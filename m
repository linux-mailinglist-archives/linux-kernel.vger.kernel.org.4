Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DA2C625952
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 12:28:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233146AbiKKL2C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 06:28:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232004AbiKKL2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 06:28:01 -0500
Received: from dhl.lxnav.com (dhl.lxnav.com [IPv6:2a01:4f8:c010:2f07::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D09263150
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 03:28:00 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1CE4D4070A;
        Fri, 11 Nov 2022 12:27:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lxnav.com; s=dhl;
        t=1668166075; h=from:subject:date:message-id:to:mime-version:
         content-transfer-encoding; bh=ZVhcBWv5g++vNVOshFC8d1giINTc5zv0mibtU5uzEW4=;
        b=FkdTYr2rkOHQ4Dd4bwx5IJz4B5YoLsUtiapRqvDRTUp4s1+X9+0ENFeBjiNBAGalqatIf5
        Xo+PiMQ1DdJb7gaLs9Vh+1TuHk1JaNUGqdkAuxSjJTCxuSiJ8g7jJoqcFVNlbhnifR///B
        4Td7kOzm1yHERrGhRZCBm8itFfCdUujdd7gsYF7ioE2lwgjjkML187OBjwR+Jn/cBFo4Mu
        LXFk4tkHSZxAgoyJFWlzOXGsn9tx3Yi2F0Y97obye4qGDMME1nUmMkeMtcgKaTQ5GlodIS
        odWgrZ8P6WeVCpegYfpEv9CfKH9cCkBcoge4raFhRJmvf7pD6gcOu7JslLVxZw==
From:   Mitja Spes <mitja@lxnav.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Mitja Spes <mitja@lxnav.com>,
        Angelo Compagnucci <angelo.compagnucci@gmail.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] iio: adc: mcp3422 improvements
Date:   Fri, 11 Nov 2022 12:26:52 +0100
Message-Id: <20221111112657.1521307-1-mitja@lxnav.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes:
* iio: adc: mcp3422: fix scale read bug
  Scale was always returned for the last read input instead of the specified
  channel.

Improvements:
* iio: adc: mcp3422: allow setting gain and sampling per channel
  Sampling was the same for all channels. This patch adds the ability to select
  different gain and sampling per channel. They can be set together via scale
  attribute.
  Sampling can be set also via the standalone attribute which is now per
  channel. This might be a breaking change for some.

* iio: adc: mcp3422: add hardware gain attribute
  Setting via scale is cumbersome. This patch just adds a concise way to set
  the gain, since sampling can already be set separately.

* iio: adc: mcp3422: reduce sleep for fast sampling rates
  msleep can produce a delay which is fi. 30ms off the mark. This patch uses
  usleep_range for the higher sampling rates.

Mitja Spes (4):
  iio: adc: mcp3422: fix scale read bug
  iio: adc: mcp3422: allow setting gain and sampling per channel
  iio: adc: mcp3422: add hardware gain attribute
  iio: adc: mcp3422: reduce sleep for fast sampling rates

 drivers/iio/adc/mcp3422.c | 161 ++++++++++++++++++++++++--------------
 1 file changed, 103 insertions(+), 58 deletions(-)

-- 
2.34.1

