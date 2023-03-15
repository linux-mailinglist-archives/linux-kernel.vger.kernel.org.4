Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 039686BAE40
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 11:55:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbjCOKzR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 06:55:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbjCOKzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 06:55:13 -0400
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE64E38664
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 03:55:10 -0700 (PDT)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20230315105508c77470d0ee4c03592a
        for <linux-kernel@vger.kernel.org>;
        Wed, 15 Mar 2023 11:55:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=daniel.starke@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=wWXnI0SkCooJMA0/xwXnc2tbsdTrHiS7iL7LzBlT/8I=;
 b=Ps8EWqpJu0XIKUeZoCPnNyId0MgnqxC8kvU+IC+/TqRIBJYNDdSZZEEoTrAkkpVkz9zIRf
 9JrD8IlfUbg1o8ECIDm5YUDmBXjg4JPeKWNE6sKcjz32IEgf5gb5b4J0Q1vTKq6SFnccE/Or
 yTEcq0NGLSzyk4tJBYk2f99ZBjQVQ=;
From:   "D. Starke" <daniel.starke@siemens.com>
To:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, ilpo.jarvinen@linux.intel.com
Cc:     linux-kernel@vger.kernel.org,
        Daniel Starke <daniel.starke@siemens.com>
Subject: [PATCH v2 2/3] tty: n_gsm: allow window size configuration
Date:   Wed, 15 Mar 2023 11:53:53 +0100
Message-Id: <20230315105354.6234-2-daniel.starke@siemens.com>
In-Reply-To: <20230315105354.6234-1-daniel.starke@siemens.com>
References: <20230315105354.6234-1-daniel.starke@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-314044:519-21489:flowmailer
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Starke <daniel.starke@siemens.com>

n_gsm is based on the 3GPP 07.010 and its newer version is the 3GPP 27.010.
See https://portal.3gpp.org/desktopmodules/Specifications/SpecificationDetails.aspx?specificationId=1516
The changes from 07.010 to 27.010 are non-functional. Therefore, I refer to
the newer 27.010 here. Chapter 6 describes the error recovery mode option
which is based on I frames. The k parameter defines the maximum number of
I frames that a DLC can have unacknowledged as described in chapter 5.7.4.
The current n_gsm implementation does not support the error recovery mode
option. However, the k parameter is also part of the parameter negotiation
message as described in chapter 5.4.6.3.1. Chapter 5.7.4 also notes that
the allowed value range for k is 1-7. That means a 0 is counted as invalid
here. This means that the user needs to configure a valid value here even
if the function itself is not supported. Otherwise, parameter negotiation
may fail.

Allow setting of k via ioctl in gsm_config(). Range checks are already
included.

Signed-off-by: Daniel Starke <daniel.starke@siemens.com>
---
 drivers/tty/n_gsm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

v1 -> v2:
No changes.

Link: https://lore.kernel.org/all/20230228062957.3150-2-daniel.starke@siemens.com/

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 9d0e7701ffd4..5bbedfc36fd1 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -3276,8 +3276,8 @@ static int gsm_config(struct gsm_mux *gsm, struct gsm_config *c)
 	int need_close = 0;
 	int need_restart = 0;
 
-	/* Stuff we don't support yet - UI or I frame transport, windowing */
-	if ((c->adaption != 1 && c->adaption != 2) || c->k)
+	/* Stuff we don't support yet - UI or I frame transport */
+	if (c->adaption != 1 && c->adaption != 2)
 		return -EOPNOTSUPP;
 	/* Check the MRU/MTU range looks sane */
 	if (c->mru < MIN_MTU || c->mtu < MIN_MTU)
-- 
2.34.1

