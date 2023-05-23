Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA5570E3B0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 19:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238242AbjEWRnW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 13:43:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbjEWRnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 13:43:20 -0400
Received: from bird.elm.relay.mailchannels.net (bird.elm.relay.mailchannels.net [23.83.212.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90CD3BF;
        Tue, 23 May 2023 10:43:19 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 908B08813EB;
        Tue, 23 May 2023 17:43:18 +0000 (UTC)
Received: from pdx1-sub0-mail-a250.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 05131881178;
        Tue, 23 May 2023 17:43:18 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1684863798; a=rsa-sha256;
        cv=none;
        b=luzbfbKFOLQLe4ZrZVvuCxA3190+XclyV8OkqTdhegxHgSKiFx8Kw5WIvj4GlHhwXjHPVZ
        DyuZfQWzazbc6n96qyIKCNoi/fLQXrAZ+d34KDCEkcvEof0cG1MbyZluin8hzytjExF+nW
        Sl4vbCY/7aJh/mRns1JHgMbcNWsEI5u1/8nGbQDTxH6LV+6Lh1VzyWtlEPca+cT9QDCGHr
        6eAhzvXbdsqAWLKhkpX3uwHfxbfty5DPa48X83kUTCdXCePmuv1uCwAJOjcJkImjf0ckir
        N2xCg50YYHEEk9UWEuU7yXmKKnJbbXlkYN46TvZrgJBfTda6UKMS7l1mYJpSeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1684863798;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=q16+5TKWGQBnFCEvrQ0mCXF889Dj8R8FUeGnQl+Z3ek=;
        b=D0V/fnMeuNJimd1xkfcWB0rvR69Ei9ppLgsznz8nOrtBcgP8IAloeGSRhFgfBWf7utKjZb
        iqOaEvDo3O69KJvn0Z0o09vJrMutqZqPI9Nh/aSlsv+fKZ0OWsnKNt0vQOp3jKc6yNY39X
        plvWVdxgO5WyDLn3eOsFxk/YxU5bLe6GWMJQHmG+/T6Mg1LLEbkDA3eA1uZhIoBxUVX8hb
        U9vngXg8azfFdEysmZQ3qTx2xAep3qNtSVYvwoLhUCJAVHvPcLcIFVcnZBEbEh88bpOXv+
        Nt0ecuY4yRwn/50I85fu0ilpI6K9xG+4nVQXbuhbd6ziorwPut7PqyIQISwPtg==
ARC-Authentication-Results: i=1;
        rspamd-5cdf8fd7d9-qfmcz;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Imminent-Oafish: 76e7736f5b99efc4_1684863798357_3783108455
X-MC-Loop-Signature: 1684863798357:613861840
X-MC-Ingress-Time: 1684863798357
Received: from pdx1-sub0-mail-a250.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.116.217.246 (trex/6.8.1);
        Tue, 23 May 2023 17:43:18 +0000
Received: from localhost.localdomain (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a250.dreamhost.com (Postfix) with ESMTPSA id 4QQhVs0kVvz6m;
        Tue, 23 May 2023 10:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1684863797;
        bh=q16+5TKWGQBnFCEvrQ0mCXF889Dj8R8FUeGnQl+Z3ek=;
        h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
        b=Fz9qlVSVnW4mj/z8IEHRyUS+EefwhvKeqI7VeOX/TEiGkqOLos8bVNdGnsvWEHs9o
         HnVWhrP//EnMZpL0/BgZiVvuaxHL3vaG67BL8BqIV78Gxv4iX/peZgYEbg9wtA7CuI
         y3saFQI57Y65aXVooTmAiLmrJoqqwesNXlCTvTqomGj80efXW1GKZtke9wAlVI+5IM
         PfpnSe+SKEWtoChe6igCz7X68pQYg3tGLdod8taqhbUhATrKEcop4MkpDt2C9vwAdL
         M+jnx6z6rj26jX+k0m3oK0Ybqfb2gz5b+reehsCgBsWjw/LpjB0xZDwkJxNLOVuSw2
         PSDZLvWhTzJFg==
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     dan.j.williams@intel.com
Cc:     dave.jiang@intel.com, alison.schofield@intel.com,
        vishal.l.verma@intel.com, ira.weiny@intel.com,
        Jonathan.Cameron@huawei.com, fan.ni@samsung.com,
        a.manzanares@samsung.com, dave@stgolabs.net,
        linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] cxl/pci: Allocate irq vectors earlier during probe
Date:   Tue, 23 May 2023 10:09:25 -0700
Message-Id: <20230523170927.20685-3-dave@stgolabs.net>
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

Move the cxl_alloc_irq_vectors() call further up in the probing
in order to allow for mailbox interrupt usage. No change in
semantics.

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 drivers/cxl/pci.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 0872f2233ed0..f2039fe0805d 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -714,6 +714,10 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	else
 		dev_warn(&pdev->dev, "Media not active (%d)\n", rc);
 
+	rc = cxl_alloc_irq_vectors(pdev);
+	if (rc)
+		return rc;
+
 	rc = cxl_pci_setup_mailbox(cxlds);
 	if (rc)
 		return rc;
@@ -738,10 +742,6 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (rc)
 		return rc;
 
-	rc = cxl_alloc_irq_vectors(pdev);
-	if (rc)
-		return rc;
-
 	cxlmd = devm_cxl_add_memdev(cxlds);
 	if (IS_ERR(cxlmd))
 		return PTR_ERR(cxlmd);
-- 
2.40.1

