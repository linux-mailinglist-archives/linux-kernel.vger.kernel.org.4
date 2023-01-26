Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06C8167C30C
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 04:14:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235263AbjAZDOn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 22:14:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjAZDOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 22:14:41 -0500
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9195264D88;
        Wed, 25 Jan 2023 19:14:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1674702880; x=1706238880;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=YnjTkVHuxQtGQzjc/gDmzlIOB8H4c7tQDGmebubRFf4=;
  b=BCUif5GnrIlLDOEF0k5mQZdFmyWBpfoZHg0MCGG55771k55TyQBwCtfg
   /8dbuJlxujjBK6l43n6ZLks7WExYKXbeuRCAA5NHyBRv+LjKduNJTAO7N
   6ZmdG5zEPZooHmADbVFN1b1iTt6WmN0wxlgVS5QO28yvk+1XEzMgQqs2B
   8=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 25 Jan 2023 19:14:39 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.45.79.139])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2023 19:14:39 -0800
Received: from hu-wcheng-lv.qualcomm.com (10.49.16.6) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Wed, 25 Jan 2023 19:14:38 -0800
From:   Wesley Cheng <quic_wcheng@quicinc.com>
To:     <srinivas.kandagatla@linaro.org>, <mathias.nyman@intel.com>,
        <perex@perex.cz>, <lgirdwood@gmail.com>, <andersson@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <gregkh@linuxfoundation.org>,
        <Thinh.Nguyen@synopsys.com>, <broonie@kernel.org>,
        <bgoswami@quicinc.com>, <tiwai@suse.com>, <robh+dt@kernel.org>,
        <agross@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <quic_jackp@quicinc.com>,
        <quic_plai@quicinc.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: [RFC PATCH v2 02/22] xhci: remove xhci_test_trb_in_td_math early development check
Date:   Wed, 25 Jan 2023 19:14:04 -0800
Message-ID: <20230126031424.14582-3-quic_wcheng@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230126031424.14582-1-quic_wcheng@quicinc.com>
References: <20230126031424.14582-1-quic_wcheng@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mathias Nyman <mathias.nyman@linux.intel.com>

Time to remove this test trb in td math check that was added
in early stage of xhci driver deveopment.

It verified that the size, alignment and boundaries of the event and
command rings the driver itself allocated are correct.

Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
---
 drivers/usb/host/xhci-mem.c | 160 ------------------------------------
 1 file changed, 160 deletions(-)

diff --git a/drivers/usb/host/xhci-mem.c b/drivers/usb/host/xhci-mem.c
index 679befa97c7a..bf9bb29f924b 100644
--- a/drivers/usb/host/xhci-mem.c
+++ b/drivers/usb/host/xhci-mem.c
@@ -1929,164 +1929,6 @@ void xhci_mem_cleanup(struct xhci_hcd *xhci)
 	xhci->usb3_rhub.bus_state.bus_suspended = 0;
 }
 
