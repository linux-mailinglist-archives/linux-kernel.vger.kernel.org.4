Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 919066DEC12
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 08:48:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbjDLGsi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 02:48:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjDLGsg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 02:48:36 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7A804C1B;
        Tue, 11 Apr 2023 23:48:35 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id E75E568AA6; Wed, 12 Apr 2023 08:48:31 +0200 (CEST)
Date:   Wed, 12 Apr 2023 08:48:31 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Christoph Hellwig <hch@lst.de>, Guenter Roeck <linux@roeck-us.net>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH] nvme: host: hwmon: constify pointers to
 hwmon_channel_info
Message-ID: <20230412064831.GA20380@lst.de>
References: <20230407145845.79557-1-krzysztof.kozlowski@linaro.org> <20230411060900.GD18527@lst.de> <20230411061012.GA18624@lst.de> <0d4d27e6-02e0-09e3-8e99-18b40880961c@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0d4d27e6-02e0-09e3-8e99-18b40880961c@linaro.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 11, 2023 at 08:11:41AM +0200, Krzysztof Kozlowski wrote:
> The dependency was described in the patch. Guenter also provided
> a stable branch with the dependency:

Ok.  See below for the version with the whitespace and Subject fix I'd like
to see.  With that:

Acked-by: Christoph Hellwig <hch@lst.de>

---
From 882410442b1bb5730f3eec29d8dc9ccda5e92cdb Mon Sep 17 00:00:00 2001
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Fri, 7 Apr 2023 16:58:45 +0200
Subject: nvme-hwmon: constify pointers to hwmon_channel_info

Statically allocated array of pointed to hwmon_channel_info can be made
const for safety.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/nvme/host/hwmon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/hwmon.c b/drivers/nvme/host/hwmon.c
index 9e6e56c20ec993..6aa153f3178a60 100644
--- a/drivers/nvme/host/hwmon.c
+++ b/drivers/nvme/host/hwmon.c
@@ -185,7 +185,7 @@ static umode_t nvme_hwmon_is_visible(const void *_data,
 	return 0;
 }
 
-static const struct hwmon_channel_info *nvme_hwmon_info[] = {
+static const struct hwmon_channel_info *const nvme_hwmon_info[] = {
 	HWMON_CHANNEL_INFO(chip, HWMON_C_REGISTER_TZ),
 	HWMON_CHANNEL_INFO(temp,
 			   HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_MIN |
-- 
2.39.2

