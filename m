Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A5A7700F6A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 21:43:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238294AbjELTnR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 15:43:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238429AbjELTnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 15:43:13 -0400
Received: from mail-vk1-xa4a.google.com (mail-vk1-xa4a.google.com [IPv6:2607:f8b0:4864:20::a4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40648D06E
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 12:43:05 -0700 (PDT)
Received: by mail-vk1-xa4a.google.com with SMTP id 71dfb90a1353d-44fb0ee32e3so2209044e0c.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 12:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683920584; x=1686512584;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YLH/bA+yhFKgRgD/PfBdmu3fiVXAEJ3yCxJiyJbAdz8=;
        b=HRpWvZHQhiD+sYYJ1K5rzdIiHd2Yle38oUBMZ4BHlDYoUtRsa69jA3USb7nZfgfV0S
         ydMxAtyjb7m5VN0Me0ArhPOxPrj0OAdH+fKA2gzeqKYjNy3drxmeSCOkRcU9iuM8eowx
         zS6DnMSxPBzwV/p8TnfWcrKVEKgst0vYDIi7OpdhVXkTs7dnPcGR6LYQiCDCObrVOXHC
         gpMAPBDWA0iMTdQxU4WDcIhbqmNSKwCTH0+5e5MJSK+4ek5ubEclbuzPb3Gc0RLJGRs5
         cRPG9cbKwMtOzyM5lV3j6NxYp08suB9JAAe69YHwa5E3NQni/K63Z/1h+9kn3HrsVLz4
         aYtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683920584; x=1686512584;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YLH/bA+yhFKgRgD/PfBdmu3fiVXAEJ3yCxJiyJbAdz8=;
        b=lYV48KjUkghjNnbmd1WFhoOW52hmPiZFSxObLL0DLihsb9SAAKloRq7BET2BQmv9Wl
         YufB62ORWL387PPKEug39ekkXI1y2HCdrkxiwFj12ijdouBRLG/ifdgWedaI6Pzv6KM8
         /CY/tC/gZHFi/MFIehAYTM04XZYa1cTyHx/SyKpaDbwc7WAilkCN1yaAdnSP5Uhbdtvf
         OOTFfWRV6z7znRSPpewkpcudhoex0XpkpLmJs6TyN4YWd2Ugm6pKf0Mg6BVQmTv4G/bU
         zcojC3H6pOp+z6cOoKPeiIUqLBLZTQwTHK9hWhF3YsWUfXTrHw9/HjGA8evGiyf7kD4Y
         lYnw==
X-Gm-Message-State: AC+VfDyNI32pd3eSWkMCwZ9jJg+bhLazN0WNIRk6baBKivgr/PhvrDLe
        FOrEfKwDkR87+NueJLawwZnncGk1K+t3MtZXrecRNQ==
X-Google-Smtp-Source: ACHHUZ7Fp1jAB8Erug5aU4TplWPM/WGhwnxeGeFU3SLJ9CkdxMdKQyNgUktT6VvojByoMdCi8ac8BldwJdkfp/D91LWepA==
X-Received: from admirable.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2888])
 (user=nicholasbishop job=sendgmr) by 2002:a1f:ac8d:0:b0:453:eb8:5fef with
 SMTP id v135-20020a1fac8d000000b004530eb85fefmr7913684vke.2.1683920584402;
 Fri, 12 May 2023 12:43:04 -0700 (PDT)
Date:   Fri, 12 May 2023 19:43:02 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
Message-ID: <20230512194302.1662230-1-nicholasbishop@google.com>
Subject: [PATCH] efi/esrt: Allow ESRT access without CAP_SYS_ADMIN
From:   Nicholas Bishop <nicholasbishop@google.com>
To:     Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Peter Jones <pjones@redhat.com>,
        Nicholas Bishop <nicholasbishop@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Access to the files in /sys/firmware/efi/esrt has been restricted to
CAP_SYS_ADMIN since support for ESRT was added, but this seems overly
restrictive given that the files are read-only and just provide
information about UEFI firmware updates.

Remove the CAP_SYS_ADMIN restriction so that a non-root process can read
the files, provided a suitably-privileged process changes the file
ownership first. The files are still read-only and still owned by root by
default.

Signed-off-by: Nicholas Bishop <nicholasbishop@google.com>
---
 drivers/firmware/efi/esrt.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/firmware/efi/esrt.c b/drivers/firmware/efi/esrt.c
index d5915272141f..aab96ab64a1a 100644
--- a/drivers/firmware/efi/esrt.c
+++ b/drivers/firmware/efi/esrt.c
@@ -95,10 +95,6 @@ static ssize_t esre_attr_show(struct kobject *kobj,
 	struct esre_entry *entry = to_entry(kobj);
 	struct esre_attribute *attr = to_attr(_attr);
 
-	/* Don't tell normal users what firmware versions we've got... */
-	if (!capable(CAP_SYS_ADMIN))
-		return -EACCES;
-
 	return attr->show(entry, buf);
 }
 
-- 
2.40.1.606.ga4b1b128d6-goog

