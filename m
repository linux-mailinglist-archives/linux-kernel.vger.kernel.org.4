Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F7285F32FA
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 17:56:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbiJCP4t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 11:56:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbiJCP4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 11:56:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC97D2DA9F
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 08:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664812598;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/5RzxXUZxi/MrG066VL+DnGEo1qQl33988Rm0NK9+zA=;
        b=MLutX1nsPeGms5FwSsl0JmsXVFj0AoP8lzGgDk/TtB5zS/YfxRC1r47fNGYAsoBKKktAKg
        N2r6Sbb4l0/lDAqpA7gMlRUyNj/dNGwKazc/EStk+BLHiCfbHhaVLtvZ2i8lBV75uWy0uO
        eW0l5/Ksm1N7HFlAdIX8C5Jyk4dN7sQ=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-656-Qv4bF7p1OWmFjIE3K2quXQ-1; Mon, 03 Oct 2022 11:56:37 -0400
X-MC-Unique: Qv4bF7p1OWmFjIE3K2quXQ-1
Received: by mail-qv1-f71.google.com with SMTP id ks15-20020a056214310f00b004b18ea4bc05so1621558qvb.22
        for <linux-kernel@vger.kernel.org>; Mon, 03 Oct 2022 08:56:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=/5RzxXUZxi/MrG066VL+DnGEo1qQl33988Rm0NK9+zA=;
        b=Z9lsZzdnw1iLShr3ZARV7gKCwBJ5u0fhiPNzXDlDo/VjIJ34pWgjtZ1ueYUvqQPlL+
         MqakKr5Fi/D/ZVbR9tX4npafIBB5NEamrxwpYSPqeYlA9mslRBVM6D89neA8rixM4ENj
         cpFl/25v6OuqelLGAeXIVgAuCkcevG1GRL/s4uuWig3G1I9Jtne9ZzH6ISwmd5HHBTj3
         ES9RUk/ooHGLt8e6ZSqstnuO8VUPbkqx/FZLkRmFfyYRt1IKeTlxJdvoGkE9UQWiQeRB
         Qzrk4hQrYQ7bNF6ODA0JfwCbDHpqSsCbBr67F8yn/mec5RsSwMcFUsPfWO+dVg/Po1mY
         so1g==
X-Gm-Message-State: ACrzQf3CmJCuV1pEnL1oeZWZwN9l/pBmFNU3yIwHP+D8a564SwQUzq9+
        n/p/Q6/bc6y6HDWiQtpMpPbPbW0j2AaWngKF05kHIUMbai4p3OHwVQGagGtXNpt4OtgONJhC+2j
        KoGFM9KY45lpbskTNVZwnNUrl3EuLlEH9PfUXASTDPtp1vuljhUqwVjZHOTF+tFuPG0VjRUvEDw
        ==
X-Received: by 2002:a05:620a:15d2:b0:6cf:2d38:9c0d with SMTP id o18-20020a05620a15d200b006cf2d389c0dmr14084021qkm.426.1664812596943;
        Mon, 03 Oct 2022 08:56:36 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5YdLVN5mgUHqMX9gMAFXtuu3DO1SuWxQNyQcY/m8UTnt2zEXiE/KDGL7J7kdUZbNlU/tPU6w==
X-Received: by 2002:a05:620a:15d2:b0:6cf:2d38:9c0d with SMTP id o18-20020a05620a15d200b006cf2d389c0dmr14083998qkm.426.1664812596639;
        Mon, 03 Oct 2022 08:56:36 -0700 (PDT)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id bs18-20020a05620a471200b006cf38fd659asm10956732qkb.103.2022.10.03.08.56.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 08:56:36 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     peterx@redhat.com, Andrea Arcangeli <aarcange@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>
Subject: [PATCH 3/3] mm/selftest: uffd: Explain the write missing fault check
Date:   Mon,  3 Oct 2022 11:56:30 -0400
Message-Id: <20221003155630.469263-4-peterx@redhat.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221003155630.469263-1-peterx@redhat.com>
References: <20221003155630.469263-1-peterx@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's not obvious why we had a write check for each of the missing messages,
especially when it should be a locking op.  Add a rich comment for that,
and also try to explain its good side and limitations, so that if someone
hit it again for either a bug or a different glibc impl there'll be some
clue to start with.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tools/testing/selftests/vm/userfaultfd.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/vm/userfaultfd.c b/tools/testing/selftests/vm/userfaultfd.c
index 74babdbc02e5..297f250c1d95 100644
--- a/tools/testing/selftests/vm/userfaultfd.c
+++ b/tools/testing/selftests/vm/userfaultfd.c
@@ -774,7 +774,27 @@ static void uffd_handle_page_fault(struct uffd_msg *msg,
 		continue_range(uffd, msg->arg.pagefault.address, page_size);
 		stats->minor_faults++;
 	} else {
-		/* Missing page faults */
+		/*
+		 * Missing page faults.
+		 *
+		 * Here we force a write check for each of the missing mode
+		 * faults.  It's guaranteed because the only threads that
+		 * will trigger uffd faults are the locking threads, and
+		 * their first instruction to touch the missing page will
+		 * always be pthread_mutex_lock().
+		 *
+		 * Note that here we relied on an NPTL glibc impl detail to
+		 * always read the lock type at the entry of the lock op
+		 * (pthread_mutex_t.__data.__type, offset 0x10) before
+		 * doing any locking operations to guarantee that.  It's
+		 * actually not good to rely on this impl detail because
+		 * logically a pthread-compatible lib can implement the
+		 * locks without types and we can fail when linking with
+		 * them.  However since we used to find bugs with this
+		 * strict check we still keep it around.  Hopefully this
+		 * could be a good hint when it fails again.  If one day
+		 * it'll break on some other impl of glibc we'll revisit.
+		 */
 		if (msg->arg.pagefault.flags & UFFD_PAGEFAULT_FLAG_WRITE)
 			err("unexpected write fault");
 
-- 
2.37.3

