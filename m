Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8092273830D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 14:13:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbjFULvJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 07:51:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbjFULvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 07:51:07 -0400
X-Greylist: delayed 1440 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 21 Jun 2023 04:51:05 PDT
Received: from fallback2.i.mail.ru (fallback2.i.mail.ru [79.137.243.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 346AF10E6;
        Wed, 21 Jun 2023 04:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=inbox.ru; s=mail4;
        h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=JdWgFEyvsv2csKxKfs0FCohIrTsdr/3DiIZZEszXHmE=;
        t=1687348265;x=1687438265; 
        b=E0vXwcb7BfbWZvmoUbuzpy/+W9zrws2wDOMYY+bnjZ7JmY3+3xm/rBhbVAuOGa+yDCDUSf03lSPPccchUlfL8gT9OmJfvtrRvISLxIrlKgMWLbLsUuJJH0H5TNc5NEtE8j936AWNhclY4crvC1BeB3cI2GKCijDWZwJACRKjvtjZ2pz6c/G89rLGiV8SWxWYpxXEP9n64coR1et/CQaB45U+eG+MYD5ZdgnUuNQ0xKRyJ5/SAr5/KDazGZ/QrwtIs+Esd2x/ZumpBf7KXr6hJWL/SyWLZJMehXvULk9+yCZCvT6sQ5C+S7Qtd9PVRaOWJEpxeAaCsc7+9Xr1s0Vw6g==;
Received: from [10.161.55.49] (port=45888 helo=smtpng1.i.mail.ru)
        by fallback2.i.mail.ru with esmtp (envelope-from <fido_max@inbox.ru>)
        id 1qBvzL-00C1CV-2Q; Wed, 21 Jun 2023 14:27:03 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=inbox.ru; s=mail4;
        h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=JdWgFEyvsv2csKxKfs0FCohIrTsdr/3DiIZZEszXHmE=;
        t=1687346823;x=1687436823; 
        b=kIxNiHQhXrN19GJcgqGq7J2LGexyvROXakpXU3Mi2wRdkBzOBqEJkIw5kUXgF0dvRg7LLO9h2hGuoqyVfp3HaAhYJMWIQmQr7NaSTSmo6kJHCORv7A0aChKP2lekEnbb9PSVBiX5Qq9njsOofSsvVvL7y5E3PP5BjwkyCivviWXpUxaJzdXPUkP00FhL7GC26GP5unOle8q8Q2fkOJORg0C5tOvFqsHCXWl/5AXEo0GNe1gK2fytcsBiVPLK3slbpE0Dm0Fezzm6NZZQvnWHw46NM/Fh9cX0e+1Y9HpMHm3Z2xa1mvNyudyQuGf0wHcSxC4U1xDaySzbzVTF5JDlPg==;
Received: by smtpng1.m.smailru.net with esmtpa (envelope-from <fido_max@inbox.ru>)
        id 1qBvz5-00068f-9O; Wed, 21 Jun 2023 14:26:47 +0300
From:   Maxim Kochetkov <fido_max@inbox.ru>
To:     netdev@vger.kernel.org
Cc:     Maxim Kochetkov <fido_max@inbox.ru>,
        Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Michal Simek <michal.simek@amd.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] net: axienet: Move reset before DMA detection
Date:   Wed, 21 Jun 2023 14:26:30 +0300
Message-Id: <20230621112630.154373-1-fido_max@inbox.ru>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailru-Src: smtp
X-7564579A: EEAE043A70213CC8
X-77F55803: 4F1203BC0FB41BD9978DF295B1C9A8BB9D84323826A48A4E6979DC33E17B8123182A05F5380850404C228DA9ACA6FE2718CDE42291E1BEF24F7F798CEE9A6143C2A7D04A29770631C1FAE79B3CD02C1C
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7922E451CE6E839B1EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F790063745D431239A8C7DA08638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D88166C0AFA8F60B1B5CB1B6839C6649FC6F9789CCF6C18C3F8528715B7D10C86878DA827A17800CE77FFCE1C639F4728C9FA2833FD35BB23D9E625A9149C048EE26055571C92BF10FF6B57BC7E64490618DEB871D839B7333395957E7521B51C2DFABB839C843B9C08941B15DA834481F8AA50765F790063780B3000F7A6F2D7A389733CBF5DBD5E9B5C8C57E37DE458B9E9CE733340B9D5F3BBE47FD9DD3FB595F5C1EE8F4F765FC72CEEB2601E22B093A03B725D353964B0B7D0EA88DDEDAC722CA9DD8327EE4930A3850AC1BE2E73557739F23D657EF2BB5C8C57E37DE458BEDA766A37F9254B7
X-C1DE0DAB: 0D63561A33F958A5039A3253B420BE8278B99395EBDC0501FAAD44C10F72E43BF87CCE6106E1FC07E67D4AC08A07B9B01DAA61796BF5227B9C5DF10A05D560A950611B66E3DA6D700B0A020F03D25A092FFDA4F57982C5F4CB5012B2E24CD356
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF77DD89D51EBB7742D3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CFC23662B37B557434663459EC48228DFD0FB7B98632BF9915B77A11FB90BECA9A245B1B6CBED8166AC17492877F82D9B8193AE7FE20AFF8D4140E9F220E5C2EC16E346BF9FA413E554C41F94D744909CEE921556F0E976A29E6EC0772259F8F8F8815B87D7EC76CB9
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojw7uTMtz3/lymtcgsLQrc0Q==
X-Mailru-Sender: 689FA8AB762F73930F533AC2B33E986BE07CCC33A5272471D04C4951FF70F75B98CC072019C18A892CA7F8C7C9492E1F2F5E575105D0B01ADBE2EF17B331888EEAB4BC95F72C04283CDA0F3B3F5B9367
X-Mras: Ok
X-7564579A: 646B95376F6C166E
X-77F55803: 6242723A09DB00B4E9028C5D3AAACA543326910168EF65999CF76EE81467C5E9B647ED114AB003ACE7E3040B4183954EC0AC3294C82D8AB1BE4A5DA2DF66D6CAACDAE828A7DFF3B8
X-7FA49CB5: 0D63561A33F958A585B1B4DDE8AEA9363C3D52CEEB6AD0795DED24E97496E442CACD7DF95DA8FC8BD5E8D9A59859A8B6045ADF271E14A4E1
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5xhPKz0ZEsZ5k6NOOPWz5QAiZSCXKGQRq3/7KxbCLSB2ESzQkaOXqCBFZPLWFrEGlV1shfWe2EVcxl5toh0c/aCGOghz/frdRhzMe95NxDFdGZgddNfoakPgEQlcWJjaIQ==
X-Mailru-MI: C000000000000800
X-Mras: Ok
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DMA detection will fail if axinet was started before (by boot loader,
boot ROM, etc). In this state axinet will not start properly.
So move axinet reset before DMA detection.

Signed-off-by: Maxim Kochetkov <fido_max@inbox.ru>
---
 drivers/net/ethernet/xilinx/xilinx_axienet_main.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index 3e310b55bce2..734822321e0a 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -2042,6 +2042,11 @@ static int axienet_probe(struct platform_device *pdev)
 		goto cleanup_clk;
 	}
 
+	/* Reset core now that clocks are enabled, prior to accessing MDIO */
+	ret = __axienet_device_reset(lp);
+	if (ret)
+		goto cleanup_clk;
+
 	/* Autodetect the need for 64-bit DMA pointers.
 	 * When the IP is configured for a bus width bigger than 32 bits,
 	 * writing the MSB registers is mandatory, even if they are all 0.
@@ -2096,11 +2101,6 @@ static int axienet_probe(struct platform_device *pdev)
 	lp->coalesce_count_tx = XAXIDMA_DFT_TX_THRESHOLD;
 	lp->coalesce_usec_tx = XAXIDMA_DFT_TX_USEC;
 
-	/* Reset core now that clocks are enabled, prior to accessing MDIO */
-	ret = __axienet_device_reset(lp);
-	if (ret)
-		goto cleanup_clk;
-
 	ret = axienet_mdio_setup(lp);
 	if (ret)
 		dev_warn(&pdev->dev,
-- 
2.40.1

