Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ABCA62C64B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 18:23:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234249AbiKPRXR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 12:23:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233262AbiKPRXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 12:23:02 -0500
X-Greylist: delayed 301 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 16 Nov 2022 09:22:56 PST
Received: from abi149hd127.arn1.oracleemaildelivery.com (abi149hd127.arn1.oracleemaildelivery.com [129.149.84.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7575559871
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 09:22:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=oci-arn1-20220924;
 d=augustwikerfors.se;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender;
 bh=LpcpAH4zxrcMxDLOPMA5F656Hw2TrxzTLadot3yE8cA=;
 b=vbCP7qhK75aPjwVaVVnjK9avPEKVW8DQTky20IKg23NM1BRDoEtaSMbscBQj/zKwoOPm3WbDLt1A
   LE1tT4s4sbnbe49Ak5JhgjfZ84JLs19DdSmL5CpyzoglRYPvbQjOqNIPZZ9ZTBb/yyEZsEsxZIZq
   kqNGxth1PEL9V1wde1yYZOccazC550JgZ9s9xvC4z8y6qVdJR7XV2VtEWuRNCxs1u29MbpjAOR3t
   LwVzwuzWU9dQFyZzhZ2xwmyJpPqt7Yj8LuCBh04pclR77SSq3umYvF6qWAfwD6lujF2QLtfAGPlC
   RSeLNIQw6xxA/6E9xt3I5MZTMZDxfsiTKYyh+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-arn-20211201;
 d=arn1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender;
 bh=LpcpAH4zxrcMxDLOPMA5F656Hw2TrxzTLadot3yE8cA=;
 b=QDdPe5/aq6cOV5ywHAns7uvVq8CuwohXDRB5cyV3d1jP5FDz4/n9sqU9Vqh57CtCNNzmnzflOJIt
   Y9DDByKpiot8WfJzBW4Rf2EotLCdkcnYfgog2DlPoRZ1tlO6cGdqMDrXW26lP/kDvom3Gqm02ntr
   /kFQcBAsRP4eq6sJXykQ2tOivncCLeTpxouAc0wPFjvuIKQF9VH9EpIagcNoul+ZLeON5D+cUJwL
   si3ZGrB9rbnbeQ+Dl1btQ7VttXN4XF5p+K/vOMAAGK4BzpLJedV40hGiXrQlezK5HPEnU6W43XCp
   AlJiFLjou5ORUtoP0Iat8JHcgWY2Y3ozlr4m1Q==
Received: by omta-ad1-fd2-101-eu-stockholm-1.omtaad1.vcndparn.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20221104 64bit (built Nov  4
 2022))
 with ESMTPS id <0RLG0063MAPTE900@omta-ad1-fd2-101-eu-stockholm-1.omtaad1.vcndparn.oraclevcn.com>
 for linux-kernel@vger.kernel.org; Wed, 16 Nov 2022 17:17:53 +0000 (GMT)
From:   August Wikerfors <git@augustwikerfors.se>
To:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        August Wikerfors <git@augustwikerfors.se>
Subject: [PATCH] nvme-pci: add NVME_QUIRK_BOGUS_NID for Samsung PM9B1 256G and
 512G
Date:   Wed, 16 Nov 2022 18:17:27 +0100
Message-id: <20221116171727.4083-1-git@augustwikerfors.se>
MIME-version: 1.0
Content-transfer-encoding: 8bit
Reporting-Meta: AAEu+0BrTkHBsWLOK63HjpEKIIURzBrIK56dK+jBm3s0DHlxjT4P2/MBeqUBNrmp
 VCVIkws4O2zsNXnjRWGkS5823k/tfg+rw6l4Necjg9kJztS2KXqUh3Xg4rRuERuF
 y59v90MLW5ID7raGwICLysCyEOWQFMjDZS+hM9eFde+qXMfhxSbKKfe8wIYyRSR3
 rou9S/44Ely2QnM4WpJzVcsC5zLhHEXBOWIjc8cJ8O5OOoeiHXB18/OjMw6c3JMb
 j9M1ky8eXkYB7Bl4XksHK/T/GaJCCwYpjnVY3REKJc2mqcoJ0FAU22aJbAZ8hlxG
 BVYpiSO02rAebKgxWgoAVYXOHg22qaejwn6h+htz/Jkbn/DJSNCQMOkNj8q3PBtI
 y8n2CqiJnEzOSq+2GCP7fqYcZhBPFMfqS2DKAWvqRlFpU3IslFJw3VPLL8Zw4P/a aBEiRg==
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Samsung PM9B1 512G SSD found in some Lenovo Yoga 7 14ARB7 laptop units
reports eui as 0001000200030004 when resuming from s2idle, causing the
device to be removed with this error in dmesg:

nvme nvme0: identifiers changed for nsid 1

To fix this, add a quirk to ignore namespace identifiers for this device.

Signed-off-by: August Wikerfors <git@augustwikerfors.se>
---
 drivers/nvme/host/pci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index f4335519399d..0af51b85c323 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3500,7 +3500,8 @@ static const struct pci_device_id nvme_id_table[] = {
 	{ PCI_DEVICE(0x1d97, 0x2263),   /* SPCC */
 		.driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
 	{ PCI_DEVICE(0x144d, 0xa80b),   /* Samsung PM9B1 256G and 512G */
-		.driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
+		.driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES |
+				NVME_QUIRK_BOGUS_NID, },
 	{ PCI_DEVICE(0x144d, 0xa809),   /* Samsung MZALQ256HBJD 256G */
 		.driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
 	{ PCI_DEVICE(0x1cc4, 0x6303),   /* UMIS RPJTJ512MGE1QDY 512G */
-- 
2.38.1

