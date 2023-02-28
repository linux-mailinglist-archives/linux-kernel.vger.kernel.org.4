Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12B3F6A5302
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 07:32:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbjB1GcV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 01:32:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbjB1GcT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 01:32:19 -0500
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6572C29141
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 22:32:16 -0800 (PST)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20230228063214fc6f5f3fde900ef331
        for <linux-kernel@vger.kernel.org>;
        Tue, 28 Feb 2023 07:32:14 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=daniel.starke@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=BSVe7O2t8AoVIgNh+LgCt8w0mdAVj5U58ZYwaeF0sSM=;
 b=QnNnaNTnzcsDKbjZj/qUHE8nt3ZOu4Idg1HVRljSi8KYXns0oKFs++JbAWvhPK+4DV+fvb
 1+M+3Nt3oq276FpxXD2dh131GO/HQq/Ydo6f+xaBZ/J7GO5oGdEtRuFZMVw8w/AZG6+aucIB
 twYrCJSUOJExzy1ISWZepS2GVs0LU=;
From:   "D. Starke" <daniel.starke@siemens.com>
To:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, ilpo.jarvinen@linux.intel.com
Cc:     linux-kernel@vger.kernel.org,
        Daniel Starke <daniel.starke@siemens.com>
Subject: [PATCH 2/3] tty: n_gsm: allow window size configuration
Date:   Tue, 28 Feb 2023 07:29:56 +0100
Message-Id: <20230228062957.3150-2-daniel.starke@siemens.com>
In-Reply-To: <20230228062957.3150-1-daniel.starke@siemens.com>
References: <20230228062957.3150-1-daniel.starke@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-314044:519-21489:flowmailer
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 3ca33149c339..494657e8535d 100644
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

