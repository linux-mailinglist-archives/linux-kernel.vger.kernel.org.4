Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D06556DE102
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 18:31:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbjDKQbO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 12:31:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbjDKQbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 12:31:09 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34CB75584
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 09:31:07 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3f05f61adbeso1673315e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 09:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1681230665;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0TZpuu/VtEYDgv0XWk+c5R5i682G1E0Upxf6E8xht2I=;
        b=F8let+de/Bj6F0/oYem5xUzY9UyuGAYyjKp14aWhXUR7i1UT/nKOxoiWP4I2Y1punY
         NGUzsYvhBGO7zPEymJcNCvBcE+z86VoQst+jVSSnG/PK8pFGzodmFMX5hf7A7gC52Lnv
         UTQY7eyUCjrKhvnuMlHkvGT6GmRKqOZq9z2Wc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681230665;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0TZpuu/VtEYDgv0XWk+c5R5i682G1E0Upxf6E8xht2I=;
        b=2lEAy8fZLN2hUEIu1HaGOVKq8J6EFRTE9Jx0+Z2t/Ie4+yXGsibe1mg9vDLTBiu6rc
         foWMt8qpN5EdJXIxPalTyFAgOUWgNlp04rF30ZKLTYdIMlT5rKTMU4heMoUAvXStWtVA
         WNzTFq6nuDPRvDgWRRBzUK/rWIJEKtgdmNUsQr9q18VnZjinMsylQMv6UDXjhaIQnEsb
         L5QZ9sveViRNgStfTUIJlbdsDi6TJpJvkz9hhbgO4nlIjvVXfdWq1w/v64P+LQtNJBkf
         kSDAI6fLjxkd6a6Uzk07jW/VLCZe+SJKCvtBjWEb1HnNjoTyuENRemoJeHjZG/+DOFdm
         Obaw==
X-Gm-Message-State: AAQBX9da8myOjs9Pht60HrmlzbvmN1ajLyhFfx1uZJOn0lQ+v9zxNM1d
        dQ+wuXrmRj0f9NpzQ2xm3g8+vg==
X-Google-Smtp-Source: AKy350YFuMzmVwKbmizf25BU1CKd5Mi3Bt+xIUF0f+oNfBawoa/p9T18zV5vWH3/t/D0awWGLEACSw==
X-Received: by 2002:a05:600c:4709:b0:3f0:84b7:22cf with SMTP id v9-20020a05600c470900b003f084b722cfmr6335310wmo.2.1681230665695;
        Tue, 11 Apr 2023 09:31:05 -0700 (PDT)
Received: from phenom.ffwll.local (212-51-149-33.fiber7.init7.net. [212.51.149.33])
        by smtp.gmail.com with ESMTPSA id g17-20020a05600c001100b003dd1bd0b915sm21028280wmc.22.2023.04.11.09.31.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 09:31:05 -0700 (PDT)
Date:   Tue, 11 Apr 2023 18:31:03 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Jeffrey Hugo <quic_jhugo@quicinc.com>
Cc:     Greg KH <greg@kroah.com>, Stephen Rothwell <sfr@canb.auug.org.au>,
        Oded Gabbay <ogabbay@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Pranjal Ramajor Asha Kanojiya <quic_pkanojiy@quicinc.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
        Dave Airlie <airlied@redhat.com>
Subject: Re: linux-next: build failure after merge of the driver-core tree
Message-ID: <ZDWLRxkFjsGZazXD@phenom.ffwll.local>
Mail-Followup-To: Jeffrey Hugo <quic_jhugo@quicinc.com>,
        Greg KH <greg@kroah.com>, Stephen Rothwell <sfr@canb.auug.org.au>,
        Oded Gabbay <ogabbay@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Pranjal Ramajor Asha Kanojiya <quic_pkanojiy@quicinc.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
        Dave Airlie <airlied@redhat.com>
