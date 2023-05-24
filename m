Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3BB370EA2B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 02:19:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239021AbjEXATu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 20:19:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239005AbjEXATs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 20:19:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85A21B5;
        Tue, 23 May 2023 17:19:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1E5DE635F2;
        Wed, 24 May 2023 00:19:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCF87C433D2;
        Wed, 24 May 2023 00:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684887586;
        bh=hixGdc1nHEoCc/d3qs1AQBwSDjqbYfvrtLPRskFMBvY=;
        h=Date:From:To:Cc:Subject:From;
        b=CHuGI6gMsRzy1m4Y8y1Mk4UEu2sIlb5MlVltFq4BGV+PjQyQTUzhuVUzjPUx/YRji
         wz9b/gjzXwwdjj4eFenbTB06urAgBpj0kU8dArGgPJDQo5K4Pe3ME0Bwz3fa8b+Nnk
         +YI6DyNveg9VNQjY4wCUkEOr22PwL8SfSMuaUP0Xzz05BOZVR0xse7cScT95RJdVds
         QjjAuDT1mEMXTeQZlmPkEaBaHOkrE1+Je5/CnIAAwx/1G0Z9AU8qPBRImCX3pua9U9
         5mHDBwJzbQuVrU40bn27wwzIvR00U6B+1vXsGoQ7Nr9HSLQN9W2Slh/z8gA60K8AL1
         9Vc8vsTBr8G3A==
Date:   Tue, 23 May 2023 18:20:38 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Andy Walls <awalls@md.metrocast.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH][next] media: pci: cx18-av-vbi: Replace one-element array
 with flexible-array member
Message-ID: <ZG1YVji9thTLWeRm@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One-element arrays are deprecated, and we are replacing them with flexible
array members instead. So, replace one-element arrays with flexible-array
members in struct vbi_anc_data.

This results in no differences in binary output.

Link: https://github.com/KSPP/linux/issues/79
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/media/pci/cx18/cx18-av-vbi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/pci/cx18/cx18-av-vbi.c b/drivers/media/pci/cx18/cx18-av-vbi.c
index a0d465924e75..65281d40c681 100644
--- a/drivers/media/pci/cx18/cx18-av-vbi.c
+++ b/drivers/media/pci/cx18/cx18-av-vbi.c
@@ -51,7 +51,7 @@ struct vbi_anc_data {
 	u8 sdid;
 	u8 data_count;
 	u8 idid[2];
-	u8 payload[1]; /* data_count of payload */
+	u8 payload[]; /* data_count of payload */
 	/* u8 checksum; */
 	/* u8 fill[]; Variable number of fill bytes */
 };
-- 
2.34.1

