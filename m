Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07103616C17
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 19:26:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbiKBS0S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 14:26:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231205AbiKBS0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 14:26:10 -0400
Received: from msg-1.mailo.com (msg-1.mailo.com [213.182.54.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDFE521820
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 11:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1667413556; bh=3rsRCttLKAT5Ls6ZOU7vfsBpZ4yDty9OCgC/PPt1JXE=;
        h=X-EA-Auth:Date:From:To:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=VHo226tcGq6UkmmWik3FzNW7FW9WJbOzLQlCk+VAlngP8Tp64JJ/2aRF5H2+92d0c
         3NfJCVoiHE1iinESUU0q9/f3HcypAD0ZcinH7TFqLvgbiC3XK+VNySHBO8uCPCWXzv
         gReUxirIfkWPIkSNGWmXHEAhksERW8UqilzYzVGk=
Received: by b-6.in.mailobj.net [192.168.90.16] with ESMTP
        via [213.182.55.206]
        Wed,  2 Nov 2022 19:25:56 +0100 (CET)
X-EA-Auth: 7Y3vbvCxeKCXYF2dtoftR5y3E0Kq3g1f7d/kmFDKtPxssrWWzjpYDtCX9eq9wTBkViFvAUaJC4feBDOKJPlqNt2PoPHZRaRK
Date:   Wed, 2 Nov 2022 23:55:52 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     outreachy@lists.linux.dev, Sven Van Asbroeck <TheSven73@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: fieldbus: convert snprintf to scnprintf
Message-ID: <Y2K2MD7+WBu4QouU@qemulion>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is recommended to use scnprintf instead of snprintf to accurately
return the size of the encoded data. Following article [1] has details
on the reason for this kernel level migration. This issue was identified
using coccicheck.

[1] https://lwn.net/Articles/69419/

Signed-off-by: Deepak R Varma <drv@mailo.com>
---
 drivers/staging/fieldbus/dev_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/fieldbus/dev_core.c b/drivers/staging/fieldbus/dev_core.c
index 5aab734606ea..d51f2b02d5e6 100644
--- a/drivers/staging/fieldbus/dev_core.c
+++ b/drivers/staging/fieldbus/dev_core.c
@@ -70,7 +70,7 @@ static ssize_t card_name_show(struct device *dev, struct device_attribute *attr,
 	 * card_name was provided by child driver, could potentially be long.
 	 * protect against buffer overrun.
 	 */
-	return snprintf(buf, PAGE_SIZE, "%s\n", fb->card_name);
+	return scnprintf(buf, PAGE_SIZE, "%s\n", fb->card_name);
 }
 static DEVICE_ATTR_RO(card_name);

--
2.34.1



