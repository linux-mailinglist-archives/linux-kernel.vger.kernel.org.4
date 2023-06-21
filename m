Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B44C737A76
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 06:54:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbjFUEyU convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 21 Jun 2023 00:54:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjFUEyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 00:54:18 -0400
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2110E171C;
        Tue, 20 Jun 2023 21:54:17 -0700 (PDT)
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-763a3032893so240705685a.2;
        Tue, 20 Jun 2023 21:54:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687323256; x=1689915256;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y1TnxLY/k2SYoAsqYAm+lbkNiBoCiFdnAyxoiLnGFx0=;
        b=LiEYyBV0C0ddsPG/XuycofIIu9eqr1OkPXqbte+loUyomhIsbmlRncsQWTUDmDIsm8
         i2Ta14NMso2AgBDe6bqo6zXIk8SwCN73AdxB54K7VrXpJ0AhLgSTG1h2qZSlsF7YOr2S
         3Q5UEQljONqQZkdt47ZIybYA1FL8WwjF5Ld3HYswjM9NVUyeGpv2BDmG190piDNjXU1Y
         cKjIbcvGyHu0GHAo6K8v+5b5511u9eMwhH/HV0L7Ge+pxeEh14FU0IUYlPktG4wfY2Gu
         GQFRAN6jUHkJi7OaUO9gdLGB2NG6XPtbVIbwj/Y6zbxfEXAvrA7LTOO1nYRFro7zvXVh
         xB1w==
X-Gm-Message-State: AC+VfDwU/8gDXpTXwdbPpVfGr81tqGL8li+XjkZ1kq7bzrksO/LqScIr
        LT/BtkUUc+EtR3r0Jq1nJCTRIisTmuJA7XCB1Cz1BT3gF5M=
X-Google-Smtp-Source: ACHHUZ5DhIUGLzwFq+zSDS5e7IzVZs5JDEr2gT/RxErAcTo+wJW+RCeZiQiMgo659bOC3zkMI8kMSXuM+411RiSz6PY=
X-Received: by 2002:a05:620a:450d:b0:762:3d10:dc5f with SMTP id
 t13-20020a05620a450d00b007623d10dc5fmr17058907qkp.58.1687323256155; Tue, 20
 Jun 2023 21:54:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230620132025.105563-1-wangrui@loongson.cn> <CAM9d7chjhFNjDMADJTTz5TNgCCuyPzy8VCDvZxw5K5girfWu1A@mail.gmail.com>
 <CAHirt9hDc-22AKrRZEEUW9LUa3hjmnEVrYDNyWCx4kkWU4WzXA@mail.gmail.com>
In-Reply-To: <CAHirt9hDc-22AKrRZEEUW9LUa3hjmnEVrYDNyWCx4kkWU4WzXA@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 20 Jun 2023 21:54:04 -0700
Message-ID: <CAM9d7cgkV3CZ_2xAp+v62hpfutAB+RpsnvGa2u09P4C0Fm5ULw@mail.gmail.com>
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

On Tue, Jun 20, 2023 at 9:37 PM WANG Rui <wangrui@loongson.cn> wrote:
>
> Hello Namhyung,
>
> On Wed, Jun 21, 2023 at 2:42 AM Namhyung Kim <namhyung@kernel.org> wrote:
> > > +static int loongarch_call__parse(struct arch *arch, struct ins_operands *ops, struct map_symbol *ms)
> > > +{
> > > +       char *c, *endptr, *tok, *name;
> > > +       struct map *map = ms->map;
> > > +       struct addr_map_symbol target = {
> > > +               .ms = { .map = map, },
> >
> > Looking here...
> >
> > > +       };
> > > +
> > > +       c = strchr(ops->raw, '#');
> > > +       if (c++ == NULL)
> > > +               return -1;
> > > +
> > > +       ops->target.addr = strtoull(c, &endptr, 16);
> > > +
> > > +       name = strchr(endptr, '<');
> > > +       name++;
> > > +
> > > +       if (arch->objdump.skip_functions_char &&
> > > +           strchr(name, arch->objdump.skip_functions_char))
> > > +               return -1;
> > > +
> > > +       tok = strchr(name, '>');
> > > +       if (tok == NULL)
> > > +               return -1;
> > > +
> > > +       *tok = '\0';
> > > +       ops->target.name = strdup(name);
> > > +       *tok = '>';
> > > +
> > > +       if (ops->target.name == NULL)
> > > +               return -1;
> > > +
> > > +       target.addr = map__objdump_2mem(map, ops->target.addr);
> > > +
> > > +       if (maps__find_ams(ms->maps, &target) == 0 &&
> > > +           map__rip_2objdump(target.ms.map, map__map_ip(target.ms.map, target.addr)) == ops->target.addr)
> >
> > So the target.ms.map is 'map', right?  Then we can reduce the line.
>
> toos/perf/util/maps.c:
>
> > int maps__find_ams(struct maps *maps, struct addr_map_symbol *ams)
> > {
> >     if (ams->addr < map__start(ams->ms.map) || ams->addr >= map__end(ams->ms.map)) {
> >         if (maps == NULL)
> >             return -1;
> >         ams->ms.map = maps__find(maps, ams->addr);
>
> Is it possible that `target.ms.map` might be reassigned within the
> `maps_find_ams` function in this case?

Ah, ok.  Missed that part.  It can change if the target is from a
different library.

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

>
> >         if (ams->ms.map == NULL)
> >             return -1;
> >     }
> >
> >     ams->al_addr = map__map_ip(ams->ms.map, ams->addr);
> >     ams->ms.sym = map__find_symbol(ams->ms.map, ams->al_addr);
> >
> >     return ams->ms.sym ? 0 : -1;
> > }

>
