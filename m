Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD0706DFB8B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 18:42:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbjDLQmW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 12:42:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbjDLQmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 12:42:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06398268B
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 09:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681317687;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=09jtKKMdBkZ99/jQ3MHG3Gpu4kZKeE61xD5S9ADSCnE=;
        b=QQL4bDt5LMYcrAWuj9OeLBN47vVfL3HJybzVJlLa9Ru7R8oPNjLO30qg4TarXSvIQ2GAh+
        MobKBXMajBrxEipfW09FB0GIBom6h8UnBlHtFTC0lpr+7C5Z8afSoC95BFvxFU7tTOEnHH
        +RD3bPjHQQVRgv57/CzIiNf2+KLw00s=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-222-vzCsdpQ7OzepawJY9Cp-HA-1; Wed, 12 Apr 2023 12:39:27 -0400
X-MC-Unique: vzCsdpQ7OzepawJY9Cp-HA-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-5ef4122d2dbso1347536d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 09:39:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681317565; x=1683909565;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=09jtKKMdBkZ99/jQ3MHG3Gpu4kZKeE61xD5S9ADSCnE=;
        b=ijjePcHlUR0deFx6fOVFQbKKoZBFQNmRoWpOZICwPua3Bbz2c5heXOgCmRQiQSkCxm
         Ij9/QMAc0OW3PCIeZgP7DzqYLKPVL4nPBFJbW8TVuNNH0YEA9gHvuzhwEAvZzV9IjQk0
         psQ9Yaok4J2pv1DQVxtXR66Q5c2ckjfDNeVw5/Pf7x65jh/EYZNfZ+gEdD3U3Zi+Z67V
         s8esR22rXozSdmFO+xiwzwIw3bTXUovUW6MjTtSaCZQc2vumx0UUaPFWiR/4oP/o/K2c
         M7FThfF/mENFmY4ZBNLF+41t8y0bAv/hFBtWFAUUF8G8a6LcCRucJFLNUiN2fquQ1ulq
         T9wQ==
X-Gm-Message-State: AAQBX9ckovkZejSY6CJqHbUWYlWkk+7DpY8l7+uIvU5XsiL1cDQiaA5E
        +m6CzlaBHVm9EaKgNYjJ5f4okDlo60AniHYKd3fy8cDRGPWTPaIBC20GRz/gXVB/e3eT6Z6rM+t
        Q/O2wpSsqq3qoM2NppD2cxzng
X-Received: by 2002:a05:6214:401a:b0:5ea:a212:3fe1 with SMTP id kd26-20020a056214401a00b005eaa2123fe1mr4433892qvb.4.1681317565691;
        Wed, 12 Apr 2023 09:39:25 -0700 (PDT)
X-Google-Smtp-Source: AKy350Yg5QWvOjiNFwdYfa/fZm9pN7qYxhapB7GAqOu9LrBAaJTeYn6HJOMM2S2srwUeyNYUeY/ZiA==
X-Received: by 2002:a05:6214:401a:b0:5ea:a212:3fe1 with SMTP id kd26-20020a056214401a00b005eaa2123fe1mr4433881qvb.4.1681317565461;
        Wed, 12 Apr 2023 09:39:25 -0700 (PDT)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-40-70-52-229-124.dsl.bell.ca. [70.52.229.124])
        by smtp.gmail.com with ESMTPSA id u13-20020a0cc48d000000b005ead602acfesm2669536qvi.35.2023.04.12.09.39.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 09:39:24 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        David Hildenbrand <david@redhat.com>, peterx@redhat.com,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        linux-stable <stable@vger.kernel.org>
Subject: [PATCH v2 01/31] Revert "userfaultfd: don't fail on unrecognized features"
Date:   Wed, 12 Apr 2023 12:38:52 -0400
Message-Id: <20230412163922.327282-2-peterx@redhat.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230412163922.327282-1-peterx@redhat.com>
References: <20230412163922.327282-1-peterx@redhat.com>
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

This is a proposal to revert commit 914eedcb9ba0ff53c33808.

I found this when writting a simple UFFDIO_API test to be the first unit
test in this set.  Two things breaks with the commit:

  - UFFDIO_API check was lost and missing.  According to man page, the
  kernel should reject ioctl(UFFDIO_API) if uffdio_api.api != 0xaa.  This
  check is needed if the api version will be extended in the future, or
  user app won't be able to identify which is a new kernel.

  - Feature flags checks were removed, which means UFFDIO_API with a
  feature that does not exist will also succeed.  According to the man
  page, we should (and it makes sense) to reject ioctl(UFFDIO_API) if
  unknown features passed in.

Link: https://lore.kernel.org/r/20220722201513.1624158-1-axelrasmussen@google.com
Fixes: 914eedcb9ba0 ("userfaultfd: don't fail on unrecognized features")
Cc: Axel Rasmussen <axelrasmussen@google.com>
Cc: Dmitry Safonov <0x7f454c46@gmail.com>
Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc: linux-stable <stable@vger.kernel.org>
Acked-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 fs/userfaultfd.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 8395605790f6..3b2a41c330e6 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -1977,8 +1977,10 @@ static int userfaultfd_api(struct userfaultfd_ctx *ctx,
 	ret = -EFAULT;
 	if (copy_from_user(&uffdio_api, buf, sizeof(uffdio_api)))
 		goto out;
-	/* Ignore unsupported features (userspace built against newer kernel) */
-	features = uffdio_api.features & UFFD_API_FEATURES;
+	features = uffdio_api.features;
+	ret = -EINVAL;
+	if (uffdio_api.api != UFFD_API || (features & ~UFFD_API_FEATURES))
+		goto err_out;
 	ret = -EPERM;
 	if ((features & UFFD_FEATURE_EVENT_FORK) && !capable(CAP_SYS_PTRACE))
 		goto err_out;
-- 
2.39.1

