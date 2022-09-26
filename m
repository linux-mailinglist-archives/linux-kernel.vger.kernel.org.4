Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93FFC5EB383
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 23:48:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbiIZVsi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 17:48:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbiIZVs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 17:48:29 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 017B2A6ADE;
        Mon, 26 Sep 2022 14:48:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 6DB68CE13C2;
        Mon, 26 Sep 2022 21:48:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B5ACC433D6;
        Mon, 26 Sep 2022 21:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664228905;
        bh=6W0fTeqRvfZnXUSIy2HmwaotV8quNId5t2aiRo7yB4o=;
        h=Date:From:To:Cc:Subject:From;
        b=IAMPRMpxF9lO2m+gOdRH1PFJCIdOlIer2cgOdeuDYjBvSpHIU91+gOygNyaH9XPQf
         k2R2pgi+tF9AbQncVVy3OzTAZ6amCRyZy1wrA+PGymZ1pPKlPefV1k1tr/ZQikTs97
         k9d0LaHckKkPVfp/THqd42E1Op1kMg36WCV33wpZV2py1MPAWlbFLJV7fDtGBgkT6W
         sKpxfYoZYegc3g/lbZ2ZT3sDZzuBMulq1iTUsJli2TDy7M9HdGFnrAoVpFH7xFcR60
         epAOrBn+UDbQD7LGfAxeiGLyqDiyubL8Z3cMABErGATuUKICwXVR058Q8x2hm5IOiP
         WbNCp/8rZpn7g==
Date:   Mon, 26 Sep 2022 16:48:21 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH][next] Input: applespi - replace zero-length array with
 DECLARE_FLEX_ARRAY() helper
Message-ID: <YzIeJeqU73G+UI8g@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Zero-length arrays are deprecated and we are moving towards adopting
C99 flexible-array members, instead. So, replace zero-length arrays
declarations in anonymous union with the new DECLARE_FLEX_ARRAY()
helper macro.

This helper allows for flexible-array members in unions.

Link: https://github.com/KSPP/linux/issues/193
Link: https://github.com/KSPP/linux/issues/219
Link: https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/input/keyboard/applespi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/keyboard/applespi.c b/drivers/input/keyboard/applespi.c
index fab5473ae5da..91a9810f6980 100644
--- a/drivers/input/keyboard/applespi.c
+++ b/drivers/input/keyboard/applespi.c
@@ -311,7 +311,7 @@ struct message {
 		struct command_protocol_mt_init	init_mt_command;
 		struct command_protocol_capsl	capsl_command;
 		struct command_protocol_bl	bl_command;
-		u8				data[0];
+		DECLARE_FLEX_ARRAY(u8, 		data);
 	};
 };
 
-- 
2.34.1

