Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E18C55F4B13
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 23:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231295AbiJDVo2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 17:44:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231672AbiJDVoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 17:44:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8255170E74
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 14:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664919689;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=7Yo5mFoNA/akKDTqGo68e4cp8toeGFfbSMrJL8cvNlg=;
        b=L52zGLaZm6I9Ix/Qrgp0imClWPgv4iU1wInXixXhS8bj36cLQ5Gm481qbZK2sL+YjtotuS
        HtpSp4DfggVMkk61Az3FgU3XqC1lzIoaO1zXJfO/SkQ/6NCxiumA/QSgeRkWH7UeQcJToP
        fEPSxLosPXTybSv5FU+jWL5/rMJSduU=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-544-YR79F68aMjmIOz_HLXsWHg-1; Tue, 04 Oct 2022 17:41:28 -0400
X-MC-Unique: YR79F68aMjmIOz_HLXsWHg-1
Received: by mail-qt1-f199.google.com with SMTP id g6-20020ac84b66000000b0035cf832dec9so10100372qts.6
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 14:41:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=7Yo5mFoNA/akKDTqGo68e4cp8toeGFfbSMrJL8cvNlg=;
        b=KtGD+7HXTdJiuGzssHNtwFYOl8JWhKkoO/qIpYVp/8btaIMoacymtwgPDPGKlkk6IX
         K43xv/hgYfgXD8gPS6Ux8kb0wjG39HsFkpSzJ2r1aCkW7+qKE9dZOChEjzll91JfVIzf
         Fd3+Zr+Kknz1GG2VV0MGeysg3tUDdCDgeWYQ4dWJUnKxCR9Id/qyoVq2glGnNjx51aHo
         bp3smZLDVRoW9K004Hqidk4N0pv8m+Mh5LdcSjn6IfRrwimhumQUfUKxz/ZMKGsmmfy+
         aFlhDxKg+SBNeEPTxpTJq/+Z9Y7up2yC9de+/Y7a3xSzAKE37h1uxtieiMcKsL2PA9kw
         kndw==
X-Gm-Message-State: ACrzQf10lkr5bQ70Y46nmBe9FlpIYjf2DixB5PUv+YrNFM0Gd5KA4Mgy
        HJva2kPkMca+PLY/LjvOWY6c+rIVMUAdOdrbEcDijU7loT4cVz7YpG4Vj4l9Whnd0lWYI/liu14
        V7TCr9M4uU7Z5DRn7sz2kKhJ/BOIDnbI28goa9R5egk8wn8i+Ku8PO9Ruz7lsvMY32yeUBDbIcQ
        ==
X-Received: by 2002:a05:622a:cf:b0:35d:538c:7b91 with SMTP id p15-20020a05622a00cf00b0035d538c7b91mr21634831qtw.588.1664919687400;
        Tue, 04 Oct 2022 14:41:27 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5eJ43Cxi/6zQiWV/bSo8ZFXM9fZ9WcXa6rfp1aDx3I0WOIUGOdMcyE6esB7t52lXwuQpGz5w==
X-Received: by 2002:a05:622a:cf:b0:35d:538c:7b91 with SMTP id p15-20020a05622a00cf00b0035d538c7b91mr21634819qtw.588.1664919687145;
        Tue, 04 Oct 2022 14:41:27 -0700 (PDT)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id y15-20020a05620a25cf00b006bbf85cad0fsm15519956qko.20.2022.10.04.14.41.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 14:41:26 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>, peterx@redhat.com,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH 0/4] selftests/vm: Drop hugetlb mntpoint in run_vmtests.sh
Date:   Tue,  4 Oct 2022 17:41:21 -0400
Message-Id: <20221004214125.120993-1-peterx@redhat.com>
X-Mailer: git-send-email 2.37.3
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since I started working on patch 1 when debugging the race anyway, I
cleaned it up so we can use the same memfd for both hugetlb and shmem which
is cleaner.

Then I figured it's not hard if with patch 1 to replace all the file-based
test to use memfd for hugetlbb so I did.  Then patch 4 dropped the hugetlb
mntpoint for run_vmtests.sh.

Please have a look, thanks.

Peter Xu (4):
  selftests/vm: Use memfd for hugetlb tests
  selftests/vm: Use memfd for hugetlb-madvise test
  selftests/vm: Use memfd for hugepage-mremap test
  selftests/vm: Drop mnt point for hugetlb in run_vmtests.sh

 tools/testing/selftests/vm/hugepage-mremap.c | 21 +++----
 tools/testing/selftests/vm/hugetlb-madvise.c | 12 +---
 tools/testing/selftests/vm/run_vmtests.sh    | 18 +-----
 tools/testing/selftests/vm/userfaultfd.c     | 60 +++++++-------------
 4 files changed, 35 insertions(+), 76 deletions(-)

-- 
2.37.3

