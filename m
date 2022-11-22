Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94A11633F91
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 15:57:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233521AbiKVO5N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 09:57:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234147AbiKVO4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 09:56:39 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACF2331EF6
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 06:54:48 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id l14so6212350wrw.13
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 06:54:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KrmpqTzejW7lkXpBGPhRv0hrjR4p7AU1gtyo69Z8dF0=;
        b=YCNl6cLofcjidVRmlkW34QMzrxYEAWxQbuiM1YpiT8cJ/YWAUvxcNzkVK6JwrsDgoM
         rbalLGZmQKr5LzHBUO4qqZS7mwH2DpsjQ4wfXQszjLzMXX+6SwJdDEHOF8USSx9F4pKU
         U5g2mizLnvzhYP0bfhBeVkjZGWWZ26TtzYawM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KrmpqTzejW7lkXpBGPhRv0hrjR4p7AU1gtyo69Z8dF0=;
        b=1WoihWM85tDx08op2bzggYScMDdiE8AJJiIU7dFNCSxg2D+OMosIBPLy/JEsjDNld8
         INCEZzhi5tB07fau4g9rhgfXCu6NyEcAK6/38MEQnblSi4mNw/ttnuGdhWtJ9zUh/+uY
         jKbcf/elu+8R28akLeRPgU1MwQyE2GZDhu+0r8VS5mCYtWGipCgVTSueQcq1p17bAdyn
         YEmg3J33gKFVedPHQH0BmNXWeTJFydy4F7MHjnW9uloV8PPF7wXLOmUfh81VuGT3iPI7
         JZIoTAF0mYFlD8pRvYMy8jEnf2V3wQggnUZnC3i2RbxnCZqTgCwtvtHEn0W1qr07Hpvd
         AyvA==
X-Gm-Message-State: ANoB5pk58sbmQjEIvPzvH8iVxdDxA0A9X5OAubh+Fr39xO2Dq21Z1fDj
        x6QIgl4wjIOPQgxtzG0s4I/g+Q==
X-Google-Smtp-Source: AA0mqf4wHzbCTiw1wZ+EHm0EW2ISVF8I4ZoG2HxHzkAjALvpNFz3Jnb1gQyAfrmIT7ceICceEd46Pw==
X-Received: by 2002:adf:e3c3:0:b0:241:ccd8:f0f7 with SMTP id k3-20020adfe3c3000000b00241ccd8f0f7mr8677335wrm.393.1669128876365;
        Tue, 22 Nov 2022 06:54:36 -0800 (PST)
Received: from phenom.ffwll.local (212-51-149-33.fiber7.init7.net. [212.51.149.33])
        by smtp.gmail.com with ESMTPSA id w4-20020adfec44000000b002415dd45320sm14103759wrn.112.2022.11.22.06.54.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 06:54:35 -0800 (PST)
Date:   Tue, 22 Nov 2022 15:54:33 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Dave Airlie <airlied@gmail.com>
Cc:     Sonal Santan <sonal.santan@amd.com>,
        Oded Gabbay <ogabbay@kernel.org>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
        Jeffrey Hugo <quic_jhugo@quicinc.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Arnd Bergmann <arnd@arndb.de>, Jiho Chu <jiho.chu@samsung.com>,
        John Hubbard <jhubbard@nvidia.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Christoph Hellwig <hch@infradead.org>,
        Christopher Friedt <chrisfriedt@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Kevin Hilman <khilman@baylibre.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>,
        Maciej Kwapulinski <maciej.kwapulinski@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH v4 0/4] new subsystem for compute accelerator devices
Message-ID: <Y3ziqU2vrgwIY4HB@phenom.ffwll.local>
Mail-Followup-To: Dave Airlie <airlied@gmail.com>,
        Sonal Santan <sonal.santan@amd.com>,
        Oded Gabbay <ogabbay@kernel.org>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
        Jeffrey Hugo <quic_jhugo@quicinc.com>,
        Jason Gunthorpe <jgg@nvidia.com>, Arnd Bergmann <arnd@arndb.de>,
        Jiho Chu <jiho.chu@samsung.com>, John Hubbard <jhubbard@nvidia.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Christoph Hellwig <hch@infradead.org>,
        Christopher Friedt <chrisfriedt@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Kevin Hilman <khilman@baylibre.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>,
        Maciej Kwapulinski <maciej.kwapulinski@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jagan Teki <jagan@amarulasolutions.com>
References: <20221119204435.97113-1-ogabbay@kernel.org>
 <02c514c0-62c4-1cdf-5d3f-b3d8942ef005@amd.com>
 <CAPM=9ty_YHrM5QhAjgFvNdpkEwnB_WHsouhYG8m5XGrb+kmWAQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPM=9ty_YHrM5QhAjgFvNdpkEwnB_WHsouhYG8m5XGrb+kmWAQ@mail.gmail.com>
X-Operating-System: Linux phenom 5.19.0-2-amd64 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 22, 2022 at 03:46:25PM +1000, Dave Airlie wrote:
> On Tue, 22 Nov 2022 at 09:06, Sonal Santan <sonal.santan@amd.com> wrote:
> >
> > On 11/19/22 12:44, Oded Gabbay wrote:
> > > This is the fourth (and hopefully last) version of the patch-set to add the
> > > new subsystem for compute accelerators. I removed the RFC headline as
> > > I believe it is now ready for merging.
> > >
> > > Compare to v3, this patch-set contains one additional patch that adds
> > > documentation regarding the accel subsystem. I hope it's good enough for
> > > this stage. In addition, there were few very minor fixes according to
> > > comments received on v3.
> > >
> > > The patches are in the following repo:
> > > https://git.kernel.org/pub/scm/linux/kernel/git/ogabbay/accel.git/log/?h=accel_v4
> > >
> > > As in v3, The HEAD of that branch is a commit adding a dummy driver that
> > > registers an accel device using the new framework. This can be served
> > > as a simple reference.
> > >
> > > v1 cover letter:
> > > https://lkml.org/lkml/2022/10/22/544
> > >
> > > v2 cover letter:
> > > https://lore.kernel.org/lkml/20221102203405.1797491-1-ogabbay@kernel.org/T/
> > >
> > > v3 cover letter:
> > > https://lore.kernel.org/lkml/20221106210225.2065371-1-ogabbay@kernel.org/T/
> >
> > Thanks for defining the new accel subsystem. We are currently working on
> > DRM based drivers for unannounced acceleration devices. I am fine with
> > these changes with the assumption that the choice of using classic DRM
> > or accel is left up to the individual driver.
> 
> I don't think that decision should be up to any individual driver
> author. It will have to be consensus with me/Daniel/Oded and the
> driver authors.

Plus the entire point of this is that it's _still_ a drm based driver. So
aside from changing a flag in the kernel driver and adjusting userspace to
find the right chardev, there should be zero changes need for an existing
drm based driver stack that gets ported to drivers/accel.

And of course if we realize there's issues as we add drivers, we can fix
things up. This is just to kick things off, not something that's going to
be cast in stone for all eternity.

Sonal, with that clarification/explanation, is this entire thing
reasonable in principal and you can drop an Ack onto the series?

Thanks, Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
