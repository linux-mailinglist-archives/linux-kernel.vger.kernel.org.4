Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 812F76069F2
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 22:59:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbiJTU7M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 16:59:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbiJTU7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 16:59:10 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E91A166567;
        Thu, 20 Oct 2022 13:59:08 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id a3so1521696wrt.0;
        Thu, 20 Oct 2022 13:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AGpsFDrypTZj6oC2F6ss37kGBvTmBU+P0J4auRH3OOE=;
        b=MkybFkVbo5hduRpxo17G2JKefZ3yY/jBsrttsd4AyMofSgDGat+iKy4Jq+NpMsNXhx
         bM4QB7CpGRg/FMVzATXbqi5qYccrjKPCqOvwpxhn/RUMwdzuGcy+5YhHqso7yh/HPmuX
         pM3JurZw1Yyjta0gTlQfdKzlxBFcU6m3yLaN0ejg0eq0n2usPwJ4Qu7NFZJPjf7W7dfT
         0jBs27P0RoMgzraNYGN2TpnAJ/O0ir14qLhTRyGiOZwpfWj+kzkRSXyhWwApjzGs7aeJ
         4Pr+OGQSfLQDush8CWqKdLV74S4U2zQepOw87jixs/frlrE2YAOtLV1L5z79BaJkg4Ef
         7PBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AGpsFDrypTZj6oC2F6ss37kGBvTmBU+P0J4auRH3OOE=;
        b=K7Dw8cGLETYrfpDMPX2RVpXlDOhkPFrcLqwsXAy8NT/UrBRoBmOOnx8/bMHJg3yUsF
         P0loOJVPym/syTXd7g8nxvcrZJcD2M8X0146rN4dBSemMqJGgBuLS1wqX3Oa3cbig38P
         1lJrj0quaBRtwQWNTc2ikXaLR+or9QkHbwsMQ+sz/mcugSKb/HLPmum5iKKIJLc+A8LV
         k9v4wlvuTP4nDMJ0wqzEu8x054PBnoR3nD4peh+ia0MjuhTl8H5Q6q3AbbHwIxnE6Usv
         Ox3TMgj2za/3/IpcemwEQ7I808GG1K+gZzbxQE2lgvz4ZrhcLniqcFSfVM7i9HgYvx97
         gtHA==
X-Gm-Message-State: ACrzQf2pPx+nlIokoWISO1oJl2MVHeV3UAtgQgFBrLexQOZDUNSM0VKd
        56qNa/V40VV5OSXCjAwWlv4=
X-Google-Smtp-Source: AMsMyM52LHY7Y7D8EYa/Z9WM3B6kgtyAOfT8ZPrMamiZyoozq8aJtF5I7+mfEhksOSfZLc+PGJwwIQ==
X-Received: by 2002:a5d:63d1:0:b0:235:9aeb:e365 with SMTP id c17-20020a5d63d1000000b002359aebe365mr3988171wrw.77.1666299546606;
        Thu, 20 Oct 2022 13:59:06 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id v10-20020a05600c444a00b003c6f27d275dsm786344wmn.33.2022.10.20.13.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 13:59:06 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Even Xu <even.xu@intel.com>, linux-input@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] hid: intel-ish-hid: ishtp: remove variable rb_count
Date:   Thu, 20 Oct 2022 21:59:05 +0100
Message-Id: <20221020205905.44690-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The variable rb_count is being incremented but it
is never rb_count, it is redundant and can be removed.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/hid/intel-ish-hid/ishtp/client.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/hid/intel-ish-hid/ishtp/client.c b/drivers/hid/intel-ish-hid/ishtp/client.c
index df0a825694f5..2d92fc129ce4 100644
--- a/drivers/hid/intel-ish-hid/ishtp/client.c
+++ b/drivers/hid/intel-ish-hid/ishtp/client.c
@@ -841,7 +841,6 @@ void recv_ishtp_cl_msg(struct ishtp_device *dev,
 	unsigned char *buffer = NULL;
 	struct ishtp_cl_rb *complete_rb = NULL;
 	unsigned long	flags;
-	int	rb_count;
 
 	if (ishtp_hdr->reserved) {
 		dev_err(dev->devc, "corrupted message header.\n");
@@ -855,9 +854,7 @@ void recv_ishtp_cl_msg(struct ishtp_device *dev,
 	}
 
 	spin_lock_irqsave(&dev->read_list_spinlock, flags);
-	rb_count = -1;
 	list_for_each_entry(rb, &dev->read_list.list, list) {
-		++rb_count;
 		cl = rb->cl;
 		if (!cl || !(cl->host_client_id == ishtp_hdr->host_addr &&
 				cl->fw_client_id == ishtp_hdr->fw_addr) ||
-- 
2.37.3

