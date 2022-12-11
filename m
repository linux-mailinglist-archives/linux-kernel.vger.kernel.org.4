Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB59564941C
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Dec 2022 13:07:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbiLKMHv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Dec 2022 07:07:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230198AbiLKMHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Dec 2022 07:07:45 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C783116E;
        Sun, 11 Dec 2022 04:07:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B4DE1B80ABE;
        Sun, 11 Dec 2022 12:07:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50E15C433EF;
        Sun, 11 Dec 2022 12:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670760460;
        bh=ZFMbhfh++FcQgRNIpSgAMTmbt1indpVhIyF9Qze3joQ=;
        h=From:To:Cc:Subject:Date:From;
        b=GdZK9R79xhoWOV8Is+SkD4wpTxbU4XmK2kn0VLcl+wxn9oUcoUaucMX9X+0uXes0R
         nvbkrGIHusn7Y43rVDuOIDlF+WdaxqPc61Vv91/aCSp6YB4uEA5u5w1UD7VC3/FR9C
         ASG8PCIRTqbG5YMZL4UJGX0A/uciAIHHBGleXLEKOxY9e3lJZ2bSr9N9BFaMppKeZV
         BBpnIAq2LK4f/65sICEkQXOmTJArHm6nU1zzOiFgVLccz0Nnl9YhGo1WRw0GTZUFDd
         nwYOHQfznzZkloEf1DmkiIgbgm6uyQ45L4xE5zxDvOMECZ43TgJ9UAe1qfY8mNDuB0
         iLFFnLJJh6qYQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1p4L7i-0003Bd-5U; Sun, 11 Dec 2022 13:08:02 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH] USB: drop misleading usb_set_intfdata() kernel doc
Date:   Sun, 11 Dec 2022 13:06:26 +0100
Message-Id: <20221211120626.12210-1-johan@kernel.org>
X-Mailer: git-send-email 2.37.4
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

The struct device driver-data pointer is used for any data that a driver
may need in various callbacks while bound to the device. For
convenience, subsystems typically provide wrappers such as
usb_set_intfdata() of the generic accessor functions for use in bus
callbacks.

There is generally no longer any need for a driver to clear the pointer,
but since commit 0998d0631001 ("device-core: Ensure drvdata = NULL when
no driver is bound") the driver-data pointer is set to NULL by driver
core post unbind anyway.

For historical reasons, USB core also clears this pointer when an
explicitly claimed interface is released.

Due to a misunderstanding, a redundant and misleading kernel doc comment
for usb_set_intfdata() was recently added which claimed that the driver
data pointer must not be cleared during disconnect before "all actions
[are] completed", which is both imprecise and incorrect.

Specifically, drivers like cdc-acm which claim additional interfaces use
the driver-data pointer as a flag which is cleared when the first
interface is unbound. As long as a driver does not do something odd like
dereference the pointer in, for example, completion callbacks, this can
be done at any time during disconnect. And in any case this is no
different than for any other resource, like the driver data itself,
which may be freed by the disconnect callback.

Drop the incorrect and unnecessary comment.

Fixes: 27ef17849779 ("usb: add usb_set_intfdata() documentation")
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 include/linux/usb.h | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/include/linux/usb.h b/include/linux/usb.h
index b47371d44d1b..010c681b8822 100644
--- a/include/linux/usb.h
+++ b/include/linux/usb.h
@@ -266,18 +266,6 @@ static inline void *usb_get_intfdata(struct usb_interface *intf)
 	return dev_get_drvdata(&intf->dev);
 }
 
-/**
- * usb_set_intfdata() - associate driver-specific data with the interface
- * @intf: the usb interface
- * @data: pointer to the device priv structure or %NULL
- *
- * Drivers should use this function in their probe() to associate their
- * driver-specific data with the usb interface.
- *
- * When disconnecting, the core will take care of setting @intf back to %NULL,
- * so no actions are needed on the driver side. The interface should not be set
- * to %NULL before all actions completed (e.g. no outsanding URB remaining).
- */
 static inline void usb_set_intfdata(struct usb_interface *intf, void *data)
 {
 	dev_set_drvdata(&intf->dev, data);
-- 
2.37.4

