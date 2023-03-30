Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D4386D0A88
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 17:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233193AbjC3P6K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 11:58:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233501AbjC3P6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 11:58:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6933B10CF
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 08:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680191839;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sP9rqjignnWh2VSPIiMl4HPMQh9/IMP3JUMCK79G4dM=;
        b=eMCUvD3eYSZZ+FKilEItqt1NS+/NsoI6qIuR8ZAmwdr86TJL9TbGbpblRWwMUE2rUPq8pr
        WXYperdklGGfr4NBOz6d7FrapK0wSqghgVmISjHHaoJbkNtuE/0INoY7zaAZiDJc5+a18J
        YLRQbUpBwxpILWifXMc/N5zRlIMKOe4=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-AZLvEGlFPpeN5WRBTqjq0Q-1; Thu, 30 Mar 2023 11:57:17 -0400
X-MC-Unique: AZLvEGlFPpeN5WRBTqjq0Q-1
Received: by mail-qk1-f198.google.com with SMTP id 72-20020a37064b000000b007467c5d3abeso9069881qkg.19
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 08:57:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680191832; x=1682783832;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sP9rqjignnWh2VSPIiMl4HPMQh9/IMP3JUMCK79G4dM=;
        b=i0GshvcBPzUahTTFTz2t/WBoCOGrDI61mIusz6wfi4olvzrEFHtwR5J4XB/f5ihFsa
         aP9SmuM6azLKTEFzXBYW44ACo2Do09+Z3h4mtm+pFvDkCjERIoa6uHZe+lxX4pgqnSln
         oE04fYMbj7Jia7jjccQn8aKCoFQ3HFq6O4a8s6h3jvxKKcnBiBVNbx8/BtqSBBlVAEu0
         3wwE9UU3HskXHo6pMhwKPqd0m5Lf0vJ216tnDVwjY9JI6byQ4mxZ+9e6dY5AxtDecAFT
         cnxM2i76xdBSL++CEJa2VA5cCXswLkKT4+j2D+3KcffuaFsIFFqzRV0olslNnO9K+eZ+
         yBpA==
X-Gm-Message-State: AO0yUKXCcTIYI70Kt7UMCltnQwWJFCGNSVCNDOy7rwQfiESmQ+OB6qUt
        mXqhLy4waicgIO6qpGPEBK3gLxSrCi+wcEkt8lfg+KBG5izdq36MY6WF+TQUT+mQ3ZKhc93s8J1
        AnSbgtOVI71L/gzZqADa8Qau8
X-Received: by 2002:a05:622a:1981:b0:3dc:483f:9c82 with SMTP id u1-20020a05622a198100b003dc483f9c82mr36684514qtc.0.1680191832432;
        Thu, 30 Mar 2023 08:57:12 -0700 (PDT)
X-Google-Smtp-Source: AK7set+XjaORt6GiFu74wzWerLNgGw4I0eI596quziToVBJF2U76yQS3mN30JraI0EQ6rxzmNnxCxA==
X-Received: by 2002:a05:622a:1981:b0:3dc:483f:9c82 with SMTP id u1-20020a05622a198100b003dc483f9c82mr36684482qtc.0.1680191832185;
        Thu, 30 Mar 2023 08:57:12 -0700 (PDT)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-40-70-52-229-124.dsl.bell.ca. [70.52.229.124])
        by smtp.gmail.com with ESMTPSA id o10-20020a05620a0d4a00b0074281812276sm13059380qkl.97.2023.03.30.08.57.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 08:57:10 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     peterx@redhat.com, Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        linux-stable <stable@vger.kernel.org>
Subject: [PATCH 01/29] Revert "userfaultfd: don't fail on unrecognized features"
Date:   Thu, 30 Mar 2023 11:56:39 -0400
Message-Id: <20230330155707.3106228-2-peterx@redhat.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230330155707.3106228-1-peterx@redhat.com>
References: <20230330155707.3106228-1-peterx@redhat.com>
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
Cc: Axel Rasmussen <axelrasmussen@google.com>
Cc: linux-stable <stable@vger.kernel.org>
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

