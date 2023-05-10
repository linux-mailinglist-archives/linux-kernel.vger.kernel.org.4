Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC7E46FE1D2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 17:48:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237362AbjEJPsM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 11:48:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbjEJPsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 11:48:08 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6CF494;
        Wed, 10 May 2023 08:48:05 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 70F2CC0008;
        Wed, 10 May 2023 15:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1683733684;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=WoIOANVWdL0y5NcqhIK3a/G8U5mkm1Ghbop7k5ySOhk=;
        b=Rd3d4ufks9H8+MFvwd9uWILnq9BHpac5TSVlyaIfx5FiU+NOdCVUKjT0oc43j2oZegyNzn
        BXnSqpoCr02fjgy25wvCFPaWqaRviURasbmfeDG0aK0GymSBFrrPX5BuKixDem2XayZoF8
        e5h19iXJm1R87Udx6qlnaYHq9O3zX7RGmXDndSidb3ecZl9f9L5fm2PLqz9JRK1GMG7sZL
        LaSGFiqdSTwBRmLAIIJe95eA+Du/FtrlAeKDgo/6wW+jIf3/VJpqbAc+CKjlFZOwqn5W7G
        FfVITgIQ8gYiM5kpYG6EWtadeSaHh2qReOLzrOm02Aoov7drJtk/GPiqPEfcQA==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        devicetree@vger.kernel.org, <linux-kernel@vger.kernel.org>,
        linux-tegra@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 0/5] of: More 'device' vs. 'module' cleanups
Date:   Wed, 10 May 2023 17:47:58 +0200
Message-Id: <20230510154803.189096-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

As part of a previous series, Rob suggested that keeping too much logic
in of/device.c was backward and would benefit from a gradual cleanup
with the hope some day to move the remaining helpers into inline
functions wrapping the proper of_*() methods.

Link: https://lore.kernel.org/lkml/CAL_JsqJE43qfYzHUuCJsbaPPBTbYX05Q7FFmPTjPFZ3Dmz_mXg@mail.gmail.com/

A few of these "conversions" happened in the series I was originally
working on. At this time I actually wrote a few other changes,
completely unrelated to my original series, but still following Rob's
cleanup idea: here they are.

Link: https://lore.kernel.org/lkml/20230307165359.225361-1-miquel.raynal@bootlin.com/

The last step of this series is to actually remove a copy of one of
these helpers which I think is not needed. This drivers/gpu/ patch
depends on the previous changes.

Thanks, Miquèl

Miquel Raynal (5):
  of: module: Mutate of_device_modalias() into two helpers
  of: module: Mutate of_device_uevent() into two helpers
  of: module: Mutate of_device_uevent_modalias() into two helpers
  of: module: Export of_uevent()
  gpu: host1x: Stop open-coding of_device_uevent()

 drivers/gpu/host1x/bus.c  | 31 +++-----------
 drivers/of/device.c       | 90 ---------------------------------------
 drivers/of/module.c       | 82 +++++++++++++++++++++++++++++++++++
 include/linux/of.h        | 21 +++++++++
 include/linux/of_device.h | 39 ++++++++++++++---
 5 files changed, 141 insertions(+), 122 deletions(-)

-- 
2.34.1

