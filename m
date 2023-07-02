Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ADE3744F84
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jul 2023 19:56:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbjGBR4J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 13:56:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbjGBRz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 13:55:58 -0400
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [IPv6:2001:67c:2050:0:465::101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F5E2E5C;
        Sun,  2 Jul 2023 10:55:52 -0700 (PDT)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4QvGtt6CD6z9sTH;
        Sun,  2 Jul 2023 19:55:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oltmanns.dev;
        s=MBO0001; t=1688320550;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UYJXelK6HIvlm3HnYGcGVVQzmR308v13RIhh/o3PQBg=;
        b=wRnKIno8Zl+53XIRjFS/8DvIMFh/37nriSsfDYkfGAlw21nTdvJibyZt4RnMnZR1e9tHYF
        7RMMtijVm50jTOmFB6PEe3/ub0M+hcZ4k631WaO1xGrVo+JoPF4zguI2fRs1/JCe52ouZm
        DKraCXnpZ5aRTKrMUHhoMGtl+yRxPz+v8tOd+UbVD8AOolKtk37+icYAiK0LFTOtFJswDo
        B8J3BybMON/yOnjd8eEknhxYazb96n5d7oxERavE96v1qGNRidH0zoqBu93j/+a33RFfK9
        jiRVtflKB9bi6Foq3a4iwZcwYtUH+3RmC8cFM2qs7TnfQUPEPlnF/JXPQq4HWg==
From:   Frank Oltmanns <frank@oltmanns.dev>
Date:   Sun, 02 Jul 2023 19:55:22 +0200
Subject: [PATCH v3 3/8] clk: sunxi-ng: Add feature to find closest rate
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230702-pll-mipi_set_rate_parent-v3-3-46dcb8aa9cbc@oltmanns.dev>
References: <20230702-pll-mipi_set_rate_parent-v3-0-46dcb8aa9cbc@oltmanns.dev>
In-Reply-To: <20230702-pll-mipi_set_rate_parent-v3-0-46dcb8aa9cbc@oltmanns.dev>
To:     Maxime Ripard <maxime@cerno.tech>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Andre Przywara <andre.przywara@arm.com>,
        Roman Beranek <me@crly.cz>
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Frank Oltmanns <frank@oltmanns.dev>
X-Developer-Signature: v=1; a=openpgp-sha256; l=879; i=frank@oltmanns.dev;
 h=from:subject:message-id; bh=nq4as25RxVF9/y/5G9YYRABH8Ort2KDG2xy+iJVw8Qw=;
 b=owEB7QES/pANAwAIAZppogiUStPHAcsmYgBkoboba3wAEwXiJymkTQCoONbsAf4+BrEkd06OO
 xBG/cEzMmKJAbMEAAEIAB0WIQQC/SV7f5DmuaVET5aaaaIIlErTxwUCZKG6GwAKCRCaaaIIlErT
 x9SuC/9IAekMRGvkUFyioDP+R5cgyY2CuyinjuaOp0VgYfQ2L+COWJOmDq9LIovGIVqXAOQ5L7v
 DrS2cT4q70H59JbgSrrZeEBfBheXAJ3QNS/akazcMZcm7ulkWFzVP0ilQuBE6+wrnakWecHFhJ9
 ZH1edZU3VQjYxxwGIv92yGgrIL35slkPSUKmKCI9T37rEWfcF6JPdj9uNwJqcPY0xA6WwC6aGp2
 ikVcRryVFPL6nRz/kOZi44V/vAvY3iq1E2uBvocLkS2oxkgIj/tCQhwaYUVcV8mwUlbME/mIrBB
 MsoBRhtI2TbZHbwbkaYIi9cn9XupxSO5a1f6VzW5h6pQ4gYMA4W/uHFKhcRI/7UKhkgYNGU/Llz
 VxKUCr7JPGfK1QreusM1xbgovRYi5t4XYoidsU3pxDYqnHqOwhhUp9imprHKxbqXOJyQuD0GTrS
 JZE5pMquaDSg8rj5OQKZGErmrLjSV5V2YwJ4BbvA++WgfAEWCKR28Q4x9nvYr/cbuuBYw=
X-Developer-Key: i=frank@oltmanns.dev; a=openpgp;
 fpr=02FD257B7F90E6B9A5444F969A69A208944AD3C7
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The default behaviour of clocks in the sunxi-ng driver is to select a
clock rate that is closest to but less than the requested rate.

Add the CCU_FEATURE_CLOSEST_RATE flag, which can be used to allow clocks
to find the closest rate instead.

Signed-off-by: Frank Oltmanns <frank@oltmanns.dev>
---
 drivers/clk/sunxi-ng/ccu_common.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/sunxi-ng/ccu_common.h b/drivers/clk/sunxi-ng/ccu_common.h
index fbf16c6b896d..5ad219f041d5 100644
--- a/drivers/clk/sunxi-ng/ccu_common.h
+++ b/drivers/clk/sunxi-ng/ccu_common.h
@@ -18,6 +18,7 @@
 #define CCU_FEATURE_MMC_TIMING_SWITCH	BIT(6)
 #define CCU_FEATURE_SIGMA_DELTA_MOD	BIT(7)
 #define CCU_FEATURE_KEY_FIELD		BIT(8)
+#define CCU_FEATURE_CLOSEST_RATE	BIT(9)
 
 /* MMC timing mode switch bit */
 #define CCU_MMC_NEW_TIMING_MODE		BIT(30)

-- 
2.41.0

