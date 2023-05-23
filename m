Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 508E570DA74
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 12:27:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236571AbjEWK05 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 06:26:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbjEWK04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 06:26:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7790FE;
        Tue, 23 May 2023 03:26:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7CFA0630D0;
        Tue, 23 May 2023 10:26:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3193C433A4;
        Tue, 23 May 2023 10:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684837613;
        bh=0vlCDn5GYXan9qivPDneQ2nYL3hkWFznEm195urAu+4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=q/nNk8Zlf7v9fHI6+tL4MQADuV0OJXDkiBSDRZ/yyPbxZPtdKvzjBuVW5SB5Zs7pV
         rBCpiiJ+PlK8q26rSP4InoJjgEB9SMROwUc84eqeRk9umUs9eAEkDd7U72LQhRifFs
         BuHN3V+mOBBrcVCDsKa9yfb2p0/4M+FI7etoyz6p5m77EA5KaL9NjeI/d+XonOsu1M
         DUXSZ6Bx2PxSFxRhqLkAFTPiiG1DyDnBc2GrhT+p4ygAp3VwMydxyzgn4a2SfNwLe6
         4KpeinGI7YQT4zv1vr9qWesb5wPBKyJkl4VKRWyIUxxXYuy/5h5I7RLiVdvvKAaPZe
         YXJrOF8RZbVEA==
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-510d6e1f1abso1333945a12.2;
        Tue, 23 May 2023 03:26:53 -0700 (PDT)
X-Gm-Message-State: AC+VfDxjB+6e5pSgO9wI0QRbIFbYYCGG5ORRo4XKRe2QvW37d8lsuhWS
        2RlyuwQeMa7dtPuv1+ZDbzZdHkuySNQlxnyQgrI=
X-Google-Smtp-Source: ACHHUZ7SrLdSYlyQXm8aeoe997GjeZoDbRoWBUEFfNUyjO6cHSN7A6U0G4UA/HJaXi1FQwlLAqQWqocH0I6LJu9t3b4=
X-Received: by 2002:a17:907:9494:b0:96a:30b5:cfb0 with SMTP id
 dm20-20020a170907949400b0096a30b5cfb0mr12353417ejc.22.1684837612089; Tue, 23
 May 2023 03:26:52 -0700 (PDT)
MIME-Version: 1.0
References: <1684835873-15956-1-git-send-email-yangtiezhu@loongson.cn>
In-Reply-To: <1684835873-15956-1-git-send-email-yangtiezhu@loongson.cn>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Tue, 23 May 2023 18:26:39 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4Es7qs54zr_hNPwn5MfgeLiKr3sgoTUP5iNj3JrH-1Uw@mail.gmail.com>
Message-ID: <CAAhV-H4Es7qs54zr_hNPwn5MfgeLiKr3sgoTUP5iNj3JrH-1Uw@mail.gmail.com>
Subject: Re: [PATCH v2] perf symbol: Add LoongArch case in get_plt_sizes()
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Leo Yan <leo.yan@linaro.org>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
        loongson-kernel@lists.loongnix.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Acked-by: Huacai Chen <chenhuacai@loongson.cn>

On Tue, May 23, 2023 at 5:57=E2=80=AFPM Tiezhu Yang <yangtiezhu@loongson.cn=
> wrote:
>
> We can see the following definitions in bfd/elfnn-loongarch.c:
>
>   #define PLT_HEADER_INSNS 8
>   #define PLT_HEADER_SIZE (PLT_HEADER_INSNS * 4)
>
>   #define PLT_ENTRY_INSNS 4
>   #define PLT_ENTRY_SIZE (PLT_ENTRY_INSNS * 4)
>
> so plt header size is 32 and plt entry size is 16 on LoongArch,
> let us add LoongArch case in get_plt_sizes().
>
> Link: https://sourceware.org/git/?p=3Dbinutils-gdb.git;a=3Dblob;f=3Dbfd/e=
lfnn-loongarch.c
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>
> v2: Add EM_LOONGARCH definition to avoid build error
>
>  tools/perf/util/symbol-elf.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
> index b2ed9cc..b3dbf6c 100644
> --- a/tools/perf/util/symbol-elf.c
> +++ b/tools/perf/util/symbol-elf.c
> @@ -35,6 +35,10 @@
>  #define EM_AARCH64     183  /* ARM 64 bit */
>  #endif
>
> +#ifndef EM_LOONGARCH
> +#define EM_LOONGARCH   258
> +#endif
> +
>  #ifndef ELF32_ST_VISIBILITY
>  #define ELF32_ST_VISIBILITY(o) ((o) & 0x03)
>  #endif
> @@ -411,6 +415,10 @@ static bool get_plt_sizes(struct dso *dso, GElf_Ehdr=
 *ehdr, GElf_Shdr *shdr_plt,
>                 *plt_header_size =3D 32;
>                 *plt_entry_size =3D 16;
>                 return true;
> +       case EM_LOONGARCH:
> +               *plt_header_size =3D 32;
> +               *plt_entry_size =3D 16;
> +               return true;
>         case EM_SPARC:
>                 *plt_header_size =3D 48;
>                 *plt_entry_size =3D 12;
> --
> 2.1.0
>
>
