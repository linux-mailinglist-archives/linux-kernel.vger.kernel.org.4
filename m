Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0B4567F9AC
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 17:51:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234569AbjA1Qvq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 11:51:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234077AbjA1Qvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 11:51:45 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B783B2B0A0
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 08:50:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674924657;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=wH+a1RoqV8gkvget5JfXDGZAoMbcGdg92N025k4ReP8=;
        b=BoVxgEddQ7uJRCVa7pQKFTbtn7XkpfkzbZP+baN/KJAbSTNM9cphlU9B5LCRQ78ITc9JO4
        eP0kYwHjdXf8X6fccpxnVCJ75Xkdvr29WeURuGmxUpOg7/WpaVec9HJWQyFMwyswY4wNBu
        GZ2CE+O3o8GbR+JBAOZFehtnnMNFObI=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-359-_ewpaXeoN9mVn6uce_q8oA-1; Sat, 28 Jan 2023 11:50:54 -0500
X-MC-Unique: _ewpaXeoN9mVn6uce_q8oA-1
Received: by mail-qt1-f199.google.com with SMTP id x16-20020ac87ed0000000b003b82d873b38so1549603qtj.13
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 08:50:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wH+a1RoqV8gkvget5JfXDGZAoMbcGdg92N025k4ReP8=;
        b=ctBMefWqFviS9cmzyarHqvbDHMqbzNhdYgcZvLP0GOk3D52xgqJdHQrZXNFn7LFNTB
         QoIQOrids2clFeLlTX3FtwQOXApmBVBeTK/aCS98f4pJ8IPRmQbR57yersd1Df7xGxe4
         r3QLI07ZZaWLneSlNJ5wIAQrc69j0762Z4KiAR/xb9wY5MSHEH27+FenSgzYGguG1aOe
         hbKP8thfRLXMSurQRuDl+SMaMmO4nO9sZlYaGYds5WsNkGxClXLfy3lnvnxm3pb0FCu+
         hKj9NRE1+wt+g9ikZegf0AMjFWMTQG4giEkVmTUKwKizGFDL0g8WhtQpOt8oVIt6wG6g
         wHAQ==
X-Gm-Message-State: AFqh2kqTNThQyaVGGFAzK2rtx2Pn/5uCyWCzp966tynyMwU9xkRoroWU
        Ouim80Aj0XECbeZHyA26ZTXqHf5dW0Joq2Tt8M/sWLVINujVUxk16iQyXSu3bVDxTmuqWdsEtDX
        lTAGUkOvs9yZGJDj4ksInPctc
X-Received: by 2002:ac8:4c84:0:b0:3b6:31e2:f537 with SMTP id j4-20020ac84c84000000b003b631e2f537mr56737709qtv.8.1674924653595;
        Sat, 28 Jan 2023 08:50:53 -0800 (PST)
X-Google-Smtp-Source: AMrXdXv7EXJmG9COVLYM4+MGlcImgPsJDpp8ayq9tlTf5QsNOKnWi3Z5lKLMbPQNVVXNeDUsKhR/6Q==
X-Received: by 2002:ac8:4c84:0:b0:3b6:31e2:f537 with SMTP id j4-20020ac84c84000000b003b631e2f537mr56737693qtv.8.1674924653338;
        Sat, 28 Jan 2023 08:50:53 -0800 (PST)
Received: from localhost.localdomain.com (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id f9-20020a05620a408900b0070eb5766a9fsm5157059qko.10.2023.01.28.08.50.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Jan 2023 08:50:52 -0800 (PST)
From:   Tom Rix <trix@redhat.com>
To:     zaslonko@linux.ibm.com, akpm@linux-foundation.org,
        iii@linux.ibm.com
Cc:     linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] lib/zlib: remove redundation assignement of avail_in dfltcc_gdht()
Date:   Sat, 28 Jan 2023 08:50:48 -0800
Message-Id: <20230128165048.1245792-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cppcheck reports
lib/zlib_dfltcc/dfltcc_deflate.c:65:21: warning: Redundant assignment of 'avail_in' to itself. [selfAssignment]
    size_t avail_in = avail_in = strm->avail_in;

Only setting avail_in once is needed.

Fixes: aa5b395b69b6 ("lib/zlib: add s390 hardware support for kernel zlib_deflate")
Signed-off-by: Tom Rix <trix@redhat.com>
---
 lib/zlib_dfltcc/dfltcc_deflate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/zlib_dfltcc/dfltcc_deflate.c b/lib/zlib_dfltcc/dfltcc_deflate.c
index 80924f067c24..b732b6d9e35d 100644
--- a/lib/zlib_dfltcc/dfltcc_deflate.c
+++ b/lib/zlib_dfltcc/dfltcc_deflate.c
@@ -62,7 +62,7 @@ static void dfltcc_gdht(
 {
     deflate_state *state = (deflate_state *)strm->state;
     struct dfltcc_param_v0 *param = &GET_DFLTCC_STATE(state)->param;
-    size_t avail_in = avail_in = strm->avail_in;
+    size_t avail_in = strm->avail_in;
 
     dfltcc(DFLTCC_GDHT,
            param, NULL, NULL,
-- 
2.26.3

