Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A965673BA7
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 15:25:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbjASOZu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 09:25:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbjASOZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 09:25:47 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C0F61BC7;
        Thu, 19 Jan 2023 06:25:46 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id d2so2022242wrp.8;
        Thu, 19 Jan 2023 06:25:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KjsZya+QHJjprUyI8l0iTCJWloAUubwO/7pn5KMVxco=;
        b=ar8Y5jds9GnCb1bu9DJlG8T+9M+euQ3P5Pu6wNsuF9/BaX1fRYVPzQ7B2JdXHWJ3dx
         jJBVGU0BUXV4y8nCmJF+RLL7OyT+kIJjeC8aN2Y8OIjJoVZMxnvnOUeSzAyL4uGFWUbC
         eHLU+nygimgKouEHjd6736nsBkRFYhWSTAgCfuX4PxBBulOya7uXBLma/0Xld25w7bh0
         +1ymYyPEV15P4mapiPWA6b17HdvXzp6qG0dqm18xTcFLjKIHl0rYU0S05H+AXxnPupeZ
         mZ9EzJniQwpnEisWTjPN3ei4BseZCp1PV1/ui9dRQUPC6HbG9XHtlLvDWaFJDhjtRhSh
         5mbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KjsZya+QHJjprUyI8l0iTCJWloAUubwO/7pn5KMVxco=;
        b=P9Jk4QON2jMni9YRZssawJzgtDOJg3FCRcEQdnfGMkM6GKFgVcVjNS8VZggPYQ7bdl
         nJvpiSA0/03D2dbdZ9SxS3B2oybHE06UrtczgooRZ03PdSJe71rBcWjrdxQYSI2wi8cf
         vbqpMRRDVBqIBCn1tzl3ojtvvg6F/volWTuoBustORGwiMhiwHcaS7/ic5KHm6JqjEwQ
         1Kir6tI+UlUR2tT/G2vaci5oZbVhZEqcheFIYT8T4dCe0SK0FSQqRmstUlKtV5otDIOG
         sQm+KWwB+hGj/glhxfZTgDrKEMFc9ZJZ58LKsnR30T5vZ2niYfbPOV8fFjyEb3OUlKje
         xypA==
X-Gm-Message-State: AFqh2krfciSCSMNhHxDrlutABysEIgG/TtmUY9clpm1BIlQz75xL7LDY
        10jsVAXNRj+dTH3Fim/iGcQ=
X-Google-Smtp-Source: AMrXdXtDiP7c/DabjOn7bKOH7ivh1JfCmDp+cs2iDNvgeWytgRdBmlEkHJc7fFHINSKci4IxJ/rbnA==
X-Received: by 2002:a5d:5e85:0:b0:2b6:2eb3:82a1 with SMTP id ck5-20020a5d5e85000000b002b62eb382a1mr6224673wrb.67.1674138344975;
        Thu, 19 Jan 2023 06:25:44 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id e1-20020a5d65c1000000b002be15ee1377sm7953480wrw.22.2023.01.19.06.25.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 06:25:44 -0800 (PST)
Date:   Thu, 19 Jan 2023 17:25:41 +0300
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
Message-ID: <Y8lS5eBliYw5EHBb@kadam>
References: <20230118115810.21979-1-umang.jain@ideasonboard.com>
 <b1a26368-3753-0d32-434b-e220dd9c06b4@i2se.com>
 <CAMEGJJ1=dix7gWvV3Jxef-M-ExFZRTASQCr+6sn_dGsEQ=deYQ@mail.gmail.com>
 <Y8lHqd9FlxiXTLuW@kroah.com>
 <CAMEGJJ1oZ9XFw0609PrEABAgDwvapbc3hG4hJ=vBekUOepdiWw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMEGJJ1oZ9XFw0609PrEABAgDwvapbc3hG4hJ=vBekUOepdiWw@mail.gmail.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2023 at 01:47:44PM +0000, Phil Elwell wrote:
> > > I understand the desire to remove the custom logging. I don't welcome
> > > the loss of flexibility that comes with such a strategy
> >
> > What "loss of flexibility"?  You now have access to the full dynamic
> > debugging facilities that all of the rest of the kernel has.  What is
> > lacking?
> 
> Perhaps I've missed something, either in this patch set or the kernel
> as a whole, but how is one supposed to set different logging levels on
> different facilities within a driver/module, or even for the module as
> a whole?

Yeah.  You will be still able to do that and more besides after the
transition.  Cleaning this up makes the code better in every way.

Documentation/admin-guide/dynamic-debug-howto.rst

regards,
dan carpenter

