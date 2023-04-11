Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C4E76DDEBF
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 17:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbjDKPB7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 11:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbjDKPBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 11:01:30 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E826F4C27
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 08:01:14 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-2efbab477a6so113767f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 08:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1681225273; x=1683817273;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p5X6MAk0ycdyWUIs+bI10cqIdEaTFo7OsdLJazRF6W4=;
        b=I5dJGkU+8/zCsX059XnDP41lbfObXsEprjlJwOEdjXnaMwmF/xe4879vsPOSYbvLeN
         GjOI4IuIHRrfsIYOhkeGkS1pTC10qm94MV82STUC5efmZvozDMMfs/NXdg2W1JSjXn8L
         HJj7rUW7GOULQiR9TtLDhNb0/nN8O4XhvIqN8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681225273; x=1683817273;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p5X6MAk0ycdyWUIs+bI10cqIdEaTFo7OsdLJazRF6W4=;
        b=VQtTm2DCGWiPXZNSZLw2pGPJ/gLoh1PS2kyBzbKsGfNNHDA6K/imW7Wfgf6QKh+j8E
         cStfjyhgMQ3so5Xof6rv6Ce42z7NdyxTNgKEKiowGs1zXX0/0IeH0xbS2kEPr0Py68g0
         2RXOAKuY9hqZeJxu5w4X9o4aeIlImXIdpM5hMszASXuRR9+v/uPn+3U0WF1Q1z2u3WBf
         8Dfa8zocW/bZy54WKZTXl4CgyoSOEhEOxyTbL+CWwcD4eOtOtrCpspeQiHE2ErMxD5LP
         QLMC0Od5MURKc3PrT0yXTmedXy6sD6OS/Co2Lth8X3RgzaHKFNL4w7gQaDar1lIEaZZk
         rfJA==
X-Gm-Message-State: AAQBX9d3QWj5COQd3Rq73KqB4uiPWmM5xfwiTX0EEp+5EwyQKGK25jYm
        zqpwIy2b6dTcn/ulGWJ+92DCxA==
X-Google-Smtp-Source: AKy350Y2w1T0rz4N/FvRZIpzEHOepBmJZn8uoGYoxs2MFy7RDHglu0yv8BxU4chJkRQTTJGEfaLenA==
X-Received: by 2002:a05:600c:3ca3:b0:3eb:2e2a:be95 with SMTP id bg35-20020a05600c3ca300b003eb2e2abe95mr8317833wmb.2.1681225273221;
        Tue, 11 Apr 2023 08:01:13 -0700 (PDT)
Received: from phenom.ffwll.local (212-51-149-33.fiber7.init7.net. [212.51.149.33])
        by smtp.gmail.com with ESMTPSA id u14-20020a05600c00ce00b003ed243222adsm17186003wmm.42.2023.04.11.08.01.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 08:01:12 -0700 (PDT)
Date:   Tue, 11 Apr 2023 17:01:10 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Greg KH <greg@kroah.com>, Oded Gabbay <ogabbay@kernel.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Dave Airlie <airlied@redhat.com>,
        Jeffrey Hugo <quic_jhugo@quicinc.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Pranjal Ramajor Asha Kanojiya <quic_pkanojiy@quicinc.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
        Oded Gabbay <ogabbay@kernel.org>
Subject: Re: linux-next: build failure after merge of the driver-core tree
Message-ID: <ZDV2Nvs57Orx47tj@phenom.ffwll.local>
Mail-Followup-To: Greg KH <greg@kroah.com>,
        Oded Gabbay <ogabbay@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Dave Airlie <airlied@redhat.com>,
        Jeffrey Hugo <quic_jhugo@quicinc.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Pranjal Ramajor Asha Kanojiya <quic_pkanojiy@quicinc.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
References: <20230411143812.11a4b00d@canb.auug.org.au>
 <ZDUuiB+E1tIJ95LY@phenom.ffwll.local>
 <2023041123-tractor-quake-c44d@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023041123-tractor-quake-c44d@gregkh>
