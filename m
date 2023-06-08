Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E46CF72877B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 20:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234469AbjFHStK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 14:49:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233710AbjFHStI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 14:49:08 -0400
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB0121FDF;
        Thu,  8 Jun 2023 11:49:06 -0700 (PDT)
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-777a4926555so37979639f.0;
        Thu, 08 Jun 2023 11:49:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686250146; x=1688842146;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jIKmCroANEKPOHzkl2knynvAkLLXALNRwLAU/LLLoFY=;
        b=HN4WVSgpUIux3s1+jg7G9Th0hEPUMa3fYDXz1HFHbzIPG7yyyuoneMc3qF4mLbwg/Q
         iwL81yBa5Z0U2yDZ0U/fP5m2rjO11vSbADtrCXkaX5nYjtIo5k8dgDnYRxMUogUspDpI
         hBV4rcIAPVMHMwj4EkDBn0flk5YGb9grETgwwYmVPFiuHFLvE1GgzBMCln7km1x81Xve
         ksnx3fHrSi9D9dtLdjYH1kM5sN/oC9S3NjoHGCqDpr7mZWE7223gr19g5JJUj4llZP+8
         pGyAyTpAXijeZOS6qXGjDoeb08qRis+xMeJH9vmr0d1f6jCE35WoUnCvBTcSfkYV1qky
         mxyg==
X-Gm-Message-State: AC+VfDwcycTB51NuUx00EA5lzGItmKBHdNnBn8lANPanVSdKmWNLG9Ac
        5X/6VSp0VmigWQWFLGHUFTjNrqW4XA==
X-Google-Smtp-Source: ACHHUZ40+TuJlTCIi/OKeN/bZ+QJqRylgyQjhG2PfjnerEU6twqk6MXkiUDgygcnfLixbmWfBb9FXQ==
X-Received: by 2002:a5e:8907:0:b0:777:a6a7:e83d with SMTP id k7-20020a5e8907000000b00777a6a7e83dmr1785128ioj.4.1686250146061;
        Thu, 08 Jun 2023 11:49:06 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id u13-20020a6be90d000000b0076c750dc780sm519421iof.29.2023.06.08.11.49.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 11:49:05 -0700 (PDT)
Received: (nullmailer pid 3220171 invoked by uid 1000);
        Thu, 08 Jun 2023 18:49:03 -0000
Date:   Thu, 8 Jun 2023 12:49:03 -0600
From:   Rob Herring <robh@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mikko Perttunen <mperttunen@nvidia.com>
Subject: Re: [PATCH 0/5] of: More 'device' vs. 'module' cleanups
Message-ID: <20230608184903.GA3200973-robh@kernel.org>
References: <20230510154803.189096-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230510154803.189096-1-miquel.raynal@bootlin.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 10, 2023 at 05:47:58PM +0200, Miquel Raynal wrote:
> Hello,
> 
> As part of a previous series, Rob suggested that keeping too much logic
> in of/device.c was backward and would benefit from a gradual cleanup
> with the hope some day to move the remaining helpers into inline
> functions wrapping the proper of_*() methods.

Where I'm at on device.c is it should be functions that bus 
implementations need. I have a ton of tree wide changes to disentangle 
of_device.h and of_platform.h. Some of that landed in 6.4.

uevents are pretty much tied to struct device and the bus, so I don't 
think moving these parts to module.c makes sense unless there is a need 
for the functionality without a struct device. 

Also, perhaps we want to make module.c configurable?:

obj-$(CONFIG_MODULE) += module.o

The uevent stuff is certainly independent of module support.

> Link: https://lore.kernel.org/lkml/CAL_JsqJE43qfYzHUuCJsbaPPBTbYX05Q7FFmPTjPFZ3Dmz_mXg@mail.gmail.com/
> 
> A few of these "conversions" happened in the series I was originally
> working on. At this time I actually wrote a few other changes,
> completely unrelated to my original series, but still following Rob's
> cleanup idea: here they are.
> 
> Link: https://lore.kernel.org/lkml/20230307165359.225361-1-miquel.raynal@bootlin.com/
> 
> The last step of this series is to actually remove a copy of one of
> these helpers which I think is not needed. This drivers/gpu/ patch
> depends on the previous changes.
> 
> Thanks, Miquèl
> 
> Miquel Raynal (5):
>   of: module: Mutate of_device_modalias() into two helpers
>   of: module: Mutate of_device_uevent() into two helpers
>   of: module: Mutate of_device_uevent_modalias() into two helpers
>   of: module: Export of_uevent()
>   gpu: host1x: Stop open-coding of_device_uevent()

This last patch is certainly worthwhile doing.

Rob
