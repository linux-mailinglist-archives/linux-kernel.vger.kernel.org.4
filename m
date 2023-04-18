Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A9406E563F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 03:15:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbjDRBPJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 21:15:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbjDRBPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 21:15:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C40A83C0D;
        Mon, 17 Apr 2023 18:15:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EAC9E6182F;
        Tue, 18 Apr 2023 01:15:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FBAAC433A7;
        Tue, 18 Apr 2023 01:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681780505;
        bh=jsS1F46hAQbhHVpD+vXSY2C2u6Z+ww/kmcB8nSA4RKg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ManG2OfNtk/zGAtRVUTd1eGyebp0k9xtlGagHt9sOeG/HWiCDHWd28EPCXQb2dezj
         GldNZndaDjzYwt/1u5nPVrKt0qc1ZM7/76yzJYzWOcHfhq5kYwNt9webhWCzDT6Pjp
         4j4ZrIwaB4cCeaCmA7I/rPy4ObCLcDKbmFM+5CaVi8CjJm90Fi24gHVft5vb3ddy27
         igvJZfYVxw+HatzH7KVV8kK0dMf8yWhtHMxdY76uJqpv67HR63uYvfWU8q0TirYFbw
         LyCjV05r+NZmNFlcIlMJathLXomrf8S6lhklYMsy02NwZJIryFntYba8okwDI3hshh
         +90IzBVz4R4kA==
Received: by mail-ej1-f46.google.com with SMTP id a5so12504296ejb.6;
        Mon, 17 Apr 2023 18:15:05 -0700 (PDT)
X-Gm-Message-State: AAQBX9dfnWMGB9xAndXLEGsFA/tfGo4DmcppWbly+QZpK9P6L9C8csAu
        9RYW4356S00uNld//tVugRP38b3tpBg3JsDT+94=
X-Google-Smtp-Source: AKy350Yv7c0ey003enetxa4tjEVr2HZE1ag9Xgcg8Xk15eWDUpN2lh4W6w3Ix+T1adES7c0pru0HDx6KP6MW1F8YPdk=
X-Received: by 2002:a17:906:5e12:b0:92d:878e:8566 with SMTP id
 n18-20020a1709065e1200b0092d878e8566mr4631793eju.10.1681780503472; Mon, 17
 Apr 2023 18:15:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230410111823.2538831-1-chenhuacai@loongson.cn>
 <0a278ab5-751a-9433-3d1f-19a5a6b99d39@loongson.cn> <CAAhV-H5sxLDS7+MOaC_Y+gd-=Qrog7gzidKDkYa=DWC2Ci_5_Q@mail.gmail.com>
 <d50d7779-3bff-1a83-2641-36abdb077ac1@loongson.cn> <b1cdd754-fa38-4b2e-0a93-b13d9cfd7a8a@loongson.cn>
In-Reply-To: <b1cdd754-fa38-4b2e-0a93-b13d9cfd7a8a@loongson.cn>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Tue, 18 Apr 2023 09:14:51 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5EMaobTNrCX5FthD6zPLwZB6c46M0Y=kTqEUetRpwo3w@mail.gmail.com>
Message-ID: <CAAhV-H5EMaobTNrCX5FthD6zPLwZB6c46M0Y=kTqEUetRpwo3w@mail.gmail.com>
Subject: Re: [PATCH V2] tools/perf: Add basic support for LoongArch
To:     Youling Tang <tangyouling@loongson.cn>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, loongarch@lists.linux.dev,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Xuerui Wang <kernel@xen0n.name>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        loongson-kernel@lists.loongnix.cn,
        Ming Wang <wangming01@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 17, 2023 at 5:22=E2=80=AFPM Youling Tang <tangyouling@loongson.=
