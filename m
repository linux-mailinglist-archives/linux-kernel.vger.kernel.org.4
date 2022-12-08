Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BBDF646B89
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 10:09:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbiLHJJL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 04:09:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbiLHJIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 04:08:32 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6209EAB;
        Thu,  8 Dec 2022 01:08:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 48D3961E28;
        Thu,  8 Dec 2022 09:08:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3317C43470;
        Thu,  8 Dec 2022 09:07:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670490480;
        bh=/+A5oXIkfPVqlkdsYp0NLY4/uVwf3XSTDvcavOu+uhM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QEtT/hxnWyXsDOquDQcYrJHOU+tUBHorP+rwZ5QfoNYvcJpM8gsnhSaA5eynkskUB
         7k4QmLPwbfVNjvp+Kio+uBrLcplK8KL43Sa4RpXMaNED+YZ20iw15+95J+DXKYt+2c
         wDRST3S8vXKSzjkwB5fbcunqSLFfP+2mcJqsKGZKgDTxxCsYKJFTGR8q7W5HogLk9s
         lKiXt90jsqDhNQ1+LacP0KRvNcrFZUmugb9MvDk1sUcsrXlr0NQVx9X8lj6CUKs+WG
         KW47TQW5kW/icnbnBka0Pg8DXCrcQhiGD8ynaicHbQeYiS0wLtPonZad5eAXXz9SZP
         lOZE2Q4TLlEZA==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Thomas Winischhofer <thomas@winischhofer.net>,
        linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: [PATCH 3/3] USB: sisusbvga: use module_usb_driver()
Date:   Thu,  8 Dec 2022 10:07:48 +0100
Message-Id: <20221208090749.28056-3-jirislaby@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221208090749.28056-1-jirislaby@kernel.org>
References: <20221208090749.28056-1-jirislaby@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now, that we only do usb_register() and usb_sisusb_exit() in
module_init() and module_exit() respectivelly, we can simply use
module_usb_driver().

Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: Thomas Winischhofer <thomas@winischhofer.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-sh@vger.kernel.org
Cc: linux-usb@vger.kernel.org
Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/usb/misc/sisusbvga/sisusbvga.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/usb/misc/sisusbvga/sisusbvga.c b/drivers/usb/misc/sisusbvga/sisusbvga.c
index a0d5ba8058f8..654a79fd3231 100644
--- a/drivers/usb/misc/sisusbvga/sisusbvga.c
+++ b/drivers/usb/misc/sisusbvga/sisusbvga.c
@@ -2947,18 +2947,7 @@ static struct usb_driver sisusb_driver = {
 	.id_table =	sisusb_table,
 };
 
-static int __init usb_sisusb_init(void)
-{
-	return usb_register(&sisusb_driver);
-}
-
-static void __exit usb_sisusb_exit(void)
-{
-	usb_deregister(&sisusb_driver);
-}
-
-module_init(usb_sisusb_init);
-module_exit(usb_sisusb_exit);
+module_usb_driver(sisusb_driver);
 
 MODULE_AUTHOR("Thomas Winischhofer <thomas@winischhofer.net>");
 MODULE_DESCRIPTION("sisusbvga - Driver for Net2280/SiS315-based USB2VGA dongles");
-- 
2.38.1

