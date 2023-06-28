Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1CE8741906
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 21:49:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231156AbjF1TtI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 15:49:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbjF1TtG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 15:49:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70B8F1BE9;
        Wed, 28 Jun 2023 12:49:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 076FA61446;
        Wed, 28 Jun 2023 19:49:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BEB4C433C8;
        Wed, 28 Jun 2023 19:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687981744;
        bh=F1SDy6om5FvcGfWGnomK4jMWzXGYxk5LjwftHO75iUE=;
        h=From:To:Cc:Subject:Date:From;
        b=USQqeiQ+R5urRUVwMUdR9enMdsK+s/6hobILgsdWjPqekIX4T7xppnc0GQrmZDn2V
         RlyMrO7KvbuP3u/WmnwH+S7VX4UtNlA60bO2n/ysV2/IeozQFh9syFJc01vCQLMn4i
         lpL5aUFa8tfTDEUk/8IpYGV6dop9ohyKK9kmioOkVEgVg1mVI8Dr5JnTBcA0r9wuI+
         FY5hXuu+7tEFmudiB5/XmwP/t6YGi7UbYbbhr8ZVsoLR4E+Lc4D7cC4RYW0EkEnXtX
         f/JaxY5ProNb82XEKFCX4Y3+t7ArxCAVSsDdBJP21BksDxKT8EPS8CratwmkeHwv2n
         1GIKIaPXhpShg==
Received: from mchehab by mail.kernel.org with local (Exim 4.96)
        (envelope-from <mchehab@kernel.org>)
        id 1qEb9x-001Nj0-23;
        Wed, 28 Jun 2023 21:49:01 +0200
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     linux-media@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Zhou jie <zhoujie@nfschina.com>,
        llvm@lists.linux.dev
Subject: [PATCH] media: wl128x: fix a clang warning
Date:   Wed, 28 Jun 2023 21:48:53 +0200
Message-ID: <6badd27ebfa718d5737f517f18b29a3e0f6e43f8.1687981726.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang-16 produces this warning, which is fatal with CONFIG_WERROR:

	../drivers/media/radio/wl128x/fmdrv_common.c:1237:19: error: variable 'cmd_cnt' set but not used [-Werror,-Wunused-but-set-variable]
	        int ret, fw_len, cmd_cnt;
	                         ^
	1 error generated.

What happens is that cmd_cnt tracks the amount of firmware data packets
were transfered, which is printed only when debug is used.

Switch to use the firmware count, as the message is all about reporting
a partial firmware transfer.

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---
 drivers/media/radio/wl128x/fmdrv_common.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/media/radio/wl128x/fmdrv_common.c b/drivers/media/radio/wl128x/fmdrv_common.c
index cbd49dff6d74..b31b7ed60bbe 100644
--- a/drivers/media/radio/wl128x/fmdrv_common.c
+++ b/drivers/media/radio/wl128x/fmdrv_common.c
@@ -1234,9 +1234,8 @@ static int fm_download_firmware(struct fmdev *fmdev, const u8 *fw_name)
 	struct bts_action *action;
 	struct bts_action_delay *delay;
 	u8 *fw_data;
-	int ret, fw_len, cmd_cnt;
+	int ret, fw_len;
 
-	cmd_cnt = 0;
 	set_bit(FM_FW_DW_INPROGRESS, &fmdev->flag);
 
 	ret = request_firmware(&fw_entry, fw_name,
@@ -1272,7 +1271,6 @@ static int fm_download_firmware(struct fmdev *fmdev, const u8 *fw_name)
 			if (ret)
 				goto rel_fw;
 
-			cmd_cnt++;
 			break;
 
 		case ACTION_DELAY:	/* Delay */
@@ -1284,7 +1282,7 @@ static int fm_download_firmware(struct fmdev *fmdev, const u8 *fw_name)
 		fw_data += (sizeof(struct bts_action) + (action->size));
 		fw_len -= (sizeof(struct bts_action) + (action->size));
 	}
-	fmdbg("Firmware commands(%d) loaded to chip\n", cmd_cnt);
+	fmdbg("Transfered only %d of %d bytes of the firmware to chip\n", fw_entry->size - fw_len, fw_entry->size);
 rel_fw:
 	release_firmware(fw_entry);
 	clear_bit(FM_FW_DW_INPROGRESS, &fmdev->flag);
-- 
2.41.0

