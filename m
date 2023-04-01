Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3B1C6D2E7D
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 08:05:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232373AbjDAGFm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Apr 2023 02:05:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjDAGFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Apr 2023 02:05:40 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F6CE1E716
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 23:05:37 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id d13-20020a17090ad98d00b00240922fdb7cso7495612pjv.6
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 23:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680329137;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nzj9Fg3GaIV9NE2Q/zhkZ2tE1+n4uT9HgOjZrVlSexY=;
        b=a+B/eYfLO/QRcC2R3kk9NVzQz2ZbJaoghwKedq2mxrvnt1fQ7X76yzOyktp3FTrfZJ
         lXOAhtIJgjpaznN4gd0nxR7Def4aezPHYphl+ftF1NWyx0e/fN7tNE68F7eCkX9UEhWL
         umWGKN4TuxXJtCbZzrK0hb2vPU+lG49Rz9r6W0Zb5xAcOuMHAIDd8AdKCDzjBhtR5tY7
         74PoftD/PfUW/5VHfWz06fpLSMMH5j2dggJEUDKepMqqBWXRsLI0rcrGYn91dOWD1f7P
         yPLdRKBLjnB2IChd8iaZ+LHB7yNrPqLFuHdZ6N6ByM/khZ03IAGUzzC3dOGq7E4CjMdK
         UttQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680329137;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nzj9Fg3GaIV9NE2Q/zhkZ2tE1+n4uT9HgOjZrVlSexY=;
        b=asdnPtaA0B/qfjl+D8k48iIGihrSL1MJXPq6HBlJJMTtF9LWiF9/Rfzz0BWraiEMzu
         z8u2HmhCToP14pSvifeyPku7SYO/71h+PfVCFQui8mSr+M3RGMRTz0NxPhFBetzdyJx4
         Jfgx1uOZhEppQeaJF8LcAD5UpFsjrZ2bMV2K1ZXtmAZ1uPiYiYXywMA+F6vwOkIRkoXI
         4wMNWHkUmmVVxMdkfMllPrI+WMkxodBb7QSbJdh25FyaX+EA7F6NDGx7/k9QdMOrwmMo
         LaIEhjPbjuNFONN09LvXT4xAPSOFye/n49YaPBnIxE3sLfg5DALLaJenZZFofbuFfi+P
         t9wA==
X-Gm-Message-State: AAQBX9e5+jDPNT7Enc+9NLKAEXpZxe9PCoJuVhBHXZk4MQkfOvasgo7r
        QntphGy3ZkybNICmj0UFY3QsaWfEcLhc
X-Google-Smtp-Source: AKy350ZHfWs0860/xrymzSKCPQKop/B7XtT0OncKiX+Pf72FRIpkclD9sEc9SXlIlKdxX1csdPDiXRq/uB17
X-Received: from dhavale-ctop.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:5e39])
 (user=dhavale job=sendgmr) by 2002:a17:902:7c81:b0:1a1:f44c:8b98 with SMTP id
 y1-20020a1709027c8100b001a1f44c8b98mr9863957pll.12.1680329137028; Fri, 31 Mar
 2023 23:05:37 -0700 (PDT)
Date:   Sat,  1 Apr 2023 06:05:08 +0000
In-Reply-To: <20230401060509.3608259-1-dhavale@google.com>
Mime-Version: 1.0
References: <20230401060509.3608259-1-dhavale@google.com>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Message-ID: <20230401060509.3608259-2-dhavale@google.com>
Subject: [PATCH v1 1/2] usb: gadget: f_fs: Fix ffs_epfile_read_iter to handle ITER_UBUF
From:   Sandeep Dhavale <dhavale@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>
Cc:     Sandeep Dhavale <dhavale@google.com>, kernel-team@android.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

iov_iter for ffs_epfile_read_iter can be ITER_UBUF with io_uring.
In that case dup_iter() does not have to allocate anything and it
can return NULL. ffs_epfile_read_iter treats this as a failure and
returns -ENOMEM. Fix it by checking if iter_is_ubuf().

Fixes: 1e23db450cff ("io_uring: use iter_ubuf for single range imports")
Signed-off-by: Sandeep Dhavale <dhavale@google.com>
---
 drivers/usb/gadget/function/f_fs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
index 8830847fbf97..a13c946e0663 100644
--- a/drivers/usb/gadget/function/f_fs.c
+++ b/drivers/usb/gadget/function/f_fs.c
@@ -1230,7 +1230,7 @@ static ssize_t ffs_epfile_read_iter(struct kiocb *kiocb, struct iov_iter *to)
 	p->kiocb = kiocb;
 	if (p->aio) {
 		p->to_free = dup_iter(&p->data, to, GFP_KERNEL);
-		if (!p->to_free) {
+		if (!iter_is_ubuf(&p->data) && !p->to_free) {
 			kfree(p);
 			return -ENOMEM;
 		}
-- 
2.40.0.348.gf938b09366-goog

