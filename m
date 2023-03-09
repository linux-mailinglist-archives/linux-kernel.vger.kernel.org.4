Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9E726B30DE
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 23:38:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231307AbjCIWiD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 17:38:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbjCIWh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 17:37:59 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D34E9FAEDC
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 14:37:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678401435;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=KDlNY98zejjvKZ/14cSb+fv+AsQvq/yadRcmqDsBLIE=;
        b=DzyMGrXDHSYgREdJdCH/XYOFlFLbqH4svGr/NNVrPJ6ramQU3t4aQpmt/ODGIwEWomNn4b
        1o7VEvkmn9pncdXwnLuDGO1v1o9I0/kG8kSkuylbt9ft2YNkwPw0B68o0LgSOMx0YpbVhR
        DEDaj7paqMU/kIE1AeimfeBJVgjl9q0=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-336-2rz4MP4rNnK994skoXiNnw-1; Thu, 09 Mar 2023 17:37:14 -0500
X-MC-Unique: 2rz4MP4rNnK994skoXiNnw-1
Received: by mail-qk1-f198.google.com with SMTP id 8-20020a370508000000b00724fd33cb3eso2048257qkf.14
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 14:37:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678401434;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KDlNY98zejjvKZ/14cSb+fv+AsQvq/yadRcmqDsBLIE=;
        b=Kk67WnNEjDg0JZnmY570Io1rhRh04kN7qGv94GQ9az/DCALyootQ8BDUeKgyetOlOd
         CtcY0Lkxvwa8yDiG06JpDHXXTEoo8i8KRQqRw09oe+wEk7HDtdN9ON8lhc5doQ1F4ZFQ
         3dgZjMactt+dwh4CAT2WLSWIWhPHEAyMtIRUMUD2F7hW142O2CAvB3CicQR8wO81m7zj
         X/X1DzfPFwBFJp3K1cgfexj6QJbYNzkOtGjE83yx0f+UuV/zf0W0kGgLM5zLPt21zSP/
         HX3J+JQhCQtk5vaZompqeMZ6u4Tv1dPMLtHqy9Jd2LhiqgQ4vEintL2Ei6e/T7qsarYo
         WUTQ==
X-Gm-Message-State: AO0yUKWREsHfv6eqpjJJNOTQzrgUuiBK2vBqlWOGaP0IxyaoR/RaRZ7m
        4BigPNzGnm09Awx2y3ZjvcrokTv45yTOX8dNMLK7u29JXNVgZTgKnebldKzAh/rlPMFllBR+FNe
        j6JtXFRoBJt+yZw6MKXyAgcU2
X-Received: by 2002:ac8:574a:0:b0:3bf:da3a:4e0f with SMTP id 10-20020ac8574a000000b003bfda3a4e0fmr1802883qtx.0.1678401434084;
        Thu, 09 Mar 2023 14:37:14 -0800 (PST)
X-Google-Smtp-Source: AK7set9P4uTGnpMVcrQQivitUTi4qOLneX/yghiqHshMuPYNiJZztd1t8zdeZ1iKzxRa9+JirB++KQ==
X-Received: by 2002:ac8:574a:0:b0:3bf:da3a:4e0f with SMTP id 10-20020ac8574a000000b003bfda3a4e0fmr1802858qtx.0.1678401433663;
        Thu, 09 Mar 2023 14:37:13 -0800 (PST)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-56-70-30-145-63.dsl.bell.ca. [70.30.145.63])
        by smtp.gmail.com with ESMTPSA id c26-20020ac84e1a000000b003b8484fdfccsm172215qtw.42.2023.03.09.14.37.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 14:37:13 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Nadav Amit <nadav.amit@gmail.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Paul Gofman <pgofman@codeweavers.com>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        David Hildenbrand <david@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>, peterx@redhat.com,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v4 0/2] mm/uffd: Add feature bit UFFD_FEATURE_WP_UNPOPULATED
Date:   Thu,  9 Mar 2023 17:37:09 -0500
Message-Id: <20230309223711.823547-1-peterx@redhat.com>
X-Mailer: git-send-email 2.39.1
Content-Type: text/plain; charset="utf-8"
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

v1: https://lore.kernel.org/r/20230215210257.224243-1-peterx@redhat.com
v2: https://lore.kernel.org/r/20230227230044.1596744-1-peterx@redhat.com
v3: https://lore.kernel.org/r/20230306213925.617814-1-peterx@redhat.com

v4:
- s/handle_pte_missing/do_pte_missing/, fix spellings, etc. [David]
- Add a helper userfaultfd_wp_use_markers() [David]
- Update userfaultfd.rst describing the new feature bit

The new feature bit will make anonymous memory acts the same like file
memory on userfaultfd-wp in that it'll also wr-protect none ptes.

It can be useful in two cases:

(1) Uffd-wp app that needs to wr-protect none ptes like QEMU snapshot, so
    pre-fault can be replaced by enabling this flag and speed up protections

(2) It helps to implement async uffd-wp mode that Muhammad is working on [1]

It's debateable whether this is the most ideal solution because with the
new feature bit set, wr-protect none pte needs to pre-populate the pgtables
to the last level (PAGE_SIZE).  But it seems fine so far to service either
purpose above, so we can leave optimizations for later.

The series brings pte markers to anonymous memory too.  There's some change
in the common mm code path in the 1st patch, great to have some eye looking
at it, but hopefully they're still relatively straightforward.

Thanks,

[1] https://lore.kernel.org/all/Y+v2HJ8+3i%2FKzDBu@x1n/

Peter Xu (2):
  mm/uffd: UFFD_FEATURE_WP_UNPOPULATED
  selftests/mm: Smoke test UFFD_FEATURE_WP_UNPOPULATED

 Documentation/admin-guide/mm/userfaultfd.rst | 17 ++++++
 fs/userfaultfd.c                             | 16 ++++++
 include/linux/mm_inline.h                    |  6 +++
 include/linux/userfaultfd_k.h                | 23 ++++++++
 include/uapi/linux/userfaultfd.h             | 10 +++-
 mm/memory.c                                  | 56 +++++++++++++++-----
 mm/mprotect.c                                | 51 ++++++++++++++----
 tools/testing/selftests/mm/userfaultfd.c     | 45 +++++++++++++++-
 8 files changed, 197 insertions(+), 27 deletions(-)

-- 
2.39.1

