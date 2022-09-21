Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D353B5E54BE
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 22:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbiIUUwE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 16:52:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbiIUUwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 16:52:01 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B4E59F8FB
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 13:51:59 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id e68so7206247pfe.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 13:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=D80WZfucxT3T2jixHx4bvU4f4glNNHDVHDNbaBiNbuQ=;
        b=WJ7vftjYdQLkD940fWG48kQOGPwWIwtjmcDQBLyGs95BRKwv0eoPa5OFr2AYkC7V80
         f9B+0Sc+QNYibiS0EvcxPrGaKU8d1DlLXvuipvj3lUidU4MeLT2/VJ/g68UHwbB1RVcw
         8+U02lIJ/hhK3v+qc4033/gXZISHphYuDQHfo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=D80WZfucxT3T2jixHx4bvU4f4glNNHDVHDNbaBiNbuQ=;
        b=wFTHY+73lxmga69rrjrqMd9UrAo7y6UrLZ9cpPRoDU5JX+X4zsTmZblfEKghtaKvKP
         jeXgrY2goyE1KmIhrJcAynsJ4LB9MFKFrIKnjUi0dCsHZrxqzA2+IuvgSy2gCYn8WSEI
         oAQjB+X3hdX/e0PmcRKWs2mtwV351IeJphxM9EZRJreaEm6ZUoBW5MbYjisfTvb2MABI
         wT1/68oNDu2d7KKUJmo0FquJ531BO4xjacLHeWLEdAwMDgP0l9EI6p+oICh2Mb9ljyGE
         TdDeui4+LH95NVyp8xEcsGs/3pbQRx27TkRQ5Ygkn11rKXW5i8Ikj+1zzzneoeaZMC3U
         PDTw==
X-Gm-Message-State: ACrzQf0jrBXnO+WIEjLq0ExwFqSy0KRGpShaHxfsqlFF4ux8/wAFjGg1
        ZaZi0djkZ2hIkfI4ArMRs4YFOg==
X-Google-Smtp-Source: AMsMyM5x/YqAvJnNkuP3s9sudYjK2UWyxBpl4qhk/dsQz/kD2YM+cCHOYeHwTWoTCsY65S3tY/T91g==
X-Received: by 2002:a65:4c85:0:b0:43b:f860:98f9 with SMTP id m5-20020a654c85000000b0043bf86098f9mr48699pgt.368.1663793519127;
        Wed, 21 Sep 2022 13:51:59 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i32-20020a632220000000b00422c003cf78sm2267673pgi.82.2022.09.21.13.51.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 13:51:58 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Sachin Sant <sachinp@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH] scsi: scsi_transport_fc: Adjust struct fc_nl_event flex array usage
Date:   Wed, 21 Sep 2022 13:51:55 -0700
Message-Id: <20220921205155.1451649-1-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3180; h=from:subject; bh=HTYO6DRAcJ0YYvNgnwbkgU3hR5o+67BVqpamWRTBFhs=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjK3lqCxkl8/+3fSy7f7uw22pne0hq/v2+EXdc5unX 3g0ywfSJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYyt5agAKCRCJcvTf3G3AJgxsEA CRYo81nzmI4fc8o5wOEqs7W5LE56q0N+KDpzyoinEebkPkLBy9cfnnZ9IZ4uqGx6ql3/k5AfUbjIN1 VOlNweshUp4eFbH9dvygIwI4A1iMBIMYflwNw1nzFzEfMF5ivWNA1625KTcxaaXy2MFPqyAfKcKhKQ Ah6CSfZ80NPSV9Ku41sbuV1dbvmI9cLn+vHkzTeCt4JI+c3KQ7FCdVYgZT5ezS2bNfCLsJrp9tc2Qc mHMqxsGQYYfsBLd+l418aqM9EsgNxZB0/WvsWnxvZEMlsvcYK3qrTJ1cEYuqsfakUMsneAPGfBgPm7 TtvT1T+BVEzuPUynHHMKOAUdKhLV5tDynM/0ILQb5whePXTw3G9MXZE65Nd5yNOjmsAiBWTLhRxl67 luoxLNmyBF0N3ayCoDFgUocr1NNsjSpGKX39IPzTT85h0f6A/pgLML5l5SBpiihEZEOBOcCC69dyPT lO3CTNvu3yelHnrIb+CX+weji6t0ty5gJklkQPZUiVr4SGiluhDoZFNDIlAOM2p/QOoLqR9bQStJA9 WZzCGqSrXJammpEt2Xt3C5zDkun6J4n+x3JWZPJcJxPwL1kGJmZxQkwIv3YS1/k1Y7mqsyJi86tnW/ AtlIF07G7jUvINEO67RaAT2Sx99E3FCKCIG+3chWg3EdXVSuDNY1BnIwW9qQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to help the compiler reason about the destination buffer in
struct fc_nl_event, add a flexible array member for this purpose.
However, since the header is UAPI, it must not change size or layout, so
a union is used.