References: <20230411143812.11a4b00d@canb.auug.org.au>
 <ZDUuiB+E1tIJ95LY@phenom.ffwll.local>
 <2023041123-tractor-quake-c44d@gregkh>
 <ZDV2Nvs57Orx47tj@phenom.ffwll.local>
 <1094266f-d845-9fa4-9f44-85de8352c04f@quicinc.com>
 <2023041131-boxy-excavator-1183@gregkh>
 <04155e87-16f7-9916-6aa8-b4842ef92b83@quicinc.com>
 <3879d287-81e0-5e25-8c58-f9554ce2303b@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3879d287-81e0-5e25-8c58-f9554ce2303b@quicinc.com>
X-Operating-System: Linux phenom 6.1.0-7-amd64 
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 11, 2023 at 09:29:27AM -0600, Jeffrey Hugo wrote:
> On 4/11/2023 9:26 AM, Jeffrey Hugo wrote:
> > On 4/11/2023 9:13 AM, Greg KH wrote:
> > > On Tue, Apr 11, 2023 at 09:08:39AM -0600, Jeffrey Hugo wrote:
> > > > On 4/11/2023 9:01 AM, Daniel Vetter wrote:
> > > > > On Tue, Apr 11, 2023 at 12:40:28PM +0200, Greg KH wrote:
> > > > > > On Tue, Apr 11, 2023 at 11:55:20AM +0200, Daniel Vetter wrote:
> > > > > > > On Tue, Apr 11, 2023 at 02:38:12PM +1000, Stephen Rothwell wrote:
> > > > > > > > Hi all,
> > > > > > > > 
> > > > > > > > After merging the driver-core tree, today's linux-next build (x86_64
> > > > > > > > allmodconfig) failed like this:
> > > > > > > > 
> > > > > > > > In file included from include/linux/linkage.h:7,
> > > > > > > >                    from include/linux/kernel.h:17,
> > > > > > > >                    from drivers/accel/qaic/mhi_qaic_ctrl.c:4:
> > > > > > > > drivers/accel/qaic/mhi_qaic_ctrl.c: In function
> > > > > > > > 'mhi_qaic_ctrl_init':
> > > > > > > > include/linux/export.h:27:22: error: passing
> > > > > > > > argument 1 of 'class_create' from incompatible
> > > > > > > > pointer type
> > > > > > > > [-Werror=incompatible-pointer-types]
> > > > > > > >      27 | #define THIS_MODULE (&__this_module)
> > > > > > > >         |                     ~^~~~~~~~~~~~~~~
> > > > > > > >         |                      |
> > > > > > > >         |                      struct module *
> > > > > > > > drivers/accel/qaic/mhi_qaic_ctrl.c:544:38: note:
> > > > > > > > in expansion of macro 'THIS_MODULE'
> > > > > > > >     544 |         mqc_dev_class =
> > > > > > > > class_create(THIS_MODULE,
> > > > > > > > MHI_QAIC_CTRL_DRIVER_NAME);
> > > > > > > >         |                                      ^~~~~~~~~~~
> > > > > > > > In file included from include/linux/device.h:31,
> > > > > > > >                    from include/linux/mhi.h:9,
> > > > > > > >                    from drivers/accel/qaic/mhi_qaic_ctrl.c:5:
> > > > > > > > include/linux/device/class.h:229:54: note:
> > > > > > > > expected 'const char *' but argument is of type
> > > > > > > > 'struct module *'
> > > > > > > >     229 | struct class * __must_check
> > > > > > > > class_create(const char *name);
> > > > > > > >         |                                          ~~~~~~~~~~~~^~~~
> > > > > > > > drivers/accel/qaic/mhi_qaic_ctrl.c:544:25:
> > > > > > > > error: too many arguments to function
> > > > > > > > 'class_create'
> > > > > > > >     544 |         mqc_dev_class =
> > > > > > > > class_create(THIS_MODULE,
> > > > > > > > MHI_QAIC_CTRL_DRIVER_NAME);
> > > > > > > >         |                         ^~~~~~~~~~~~
> > > > > > > > include/linux/device/class.h:229:29: note: declared here
> > > > > > > >     229 | struct class * __must_check
> > > > > > > > class_create(const char *name);
> > > > > > > >         |                             ^~~~~~~~~~~~
> > > > > > > > 
> > > > > > > > Caused by commit
> > > > > > > > 
> > > > > > > >     1aaba11da9aa ("driver core: class: remove
> > > > > > > > module * from class_create()")
> > > > > > > > 
> > > > > > > > interacting with commit
> > > > > > > > 
> > > > > > > >     566fc96198b4 ("accel/qaic: Add mhi_qaic_cntl")
> > > > > > > > 
> > > > > > > > from the drm tree.
> > > > > > > > 
> > > > > > > > I have applied the following merge fix patch for today.
> > > > > > > > 
> > > > > > > > From: Stephen Rothwell <sfr@canb.auug.org.au>
> > > > > > > > Date: Tue, 11 Apr 2023 14:16:57 +1000
> > > > > > > > Subject: [PATCH] fixup for "driver core: class:
> > > > > > > > remove module * from class_create()"
> > > > > > > > 
> > > > > > > > interacting with "accel/qaic: Add mhi_qaic_cntl"
> > > > > > > > 
> > > > > > > > Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> > > > > > > 
> > > > > > > Thanks for the fixup. Since Dave is out I've made a
> > > > > > > note about this in my
> > > > > > > handover mail so it won't get lost in the drm-next
> > > > > > > merge window pull. I
> > > > > > > don't think we need any other coordination than
> > > > > > > mention it in each pull to
> > > > > > > Linus, topic tree seems overkill for this. Plus there's no way I can
> > > > > > > untangle the drm tree anyway :-).
> > > > > > 
> > > > > > Want me to submit a patch for the drm tree that moves this to use
> > > > > > class_register() instead, which will make the
> > > > > > merge/build issue go away
> > > > > > for you?  That's my long-term goal here anyway, so converting this new
> > > > > > code to this api today would be something I have to do eventually :)
> > > > > 
> > > > > We kinda closed drm-next for feature work mostly already (just pulling
> > > > > stuff in from subtrees), so won't really help for this merge window.
> > > > > 
> > > > > For everything else I think this is up to Oded, I had no
> > > > > idea qaic needed
> > > > > it's entire own dev class and I don't want to dig into this
> > > > > for the risk I
> > > > > might freak out :-)
> > > > > 
> > > > > Adding Oded.
> > > > > 
> > > > > Cheers, Daniel
> > > > 
> > > > Sorry for the mess.
> > > > 
> > > > I made a note to update to class_register() once my drm-misc access is
> > > > sorted out.  Looks like we'll address the conflict in the merge
> > > > window, and
> > > > catch the update to the new API in the following release.
> > > 
> > > Wait, I think the large question is, "why does this need a separate
> > > class"?  Why are you not using the accel char device and class?  That is
> > > what everything under accel/ should be using, otherwise why put it in
> > > there?
> > > 
> > > And what exactly are you using that class for?  Just device nodes?  If
> > > so, how many?
> > > 
> > > thanks,
> > > 
> > > greg k-h
> > 
> > 
> > Remember MHI_UCI that then evolved into the WWAN subsystem?  I pointed
> > out at the time that AIC100/QAIC would need the same functionality.
> > You/Jakub told myself/Mani/Loic that a combined implementation is not
> > acceptable, and every area needs to implement their own version of
> > MHI_UCI.
> > 
> > We took the WWAN subsystem and simplified it to meet our needs.
> > 
> > The functionality is QAIC specific, so wedging it into the Accel node
> > seems to be a poor fit as it would subject Habana and iVPU to the same.
> 
> Also, I forgot to mention.  QAIC is sharing userspace components with WWAN,
> so we really cannot diverge from what WWAN has done and define a new API
> through the Accel node.

So there is an accel/drm_device in the qaic driver, but there's also this
different class thing, which I don't get.

And yeah if that's an entirely orthogonal thing then I guess that should
be in a different driver/subsystem, all supported with the aux bus to
multiplex the underlying device.

I haven't found any explanation for what MHI is (or any of the other
acrynoms), so I'm entirely lost.
-Daniel

> 
> > 
> > We need (eventually) 128 device nodes.  We have systems with 32 QAIC
> > devices, and each QAIC device uses 4 device nodes (32 * 4 = 128).  WWAN
> > subsystem would be similar.  Looks like each 5G modem is 6 nodes per
> > device, so if you had 22 5G modems on a system, you'd have 132 device
> > nodes.  I'm not aware of any such system, but it could exist.
> > 
> > -Jeff
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
