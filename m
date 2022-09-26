Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 178E35EAE63
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 19:42:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231237AbiIZRmr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 13:42:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230327AbiIZRmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 13:42:15 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 193AC17AA8
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 10:09:40 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28QApP6J006398
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 10:09:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=vLUCidGyBbc0aglagMzLHklot9FF2ixj2NRn9pzX/t8=;
 b=iImqhsF3FzWHg1MJQmaYM4F/Xu00lJY821fzOkSoEikc8tMsv0pPVIcKugCsQIw/gqg5
 zmlOjIL2h/Bfb/qYtWL2RXMmp84XAN52i8qebqraB4UaOTespZH23La35V68MjnOovMe
 K4Lp4FwD69YIuSW8LJRrUVrquWzWqu8V9GY= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3jsyknmms3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 10:09:39 -0700
Received: from twshared8247.08.ash8.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 26 Sep 2022 10:09:38 -0700
Received: by devbig038.lla2.facebook.com (Postfix, from userid 572232)
        id C66116B0A92B; Mon, 26 Sep 2022 10:09:27 -0700 (PDT)
From:   Dylan Yudaken <dylany@fb.com>
To:     Jens Axboe <axboe@kernel.dk>,
        Pavel Begunkov <asml.silence@gmail.com>
CC:     <io-uring@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-team@fb.com>, Dylan Yudaken <dylany@fb.com>
Subject: [PATCH v2 1/3] io_uring: register single issuer task at creation
Date:   Mon, 26 Sep 2022 10:09:25 -0700
Message-ID: <20220926170927.3309091-2-dylany@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220926170927.3309091-1-dylany@fb.com>
References: <20220926170927.3309091-1-dylany@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: sX_s_IQcl5FxPz2Fo9n8TSw3fwwn1zE6
X-Proofpoint-ORIG-GUID: sX_s_IQcl5FxPz2Fo9n8TSw3fwwn1zE6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-26_09,2022-09-22_02,2022-06-22_01
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of picking the task from the first submitter task, rather use the
creator task or in the case of disabled (IORING_SETUP_R_DISABLED) the
enabling task.

This approach allows a lot of simplification of the logic here. This
removes init logic from the submission path, which can always be a bit
confusing, but also removes the need for locking to write (or read) the
submitter_task.

Users that want to move a ring before submitting can create the ring
disabled and then enable it on the submitting task.

Signed-off-by: Dylan Yudaken <dylany@fb.com>
---
 io_uring/io_uring.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index 2965b354efc8..242d896c00f3 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -3357,6 +3357,10 @@ static __cold int io_uring_create(unsigned entries=
, struct io_uring_params *p,
 		goto err;
 	}
=20
+	if (ctx->flags & IORING_SETUP_SINGLE_ISSUER
+	    && !(ctx->flags & IORING_SETUP_R_DISABLED))
+		ctx->submitter_task =3D get_task_struct(current);
+
 	file =3D io_uring_get_file(ctx);
 	if (IS_ERR(file)) {
 		ret =3D PTR_ERR(file);
@@ -3548,6 +3552,9 @@ static int io_register_enable_rings(struct io_ring_=
ctx *ctx)
 	if (!(ctx->flags & IORING_SETUP_R_DISABLED))
 		return -EBADFD;
=20
+	if (ctx->flags & IORING_SETUP_SINGLE_ISSUER && !ctx->submitter_task)
+		ctx->submitter_task =3D get_task_struct(current);
+
 	if (ctx->restrictions.registered)
 		ctx->restricted =3D 1;
=20
--=20
2.30.2

