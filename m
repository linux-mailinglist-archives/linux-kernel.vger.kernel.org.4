Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D65E6C5489
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 20:09:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbjCVTJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 15:09:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230059AbjCVTJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 15:09:36 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33967574C9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 12:09:35 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id h8so77130131ede.8
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 12:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1679512173;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+ySahdxE1L4cd6ksj325R5E2NVmNvOBKF2RFZh+Bg40=;
        b=UPWEMq3NxXxzE8Wiu8abtvsUinCwPFZ8H9FO2g/NFY4fziUMumJC6irIJ6dv69ZpTQ
         n21XNFACcI9NsGiNHUOVoAwAE2Fee/eo+JtPd9gQfHg4dOwJC75vcH4W7wbd8iWEA9qK
         XqW4gf0zm/PELPGeYyejrX2CHeGxrVAhvfSjQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679512173;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+ySahdxE1L4cd6ksj325R5E2NVmNvOBKF2RFZh+Bg40=;
        b=q7Er9q4XqpoQNSumbHkqNwHBxFLcDTQuxyJh8gJbvyITXNFwptpA7eaTuzrif13dSq
         tMXMO3A5DXlapVPNEkJv8uHhORtGSCXMBglOwAgZUEZJJ9O3B9Iry7+zSu/qaGi95Y9n
         PO7Ap8sk/i/HIlhgFSduw0I3VcDeQsItSaKU9XpV45IXsiH92WD6Ca18pZy4gWOgZJ4z
         UiV+b7PrUOd9jX7b4N2Y3UB5NKbARyDpphGamY56NLnrYeTEjC4WKLiVJw+CvHTbkc5y
         SlNunU/s0GodrG4rF/PConKqRBEH+Jl1Im4Xppy+1ODVXf5nBUv+8aUjEA4/114ANm8n
         LIlQ==
X-Gm-Message-State: AO0yUKUqQew9OcrxlGpY6qAtZqo1lp582SvVhAQhl4y7gsKwMgmecKdS
        gcCscKYInV6b3jhnZHxMO3rAzSfmXLXse4oeiTqhIw==
X-Google-Smtp-Source: AK7set9bWzvTBQfp8o8NZCDk6+QW+Q+iaLsHjRinXNgkwF5mMn25Kdc/k/pwNG7wlQ43npIAUmacDw==
X-Received: by 2002:a17:906:7e55:b0:932:cfbc:7613 with SMTP id z21-20020a1709067e5500b00932cfbc7613mr7814672ejr.24.1679512173566;
        Wed, 22 Mar 2023 12:09:33 -0700 (PDT)
Received: from alco.roam.corp.google.com (80.71.134.83.ipv4.parknet.dk. [80.71.134.83])
        by smtp.gmail.com with ESMTPSA id k24-20020a50ce58000000b004fc9e462743sm8129130edj.91.2023.03.22.12.09.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 12:09:33 -0700 (PDT)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Wed, 22 Mar 2023 20:09:21 +0100
Subject: [PATCH v3] kexec: Support purgatories with .text.hot sections
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230321-kexec_clang16-v3-0-5f016c8d0e87@chromium.org>
To:     Eric Biederman <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org, Philipp Rudo <prudo@redhat.com>,
        kexec@lists.infradead.org, Baoquan He <bhe@redhat.com>,
        Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.11.0-dev-696ae
