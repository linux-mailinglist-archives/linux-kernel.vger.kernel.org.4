Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 052E073A89D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 20:51:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231422AbjFVSvl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 14:51:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231414AbjFVSvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 14:51:38 -0400
X-Greylist: delayed 106886 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 22 Jun 2023 11:51:35 PDT
Received: from smtpng3.i.mail.ru (smtpng3.i.mail.ru [94.100.177.149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E07B71FF9;
        Thu, 22 Jun 2023 11:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=inbox.ru; s=mail4;
        h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=p+iWB5jlHu8J5NVdgbBRkf4lseuIbdgeu4gKikNjj+w=;
        t=1687459896;x=1687549896; 
        b=DqEAMuLs+a39CC9dXXG2F7NHOXOJf3Bxcq3LODyw9XXpdMFrdDJ3BKFbp4zfATYvPVUcXng8iWHKq7FtZRCtpZL7QpSLKHTR2dcAbWgPiJsSP6ExqrAD7Ip7sqxLynULGOLfcF4M0zIP/g0kLu0/F9NfboB3faMKa+eaXU8KE/RSsD81wF7Zs0QqDL5qPszM7eDGbytRbv0OlDjoaa972LAPbFsI0A2GlZ0fXph1kmwZknj2htbI8HvgPI7rOIv0ZKjbZW6EYhLlv3SYu3tOAV8xUOB3OhXsmVtW5nZy+2ttNMcHbbXGPaErtNJsxnpa5GXOB55u/6HGGnbRTAUNaA==;
Received: by smtpng3.m.smailru.net with esmtpa (envelope-from <fido_max@inbox.ru>)
        id 1qCPP3-0001CL-7p; Thu, 22 Jun 2023 21:51:33 +0300
From:   Maxim Kochetkov <fido_max@inbox.ru>
To:     netdev@vger.kernel.org
Cc:     Maxim Kochetkov <fido_max@inbox.ru>,
        Robert Hancock <robert.hancock@calian.com>,
        Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Michal Simek <michal.simek@amd.com>,
        Andre Przywara <andre.przywara@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/1] net: axienet: Move reset before DMA detection
Date:   Thu, 22 Jun 2023 21:51:30 +0300
Message-Id: <20230622185131.113717-1-fido_max@inbox.ru>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtpng3.m.smailru.net; auth=pass smtp.auth=fido_max@inbox.ru smtp.mailfrom=fido_max@inbox.ru
X-Mailru-Src: smtp
X-7564579A: 646B95376F6C166E
X-77F55803: 4F1203BC0FB41BD95D99986233CC4DDCD825FF3AA070ECA3C2EE242F31DB0C21182A05F538085040F499278726E560259E7EC9ACB4612EF05270372DAF44CC04427632CD680C1B4E
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7CC84CC3AD347B910EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F79006371005780D56A98C20EA1F7E6F0F101C6723150C8DA25C47586E58E00D9D99D84E1BDDB23E98D2D38BE5CCB53A13BC8DBA7860F8D68D0323F857C18BE58FF1278D20879F7C8C5043D14489FFFB0AA5F4BFA417C69337E82CC2CC7F00164DA146DAFE8445B8C89999728AA50765F790063741F7343E26298569389733CBF5DBD5E9C8A9BA7A39EFB766F5D81C698A659EA7CC7F00164DA146DA9985D098DBDEAEC8CE4AEF6198D26326F6B57BC7E6449061A352F6E88A58FB86F5D81C698A659EA7E827F84554CEF5019E625A9149C048EE9ECD01F8117BC8BEE2021AF6380DFAD18AA50765F790063735872C767BF85DA227C277FBC8AE2E8B08F9A42B2210255C75ECD9A6C639B01B4E70A05D1297E1BBCB5012B2E24CD356
X-C1DE0DAB: 0D63561A33F958A5F843997C76389857B97932DC439E4282D4C195A55BD471C6F87CCE6106E1FC07E67D4AC08A07B9B01DAA61796BF5227B9C5DF10A05D560A950611B66E3DA6D700B0A020F03D25A0997E3FB2386030E77
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF77DD89D51EBB7742D3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CF8925DAA191E1713318F85A81DA1558E22CCEAEED2076469D72E08A9CF3BB8FE8422E0C78D0E15355B05B57073EAFDF971B30CF38DA3B874AF2E539E16A78A81621BEC6C0C71ED4F84C41F94D744909CEE921556F0E976A29E6EC0772259F8F8F8815B87D7EC76CB9
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojB41c+mu8Ac+Sc30P1oorFA==
X-Mailru-Sender: 689FA8AB762F73930F533AC2B33E986B70B89E82614EDFD7B35E749CAF57FC7598CC072019C18A892CA7F8C7C9492E1F2F5E575105D0B01ADBE2EF17B331888EEAB4BC95F72C04283CDA0F3B3F5B9367
X-Mras: Ok
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DMA detection will fail if axienet was started before (by boot loader,
boot ROM, etc). In this state axienet will not start properly.
XAXIDMA_TX_CDESC_OFFSET + 4 register (MM2S_CURDESC_MSB) is used to detect
64 DMA capability here. But datasheet says: When DMACR.RS is 1
(axienet is in enabled state), CURDESC_PTR becomes Read Only (RO) and
is used to fetch the first descriptor. So iowrite32()/ioread32() trick
to this register to detect DMA will not work.
So move axienet reset before DMA detection.

Fixes: f735c40ed93c ("net: axienet: Autodetect 64-bit DMA capability")
Signed-off-by: Maxim Kochetkov <fido_max@inbox.ru>
Reviewed-by: Robert Hancock <robert.hancock@calian.com>
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

