Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4388A6AE7EF
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 18:08:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230520AbjCGRIL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 12:08:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230512AbjCGRHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 12:07:46 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDEA693E3B
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 09:02:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CE3C6B819A3
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 17:01:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7789CC433D2
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 17:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678208495;
        bh=yHqaje+Ge8sOaFcvWdbj0iBUfFgp9wgYhJvAoQ/UX1w=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nM1u/VULBE5pvK4J8/gUycHZyAxy98AANYI5GyjT7qVTTq4fPnxJv/vrOHy1HliRK
         RpU4JbxHrK6FTo/6pnjTgiqtEpRJWvTfZbAAuwTKUDCGcau49DMmBi8AyxWTFRhZDZ
         ZoibBm9qklTWuOhmaxVW5Ffn+cdD97Yhttv3v9eamSb4AaR6i00AngdxSuxL3/2d2h
         OctXnlY7AlIZf8zJ4/MAyVaN0eLsKq/IS5rVY06ScyOLiqHncITH0wgG6nVyzvlbn3
         8nPClhO8k0NiskMWwJwWdOJtSH17wUxgcpnJwx73WcoXqahPV24KxJieGPrxHcdF4o
         8AlLs7XWKDYTw==
Received: by mail-lj1-f175.google.com with SMTP id a32so13853925ljr.9
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 09:01:35 -0800 (PST)
X-Gm-Message-State: AO0yUKWPGZGNL18mwEyAftFfuMIObodhtgFzJ0lvQ83IRqadE04t3RY5
        0GsSVW9fWenJfRyNARIKreBWjDyI0Q15ks50TMw=
X-Google-Smtp-Source: AK7set+lzTDV2lhuYBcAizYW+6yUPGlP9zrm/d3AeapqWJFkShlGkk2zL6LsLeDiXv8LOCFGU/ucPov9r4jD9N5FQC8=
X-Received: by 2002:a2e:b988:0:b0:295:b80a:a953 with SMTP id
 p8-20020a2eb988000000b00295b80aa953mr4587809ljp.2.1678208493482; Tue, 07 Mar
 2023 09:01:33 -0800 (PST)
MIME-Version: 1.0
References: <20230307140522.2311461-1-ardb@kernel.org> <20230307140522.2311461-7-ardb@kernel.org>
 <448139c7-bef0-3ddc-388c-db793a37d55e@arm.com>
In-Reply-To: <448139c7-bef0-3ddc-388c-db793a37d55e@arm.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 7 Mar 2023 18:01:22 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHaFea17OTXT6xEN+xOsmwQMjFs=he5z8OcJNtVM=cnBw@mail.gmail.com>
Message-ID: <CAMj1kXHaFea17OTXT6xEN+xOsmwQMjFs=he5z8OcJNtVM=cnBw@mail.gmail.com>
Subject: Re: [PATCH v3 06/60] arm64: ptdump: Allow VMALLOC_END to be defined
 at boot
To:     Ryan Roberts <ryan.roberts@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Mar 2023 at 17:58, Ryan Roberts <ryan.roberts@arm.com> wrote:
>
> On 07/03/2023 14:04, Ard Biesheuvel wrote:
> > Extend the existing pattern for populating ptdump marker entries at
> > boot, and add handling of VMALLOC_END, which will cease to be a compile
> > time constant for configurations that support 52-bit virtual addressing.
> >
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > ---
> >  arch/arm64/mm/ptdump.c | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/arm64/mm/ptdump.c b/arch/arm64/mm/ptdump.c
> > index 76d28056bd14920a..910b35f02280cbdb 100644
> > --- a/arch/arm64/mm/ptdump.c
> > +++ b/arch/arm64/mm/ptdump.c
> > @@ -31,7 +31,12 @@ enum address_markers_idx {
> >       PAGE_END_NR,
> >  #if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
> >       KASAN_START_NR,
> > +     KASAN_END_NR,
> >  #endif
> > +     MODULES_NR,
> > +     MODULES_END_NR,
> > +     VMALLOC_START_NR,
> > +     VMALLOC_END_NR,
> >  };
> >
> >  static struct addr_marker address_markers[] = {
> > @@ -44,7 +49,7 @@ static struct addr_marker address_markers[] = {
> >       { MODULES_VADDR,                "Modules start" },
> >       { MODULES_END,                  "Modules end" },
> >       { VMALLOC_START,                "vmalloc() area" },
> > -     { VMALLOC_END,                  "vmalloc() end" },
> > +     { 0,                            "vmalloc() end" },
> >       { VMEMMAP_START,                "vmemmap start" },
> >       { VMEMMAP_START + VMEMMAP_SIZE, "vmemmap end" },
> >       { PCI_IO_START,                 "PCI I/O start" },
>
> With all the VA layout changes, and the addition of 52-bit PA/VA for 4KB and
> 16KB pages, Documentation/arm64/memory.rst now looks very wrong. Suggest
> updating it to reflect reality?
>

Yeah good point. And I don't think we necessarily have to describe
every imaginable combo exhaustively.