X-Developer-Signature: v=1; a=openpgp-sha256; l=3040; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=zeD7U+0v4JMLtkU5q8C0r0fzM4KdEhcMV9PmfyzIKU0=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBkG1JkKRERoHv42QrNtVkqYPkq552VERdk/QnsxyEi
 q0BT2CmJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCZBtSZAAKCRDRN9E+zzrEiN88D/
 4us5k4JkfH+locFVVMElk6flGVX8JQm9dVqN442H5ATser3crdr0Ar8pPlcgcJVHtwby3G+qLJksSm
 loLsjZoLDrQgTJDJIQJDWmrj1fLTE3IranBC1bgZ4FyFir/I4yhSpiDIONnctM8nNAFZ24rLYABGmv
 2VqJU7zbiPbg765ixmxCilQptemctcAL2K4wb1nEPVZhiRWCCRVe6GbYOnOOZzY/PmG0MrdQp/aAhj
 nghVQ51CpAUd+TvUgbFOBhBfNwVsX6+ujowsxQNl9oXGdkjdbiu4/uV5oWvFfx3VJjsebs1uOFn54Y
 M/PhxTrEBH3+pKBmtWc2n1pPzcIPU5cLt9j41IJSk39sCdZ7oM9G24801egJoqBL/el62Oaa9wqFCW
 BRwp09+2qsTGQIJvdGHKuHEOsbjgm0WfUtuxM2kpazmAAx4xXOMImQkGvbpPrdD8zRqNz1JEPs+Kcp
 kfcmq1tbJhIayWISo6eKAd74xIl2RrGobQo7zGPbcNqFL9QvaJU4mMTv4q4l50xxPyiqAnDYKfXT/p
 494vBT80CbrGQqWqWiKjf+sDRSd8Df+KY0qkXOf3mh9ycDvfnSZPEOuKa5rO6jSglNHRVY8Qr0WdHl
 79mYgpPR8TRXNH6RHduqRtZaSBJ5syOlt/y6SVivwFK2YWchFDGjZrxBMxMQ==
X-Developer-Key: i=ribalda@chromium.org; a=openpgp;
 fpr=9EC3BB66E2FC129A6F90B39556A0D81F9F782DA9
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang16 links the purgatory text in two sections:

  [ 1] .text             PROGBITS         0000000000000000  00000040
       00000000000011a1  0000000000000000  AX       0     0     16
  [ 2] .rela.text        RELA             0000000000000000  00003498
       0000000000000648  0000000000000018   I      24     1     8
  ...
  [17] .text.hot.        PROGBITS         0000000000000000  00003220
       000000000000020b  0000000000000000  AX       0     0     1
  [18] .rela.text.hot.   RELA             0000000000000000  00004428
       0000000000000078  0000000000000018   I      24    17     8

And both of them have their range [sh_addr ... sh_addr+sh_size] on the
area pointed by `e_entry`.

This causes that image->start is calculated twice, once for .text and
another time for .text.hot. The second calculation leaves image->start
in a random location.

Because of this, the system crashes inmediatly after:

kexec_core: Starting new kernel

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
kexec: Fix kexec_file_load for llvm16

When upreving llvm I realised that kexec stopped working on my test
platform. This patch fixes it.

To: Eric Biederman <ebiederm@xmission.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: Philipp Rudo <prudo@redhat.com>
Cc: kexec@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
Changes in v3:
- Fix initial value. Thanks Ross!
- Link to v2: https://lore.kernel.org/r/20230321-kexec_clang16-v2-0-d10e5d517869@chromium.org

Changes in v2:
- Fix if condition. Thanks Steven!.
- Update Philipp email. Thanks Baoquan.
- Link to v1: https://lore.kernel.org/r/20230321-kexec_clang16-v1-0-a768fc2c7c4d@chromium.org
---
 kernel/kexec_file.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index f1a0e4e3fb5c..25a37d8f113a 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -901,10 +901,21 @@ static int kexec_purgatory_setup_sechdrs(struct purgatory_info *pi,
 		}
 
 		offset = ALIGN(offset, align);
+
+		/*
+		 * Check if the segment contains the entry point, if so,
+		 * calculate the value of image->start based on it.
+		 * If the compiler has produced more than one .text sections
+		 * (Eg: .text.hot), they are generally after the main .text
+		 * section, and they shall not be used to calculate
+		 * image->start. So do not re-calculate image->start if it
+		 * is not set to the initial value.
+		 */
 		if (sechdrs[i].sh_flags & SHF_EXECINSTR &&
 		    pi->ehdr->e_entry >= sechdrs[i].sh_addr &&
 		    pi->ehdr->e_entry < (sechdrs[i].sh_addr
-					 + sechdrs[i].sh_size)) {
+					 + sechdrs[i].sh_size) &&
+		    kbuf->image->start == pi->ehdr->e_entry) {
 			kbuf->image->start -= sechdrs[i].sh_addr;
 			kbuf->image->start += kbuf->mem + offset;
 		}

---
base-commit: 17214b70a159c6547df9ae204a6275d983146f6b
change-id: 20230321-kexec_clang16-4510c23d129c

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>