-static int xhci_test_trb_in_td(struct xhci_hcd *xhci,
-		struct xhci_segment *input_seg,
-		union xhci_trb *start_trb,
-		union xhci_trb *end_trb,
-		dma_addr_t input_dma,
-		struct xhci_segment *result_seg,
-		char *test_name, int test_number)
-{
-	unsigned long long start_dma;
-	unsigned long long end_dma;
-	struct xhci_segment *seg;
-
-	start_dma = xhci_trb_virt_to_dma(input_seg, start_trb);
-	end_dma = xhci_trb_virt_to_dma(input_seg, end_trb);
-
-	seg = trb_in_td(xhci, input_seg, start_trb, end_trb, input_dma, false);
-	if (seg != result_seg) {
-		xhci_warn(xhci, "WARN: %s TRB math test %d failed!\n",
-				test_name, test_number);
-		xhci_warn(xhci, "Tested TRB math w/ seg %p and "
-				"input DMA 0x%llx\n",
-				input_seg,
-				(unsigned long long) input_dma);
-		xhci_warn(xhci, "starting TRB %p (0x%llx DMA), "
-				"ending TRB %p (0x%llx DMA)\n",
-				start_trb, start_dma,
-				end_trb, end_dma);
-		xhci_warn(xhci, "Expected seg %p, got seg %p\n",
-				result_seg, seg);
-		trb_in_td(xhci, input_seg, start_trb, end_trb, input_dma,
-			  true);
-		return -1;
-	}
-	return 0;
-}
-
-/* TRB math checks for xhci_trb_in_td(), using the command and event rings. */
-static int xhci_check_trb_in_td_math(struct xhci_hcd *xhci)
-{
-	struct {
-		dma_addr_t		input_dma;
-		struct xhci_segment	*result_seg;
-	} simple_test_vector [] = {
-		/* A zeroed DMA field should fail */
-		{ 0, NULL },
-		/* One TRB before the ring start should fail */
-		{ xhci->event_ring->first_seg->dma - 16, NULL },
-		/* One byte before the ring start should fail */
-		{ xhci->event_ring->first_seg->dma - 1, NULL },
-		/* Starting TRB should succeed */
-		{ xhci->event_ring->first_seg->dma, xhci->event_ring->first_seg },
-		/* Ending TRB should succeed */
-		{ xhci->event_ring->first_seg->dma + (TRBS_PER_SEGMENT - 1)*16,
-			xhci->event_ring->first_seg },
-		/* One byte after the ring end should fail */
-		{ xhci->event_ring->first_seg->dma + (TRBS_PER_SEGMENT - 1)*16 + 1, NULL },
-		/* One TRB after the ring end should fail */
-		{ xhci->event_ring->first_seg->dma + (TRBS_PER_SEGMENT)*16, NULL },
-		/* An address of all ones should fail */
-		{ (dma_addr_t) (~0), NULL },
-	};
-	struct {
-		struct xhci_segment	*input_seg;
-		union xhci_trb		*start_trb;
-		union xhci_trb		*end_trb;
-		dma_addr_t		input_dma;
-		struct xhci_segment	*result_seg;
-	} complex_test_vector [] = {
-		/* Test feeding a valid DMA address from a different ring */
-		{	.input_seg = xhci->event_ring->first_seg,
-			.start_trb = xhci->event_ring->first_seg->trbs,
-			.end_trb = &xhci->event_ring->first_seg->trbs[TRBS_PER_SEGMENT - 1],
-			.input_dma = xhci->cmd_ring->first_seg->dma,
-			.result_seg = NULL,
-		},
-		/* Test feeding a valid end TRB from a different ring */
-		{	.input_seg = xhci->event_ring->first_seg,
-			.start_trb = xhci->event_ring->first_seg->trbs,
-			.end_trb = &xhci->cmd_ring->first_seg->trbs[TRBS_PER_SEGMENT - 1],
-			.input_dma = xhci->cmd_ring->first_seg->dma,
-			.result_seg = NULL,
-		},
-		/* Test feeding a valid start and end TRB from a different ring */
-		{	.input_seg = xhci->event_ring->first_seg,
-			.start_trb = xhci->cmd_ring->first_seg->trbs,
-			.end_trb = &xhci->cmd_ring->first_seg->trbs[TRBS_PER_SEGMENT - 1],
-			.input_dma = xhci->cmd_ring->first_seg->dma,
-			.result_seg = NULL,
-		},
-		/* TRB in this ring, but after this TD */
-		{	.input_seg = xhci->event_ring->first_seg,
-			.start_trb = &xhci->event_ring->first_seg->trbs[0],
-			.end_trb = &xhci->event_ring->first_seg->trbs[3],
-			.input_dma = xhci->event_ring->first_seg->dma + 4*16,
-			.result_seg = NULL,
-		},
-		/* TRB in this ring, but before this TD */
-		{	.input_seg = xhci->event_ring->first_seg,
-			.start_trb = &xhci->event_ring->first_seg->trbs[3],
-			.end_trb = &xhci->event_ring->first_seg->trbs[6],
-			.input_dma = xhci->event_ring->first_seg->dma + 2*16,
-			.result_seg = NULL,
-		},
-		/* TRB in this ring, but after this wrapped TD */
-		{	.input_seg = xhci->event_ring->first_seg,
-			.start_trb = &xhci->event_ring->first_seg->trbs[TRBS_PER_SEGMENT - 3],
-			.end_trb = &xhci->event_ring->first_seg->trbs[1],
-			.input_dma = xhci->event_ring->first_seg->dma + 2*16,
-			.result_seg = NULL,
-		},
-		/* TRB in this ring, but before this wrapped TD */
-		{	.input_seg = xhci->event_ring->first_seg,
-			.start_trb = &xhci->event_ring->first_seg->trbs[TRBS_PER_SEGMENT - 3],
-			.end_trb = &xhci->event_ring->first_seg->trbs[1],
-			.input_dma = xhci->event_ring->first_seg->dma + (TRBS_PER_SEGMENT - 4)*16,
-			.result_seg = NULL,
-		},
-		/* TRB not in this ring, and we have a wrapped TD */
-		{	.input_seg = xhci->event_ring->first_seg,
-			.start_trb = &xhci->event_ring->first_seg->trbs[TRBS_PER_SEGMENT - 3],
-			.end_trb = &xhci->event_ring->first_seg->trbs[1],
-			.input_dma = xhci->cmd_ring->first_seg->dma + 2*16,
-			.result_seg = NULL,
-		},
-	};
-
-	unsigned int num_tests;
-	int i, ret;
-
-	num_tests = ARRAY_SIZE(simple_test_vector);
-	for (i = 0; i < num_tests; i++) {
-		ret = xhci_test_trb_in_td(xhci,
-				xhci->event_ring->first_seg,
-				xhci->event_ring->first_seg->trbs,
-				&xhci->event_ring->first_seg->trbs[TRBS_PER_SEGMENT - 1],
-				simple_test_vector[i].input_dma,
-				simple_test_vector[i].result_seg,
-				"Simple", i);
-		if (ret < 0)
-			return ret;
-	}
-
-	num_tests = ARRAY_SIZE(complex_test_vector);
-	for (i = 0; i < num_tests; i++) {
-		ret = xhci_test_trb_in_td(xhci,
-				complex_test_vector[i].input_seg,
-				complex_test_vector[i].start_trb,
-				complex_test_vector[i].end_trb,
-				complex_test_vector[i].input_dma,
-				complex_test_vector[i].result_seg,
-				"Complex", i);
-		if (ret < 0)
-			return ret;
-	}
-	xhci_dbg(xhci, "TRB math tests passed.\n");
-	return 0;
-}
-
 static void xhci_set_hc_event_deq(struct xhci_hcd *xhci)
 {
 	u64 temp;
@@ -2506,8 +2348,6 @@ int xhci_mem_init(struct xhci_hcd *xhci, gfp_t flags)
 					0, flags);
 	if (!xhci->event_ring)
 		goto fail;
-	if (xhci_check_trb_in_td_math(xhci) < 0)
-		goto fail;
 
 	ret = xhci_alloc_erst(xhci, xhci->event_ring, &xhci->erst, flags);
 	if (ret)
