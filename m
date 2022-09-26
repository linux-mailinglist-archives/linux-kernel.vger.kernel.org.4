Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26D275EB4F7
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 01:01:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbiIZXBU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 19:01:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbiIZXBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 19:01:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B415EA5C6B;
        Mon, 26 Sep 2022 16:01:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5DB01B815C6;
        Mon, 26 Sep 2022 23:01:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7653C433D6;
        Mon, 26 Sep 2022 23:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664233273;
        bh=DP2/l6tR4P/DfoghYnDGEAWd4w5n5Txnre0toNJR3B4=;
        h=Date:From:To:Cc:Subject:From;
        b=boCq+yQ/8137uehBc9l2Vg8fH0UtZiV/BTfOw5Pliv/p3ReaZul1LbHdkZ+kETELP
         JNMJXaw65cWY5KBy57F76JdC3PVvqn2eIjIkHrb9fwZu66N6hzDL43oFrkW7rs8Ky+
         XFvTUKOsJ/xYtApAUBZwwy8czhvK7ZpUpRi1GMxzOGBM2OQnZqfMPvpeIfiRCmBSxI
         Ss46Z0hBLn19YxHSK8RzCQzZv0aORaqH9vU3oF9ovqM+UbH+C26QcIyf8wh6hGS6Pc
         w9q9ccZKPDVw6ohQhzAawjdDPWFItsVzVAjSue4yW7udf+9Fk9uOobqGkEK7FtFfcX
         clIFfgYpsQdng==
Date:   Mon, 26 Sep 2022 18:01:08 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH][next] soc: qcom: smd-rpm: Replace zero-length array with
 DECLARE_FLEX_ARRAY() helper
Message-ID: <YzIvNIyPhWaG2DTr@work>
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
Link: https://github.com/KSPP/linux/issues/224
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/soc/qcom/smd-rpm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/smd-rpm.c b/drivers/soc/qcom/smd-rpm.c
index 413f9f4ae9cd..125cb456a5dc 100644
--- a/drivers/soc/qcom/smd-rpm.c
+++ b/drivers/soc/qcom/smd-rpm.c
@@ -75,7 +75,7 @@ struct qcom_rpm_message {
 	__le32 length;
 	union {
 		__le32 msg_id;
-		u8 message[0];
+		DECLARE_FLEX_ARRAY(u8, message);
 	};
 };
 
-- 
2.34.1

