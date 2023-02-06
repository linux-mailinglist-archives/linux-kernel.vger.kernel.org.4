Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBDC968BA83
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 11:39:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbjBFKjo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 05:39:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbjBFKjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 05:39:40 -0500
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF161DBEA;
        Mon,  6 Feb 2023 02:39:08 -0800 (PST)
Received: by mail-ej1-x644.google.com with SMTP id lu11so32897963ejb.3;
        Mon, 06 Feb 2023 02:39:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xK/SoV6W+L9dwyyDpNjEuviI697WMNBbUvcumQmSRzo=;
        b=lHQH0PxHTLqrzoqYttIGLIbe6da/rgJog8MtswapCaoa0tjqEV77lQPQpGZK3ROX5U
         ZyaGdr6nf/I5ZXo5cVz7fXT3ONHVuMoKP9Noxbu4f1BhtqCunab/0E2hmji4rynw0uwT
         8mQA5UGEeC6Ag4a5w43+rOGsjePhoDB3FhS7YDcgKYmBf8DC2W/z0Sb9+M+MRMazEIGv
         jg9japbfF1nDjgCGG5UmvxELn9sjj24UFZodObGYxFE1v4dkXDowbaR2xHKM9GkcAyZn
         auW51zTelykon91Sex68dJ66zjFIozvr/I4XCJKcc9mypmx60UsXKxqYUu5mAFLCMVv8
         6qVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xK/SoV6W+L9dwyyDpNjEuviI697WMNBbUvcumQmSRzo=;
        b=iGlZCjqHR37lJ8SMPWVSmQyvWmxMLCWk9OYp9fygT0d/V7WdIdGs1jB4oBGEXB6MKG
         4ephwr/0K4bSaTnSagUT/x24Fe4P0TgX4oL0+mVLv3fq46tmirpsyX0hKJ1VJqhtWPmK
         4x0TFvTvFdPQ0plDMJQfkL+dRE1OUI8sZOomtbhzJMpyGV3S5PO407Gcq5r+Rf6oz9BL
         s17LHjza+83xYOQrmYh9X6raTo+wp92zhmXEd4kcKpNfeHhCWZ95oHVZMvrCRWJbiyL6
         gwA2cM28m+OneO3E7PsFRFIhRw4am9+vH2VDEy0GtyRzpTnFU6BXVr1qzvW1r4QlWjhE
         KgEw==
X-Gm-Message-State: AO0yUKXXb04VU/1RXGa5wG7MD4r5d27iTUbl4WapnukqgWwX56RcVdU7
        Lp5UhPe+qx540Pc/KUs6HDY=
X-Google-Smtp-Source: AK7set8PHFzniR3H0+5MkGkvu4JDYyxbxmaCnvaAaK3dlVpUFb9sEvDfxmIyE9VHYt5TFSVL6CjFOQ==
X-Received: by 2002:a17:906:5181:b0:878:79e6:4672 with SMTP id y1-20020a170906518100b0087879e64672mr20380001ejk.42.1675679948385;
        Mon, 06 Feb 2023 02:39:08 -0800 (PST)
Received: from [127.0.1.1] (i130160.upc-i.chello.nl. [62.195.130.160])
        by smtp.googlemail.com with ESMTPSA id p15-20020a1709060e8f00b0088bd01105eesm5283479ejf.188.2023.02.06.02.39.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 02:39:08 -0800 (PST)
From:   Jakob Koschel <jkl820.git@gmail.com>
Date:   Mon, 06 Feb 2023 11:39:02 +0100
Subject: [PATCH] x86/sgx: Avoid using iterator after loop in
 sgx_mmu_notifier_release()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230206-sgx-use-after-iter-v1-1-c09fb5300b5e@gmail.com>
X-B4-Tracking: v=1; b=H4sIAMXY4GMC/x2NwQrCQAxEf6XkbGC71lr8FfGQbrNtDq6SVCmU/
 rtZLwOPmcfsYKzCBrdmB+WvmLyKQ3tqIC1UZkaZnCGGeA4x9Gjzhh9jpLyyotTIl6FL7dR3abi
 CiyN5PyqVtFT1SearWryVs2z/t/vjOH7ef93DfQAAAA==
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Cc:     linux-sgx@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pietro Borrello <borrello@diag.uniroma1.it>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>, Jakob Koschel <jkl820.git@gmail.com>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1675679947; l=1863;
 i=jkl820.git@gmail.com; s=20230112; h=from:subject:message-id;
 bh=s5Z25nwMKZrnXgvpZBm/IP90o2y1bj8eWKKa4KOh3MA=;
 b=0S50NE1ixxa4ushMukAa9C7P25oFt05fKlJK7B1i/gbH5pmxkIS1yph56qxxQD1r4Qtt3lsGkt3c
 bgDDkaKyDK9vzzIkxC8YnIwtQ5gdWdYP865Cy/hIuzHWhn68H+m0
X-Developer-Key: i=jkl820.git@gmail.com; a=ed25519;
 pk=rcRpP90oZXet9udPj+2yOibfz31aYv8tpf0+ZYOQhyA=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If &encl_mm->encl->mm_list does not contain the searched 'encl_mm',
'tmp' will not point to a valid sgx_encl_mm struct.

Since the code within the guarded block is just called when the element
is found, it can simply be moved into the list iterator.
Within the list iterator 'tmp' is guaranteed to point to a valid
element.

Signed-off-by: Jakob Koschel <jkl820.git@gmail.com>
---
Linus proposed to avoid any use of the list iterator variable after the
loop, in the attempt to move the list iterator variable declaration into
the marcro to avoid any potential misuse after the loop.
Using it in a pointer comparision after the loop is undefined behavior
and should be omitted if possible [1].

Link: https://lore.kernel.org/all/CAHk-=wgRr_D8CB-D9Kg-c=EHreAsk5SqXPwr9Y7k9sA6cWXJ6w@mail.gmail.com/ [1]
---
 arch/x86/kernel/cpu/sgx/encl.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/cpu/sgx/encl.c b/arch/x86/kernel/cpu/sgx/encl.c
index 2a0e90fe2abc..db585b780141 100644
--- a/arch/x86/kernel/cpu/sgx/encl.c
+++ b/arch/x86/kernel/cpu/sgx/encl.c
@@ -764,15 +764,13 @@ static void sgx_mmu_notifier_release(struct mmu_notifier *mn,
 	list_for_each_entry(tmp, &encl_mm->encl->mm_list, list) {
 		if (tmp == encl_mm) {
 			list_del_rcu(&encl_mm->list);
-			break;
+			spin_unlock(&encl_mm->encl->mm_lock);
+			synchronize_srcu(&encl_mm->encl->srcu);
+			mmu_notifier_put(mn);
+			return;
 		}
 	}
 	spin_unlock(&encl_mm->encl->mm_lock);
-
-	if (tmp == encl_mm) {
-		synchronize_srcu(&encl_mm->encl->srcu);
-		mmu_notifier_put(mn);
-	}
 }
 
 static void sgx_mmu_notifier_free(struct mmu_notifier *mn)

---
base-commit: d2d11f342b179f1894a901f143ec7c008caba43e
change-id: 20230206-sgx-use-after-iter-f584c1d64c87

Best regards,
-- 
Jakob Koschel <jkl820.git@gmail.com>

