Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40AC56C859D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 20:07:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231445AbjCXTHp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 15:07:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231215AbjCXTHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 15:07:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 544E61A942
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 12:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679684812;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=m1e+oH63s8EilReY/6J1/4GgJ3Yip783LTwv8q9nidY=;
        b=X4GVWJrPUP7H58rDM/uvIswL6yH4xPikqC3Ti5T4DgQQNm57WvaB2eZpWgU+CjdGszDSWV
        Rnx6WcH8cFJfdrrqIEmLppYojo4r+6HhF14BrZ5D0eTjWRJDGwg0c61sFrom9DjxUHm4c9
        pJisvTGzYMeoQUaN6VRB0W7tdPrZbOw=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-346-SqmrjD7WNfaxL3ywTfrlCA-1; Fri, 24 Mar 2023 15:06:51 -0400
X-MC-Unique: SqmrjD7WNfaxL3ywTfrlCA-1
Received: by mail-qt1-f199.google.com with SMTP id t15-20020a05622a180f00b003e37dd114e3so1584644qtc.10
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 12:06:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679684810;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m1e+oH63s8EilReY/6J1/4GgJ3Yip783LTwv8q9nidY=;
        b=pIhMN8mrVPL8uLAAdPUX0lSC6Uw+3x6qHi1WAqB/t4I5wDVbUEIEzDbLRtlGtJ3956
         mesZNCs9TZSFOXet8fw5iWd7jRUdTasZ4qTdU9XohIqkRbnlrhgEb+UX3VsJmRaoPRpn
         atmXj6j1/B0KceCBvZI0wmIE9K6HnTQJb4muI+0jTde2b64AixMB+UglBSynlElmh7XR
         pdTvxuF1Gy5jLR4a+VfyT07cXJXluSiziyVPxrAXN8EAFZkdDmR0zEkcPy5RtT6JtIyb
         4KvD25sv0B6DFcDDEmSgYUePl9ohyXfglodqRlGcrJq9tpQNbNz6anrFKYXby5PqdXOS
         Kxsg==
X-Gm-Message-State: AAQBX9c2ybygQi4/OVKeT2x51sLts1fTmPEk4ll5NXg6dnsO74DcbIJH
        X8vdOmkbhpHRId6X8kxSfolBDkvNkkIoNb/FuqVUJEMsg7c/FvtrjtaWWSPCV+SlYkghIwtWdl0
        9ni2i9FBwoSJOlz+VVbSTECVE
X-Received: by 2002:a05:6214:27e8:b0:5a9:2bc0:ea8b with SMTP id jt8-20020a05621427e800b005a92bc0ea8bmr5351758qvb.47.1679684810468;
        Fri, 24 Mar 2023 12:06:50 -0700 (PDT)
X-Google-Smtp-Source: AKy350YuWvGXZU1QVTitk/8JsI8hEFHXd1EPDpR8zn1NFJSLnBRtZ4fzQy+1va5RMqv6w0SUiL2WXw==
X-Received: by 2002:a05:6214:27e8:b0:5a9:2bc0:ea8b with SMTP id jt8-20020a05621427e800b005a92bc0ea8bmr5351729qvb.47.1679684810228;
        Fri, 24 Mar 2023 12:06:50 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id kr15-20020a0562142b8f00b005dd8b93456csm885828qvb.4.2023.03.24.12.06.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 12:06:49 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     zajec5@gmail.com, nathan@kernel.org, ndesaulniers@google.com
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Tom Rix <trix@redhat.com>
Subject: [PATCH] bcma: remove unused mips_read32 function
Date:   Fri, 24 Mar 2023 15:06:47 -0400
Message-Id: <20230324190647.2654293-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
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

clang with W=1 reports
drivers/bcma/driver_mips.c:49:19: error: unused function
  'mips_read32' [-Werror,-Wunused-function]
static inline u32 mips_read32(struct bcma_drv_mips *mcore,
                  ^
This function is not used so remove it.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/bcma/driver_mips.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/bcma/driver_mips.c b/drivers/bcma/driver_mips.c
index 4f01e6b17bb9..9be0806eb033 100644
--- a/drivers/bcma/driver_mips.c
+++ b/drivers/bcma/driver_mips.c
@@ -46,12 +46,6 @@ static inline bool bcma_core_mips_bcm5357b0_quirk(struct bcma_device *dev)
 	       dev->id.id == BCMA_CORE_USB20_HOST;
 }
 
-static inline u32 mips_read32(struct bcma_drv_mips *mcore,
-			      u16 offset)
-{
-	return bcma_read32(mcore->core, offset);
-}
-
 static u32 bcma_core_mips_irqflag(struct bcma_device *dev)
 {
 	u32 flag;
-- 
2.27.0

