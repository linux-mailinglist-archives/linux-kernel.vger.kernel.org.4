Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6266362F36B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 12:15:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241649AbiKRLPb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 06:15:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241421AbiKRLP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 06:15:28 -0500
Received: from mx.swemel.ru (mx.swemel.ru [95.143.211.150])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E893761528
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 03:15:25 -0800 (PST)
From:   Denis Arefev <arefev@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
        t=1668770123;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=oJ+C4azwrz0T1Xq/DoyYfvD0U7Rp9/tHMKhuIZvRgnw=;
        b=UXv93xb3Ze7gwRU/niYHPo3H8MG295UqhEN+zk73xSRUqM4ciw45FZo1nKtqpHh2Mrc7PH
        ZdievLhBH4bgiNb6TJQfqxrW2fw//08XMDpZHa6QtTe2f36gylCDqp1OmZDUvT40AtTbI6
        RQhB8KS7LvQMYv8ILX/jQ56hazsUb+Y=
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org, trufanov@swemel.ru, vfh@swemel.ru
Subject: [PATCH] staging: rts5208: Added value check
Date:   Fri, 18 Nov 2022 14:15:23 +0300
Message-Id: <20221118111523.123463-1-arefev@swemel.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added value check.
Return value of a function 'ms_set_rw_reg_addr'
called at ms.c:1770 is not checked,
but it is usually checked for this function

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Denis Arefev <arefev@swemel.ru>
---
 drivers/staging/rts5208/ms.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/staging/rts5208/ms.c b/drivers/staging/rts5208/ms.c
index 9001570a8c94..e884ee5da317 100644
--- a/drivers/staging/rts5208/ms.c
+++ b/drivers/staging/rts5208/ms.c
@@ -1769,6 +1769,8 @@ static int ms_copy_page(struct rtsx_chip *chip, u16 old_blk, u16 new_blk,
 
 		retval = ms_set_rw_reg_addr(chip, OVERWRITE_FLAG, MS_EXTRA_SIZE,
 					    SYSTEM_PARAM, (6 + MS_EXTRA_SIZE));
+		if (retval != STATUS_SUCCESS)
+			return STATUS_FAIL;
 
 		ms_set_err_code(chip, MS_NO_ERROR);
 
-- 
2.25.1

