Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2BFC6E5145
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 21:55:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230399AbjDQTzD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 15:55:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbjDQTyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 15:54:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29BB34232
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 12:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681761216;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nL6ukD3uQsP0j8aiX/3IiND2lFTW26LLUmGTHQFycOk=;
        b=F9YY/XJrSlczL7wPBf0oYKvzQ6/0CTmM47PL0kpjrJA5VT4uH7MliYxXPsY4asfjYHHBXg
        cwLzc9paztU3g4zqOZKNDUzhk1Y94Sz8mpC2YtgWjmfRN9PjgLIuc/BN2PXSOTYZny8/qu
        5p8+vUaDOzs/dad68w51uYtFZqazSJA=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-126-sfuNc7wnN_WGDij7zcikxg-1; Mon, 17 Apr 2023 15:53:32 -0400
X-MC-Unique: sfuNc7wnN_WGDij7zcikxg-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-74accc750c1so34639485a.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 12:53:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681761211; x=1684353211;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nL6ukD3uQsP0j8aiX/3IiND2lFTW26LLUmGTHQFycOk=;
        b=Og8U0gwkmNgSyDx8U04B31gnrxXZ+kM+aMcW+2C9uPsy7+wC5XvzP4+YJpT5XAbBsr
         Eo7p+aJu/GQaZjDP7Ic2Kcpkem1kG3tP7wa121FLE0gEpLpN27FcdYqZgp9ipKmYDINd
         LetRNCqCrFAXaZuLgy010WEh0TcAe+YxR/7Al7ivYWsQZQY+NsVNDCVWsXtWpz/T3TNm
         LIEyBDpK2pdvtAWToijNTcnXvtgo/I77w+PHE8ejqeZBzdQEhcPyPPf3StZ6oeY1Ji6O
         g5wdsZ6oJuTAmil/DVsGIk2KEvrqPelvXVxzF5ang2WSv64Gn+/oE46HS1n3RulsVt9O
         IrAQ==
X-Gm-Message-State: AAQBX9e/8z6FvYkfuH8ZFRU8185wrR5c67PstZ2Z/MCJAiKQ3bGQ+Ejg
        PLxayl/9GH4MpTaiEY0dBI2v9AG8rX1dqALCW79nMHuraGX0t7txDmKZwXmpUBy8TQzw7Xs/OoV
        FVqadClW1V/yIHZwiiV2WCTdEGv9Aafpnkwna3QiLSiwWrl4dFkzbinDb5vfTMNmURZrj+/AcgY
        wfAzQdjQ==
X-Received: by 2002:a05:6214:5095:b0:5ef:55d8:7164 with SMTP id kk21-20020a056214509500b005ef55d87164mr16879409qvb.5.1681761211391;
        Mon, 17 Apr 2023 12:53:31 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZYsrWygXMFCyj7XgLRO6y6vn18wQ8faUnma5Zhq/ehDr1HRYT9sovIA6wDuciwvG7UbAnfUQ==
X-Received: by 2002:a05:6214:5095:b0:5ef:55d8:7164 with SMTP id kk21-20020a056214509500b005ef55d87164mr16879362qvb.5.1681761210964;
        Mon, 17 Apr 2023 12:53:30 -0700 (PDT)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-40-70-52-229-124.dsl.bell.ca. [70.52.229.124])
        by smtp.gmail.com with ESMTPSA id r17-20020ac87ef1000000b003edfb5d7637sm1731278qtc.73.2023.04.17.12.53.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 12:53:29 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        =?UTF-8?q?Mika=20Penttil=C3=A4?= <mpenttil@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>, peterx@redhat.com,
        Axel Rasmussen <axelrasmussen@google.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH v2 5/6] selftests/mm: Rename COW_EXTRA_LIBS to IOURING_EXTRA_LIBS
Date:   Mon, 17 Apr 2023 15:53:16 -0400
Message-Id: <20230417195317.898696-6-peterx@redhat.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230417195317.898696-1-peterx@redhat.com>
References: <20230417195317.898696-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The macro and facility can be reused in other tests too.  Make it general.

Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tools/testing/selftests/mm/Makefile        | 8 ++++----
 tools/testing/selftests/mm/check_config.sh | 4 ++--
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
index 63c03a6414fc..0ee00769b53f 100644
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

