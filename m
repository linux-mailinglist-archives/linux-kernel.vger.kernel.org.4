Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6177064A407
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 16:20:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232495AbiLLPU0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 10:20:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232277AbiLLPUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 10:20:23 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF541643B;
        Mon, 12 Dec 2022 07:20:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9548061025;
        Mon, 12 Dec 2022 15:20:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0123CC433EF;
        Mon, 12 Dec 2022 15:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670858422;
        bh=mQpk7CV3/z1ODSFrCA9tNUlmPZ5Zr00nwKY2/kfEgoo=;
        h=From:To:Cc:Subject:Date:From;
        b=Zc9FN1Z1Kg/d5T13VaxnN9rlF2TLPKddbuT4fHVvhW0+MXfPP0egqSZIrNYNClL8i
         uR93FJ9ti+aTZ3CSKpKSC7Tk1Ka9JX/qmJo37uOH+Y12wJHZlE3Xm5Mcey6kxpONV0
         5rMRj4DwtI5M7TZtS5TTe7iyohAXSy+iKv8PmffSyEnUaACmriGiWXm1QpyHLkHgvy
         UmBgra6/awuycT1c7+9Ozo+51X01o+mhWOH9Qtw5ppa7RRg0mo9YLKI2qq9GJ/k1eE
         o17XyZKVaAfNTwf0a73DS9TuOaLwMaeylQpIZY8TSkdExZX23krpf7YltyHIY7H9HN
         stF9bojCpHmlQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1p4kbk-0008He-E9; Mon, 12 Dec 2022 16:20:45 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        Oliver Neukum <oneukum@suse.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: [PATCH v2] USB: fix misleading usb_set_intfdata() kernel doc
Date:   Mon, 12 Dec 2022 16:20:35 +0100
Message-Id: <20221212152035.31806-1-johan@kernel.org>
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

Due to a misunderstanding, a misleading kernel doc comment for
usb_set_intfdata() was recently added which claimed that the driver data
pointer must not be cleared during disconnect before "all actions [are]
completed", which is both imprecise and incorrect.

Specifically, drivers like cdc-acm which claim additional interfaces use
the driver-data pointer as a flag which is cleared when the first
interface is unbound. As long as a driver does not do something odd like
dereference the pointer in, for example, completion callbacks, this can
be done at any time during disconnect. And in any case this is no
different than for any other resource, like the driver data itself,
which may be freed by the disconnect callback.

Note that the comment actually also claimed that the interface itself
was somehow being set to NULL by driver core.

Fix the kernel doc by removing incorrect, overly specific and misleading
details and adding a comment about why some drivers do clear the
driver-data pointer.

Fixes: 27ef17849779 ("usb: add usb_set_intfdata() documentation")
Signed-off-by: Johan Hovold <johan@kernel.org>
---

Changes in v2
 - fix up rather than drop the comment


 include/linux/usb.h | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/include/linux/usb.h b/include/linux/usb.h
index b47371d44d1b..8a32e17f826e 100644
--- a/include/linux/usb.h
+++ b/include/linux/usb.h
@@ -267,16 +267,15 @@ static inline void *usb_get_intfdata(struct usb_interface *intf)
 }
 
 /**
- * usb_set_intfdata() - associate driver-specific data with the interface
- * @intf: the usb interface
- * @data: pointer to the device priv structure or %NULL
+ * usb_set_intfdata() - associate driver-specific data with an interface
+ * @intf: USB interface
+ * @data: driver data
  *
- * Drivers should use this function in their probe() to associate their
- * driver-specific data with the usb interface.
+ * Drivers can use this function in their probe() callbacks to associate
+ * driver-specific data with an interface.
  *
- * When disconnecting, the core will take care of setting @intf back to %NULL,
- * so no actions are needed on the driver side. The interface should not be set
- * to %NULL before all actions completed (e.g. no outsanding URB remaining).
+ * Note that there is generally no need to clear the driver-data pointer even
+ * if some drivers do so for historical or implementation-specific reasons.
  */
 static inline void usb_set_intfdata(struct usb_interface *intf, void *data)
 {
-- 
2.37.4

