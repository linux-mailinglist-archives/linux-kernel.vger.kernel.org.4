Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF6026882C5
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 16:37:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232771AbjBBPhM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 10:37:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232889AbjBBPgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 10:36:46 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 538E44F86B;
        Thu,  2 Feb 2023 07:36:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CAF0DB826AD;
        Thu,  2 Feb 2023 15:33:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1103CC4339C;
        Thu,  2 Feb 2023 15:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1675351999;
        bh=LxA279H1FvrJsAusP/AZ5gRL/bHuKKZsq2ugyns8LMw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nI3g5+y7Skra/emw8kuhlV9ktB54HmaJDyN9sJzPlqo2gT+e3C4eBZPR45Q0u0aTR
         IFhRpwUt1zN7PyvBl4KkQYwzP378dY0AnGSMaorT+oBkD74KNcivMoZ12rtxkZhLND
         IpbzE1DsHQB4xwq9QJ/X3HcY9OlL3vNXM/yKZzzc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-usb@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Jakob Koschel <jakobkoschel@gmail.com>,
        Miaoqian Lin <linmq006@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 10/13] USB: gadget: lpc32xx_udc: fix memory leak with using debugfs_lookup()
Date:   Thu,  2 Feb 2023 16:32:32 +0100
Message-Id: <20230202153235.2412790-10-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230202153235.2412790-1-gregkh@linuxfoundation.org>
References: <20230202153235.2412790-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1121; i=gregkh@linuxfoundation.org; h=from:subject; bh=LxA279H1FvrJsAusP/AZ5gRL/bHuKKZsq2ugyns8LMw=; b=owGbwMvMwCRo6H6F97bub03G02pJDMm3r086e3N95v++mDfTLTbt0d/4QEnTJjFWIcH9wqPd6inn b1mc7ohlYRBkYpAVU2T5so3n6P6KQ4pehranYeawMoEMYeDiFICJLGljmF8ovfvh1wSfn47J/rqXPE Js3l270cawYI17wtnLkyWb380Kjgz0Fo07PCvkLQA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When calling debugfs_lookup() the result must have dput() called on it,
otherwise the memory will leak over time.  To make things simpler, just
call debugfs_lookup_and_remove() instead which handles all of the logic
at once.

Cc: Vladimir Zapolskiy <vz@mleia.com>
Cc: Jakob Koschel <jakobkoschel@gmail.com>
Cc: Miaoqian Lin <linmq006@gmail.com>
Cc: linux-usb@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/gadget/udc/lpc32xx_udc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/udc/lpc32xx_udc.c b/drivers/usb/gadget/udc/lpc32xx_udc.c
index cea10cdb83ae..fe62db32dd0e 100644
--- a/drivers/usb/gadget/udc/lpc32xx_udc.c
+++ b/drivers/usb/gadget/udc/lpc32xx_udc.c
@@ -532,7 +532,7 @@ static void create_debug_file(struct lpc32xx_udc *udc)
 
 static void remove_debug_file(struct lpc32xx_udc *udc)
 {
-	debugfs_remove(debugfs_lookup(debug_filename, NULL));
+	debugfs_lookup_and_remove(debug_filename, NULL);
 }
 
 #else
-- 
2.39.1

