Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E82786372FD
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 08:40:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229452AbiKXHke (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 02:40:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbiKXHk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 02:40:28 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F241092B4F;
        Wed, 23 Nov 2022 23:40:27 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id n17so907130pgh.9;
        Wed, 23 Nov 2022 23:40:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7S1seOnibUlw6OdzLDbRM1IZ6rta3D5eLOPFyKSRo60=;
        b=OikolcwKLyDm6Gm9nYajldTnbUzGDkqZ6RKM7j7kQG5cQM4Kc64p3MVfFNbshYbBER
         uXVgUdCgSAbErevyhpOQ1DYLpnaDesR8jDA9S4q8CKW2Fj9CO2XlYjtdfeW7H2TgNb2W
         uYvwQYYfVdpqtcIrLG5lX8vhKl2m/U6oeZydUJfRcJaaN2pa6SbbdiyXNBanC3kZYoaj
         vzgneTCkkeUtog4t0p83zBwNF+quGxuXGNAYgSvtlghWDNFuGBbBucrKKiQY8EMGHMcd
         b8xmpi7P6LdVe9MXivmqcFP9nbTmP6XhqJZlU9K93BALlkIflwNLTytqgyqq3hswugJk
         tdxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7S1seOnibUlw6OdzLDbRM1IZ6rta3D5eLOPFyKSRo60=;
        b=pv4Hx5+KM41x/TU89HE4YCFXiod1nE41NuNHAv5BuZ4GkdbmaLHMFfIFY5J+Di126l
         JKVak/MwjdmT8BMM9Pdi45Llfk8foVNsmmtQzJsQgq2heByuzMHF5fHZNZN83vgrJjlU
         19Yc1PZ7Sa76xcVU76zEUE5VNQGg5mgPOY6OCyqJUduFMxsAMcPPGYxSfs/ByFA3vok1
         +qKo6pNL7GVK1DRrlECE0D+b9aS3cOVrKnjNEZ6ta/uAP45ODiqObXXF7AVTvF8xvhSh
         p7pbsgZ7aKaJ5EIcYhXEV/jI/vFE+mbDbH82+tQXJ9m1xXfsD9V/5IfaXfMIbj2nsNv/
         3SHw==
X-Gm-Message-State: ANoB5pkKdrctlFo2JsVSmsSL74xqjfkzF+oEsB3AUFPU3vPD9oW+2KWv
        sCUy8nDEwKnr3T5PT6HsIwYhCOwcFvc=
X-Google-Smtp-Source: AA0mqf67xCuJAZiXjOWHBFYcxdW2WL1LKeI5w3+b9yO6m3a0ZfN5pMwVuzPZ1uhx5L5IkH6Hm4AX5A==
X-Received: by 2002:aa7:92c7:0:b0:574:39dd:f162 with SMTP id k7-20020aa792c7000000b0057439ddf162mr8180973pfa.44.1669275627508;
        Wed, 23 Nov 2022 23:40:27 -0800 (PST)
Received: from localhost.localdomain ([123.51.145.88])
        by smtp.gmail.com with ESMTPSA id s5-20020a632c05000000b0047781f8ac17sm503143pgs.77.2022.11.23.23.40.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 23:40:27 -0800 (PST)
From:   JaimeLiao <jaimeliao.tw@gmail.com>
To:     broonie@kernel.org, krzysztof.kozlowski@linaro.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     jaimeliao@mxic.com.tw, JaimeLiao <jaimeliao.tw@gmail.com>
Subject: [PATCH v1 2/2] memory: renesas-rpc-if: Add Octal DTR mode support
Date:   Thu, 24 Nov 2022 15:39:57 +0800
Message-Id: <20221124073957.22471-3-jaimeliao.tw@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221124073957.22471-1-jaimeliao.tw@gmail.com>
References: <20221124073957.22471-1-jaimeliao.tw@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1. Support Octal DTR manual mode (Program & Erase & register)
2. Support diramap read (enable external address space read mode)

Signed-off-by: JaimeLiao <jaimeliao.tw@gmail.com>
---
 drivers/memory/renesas-rpc-if.c | 56 +++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/drivers/memory/renesas-rpc-if.c b/drivers/memory/renesas-rpc-if.c
index bdf0a7f68ff2..db5019a7190e 100644
--- a/drivers/memory/renesas-rpc-if.c
+++ b/drivers/memory/renesas-rpc-if.c
@@ -462,6 +462,43 @@ void rpcif_prepare(struct rpcif *rpc, const struct rpcif_op *op, u64 *offs,
 
 		rpc->enable |= RPCIF_SMENR_SPIDB(rpcif_bit_size(op->data.buswidth));
 	}
+       /* Fixup in Octal DTR mode */
+	if (op->cmd.buswidth == 8 && op->cmd.ddr) {
+		rpc->bus_size = 2;
+
+		regmap_update_bits(rpc->regmap, RPCIF_PHYCNT,
+				   RPCIF_PHYCNT_OCTA(0x2) | RPCIF_PHYCNT_OCT |
+				   RPCIF_PHYCNT_PHYMEM(0x1) ,
+				   RPCIF_PHYCNT_OCTA(0x2) | RPCIF_PHYCNT_OCT |
+				   RPCIF_PHYCNT_PHYMEM(0x1));
+		regmap_update_bits(rpc->regmap, RPCIF_CMNCR, RPCIF_CMNCR_BSZ(1),
+				   RPCIF_CMNCR_BSZ(1));
+
+		regmap_update_bits(rpc->regmap, RPCIF_PHYOFFSET1,
+				   RPCIF_PHYOFFSET1_DDRTMG(3),
+				   RPCIF_PHYOFFSET1_DDRTMG(2));
+		regmap_update_bits(rpc->regmap, RPCIF_PHYOFFSET2,
+				   RPCIF_PHYOFFSET2_OCTTMG(7),
+				   RPCIF_PHYOFFSET2_OCTTMG(3));
+
+		if (op->ocmd.buswidth == 8 && RPCIF_SMENR_OCDE)
+			rpc->enable &= ~RPCIF_SMENR_OCDE;
+
+		if (op->addr.ddr)
+			rpc->enable &= ~RPCIF_SMENR_ADE(0xF) |
+					RPCIF_SMENR_ADE(0xc);
+
+		if (op->dummy.buswidth == 8)
+			rpc->dummy =
+				RPCIF_SMDMCR_DMCYC(op->dummy.ncycles / 2);
+
+		if (op->data.dir == RPCIF_DATA_IN)
+			/* Set Extenal Address space Read mode */
+			if (op->data.buswidth == 8 && op->data.ddr) {
+				regmap_update_bits(rpc->regmap, RPCIF_PHYCNT,
+					RPCIF_PHYCNT_EXDS, RPCIF_PHYCNT_EXDS);
+			}
+	}
 }
 EXPORT_SYMBOL(rpcif_prepare);
 