The allocation size calculations are also corrected (it was potentially
allocating an extra 8 bytes), and the padding is zeroed to avoid leaking
kernel heap memory contents.

Detected at run-time by the recently added memcpy() bounds checking:

  memcpy: detected field-spanning write (size 8) of single field "&event->event_data" at drivers/scsi/scsi_transport_fc.c:581 (size 4)

Reported-by: Sachin Sant <sachinp@linux.ibm.com>
Link: https://lore.kernel.org/linux-next/42404B5E-198B-4FD3-94D6-5E16CF579EF3@linux.ibm.com/
Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/scsi/scsi_transport_fc.c    | 8 +++++---
 include/uapi/scsi/scsi_netlink_fc.h | 7 +++++--
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/scsi/scsi_transport_fc.c b/drivers/scsi/scsi_transport_fc.c
index a2524106206d..0d798f11dc34 100644
--- a/drivers/scsi/scsi_transport_fc.c
+++ b/drivers/scsi/scsi_transport_fc.c
@@ -543,7 +543,7 @@ fc_host_post_fc_event(struct Scsi_Host *shost, u32 event_number,
 	struct nlmsghdr	*nlh;
 	struct fc_nl_event *event;
 	const char *name;
-	u32 len;
+	size_t len, padding;
 	int err;
 
 	if (!data_buf || data_len < 4)
@@ -554,7 +554,7 @@ fc_host_post_fc_event(struct Scsi_Host *shost, u32 event_number,
 		goto send_fail;
 	}
 
-	len = FC_NL_MSGALIGN(sizeof(*event) + data_len);
+	len = FC_NL_MSGALIGN(sizeof(*event) - sizeof(event->event_data) + data_len);
 
 	skb = nlmsg_new(len, GFP_KERNEL);
 	if (!skb) {
@@ -578,7 +578,9 @@ fc_host_post_fc_event(struct Scsi_Host *shost, u32 event_number,
 	event->event_num = event_number;
 	event->event_code = event_code;
 	if (data_len)
-		memcpy(&event->event_data, data_buf, data_len);
+		memcpy(event->event_data_flex, data_buf, data_len);
+	padding = len - offsetof(typeof(*event), event_data_flex) - data_len;
+	memset(event->event_data_flex + data_len, 0, padding);
 
 	nlmsg_multicast(scsi_nl_sock, skb, 0, SCSI_NL_GRP_FC_EVENTS,
 			GFP_KERNEL);
diff --git a/include/uapi/scsi/scsi_netlink_fc.h b/include/uapi/scsi/scsi_netlink_fc.h
index 7535253f1a96..b46e9cbeb001 100644
--- a/include/uapi/scsi/scsi_netlink_fc.h
+++ b/include/uapi/scsi/scsi_netlink_fc.h
@@ -35,7 +35,7 @@
  * FC Transport Broadcast Event Message :
  *   FC_NL_ASYNC_EVENT
  *
- * Note: if Vendor Unique message, &event_data will be  start of
+ * Note: if Vendor Unique message, event_data_flex will be start of
  * 	 vendor unique payload, and the length of the payload is
  *       per event_datalen
  *
@@ -50,7 +50,10 @@ struct fc_nl_event {
 	__u16 event_datalen;
 	__u32 event_num;
 	__u32 event_code;
-	__u32 event_data;
+	union {
+		__u32 event_data;
+		__DECLARE_FLEX_ARRAY(__u8, event_data_flex);
+	};
 } __attribute__((aligned(sizeof(__u64))));
 
 
-- 
2.34.1

