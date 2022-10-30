Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C851C612962
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 10:23:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbiJ3JXR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 05:23:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbiJ3JXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 05:23:09 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42F4A314
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 02:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=hTh4rDiW0BSA+UqqtN7qj7huwQMbEDssKGB16Ri5++E=; b=S1W9S9mIlTiGAKmRRB18A8D9fZ
        7JABltjsQm6szULAy6ysof5c3WV/j+2YZ6TykE+4SzfUGsjXtwHcMTnjGYIYviWh+Qh1Q2QezA4O3
        sWGAKll4HGljrDn5J9MOtgEzPcQjjDa52IOkMjQdWZLUWBnUt43IvUiumICxDZqH/avl5Z1b7zZ+R
        JMQSuEgmUFYq+5zyKS4/W3KLMhB6yr5o7qifRKyllTVwGXfcNmhoVsRhQogRadndVnF2nEQDZLbsz
        mafTYOmxxf4TlxmN6E9ISd83d1/bbVQkvn52ckRQ81BFK1hSyYXrQSFkA98yYrPOf4RFPUz0D0ZoV
        M4eekRow==;
Received: from [2001:4bb8:199:6818:1c2a:5f62:2eb:6092] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1op4X5-00EmBD-A1; Sun, 30 Oct 2022 09:23:07 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     gregkh@linuxfoundation.org, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] driver core: mark driver_allows_async_probing static
Date:   Sun, 30 Oct 2022 10:22:55 +0100
Message-Id: <20221030092255.872280-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

driver_allows_async_probing is only used in drivers/base/dd.c, so mark
it static and remove the declaration in drivers/base/base.h.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/base/base.h | 1 -
 drivers/base/dd.c   | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/base/base.h b/drivers/base/base.h
index b902d1ecc247f..7d4803c03d3e6 100644
--- a/drivers/base/base.h
+++ b/drivers/base/base.h
@@ -146,7 +146,6 @@ static inline int driver_match_device(struct device_driver *drv,
 {
 	return drv->bus->match ? drv->bus->match(dev, drv) : 1;
 }
-extern bool driver_allows_async_probing(struct device_driver *drv);
 
 extern int driver_add_groups(struct device_driver *drv,
 			     const struct attribute_group **groups);
diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 3dda62503102f..4001e22617ab0 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -843,7 +843,7 @@ static int __init save_async_options(char *buf)
 }
 __setup("driver_async_probe=", save_async_options);
 
-bool driver_allows_async_probing(struct device_driver *drv)
+static bool driver_allows_async_probing(struct device_driver *drv)
 {
 	switch (drv->probe_type) {
 	case PROBE_PREFER_ASYNCHRONOUS:
-- 
2.30.2

