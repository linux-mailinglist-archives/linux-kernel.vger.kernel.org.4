Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91AF86D0AA5
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 18:07:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbjC3QHh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 12:07:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjC3QHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 12:07:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11F218A7D
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 09:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680192409;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YTYh+E3AEUbIuKqZIO8jsHd8WLvzzX9QzK3UcbYoR1Y=;
        b=FkbnxmbQ+HS4mWJSUWx1fAgHuw0hNwb2B4Hug/dUxQ2dBJ2P82nRIuZ51nPm8x+xPEBiOp
        IGuCLLnQP2lsFeJfwEnyDs/nS0RPq5a/IM9On4rvK/TPGtIOTWHLnGr8oY2olnFLTAWTCd
        QO48g+JZTBKz9xixBk3Ng3qELKDNiX4=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-S9C5sULqPeCvmUFKY6xBPQ-1; Thu, 30 Mar 2023 12:06:46 -0400
X-MC-Unique: S9C5sULqPeCvmUFKY6xBPQ-1
Received: by mail-qv1-f71.google.com with SMTP id w2-20020a0cc242000000b00583d8e55181so8444510qvh.23
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 09:06:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680192406; x=1682784406;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YTYh+E3AEUbIuKqZIO8jsHd8WLvzzX9QzK3UcbYoR1Y=;
        b=lNgcfMumbktVd/xSk83qsnTKjjQGzyBAj/vQkOaTQ0CQGiGQRSInJU6/eHSyhannYi
         vMLxhXYIH7Y8/OzbpQTDxLeJYmMA7cPA5MZum51WmElDA4+YsIFeGBe12F0+WPWj5H2B
         NMhk6jP1qXtdl7IrO6MN9xZhanRiPwAHHT39dCvmjfEjauppYSwzxWxEzI4kNXIZFl3Q
         NYe/Sn8WoxevKtLLYhdLyJvYrLPJYiqi7CJTAGM6ZB9XbyDS8nT395S+j1DMIrmKu8Hi
         V6yiQa1ydxvuM+opVtzvNuXzu5Ig0QY9sjWCvAxpJMQNQjLiN6tgiK+UkE8ylNrqmy+h
         hxug==
X-Gm-Message-State: AO0yUKVvLRmh7D8mpqeRQxW6fc+hZIY0avXe9iLAYLAno/QBQ+fkkOLG
        Hw0aEbprt+yBmbRoMpKf2N0FzqV+Bxok5x2Rx+Q9Gngke3fNzo0BwToU6YArysHZCxLEWkzCFW0
        PpQNiAKemjzUX70NcBtoeG3Qt
X-Received: by 2002:a05:622a:1886:b0:3d1:16f4:ae58 with SMTP id v6-20020a05622a188600b003d116f4ae58mr37192710qtc.2.1680192406271;
        Thu, 30 Mar 2023 09:06:46 -0700 (PDT)
X-Google-Smtp-Source: AK7set+DfmwmgvSk/9QMK33YSWaZ+XaRstViNG93WHdzarb6l0ctIK/zH2ncD77kXk8cljlX9EelRg==
X-Received: by 2002:a05:622a:1886:b0:3d1:16f4:ae58 with SMTP id v6-20020a05622a188600b003d116f4ae58mr37192679qtc.2.1680192406057;
        Thu, 30 Mar 2023 09:06:46 -0700 (PDT)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-40-70-52-229-124.dsl.bell.ca. [70.52.229.124])
        by smtp.gmail.com with ESMTPSA id 66-20020a370b45000000b0071eddd3bebbsm11294515qkl.81.2023.03.30.09.06.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 09:06:44 -0700 (PDT)
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
Subject: [PATCH 02/29] selftests/mm: Update .gitignore with two missing tests
Date:   Thu, 30 Mar 2023 12:06:43 -0400
Message-Id: <20230330160643.3106892-1-peterx@redhat.com>
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

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tools/testing/selftests/mm/.gitignore | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/mm/.gitignore b/tools/testing/selftests/mm/.gitignore
index 1f8c36a9fa10..347277f2adc3 100644
--- a/tools/testing/selftests/mm/.gitignore
+++ b/tools/testing/selftests/mm/.gitignore
@@ -36,3 +36,5 @@ split_huge_page_test
 ksm_tests
 local_config.h
 local_config.mk
+ksm_functional_tests
+mdwe_test
-- 
2.39.1

