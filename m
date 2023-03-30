Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6D916D0AA7
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 18:07:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231270AbjC3QHr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 12:07:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230525AbjC3QHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 12:07:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ADB0900D
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 09:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680192413;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ur7tdcX2754X/jwxH6S7nx/WMyBE34LUGKNmt1W9AUk=;
        b=EYKJIM0dIvr0IRBY+U25LLa+VToES3JxHR9t3uigjq7tLzH0HqWY3N+tlJ6DLQXSDJSG+d
        R2iTOYqmjnUPjHhskKa8dIht/VrCmnfe16/EltTo72b52FB4Lhjyr2Ewesq2t6diVLsR+R
        moIcea9tRVBvs9IlOaKlwEbW9yf7OIo=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-134-_7mtD-WyOMCl8rdjjMHARQ-1; Thu, 30 Mar 2023 12:06:50 -0400
X-MC-Unique: _7mtD-WyOMCl8rdjjMHARQ-1
Received: by mail-qk1-f197.google.com with SMTP id b142-20020ae9eb94000000b007486a8b9ae9so6467482qkg.11
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 09:06:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680192410; x=1682784410;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ur7tdcX2754X/jwxH6S7nx/WMyBE34LUGKNmt1W9AUk=;
        b=eo/yiDPNz0BMkZAqqqK9Fs1Ne8GX+VrTYh5sFoBQv5NXQn8A+9EqtU25UOdcYg4MsH
         9w8TPLEL2UH9AgOuDhdpfxtBEnuYI1ypyBMEgkHxdXMfivp8OA4THDhC57boGj3rn8Er
         BU9a88PnDsQMDcHNEFuTsVSeA/OTiW4c9shOorDCiMLZqrb48QvohoM5YZvp8/yxCqsR
         vO6Gq7N8zZ6kpm/mnedfk88o6OYq8ftwRXj/KzGiaSSWzNkMmRRADTL/qrfVUZ5lpei5
         iGmdYohTDGfqFgKeW7F00vBVO2/x/qez0hAANizZS3MGUH8F32Mxew37AmuqWQAtRKlB
         Wlyw==
X-Gm-Message-State: AAQBX9dtG8EBwwPttj6iIBL3i4lGVU0WrQlLhaQwG5bjX/DOx2JjC+cc
        zgZF0yCq8JNrtncyL0meCZNSO5ht9VXgoCQnTtfYgzpBggDrsNl5Sg1lj7/7IUfvL5ZvoJTGmdi
        hDdayKIKCf1PKFKJsJq/ZxL7K
X-Received: by 2002:a05:6214:518a:b0:5de:5da:b873 with SMTP id kl10-20020a056214518a00b005de05dab873mr3919739qvb.3.1680192409807;
        Thu, 30 Mar 2023 09:06:49 -0700 (PDT)
X-Google-Smtp-Source: AKy350baROru4BSpw3JpIlSLNAp+ESXSwo1NPW+Z7d/OD7Cm1StOx06WqJRNSws7xERwMIoZLTH2Jw==
X-Received: by 2002:a05:6214:518a:b0:5de:5da:b873 with SMTP id kl10-20020a056214518a00b005de05dab873mr3919704qvb.3.1680192409526;
        Thu, 30 Mar 2023 09:06:49 -0700 (PDT)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-40-70-52-229-124.dsl.bell.ca. [70.52.229.124])
        by smtp.gmail.com with ESMTPSA id 15-20020a05620a048f00b0074636e35405sm12074981qkr.65.2023.03.30.09.06.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 09:06:48 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>, peterx@redhat.com,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Nadav Amit <nadav.amit@gmail.com>
Subject: [PATCH 03/29] selftests/mm: Dump a summary in run_vmtests.sh
Date:   Thu, 30 Mar 2023 12:06:46 -0400
Message-Id: <20230330160646.3106903-1-peterx@redhat.com>
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

Dump a summary after running whatever test specified.  Useful for human
runners to identify any kind of failures (besides exit code).

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tools/testing/selftests/mm/run_vmtests.sh | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/testing/selftests/mm/run_vmtests.sh b/tools/testing/selftests/mm/run_vmtests.sh
index c0f93b668c0c..9cc33984aa9f 100644
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
+			count_pass=$(( $count_pass + 1 ))
 			echo "[PASS]"
 		elif [ $ret -eq $ksft_skip ]; then
+			count_skip=$(( $count_skip + 1 ))
 			echo "[SKIP]"
 			exitcode=$ksft_skip
 		else
+			count_fail=$(( $count_fail + 1 ))
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

