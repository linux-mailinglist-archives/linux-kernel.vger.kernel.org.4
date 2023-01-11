Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F26796660FC
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 17:52:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234899AbjAKQv6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 11:51:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234299AbjAKQv4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 11:51:56 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F3A2BC19
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 08:51:55 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id c4-20020a1c3504000000b003d9e2f72093so10023859wma.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 08:51:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LHmBMWU2SWNtjXec6rBQlMkwK624/CHswkgmYXv2n0Y=;
        b=KAWAZcxBA/g537PW2pgy9HHAnsvYTQXGWZXB0mJQ4BwngCM142dMInth0PW7wti3TK
         3EW4rQbKx7wac4KzbfEaKxskWRdxek7SJ64NdG0ZarL+h2pwmVsyzUSHU5dtK/UtCHo+
         HmbJx7zW490VEqBUGE2ibZmrjTk38rz4A+mJ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LHmBMWU2SWNtjXec6rBQlMkwK624/CHswkgmYXv2n0Y=;
        b=QX/wPWOlEn00H0tDia1IIQyu/DY5iLrd4EfrTNdwHdspPEkBY/pZPmln+/tlbYFEJh
         61zmMbP1X2tOgNicZq4T3ybezu3nWIhrIkYjTmm5IlNk8FvccyjgIjzR5aVGPuT8IPfZ
         q/qqRLDlgL4KbedWiWKeWdv2M9F77qtMq8R9LRd+rKeRBUNQgEpdNKx09pljoAg1MsKb
         De2VJCHcD4uogIdbSAeo7oCni0sYT9qKXGTVQToaAMmTL/5AiMGXtSuPii9T5vxxkcUF
         L2/2ihRND2lH5K/fqS91VjTxeaQ31mTPEAaJehgPdogIyibBo95u0poaFRbvBMkBeP71
         YprQ==
X-Gm-Message-State: AFqh2kpf/V8lVtjWJ5p7Vdd/KEzISYO3GGTEeKGCwqR+NzgcoXu7cWfz
        tLh4PlPMX5IMeavOnvGtDTmAPw==
X-Google-Smtp-Source: AMrXdXsouhyLK5NqfGbiLX93aqJApozE4UxLS+XTULWdoBQPgskRAiuklAhwFNgIMvCyPHRelTozlw==
X-Received: by 2002:a05:600c:3b23:b0:3da:f37:1253 with SMTP id m35-20020a05600c3b2300b003da0f371253mr1312019wms.8.1673455914044;
        Wed, 11 Jan 2023 08:51:54 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id r10-20020a05600c458a00b003d35acb0fd7sm25299500wmo.34.2023.01.11.08.51.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 08:51:53 -0800 (PST)
Date:   Wed, 11 Jan 2023 17:51:51 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Helge Deller <deller@gmx.de>, linux-fbdev@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 04/11] video/aperture: use generic code to figure out the
 vga default device
Message-ID: <Y77pJ/+V2qHeqOjW@phenom.ffwll.local>
Mail-Followup-To: Thomas Zimmermann <tzimmermann@suse.de>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Helge Deller <deller@gmx.de>, linux-fbdev@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
References: <20230111154112.90575-1-daniel.vetter@ffwll.ch>
 <20230111154112.90575-4-daniel.vetter@ffwll.ch>
 <e0c0e249-30bc-c310-0175-92ea379ef0d6@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e0c0e249-30bc-c310-0175-92ea379ef0d6@suse.de>
X-Operating-System: Linux phenom 5.19.0-2-amd64 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 11, 2023 at 04:59:30PM +0100, Thomas Zimmermann wrote:
> Hi
> 
> Am 11.01.23 um 16:41 schrieb Daniel Vetter:
> > Since vgaarb has been promoted to be a core piece of the pci subsystem
> > we don't have to open code random guesses anymore, we actually know
> > this in a platform agnostic way, and there's no need for an x86
> > specific hack. See also 1d38fe6ee6a8 ("PCI/VGA: Move vgaarb to
> > drivers/pci")
> > 
> > This should not result in any functional change, and the non-x86
> > multi-gpu pci systems are probably rare enough to not matter (I don't
> > know of any tbh). But it's a nice cleanup, so let's do it.
> > 
> > Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> > Cc: Thomas Zimmermann <tzimmermann@suse.de>
> > Cc: Javier Martinez Canillas <javierm@redhat.com>
> > Cc: Helge Deller <deller@gmx.de>
> > Cc: linux-fbdev@vger.kernel.org
> > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > Cc: linux-pci@vger.kernel.org
> > ---
> >   drivers/video/aperture.c | 6 ++----
> >   1 file changed, 2 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/video/aperture.c b/drivers/video/aperture.c
> > index 41e77de1ea82..3d8c925c7365 100644
> > --- a/drivers/video/aperture.c
> > +++ b/drivers/video/aperture.c
> > @@ -324,13 +324,11 @@ EXPORT_SYMBOL(aperture_remove_conflicting_devices);
> >    */
> >   int aperture_remove_conflicting_pci_devices(struct pci_dev *pdev, const char *name)
> >   {
> > -	bool primary = false;
> > +	bool primary;
> >   	resource_size_t base, size;
> >   	int bar, ret;
> > -#ifdef CONFIG_X86
> > -	primary = pdev->resource[PCI_ROM_RESOURCE].flags & IORESOURCE_ROM_SHADOW;
> > -#endif
> > +	primary = pdev == vga_default_device();
> 
> vga_default_device() is part of vgaarb and can return NULL. [1] That new
> test is likely to be incorrect on many systems.
> 
> I suggest to implement a helper like fb_is_primary_device() on x86: it uses
> the default VGA if set, or falls back to the original test. [2]
> 
> It's noteworthy that on most architectures, fb_is_primary_device() returns
> 0. But at least on Sparc [3] and some Parisc [4] machines, it does not.

Afaik these neither do legacy vga nor sysfb, so we should be fine. I'll
augment the commit message.

> I've long wanted to rework this helper anyway. So this is a good
> opportunity.

Hm yeah that sounds like a good thing to copy. I'm honestly not sure
whether it's needed, but at least it shouldn't hurt. I thought at least
that the boot default device should be set on all pci architectures.

I'll also reorder this with the previous patch to avoid the compile fail.
-Daniel

> 
> Best regards
> Thomas
> 
> [1]
> https://elixir.bootlin.com/linux/latest/source/include/linux/vgaarb.h#L69
> [2]
> https://elixir.bootlin.com/linux/latest/source/arch/x86/video/fbdev.c#L14
> [3] https://elixir.bootlin.com/linux/latest/source/arch/sparc/include/asm/fb.h#L18
> [4] https://elixir.bootlin.com/linux/latest/source/drivers/video/console/sticore.c#L1153
> 
> 
> >   	for (bar = 0; bar < PCI_STD_NUM_BARS; ++bar) {
> >   		if (!(pci_resource_flags(pdev, bar) & IORESOURCE_MEM))
> 
> -- 
> Thomas Zimmermann
> Graphics Driver Developer
> SUSE Software Solutions Germany GmbH
> Maxfeldstr. 5, 90409 N�rnberg, Germany
> (HRB 36809, AG N�rnberg)
> Gesch�ftsf�hrer: Ivo Totev




-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
