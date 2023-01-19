Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BF4A673C4F
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 15:40:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231604AbjASOjt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 09:39:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231515AbjASOjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 09:39:42 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09E668298E;
        Thu, 19 Jan 2023 06:38:01 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id n7so2076257wrx.5;
        Thu, 19 Jan 2023 06:38:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GD0a/ka5+MJwmasza9LWV0qmM9V0aVs/dU+fSwzbrLs=;
        b=bQEZCtdRMYcijshT0y2Qu43vkvvkxnxFwy1oJhQCYKekBgxduc4PibPd41KYQ4DIlk
         r36PazF7qhmaQ/BJkKR0r/pA4X/4FSq3jf7rlUlUfMW7edWvRHJBHv0kUNUmXL50ivUI
         daB4uoFA40zs8ffS7cHsMu0w5LQUUrZvR+lq+C3EULFL5NugbTV2ey3ubJRZmC1unaO1
         VUh8MjbKZHEKtzBc0UF8AXYnpQE3c9EhcLMKjFCQ5sNvCd2dB+32dnHVa1GYHjjdod9X
         z5WwPPK2NwjfBbtV9/lAkTJ00PRnU5dLTD4avwUpEBqtxinsS8SBcs3s0vmSS6BWdjB9
         DqQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GD0a/ka5+MJwmasza9LWV0qmM9V0aVs/dU+fSwzbrLs=;
        b=zcWQhD4kT+qqI04q6NP6jKtzodsP6+MQ1vmxdsmmRzLcqd1j8JRflfdYm8CHGDaxik
         9MWZpah6skG+FPN6qxIO68544zDVI94HLkzhx2V/kAe5RKFOTrCrA5pdr1QzWtjbNBrU
         ls1l75hKyiqqheH73D81saCR4DQEFAwg4GlPtGQAj9+R7/By1BMjDQh0itBv/2fLIYiP
         nkmu/XWrSGyzLaJCafqAy9uVCAz0POs+HVIQWgRCU2sLdGG+hH6pOFJyRaxVlv1mx6bz
         5fhamf5gJCm9bhIwkU2YpcihKefIsdFrKrB6jxG08sYouWUYc9db5npwEX6cHpyPqDQm
         Q3Zg==
X-Gm-Message-State: AFqh2kqS3czrX2bh7x1E1HYQSH8iWDxY5cMXw1Wx3rz3E0tAu4gmInKZ
        dFV4ilkPUnqu+I1BE9joEnY=
X-Google-Smtp-Source: AMrXdXs/MbE7VqWd1vWjhpRw1JIECqYAGxrvtnGpGJTppbIZ3SSFqmdLDloCNBl/0j/F8ueulrWNqA==
X-Received: by 2002:a5d:428e:0:b0:2bc:8339:1fcc with SMTP id k14-20020a5d428e000000b002bc83391fccmr10333611wrq.58.1674139079212;
        Thu, 19 Jan 2023 06:37:59 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id q15-20020adfab0f000000b002bde7999cd6sm16061235wrc.61.2023.01.19.06.37.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 06:37:58 -0800 (PST)
Date:   Thu, 19 Jan 2023 17:37:48 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Phil Elwell <phil@raspberrypi.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Umang Jain <umang.jain@ideasonboard.com>,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Adrien Thierry <athierry@redhat.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/4] Drop custom logging
Message-ID: <Y8lVvHMIYeSOLM5q@kadam>
References: <20230118115810.21979-1-umang.jain@ideasonboard.com>
 <b1a26368-3753-0d32-434b-e220dd9c06b4@i2se.com>
 <CAMEGJJ1=dix7gWvV3Jxef-M-ExFZRTASQCr+6sn_dGsEQ=deYQ@mail.gmail.com>
 <Y8lHqd9FlxiXTLuW@kroah.com>
 <CAMEGJJ1oZ9XFw0609PrEABAgDwvapbc3hG4hJ=vBekUOepdiWw@mail.gmail.com>
 <Y8lS5eBliYw5EHBb@kadam>
 <CAMEGJJ2b1KFQY1m1eTcvf8_kGBBTjzrBD2i_M2uR+6v4gEcbVQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMEGJJ2b1KFQY1m1eTcvf8_kGBBTjzrBD2i_M2uR+6v4gEcbVQ@mail.gmail.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2023 at 02:31:50PM +0000, Phil Elwell wrote:
> On Thu, 19 Jan 2023 at 14:25, Dan Carpenter <error27@gmail.com> wrote:
> >
> > On Thu, Jan 19, 2023 at 01:47:44PM +0000, Phil Elwell wrote:
> > > > > I understand the desire to remove the custom logging. I don't welcome
> > > > > the loss of flexibility that comes with such a strategy
> > > >
> > > > What "loss of flexibility"?  You now have access to the full dynamic
> > > > debugging facilities that all of the rest of the kernel has.  What is
> > > > lacking?
> > >
> > > Perhaps I've missed something, either in this patch set or the kernel
> > > as a whole, but how is one supposed to set different logging levels on
> > > different facilities within a driver/module, or even for the module as
> > > a whole?
> >
> > Yeah.  You will be still able to do that and more besides after the
> > transition.  Cleaning this up makes the code better in every way.
> >
> > Documentation/admin-guide/dynamic-debug-howto.rst
> 
> Are you saying this patch set gets us to that point?

Yes.  The patch has some issues, but yes.

regards,
dan carpenter
