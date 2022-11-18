Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2327562ED9F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 07:32:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234814AbiKRGcA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 01:32:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235200AbiKRGbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 01:31:55 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE9AF97A99
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 22:31:53 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id q1so4180528pgl.11
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 22:31:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2NYDcOh5n1h0+3JmFt6OBHp8y607KAymyMlNfD86cHQ=;
        b=cDvyxai/no61jb0OqF0aMtz6WqFdoA6s+9a4NZgMCjxROG/jJZSE/hHUeLHWTKGAZF
         U1niJ0U/5ezYtDmASd0UvyFkxpX15Y3t0Wy5bj75gbHdMU4ZrMwzEGf4pVXoVXUUzImM
         KrmQy6ZtItcY1Q9Mx1JljRcT5q/Y1Na7yqgaPFGX6QotwvKs2HyyoVEk8/jjhyi6NsPQ
         GKNFi81b/z8RzK5EafYt3Hy2jCWd7+sW/PVsCdsqvsZ706/SQZmqvO7CHCl9n6bK/FaM
         dRw3+P8FOauBcnwMknptIMnnZ4GjOzoO4fmvBvg5HTOCYPDccnm0G8PHo9E14BN2rvp0
         vMCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2NYDcOh5n1h0+3JmFt6OBHp8y607KAymyMlNfD86cHQ=;
        b=aCUbzMuvm1TX0NiEb3V3xHnvvqP2JBXcgmJIbROXMucy0E9q9EA5B6bR4AWGsnZjfl
         6Onx9WPHjc84l49yyWjEVo7r5kXz5p/gnYdP1WbSKoHuldqFPPGVyk3JeXCjmvx4WW6A
         raEFhQT0QXkONi7sqMXGX+IX8my+WiC6dSGvLUeY6ZbNhZ0qs2k0HDItzwA0qHbu/xPG
         CZTfd7GBTFOKCkGSBDx+6X0d5c80YuGtdUZFsMVX6RwYphfxK0580IOHnBPoYtjG+QNg
         iTdpa3E+8BL8Pt3y1cGFkmpI5ZSdslmj/g9ok1vRBU3NocNu/koYdFFvNNTRmr0U1/mt
         ZwyQ==
X-Gm-Message-State: ANoB5pnOC5Yqb07eU2gtl2iBlqYr/tOfkK8XLPoGGjNIc5VfohDPQ6mO
        rSPJAH/Wax+uy3WgvNS4WmA=
X-Google-Smtp-Source: AA0mqf5DR/Q9FiW5k+t7mdG5PItHqfyZV5K8uA3eiba29lpUhIJc47LTBFEz1d+DDTWuFtxQvpzDSA==
X-Received: by 2002:a63:5c1e:0:b0:46e:96ba:494d with SMTP id q30-20020a635c1e000000b0046e96ba494dmr5365390pgb.404.1668753113281;
        Thu, 17 Nov 2022 22:31:53 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:e4c5:c31d:4c68:97a0])
        by smtp.gmail.com with ESMTPSA id nd13-20020a17090b4ccd00b0020de216d0f7sm1981661pjb.18.2022.11.17.22.31.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 22:31:52 -0800 (PST)
Date:   Thu, 17 Nov 2022 22:31:49 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH 01/11] ASoC: ak5386: switch to using gpiod API
Message-ID: <Y3cm1eeDN+n3tbpG@google.com>
References: <20221116053817.2929810-1-dmitry.torokhov@gmail.com>
 <Y3S9KzTE1/UQDmJl@sirena.org.uk>
 <Y3U1BJAPOJTLw/Zb@google.com>
 <Y3YcLulaebidYYsg@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3YcLulaebidYYsg@sirena.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2022 at 11:34:06AM +0000, Mark Brown wrote:
> On Wed, Nov 16, 2022 at 11:07:48AM -0800, Dmitry Torokhov wrote:
> > On Wed, Nov 16, 2022 at 10:36:27AM +0000, Mark Brown wrote:
> 
> > > How are we ensuring that people have described signals as active
> > > low/high in existing DTs, and are we positive that the signal is
> > > described as active low for all devices?  In particular if the
> > > signal is described as a reset signal then it's active high even
> > > if we want it low while the device is actually in use.
> 
> > I have been going through in-kernel DTSes and adjusting ones that are
> > incorrect. For external ones I think we should take a pragmatic approach
> > and say that if driver has last non-mechanical update in 2014 and there
> > are no users submitted to mainline since then (as this one), then it is
> > highly unlikely that devices currently using this component/codec will
> > be updated to the 6.2+ kernel even if they are still in service. And if
> > this does happen the breakage will be immediately obvious as we'll keep
> > the codec in reset state.
> 
> > But if you really want to I can add quirk(s) to gpiolib forcing this
> > line to be treated as active-low regardless of what specified in DTS.
> > This kind of negates benefit of going to gpiod though.
> 
> That doesn't address the bit about checking that the device
> describes the signal as active low in hardware - it's assuming
> that the signal is described by the device as an active low
> reset and not for example as a shutdown signal.

Huh? If we add a quirk to gpiolib to treat the signal as active low
(i.e. preserve current driver behavior - I am talking about this
particular peripheral here, not treating everything as active low of
course).

> 
> TBH I'm not thrilled about just randomly breaking ABI
> compatibility for neatness reasons, it's really not helping
> people take device tree ABI compatibility seriously.

Yes, I freely admit I do not take device tree ABI compatibility
seriously. IMO, with the exception of a few peripherals, it is a
solution in search of a problem, and we declared stability of it too
early, before we came up with reasonable rules for how resources should
be described. I strongly believe that in vast majority of cases devices
with out-of-tree DTs will not be updated to upstream kernels as this
requires significant engineering effort and vendors usually not
interested in doing that.

Thanks.

-- 
Dmitry
