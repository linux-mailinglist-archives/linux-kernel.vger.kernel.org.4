Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74CF864146E
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 07:09:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230430AbiLCGJp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Dec 2022 01:09:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbiLCGJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Dec 2022 01:09:42 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BAB713E39;
        Fri,  2 Dec 2022 22:09:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=Vxr1BilUXwzDdnzrGNUD0GN+KKUJxwsmIbzziZmyjCA=; b=Xk3ColPdsycTXJhkAUS6OmurZW
        T+nCYLuJCXP1v8JR6Q2epHI11hTB3WKced4aO6pVCjI7C6BHnmKbeF3EWpa+JriiQkQtqB4ADkT8z
        H+xfcYwKsJm4hD3jYsh4QvJIDHyYhJjfGNW7fhp3TGNI80yNI9r5Y0KpN0DUE+i/mzZclNTD0Cc2X
        LJt8RrQOvThAqTWKGFEDQNKEDMWfntp3OyeAXIzdG6lkoHQqeF+Zn6ERjA0dr5+1j6f/oIuA0haBa
        ITTCa7BppfO1f7D9tJhKV1k7YiOTZjO7bo85JqKHU7RjomiDQVpNc1wKZmxLYIPaBnb6P/2X+J9Xg
        HvkP8qdw==;
Received: from [2601:1c2:d80:3110::a2e7] (helo=casper.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p1LiZ-000vxr-UL; Sat, 03 Dec 2022 06:09:44 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>, Lin Ma <linma@zju.edu.cn>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org
Subject: [PATCH] media: dvbdev.h: fix kernel-doc warnings
Date:   Fri,  2 Dec 2022 22:09:31 -0800
Message-Id: <20221203060931.19953-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix kernel-doc warnings in <media/dvbdev.h> that were recently introduced.

Quietens these warnings:

../include/media/dvbdev.h:193: warning: Function parameter or member 'ref' not described in 'dvb_device'
../include/media/dvbdev.h:207: warning: expecting prototype for dvb_device_get(). Prototype was for dvb_device_put() instead
dvbdev.h:257: warning: contents before sections

Fixes: 0fc044b2b5e2 ("media: dvbdev: adopts refcnt to avoid UAF")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Lin Ma <linma@zju.edu.cn>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org
---
 include/media/dvbdev.h |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff -- a/include/media/dvbdev.h b/include/media/dvbdev.h
--- a/include/media/dvbdev.h
+++ b/include/media/dvbdev.h
@@ -130,6 +130,7 @@ struct dvb_adapter {
  * struct dvb_device - represents a DVB device node
  *
  * @list_head:	List head with all DVB devices
+ * @ref:	reference count for this device
  * @fops:	pointer to struct file_operations
  * @adapter:	pointer to the adapter that holds this device node
  * @type:	type of the device, as defined by &enum dvb_device_type.
@@ -200,7 +201,7 @@ struct dvb_device {
 struct dvb_device *dvb_device_get(struct dvb_device *dvbdev);
 
 /**
- * dvb_device_get - Decrease dvb_device reference
+ * dvb_device_put - Decrease dvb_device reference
  *
  * @dvbdev:	pointer to struct dvb_device
  */
@@ -250,10 +251,10 @@ int dvb_register_device(struct dvb_adapt
 /**
  * dvb_remove_device - Remove a registered DVB device
  *
+ * @dvbdev:	pointer to struct dvb_device
+ *
  * This does not free memory. dvb_free_device() will do that when
  * reference counter is empty
- *
- * @dvbdev:	pointer to struct dvb_device
  */
 void dvb_remove_device(struct dvb_device *dvbdev);
 
