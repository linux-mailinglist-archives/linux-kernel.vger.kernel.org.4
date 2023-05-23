Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0C2770E311
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 19:46:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237999AbjEWRne (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 13:43:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238100AbjEWRn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 13:43:29 -0400
Received: from tiger.tulip.relay.mailchannels.net (tiger.tulip.relay.mailchannels.net [23.83.218.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72E4AB5;
        Tue, 23 May 2023 10:43:22 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 6CD29262609;
        Tue, 23 May 2023 17:43:19 +0000 (UTC)
Received: from pdx1-sub0-mail-a250.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id DB523262595;
        Tue, 23 May 2023 17:43:18 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1684863799; a=rsa-sha256;
        cv=none;
        b=4ukWSsaAJr2usHupXvtBxk8OwHTTROxCjmGAK2SVMQASfhODZZa4lBe/KylNbNi3TxHaZJ
        aJba6aGEV3uQkjcCCdIGulinbbl/HCAvJkPNyfeg0ifaVUz1yHpRd4qFkA3BchZEk6Q9aE
        JZCTJrfdkE/MeOzV6QRwuVigvTcUeqbRD7fNU+wQA1zUM+e7iIGBCVDODyjtK0g1UOPxzz
        L9F1aLvwkHIIW7Etgqpy+0UBySfkWFD315jt1MW3R7JAQ4QxyUB35H4STjumvryUyJUZmG
        ElVXtFYgLUN1kFkQIOZaaazYiGjrkEo6tTjfQDJXgDN+ziDe9cYrgJdzwMaYZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1684863799;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=Bh5pmBAZMINLcIjPupzC+5lllFGC0EfYDoFo0I+pOsA=;
        b=ZfagXL2k92ZnhqKlPWE+VDc6dG2F0xNU0zgzvUQOXD4uDx1a3fzWaZuHcbLUYmhnJDRPhe
        o+gGmnFzAAGXr+eiHHr6stkwNSPCh4fK5enoEvlgeLxz+Ot8pMNrw5Xdnrpr19hxbu4ySk
        JopIY6G9xrozSxJMEA3N45kXn0jlino84kcGjGX9MKsWrCCboanFveoLBgHydbydU3A0kC
        V3IMUchC1Kyyr2bR4R0nMDD1YtM1VizZbNg9xp09YVXG8zcY9PvfpFKSVDiWpKkeHJ+W+T
        R+t6YTo+5r8GnpxV5fwQskvwXx2+KCRRGivlOntXkZJdCQW3Fd9JybuEor1jrw==
ARC-Authentication-Results: i=1;
        rspamd-5cdf8fd7d9-7mx5b;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Left-Scare: 7578ef46780d1bcc_1684863799244_2689381057
X-MC-Loop-Signature: 1684863799244:2937721352
X-MC-Ingress-Time: 1684863799244
Received: from pdx1-sub0-mail-a250.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.104.24.179 (trex/6.8.1);
        Tue, 23 May 2023 17:43:19 +0000
Received: from localhost.localdomain (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a250.dreamhost.com (Postfix) with ESMTPSA id 4QQhVs72Nqz36;
        Tue, 23 May 2023 10:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1684863798;
        bh=Bh5pmBAZMINLcIjPupzC+5lllFGC0EfYDoFo0I+pOsA=;
        h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
        b=hCCHZioq5QPrLydqF+KocM6vBONbyQ5ghX7kQBI4BIc5Ob6GqoTpFUm2QAbnxsRit
         PRK4Hn44xafkBFJ+GNhdO/ti/1XlyfF/P09l1elqlymDdYRFdfJiSQSs8u44bQS+oo
         XqHU5s8+eGFcsZwYSBg5gBAcavQN7yi8mXEumkeuZheXDQ13wq//jb95Z+PtyvUnd4
         dpTrSmk39HM8S0aqIlbmFYLu8yJMRQLhcjdhgJSHMurac1lLpduEOQYekGUjIaqbEQ
         zZpcMHoc8AZ+j7G6StXHsxIlU1btHDuPjsNzREvaNprGDvNTuTEkfwEOwQtQZQ+a8w
         GZnCEqo+P1beQ==
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     dan.j.williams@intel.com
Cc:     dave.jiang@intel.com, alison.schofield@intel.com,
        vishal.l.verma@intel.com, ira.weiny@intel.com,
        Jonathan.Cameron@huawei.com, fan.ni@samsung.com,
        a.manzanares@samsung.com, dave@stgolabs.net,
        linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] cxl/pci: Introduce cxl_request_irq()
Date:   Tue, 23 May 2023 10:09:26 -0700
Message-Id: <20230523170927.20685-4-dave@stgolabs.net>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230523170927.20685-1-dave@stgolabs.net>
References: <20230523170927.20685-1-dave@stgolabs.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Factor out common functionality/semantics for cxl shared interrupts
into a new helper on top of devm_request_irq().

Suggested-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 drivers/cxl/pci.c | 39 +++++++++++++++++++++++----------------
 1 file changed, 23 insertions(+), 16 deletions(-)

diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index f2039fe0805d..18b8f3ce680c 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -84,6 +84,27 @@ static int cxl_pci_mbox_wait_for_doorbell(struct cxl_dev_state *cxlds)
 			    status & CXLMDEV_DEV_FATAL ? " fatal" : "",        \
 			    status & CXLMDEV_FW_HALT ? " firmware-halt" : "")
 
+struct cxl_dev_id {
+	struct cxl_dev_state *cxlds;
+};
+
+static int cxl_request_irq(struct cxl_dev_state *cxlds, int irq,
+			   irq_handler_t handler, irq_handler_t thread_fn)
+{
+	struct device *dev = cxlds->dev;
+	struct cxl_dev_id *dev_id;
+
+	/* dev_id must be globally unique and must contain the cxlds */
+	dev_id = devm_kzalloc(dev, sizeof(*dev_id), GFP_KERNEL);
+	if (!dev_id)
+		return -ENOMEM;
+	dev_id->cxlds = cxlds;
+
+	return devm_request_threaded_irq(dev, irq, handler, thread_fn,
+					 IRQF_SHARED | IRQF_ONESHOT,
+					 NULL, dev_id);
+}
+
 /**
  * __cxl_pci_mbox_send_cmd() - Execute a mailbox command
  * @cxlds: The device state to communicate with.
@@ -469,10 +490,6 @@ static int cxl_alloc_irq_vectors(struct pci_dev *pdev)
 	return 0;
 }
 
-struct cxl_dev_id {
-	struct cxl_dev_state *cxlds;
-};
-
 static irqreturn_t cxl_event_thread(int irq, void *id)
 {
 	struct cxl_dev_id *dev_id = id;
@@ -498,28 +515,18 @@ static irqreturn_t cxl_event_thread(int irq, void *id)
 
 static int cxl_event_req_irq(struct cxl_dev_state *cxlds, u8 setting)
 {
-	struct device *dev = cxlds->dev;
-	struct pci_dev *pdev = to_pci_dev(dev);
-	struct cxl_dev_id *dev_id;
+	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
 	int irq;
 
 	if (FIELD_GET(CXLDEV_EVENT_INT_MODE_MASK, setting) != CXL_INT_MSI_MSIX)
 		return -ENXIO;
 
-	/* dev_id must be globally unique and must contain the cxlds */
-	dev_id = devm_kzalloc(dev, sizeof(*dev_id), GFP_KERNEL);
-	if (!dev_id)
-		return -ENOMEM;
-	dev_id->cxlds = cxlds;
-
 	irq =  pci_irq_vector(pdev,
 			      FIELD_GET(CXLDEV_EVENT_INT_MSGNUM_MASK, setting));
 	if (irq < 0)
 		return irq;
 
-	return devm_request_threaded_irq(dev, irq, NULL, cxl_event_thread,
-					 IRQF_SHARED | IRQF_ONESHOT, NULL,
-					 dev_id);
+	return cxl_request_irq(cxlds, irq, NULL, cxl_event_thread);
 }
 
 static int cxl_event_get_int_policy(struct cxl_dev_state *cxlds,
-- 
2.40.1

