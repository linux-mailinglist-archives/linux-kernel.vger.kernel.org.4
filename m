Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0A81637773
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 12:19:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbiKXLTT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 06:19:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbiKXLTM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 06:19:12 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E21627D287
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 03:18:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669288682;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xPrnI3wUzzA5EN1dGSFZgqDRTkuK8RUJQxnTAkxblL0=;
        b=ICsGyojkrI657XQb/u27fYu1YzNkQ18cPjcn3vShqogL3hh6tKOIxj7kOnd43MvyRLFJuF
        Js9IXknS/2WSHA2gsXMGsoI8Ij2l7cH+lAyZM8T5ZmTKZ3/3jqjZIsymSH6O5GjAGsEmtw
        7Zc0qeri2kcDnLG8cnHvdHQTcuzYWYg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-16-f7iuFoDwNPSvuE7nPRhkhQ-1; Thu, 24 Nov 2022 06:17:58 -0500
X-MC-Unique: f7iuFoDwNPSvuE7nPRhkhQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F40AD858F17;
        Thu, 24 Nov 2022 11:17:57 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.192.212])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 817292166B26;
        Thu, 24 Nov 2022 11:17:57 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 2A9D91800609; Thu, 24 Nov 2022 12:17:54 +0100 (CET)
Date:   Thu, 24 Nov 2022 12:17:54 +0100
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH resend v2] drm/fourcc: Add missing big-endian XRGB1555
 and RGB565 formats
Message-ID: <20221124111754.yrfewus6mqismc3b@sirius.home.kraxel.org>
References: <3ee1f8144feb96c28742b22384189f1f83bcfc1a.1669221671.git.geert@linux-m68k.org>
 <Y35RCaEP0icg6San@phenom.ffwll.local>
 <CAMuHMdVgqwHjm8Hxms04rg6YXiQacEwKiaRV80nNA_OM9mvZpA@mail.gmail.com>
 <20221124065148.7v4m3qli2k74mic6@sirius.home.kraxel.org>
 <CAMuHMdUJUUPPxS6VCHV1X9XMqzfACvu8qivUVO2pMbvD7rcQKg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdUJUUPPxS6VCHV1X9XMqzfACvu8qivUVO2pMbvD7rcQKg@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

> > Supporting 16 bpp in the driver wouldn't be that much of a problem, but
> > processing the framebuffer on the host side when emulating a big endian
> > guest on a little endian host is painful.  I think I can't ask pixman to
> > do a conversation from DRM_FORMAT_RGB565 | DRM_FORMAT_BIG_ENDIAN to
> > DRM_FORMAT_XRGB8888 on a little endian machine.
> 
> Indeed. But you can do a quick 16-bit byteswap, and convert from
> DRM_FORMAT_RGB565 to DRM_FORMAT_XRGB8888?

Sure doable, but it's an extra step in a rarely tested code path ...

> BTW, does pixman support converting DRM_FORMAT_RGB565 to
> DRM_FORMAT_XRGB8888 on a big-endian machine?

I don't think so.  When you can get the color bits with shifting and
masking pixman is happy.  For rgb565 (and xrgb1555) that works only on
native byte order.

take care,
  Gerd