X-Operating-System: Linux phenom 6.1.0-7-amd64
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 11, 2023 at 12:40:28PM +0200, Greg KH wrote:
> On Tue, Apr 11, 2023 at 11:55:20AM +0200, Daniel Vetter wrote:
> > On Tue, Apr 11, 2023 at 02:38:12PM +1000, Stephen Rothwell wrote:
> > > Hi all,
> > > 
> > > After merging the driver-core tree, today's linux-next build (x86_64
> > > allmodconfig) failed like this:
> > > 
> > > In file included from include/linux/linkage.h:7,
> > >                  from include/linux/kernel.h:17,
> > >                  from drivers/accel/qaic/mhi_qaic_ctrl.c:4:
> > > drivers/accel/qaic/mhi_qaic_ctrl.c: In function 'mhi_qaic_ctrl_init':
> > > include/linux/export.h:27:22: error: passing argument 1 of 'class_create' from incompatible pointer type [-Werror=incompatible-pointer-types]
> > >    27 | #define THIS_MODULE (&__this_module)
> > >       |                     ~^~~~~~~~~~~~~~~
> > >       |                      |
> > >       |                      struct module *
> > > drivers/accel/qaic/mhi_qaic_ctrl.c:544:38: note: in expansion of macro 'THIS_MODULE'
> > >   544 |         mqc_dev_class = class_create(THIS_MODULE, MHI_QAIC_CTRL_DRIVER_NAME);
> > >       |                                      ^~~~~~~~~~~
> > > In file included from include/linux/device.h:31,
> > >                  from include/linux/mhi.h:9,
> > >                  from drivers/accel/qaic/mhi_qaic_ctrl.c:5:
> > > include/linux/device/class.h:229:54: note: expected 'const char *' but argument is of type 'struct module *'
> > >   229 | struct class * __must_check class_create(const char *name);
> > >       |                                          ~~~~~~~~~~~~^~~~
> > > drivers/accel/qaic/mhi_qaic_ctrl.c:544:25: error: too many arguments to function 'class_create'
> > >   544 |         mqc_dev_class = class_create(THIS_MODULE, MHI_QAIC_CTRL_DRIVER_NAME);
> > >       |                         ^~~~~~~~~~~~
> > > include/linux/device/class.h:229:29: note: declared here
> > >   229 | struct class * __must_check class_create(const char *name);
> > >       |                             ^~~~~~~~~~~~
> > > 
> > > Caused by commit
> > > 
> > >   1aaba11da9aa ("driver core: class: remove module * from class_create()")
> > > 
> > > interacting with commit
> > > 
> > >   566fc96198b4 ("accel/qaic: Add mhi_qaic_cntl")
> > > 
> > > from the drm tree.
> > > 
> > > I have applied the following merge fix patch for today.
> > > 
> > > From: Stephen Rothwell <sfr@canb.auug.org.au>
> > > Date: Tue, 11 Apr 2023 14:16:57 +1000
> > > Subject: [PATCH] fixup for "driver core: class: remove module * from class_create()"
> > > 
> > > interacting with "accel/qaic: Add mhi_qaic_cntl"
> > > 
> > > Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> > 
> > Thanks for the fixup. Since Dave is out I've made a note about this in my
> > handover mail so it won't get lost in the drm-next merge window pull. I
> > don't think we need any other coordination than mention it in each pull to
> > Linus, topic tree seems overkill for this. Plus there's no way I can
> > untangle the drm tree anyway :-).
> 
> Want me to submit a patch for the drm tree that moves this to use
> class_register() instead, which will make the merge/build issue go away
> for you?  That's my long-term goal here anyway, so converting this new
> code to this api today would be something I have to do eventually :)

We kinda closed drm-next for feature work mostly already (just pulling
stuff in from subtrees), so won't really help for this merge window.

For everything else I think this is up to Oded, I had no idea qaic needed
it's entire own dev class and I don't want to dig into this for the risk I
might freak out :-)

Adding Oded.

Cheers, Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