@@ -501,10 +538,24 @@ int rpcif_manual_xfer(struct rpcif *rpc)
 			rpc->xfer_size = nbytes;
 
 			memcpy(data, rpc->buffer + pos, nbytes);
+			if (rpc->bus_size == 2) {
+				data[0] = (data[0] & 0x00f000f0) << 8 |
+					  (data[0] & 0xf000f000) >> 4 |
+					  (data[0] & 0x000f000f) << 4 |
+					  (data[0] & 0x0f000f00) >> 8;
+
+				data[1] = (data[1] & 0x00f000f0) << 8 |
+					  (data[1] & 0xf000f000) >> 4 |
+					  (data[1] & 0x000f000f) << 4 |
+					  (data[1] & 0x0f000f00) >> 8;
+			}
 			if (nbytes == 8)
 				regmap_write(rpc->regmap, RPCIF_SMWDR1, *p++);
 			regmap_write(rpc->regmap, RPCIF_SMWDR0, *p);
 
+			regmap_write(rpc->regmap, RPCIF_SMADR,
+				     rpc->smadr + pos);
+			regmap_write(rpc->regmap, RPCIF_SMENR, smenr);
 			regmap_write(rpc->regmap, RPCIF_SMCR, smcr);
 			ret = wait_msg_xfer_end(rpc);
 			if (ret)
@@ -652,9 +703,14 @@ ssize_t rpcif_dirmap_read(struct rpcif *rpc, u64 offs, size_t len, void *buf)
 	regmap_write(rpc->regmap, RPCIF_DROPR, rpc->option);
 	regmap_write(rpc->regmap, RPCIF_DRENR,
 		     rpc->enable & ~RPCIF_SMENR_SPIDE(0xF));
+	regmap_write(rpc->regmap, RPCIF_SMENR,
+		     rpc->enable & ~RPCIF_SMENR_SPIDE(0xF));
 	regmap_write(rpc->regmap, RPCIF_DRDMCR, rpc->dummy);
 	regmap_write(rpc->regmap, RPCIF_DRDRENR, rpc->ddr);
 
+	regmap_update_bits(rpc->regmap, RPCIF_DRENR, RPCIF_DRENR_ADE(0xF),
+			   RPCIF_DRENR_ADE(0xF));
+
 	if (rpc->bus_size == 2)
 		memcpy_fromio_readw(buf, rpc->dirmap + from, len);
 	else
-- 
2.17.1

