Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B39B7216F6
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jun 2023 14:35:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230475AbjFDMfB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 08:35:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbjFDMe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 08:34:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D41CDD2;
        Sun,  4 Jun 2023 05:34:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 551126168A;
        Sun,  4 Jun 2023 12:34:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A627CC433A1;
        Sun,  4 Jun 2023 12:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685882095;
        bh=uSiepLtWjVhXcCAJfRm0oQIqf205bq5k7/+2TYyI62A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HVm95rU2CTfgP+eezc4CeuRqfmOHm6twlNyd3vAM8q5LESTSzBYDIvxXsck9a+yNT
         JZiMgMyRIlSLkKvEnel+7t8TlVDgiiCIRsSJPB4MLV05UaKDNaFi5SSqhiVq1KzMl8
         +p6oP78Teup6GcxJkkZQfcJ2u5mhg5L0KoTw/tP3q1qYKNyaQ8eIjK6STeHM3lEWpk
         PhLenYtZ9xYevvkneySJ1f8A8hF6gAuuAbHfJG25Qw+7+oGmbFUxFwWD0uT7JGFSBG
         cvlKjsYi+5B2qst2qMY53xFS3wwXY/8rwmUGFTz4/b/LWVm1NMICDxEZqZ/sLfFaDy
         k7GGJUSglGmyg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1q5mww-0001DZ-Ou; Sun, 04 Jun 2023 14:35:10 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Corey Minyard <minyard@acm.org>
Subject: [PATCH v2 3/3] USB: serial: report unsupported break signalling
Date:   Sun,  4 Jun 2023 14:35:05 +0200
Message-Id: <20230604123505.4661-4-johan@kernel.org>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230604123505.4661-1-johan@kernel.org>
References: <20230604123505.4661-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of returning success when a driver does not support break
signalling, return an error to let user space know and to avoid waiting
when break is not supported.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/usb-serial.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/serial/usb-serial.c b/drivers/usb/serial/usb-serial.c
index 470634444af7..7b4805c1004d 100644
--- a/drivers/usb/serial/usb-serial.c
+++ b/drivers/usb/serial/usb-serial.c
@@ -541,7 +541,7 @@ static int serial_break(struct tty_struct *tty, int break_state)
 	if (port->serial->type->break_ctl)
 		return port->serial->type->break_ctl(tty, break_state);
 
-	return 0;
+	return -ENOTTY;
 }
 
 static int serial_proc_show(struct seq_file *m, void *v)
-- 
2.39.3

