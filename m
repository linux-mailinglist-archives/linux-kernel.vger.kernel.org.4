Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88C806C4EB5
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 15:58:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231552AbjCVO6Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 10:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231500AbjCVO57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 10:57:59 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0777B22C91
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 07:57:16 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id r11so74147561edd.5
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 07:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1679497032;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cGYOqDadhmsseDC0wX50qpITbuUEp1N4J0vaATobCLA=;
        b=G/l1XPwfAmpfc0zYBfc2PYxi5tOYq6n46qHEAus+GTjiRtmsEdqv+dK/6PcCUBJDLJ
         hbip3YmDaE6mXLNsGjTYq8q0g4yXh6gfNTKraQqo92KDvpsNQ4kFc6ZqLH8ExhcBRiCZ
         dYdho9HU6l7AMN+yE/wqmxMkeT6ZH0nDPozDc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679497032;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cGYOqDadhmsseDC0wX50qpITbuUEp1N4J0vaATobCLA=;
        b=KXtDGIcN9DH9qk4JtANW7p8RItQezXXqKPxxK1DseTeUYmXpiipyTXfGSnNZ7kD3zp
         IOC6wciJGDYxE+w2Zvdic69rHal2HUZZXPIJqACLPJcCGyKGESkqmQMAyDOGAKR4f4V4
         A+rhkr56mnwEPdW/mKg8GsYbKaV4+JvwuVOwWMCzv5trlQSWB0UhmquakY4fR6CzotM4
         BtUEcWSVHmQr6T6YPIatQ0yOX+G5EAEDs2s7riNREgmcUmX18klYK+Ds/gOIbQjLkuMZ
         QHrDl0H9jtbTFDhocJMr59NYfohFdDFMq93UPdY6eH4K4y4jIM6XBWq2sHejN9QZdM59
         fMPQ==
X-Gm-Message-State: AO0yUKUpFR73owBw/5mrALzPEuSIbhE34DVnLRZfxOuMGuwtUYB403zG
        0R22c4qsDbMUqgLxoa26126dFtIYyD0g825IVqqOww==
X-Google-Smtp-Source: AK7set+PXmlCPVawaFWyPYo9kOHc3dNlpQMXGtbT4rULP0P5Nfil6epT/P9Ft0E42xmHrAYBEhv8Dw==
X-Received: by 2002:a05:6402:44f:b0:500:4062:99f7 with SMTP id p15-20020a056402044f00b00500406299f7mr7464988edw.32.1679497032667;
        Wed, 22 Mar 2023 07:57:12 -0700 (PDT)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:5f6a:82a1:e22a:94f1])
        by smtp.gmail.com with ESMTPSA id q30-20020a50aa9e000000b004fadc041e13sm7886755edc.42.2023.03.22.07.57.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 07:57:12 -0700 (PDT)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Wed, 22 Mar 2023 15:57:03 +0100
Subject: [PATCH v2] kexec: Support purgatories with .text.hot sections
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230321-kexec_clang16-v2-0-d10e5d517869@chromium.org>
To:     Eric Biederman <ebiederm@xmission.com>
Cc:     Philipp Rudo <prudo@redhat.com>,
        Ricardo Ribalda <ribalda@chromium.org>,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        Baoquan He <bhe@redhat.com>
X-Mailer: b4 0.11.0-dev-696ae
X-Developer-Signature: v=1; a=openpgp-sha256; l=2892; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=fnrLcVQ1AvJdACOA7Q5fvzBkJ12XpQAOmvFAOWWoit0=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBkGxdB8KVcnWWA0yHB3Vo3OsDbKZYjZaWTwqtOoMlg
 u9oJd/qJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCZBsXQQAKCRDRN9E+zzrEiIBjD/
 9s92XhCh2L80pc0Mj6fm7p1vIC6K/nmBsfzkvlM1sLeSbHf6NuQdLPHn0QZS83rBYVMX/V2WZSm4dx
 C/ApyOM7ltyd5Ltr8memqr6SrP7mSl+1U9Yw5ZaSQqAY6NZGoZ/6aDFTCbaDbTAScnRgtDXz6hHLJ2
 GE5x2lu5RTyU5a5NekCilvoypGfFwHaLINDfSArgI9q+oP2f4bhd4BBNLfzBpv857Mo2gqjKhm+9xt
 E2Y0zYMbjGFclSXk0w7dsTd3AMQQ6tEMmhvdxLDjnpVE02PJpV9VZ/ElQmINt+YECOgrfZM9ayN/8H
 XVx+zquSCdZ1pp1CitBwxUnswJePK6x5ik2f1iGh5A5TPsB6fobSOt+iSroM5vV/OEtKGzXaeuQA2D
 MlSb3O47DiFgmMKyQyYZoGQvIKTKm0//y0qrirUsRi4BGEsaBmD65AdqopChGDQ7KSmpw8nJG99ozV
 Js1gHNTg+Ne/fJXZ+qoW8jENnFTrS6j2nw2EY7B1H4Zzntgi6ouQszaroQgUqvsaEBHsqaR/ZS2cKF
 Q68UkswH88KBtsodAJJFm9VGDkptYxpfCfJbvegERNNjUjHrq7xaqqdbLomI4cw4z7lhrwwu4q7LwT
 VoxGrrwqZFaBbys112SnZ6veat7mpQwzQEq5MH0anO3PjCV4S9huvjImJs0g==
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
Changes in v2:
- Fix if condition. Thanks Steven!.
- Update Philipp email. Thanks Baoquan.
- Link to v1: https://lore.kernel.org/r/20230321-kexec_clang16-v1-0-a768fc2c7c4d@chromium.org
---
 kernel/kexec_file.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index f1a0e4e3fb5c..975f2e969a45 100644
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
+		    kbuf->image->start == pi->ehdr->e_shnum) {
 			kbuf->image->start -= sechdrs[i].sh_addr;
 			kbuf->image->start += kbuf->mem + offset;
 		}

---
base-commit: 17214b70a159c6547df9ae204a6275d983146f6b
change-id: 20230321-kexec_clang16-4510c23d129c

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>
