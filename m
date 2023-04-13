Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 173DD6E17EF
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 01:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230309AbjDMXMm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 19:12:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230327AbjDMXM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 19:12:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3694B49D2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 16:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681427497;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UrLvr60huy61e3psoajwIv3A4LyU2VRqVkvYCOVTv4c=;
        b=Gtb7DL7zoE+Tm/3L4YYshWjdQzDeBiytm+FOOSc0mRXOovkxQ6Uw8uocjMxnIhe28X6TIq
        yjQd/Dfypr/Th7laQ/I1mWxi8iTgpRURAQWdSUhlYYnjOUN/VOaoFq6/NSn2EvGvrJaK6A
        ymHZObmk/KPO4rn+mY4YjeafDQfh8yg=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-223-acdjznG5MEyeqAu0eKBGJg-1; Thu, 13 Apr 2023 19:11:36 -0400
X-MC-Unique: acdjznG5MEyeqAu0eKBGJg-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-5ef52fc3c8aso691566d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 16:11:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681427494; x=1684019494;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UrLvr60huy61e3psoajwIv3A4LyU2VRqVkvYCOVTv4c=;
        b=KecDmWdr6zdPJpomCodqK0wewsgqB8fmrQsIKa0gciwjKhBVWPDP+5suqLtQeH24on
         efGS42meeczB7gK/pA7c0Q+mecBVuN0BUGvHyXon+rOef8eld89Mhyj4E43oZV2vyosI
         EKVpdqmBr4d9vytGhJqlDc0wv7uPX8Dh0ND5lM4i3+wlz5l/l4kZMHbDY+Wbd9tasEDJ
         m4Wyu1X9yMil3huS4BWbJZ5dlHA28a3geD2Oz5AXB2HWkV0oSeKBG4Ry6mPWHMUTC1K0
         NhKTDgSfLUDipyCesAr2ez/Ll0pGjIxAZsR1fG+TDcf7RX2tGY35XnpMdr7eNLP8ZD9M
         IPhw==
X-Gm-Message-State: AAQBX9fie35aeOrwWIA9rQQoUKMx44b59VacilApoI/9nzJN/+toGAgf
        wBB8HE2JJBPB2CVzDRIUHuPfBE98NPEwjvwcALZ3NFXfW4udiF0C3yEmpsJC6x+LjXI0knz/z5A
        C5933Zjsc9pI0ufapqPXV+ncUXUS7JeLntvhhHH/PqN6nj62eZxN7VeDqfnGH7ihZ5gMvhR1siS
        evYdERug==
X-Received: by 2002:a05:622a:19a4:b0:3e8:e986:b20b with SMTP id u36-20020a05622a19a400b003e8e986b20bmr822645qtc.6.1681427493800;
        Thu, 13 Apr 2023 16:11:33 -0700 (PDT)
X-Google-Smtp-Source: AKy350YyNQPwspj+xj10BFWcJDwoT/zFUFT3us77X7aynWNJPLGIpmq+EZfsiE/QhH18vpRqiooHtg==
X-Received: by 2002:a05:622a:19a4:b0:3e8:e986:b20b with SMTP id u36-20020a05622a19a400b003e8e986b20bmr822605qtc.6.1681427493424;
        Thu, 13 Apr 2023 16:11:33 -0700 (PDT)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-40-70-52-229-124.dsl.bell.ca. [70.52.229.124])
        by smtp.gmail.com with ESMTPSA id g3-20020ac81243000000b003ea1b97acfasm612446qtj.49.2023.04.13.16.11.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 16:11:31 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Axel Rasmussen <axelrasmussen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>, peterx@redhat.com,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: [PATCH 5/6] selftests/mm: Rename COW_EXTRA_LIBS to IOURING_EXTRA_LIBS
Date:   Thu, 13 Apr 2023 19:11:19 -0400
Message-Id: <20230413231120.544685-6-peterx@redhat.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230413231120.544685-1-peterx@redhat.com>
References: <20230413231120.544685-1-peterx@redhat.com>
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

The macro and facility can be reused in other tests too.  Make it general.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tools/testing/selftests/mm/Makefile        | 8 ++++----
 tools/testing/selftests/mm/check_config.sh | 4 ++--
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
index 5a3434419403..9ffce175d5e6 100644
--- a/tools/testing/selftests/mm/Makefile
+++ b/tools/testing/selftests/mm/Makefile
@@ -161,8 +161,8 @@ warn_32bit_failure:
 endif
 endif
 
-# cow_EXTRA_LIBS may get set in local_config.mk, or it may be left empty.
-$(OUTPUT)/cow: LDLIBS += $(COW_EXTRA_LIBS)
+# IOURING_EXTRA_LIBS may get set in local_config.mk, or it may be left empty.
+$(OUTPUT)/cow: LDLIBS += $(IOURING_EXTRA_LIBS)
 
 $(OUTPUT)/mlock-random-test $(OUTPUT)/memfd_secret: LDLIBS += -lcap
 
@@ -175,11 +175,11 @@ local_config.mk local_config.h: check_config.sh
 
 EXTRA_CLEAN += local_config.mk local_config.h
 
-ifeq ($(COW_EXTRA_LIBS),)
+ifeq ($(IOURING_EXTRA_LIBS),)
 all: warn_missing_liburing
 
 warn_missing_liburing:
 	@echo ; \
-	echo "Warning: missing liburing support. Some COW tests will be skipped." ; \
+	echo "Warning: missing liburing support. Some tests will be skipped." ; \
 	echo
 endif
diff --git a/tools/testing/selftests/mm/check_config.sh b/tools/testing/selftests/mm/check_config.sh
index bcba3af0acea..3954f4746161 100644
--- a/tools/testing/selftests/mm/check_config.sh
+++ b/tools/testing/selftests/mm/check_config.sh
@@ -21,11 +21,11 @@ $CC -c $tmpfile_c -o $tmpfile_o >/dev/null 2>&1
 
 if [ -f $tmpfile_o ]; then
     echo "#define LOCAL_CONFIG_HAVE_LIBURING 1"  > $OUTPUT_H_FILE
-    echo "COW_EXTRA_LIBS = -luring"              > $OUTPUT_MKFILE
+    echo "IOURING_EXTRA_LIBS = -luring"          > $OUTPUT_MKFILE
 else
     echo "// No liburing support found"          > $OUTPUT_H_FILE
     echo "# No liburing support found, so:"      > $OUTPUT_MKFILE
-    echo "COW_EXTRA_LIBS = "                    >> $OUTPUT_MKFILE
+    echo "IOURING_EXTRA_LIBS = "                >> $OUTPUT_MKFILE
 fi
 
 rm ${tmpname}.*
-- 
2.39.1

