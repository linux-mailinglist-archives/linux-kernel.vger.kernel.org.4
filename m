Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2A7870EB92
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 04:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239199AbjEXCwh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 22:52:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238655AbjEXCwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 22:52:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B0E2E9;
        Tue, 23 May 2023 19:52:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A49466381E;
        Wed, 24 May 2023 02:52:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11DDBC433AA;
        Wed, 24 May 2023 02:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684896752;
        bh=wWoMXJfcsEqC8USOGU+FMTNfWB3fZsnW3ugmshgZ1Xk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=D2m7W/zHXM5Rv5UDEXZXkm9GPKwyahJiAcJNTh7lPcZGA1d4k0VDo3mmEMsrW1X0v
         M2uvcl/OoEuzD0YroPBxaRJHj8MUGnNuqjubDIwLFb6viGe8tHp3nPUBiegQYjniDh
         y2zcDYAaK9t/RtLHs5tu69b4XBkkSWYuuqzlOTFzkHcqYrDBTDq899naqYtxOFHebL
         l3w2KlqA85AZ3tPSebf+WYsyLzsrhcUkjex6eLCaxE/oSzswQnVZ5diIG43bhOzd/l
         2F64SEr+dU3QkthBEpbOwB9oK2ZtHUq2zLQh3KrTA4OqI9dELrD0E/eZiluTXhQFA4
         3MSjjR4cae9Dg==
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-96f9cfa7eddso61551266b.2;
        Tue, 23 May 2023 19:52:31 -0700 (PDT)
X-Gm-Message-State: AC+VfDw32hQBi6VVjQsPXQn03R0woc6yWm2CCKXUCo5fFHwdHq7XrUQi
        gaj/aE00uCnAjXNjs7X2+f62zQswNoHl71Iab1Y=
X-Google-Smtp-Source: ACHHUZ6J6x108CbZr4DxK0jIw8cgX+MlpLwVdnsGTEbIP0LkrHmvxtEw2W5YjRSePJK+Xk1I+XoIEUkdVKu0hFVNxPg=
X-Received: by 2002:a17:907:7d8c:b0:96f:781e:a4d5 with SMTP id
 oz12-20020a1709077d8c00b0096f781ea4d5mr15327710ejc.77.1684896750091; Tue, 23
 May 2023 19:52:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230520105718.325819-1-15330273260@189.cn> <20230520105718.325819-2-15330273260@189.cn>
 <26fd78b9-c074-8341-c99c-4e3b38cd861a@xen0n.name> <e7f911cc-6588-bc0f-8e1e-759260f5187a@189.cn>
 <ed795dc0-823a-f3d8-9e70-1cf33c0de7f0@xen0n.name> <ac2fde55-c770-fbb5-844d-50fb38dd90be@189.cn>
 <331e7baa-a83b-b0c9-37f7-0e8e39187df4@xen0n.name> <5ae49b7a-b8d2-a822-65bc-6a894d2b1b4e@189.cn>
 <0e5e4a4b-1426-ffae-e958-cf8f9aece166@xen0n.name> <69edaf49-359a-229c-c8b4-8aa3af622008@189.cn>
 <ece7821e-c4bb-f2b7-3b1d-dacc04729530@xen0n.name>
In-Reply-To: <ece7821e-c4bb-f2b7-3b1d-dacc04729530@xen0n.name>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Wed, 24 May 2023 10:52:18 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7yTDMrZiOCBs6U8+_K3pPDwk-S2boEy2aOJgTqoUGYGw@mail.gmail.com>
Message-ID: <CAAhV-H7yTDMrZiOCBs6U8+_K3pPDwk-S2boEy2aOJgTqoUGYGw@mail.gmail.com>
Subject: Re: [PATCH v14 1/2] drm: add kms driver for loongson display controller
To:     WANG Xuerui <kernel@xen0n.name>
Cc:     Sui Jingfeng <15330273260@189.cn>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Li Yi <liyi@loongson.cn>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian Koenig <christian.koenig@amd.com>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        loongson-kernel@lists.loongnix.cn,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Nathan Chancellor <nathan@kernel.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Javier Martinez Canillas <javierm@redhat.com>,
        linaro-mm-sig@lists.linaro.org, Liu Peibao <liupeibao@loongson.cn>,
        linux-media@vger.kernel.org
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

