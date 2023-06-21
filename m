Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C2DE737A28
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 06:35:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbjFUEfh convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 21 Jun 2023 00:35:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjFUEfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 00:35:34 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C845B171C
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 21:35:31 -0700 (PDT)
Received: from loongson.cn (unknown [209.85.208.41])
        by gateway (Coremail) with SMTP id _____8BxlfAPfpJkOQAAAA--.9S3;
        Wed, 21 Jun 2023 12:35:28 +0800 (CST)
Received: from mail-ed1-f41.google.com (unknown [209.85.208.41])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxDc_GeZJk_wAAAA--.26S3;
        Wed, 21 Jun 2023 12:17:12 +0800 (CST)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-51bdc87feb1so193150a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 21:17:12 -0700 (PDT)
X-Gm-Message-State: AC+VfDxKMfQoid6VknL4EbSMTSVJZGF+HGbS7tox77mbz8o73rvkDCOV
        jpYlWrA1gdAOtdLb2JzsUXpyCGG0emcJ1tpc9GB2lQ==
X-Google-Smtp-Source: ACHHUZ4NbyRZWvmfN8G6zN4spULubzWBpkQQU1JsvmeAsqFQhaJ3lcgXL/QS2HBeY7kvekKVIU/OcmeCEJbFA6zurcA=
X-Received: by 2002:adf:f08b:0:b0:311:1ce2:ee1b with SMTP id
 n11-20020adff08b000000b003111ce2ee1bmr10295436wro.66.1687320634966; Tue, 20
 Jun 2023 21:10:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230620132025.105563-1-wangrui@loongson.cn> <CAM9d7chjhFNjDMADJTTz5TNgCCuyPzy8VCDvZxw5K5girfWu1A@mail.gmail.com>
In-Reply-To: <CAM9d7chjhFNjDMADJTTz5TNgCCuyPzy8VCDvZxw5K5girfWu1A@mail.gmail.com>
From:   WANG Rui <wangrui@loongson.cn>
Date:   Wed, 21 Jun 2023 12:10:24 +0800
X-Gmail-Original-Message-ID: <CAHirt9hDc-22AKrRZEEUW9LUa3hjmnEVrYDNyWCx4kkWU4WzXA@mail.gmail.com>
Message-ID: <CAHirt9hDc-22AKrRZEEUW9LUa3hjmnEVrYDNyWCx4kkWU4WzXA@mail.gmail.com>
Subject: Re: [PATCH] perf annotate: Fix instruction association and parsing
 for LoongArch
To:     Namhyung Kim <namhyung@kernel.org>
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
X-CM-TRANSID: AQAAf8DxDc_GeZJk_wAAAA--.26S3
X-CM-SenderInfo: pzdqw2txl6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7WryxAw4rXr4fAr4DWrWDWrX_yoW8Cr1Dpa
        4Iy3WxWr4xtry8CwsrJay8Z3ZxCw13WrW3A3s7tas8CFn8uF4fGa45KFyaka45Ar17Wr40
        vF4DZryFkrnrtFgCm3ZEXasCq-sJn29KB7ZKAUJUUUU3529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUU9Cb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
        Jr0_Gr1ln4kS14v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2
        x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15
        McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7
        CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l
        4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxV
        WUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAF
        wI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcI
        k0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j
        6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UM7KsUUUUU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Namhyung,

On Wed, Jun 21, 2023 at 2:42 AM Namhyung Kim <namhyung@kernel.org> wrote:
> > +static int loongarch_call__parse(struct arch *arch, struct ins_operands *ops, struct map_symbol *ms)
> > +{
> > +       char *c, *endptr, *tok, *name;
> > +       struct map *map = ms->map;
> > +       struct addr_map_symbol target = {
> > +               .ms = { .map = map, },
>
> Looking here...
>
> > +       };
> > +
> > +       c = strchr(ops->raw, '#');
> > +       if (c++ == NULL)
> > +               return -1;
> > +
> > +       ops->target.addr = strtoull(c, &endptr, 16);
> > +
> > +       name = strchr(endptr, '<');
> > +       name++;
> > +
> > +       if (arch->objdump.skip_functions_char &&
> > +           strchr(name, arch->objdump.skip_functions_char))
> > +               return -1;
> > +
> > +       tok = strchr(name, '>');
> > +       if (tok == NULL)
> > +               return -1;
> > +
> > +       *tok = '\0';
> > +       ops->target.name = strdup(name);
> > +       *tok = '>';
> > +
> > +       if (ops->target.name == NULL)
> > +               return -1;
> > +
> > +       target.addr = map__objdump_2mem(map, ops->target.addr);
> > +
> > +       if (maps__find_ams(ms->maps, &target) == 0 &&
> > +           map__rip_2objdump(target.ms.map, map__map_ip(target.ms.map, target.addr)) == ops->target.addr)
>
> So the target.ms.map is 'map', right?  Then we can reduce the line.

toos/perf/util/maps.c:

> int maps__find_ams(struct maps *maps, struct addr_map_symbol *ams)
> {
>     if (ams->addr < map__start(ams->ms.map) || ams->addr >= map__end(ams->ms.map)) {
>         if (maps == NULL)
>             return -1;
>         ams->ms.map = maps__find(maps, ams->addr);

Is it possible that `target.ms.map` might be reassigned within the
`maps_find_ams` function in this case?

>         if (ams->ms.map == NULL)
>             return -1;
>     }
>
>     ams->al_addr = map__map_ip(ams->ms.map, ams->addr);
>     ams->ms.sym = map__find_symbol(ams->ms.map, ams->al_addr);
>
>     return ams->ms.sym ? 0 : -1;
> }

Thanks!

-- 
WANG Rui
Loongson Technology Corporation Limited

