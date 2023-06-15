Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87CF47322A4
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 00:22:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235592AbjFOWV6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 18:21:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjFOWV4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 18:21:56 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEF541AA;
        Thu, 15 Jun 2023 15:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=dPvqZvPWD49EZocndBE+cOq6aWcEwgx21IcCTV3kPWU=; b=nJ5DGLdPFffwE/nRtF4TzMX1UU
        zbGuSTqzi3o+p7SQEQWb4v/wgmb9os811DUaQP4cisvEG+awPlPJuKZELSJ2Dq94TCE7T4HNsHv13
        hBl0egJz5Ct+nk9Ds7bvNB3Q0mlzpJXPg//v39x9o22aVkmCxVDFU1KHzpG0lJymj9rdHWAkMQFpM
        U9nJ2tkgGEC9bZSikUnI+HdR6zlGS91a0weqGJyZacE2EknEjEx+gunCIPecSLLhvY0poayxCA3Yr
        XW6wbKGlpoDcyDCFeQ5cGYIKuZg3ljaUhIzgHPvhPWxDAkVcxPYS0cgdBy5K1tzJsNFP/6H1QZbnm
        oqNVar3g==;
Received: from [2601:1c2:980:9ec0::2764] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q9vLn-00GEwb-1d;
        Thu, 15 Jun 2023 22:21:55 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Alexandra Winter <wintera@linux.ibm.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>
Subject: [PATCH] s390/net: lcs: use IS_ENABLED() for kconfig detection
Date:   Thu, 15 Jun 2023 15:21:52 -0700
Message-ID: <20230615222152.13250-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_ETHERNET=m or CONFIG_FDDI=m, lcs.s has build errors or
warnings:

../drivers/s390/net/lcs.c:40:2: error: #error Cannot compile lcs.c without some net devices switched on.
   40 | #error Cannot compile lcs.c without some net devices switched on.
../drivers/s390/net/lcs.c: In function 'lcs_startlan_auto':
../drivers/s390/net/lcs.c:1601:13: warning: unused variable 'rc' [-Wunused-variable]
 1601 |         int rc;

Solve this by using IS_ENABLED(CONFIG_symbol) instead of ifdef
CONFIG_symbol. The latter only works for builtin (=y) values
while IS_ENABLED() works for builtin or modular values.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Alexandra Winter <wintera@linux.ibm.com>
Cc: Wenjia Zhang <wenjia@linux.ibm.com>
Cc: linux-s390@vger.kernel.org
Cc: netdev@vger.kernel.org
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Sven Schnelle <svens@linux.ibm.com>
---
 drivers/s390/net/lcs.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff -- a/drivers/s390/net/lcs.c b/drivers/s390/net/lcs.c
--- a/drivers/s390/net/lcs.c
+++ b/drivers/s390/net/lcs.c
@@ -36,7 +36,7 @@
 #include "lcs.h"
 
 
-#if !defined(CONFIG_ETHERNET) && !defined(CONFIG_FDDI)
+#if !IS_ENABLED(CONFIG_ETHERNET) && !IS_ENABLED(CONFIG_FDDI)
 #error Cannot compile lcs.c without some net devices switched on.
 #endif
 
@@ -1601,14 +1601,14 @@ lcs_startlan_auto(struct lcs_card *card)
 	int rc;
 
 	LCS_DBF_TEXT(2, trace, "strtauto");
-#ifdef CONFIG_ETHERNET
+#if IS_ENABLED(CONFIG_ETHERNET)
 	card->lan_type = LCS_FRAME_TYPE_ENET;
 	rc = lcs_send_startlan(card, LCS_INITIATOR_TCPIP);
 	if (rc == 0)
 		return 0;
 
 #endif
-#ifdef CONFIG_FDDI
+#if IS_ENABLED(CONFIG_FDDI)
 	card->lan_type = LCS_FRAME_TYPE_FDDI;
 	rc = lcs_send_startlan(card, LCS_INITIATOR_TCPIP);
 	if (rc == 0)
@@ -2139,13 +2139,13 @@ lcs_new_device(struct ccwgroup_device *c
 		goto netdev_out;
 	}
 	switch (card->lan_type) {
-#ifdef CONFIG_ETHERNET
+#if IS_ENABLED(CONFIG_ETHERNET)
 	case LCS_FRAME_TYPE_ENET:
 		card->lan_type_trans = eth_type_trans;
 		dev = alloc_etherdev(0);
 		break;
 #endif
-#ifdef CONFIG_FDDI
+#if IS_ENABLED(CONFIG_FDDI)
 	case LCS_FRAME_TYPE_FDDI:
 		card->lan_type_trans = fddi_type_trans;
 		dev = alloc_fddidev(0);
