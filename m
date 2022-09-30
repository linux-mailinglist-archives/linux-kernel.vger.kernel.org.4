Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 037085F10FA
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 19:37:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232011AbiI3RhD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 13:37:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231426AbiI3RhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 13:37:01 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 787FB2B1AD
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 10:36:59 -0700 (PDT)
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 47AFE3F488
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 17:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1664559417;
        bh=bJ5bo6LVjlHiEIphRJtRsnM1mvDaXy5QFV28soKQ3Y4=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=VyhMV/oVXA812rFtigAARnbFKGkuPT5auojxphm0LbWNhe2l40D0WqC/S86PSFcTk
         Yuw/JqvJ7P8KLlXzvDiJVEcjE9/T368ptn+P1pHwc4IfZq0ltSIoxboKFi0iHoa6I+
         tn2NNRCPdw4LAJRogm0uzUm2Pmi2FsV8O2Fhm5EQkWDog2xVGjlrllR/k0MSDnbp4m
         C4UI6AAIlqwYWSPznH3g8KwrVvodE2FLNq+DmJ6gfX9EEJb+tP2VJBe5hS9yvaZrcM
         tAnQxZ6OCqq/orqdTADL+qdYjJzWs/WgcfBOmTF+ROrcv7QYI2p5TMJzLQi4ooboUJ
         JEEXakOIqFeMQ==
Received: by mail-pg1-f199.google.com with SMTP id k16-20020a635a50000000b0042986056df6so3210099pgm.2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 10:36:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date;
        bh=bJ5bo6LVjlHiEIphRJtRsnM1mvDaXy5QFV28soKQ3Y4=;
        b=RrweR/ZCc30C0ryWwuz/8T3IW3DEFIV+uUiR/929Vm96s5DuvuxegFJDrQkIJEOLe+
         vj7YTVQVLZnxFpXRkQBVUA22h8KaUVZv3dqvqL3ZFcDUtoQmqWw/5pjPwaIK7iAfaKVW
         6i6DRfymj5YrJqKE3l8YApY1LXDtSRiwfhCu5OYKWdg0qHFAomMfqxPHTyc20Vn31LVQ
         TPTjspc9fVn5bLFmPmSJkShL6hhAFQ7wUbzC2SWXV7dUgzPSmpGSg5yI5GFV2RF0Q0v0
         d1GW5HYRlFwfcsTlYl2hf7r8AXkBzO2RJm6BagxEpBPlyGh/XMl8M4DUlKQHLtx4aGJO
         2H7Q==
X-Gm-Message-State: ACrzQf2pfCChgn6zSDu66kuH/PeHumK74n92C7OmXFf0qmyjYX/qHCJz
        DP3mAS9Rd8pwtVgUvjEjVygqkCe6P0R+kxobOYhx72WWtTRbyGptd8gtiD9GIh3EIwlcJNgUmAa
        ys8u+w3B/p/jXZWSMnoU2+52CG91dM1ka41Wfs1vnuw==
X-Received: by 2002:a63:6a09:0:b0:43a:20d4:85fe with SMTP id f9-20020a636a09000000b0043a20d485femr8371839pgc.625.1664559415512;
        Fri, 30 Sep 2022 10:36:55 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5kOWRGJJe1m9sHK/Tz/IEJp3mc8mER4MEFXVX2q6ncDc1ctIej2T+SbCuV/9emYNGDXrjUZQ==
X-Received: by 2002:a63:6a09:0:b0:43a:20d4:85fe with SMTP id f9-20020a636a09000000b0043a20d485femr8371824pgc.625.1664559415212;
        Fri, 30 Sep 2022 10:36:55 -0700 (PDT)
Received: from canonical.com (2001-b011-3815-12c7-62cc-9df5-f950-3a6d.dynamic-ip6.hinet.net. [2001:b011:3815:12c7:62cc:9df5:f950:3a6d])
        by smtp.gmail.com with ESMTPSA id 207-20020a6305d8000000b0043be00f867fsm1936963pgf.60.2022.09.30.10.36.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 10:36:54 -0700 (PDT)
From:   Koba Ko <koba.ko@canonical.com>
To:     Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Jie Hai <haijie1@huawei.com>, Dave Jiang <dave.jiang@intel.com>
Subject: [PATCH V2] dmaengine: Fix client_count is countered one more incorrectly.
Date:   Sat,  1 Oct 2022 01:36:52 +0800
Message-Id: <20220930173652.1251349-1-koba.ko@canonical.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the passed client_count is 0,
it would be incremented by balance_ref_count first
then increment one more.
This would cause client_count to 2.

cat /sys/class/dma/dma0chan*/in_use
2
2
2

Fixes: d2f4f99db3e9 ("dmaengine: Rework dma_chan_get")
Signed-off-by: Koba Ko <koba.ko@canonical.com>
Reviewed-by: Jie Hai <haijie1@huawei.com>
Test-by: Jie Hai <haijie1@huawei.com>
Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>

---
V2: Remove [3/3] on subject.
---
 drivers/dma/dmaengine.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index 2cfa8458b51be..78f8a9f3ad825 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -451,7 +451,8 @@ static int dma_chan_get(struct dma_chan *chan)
 	/* The channel is already in use, update client count */
 	if (chan->client_count) {
 		__module_get(owner);
-		goto out;
+		chan->client_count++;
+		return 0;
 	}
 
 	if (!try_module_get(owner))
@@ -470,11 +471,11 @@ static int dma_chan_get(struct dma_chan *chan)
 			goto err_out;
 	}
 
+	chan->client_count++;
+
 	if (!dma_has_cap(DMA_PRIVATE, chan->device->cap_mask))
 		balance_ref_count(chan);
 
-out:
-	chan->client_count++;
 	return 0;
 
 err_out:
-- 
2.25.1