cn> wrote:
>
> /* snip */
>
> >>>> --- /dev/null
> >>>> +++ b/tools/perf/arch/loongarch/util/dwarf-regs.c
> >>>> @@ -0,0 +1,44 @@
> >>>> +// SPDX-License-Identifier: GPL-2.0
> >>>> +/*
> >>>> + * dwarf-regs.c : Mapping of DWARF debug register numbers into
> >>>> register names.
> >>>> + *
> >>>> + * Copyright (C) 2020-2023 Loongson Technology Corporation Limited
> >>>> + */
> >>>> +
> >>>> +#include <stdio.h>
> >>>> +#include <errno.h> /* for EINVAL */
> >>>> +#include <string.h> /* for strcmp */
> >>>> +#include <dwarf-regs.h>
> >>>> +
> >>>> +struct pt_regs_dwarfnum {
> >>>> +     const char *name;
> >>>> +     unsigned int dwarfnum;
> >>>> +};
> >>>> +
> >>>> +static struct pt_regs_dwarfnum loongarch_gpr_table[] =3D {
> >>>> +     {"$0", 0}, {"$1", 1}, {"$2", 2}, {"$3", 3},
> >>>> +     {"$4", 4}, {"$5", 5}, {"$6", 6}, {"$7", 7},
> >>>> +     {"$8", 8}, {"$9", 9}, {"$10", 10}, {"$11", 11},
> >>>> +     {"$12", 12}, {"$13", 13}, {"$14", 14}, {"$15", 15},
> >>>> +     {"$16", 16}, {"$17", 17}, {"$18", 18}, {"$19", 19},
> >>>> +     {"$20", 20}, {"$21", 21}, {"$22", 22}, {"$23", 23},
> >>>> +     {"$24", 24}, {"$25", 25}, {"$26", 26}, {"$27", 27},
> >>>> +     {"$28", 28}, {"$29", 29}, {"$30", 30}, {"$31", 31},
> >>>> +     {NULL, 0}
> >>>> +};
> >>> Do you need to change it to the following:
> >>>
> >>> #define GPR_DWARFNUM_NAME(num) {.name =3D __stringify($r##num), .dwar=
fnum
> >>> =3D num}
> >>> #define REG_DWARFNUM_END {.name =3D NULL, .dwarfnum =3D 0}
> >>>
> >>> static const struct pt_regs_dwarfnum regdwarfnum_table[] =3D {
> >>>          GPR_DWARFNUM_NAME(0),
> >>>          GPR_DWARFNUM_NAME(1),
> >>>          GPR_DWARFNUM_NAME(2),
> >>>          GPR_DWARFNUM_NAME(3),
> >>>          GPR_DWARFNUM_NAME(4),
> >>>          GPR_DWARFNUM_NAME(5),
> >>>          GPR_DWARFNUM_NAME(6),
> >>>          GPR_DWARFNUM_NAME(7),
> >>>          GPR_DWARFNUM_NAME(8),
> >>>          GPR_DWARFNUM_NAME(9),
> >>>          GPR_DWARFNUM_NAME(10),
> >>>          GPR_DWARFNUM_NAME(11),
> >>>          GPR_DWARFNUM_NAME(12),
> >>>          GPR_DWARFNUM_NAME(13),
> >>>          GPR_DWARFNUM_NAME(14),
> >>>          GPR_DWARFNUM_NAME(15),
> >>>          GPR_DWARFNUM_NAME(16),
> >>>          GPR_DWARFNUM_NAME(17),
> >>>          GPR_DWARFNUM_NAME(18),
> >>>          GPR_DWARFNUM_NAME(19),
> >>>          GPR_DWARFNUM_NAME(20),
> >>>          GPR_DWARFNUM_NAME(21),
> >>>          GPR_DWARFNUM_NAME(22),
> >>>          GPR_DWARFNUM_NAME(23),
> >>>          GPR_DWARFNUM_NAME(24),
> >>>          GPR_DWARFNUM_NAME(25),
> >>>          GPR_DWARFNUM_NAME(26),
> >>>          GPR_DWARFNUM_NAME(27),
> >>>          GPR_DWARFNUM_NAME(28),
> >>>          GPR_DWARFNUM_NAME(29),
> >>>          REG_DWARFNUM_NAME(30),
> >>>          REG_DWARFNUM_NAME(31),
> >>>          REG_DWARFNUM_END,
> >>> };
> >>>
> >>> At the same time, "$rx" is used in __perf_reg_name_loongarch and
> >>> loongarch_regstr_tbl, which is consistent with assembly.
> >> OK, I will use the "$rx" format, but I don't want to use macros.
> > Use the "rx" format to make regs_query_register_offset consistent with
> > arch/loongarch/kernel/ptrace.c (that is, the names in
> > loongarch_gpr_table and regoffset_table are consistent)
>
> If we want to be consistent with the usage of `trace probe`, we should
> use "%rx".
OK, make sense.

Huacai
>
> eg:
>     # echo "p:myuprobe /tmp/test:0x4194 %r4 %r5" > uprobe_events
>
> parse_probe_arg()
>           case '%': regs_query_register_offset()
>
> Youling.
> >
> > Youling.
> >>
> >> Huacai
> >>>
> >>>> +
> >>>> +const char *get_arch_regstr(unsigned int n)
> >>>> +{
> >>>> +     n %=3D 32;
> >>>> +     return loongarch_gpr_table[n].name;
> >>>> +}
> >>>> +
> >>>> +int regs_query_register_offset(const char *name)
> >>>> +{
> >>>> +     const struct pt_regs_dwarfnum *roff;
> >>>> +
> >>>> +     for (roff =3D loongarch_gpr_table; roff->name !=3D NULL; roff+=
+)
> >>>> +             if (!strcmp(roff->name, name))
> >>>> +                     return roff->dwarfnum;
> >>>> +     return -EINVAL;
> >>>> +}
> >
>
>
