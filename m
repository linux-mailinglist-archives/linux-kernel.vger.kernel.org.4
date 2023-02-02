Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 759FB687A9A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 11:46:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232460AbjBBKqh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 05:46:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232789AbjBBKqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 05:46:22 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A7FA8A7EC
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 02:45:43 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id o13so1532736pjg.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 02:45:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igel-co-jp.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Wj1wi+vfvB54wfWKyUZTobNpEfDR2hWH6JizNjshTls=;
        b=xr7SVjq+Qi9fFt/m3pDEUSVVbaizv/QkcY3BkJv7lSkED89MyE2o2ADQSMSY+dFiNY
         eJH5YIxIAEkkg00mBo3BhLjSprH/g46aK8aiEU6y6SqA4wQPGSXcuqJaKHS7rFy5Hpu2
         dFQjraopoEqzjZhNU1wGcGKjF3WbPxhtwJGSf7CeBRvpCBb4KUkYXQrxJCYiB4FLOUjh
         2SGFbPzMDI85JfBYkQl6YW6L3rp6Un1NquGXRUWrqoSt2eki8rm+f4nHpb6sfOKZfOkx
         LM3gJ8746ODgyOIaHCbQOimsq6+RCG/lZ5PDKu+8ttyyp2wGZb/u8ajv78GfsVlRVlPf
         zcWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wj1wi+vfvB54wfWKyUZTobNpEfDR2hWH6JizNjshTls=;
        b=GdJlnxVoYuNzDdqoh6k8rjg2O3Hgd9ci5Nvgshw9w6Ysz5pYsWvlOePudOblL7IJrr
         wLPrOUIvQ+G6N5xNe3iX24orqcC5vs5mTazXHzYV54D1U/QOgymHnISymLKsPlWKq8Tw
         3V47jMWgO3rHT6z3Hdk3Q6CK8aycAzDzcMjpcARFoRryOIc6qrnsKLMHX8d7h7eLISoX
         /GAVY98tIbsZIE06nRB/friNxva0IM1wNC3MII6tldJtpE9y0eBxxJJusxaCNoZG9vag
         gdQiP4T/WgacaSKUq+KnPUzKMFpz9MDTlNgAV+yyakdC74nT4pHZxIK1IPmp0orcutTv
         zDgQ==
X-Gm-Message-State: AO0yUKVKKOZiVKPM9Zg0nYRQePV6RNHky8qoASjZ455JimMJp2019csj
        V0ijzeAm7MeTdSjluqSHFnqe+A==
X-Google-Smtp-Source: AK7set8wpF7VU0PIG0iDBH0+zdbpzQ/i+YdEY06ArnDW1Hqqjrgqjz7XwAHfBQ+YFbg6wWYwlSEbQQ==
X-Received: by 2002:a17:90b:4ac1:b0:22c:8b3f:e1a1 with SMTP id mh1-20020a17090b4ac100b0022c8b3fe1a1mr6262204pjb.19.1675334742618;
        Thu, 02 Feb 2023 02:45:42 -0800 (PST)
Received: from tyrell.hq.igel.co.jp (napt.igel.co.jp. [219.106.231.132])
        by smtp.gmail.com with ESMTPSA id j6-20020a17090a840600b002270155254csm2919193pjn.24.2023.02.02.02.45.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 02:45:42 -0800 (PST)
From:   Shunsuke Mie <mie@igel.co.jp>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Shunsuke Mie <mie@igel.co.jp>
Subject: [PATCH] tools/virtio: enable to build with retpoline
Date:   Thu,  2 Feb 2023 19:45:38 +0900
Message-Id: <20230202104538.2041879-1-mie@igel.co.jp>
X-Mailer: git-send-email 2.25.1
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

Add build options to bring it close to a linux kernel. It allows for
testing that is close to reality.

Signed-off-by: Shunsuke Mie <mie@igel.co.jp>
---
 tools/virtio/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/virtio/Makefile b/tools/virtio/Makefile
index 1b25cc7c64bb..7b7139d97d74 100644
--- a/tools/virtio/Makefile
+++ b/tools/virtio/Makefile
@@ -4,7 +4,7 @@ test: virtio_test vringh_test
 virtio_test: virtio_ring.o virtio_test.o
 vringh_test: vringh_test.o vringh.o virtio_ring.o
 
-CFLAGS += -g -O2 -Werror -Wno-maybe-uninitialized -Wall -I. -I../include/ -I ../../usr/include/ -Wno-pointer-sign -fno-strict-overflow -fno-strict-aliasing -fno-common -MMD -U_FORTIFY_SOURCE -include ../../include/linux/kconfig.h
+CFLAGS += -g -O2 -Werror -Wno-maybe-uninitialized -Wall -I. -I../include/ -I ../../usr/include/ -Wno-pointer-sign -fno-strict-overflow -fno-strict-aliasing -fno-common -MMD -U_FORTIFY_SOURCE -include ../../include/linux/kconfig.h -mfunction-return=thunk -fcf-protection=none -mindirect-branch-register
 CFLAGS += -pthread
 LDFLAGS += -pthread
 vpath %.c ../../drivers/virtio ../../drivers/vhost
-- 
2.25.1

