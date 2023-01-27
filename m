Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14AE467F13C
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 23:38:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231849AbjA0Wi0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 17:38:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbjA0WiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 17:38:21 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B28C8199C1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 14:38:19 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id b24-20020a17090a551800b0022beefa7a23so10010992pji.5
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 14:38:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=v8KUQGK7MJtzuKGRGDT0BQ6/1Z8fLbRNluB/Og9OPvw=;
        b=WsypvYtPfkPUjon6FlpkUez3/t7ERj4dR0qDWPjh+OxIGuPsOyODltDLvl0hNi7yh1
         tHX6ZBa0vmEm4pZWaWnzIZjhhg6LXLlxX50zsD6n+XwFWKUcfNswh/fCwQb1uHo5ciew
         X8yz53VEK25sNyYArevRoax9uOlgS2FUp6sok=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v8KUQGK7MJtzuKGRGDT0BQ6/1Z8fLbRNluB/Og9OPvw=;
        b=a80448iapOBbAjS6szBVibRHYdTeNW5l5wLSzKn+LnNbD6Zb0j1rU4R4AANeNda/xI
         TZLVt0D1vDNT89dgmLPZsdkMSQO4cOEgRdabsTzIk14MvcbSzGy2JKkhK6/4iqBeC09E
         Y5X3/s/vc4mB9xs1FqGDVei2k2VJxZYzohYCjfvdPMp8kBGUiiPP2pJskjQiY7LnsLzq
         cnUBAeeZPP3NpEVsAQ/cWGlZgN8NoJt0yxXFpnvwcW//DXSyhg16ZjgSVmllG+FPrzK3
         dJjmTjmh0QPUZWZmkvzDS0t3jANrd0a4mGf1oHlKTrAp+V1xvTtiKfMOWv9EMo5Zpgw0
         Fkqw==
X-Gm-Message-State: AO0yUKVqdxOQKCvfyFOMgxkZwoJ2YKzX2XajbNDMFe369f9OTFW7ifkB
        GSUxIW+jwGO8tB7UD0D8/R4Nbg==
X-Google-Smtp-Source: AK7set8ZJl02n6oFmIl8pxXtG1MZuC84fRHK08N8jgqRjWLycq2flaq6sz5rhHHqCU8FgQIcPFB0Rw==
X-Received: by 2002:a17:90b:4d04:b0:22c:f74:9417 with SMTP id mw4-20020a17090b4d0400b0022c0f749417mr10949646pjb.32.1674859099176;
        Fri, 27 Jan 2023 14:38:19 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id n19-20020a637213000000b0044ed37dbca8sm2869837pgc.2.2023.01.27.14.38.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 14:38:18 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Kees Cook <keescook@chromium.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH] iommufd: Add top-level bounds check on kernel buffer size
Date:   Fri, 27 Jan 2023 14:38:17 -0800
Message-Id: <20230127223816.never.413-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2558; h=from:subject:message-id; bh=DvvDSCPrtiZf/vMBP8xmsL1zlu6L3aeqhNadd+7X3/I=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBj1FJYszVzg798jHCOXWzXgYux6qhv5/f16dGlhaEB rqrNfm+JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY9RSWAAKCRCJcvTf3G3AJrDmEA CbYqX7OsaxA+dCd3NJ1XX0DkPmMT3rasLziMOqYGfiyPrkphRzxwJpqE4RmVRUGLh/l/rq0IDEqN9q CU/+3WbpR1gnnAkU9S999jWfdgFMwDeU9faCxzWGfOURx4qmzdeChhirJ4tCIOjWaBWkaplF0dBFHn XNei+7Dm2NhtUTEPrCGw8ksJ4LV5vw11l5N5GQ+7nCTPz3bKjFxDUsujvoSTezYtRJ0d5EEP1qEirN kPvVp/L5Gj9nWjiXu1IuK8ccZZsL6sVIqPJHGleRSazpuHs2A1oNOAybyglMN0c3szknlqtSsiTrmK Tn3h+0a/eXCyAZMmnUD9si1ShI4cDVscNZJPARDGWPPVFpltHPr2ujsLrdttQM8TuXYiuQGXP1HhIB LB+eJU7qzVovH7LmgDgRT+pCLKL7CTh1DdyKqZWIFMZ5OdU7o+5EDsKNuWiTvFfdHvo5vbEzS8TCvc ud8D62925NjOCzjA/HwBKDgSTR8EZQGgcFH7BhUIPeBoc0LfgzFzNKdhK6e/KeHwM/UAOd3L0aYwCt A1f/DHjI6mRQu7J8WuOEUYwU2ByNFDvzKsVOrUYwoYM9HLozJt5774fE2XaNcoVbnOB+F6CERVXHby UhmpHr10nXfMTJo+08gdjgW0TUTMQ4bh3JBFaDYxLb4DdWtEBD9ii+7MxrGA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While the op->size assignments are already bounds-checked at static
initializer time, these limits aren't aggregated and tracked when doing
later variable range checking under -Warray-bounds. Help the compiler
see that we know what we're talking about, and we'll never ask to
write more that sizeof(ucmd.cmd) bytes during the memset() inside
copy_struct_from_user(). Seen under GCC 13:

In function 'copy_struct_from_user',
    inlined from 'iommufd_fops_ioctl' at ../drivers/iommu/iommufd/main.c:333:8:
../include/linux/fortify-string.h:59:33: warning: '__builtin_memset' offset [57, 4294967294] is out of the bounds [0, 56] of object 'buf' with type 'union ucmd_buffer' [-Warray-bounds=]
   59 | #define __underlying_memset     __builtin_memset
      |                                 ^
../include/linux/fortify-string.h:453:9: note: in expansion of macro '__underlying_memset'
  453 |         __underlying_memset(p, c, __fortify_size); \
      |         ^~~~~~~~~~~~~~~~~~~
../include/linux/fortify-string.h:461:25: note: in expansion of macro '__fortify_memset_chk'
  461 | #define memset(p, c, s) __fortify_memset_chk(p, c, s, \
      |                         ^~~~~~~~~~~~~~~~~~~~
../include/linux/uaccess.h:334:17: note: in expansion of macro 'memset'
  334 |                 memset(dst + size, 0, rest);
      |                 ^~~~~~
../drivers/iommu/iommufd/main.c: In function 'iommufd_fops_ioctl':
../drivers/iommu/iommufd/main.c:311:27: note: 'buf' declared here
  311 |         union ucmd_buffer buf;
      |                           ^~~

Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Kevin Tian <kevin.tian@intel.com>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: iommu@lists.linux.dev
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/iommu/iommufd/main.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index 3fbe636c3d8a..34a1785da33a 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -330,8 +330,9 @@ static long iommufd_fops_ioctl(struct file *filp, unsigned int cmd,
 		return -EINVAL;
 
 	ucmd.cmd = &buf;
-	ret = copy_struct_from_user(ucmd.cmd, op->size, ucmd.ubuffer,
-				    ucmd.user_size);
+	ret = copy_struct_from_user(ucmd.cmd,
+				    min_t(size_t, op->size, sizeof(ucmd.cmd)),
+				    ucmd.ubuffer, ucmd.user_size);
 	if (ret)
 		return ret;
 	ret = op->execute(&ucmd);
-- 
2.34.1

