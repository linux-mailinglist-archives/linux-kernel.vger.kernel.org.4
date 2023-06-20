Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5502D73747C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 20:42:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbjFTSmm convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 20 Jun 2023 14:42:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbjFTSmk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 14:42:40 -0400
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31986DC;
        Tue, 20 Jun 2023 11:42:39 -0700 (PDT)
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-77e457319a6so72913239f.1;
        Tue, 20 Jun 2023 11:42:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687286558; x=1689878558;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sCtMr8ijFx2CrFh9ZGovTyfqeQbUmmEvN/2Rn9Z2qpQ=;
        b=Is5zqw8te+z6zLolRfjtZeG56es4WN4izEWadogetXeF0tVUgOeDJpF35BxPDifggy
         Yyc5Myj3wZ6UGsGeZEI/WT2Zq1EN1HkK5FiiGV8qw/TKeS7Hzhe8eARs9qpjIcsh8jEc
         MNh30GO2KlTI6C/b21SzJT+I9XNyfvf2/doXtHEHxXitBfgB0NvhiMWLE6plE8Xf+9t6
         BBnvTXDFWSiXHvx3cGI8TyIFTPghir3GuUnsL1kJUSjjrS1TJPUie5fOW4uvkDsr4ByV
         rKonPPR05RYQ3QSL8mxxHVGBOQK63VjWNoKUQrTcjKAOx7/3vn1j9KsDH/Dct28GlArq
         Hi5g==
X-Gm-Message-State: AC+VfDzZ2tvwjZWPKh2+qNAK56NjqvUBfJUDtT9BtxTOogKeKgd/eikc
        NNjrAirxxKeLhH8zB+PkAyjC+mvQDVK1uiD9yJrt9oei
X-Google-Smtp-Source: ACHHUZ5UypJ0++pBV6Hqw8rqiWPP/lwWp2zQMiRMqtjM8mucthRU+AAM+/bTiYec3dtoQpaSXydIJ2YfK6X/YRv3cxA=
X-Received: by 2002:a6b:fd07:0:b0:777:ce47:6c5a with SMTP id
 c7-20020a6bfd07000000b00777ce476c5amr9165132ioi.21.1687286557979; Tue, 20 Jun
 2023 11:42:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230620132025.105563-1-wangrui@loongson.cn>
In-Reply-To: <20230620132025.105563-1-wangrui@loongson.cn>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 20 Jun 2023 11:42:26 -0700
Message-ID: <CAM9d7chjhFNjDMADJTTz5TNgCCuyPzy8VCDvZxw5K5girfWu1A@mail.gmail.com>
Subject: Re: [PATCH] perf annotate: Fix instruction association and parsing
 for LoongArch
To:     WANG Rui <wangrui@loongson.cn>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Huacai Chen <chenhuacai@loongson.cn>,
        loongarch@lists.linux.dev, Tiezhu Yang <yangtiezhu@loongson.cn>,
        WANG Xuerui <kernel@xen0n.name>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, loongson-kernel@lists.loongnix.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, Jun 20, 2023 at 6:21 AM WANG Rui <wangrui@loongson.cn> wrote:
>
> In the perf annotate view for LoongArch, there is no arrowed line
> pointing to the target from the branch instruction. This issue is
> caused by incorrect instruction association and parsing.
>
> $ perf record alloc-6276705c94ad1398 # rust benchmark
> $ perf report
>
>   0.28 │       ori        $a1, $zero, 0x63
>        │       move       $a2, $zero
>  10.55 │       addi.d     $a3, $a2, 1(0x1)
>        │       sltu       $a4, $a3, $s7
>   9.53 │       masknez    $a4, $s7, $a4
>        │       sub.d      $a3, $a3, $a4
>  12.12 │       st.d       $a1, $fp, 24(0x18)
>        │       st.d       $a3, $fp, 16(0x10)
>  16.29 │       slli.d     $a2, $a2, 0x2
>        │       ldx.w      $a2, $s8, $a2
>  12.77 │       st.w       $a2, $sp, 724(0x2d4)
>        │       st.w       $s0, $sp, 720(0x2d0)
>   7.03 │       addi.d     $a2, $sp, 720(0x2d0)
>        │       addi.d     $a1, $a1, -1(0xfff)
>  12.03 │       move       $a2, $a3
>        │     → bne        $a1, $s3, -52(0x3ffcc)  # 82ce8 <test::bench::Bencher::iter+0x3f4>
>   2.50 │       addi.d     $a0, $a0, 1(0x1)
>
> This patch fixes instruction association issues, such as associating
> branch instructions with jump_ops instead of call_ops, and corrects
> false instruction matches. It also implements branch instruction parsing
> specifically for LoongArch. With this patch, we will be able to see the
> arrowed line.
>
>   0.79 │3ec:   ori        $a1, $zero, 0x63
>        │       move       $a2, $zero
>  10.32 │3f4:┌─→addi.d     $a3, $a2, 1(0x1)
>        │    │  sltu       $a4, $a3, $s7
>  10.44 │    │  masknez    $a4, $s7, $a4
>        │    │  sub.d      $a3, $a3, $a4
>  14.17 │    │  st.d       $a1, $fp, 24(0x18)
>        │    │  st.d       $a3, $fp, 16(0x10)
>  13.15 │    │  slli.d     $a2, $a2, 0x2
>        │    │  ldx.w      $a2, $s8, $a2
>  11.00 │    │  st.w       $a2, $sp, 724(0x2d4)
>        │    │  st.w       $s0, $sp, 720(0x2d0)
>   8.00 │    │  addi.d     $a2, $sp, 720(0x2d0)
>        │    │  addi.d     $a1, $a1, -1(0xfff)
>  11.99 │    │  move       $a2, $a3
>        │    └──bne        $a1, $s3, 3f4
>   3.17 │       addi.d     $a0, $a0, 1(0x1)
>
> Signed-off-by: WANG Rui <wangrui@loongson.cn>

