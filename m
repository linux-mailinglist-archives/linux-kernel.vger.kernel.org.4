Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AE9974E8E0
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 10:20:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbjGKIU4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 04:20:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjGKIUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 04:20:53 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CF79E5C
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 01:20:52 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2b6b98ac328so81951211fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 01:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689063650; x=1691655650;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uTdlkhlpCCqeoNeoPuiVvBqr3VCWV64K8rIS7qqJISM=;
        b=IWXMcd8eMJHr2DIy2sik4O4IzCVH6d6WdfyrhNdgVX5cZbUrI5cCaR2wLh6sFSed9f
         qvv6vzMLbVvod6erYahZlnYthzzRtlvcbfwXuTe+4q4yiDc8UWTHkUTM91z3/6EaKTo3
         Jojz0GrYbFS8r/1FuNya8qpOKYvw4Nl8JYsnnL4E7ocNL63wo0A4Vix/VUvKRvmQRb60
         FRCKgJdm94SUGykkG5eYFkGDnvt2kHeSUgKeyMcyrYonFfuhp8xsmCDRF8v+RJmuOP0U
         3JDHqt/ssETM1B1gB2VkWB/snbJCvsGy95uzDQzI37FWYbFfG0TmXAU+zTJ0YyQdyWdr
         AVHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689063650; x=1691655650;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uTdlkhlpCCqeoNeoPuiVvBqr3VCWV64K8rIS7qqJISM=;
        b=L+Yw6smQ4so/IX7KNK7qnZsUPMsdnZHCltdEHJrxirBoKhCQ9NoTnH6G71v3snAG8W
         FVvzZD9I/JqdPROYBqK1Huo3U8LOhzFLV/EzGVyKhfvg4Ir/U8rwXaTvuz50fUkayYhx
         ZCXBBTXZc6A4UCD7w/rk5l5137iaqXlBe3kbjFo7zDdOC//P40i8D23DnZmgiFZsaR0H
         7MUpDZwoSphVqDiTPPbSjdUE0QfW02Tqty8K+Ncv9unJk6k6HOf7itU+26Qm8ROK5sAu
         M17BGRvvWBDmr4o7u1FbBWCdofj3CeAyU++P0T37zAQTE0PVdSFP0UoZrHH4/8+jkay9
         YkDg==
X-Gm-Message-State: ABy/qLYXVvriVXJRQkx4CEmZQI4k74MMOd9zcqoLbYbb8tnMDT+ulr0B
        gunxQiFj2XAJD3AGWBwSU0+bxA==
X-Google-Smtp-Source: APBJJlFAPzRYzDe1rsGW/YswGSAcORefT4bkbI9eiSkHF3c1m/SfcBojfmfiKAGoLNKbp/VdeGCmMQ==
X-Received: by 2002:a2e:998e:0:b0:2b6:de63:6d3b with SMTP id w14-20020a2e998e000000b002b6de636d3bmr12672857lji.21.1689063650276;
        Tue, 11 Jul 2023 01:20:50 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id 12-20020a05600c020c00b003f819faff24sm12386039wmi.40.2023.07.11.01.20.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 01:20:49 -0700 (PDT)
Date:   Tue, 11 Jul 2023 11:20:44 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Jeffrey Hugo <quic_jhugo@quicinc.com>
Cc:     Carl Vanderlip <quic_carlv@quicinc.com>,
        Pranjal Ramajor Asha Kanojiya <quic_pkanojiy@quicinc.com>,
        Oded Gabbay <ogabbay@kernel.org>,
        Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
        Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH 1/5 v4] accel/qaic: tighten bounds checking in
 encode_message()
Message-ID: <9a0cb0c1-a974-4f10-bc8d-94437983639a@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e935c70-5bd2-4808-bdd9-d664f892b0b5@moroto.mountain>
X-Mailer: git-send-email haha only kidding
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are several issues in this code.  The check at the start of the
loop:

	if (user_len >= user_msg->len) {

This check does not ensure that we have enough space for the trans_hdr
(8 bytes).  Instead the check needs to be:

	if (user_len > user_msg->len - sizeof(*trans_hdr)) {

That subtraction is done as an unsigned long we want to avoid
negatives.  Add a lower bound to the start of the function.

	if (user_msg->len < sizeof(*trans_hdr))

There is a second integer underflow which can happen if
trans_hdr->len is zero inside the encode_passthrough() function.

	memcpy(out_trans->data, in_trans->data, in_trans->hdr.len - sizeof(in_trans->hdr));

Instead of adding a check to encode_passthrough() it's better to check
in this central place.  Add that check:

	if (trans_hdr->len < sizeof(trans_hdr)

The final concern is that the "user_len + trans_hdr->len" might have an
integer overflow bug.  Use size_add() to prevent that.

-	if (user_len + trans_hdr->len > user_msg->len) {
+	if (size_add(user_len, trans_hdr->len) > user_msg->len) {

Fixes: 129776ac2e38 ("accel/qaic: Add control path")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
v4: send this patch.
v2: * Fix the >= vs > bug in:

	if (user_len > user_msg->len - sizeof(*trans_hdr)) {

    * include overflow.h
---
 drivers/accel/qaic/qaic_control.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/accel/qaic/qaic_control.c b/drivers/accel/qaic/qaic_control.c
index 5c57f7b4494e..2fdd5959c52f 100644
--- a/drivers/accel/qaic/qaic_control.c
+++ b/drivers/accel/qaic/qaic_control.c
@@ -14,6 +14,7 @@
 #include <linux/mm.h>
 #include <linux/moduleparam.h>
 #include <linux/mutex.h>
+#include <linux/overflow.h>
 #include <linux/pci.h>
 #include <linux/scatterlist.h>
 #include <linux/types.h>
@@ -748,7 +749,8 @@ static int encode_message(struct qaic_device *qdev, struct manage_msg *user_msg,
 	int ret;
 	int i;
 
-	if (!user_msg->count) {
+	if (!user_msg->count ||
+	    user_msg->len < sizeof(*trans_hdr)) {
 		ret = -EINVAL;
 		goto out;
 	}
@@ -765,12 +767,13 @@ static int encode_message(struct qaic_device *qdev, struct manage_msg *user_msg,
 	}
 
 	for (i = 0; i < user_msg->count; ++i) {
-		if (user_len >= user_msg->len) {
+		if (user_len > user_msg->len - sizeof(*trans_hdr)) {
 			ret = -EINVAL;
 			break;
 		}
 		trans_hdr = (struct qaic_manage_trans_hdr *)(user_msg->data + user_len);
-		if (user_len + trans_hdr->len > user_msg->len) {
+		if (trans_hdr->len < sizeof(trans_hdr) ||
+		    size_add(user_len, trans_hdr->len) > user_msg->len) {
 			ret = -EINVAL;
 			break;
 		}
-- 
2.39.2

