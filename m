Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DFFF650B04
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 12:59:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231942AbiLSL6g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 06:58:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231690AbiLSL6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 06:58:16 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F9E3F039;
        Mon, 19 Dec 2022 03:58:15 -0800 (PST)
Received: from umang.jainideasonboard.com (unknown [IPv6:2401:4900:1f3e:7d24:3f0:3e81:fb16:ab4d])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id AF18C825;
        Mon, 19 Dec 2022 12:58:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1671451094;
        bh=U4AsQkzYd1PDi/2MceWavcKccSKSoRxFVZd5HokQOSM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VJ/3b6+7HMvZn1HMYMUJndDv2VTxgGfZCPJ7bQVANEjCfQopAZxUz/UvTnuXAjsHy
         KGCQsAn4REpMFKCxVXJUIgvWe124ah8A0GMdfRuOlysHmzm+TA4pxqC9pPlOPEq21w
         JpKKwvg81MM/K70epa92UL16yF53SVst+ZC2TvT8=
From:   Umang Jain <umang.jain@ideasonboard.com>
To:     linux-staging@lists.linux.dev,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Adrien Thierry <athierry@redhat.com>,
        Dan Carpenter <error27@gmail.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Umang Jain <umang.jain@ideasonboard.com>
Subject: [PATCH v2 5/7] vc04_services: vchiq_arm: Drop VCHIQ_RETRY usage on disconnect
Date:   Mon, 19 Dec 2022 17:27:23 +0530
Message-Id: <20221219115725.11992-6-umang.jain@ideasonboard.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221219115725.11992-1-umang.jain@ideasonboard.com>
References: <20221219115725.11992-1-umang.jain@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the usage of VCHIQ_RETRY when the vchiq has connection status
VCHIQ_CONNSTATE_DISCONNECTED. Disconnected status will not be valid to
carry on a retry, replace the VCHIQ_RETRY with -ENOTCONN.

This patch removes the usage of vCHIQ_RETRY completely and act as
intermediatory to address the TODO item:
	* Get rid of custom function return values
for vc04_services/interface.

Fixes: 71bad7f08641 ("staging: add bcm2708 vchiq driver")
Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
---
 .../staging/vc04_services/interface/vchiq_arm/vchiq_core.c    | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
index 9c64d5de810e..ddb6d0f4daed 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
@@ -3641,7 +3641,7 @@ vchiq_loud_error_footer(void)
 int vchiq_send_remote_use(struct vchiq_state *state)
 {
 	if (state->conn_state == VCHIQ_CONNSTATE_DISCONNECTED)
-		return VCHIQ_RETRY;
+		return -ENOTCONN;
 
 	return queue_message(state, NULL, MAKE_REMOTE_USE, NULL, NULL, 0, 0);
 }
@@ -3649,7 +3649,7 @@ int vchiq_send_remote_use(struct vchiq_state *state)
 int vchiq_send_remote_use_active(struct vchiq_state *state)
 {
 	if (state->conn_state == VCHIQ_CONNSTATE_DISCONNECTED)
-		return VCHIQ_RETRY;
+		return -ENOTCONN;
 
 	return queue_message(state, NULL, MAKE_REMOTE_USE_ACTIVE,
 			     NULL, NULL, 0, 0);
-- 
2.38.1

