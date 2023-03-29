Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 710FA6CF6AD
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 01:04:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbjC2XEI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 19:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjC2XEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 19:04:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B946B4C08
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 16:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680130996;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=dvCH/Q/mYXYnFPxo1Zw9BF/bBxj1AhUZU0zHEiex0ss=;
        b=Wr3IdMz6tSMvRSu7pSwSrufMYDdosBkW3SAdTQk9oV7AXGN4dTwmAW2G08Chawc0dVoDrt
        74zLCMMTdfKauf4MIaYZgWzvcUh0ZVDL2/g8Rj/C2wVKkEpAwOeYphU7X0ypsrTRkRYCy4
        /jFiALCYcGF2TW9PiuDSQFW+C18sP2E=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-330-Puw5mImVMhCXeLOSg4HseQ-1; Wed, 29 Mar 2023 19:03:15 -0400
X-MC-Unique: Puw5mImVMhCXeLOSg4HseQ-1
Received: by mail-qv1-f71.google.com with SMTP id g14-20020ad457ae000000b005aab630eb8eso7408533qvx.13
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 16:03:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680130995;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dvCH/Q/mYXYnFPxo1Zw9BF/bBxj1AhUZU0zHEiex0ss=;
        b=5ugg/0EbsUyGPnKGP+Ymw2cuLaY0CwuDr+nPI2vjtPOt7BgeIARfhRY81z7Wmd50bA
         sqNaXDa3FJ4OJLMOfxLyjrL7b1x5UbCnyGpk2qKlaEdEzvFl3XKsZ4G46/LTcBjfUkRD
         t+Tm/LS9t6Zj7EyoEfiB/nWUPPssfvQv8QhBoCRhUgEqMU9uIAsGJVdn9zZcYudw4HPb
         OkFzlqfBoNhbmitYH7LgAcqBred0BgdqmzbYfF5xOUC6/PtEdKuejGaUmW2gWrys/hh8
         FqX3t/zmLUT4VSnSyEQQaNteT9qOnAvkK+YjHo9+f6e/5BhxgEo/aI5gOazFbG4iWS3c
         2XqQ==
X-Gm-Message-State: AO0yUKXz8VzVC7E2+c1AywRdMosr1MpBWzpTJqfn9JnT1fsHCxb0Itil
        MBOiXSS/v4IFOqGynBfGbdHviJlh98rWd3dFrAkmC6rH/Qya+/YVuxdHcR3LAOiVSvB4eQs/AQT
        Yu93gb2VSFwnHjMDKw02awSfX
X-Received: by 2002:ac8:5ad1:0:b0:3bd:140c:91f7 with SMTP id d17-20020ac85ad1000000b003bd140c91f7mr35157022qtd.40.1680130995201;
        Wed, 29 Mar 2023 16:03:15 -0700 (PDT)
X-Google-Smtp-Source: AKy350Z8o7ID5Y2qg2JO2AE3/F9MkoBdJxNI1wNK4jnkhkFlSdNW84WEhZHG+3IOdDu05fJRwkkzYw==
X-Received: by 2002:ac8:5ad1:0:b0:3bd:140c:91f7 with SMTP id d17-20020ac85ad1000000b003bd140c91f7mr35156994qtd.40.1680130994961;
        Wed, 29 Mar 2023 16:03:14 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id 12-20020a370b0c000000b0074680682acdsm14392346qkl.76.2023.03.29.16.03.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 16:03:14 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     hdegoede@redhat.com, nathan@kernel.org, ndesaulniers@google.com
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Tom Rix <trix@redhat.com>
Subject: [PATCH] fs: vboxsf: remove unused out_len variable
Date:   Wed, 29 Mar 2023 19:03:10 -0400
Message-Id: <20230329230310.1816101-1-trix@redhat.com>
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
fs/vboxsf/utils.c:442:9: error: variable
  'out_len' set but not used [-Werror,-Wunused-but-set-variable]
        size_t out_len;
               ^
This variable is not used so remove it.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 fs/vboxsf/utils.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fs/vboxsf/utils.c b/fs/vboxsf/utils.c
index dd0ae1188e87..ab0c9b01a0c2 100644
--- a/fs/vboxsf/utils.c
+++ b/fs/vboxsf/utils.c
@@ -439,7 +439,6 @@ int vboxsf_nlscpy(struct vboxsf_sbi *sbi, char *name, size_t name_bound_len,
 {
 	const char *in;
 	char *out;
-	size_t out_len;
 	size_t out_bound_len;
 	size_t in_bound_len;
 
@@ -447,7 +446,6 @@ int vboxsf_nlscpy(struct vboxsf_sbi *sbi, char *name, size_t name_bound_len,
 	in_bound_len = utf8_len;
 
 	out = name;
-	out_len = 0;
 	/* Reserve space for terminating 0 */
 	out_bound_len = name_bound_len - 1;
 
@@ -468,7 +466,6 @@ int vboxsf_nlscpy(struct vboxsf_sbi *sbi, char *name, size_t name_bound_len,
 
 		out += nb;
 		out_bound_len -= nb;
-		out_len += nb;
 	}
 
 	*out = 0;
-- 
2.27.0

