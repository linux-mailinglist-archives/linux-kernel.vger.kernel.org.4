Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4523D666159
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 18:05:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239508AbjAKRFm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 12:05:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236185AbjAKRFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 12:05:07 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7732E395E2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 09:02:30 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id co23so15732056wrb.4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 09:02:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=b1AAzENehsPYWw2Oaedh0crDw1m6Zs6gd5zh20RGn1E=;
        b=FwUOD+wCpn9aORxQQ9IZFC80gkiq974021pW37TQW8dMSa0nBryG+Y9/ufYw40yYdd
         cfc8QrFcpiw45eaM4QhmQ4Qnd6Y6CSQc3mItEfUbZAZTZ2xylQ3/t1zOMXREjJ2V3BOd
         05hSUiPmq2+ZbXFl2jn/CbytxTD/EGeYakr6M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b1AAzENehsPYWw2Oaedh0crDw1m6Zs6gd5zh20RGn1E=;
        b=P338pThrGNhGafhk5+QJG89M3bcQgc9lqNDZQN4xS0T10bitPSjqHMTIkDKPkDf7VD
         Ok/vv5xRuAeV9hePfsotMlndGCWRpdeF0A7KhXKg8cGZYhJ6LwC9M6XF7S6PxsXAbygP
         DSeDU3p3kPzGC7oZ3pLHDBmtPzqRZwv/G1ucw1DNOmiAa1gHa5ZPvgu3m8slxeNGwZur
         LYmUTH/hosMM4I6QrZXrcceA2F72nWuguNVnxkcgrF0J2ewmrS6gIyeVYnvXwfMkMq9p
         XNyZBeyeFmKn8RzlwxYdUpB/hUB9MbLJI5ulynBHtrQjdMZdbKHzCZslSoT2fLgnv7Cn
         U7Rw==
X-Gm-Message-State: AFqh2kpk4x7bdL13G3CVRpUmLOE005uhWuJxzi32a9/L6thNnrbX8lUJ
        GY0uzUBac+9d64tdehxz4x1o7Q==
X-Google-Smtp-Source: AMrXdXtPPt+JpFASCNzf+qFF6+k8bl3HIp6rRi4y8P9mKZ6UBLFtd1bgk1B/AByfIzGUc7gGYAO2BA==
X-Received: by 2002:a5d:48c6:0:b0:242:844a:835d with SMTP id p6-20020a5d48c6000000b00242844a835dmr41453252wrs.65.1673456549060;
        Wed, 11 Jan 2023 09:02:29 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id n16-20020a5d4010000000b002bbed1388a5sm8972510wrp.15.2023.01.11.09.02.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 09:02:28 -0800 (PST)
Date:   Wed, 11 Jan 2023 18:02:26 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Dave Airlie <airlied@redhat.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Helge Deller <deller@gmx.de>, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH 01/11] drm/ast: Use
 drm_aperture_remove_conflicting_pci_framebuffers
Message-ID: <Y77rol9OibGAzgJk@phenom.ffwll.local>
Mail-Followup-To: Thomas Zimmermann <tzimmermann@suse.de>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Dave Airlie <airlied@redhat.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Helge Deller <deller@gmx.de>, linux-fbdev@vger.kernel.org
References: <20230111154112.90575-1-daniel.vetter@ffwll.ch>
 <1118bbfc-16f2-a65c-0dd0-ccc0e42e13c1@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1118bbfc-16f2-a65c-0dd0-ccc0e42e13c1@suse.de>
X-Operating-System: Linux phenom 5.19.0-2-amd64 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 11, 2023 at 04:48:39PM +0100, Thomas Zimmermann wrote:
> Hi
> 
> Am 11.01.23 um 16:41 schrieb Daniel Vetter:
> > It's just open coded and matches.
> > 
> > Note that Thomas said that his version apparently failed for some
> > reason, but hey maybe we should try again.
> 
> I'll give this patch a test tomorrow.

Thanks a lot!
-Daniel

> 
> Best regards
> Thomas
> 
> > 
> > Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> > Cc: Dave Airlie <airlied@redhat.com>
> > Cc: Thomas Zimmermann <tzimmermann@suse.de>
> > Cc: Javier Martinez Canillas <javierm@redhat.com>
> > Cc: Helge Deller <deller@gmx.de>
> > Cc: linux-fbdev@vger.kernel.org
> > ---
> >   drivers/gpu/drm/ast/ast_drv.c | 16 +---------------
> >   1 file changed, 1 insertion(+), 15 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/ast/ast_drv.c b/drivers/gpu/drm/ast/ast_drv.c
> > index 420fc75c240e..3ac24a780f50 100644
> > --- a/drivers/gpu/drm/ast/ast_drv.c
> > +++ b/drivers/gpu/drm/ast/ast_drv.c
> > @@ -90,27 +90,13 @@ static const struct pci_device_id ast_pciidlist[] = {
> >   MODULE_DEVICE_TABLE(pci, ast_pciidlist);
> > -static int ast_remove_conflicting_framebuffers(struct pci_dev *pdev)
> > -{
> > -	bool primary = false;
> > -	resource_size_t base, size;
> > -
> > -	base = pci_resource_start(pdev, 0);
> > -	size = pci_resource_len(pdev, 0);
> > -#ifdef CONFIG_X86
> > -	primary = pdev->resource[PCI_ROM_RESOURCE].flags & IORESOURCE_ROM_SHADOW;
> > -#endif
> > -
> > -	return drm_aperture_remove_conflicting_framebuffers(base, size, primary, &ast_driver);
> > -}
> > -
> >   static int ast_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
> >   {
> >   	struct ast_private *ast;
> >   	struct drm_device *dev;
> >   	int ret;
> > -	ret = ast_remove_conflicting_framebuffers(pdev);
> > +	ret = drm_aperture_remove_conflicting_pci_framebuffers(pdev, &ast_driver);
> >   	if (ret)
> >   		return ret;
> 
> -- 
> Thomas Zimmermann
> Graphics Driver Developer
> SUSE Software Solutions Germany GmbH
> Maxfeldstr. 5, 90409 Nürnberg, Germany
> (HRB 36809, AG Nürnberg)
> Geschäftsführer: Ivo Totev




-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
