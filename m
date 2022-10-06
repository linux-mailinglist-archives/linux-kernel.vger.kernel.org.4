Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6885B5F6283
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 10:24:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231225AbiJFIX4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 04:23:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231163AbiJFIX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 04:23:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7AA08FD41
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 01:23:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1B5776188C
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 08:23:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A68E8C433B5;
        Thu,  6 Oct 2022 08:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665044603;
        bh=2Gfuxmw18c9OLxb627xsfDLqv9C4xibq9Hp/mW8RsXw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c+esqQQlPJ+oPf4IxQ6Q2HFtZO7Ba+0RYni1X8ddhujQWmXpgl3KhSR+MzbY1nvsu
         Llowz6cvZ2vXp8mDFXJ/3x+84cStlLnbQQ42biBlB2eqW1EhiFqiqNeWWrFM220itk
         mGXo6C4kPHNHvQS5RSS8HxQd/YhdKn57KB8WjHVUSHDEir6pgeRC1ad/wd7AfJ7nDl
         u9AurStpYI0FGt64A4Wq+CpqWnUQlVu1/0m6NuxOapmhiUlRNoccdXlvkqxrGfvHOh
         c7M+e8a/4s7r3aCZ6FSohPCnmvxrnWQGthEdmljXQii8oN7g9MmcLBrZ7j8BEG8Fks
         c0X7W1hEaYrzQ==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Tomer Tayar <ttayar@habana.ai>
Subject: [PATCH 08/13] habanalabs: allow unregistering eventfd when device non-operational
Date:   Thu,  6 Oct 2022 11:23:03 +0300
Message-Id: <20221006082308.1266716-8-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221006082308.1266716-1-ogabbay@kernel.org>
References: <20221006082308.1266716-1-ogabbay@kernel.org>
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

Unregistering eventfd is for releasing host resources and doesn't
involve an access to the device. As such, there is no reason to disallow
it when device isn't operational.

Signed-off-by: Tomer Tayar <ttayar@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/habanalabs_ioctl.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/habanalabs/common/habanalabs_ioctl.c b/drivers/misc/habanalabs/common/habanalabs_ioctl.c
index cac2c7fb14f1..5ce5c42e2731 100644
--- a/drivers/misc/habanalabs/common/habanalabs_ioctl.c
+++ b/drivers/misc/habanalabs/common/habanalabs_ioctl.c
@@ -879,6 +879,9 @@ static int _hl_info_ioctl(struct hl_fpriv *hpriv, void *data,
 	case HL_INFO_USER_MAPPINGS:
 		return user_mappings_info(hpriv, args);
 
+	case HL_INFO_UNREGISTER_EVENTFD:
+		return eventfd_unregister(hpriv, args);
+
 	default:
 		break;
 	}
@@ -935,9 +938,6 @@ static int _hl_info_ioctl(struct hl_fpriv *hpriv, void *data,
 	case HL_INFO_REGISTER_EVENTFD:
 		return eventfd_register(hpriv, args);
 
-	case HL_INFO_UNREGISTER_EVENTFD:
-		return eventfd_unregister(hpriv, args);
-
 	case HL_INFO_ENGINE_STATUS:
 		return engine_status_info(hpriv, args);
 
-- 
2.25.1

