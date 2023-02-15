Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3463697F7C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 16:24:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230130AbjBOPYy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 10:24:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbjBOPYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 10:24:52 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E48462D4A
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 07:24:24 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id o8so18191916pls.11
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 07:24:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112; t=1676474664;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7ChDZzA05xcm0/ZNkR3nCKSD7audyj5A66jkFmfs4d8=;
        b=yLEs2XLyyLIQyBX9kJhyGXQFLvTTHVODzB7wQaKILm+o6Yr0dDoX2ewO5IUD/PxcDL
         T4C+fwMnNhrqLFlUythIvtY3soGh4e9zffOctzbN1rIBu7axKgEyH445iImwETYzenfs
         QsMct5QxgRVnQ6rw/FLHmr5WHjCdR6pMUvelD2yn/tPWEKEcooOXvzdYnrqMASZV/Uka
         uhpXEb0ZwStEc12OL4x52UTdGpptKC33+TGYSYUUFkqnnlNlR2RnOJ39lC4hfb2Na+xW
         qxTfas6tXekVjFwf8X1Q1zVRYSHrGLRo0GdkDkhgikNQeq6U4VZQum/JQdMKOVB6mIrZ
         BDQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676474664;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7ChDZzA05xcm0/ZNkR3nCKSD7audyj5A66jkFmfs4d8=;
        b=e1aZfDfg1ER2Yb1qpLAuTBOI8xug8VwjB+LJYpbguujP7vDWZcAjbBka2rLIGZ4sbT
         AQ9ETieG53Uii/ahQwLzbcWk1xT0rO1zfF3MtdHzQhxArzZtAXcXQ6NtQaXdx8z7DJaG
         L/DwVmBItrmXHYbe+aAnh8WuyDgy+1250u/U9MD8CrO4KAXsrd5FkAunPazWbl3AbMwy
         8U2jSeQ2SN4Q4zbI9zkpDZgwe/hOUZYTGbCw8JbU3ToukfuAfDBLRoKL3q9jWo6+65Dn
         wCwG+eJwaIwheNbwXJtYwiGfZ6MpLCH1MZJeN3L1MaQg1bm0zLKcoHy3MA4Zyiip4e2U
         unZA==
X-Gm-Message-State: AO0yUKUuNGDWVPjb8iDjrc4iZX1s26yinaDozp3FEmgZn9vQiSW8rcHo
        eaeyvujj+Bn36mZxpLRbblH2dQ==
X-Google-Smtp-Source: AK7set/sEz9TYpPCi4z/Nc1UBcRAV6t/tAeN55ColrML/Tw+taqRhsKQEEDpjSciqcePc0rgoVoW2Q==
X-Received: by 2002:a17:902:c40d:b0:19a:84b0:4845 with SMTP id k13-20020a170902c40d00b0019a84b04845mr3233632plk.5.1676474664443;
        Wed, 15 Feb 2023 07:24:24 -0800 (PST)
Received: from localhost.localdomain ([139.177.225.228])
        by smtp.gmail.com with ESMTPSA id jh12-20020a170903328c00b0019682e27995sm6176997plb.223.2023.02.15.07.24.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Feb 2023 07:24:23 -0800 (PST)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, vbabka@suse.cz, david@redhat.com,
        rppt@kernel.org, mhocko@suse.com
Cc:     willy@infradead.org, mgorman@techsingularity.net,
        osalvador@suse.de, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH 0/2] handle memoryless nodes more appropriately
Date:   Wed, 15 Feb 2023 23:24:10 +0800
Message-Id: <20230215152412.13368-1-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Currently, in the process of initialization or offline memory, memoryless
nodes will still be built into the fallback list of itself or other nodes.

This is not what we expected, so this patch series removes memoryless
nodes from the fallback list entirely.

Comments and suggestions are welcome.

Thanks,
Qi

Qi Zheng (2):
  mm: page_alloc: skip memoryless nodes entirely
  mm: memory_hotplug: drop memoryless node from fallback lists

 mm/memory_hotplug.c | 2 +-
 mm/page_alloc.c     | 7 +++++--
 2 files changed, 6 insertions(+), 3 deletions(-)

-- 
2.20.1