On Tue, May 23, 2023 at 4:14=E2=80=AFPM WANG Xuerui <kernel@xen0n.name> wro=
te:
>
> On 5/22/23 21:13, Sui Jingfeng wrote:
> > Hi,
> >
> > On 2023/5/22 18:25, WANG Xuerui wrote:
> >> On 2023/5/22 18:17, Sui Jingfeng wrote:
> >>> Hi,
> >>>
> >>> On 2023/5/22 18:05, WANG Xuerui wrote:
> >>>> On 2023/5/22 17:49, Sui Jingfeng wrote:
> >>>>> Hi,
> >>>>>
> >>>>> On 2023/5/22 17:28, WANG Xuerui wrote:
> >>>>>> On 2023/5/22 17:25, Sui Jingfeng wrote:
> >>>>>>> Hi,
> >>>>>>>
> >>>>>>> On 2023/5/21 20:21, WANG Xuerui wrote:
> >>>>>>>>> + * LS3A4000/LS3A5000/LS3A6000 CPU, they are equipped with
> >>>>>>>>> on-board video RAM
> >>>>>>>>> + * typically. While LS2K0500/LS2K1000/LS2K2000 are low cost
> >>>>>>>>> SoCs which share
> >>>>>>>>> + * the system RAM as video RAM, they don't has a dediacated
> >>>>>>>>> VRAM.
> >>>>>>>>
> >>>>>>>> CPU models are not typically prefixed with "LS", so "Loongson
> >>>>>>>> 3A4000/3A5000/3A6000".
> >>>>>>>>
> >>>>>>> Here is because when you do programming, variable name should
> >>>>>>> prefix with letters.
> >>>>>>
> >>>>>> Commit messages, comments, and log messages etc. are natural
> >>>>>> language, so it's better to treat them differently. No problem to
> >>>>>> keep code as-is IMO.
> >>>>>>
> >>>>> Then you get two name for a single chip,  take  LS7A1000 as an
> >>>>> example.
> >>>>>
> >>>>> You name it as Loongson 7A1000 in commit message,  and then you
> >>>>> have to define another name in the code,  say LS7A1000.
> >>>>>
> >>>>> "Loongson 7A1000" is too long,  not as compact as LS7A1000.
> >>>>>
> >>>>> This also avoid bind the company name to a specific product,
> >>>>> because a company can produce many product.
> >>>>
> >>>> Nah, the existing convention is "LS7Xxxxx" for bridges and
> >>>> "Loongson 3Axxxx" for CPUs (SoCs like 2K fall under this category
> >>>> too). It's better to stick with existing practice so it would be
> >>>> familiar to long-time Loongson/LoongArch developers, but I
> >>>> personally don't think it will hamper understanding if you feel
> >>>> like doing otherwise.
> >>>>
> >>> Can you explain why it is better?
> >>>
> >>> is it that the already existing is better ?
> >>
> >> It's not about subjective perception of "better" or "worse", but
> >> about tree-wide consistency, and about reducing any potential
> >> confusion from newcomers. I remember Huacai once pointing out that
> >> outsiders usually have a hard time remembering "1, 2, and 3 are CPUs,
> >> some 2 are SoCs, 7 are bridge chips", and consistently referring to
> >> the bridge chips throughout the tree as "LS7A" helped.
> >>
> >> In any case, for the sake of consistency, you can definitely refer to
> >> the CPU models in natural language like "LS3Axxxx"; just make sure to
> >> refactor for example every occurrence in arch/loongarch and other
> >> parts of drivers/. That's a lot of churn, though, so I don't expect
> >> such changes to get accepted, and that's why the tree-wide
> >> consistency should be favored over the local one.
> >>
> > There are document[1] which named LS7A1000 bridge chip as Loongson
> > 7A1000 Bridge,
> >
> > which is opposed to what you have said "the existing convention is
> > LS7Xxxxx for bridges".
> >
> >
> > there are also plenty projects[2] which encode ls2k1000 as project
> > name, which simply
> >
> > don't fall into the category as you have mentioned("Loongson 3Axxxx").
> >
> >
> > See [1][2] for reference, how to explain this phenomenon then?
>
> Turn down the flames a little bit, okay? ;-)
>
> What I'm describing is simply the kernel convention. Try grepping the
> commit log of linux: you can see almost all mentions of "Loongson 7A" is
> just referring to the manual which is named like that; that "LS3A" only
> ever appear as part of some board name; and that "LS2K" only briefly
> appearing when mentioned together with LS7A, maybe that's emphasis on
> the SoC's bridge part. "Loongson [123]" and "LS7A" are clearly the
> majority there.
>
> But, as the convention was established by Huacai and I'm only
> reiterating his rules, you may instead just check with him and not
> continue the boring debate with me. Meanwhile maybe keeping all "LS3A"
> and/or "LS2K" is kind of acceptable, given such naming is etched right
> on the chip's packaging; I'd follow whatever Huacai mandates.
Yes, I can confirm that.

For CPU: we always use the full name, "Loongson-3A".
For Bridge: we only use the full name when referring to the manuals,
otherwise use the abbrev. name "LS7A".
For SoC: depending on scenarios, in architectural code we usually use
the full name "Loongson-2K", and in drivers it is allowed to call
"LS2K" to keep consistency, especially in DTS.

Huacai
>
> --
> WANG "xen0n" Xuerui
>
> Linux/LoongArch mailing list: https://lore.kernel.org/loongarch/
>
