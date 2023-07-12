Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20065750257
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 11:02:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233188AbjGLJCA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 05:02:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232487AbjGLJBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 05:01:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14F451BFB;
        Wed, 12 Jul 2023 01:59:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A6D24616E6;
        Wed, 12 Jul 2023 08:59:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E6DBC433C9;
        Wed, 12 Jul 2023 08:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689152394;
        bh=BR+iCpSuQ7vxUhB+UPskQqo1D8fyS+p3rbke57h/srY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=koAZdbFhYit8+IZ+/sRyA0ny8Ba4SKLjFvY3BBuxstMtA/AsdoJZJ6Pjrr6IdRc9S
         Q4ZDSiDq12k8y1EjsHEA3nHJaNHxSRlSMpqkkpyceqFYmU+4MMt2y0iQBNsoYLenYZ
         nMqrdNFAYDH7199G/Z9c6owb80OAR5qI+T2D74HnAzwUc1f7ZNtIzoOZeAMwDc32VB
         hTyCX2R7tDYpBvMfmhQ3b4VHFeoKvasKZSmyNYEF6XDvCbb/Tk8cGX9x+Xn5/K77Iq
         CZcV6wTzt3WVjpHsgTJJkW8IOpEQv/JxMuxJysuffxhSffvDhZKXAClzW+S0DKaFMo
         kfcugQulRuodg==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
        Helge Deller <deller@gmx.de>, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 4/7] vgacon: let vgacon_doresize() return void
Date:   Wed, 12 Jul 2023 10:59:39 +0200
Message-ID: <20230712085942.5064-5-jirislaby@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230712085942.5064-1-jirislaby@kernel.org>
References: <20230712085942.5064-1-jirislaby@kernel.org>
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

The return value is neither used, nor vgacon_doresize() returns an
error. So change the reurn type to void.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
---
 drivers/video/console/vgacon.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/video/console/vgacon.c b/drivers/video/console/vgacon.c
index 7cb15851ea56..07f6b97d9b81 100644
--- a/drivers/video/console/vgacon.c
+++ b/drivers/video/console/vgacon.c
@@ -528,7 +528,7 @@ static void vgacon_cursor(struct vc_data *c, int mode)
 	}
 }
 
-static int vgacon_doresize(struct vc_data *c,
+static void vgacon_doresize(struct vc_data *c,
 		unsigned int width, unsigned int height)
 {
 	unsigned long flags;
@@ -587,7 +587,6 @@ static int vgacon_doresize(struct vc_data *c,
 	}
 
 	raw_spin_unlock_irqrestore(&vga_lock, flags);
-	return 0;
 }
 
 static int vgacon_switch(struct vc_data *c)
-- 
2.41.0