Just a nitpick.  Otherwise looks good.

> ---
>  .../arch/loongarch/annotate/instructions.c    | 116 ++++++++++++++++--
>  tools/perf/arch/s390/annotate/instructions.c  |   3 -
>  tools/perf/util/annotate.c                    |   8 +-
>  3 files changed, 109 insertions(+), 18 deletions(-)
>
> diff --git a/tools/perf/arch/loongarch/annotate/instructions.c b/tools/perf/arch/loongarch/annotate/instructions.c
> index ab21bf122135..98e19c5366ac 100644
> --- a/tools/perf/arch/loongarch/annotate/instructions.c
> +++ b/tools/perf/arch/loongarch/annotate/instructions.c
> @@ -5,25 +5,115 @@
>   * Copyright (C) 2020-2023 Loongson Technology Corporation Limited
>   */
>
> +static int loongarch_call__parse(struct arch *arch, struct ins_operands *ops, struct map_symbol *ms)
> +{
> +       char *c, *endptr, *tok, *name;
> +       struct map *map = ms->map;
> +       struct addr_map_symbol target = {
> +               .ms = { .map = map, },

Looking here...

> +       };
> +
> +       c = strchr(ops->raw, '#');
> +       if (c++ == NULL)
> +               return -1;
> +
> +       ops->target.addr = strtoull(c, &endptr, 16);
> +
> +       name = strchr(endptr, '<');
> +       name++;
> +
> +       if (arch->objdump.skip_functions_char &&
> +           strchr(name, arch->objdump.skip_functions_char))
> +               return -1;
> +
> +       tok = strchr(name, '>');
> +       if (tok == NULL)
> +               return -1;
> +
> +       *tok = '\0';
> +       ops->target.name = strdup(name);
> +       *tok = '>';
> +
> +       if (ops->target.name == NULL)
> +               return -1;
> +
> +       target.addr = map__objdump_2mem(map, ops->target.addr);
> +
> +       if (maps__find_ams(ms->maps, &target) == 0 &&
> +           map__rip_2objdump(target.ms.map, map__map_ip(target.ms.map, target.addr)) == ops->target.addr)

So the target.ms.map is 'map', right?  Then we can reduce the line.


> +               ops->target.sym = target.ms.sym;
> +
> +       return 0;
> +}
> +
> +static struct ins_ops loongarch_call_ops = {
> +       .parse     = loongarch_call__parse,
> +       .scnprintf = call__scnprintf,
> +};
> +
> +static int loongarch_jump__parse(struct arch *arch, struct ins_operands *ops, struct map_symbol *ms)
> +{
> +       struct map *map = ms->map;
> +       struct symbol *sym = ms->sym;
> +       struct addr_map_symbol target = {
> +               .ms = { .map = map, },
> +       };
> +       const char *c = strchr(ops->raw, '#');
> +       u64 start, end;
> +
> +       ops->raw_comment = strchr(ops->raw, arch->objdump.comment_char);
> +       ops->raw_func_start = strchr(ops->raw, '<');
> +
> +       if (ops->raw_func_start && c > ops->raw_func_start)
> +               c = NULL;
> +
> +       if (c++ != NULL)
> +               ops->target.addr = strtoull(c, NULL, 16);
> +       else
> +               ops->target.addr = strtoull(ops->raw, NULL, 16);
> +
> +       target.addr = map__objdump_2mem(map, ops->target.addr);
> +       start = map__unmap_ip(map, sym->start);
> +       end = map__unmap_ip(map, sym->end);
> +
> +       ops->target.outside = target.addr < start || target.addr > end;
> +
> +       if (maps__find_ams(ms->maps, &target) == 0 &&
> +           map__rip_2objdump(target.ms.map, map__map_ip(target.ms.map, target.addr)) == ops->target.addr)

Ditto.

Thanks,
Namhyung


> +               ops->target.sym = target.ms.sym;
> +
> +       if (!ops->target.outside) {
> +               ops->target.offset = target.addr - start;
> +               ops->target.offset_avail = true;
> +       } else {
> +               ops->target.offset_avail = false;
> +       }
> +
> +       return 0;
> +}
> +
> +static struct ins_ops loongarch_jump_ops = {
> +       .parse     = loongarch_jump__parse,
> +       .scnprintf = jump__scnprintf,
> +};
> +
>  static
>  struct ins_ops *loongarch__associate_ins_ops(struct arch *arch, const char *name)
>  {
>         struct ins_ops *ops = NULL;
>
> -       if (!strncmp(name, "beqz", 4) ||
> -           !strncmp(name, "bnez", 4) ||
> -           !strncmp(name, "beq", 3) ||
> -           !strncmp(name, "bne", 3) ||
> -           !strncmp(name, "blt", 3) ||
> -           !strncmp(name, "bge", 3) ||
> -           !strncmp(name, "bltu", 4) ||
> -           !strncmp(name, "bgeu", 4) ||
> -           !strncmp(name, "bl", 2))
> -               ops = &call_ops;
> -       else if (!strncmp(name, "jirl", 4))
> +       if (!strcmp(name, "bl"))
> +               ops = &loongarch_call_ops;
> +       else if (!strcmp(name, "jirl"))
>                 ops = &ret_ops;
> -       else if (name[0] == 'b')
> -               ops = &jump_ops;
> +       else if (!strcmp(name, "b") ||
> +                !strncmp(name, "beq", 3) ||
> +                !strncmp(name, "bne", 3) ||
> +                !strncmp(name, "blt", 3) ||
> +                !strncmp(name, "bge", 3) ||
> +                !strncmp(name, "bltu", 4) ||
> +                !strncmp(name, "bgeu", 4))
> +               ops = &loongarch_jump_ops;
>         else
>                 return NULL;
>
> diff --git a/tools/perf/arch/s390/annotate/instructions.c b/tools/perf/arch/s390/annotate/instructions.c
> index de925b0e35ce..da5aa3e1f04c 100644
> --- a/tools/perf/arch/s390/annotate/instructions.c
> +++ b/tools/perf/arch/s390/annotate/instructions.c
> @@ -45,9 +45,6 @@ static int s390_call__parse(struct arch *arch, struct ins_operands *ops,
>         return 0;
>  }
>
> -static int call__scnprintf(struct ins *ins, char *bf, size_t size,
> -                          struct ins_operands *ops, int max_ins_name);
> -
>  static struct ins_ops s390_call_ops = {
>         .parse     = s390_call__parse,
>         .scnprintf = call__scnprintf,
> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> index cdd1924a4418..ad40adbd8895 100644
> --- a/tools/perf/util/annotate.c
> +++ b/tools/perf/util/annotate.c
> @@ -61,6 +61,10 @@ static regex_t        file_lineno;
>  static struct ins_ops *ins__find(struct arch *arch, const char *name);
>  static void ins__sort(struct arch *arch);
>  static int disasm_line__parse(char *line, const char **namep, char **rawp);
> +static int call__scnprintf(struct ins *ins, char *bf, size_t size,
> +                         struct ins_operands *ops, int max_ins_name);
> +static int jump__scnprintf(struct ins *ins, char *bf, size_t size,
> +                         struct ins_operands *ops, int max_ins_name);
>
>  struct arch {
>         const char      *name;
> @@ -323,7 +327,7 @@ static struct ins_ops call_ops = {
>
>  bool ins__is_call(const struct ins *ins)
>  {
> -       return ins->ops == &call_ops || ins->ops == &s390_call_ops;
> +       return ins->ops == &call_ops || ins->ops == &s390_call_ops || ins->ops == &loongarch_call_ops;
>  }
>
>  /*
> @@ -464,7 +468,7 @@ static struct ins_ops jump_ops = {
>
>  bool ins__is_jump(const struct ins *ins)
>  {
> -       return ins->ops == &jump_ops;
> +       return ins->ops == &jump_ops || ins->ops == &loongarch_jump_ops;
>  }
>
>  static int comment__symbol(char *raw, char *comment, u64 *addrp, char **namep)
> --
> 2.41.0
>
