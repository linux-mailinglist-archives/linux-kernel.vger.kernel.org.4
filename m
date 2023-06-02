Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7E9F72025F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 14:47:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235657AbjFBMq5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 08:46:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235286AbjFBMqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 08:46:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A0E913D;
        Fri,  2 Jun 2023 05:46:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D2B5D6500B;
        Fri,  2 Jun 2023 12:46:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42902C433D2;
        Fri,  2 Jun 2023 12:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685710008;
        bh=uSiepLtWjVhXcCAJfRm0oQIqf205bq5k7/+2TYyI62A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X//v7whp/oQm0/fBEgfGL161IJQ64IbHiJZwCgjVBOwKKkKBtiGEF1VMFICCG5k8A
         GvitP1GR6to67KLwcXVFtno3OGIP8QGK8gZFgk7CoCZm2vmydovba0aXzVn0UnmvnB
         d8wTGmSc00WeWPUBw1/gdCiqxjx+ksAG1DI/o188F03GnK/9aTtjLdhxqPaBLIUV0B
         Cx6H+4VYDNwYivPa2JKfIlU+9mdEq2lf4FHwoUSLpc3AgeNcq2SMUYUAyLv919PpzK
         H7w1NV8IdzG1WmNhGKKlf6tJZ6r74gWQTi88vD2kMm3d8f5U1H/UuCTvHD6P9TfmKg
         HdfTme31HEG6w==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1q54BG-0004y3-5j; Fri, 02 Jun 2023 14:46:58 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Corey Minyard <minyard@acm.org>
Subject: [PATCH 3/3] USB: serial: report unsupported break signalling
Date:   Fri,  2 Jun 2023 14:46:42 +0200
Message-Id: <20230602124642.19076-4-johan@kernel.org>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230602124642.19076-1-johan@kernel.org>
References: <20230602124642.19076-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

