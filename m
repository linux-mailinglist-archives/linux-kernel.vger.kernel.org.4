Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38364705D8E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 04:57:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232256AbjEQC47 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 22:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231207AbjEQC44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 22:56:56 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C062E448C
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 19:56:32 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-6434e65d808so193738b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 19:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1684292192; x=1686884192;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0ZO1TY70d7JB54ZSdTzcbWlEKFT+XnqOX871W+Km0K4=;
        b=M/J5k6mpUDJ7zHnVuje5rzGIiUI4Fg5+wLDHTXT1id7bm7QXJTEs+JIbbz0KNOPlHP
         5RHGgG2nCX/wB65HSNpsJsx7WlN+Q1iopT7D9j9GVBSOxHR2qxhShnJKb3IzZmtb+9ue
         Z8gVkhum+qzraD7SObBaFfdehgltTpwR87/Qjg6tEAM9c2jSGZdLpUTMSI3+La3sxZop
         yXkTqN89pzj+QFfTVclKC6MGgbbL9XsdFCCSHKvVNhjRD3qfU3Umsvj7zxr4lvDJat03
         DF7g2yBjgODafx8wj0zX71ThL+T444fKM4hCeK155iq38q6D54vPTABWJHGROlQhEXJT
         G10g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684292192; x=1686884192;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0ZO1TY70d7JB54ZSdTzcbWlEKFT+XnqOX871W+Km0K4=;
        b=jFdyAxW3X/8Dfr4PbTAHkKTsxsX228jJeLs4NHauZR9tnEqqrtVqdWw/YY+higmzgY
         KnOQAHXF/ykliOctJxanQrQ2fOk9oxTtBn2tBa3JC4DywFtTJoGg5HsIVcO0/a62sR1a
         yQ0N4Owx+2RpJ9deK3+gg2ktHTnlFWdus2L/FH6I6IjYpGobJFmSCVHXaOEU+ZQzK9Ve
         agDx2jygtaN64qf1/QHKHRhxv2HwQbHOnKI2g5R4YQqvDbofwb6YeVNKciH+KsDBwvI4
         14j0Bs6IxHcZCobad3tjkRQ0pgDcFZCZ2I++1gGOFBypfniDPOVDODb8dYHPGxD4lcsm
         Lu7A==
X-Gm-Message-State: AC+VfDymI0qa4RsaV6sGhHAixQfX2hZL4QikQF4NRf9GTiA3DeBnEzHt
        Ph6qBKHhe05yrsZ1s03mNOZhdw==
X-Google-Smtp-Source: ACHHUZ5WauqPWuzVwbbCM7sQ9PlEsup7ohuTtKWD2cYYNIVL/pEsXFcV4RvdmCyZbIvzdCV4lx/qdg==
X-Received: by 2002:aa7:88ce:0:b0:645:cfb0:2779 with SMTP id k14-20020aa788ce000000b00645cfb02779mr35734717pff.26.1684292192266;
        Tue, 16 May 2023 19:56:32 -0700 (PDT)
Received: from always-x1.bytedance.net ([61.213.176.11])
        by smtp.gmail.com with ESMTPSA id b19-20020aa78713000000b00643355ff6a6sm14527971pfo.99.2023.05.16.19.56.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 19:56:31 -0700 (PDT)
From:   zhenwei pi <pizhenwei@bytedance.com>
To:     stefanha@redhat.com, mst@redhat.com, jasowang@redhat.com
Cc:     xuanzhuo@linux.alibaba.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, zhenwei pi <pizhenwei@bytedance.com>
Subject: [PATCH v2 0/2] virtio: abstract virtqueue related methods
Date:   Wed, 17 May 2023 10:54:22 +0800
Message-Id: <20230517025424.601141-1-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v1 -> v2:
- Suggested by MST, use fast path for vring based performance
sensitive API.
- Reduce changes in tools/virtio.

Add test result(no obvious change):
Before:
time ./vringh_test --parallel
Using CPUS 0 and 191
Guest: notified 10036893, pinged 68278
Host: notified 68278, pinged 3093532

real	0m14.463s
user	0m6.437s
sys	0m8.010s

After:
time ./vringh_test --parallel
Using CPUS 0 and 191
Guest: notified 10036709, pinged 68347
Host: notified 68347, pinged 3085292

real	0m14.196s
user	0m6.289s
sys	0m7.885s

v1:
Hi,

3 weeks ago, I posted a proposal 'Virtio Over Fabrics':
https://lists.oasis-open.org/archives/virtio-comment/202304/msg00442.html

Jason and Stefan pointed out that a non-vring based virtqueue has a
chance to overwrite virtqueue instead of using vring virtqueue.

Then I try to abstract virtqueue related methods in this series, the
details changes see the comment of patch 'virtio: abstract virtqueue related methods'.

Something is still remained:
- __virtqueue_break/__virtqueue_unbreak is supposed to use by internal
  virtio core, I'd like to rename them to vring_virtqueue_break
  /vring_virtqueue_unbreak. Is this reasonable?
- virtqueue_get_desc_addr/virtqueue_get_avail_addr/virtqueue_get_used_addr
  /virtqueue_get_vring is vring specific, I'd like to rename them like
  vring_virtqueue_get_desc_addr. Is this reasonable?
- there are still some functions in virtio_ring.c with prefix *virtqueue*,
  for example 'virtqueue_add_split', just keep it or rename it to
  'vring_virtqueue_add_split'?
zhenwei pi (2):
  virtio: abstract virtqueue related methods
  tools/virtio: implement virtqueue in test

 drivers/virtio/virtio_ring.c | 285 +++++-----------------
 include/linux/virtio.h       | 441 +++++++++++++++++++++++++++++++----
 include/linux/virtio_ring.h  |  26 +++
 tools/virtio/linux/virtio.h  | 355 +++++++++++++++++++++++++---
 4 files changed, 807 insertions(+), 300 deletions(-)

-- 
2.20.1

