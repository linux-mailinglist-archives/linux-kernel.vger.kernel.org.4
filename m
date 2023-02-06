Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E558468C0CF
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 15:58:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230515AbjBFO6Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 09:58:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230289AbjBFO6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 09:58:08 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 376011A4A9
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 06:57:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675695434;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=rIgTA2Xmbd7t9d8F++MfN6g4uGoF/RD+Mu3OeUMvfvg=;
        b=hrE9BSF/gePk1gmd3S1fCikixyUgykwGXx9TP1tCD0zpWpL9BlgEu7OScNMUa70QBxuUVV
        HNe0T/ORJ7oHBHQyZXtSNb4HtXnTndOr0YKcrzZ7cl3Z2u1mGPhGW7U1uAuPgUKgwA/QKN
        QqagBXwaL68ecA4Jj3t5/S+4m25N0NM=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-542-JmjeXgV9M1mFN0NrVlH90Q-1; Mon, 06 Feb 2023 09:57:05 -0500
X-MC-Unique: JmjeXgV9M1mFN0NrVlH90Q-1
Received: by mail-qk1-f197.google.com with SMTP id 130-20020a370588000000b0072fcbe20069so4993923qkf.22
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 06:57:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rIgTA2Xmbd7t9d8F++MfN6g4uGoF/RD+Mu3OeUMvfvg=;
        b=16uno0mggU/5wu/3jDaNduOHH+xuT41Nmb2aVUp8c21CWCh0VXe2872vNXw1Ll3RbT
         YL635ythNm2c/2nIFN3cvfcdERni50SBcMrS+f6btoolCGm4iCWg1GT4hpuLU0SH+wLO
         nBPuoVXkr2KZl3joi7DIv87nugZabmlwpcOKzfjCpGs6b6JEaUWz9R664k9Ex3Mdrokh
         ytvoppmbglTzmbpvYbmr4+zSaSSOKNZ6bsoW1g0VSU/ll4QXaiGzQCxGWj39deFt7mDe
         0bTacGvvWA037SJna4nh2amhrpz7RaG+VMo+Re+meQxKd4w1PmzG+z9dW82aS79amfBs
         ki7g==
X-Gm-Message-State: AO0yUKVhKM0OU0F3OmNU3EVbTsc9hZaEPMoCm2AgKH+Fs3Z0IoYfWpfl
        9IWXUdPAMqwdFpnp6PTDqxEf5Mjm8Hxt1CKb8P/z7fpX5kKiWIHl/NOcD3xelwJSGSBYKuxvtg3
        bcr2ZA1JmLzN8e1ZBhhsCMJ7g
X-Received: by 2002:ac8:5ac6:0:b0:3b8:6a92:c8d6 with SMTP id d6-20020ac85ac6000000b003b86a92c8d6mr37832277qtd.60.1675695425195;
        Mon, 06 Feb 2023 06:57:05 -0800 (PST)
X-Google-Smtp-Source: AK7set92cIxYT5bIs41crQz1jVBZ7Rd6XKPaRwbA6dH+JROdrZzl5nc/0WhArHdGNyKIkJmZD6GDdA==
X-Received: by 2002:ac8:5ac6:0:b0:3b8:6a92:c8d6 with SMTP id d6-20020ac85ac6000000b003b86a92c8d6mr37832250qtd.60.1675695424964;
        Mon, 06 Feb 2023 06:57:04 -0800 (PST)
Received: from localhost.localdomain.com (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id x5-20020a05620a0b4500b00731a76883basm4117666qkg.101.2023.02.06.06.57.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 06:57:04 -0800 (PST)
From:   Tom Rix <trix@redhat.com>
To:     hare@suse.de, kbusch@kernel.org, axboe@fb.com, hch@lst.de,
        sagi@grimberg.me
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] nvme-auth: set nvme_auth_wq storage-class-specifier to static
Date:   Mon,  6 Feb 2023 06:57:00 -0800
Message-Id: <20230206145700.1798073-1-trix@redhat.com>
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

smatch reports
drivers/nvme/host/auth.c:48:25: warning: symbol 'nvme_auth_wq' was not declared. Should it be static?

nvme_auth_wq is only used in auth.c, so it should be static.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/nvme/host/auth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
index b57630d1d3b8..bdb97496ba2d 100644
--- a/drivers/nvme/host/auth.c
+++ b/drivers/nvme/host/auth.c
@@ -45,7 +45,7 @@ struct nvme_dhchap_queue_context {
 	int sess_key_len;
 };
 
-struct workqueue_struct *nvme_auth_wq;
+static struct workqueue_struct *nvme_auth_wq;
 
 #define nvme_auth_flags_from_qid(qid) \
 	(qid == 0) ? 0 : BLK_MQ_REQ_NOWAIT | BLK_MQ_REQ_RESERVED
-- 
2.26.3

