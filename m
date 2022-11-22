Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EA72633C99
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 13:35:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233789AbiKVMfu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 07:35:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233565AbiKVMff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 07:35:35 -0500
Received: from metanate.com (unknown [IPv6:2001:8b0:1628:5005::111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1814D5B852;
        Tue, 22 Nov 2022 04:35:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=metanate.com; s=stronger; h=Content-Transfer-Encoding:References:
        In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Reply-To:
        Content-ID:Content-Description;
        bh=3XtypsQCZfitCCQMZ1INOCA+bpbOa3aJWCZ30RBSfxk=; b=2rn+vgcsNJmicNvWa5wF/GIy4x
        UxlKu5IshzDEjq5aSmeYRYuEs7FD750VvMNtMSQTvXT2rJhUQC17zuVlSHAr02mHxmY+9QfveG2O3
        t9qBgfNgAIL6OIdR/9MiCe1HHzWDD2iej2/9sHiRmx5NVTFzBIAR3A3Ig75Sx+So037RT9yJ5z6Gg
        AOXVnmI0+st2vmoTplh36lbyHddmVEWV1rviobn5ORveSLp79psMWQ2yyAJg9NAd6pfeO+mViB4FT
        gUYGKdb2efe2Qseg1MnAJMSCKxA4/Hvp3CzfSIRDMJ4xpRwnSRGKQ2eg5afAagbDSyi8pmWK0O9Nq
        z2leee9A==;
Received: from [81.174.171.191] (helo=donbot.metanate.com)
        by email.metanate.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <john@metanate.com>)
        id 1oxSUt-0003da-Gn;
        Tue, 22 Nov 2022 12:35:32 +0000
From:   John Keeping <john@metanate.com>
To:     linux-usb@vger.kernel.org
Cc:     Fabien Chouteau <fabien.chouteau@barco.com>,
        Peter Korsgaard <peter.korsgaard@barco.com>,
        Felipe Balbi <balbi@ti.com>,
        Andrzej Pietrasiewicz <andrzej.p@samsung.com>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        John Keeping <john@metanate.com>, Lee Jones <lee@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>
Subject: [PATCH 2/3] usb: gadget: f_hid: fix refcount leak on error path
Date:   Tue, 22 Nov 2022 12:35:22 +0000
Message-Id: <20221122123523.3068034-3-john@metanate.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221122123523.3068034-1-john@metanate.com>
References: <20221122123523.3068034-1-john@metanate.com>
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

When failing to allocate report_desc, opts->refcnt has already been
incremented so it needs to be decremented to avoid leaving the options
structure permanently locked.

Fixes: 21a9476a7ba8 ("usb: gadget: hid: add configfs support")
Signed-off-by: John Keeping <john@metanate.com>
---
 drivers/usb/gadget/function/f_hid.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/gadget/function/f_hid.c b/drivers/usb/gadget/function/f_hid.c
index 8b8bbeaa27cb..6be6009f911e 100644
--- a/drivers/usb/gadget/function/f_hid.c
+++ b/drivers/usb/gadget/function/f_hid.c
@@ -1292,6 +1292,7 @@ static struct usb_function *hidg_alloc(struct usb_function_instance *fi)
 						 GFP_KERNEL);
 		if (!hidg->report_desc) {
 			put_device(&hidg->dev);
+			--opts->refcnt;
 			mutex_unlock(&opts->lock);
 			return ERR_PTR(-ENOMEM);
 		}
-- 
2.38.1

