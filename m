Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6EDB6BF5F8
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 00:07:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbjCQXHR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 19:07:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjCQXHO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 19:07:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FFD73AAD
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 16:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679094385;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=i4/4tOgwP/X+xCG5XArCzD3rKZ+G/aYQCWfq3NKAVk0=;
        b=OFZYryhY8a8j6wY25jWfU8Xm/w6c5EJbZKSz0pBWRP69FCDGxUDQuNeYPAK6iPUcgUW3a7
        /6PqFRHISdgfxvfpVvSPOmazzHbcsOfEepdXYwLbYJsVE+rm2sX9paMLkj2QtKCknSqy9N
        rvsLWwEUU7UgTGPlzchcCooJoYUftSY=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-271-BdU3IqLgNSGma0x76hMmzw-1; Fri, 17 Mar 2023 19:06:23 -0400
X-MC-Unique: BdU3IqLgNSGma0x76hMmzw-1
Received: by mail-qk1-f200.google.com with SMTP id d23-20020ae9ef17000000b007464ce9a4f5so2632949qkg.18
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 16:06:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679094383;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i4/4tOgwP/X+xCG5XArCzD3rKZ+G/aYQCWfq3NKAVk0=;
        b=AU+91VNyMDobwBynsvJTiX7y14OjuLAbM0PR5m6aMolHXVOqVcetQpz0C3t5RvxiYp
         I/AYk9y0R389M2QVakawklR3k7RvzlCOb2OsarMu77j7KZeBFijZNlfmG1sVgcAqNNpV
         lqam61MaHMvGR+AASyzsZzHsY/dS9TNz78uiF0SqMQ4AqFcH8L7qhBeZfq6PQyVuI/47
         fwsodMGa7BwOgoAbnrq4XhP78ZJrTTnVHfrOZWS21LUmisk+e5ig7BFWk3UaI42EvqPi
         yGN+0EbMs3gIt+Fs1BrNQhMG6/l9y4Lu2XUcJEOgHHKD6MGHOPtfIzm3qsYPdJVYLP8C
         6ICw==
X-Gm-Message-State: AO0yUKVG8l2PBA73Y0DXEbu0ibsl04N6k0WWxh7Of/DZ1h1MjNSJTCwy
        OOrs8GdEKNxUNJAD34k77qyJpNJovoVfzo6zMvxUNfGJjH4DsNTNd/iml7X7mbMk4BmdHwZLP+B
        WfFbz0cGqQSL9+TZF96OkfaAN
X-Received: by 2002:a05:6214:1250:b0:56e:a0fb:18ab with SMTP id r16-20020a056214125000b0056ea0fb18abmr43535294qvv.19.1679094383190;
        Fri, 17 Mar 2023 16:06:23 -0700 (PDT)
X-Google-Smtp-Source: AK7set+CvCK7xfA2z4a8rn/h8YoqqpGCDL9n+rxJp8+V5zj/8rhXm9CC2WiHcUfi72KYNIoH5Wu+QQ==
X-Received: by 2002:a05:6214:1250:b0:56e:a0fb:18ab with SMTP id r16-20020a056214125000b0056ea0fb18abmr43535257qvv.19.1679094382804;
        Fri, 17 Mar 2023 16:06:22 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id 13-20020a37080d000000b007456efa7f73sm2518474qki.85.2023.03.17.16.06.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 16:06:22 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     mdf@kernel.org, hao.wu@intel.com, yilun.xu@intel.com,
        michal.simek@xilinx.com, nathan@kernel.org, ndesaulniers@google.com
Cc:     linux-fpga@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] fpga: xilinx-pr-decoupler: remove unused xlnx_pr_decouple_read function
Date:   Fri, 17 Mar 2023 19:06:17 -0400
Message-Id: <20230317230617.1673923-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
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

clang with W=1 reports
drivers/fpga/xilinx-pr-decoupler.c:37:19: error: unused function 'xlnx_pr_decouple_read' [-Werror,-Wunused-function]
static inline u32 xlnx_pr_decouple_read(const struct xlnx_pr_decoupler_data *d,
                  ^
This static function is not used, so remove it.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/fpga/xilinx-pr-decoupler.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/fpga/xilinx-pr-decoupler.c b/drivers/fpga/xilinx-pr-decoupler.c
index 2d9c491f7be9..b6f18c07c752 100644
--- a/drivers/fpga/xilinx-pr-decoupler.c
+++ b/drivers/fpga/xilinx-pr-decoupler.c
@@ -34,12 +34,6 @@ static inline void xlnx_pr_decoupler_write(struct xlnx_pr_decoupler_data *d,
 	writel(val, d->io_base + offset);
 }
 
-static inline u32 xlnx_pr_decouple_read(const struct xlnx_pr_decoupler_data *d,
-					u32 offset)
-{
-	return readl(d->io_base + offset);
-}
-
 static int xlnx_pr_decoupler_enable_set(struct fpga_bridge *bridge, bool enable)
 {
 	int err;
-- 
2.27.0

