Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B27516B1DCC
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 09:23:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbjCIIXC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 03:23:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbjCIIWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 03:22:42 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DD4FE0617;
        Thu,  9 Mar 2023 00:20:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678350057; x=1709886057;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iSFAeXMyb15nLeLM23ofC0opCVrv3Repl2TyKJV+3ME=;
  b=Q+2matrx/83DeMYzNB5f34pI/60OgDfKQz0h299Pr14d7016bVpxLyM+
   +faufy1rxg3ypb0vKK5XveuQBYQtKW6ei1wNa6iUNot2zWqsY2nFX0mKP
   U6//IjytTCLH6b9x9iuJ+CoTjNMrlQ2qFOvn4PqYHjd//v9aA6VuDNGrz
   DZl9q0Ne6EDz0L0p+yRuZCDtHxfBZWEiMjC8c7zNB+YV4WpZYLgxmnGic
   bjDJoagWDqH77zaG7F5FjaIU9bnOveQrV7AglBP/j7xk56L8XOjlYagaE
   EKRgK+FvJY52zPVx/uXPU2GPT7CZvLGsCRZjFfAQPSefKH0agBAIU+hWX
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="364025743"
X-IronPort-AV: E=Sophos;i="5.98,245,1673942400"; 
   d="scan'208";a="364025743"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2023 00:20:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="787473852"
X-IronPort-AV: E=Sophos;i="5.98,245,1673942400"; 
   d="scan'208";a="787473852"
Received: from unknown (HELO ijarvine-MOBL2.mshome.net) ([10.237.66.35])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2023 00:20:55 -0800
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 1/8] n_tty: Convert no_space_left to space_left boolean
Date:   Thu,  9 Mar 2023 10:20:28 +0200
Message-Id: <20230309082035.14880-2-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230309082035.14880-1-ilpo.jarvinen@linux.intel.com>
References: <20230309082035.14880-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The no_space_left variable is only assigned with 0 and 1.

Change its type to boolean and move negation from its name into the
check.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/n_tty.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index c8f56c9b1a1c..4fc5bd166e56 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -625,7 +625,7 @@ static size_t __process_echoes(struct tty_struct *tty)
 		c = echo_buf(ldata, tail);
 		if (c == ECHO_OP_START) {
 			unsigned char op;
-			int no_space_left = 0;
+			bool space_left = true;
 
 			/*
 			 * Since add_echo_byte() is called without holding
@@ -664,7 +664,7 @@ static size_t __process_echoes(struct tty_struct *tty)
 				num_bs = 8 - (num_chars & 7);
 
 				if (num_bs > space) {
-					no_space_left = 1;
+					space_left = false;
 					break;
 				}
 				space -= num_bs;
@@ -690,7 +690,7 @@ static size_t __process_echoes(struct tty_struct *tty)
 			case ECHO_OP_START:
 				/* This is an escaped echo op start code */
 				if (!space) {
-					no_space_left = 1;
+					space_left = false;
 					break;
 				}
 				tty_put_char(tty, ECHO_OP_START);
@@ -710,7 +710,7 @@ static size_t __process_echoes(struct tty_struct *tty)
 				 *
 				 */
 				if (space < 2) {
-					no_space_left = 1;
+					space_left = false;
 					break;
 				}
 				tty_put_char(tty, '^');
@@ -720,7 +720,7 @@ static size_t __process_echoes(struct tty_struct *tty)
 				tail += 2;
 			}
 
-			if (no_space_left)
+			if (!space_left)
 				break;
 		} else {
 			if (O_OPOST(tty)) {
-- 
2.30.2

