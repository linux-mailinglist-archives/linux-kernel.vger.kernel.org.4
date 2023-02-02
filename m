Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 931BD687861
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 10:10:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232156AbjBBJKD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 04:10:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232456AbjBBJJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 04:09:48 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C64A7CC9A
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 01:09:47 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id pj3so1321084pjb.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 01:09:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igel-co-jp.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wj1wi+vfvB54wfWKyUZTobNpEfDR2hWH6JizNjshTls=;
        b=1Q/JH/sUAULTsLNVNGl+nJTH5Ax+tvJ+1r2DKsuwDfuOKK7Ec5J5bJnGtXbC45rfRC
         VynUJt6ACswjfIqa8MV8+aq8oj2HUPBfP0teYR/JHiz+uQcFDcvG0/t/1tUEWyWzCg4C
         EimV0skFo5WvorB8MwJjeN8RIM/0KZVjSL/U4Sq0/P3w8M+bciIDr8PXRPnNxwMYuhYp
         1uiIuZ1jZjWhqoykheNnB5QXWK6a0cb6X28sqYlLwQCnLc5tCl4KDqOueYTg1dZN8kaY
         gmXpt3eUAfDfZVXRPQ+OpYdbRcV6fVlEfZT1k2vMJ14BWtV2uVBge9Y8HoZ7t7JtqZDK
         i3eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wj1wi+vfvB54wfWKyUZTobNpEfDR2hWH6JizNjshTls=;
        b=ve/y1LUmDxMRSgFc0ct1zA/S9S7Uk7SO2EE3oNMVv3lRv4UNHyuzJmzeJjFfr99NDy
         guIgEppgcwu3D8Pd5lW3Ye2WtJgS+R7Sce4fRoX+0R1uCDDWkTxcq/cI6GEjSPXYCNPt
         G7Rbw5tpcXt0oDwD4BxGdtJxjCEbxauZGxV7pdEjf70CNAcO6RGZ8mPRGuX86CSHyZpw
         gqKJWxRWs6V+wO3nXdSRDZf8nhqJBw5bPLyAjm++k4BNywIG39d29AzdOn+tTwQGEnRB
         2FogomRMVMXa7KBvdgqugW12X3iV3hLPQDd5Q4TIJI+24+jp2cAuJpQOQDwwfvbguK3W
         FHvA==
X-Gm-Message-State: AO0yUKWL1PT0JUkp2a+F1rcjVxpGlILiqp8go2qcVulrmJaSlsnNMs0P
        URUXIqHSithtIXkSzstDg5/wPQ==
X-Google-Smtp-Source: AK7set8Mjt/sTl97PMKSnJmxqA5B1xuZBtgxd19g5SZqOTcdXWGQrZOHsyfNQ13X71sz0ldcLMsDJg==
X-Received: by 2002:a17:902:e810:b0:194:81c9:b8da with SMTP id u16-20020a170902e81000b0019481c9b8damr7411648plg.3.1675328986637;
        Thu, 02 Feb 2023 01:09:46 -0800 (PST)
Received: from tyrell.hq.igel.co.jp (napt.igel.co.jp. [219.106.231.132])
        by smtp.gmail.com with ESMTPSA id ik12-20020a170902ab0c00b001929827731esm13145968plb.201.2023.02.02.01.09.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 01:09:46 -0800 (PST)
From:   Shunsuke Mie <mie@igel.co.jp>
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Rusty Russell <rusty@rustcorp.com.au>
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shunsuke Mie <mie@igel.co.jp>
Subject: [RFC PATCH v2 2/7] tools/virtio: enable to build with retpoline
Date:   Thu,  2 Feb 2023 18:09:29 +0900
Message-Id: <20230202090934.549556-3-mie@igel.co.jp>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230202090934.549556-1-mie@igel.co.jp>
References: <20230202090934.549556-1-mie@igel.co.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
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

