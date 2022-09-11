Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E1105B4F4F
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 16:03:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230448AbiIKOD2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 10:03:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230333AbiIKODM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 10:03:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 660D433A19;
        Sun, 11 Sep 2022 07:03:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ED68D61041;
        Sun, 11 Sep 2022 14:03:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF5CCC4314F;
        Sun, 11 Sep 2022 14:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662904989;
        bh=4VDAeDrDE5XmmwiLBFA5Z5Gow6FH/LGJWnAEFdy77bw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e6qh9CEkMZATgzZDsl0E9mTtdXTFCNPVt7FW55dI5eLClbbr0C65y6TBy1gjk68ei
         Z9A6aEDtz+spf/X/dO69TZ88Xol4XrLAJ6yLsf/A4qKObqGehX8i/A9z+n5z5d3bdh
         T8FkQf72RWqDLYzcnRlFxungHLJfni6qPYuC++Brtiqa+FowZWuwXqhLXhKS7b5I/M
         TOwFwSc6ICsLNuuxu8d7q5mw3T3oMHX2mLYA3uZ3gt8hyFZfIq0mX6ev6f2sV5cQ24
         VN2aFwKzxYFtMrYMPFqDZmzdUjoZ6vCYg22Q9YjglNXvlwCauOAa9yRIVxOCrjUvNg
         dZb4L3zG9sbaA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oXNYM-0007x1-Dh; Sun, 11 Sep 2022 16:03:18 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Amireddy mallikarjuna reddy <mallikarjuna.reddy@ftdichip.com>,
        arun.pappan@ftdichip.com, sowjanya.reddy@ftdichip.com,
        malliamireddy009@gmail.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 11/12] USB: serial: ftdi_sio: simplify divisor handling
Date:   Sun, 11 Sep 2022 16:02:15 +0200
Message-Id: <20220911140216.30481-12-johan@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220911140216.30481-1-johan@kernel.org>
References: <20220911140216.30481-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for adding further Hi-Speed types, assume the device type
is Hi-Speed unless it's an explicitly listed legacy type when
determining divisors.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/ftdi_sio.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/usb/serial/ftdi_sio.c b/drivers/usb/serial/ftdi_sio.c
index a43101000ee3..e9f508e31876 100644
--- a/drivers/usb/serial/ftdi_sio.c
+++ b/drivers/usb/serial/ftdi_sio.c
@@ -1370,9 +1370,7 @@ static u32 get_ftdi_divisor(struct tty_struct *tty,
 			baud = 9600;
 		}
 		break;
-	case FT2232H:
-	case FT4232H:
-	case FT232H:
+	default:
 		if ((baud <= 12000000) && (baud >= 1200)) {
 			div_value = ftdi_2232h_baud_to_divisor(baud);
 		} else if (baud < 1200) {
-- 
2.35.1

