Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB410637E00
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 18:04:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbiKXREs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 12:04:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiKXREp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 12:04:45 -0500
Received: from metanate.com (unknown [IPv6:2001:8b0:1628:5005::111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 979972B1BB;
        Thu, 24 Nov 2022 09:04:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=metanate.com; s=stronger; h=Content-Transfer-Encoding:Message-Id:Date:
        Subject:Cc:To:From:Content-Type:Reply-To:Content-ID:Content-Description:
        In-Reply-To:References; bh=/K9WVPVMPasDt2GUsLve9o5Zh3vIW7gvBXUy8+n3CAE=; b=cx
        gTekk7r1nQ3wMUXIJPF/+3zwT4r9xiA/sMJaffqqLN38HakS33On1EJAMj0ViA4ZfZxBiZ4D81ZLX
        Fi+IbRaglEGul1CpltlNRMXCgN2dvc5g7Ao83QmK5JV1V5dREDx3ffNoKvE6wL9xOlYA5K4pRPiHp
        1pmxx7v+TOR7R248voHq3YUS4GXGOK1cvDYU83zSaSczRRkfJkIJoxGquMW/94uH6I3xoTh3bUtDh
        G3lCDoEmQ5UHulsP9VF+y9SMSJLBDSFwSsp060dAAdF9OxonSyhvcE8xzwaYs+1ewcmYygwkjp8MX
        RWtxjA5wltrHLfPd+wUiBRzKNhOdk+Dg==;
Received: from [81.174.171.191] (helo=donbot.metanate.com)
        by email.metanate.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <john@metanate.com>)
        id 1oyFeO-0000NB-7e;
        Thu, 24 Nov 2022 17:04:36 +0000
From:   John Keeping <john@metanate.com>
To:     linux-usb@vger.kernel.org
Cc:     John Keeping <john@metanate.com>,
        Linyu Yuan <quic_linyyuan@quicinc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Dan Carpenter <error27@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] usb: gadget: f_fs: use io_data->status consistently
Date:   Thu, 24 Nov 2022 17:04:28 +0000
Message-Id: <20221124170430.3998755-1-john@metanate.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated: YES
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_PASS,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit fb1f16d74e26 ("usb: gadget: f_fs: change ep->status safe in
ffs_epfile_io()") added a new ffs_io_data::status field to fix lifetime
issues in synchronous requests.

While there are no similar lifetime issues for asynchronous requests
(the separate ep member in ffs_io_data avoids them) using the status
field means the USB request can be freed earlier and that there is more
consistency between the synchronous and asynchronous I/O paths.

Cc: Linyu Yuan <quic_linyyuan@quicinc.com>
Signed-off-by: John Keeping <john@metanate.com>
---
 drivers/usb/gadget/function/f_fs.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
index 73dc10a77cde..1221f0d1b1a9 100644
--- a/drivers/usb/gadget/function/f_fs.c
+++ b/drivers/usb/gadget/function/f_fs.c
@@ -825,8 +825,7 @@ static void ffs_user_copy_worker(struct work_struct *work)
 {
 	struct ffs_io_data *io_data = container_of(work, struct ffs_io_data,
 						   work);
-	int ret = io_data->req->status ? io_data->req->status :
-					 io_data->req->actual;
+	int ret = io_data->status;
 	bool kiocb_has_eventfd = io_data->kiocb->ki_flags & IOCB_EVENTFD;
 
 	if (io_data->read && ret > 0) {
@@ -840,8 +839,6 @@ static void ffs_user_copy_worker(struct work_struct *work)
 	if (io_data->ffs->ffs_eventfd && !kiocb_has_eventfd)
 		eventfd_signal(io_data->ffs->ffs_eventfd, 1);
 
-	usb_ep_free_request(io_data->ep, io_data->req);
-
 	if (io_data->read)
 		kfree(io_data->to_free);
 	ffs_free_buffer(io_data);
@@ -856,6 +853,9 @@ static void ffs_epfile_async_io_complete(struct usb_ep *_ep,
 
 	ENTER();
 
+	io_data->status = req->status ? req->status : req->actual;
+	usb_ep_free_request(_ep, req);
+
 	INIT_WORK(&io_data->work, ffs_user_copy_worker);
 	queue_work(ffs->io_completion_wq, &io_data->work);
 }
-- 
2.38.1

