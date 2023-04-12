Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 550F96DFB8A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 18:42:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbjDLQmN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 12:42:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbjDLQmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 12:42:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FF6E65BF
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 09:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681317683;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UoyMoOjoICnnEVcPuqz2r5voAg7rax1INu5Vpam+Fw4=;
        b=DsW8QCLTxgKgqLWuKHN+nmBVuozPrIYOj/xyX0lhKIAY3mERfnJvMml8ao+lblCWGt+VDc
        VZ91yPhSNp5+3NAa32+egWsR4q1LkB1x8Qtjj+mlKYwpREkIhIf0xMgKwAUYBDyIuaPYIr
        pxmxwchFZDpRK4bkeeXgeQ4izaKghp4=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-407-bYdX4MbmP5GstWRWDxWnVg-1; Wed, 12 Apr 2023 12:41:22 -0400
X-MC-Unique: bYdX4MbmP5GstWRWDxWnVg-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-5ea572ef499so7654656d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 09:41:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681317681; x=1683909681;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UoyMoOjoICnnEVcPuqz2r5voAg7rax1INu5Vpam+Fw4=;
        b=aHDfNcKXHZisfoZS/iY7v/w3uhmsfOJQXDlSa3NV7URX6xhjz6bBSdCXVu5GN2B4EI
         uHUhmvOxmoQ05kYKu38PxItx2ebWvPm5MOIXbsH/bTT2xYRWeacuS4MMdxSpMZLW4hpi
         AFMN6ZrWD8953wvbGyua1/qB8nsUUdBPQX8z96fJd2U6DmIgKzC6AwA91Qq+2ed9IQuf
         1XLEFR5Po/+VhlvrMbi2UnSN/E0yClZRNzAzjTCokgWbc3KAy/WF1aSMrss0vZReJn+9
         Iqy+kQRInnm00XW6DuYp9sax5Y0EmN9RTsTZ1oeFQj9rBQGniLZ7meath7PStV9VcqCl
         aCLQ==
X-Gm-Message-State: AAQBX9f+UP/ll6eZbAIsbZBpV0a171X0PnmBF5ivnfdOHYkTCqEYSun5
        yjgsW8hQ1NKMH/BeFK+BhrUJ0SjIzJGfTdO5Ept4m1pPeepke8ExXymD1+laTN4w5L0/sEl+47K
        sKUiRpWu2VTIbuhq4F4EVd1q+COxm66xq+1HJ9KUHOddR5za7FiOW95Mp54ozZTFdwGyxQXprnh
        qfvsJ/8w==
X-Received: by 2002:a05:6214:5290:b0:5ed:c96e:ca4a with SMTP id kj16-20020a056214529000b005edc96eca4amr14516826qvb.1.1681317681037;
        Wed, 12 Apr 2023 09:41:21 -0700 (PDT)
X-Google-Smtp-Source: AKy350Y/BM9d0qYWbe4XaYzBW72Y+CI5qbpGOBnAbMVn6e6u5jNfJhaRd9I8cUGoJsnTVOpur+A1Jw==
X-Received: by 2002:a05:6214:5290:b0:5ed:c96e:ca4a with SMTP id kj16-20020a056214529000b005edc96eca4amr14516789qvb.1.1681317680716;
        Wed, 12 Apr 2023 09:41:20 -0700 (PDT)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-40-70-52-229-124.dsl.bell.ca. [70.52.229.124])
        by smtp.gmail.com with ESMTPSA id d125-20020a37b483000000b007426ec97253sm4741159qkf.111.2023.04.12.09.41.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 09:41:19 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Axel Rasmussen <axelrasmussen@google.com>,
        David Hildenbrand <david@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Nadav Amit <nadav.amit@gmail.com>, peterx@redhat.com,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
        Mike Rapoport <rppt@kernel.org>
Subject: [PATCH v2 03/31] selftests/mm: Dump a summary in run_vmtests.sh
Date:   Wed, 12 Apr 2023 12:41:17 -0400
Message-Id: <20230412164117.327720-1-peterx@redhat.com>
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

Dump a summary after running whatever test specified.  Useful for human
runners to identify any kind of failures (besides exit code).

Reviewed-by: Axel Rasmussen <axelrasmussen@google.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tools/testing/selftests/mm/run_vmtests.sh | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/testing/selftests/mm/run_vmtests.sh b/tools/testing/selftests/mm/run_vmtests.sh
index c0f93b668c0c..ddf40f883747 100644
--- a/tools/testing/selftests/mm/run_vmtests.sh
+++ b/tools/testing/selftests/mm/run_vmtests.sh
@@ -5,6 +5,9 @@
 # Kselftest framework requirement - SKIP code is 4.
 ksft_skip=4
 
+count_pass=0
+count_fail=0
+count_skip=0
 exitcode=0
 
 usage() {
@@ -149,11 +152,14 @@ run_test() {
 		"$@"
 		local ret=$?
 		if [ $ret -eq 0 ]; then
+			count_pass=$(( count_pass + 1 ))
 			echo "[PASS]"
 		elif [ $ret -eq $ksft_skip ]; then
+			count_skip=$(( count_skip + 1 ))
 			echo "[SKIP]"
 			exitcode=$ksft_skip
 		else
+			count_fail=$(( count_fail + 1 ))
 			echo "[FAIL]"
 			exitcode=1
 		fi
@@ -279,4 +285,6 @@ CATEGORY="soft_dirty" run_test ./soft-dirty
 # COW tests
 CATEGORY="cow" run_test ./cow
 
+echo "SUMMARY: PASS=${count_pass} SKIP=${count_skip} FAIL=${count_fail}"
+
 exit $exitcode
-- 
2.39.1

