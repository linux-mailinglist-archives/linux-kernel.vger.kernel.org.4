Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C749D6C30CE
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 12:49:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbjCULtu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 07:49:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230381AbjCULto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 07:49:44 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB106DBC0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 04:49:31 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id t5so21684666edd.7
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 04:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1679399370;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wfc/MKwL6R69K5wz8AOeHXnxOrck8uBBMJXOwwRZiMA=;
        b=hqeF1dzvKFnVOu3pPvTcvVWaYPURtGrMkJs+VoOA7NeCEwSjuKUV4S9Jgi41+DRCVT
         nDgoCi9okHijFcq+EEepOhHzvQxsO7NU/XnDFGwfu0Wj1Fs7dwZ2x6mIZfve0hZWYCw4
         bhO2WkmO1otQ9wjov9G0w3pX3Sa/qRbQ7FEnY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679399370;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wfc/MKwL6R69K5wz8AOeHXnxOrck8uBBMJXOwwRZiMA=;
        b=LTmeuYMlK6Nfl2yoXFk2vuYpbAP496+ZkuqLchJ1VafRw64Rh7xbZlAiJ5KzUkNnag
         oO7f7SLYL42GnjW9L3Cp35SPpYciPIE8Vp7fJOfMlbY3FXj5iPeIpXuaCG9e7NT5PzSQ
         YAOIJX6oeTBgoWX30Z7zj4wg7WFPm0UruNmCATHlzJY6z+22zBmbHK+Qb/Armdg+2iO+
         FX5cOhdYXhGq8RLDi/AD7JOUBXgMhd6DK9BGP3AA4W/YRltYZWATxoUQR86Ya/G+KQia
         aUH4HRwb7XQdKmR1q/11Pcf3Nm5vtTjI25qtU6c4bD8GEBJDXuRfaDVnf/z7t6UUy3Zc
         BlSQ==
X-Gm-Message-State: AO0yUKW3rsjmdxFDU7rnS7d7KxZKu4AoW44waEfBv8QeNJq5jeCs7a8M
        OeUsxf+tilTJccI+gDQPS0+9Nw==
X-Google-Smtp-Source: AK7set8u3SsBgOKZqdfTvYLQwQbmLrg1oqykUrZtwCjyDwbRSr6v7ivv37R8vy3Jy+L4xYW1jqPiOg==
X-Received: by 2002:a17:906:f8c2:b0:930:3916:df17 with SMTP id lh2-20020a170906f8c200b009303916df17mr2808888ejb.0.1679399370203;
        Tue, 21 Mar 2023 04:49:30 -0700 (PDT)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:1066:a3f0:9dfa:4604])
        by smtp.gmail.com with ESMTPSA id gv27-20020a1709072bdb00b008b9b4ab6ad1sm5682835ejc.102.2023.03.21.04.49.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 04:49:29 -0700 (PDT)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Tue, 21 Mar 2023 12:49:08 +0100
Subject: [PATCH] kexec: Support purgatories with .text.hot sections
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230321-kexec_clang16-v1-0-a768fc2c7c4d@chromium.org>
To:     Eric Biederman <ebiederm@xmission.com>
Cc:     Philipp Rudo <prudo@linux.vnet.ibm.com>,
        Ricardo Ribalda <ribalda@chromium.org>,
        linux-kernel@vger.kernel.org, kexec@lists.infradead.org
X-Mailer: b4 0.11.0-dev-696ae
X-Developer-Signature: v=1; a=openpgp-sha256; l=3075; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=L5iy/RBbUSnp18lqg34HLuwN0ZubleWR8YgXa0JvyoY=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBkGZnBY8DH4DLVJKyCFvKrPsDgIulVhZBdn63lYLCA
 ZGHPU66JAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCZBmZwQAKCRDRN9E+zzrEiH89D/
 0SBPLgBlsByQkpnKEHmdb/+FGZhQdP8pzvqICJzE5FSm5AbLQkkBGsbsn/OCJbxZgz48M/nyXISz3P
 eqo5os9lgQJrZR0402pKlYMaY6WxbToVesC2SjKKFC15bESzf60lL8KNnIxhwsFDwiCRv1sgCn2jgl
 HOsT2/RIIOAQ6fdKoWAzZ0m/UOt9gPfjQqh9jce4oW2tYQ/gKHvJohcczJIxQn8d14eYGZWbQOdxjO
 pWTSz9JlQssUwykW3m30ZAFZ3eDmFpUldV1fIDfDE9ADDymeAzIXKF7mjbzqhWEJW6S8/g26MQCq1n
 Xx+4+n1m84Pj9iSIoBRDQ5tNGJSpvCXJ3Xdp3WrSaun9eSFKOuv2skMZP8tDvh5D+/yNzcYLMPgHD9
 yYV9j6R3tGc2oV3CWBrkmzzU4ZtzZLJFJpP60Rck+Vl/FPQ/qmd67OD4qzOnlNrSSuo3c9LxAu5Jcy
 hlSyzOkrtRhfsAfU4hjQDEl2IxXvvcz87J6R+BKUjPBf5xAor3aIiYDGrplVGgtVddCOZOJQpAiPQc
 MajN346hQO3biY2LLKWtL7nVDwV9iOaMpe0grfmV7vL+o5kLxqyHsMHQyzz4bb97FyDoKYalaHiyao
 gNd6rdc0NCUTUV2g5xsUXHYK/axh475DE/LsZNhecsEeGSUaL6C4di6XPw7g==
X-Developer-Key: i=ribalda@chromium.org; a=openpgp;
 fpr=9EC3BB66E2FC129A6F90B39556A0D81F9F782DA9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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
kexec: Support purgatories with .text.hot sections

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

To: Eric Biederman <ebiederm@xmission.com>
Cc: Philipp Rudo <prudo@linux.vnet.ibm.com>
Cc: kexec@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
 kernel/kexec_file.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index f1a0e4e3fb5c..b1a25d97d5e2 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -904,7 +904,8 @@ static int kexec_purgatory_setup_sechdrs(struct purgatory_info *pi,
 		if (sechdrs[i].sh_flags & SHF_EXECINSTR &&
 		    pi->ehdr->e_entry >= sechdrs[i].sh_addr &&
 		    pi->ehdr->e_entry < (sechdrs[i].sh_addr
-					 + sechdrs[i].sh_size)) {
+					 + sechdrs[i].sh_size) &&
+		    kbuf->image->start != pi->ehdr->e_shnum) {
 			kbuf->image->start -= sechdrs[i].sh_addr;
 			kbuf->image->start += kbuf->mem + offset;
 		}

---
base-commit: 17214b70a159c6547df9ae204a6275d983146f6b
change-id: 20230321-kexec_clang16-4510c23d129c

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>
