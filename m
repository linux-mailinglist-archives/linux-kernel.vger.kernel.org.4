Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2D986472A9
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 16:15:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbiLHPPt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 10:15:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbiLHPOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 10:14:39 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B9F7AD339
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 07:14:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 483A5B823DC
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 15:14:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46167C43151;
        Thu,  8 Dec 2022 15:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670512467;
        bh=HoYALqjvqnCPCS7thHq8D4m998sGCS3WKDk+gLoFYak=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aGFduoip26eis6oUkuGUmR4uyB1MPqQ4JOC1XmvUMBCcOrVk+GfuqsOawYVIquHkT
         ynubygIxLnbtbJjN1ZmIbBix/PJlY2bHJAhbK2DOirLT2Prz9NaCk3SCNxWPHZb6W4
         XJH2yXA1AuTp3FsmbHdgcpuvdRATbK0TKbVpOtZlTcjf84ZGEKuQC8wutt1kl/vXFo
         6dntuvl1rixXT86/d/SL7+asfWs9liyOcYbSAF4pTYHOF8RK367NQVrU/nlm34QE5e
         Vu8I6xqFRFb2MvTQ14CVCIqqKrDxcaWapmKvpeEYEKjvqJ/0qSUys0Kp1C2eDxjHX0
         iXsW82VyOXQIQ==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Tomer Tayar <ttayar@habana.ai>
Subject: [PATCH 24/26] habanalabs: put fences in case of unexpected wait status
Date:   Thu,  8 Dec 2022 17:13:48 +0200
Message-Id: <20221208151350.1833823-24-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221208151350.1833823-1-ogabbay@kernel.org>
References: <20221208151350.1833823-1-ogabbay@kernel.org>
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

Need to put fences even if an unexpected status value is received while
waiting for a fence.

Signed-off-by: Tomer Tayar <ttayar@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/command_submission.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/habanalabs/common/command_submission.c b/drivers/misc/habanalabs/common/command_submission.c
index 0ec8cdcbb1f5..1543ef993f8e 100644
--- a/drivers/misc/habanalabs/common/command_submission.c
+++ b/drivers/misc/habanalabs/common/command_submission.c
@@ -2722,7 +2722,8 @@ static int hl_cs_poll_fences(struct multi_cs_data *mcs_data, struct multi_cs_com
 			break;
 		default:
 			dev_err(hdev->dev, "Invalid fence status\n");
-			return -EINVAL;
+			rc = -EINVAL;
+			break;
 		}
 
 	}
-- 
2.25.1

