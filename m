Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD16E700439
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 11:48:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240319AbjELJs0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 05:48:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240120AbjELJsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 05:48:24 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 291E930E7
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 02:48:23 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-64a9335a8e7so4364826b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 02:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1683884902; x=1686476902;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xQT0FmogO5TGY0rbQj7fXytMe4BFJtheTdNHt0t5iWE=;
        b=crfSML1D5wH7IO5vc+OyCVHZrQULvGv9CCRF1/naJtHJtQvEtBJue48p2BLCutjHdx
         k/3GgoGdwnBmEGE4B+5SMLpmay4Pgjpccn5NWT+WKQ/2h5wTCoZhc3EfGRYnW+LETqJl
         8gHlKIAXXbrGB87dkSZQ2y0/MNMJLzUeWKb8R9fcOHObPNix/I9+CCqa+PRuRYxqwgDa
         99pqlMt+lI9RgDqZro8ewFxfZrOMi9/TEUpXSignIUAHjfzaT6BV7uP4aWmikLvGUkik
         O+NjI7Tt2wIrBWDIdy4QHQbNoaHkb5ihUXuuap2onVXBURooML4V/B2gLlW9SwjCJIic
         Wmhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683884902; x=1686476902;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xQT0FmogO5TGY0rbQj7fXytMe4BFJtheTdNHt0t5iWE=;
        b=QDzYOOwvspmLbqJ/IidDXWBep8By5g8lIzX0ENPLSlu/C1dVdEC48+yNBbmD2dKwhn
         5NrCrV1O73Z5TsBkBLVKIkvqdoCWJ6Ke8gq1ZzyaBtFdHd+1bh1dU3+ZyOJOWsFQfCeo
         X9DsdlHr867qAgPRUu2fGt9GI0rgj45bCeCyzZ56ebNtyrSjf+wCZtUX5o1pPBc2Emms
         xJO6i0TVaPmbatYlFv61HfNsZtDlDoYpmCAjkyngQQ0Irp93AaJZe1idyL5yM9w028oU
         CHwKVxGTa1Nm7nWs91TFrNbLqbR7MXrrR67DdjyUpQ+a98OB0uEQvlV+Oc6BF01yQcgr
         LhlQ==
X-Gm-Message-State: AC+VfDxaG60UuZI1L55eM3iX/c6GGrJdLB6WgaomoNpdFHTcc5xvB4BT
        u9OaHmmsMdEqU9mMmraIi8i93ih31/bZb0d3tuo=
X-Google-Smtp-Source: ACHHUZ6jca329PTc/0Z6VeTJ8ExSq29nobPjfYbIoKeiC5aivyG/NRPzQV74tXnzbHRlO+aAZ1NNlA==
X-Received: by 2002:a17:902:e547:b0:1ac:b03c:a58e with SMTP id n7-20020a170902e54700b001acb03ca58emr11886825plf.25.1683884902614;
        Fri, 12 May 2023 02:48:22 -0700 (PDT)
Received: from always-x1.bytedance.net ([61.213.176.13])
        by smtp.gmail.com with ESMTPSA id x17-20020a170902821100b001a6d4ffc760sm7452956pln.244.2023.05.12.02.48.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 02:48:22 -0700 (PDT)
From:   zhenwei pi <pizhenwei@bytedance.com>
To:     stefanha@redhat.com, mst@redhat.com, jasowang@redhat.com
Cc:     xuanzhuo@linux.alibaba.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, zhenwei pi <pizhenwei@bytedance.com>
Subject: [PATCH 0/2] virtio: abstract virtqueue related methods
Date:   Fri, 12 May 2023 17:46:16 +0800
Message-Id: <20230512094618.433707-1-pizhenwei@bytedance.com>
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

 drivers/virtio/virtio.c      | 362 ++++++++++++++++++++++++++++++++++
 drivers/virtio/virtio_ring.c | 282 +++++----------------------
 include/linux/virtio.h       |  29 +++
 tools/virtio/Makefile        |   4 +-
 tools/virtio/linux/virtio.h  |  30 +++
 tools/virtio/virtqueue.c     | 367 +++++++++++++++++++++++++++++++++++
 6 files changed, 842 insertions(+), 232 deletions(-)
 create mode 100644 tools/virtio/virtqueue.c

-- 
2.20.1

