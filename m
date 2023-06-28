Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4975A740A0D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 09:57:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230522AbjF1H4t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 03:56:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230295AbjF1Hyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 03:54:40 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB2D52D72;
        Wed, 28 Jun 2023 00:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=hVxHcQDl4192w9qi7Ylg1NcjDzorbdlRCndnD2dfwgQ=; b=vmfnbxTtOhtOhGHRjex1Rz+I7Z
        I/2VKIGIH73E60M8aqp169FEN9Bd4ii/ZTTB0jVb7bj8xJO1eoOEG3w/i6GhsRSAMvLOuPAjK2DWf
        jym6TL2Ysxzyh576Vz98Pyz0fxXGQ3bdeEDtvpThWMWLqdigWzGZ+tjLSTUfAcGFxSq8rXI1elKdV
        tQo8qYyIP6qXzhagvJXsg95FOHA+CLdTXdR8UocGW/mCyQZIdyaubInOl3M8A3MhCVGJxIq950PkN
        QJ3wW4bcQEamrZum50yKwXV8svYgk37SBUNl9SUkbmcvdlxlIdJZSiHzdtOj/qXQFJWqaqvfgR5Zh
        MwBzIUwg==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qENNr-00EqSq-0y;
        Wed, 28 Jun 2023 05:06:27 +0000
Message-ID: <510b6216-35e5-5ea1-525f-5fab35b901e0@infradead.org>
Date:   Tue, 27 Jun 2023 22:06:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH] s390/net: lcs: fix build errors when FDDI is a loadable
 module
Content-Language: en-US
From:   Randy Dunlap <rdunlap@infradead.org>
To:     Alexandra Winter <wintera@linux.ibm.com>,
        Simon Horman <simon.horman@corigine.com>
Cc:     linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Simon Horman <simon.horman@corigine.com>
References: <20230621213742.8245-1-rdunlap@infradead.org>
 <98375832-3d29-1f03-145f-8d6e763dd2d2@linux.ibm.com>
 <ZJP99hSRt5MakBXC@corigine.com>
 <3da03251-21ac-b41f-593d-cbc9ac9f86f6@linux.ibm.com>
 <7f585168-7296-58aa-7fdb-c2aa08f346f4@infradead.org>
In-Reply-To: <7f585168-7296-58aa-7fdb-c2aa08f346f4@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexandra, Simon, others,

Here is v2 of this patch. I will send it formally after the merge window closes.

Thanks for all of your help.
---

From: Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v2 net] s390/net: lcs: use IS_ENABLED() for kconfig detection

When CONFIG_ETHERNET is disabled and CONFIG_FDDI=m, lcs.s has build
errors or warnings:

../drivers/s390/net/lcs.c:40:2: error: #error Cannot compile lcs.c without some net devices switched on.
   40 | #error Cannot compile lcs.c without some net devices switched on.
../drivers/s390/net/lcs.c: In function 'lcs_startlan_auto':
../drivers/s390/net/lcs.c:1601:13: warning: unused variable 'rc' [-Wunused-variable]
 1601 |         int rc;

Solve this by using IS_ENABLED(CONFIG_symbol) instead of ifdef
CONFIG_symbol. The latter only works for builtin (=y) values
while IS_ENABLED() works for builtin or modular values.

Modify the LCS Kconfig entry to allow combinations of builtin and
modular drivers to work as long as LCS <= FDDI (where n < m < y)
if FDDI is enabled. If FDDI is not enabled, ETHERNET must be =y,
so LCS can be builtin or modular since ETHERNET is a bool.

Remove the #error directive in the source file since the Kconfig
modification prevents that error combination.

Tested successfully with all possible combinations of ETHERNET, FDDI,
and LCS.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Suggested-by: Alexandra Winter <wintera@linux.ibm.com>
Cc: Wenjia Zhang <wenjia@linux.ibm.com>
Cc: linux-s390@vger.kernel.org
Cc: netdev@vger.kernel.org
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Sven Schnelle <svens@linux.ibm.com>
Cc: Simon Horman <simon.horman@corigine.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
---
 drivers/s390/net/Kconfig |    1 +
 drivers/s390/net/lcs.c   |   13 ++++---------
 2 files changed, 5 insertions(+), 9 deletions(-)

diff -- a/drivers/s390/net/Kconfig b/drivers/s390/net/Kconfig
--- a/drivers/s390/net/Kconfig
+++ b/drivers/s390/net/Kconfig
@@ -6,6 +6,7 @@ config LCS
 	def_tristate m
 	prompt "Lan Channel Station Interface"
 	depends on CCW && NETDEVICES && (ETHERNET || FDDI)
+	depends on FDDI || FDDI=n
 	help
 	  Select this option if you want to use LCS networking on IBM System z.
 	  This device driver supports FDDI (IEEE 802.7) and Ethernet.
diff -- a/drivers/s390/net/lcs.c b/drivers/s390/net/lcs.c
--- a/drivers/s390/net/lcs.c
+++ b/drivers/s390/net/lcs.c
@@ -35,11 +35,6 @@
 
 #include "lcs.h"
 
-
-#if !defined(CONFIG_ETHERNET) && !defined(CONFIG_FDDI)
-#error Cannot compile lcs.c without some net devices switched on.
-#endif
-
 /*
  * initialization string for output
  */
@@ -1601,14 +1596,14 @@ lcs_startlan_auto(struct lcs_card *card)
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
@@ -2140,13 +2135,13 @@ lcs_new_device(struct ccwgroup_device *c
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

