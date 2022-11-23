Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1407636289
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 15:58:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235969AbiKWO6Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 09:58:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238244AbiKWO6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 09:58:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 796D7E0BF
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 06:58:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 472C2B8201C
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 14:58:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15352C433C1;
        Wed, 23 Nov 2022 14:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669215486;
        bh=OWR6iQytWgRE2Knz69g3vKSi0RhDkuWPDftNikbLzmA=;
        h=From:To:Cc:Subject:Date:From;
        b=E72hcwJoIxALhfnaBX0nX39qCx5xqFH6BDtgXf/do72yDafOXJTSglBIJ9s95QxdA
         iup9Bpkht28lSoiJt9f2XQcqEK6EjmnwG364udouhJlTQ6CE37eKo9W7+zxcMT1rUw
         7Q1/kYISIOOPd1iq13eW3hVSq6Px4SGrGMTV6OQkxccp+DnDlSb763VbrrMNOYz69n
         JZFazwZz1oxbuTYtMaD3hZIJXqwvQcR2f6BGe67ekwTfd3PIbAoeeWgLOCjYJwZbXn
         bf0NdsELhs/itSAeHzDJVEv8dKmsCTWoZdWRfV8Ecrvd1iFMgGyNxvfrISxxC0cZHM
         Dh+JOe/gQfK/g==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Tomer Tayar <ttayar@habana.ai>
Subject: [PATCH 1/8] habanalabs: fix rc when new CPUCP opcodes are not supported
Date:   Wed, 23 Nov 2022 16:57:54 +0200
Message-Id: <20221123145801.542029-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tomer Tayar <ttayar@habana.ai>

When the new CPUCP opcodes are not supported and a CPUCP packet fails,
the return value is the F/W error resposone which is a positive value.
If this packet is sent from IOCTL and the positive value is used, the
ICOTL will not be considered as unsuccessful.

Signed-off-by: Tomer Tayar <ttayar@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/firmware_if.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/misc/habanalabs/common/firmware_if.c b/drivers/misc/habanalabs/common/firmware_if.c
index c0909d76d6eb..cf8147e43833 100644
--- a/drivers/misc/habanalabs/common/firmware_if.c
+++ b/drivers/misc/habanalabs/common/firmware_if.c
@@ -324,6 +324,7 @@ int hl_fw_send_cpu_message(struct hl_device *hdev, u32 hw_queue_id, u32 *msg,
 
 		if (!prop->supports_advanced_cpucp_rc) {
 			dev_dbg(hdev->dev, "F/W ERROR %d for CPU packet %d\n", rc, opcode);
+			rc = -EIO;
 			goto scrub_descriptor;
 		}
 
-- 
2.25.1

