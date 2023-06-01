Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43EEB71F4D0
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 23:34:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232754AbjFAVez (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 17:34:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232986AbjFAVev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 17:34:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FF7519D;
        Thu,  1 Jun 2023 14:34:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0641E649ED;
        Thu,  1 Jun 2023 21:34:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF33EC433EF;
        Thu,  1 Jun 2023 21:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685655284;
        bh=AbHfTr5p4zXcglalc0/KHf9eaa46MDixzs0334/nXsk=;
        h=From:To:Cc:Subject:Date:From;
        b=VW0jA7Mwu5T2MtFg9L0vQu1b9YVdZekxH9ULe+m0nXatTeu6X8r9m9FiG1BsE+FOl
         WdZ7GxIsHpuUSnndQ+1LYlfe/nXD5SbyLxtMPQE5d91G+su3YyMruiUFSBSxgCe+Pp
         cIvF7mNE3Ti4ZHkgj78V0jgXWnM9LcPXckXXESitFhUXzBrh8qEWC6Sg4F5IFfMD8L
         3KbQp1gKVzLCMZ22wEOo+ANXEj0SwHIKsN3d9RXq0IcAwFzH5P2h1LIyitVwu99MoP
         YWwj13wlayXxtVOBkxkM25bHaBNE7EQ/bexf19RG+LA3tDgdxbYiq8uIehYldPm+SI
         dNCn+CP0KKWIA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Yauhen Kharuzhy <jekhor@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] leds: cht-wcove: mark cht_wc_leds_brightness_get static
Date:   Thu,  1 Jun 2023 23:34:33 +0200
Message-Id: <20230601213439.3398794-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

This was apparently made global but is not called from anywhere else:

drivers/leds/leds-cht-wcove.c:144:21: error: no previous prototype for 'cht_wc_leds_brightness_get' [-Werror=missing-prototypes]

Fixes: 047da762b9a93 ("leds: Add Intel Cherry Trail Whiskey Cove PMIC LED driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/leds/leds-cht-wcove.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/leds/leds-cht-wcove.c b/drivers/leds/leds-cht-wcove.c
index 0cfebee989107..0a5c30e5ed5d4 100644
--- a/drivers/leds/leds-cht-wcove.c
+++ b/drivers/leds/leds-cht-wcove.c
@@ -141,7 +141,7 @@ static int cht_wc_leds_brightness_set(struct led_classdev *cdev,
 	return ret;
 }
 
-enum led_brightness cht_wc_leds_brightness_get(struct led_classdev *cdev)
+static enum led_brightness cht_wc_leds_brightness_get(struct led_classdev *cdev)
 {
 	struct cht_wc_led *led = container_of(cdev, struct cht_wc_led, cdev);
 	unsigned int val;
-- 
2.39.2

