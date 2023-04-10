Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F7A56DC912
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 18:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbjDJQIs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 12:08:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbjDJQIr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 12:08:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3FB4E6C
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 09:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681142883;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=tKyrBwfd2oDcUs2lWJFq6u064SVhVNeOSwEIW7vUOn0=;
        b=Pyrq1cIkydbSwiAL9LsPDsEtHgf7yJEOHwpFd8kv52v5Sl+MEcxWyQiD6J0kXTZBi5MAQI
        1cwNINemyMD6Pl5tvsjYEhBr6wNM83F+/cZ71EoZUTp7E/gWmIgP/r6QfBKG47elVQww5E
        9IcRVBZ8nIQt+74btvdwkST1SPGuhuk=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-20-a5UfyMqANqqY1B2Gf3yZbA-1; Mon, 10 Apr 2023 12:08:02 -0400
X-MC-Unique: a5UfyMqANqqY1B2Gf3yZbA-1
Received: by mail-pg1-f198.google.com with SMTP id j62-20020a638041000000b0051827ed9c15so1989262pgd.7
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 09:08:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681142881; x=1683734881;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tKyrBwfd2oDcUs2lWJFq6u064SVhVNeOSwEIW7vUOn0=;
        b=aciMMqy0HbB1w2O8vEgmGQZC2CBnCRlArJ4NISvI4uwW+JtRAhPW7XOTpQYkhcxiHd
         1pCg+h0Gwu5Ca3HTA/Thf419alIgaOrYD6g5HzmdWZBj5gbEpMmN40Qwb8/2Tpa59PDC
         FaLaZm8InEjNdjG1TJOP6wF1dJ10TYRKWy4K+sm+EJkkdE7mH/bw1tuHhqritGIGSN7v
         x/GtPooFGTmY14fgezDNFDIy2/Z0M9i2Nk6Qr46o1R7nR1VEigFcbA0EwOtwsyhcXWAP
         Bsw4Y1HvspfoWVKSlTKzekoMozw46VTMxnurMsEVbdNVg7o95Z0jB9SUT0zKTs/jkx9l
         ddKA==
X-Gm-Message-State: AAQBX9e1BcoPnLv/wb9gLRcSBnonsYZ5ebK6CS9HmATpqHQ/C1Ho9a4M
        QdUNqriJwiFYNuGtFAMU+b5Li4lRtfQChzFDrwYZvxkrKu/Be99SrBKRbPsXYBgocMCjmhLL7SF
        ooBJ+yjtA2myo46+nFSMdwgdn
X-Received: by 2002:a05:6a20:7a86:b0:e4:2a2c:869b with SMTP id u6-20020a056a207a8600b000e42a2c869bmr12067471pzh.36.1681142881291;
        Mon, 10 Apr 2023 09:08:01 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZXeZrFMveM/HuIZlNvxfD4NqlUe/w1jLGkwF5Qj6WkdSiJUAg3vzTfi5sKD3AiJ/e//XOcYg==
X-Received: by 2002:a05:6a20:7a86:b0:e4:2a2c:869b with SMTP id u6-20020a056a207a8600b000e42a2c869bmr12067447pzh.36.1681142880863;
        Mon, 10 Apr 2023 09:08:00 -0700 (PDT)
Received: from zeus.elecom ([240b:10:83a2:bd00:6e35:f2f5:2e21:ae3a])
        by smtp.gmail.com with ESMTPSA id l14-20020a63da4e000000b005004919b31dsm3449040pgj.72.2023.04.10.09.07.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 09:08:00 -0700 (PDT)
From:   Ryosuke Yasuoka <ryasuoka@redhat.com>
To:     djwong@kernel.org
Cc:     linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        sandeen@sandeen.net, david@fromorbit.com,
        Ryosuke Yasuoka <ryasuoka@redhat.com>
Subject: [PATCH v2] xfs: Use for_each_perag_from() to iterate all available AGs
Date:   Tue, 11 Apr 2023 01:07:27 +0900
Message-Id: <20230410160727.3748239-1-ryasuoka@redhat.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

xfs_filestream_pick_ag() iterates all the available AGs when no
unassociated AGs are available by using for_each_perag_wrap().
To iterate all the available AGs, just use for_each_perag_from() instead.


This patch cleans up a code where xfs_filestream_pick_ag() iterates 
all the available AGs when no unassociated AGs are available.
Current implementation is using a for_each_perag_wrap() macro which
iterates all AGs from start_agno through wrap_agno, wraps to
restart_agno, and then iterates again toward to (start_agno - 1).
In this case, xfs_filestream_pick_ag() start to iterate from 0 and
does't need to wrap. Although passing 0 as start_agno to
for_each_perag_wrap() 
is not problematic, we have already a for_each_perag() macro family
which just iterates all AGs from 0 and doesn't wrap. Hense, I propose
to use for_each_perag() family simply.


Changes since v1 [1]:
Use for_each_perag_from() instead of for_each_perag() to clarify
where we are iterating from.

[1]:
https://lore.kernel.org/linux-xfs/CAHpthZrvhqh8O1HO7U_jVnaq9R9Ur=Yq2eWzjWfNx3ryDbnGPA@mail.gmail.com/T/#m5704d0409bec1ce5273be0d3860e8ad60e9886fd

Signed-off-by: Ryosuke Yasuoka <ryasuoka@redhat.com>
---
 fs/xfs/xfs_filestream.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_filestream.c b/fs/xfs/xfs_filestream.c
index 22c13933c8f8..29acd9f7d422 100644
--- a/fs/xfs/xfs_filestream.c
+++ b/fs/xfs/xfs_filestream.c
@@ -151,7 +151,8 @@ xfs_filestream_pick_ag(
 		 * grab.
 		 */
 		if (!max_pag) {
-			for_each_perag_wrap(args->mp, 0, start_agno, args->pag)
+			start_agno = 0;
+			for_each_perag_from(args->mp, start_agno, args->pag)
 				break;
 			atomic_inc(&args->pag->pagf_fstrms);
 			*longest = 0;
-- 
2.39.2

