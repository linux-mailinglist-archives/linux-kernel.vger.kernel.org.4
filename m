Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63820747755
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 18:58:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231796AbjGDQ6D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 12:58:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231693AbjGDQ6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 12:58:01 -0400
Received: from mailrelay2-1.pub.mailoutpod2-cph3.one.com (mailrelay2-1.pub.mailoutpod2-cph3.one.com [46.30.211.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 126DDDD
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 09:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=rsa1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=U5xzlvM1CTgMQBuBlj9xR3JXjLncSnb3fL2Y24Bn8nI=;
        b=kFuVqPPr/JNrVPOQH8qYh972bjTGxXVQxYubNVs1hPYyWUk8nRBM0YmnLXgN+wMuL1zmAhq3AIex8
         yN6WgixYD3RiR/x2Bp1Vup9rTAWJs6NiCWU+nG3vxqAuHcTG2u8aynfzAXTAE6jHBoVcaBgmRPGFu8
         vDlpuZt5RUJJbIUQHPJEZvH2KJlUWZ4C+Fqn6N2BBuqPoAJPl4XPSumNVwj9EQwTk1OWWoEVqtpFbF
         lFJOVB3C5nAEsing1eeIGj1sstJD3ucBMRrobW/uT/34T44aEHnqeHi5SzUychkfXWBmRFDrM9uJqt
         YMxPiWf0KcR6u1h/Z87iXpc6p1wPwtg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=ed1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=U5xzlvM1CTgMQBuBlj9xR3JXjLncSnb3fL2Y24Bn8nI=;
        b=T8FvXph7wvVJ4YKRX/umvu5nJxow5nMHL7hihWXTcj6QNe5npygkfKVBCXC0tvGv7umijqfJ63yoJ
         CEZGQhzBA==
X-HalOne-ID: c73b81eb-1a8b-11ee-b83b-5ba399456a4a
Received: from ravnborg.org (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
        by mailrelay2 (Halon) with ESMTPSA
        id c73b81eb-1a8b-11ee-b83b-5ba399456a4a;
        Tue, 04 Jul 2023 16:56:55 +0000 (UTC)
Date:   Tue, 4 Jul 2023 18:56:54 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Mohammad Faiz Abbas Rizvi <faiz.abbas@arm.com>
Cc:     Liviu Dudau <liviu.dudau@arm.com>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm/arm/komeda: Remove component framework and add a
 simple encoder
Message-ID: <20230704165654.GA940443@ravnborg.org>
References: <20230621084116.26882-1-faiz.abbas@arm.com>
 <ZJ1UJaNJese6g2Ia@e110455-lin.cambridge.arm.com>
 <90f386c3-b2bb-b876-80df-c67005e89a66@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <90f386c3-b2bb-b876-80df-c67005e89a66@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mohammed,

On Tue, Jul 04, 2023 at 07:19:04PM +0530, Mohammad Faiz Abbas Rizvi wrote:
> Hi Liviu,
> 
> On 6/29/2023 3:21 PM, Liviu Dudau wrote:
> > Hi Faiz,
> >
> > Thanks for the patch and for addressing what was at some moment on my "nice to
> > improve / cleanup" list. Sorry for the delay in responding, I had to revive
> > the bits of an old setup to be able to test this properly, with 2 encoders
> > attached.
> >
> > On Wed, Jun 21, 2023 at 02:11:16PM +0530, Faiz Abbas wrote:
> >> The Komeda driver always expects the remote connector node to initialize
> >> an encoder. It uses the component aggregator framework which consists
> >> of component->bind() calls used to initialize the remote encoder and attach
> >> it to the crtc. This is different from other drm implementations which expect
> >> the display driver to supply a crtc and connect an encoder to it.
> > I think both approaches are valid in DRM. We don't want to remove the component
> > framework because it is doing the wrong thing, but because we cannot use it
> > with drivers that implement the drm_bridge API. Given that we usually pair with
> > a component encoder that also implements a drm_bridge, dropping support for
> > component framework should not affect the users of the driver.

Glad to see the patch - I think this is moving things in the right
direction.


While at it do you plan to support DRM_BRIDGE_ATTACH_NO_CONNECTOR?

I did not read the patch carefully but noticed this call with no flags:

> drm_bridge_attach(&kcrtc->encoder, bridge, NULL, 0);

To add support for DRM_BRIDGE_ATTACH_NO_CONNECTOR you may need to verify
that all relevant bridge drivers supports the flag.
You will be told at runtime but only if the relevant bridge driver is
used.

It can be done later and is obviously a separate patch.

	Sam

