Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B58C16A6B8F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 12:18:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbjCALSG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 06:18:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbjCALSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 06:18:04 -0500
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E417C83E6;
        Wed,  1 Mar 2023 03:18:02 -0800 (PST)
Received: by mail-ed1-x542.google.com with SMTP id o15so49812253edr.13;
        Wed, 01 Mar 2023 03:18:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7bykwTXYPplq261L/H6aPpi/wwZYBxJRVPWWi2MZN8k=;
        b=Gm8GR+l2oO22LTxUJa9XScUt3gNJjCFwMuuFgBUS8i1chHaDGtuek7VBcAA1EmtvHl
         WPmgY7W2gINf1tHPjaa4oQeAaZTS3aCZnjl/eUSZ84ECEZHUnOfQaYSkKkUIeMX0Tgyw
         Ly6OpSAk7PsmHID9B2VNL1NXEQVxHHK0j4khQXYSxqmifFF3IuhqO6/YV7xXYURAYNEA
         487THAfbLg6nYdrpklNLcna095FXlDvjHW6vy8k6aRVfiq40C+SmNibY3/KyinGpViCn
         vl+yHbP9ObzbEQeFJJPbrq0wjrsXpH5dCsRoc5qHSnmT7wZR9Ok9tg0Ta+x8InRjttQh
         GjZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7bykwTXYPplq261L/H6aPpi/wwZYBxJRVPWWi2MZN8k=;
        b=7UpA56gbhcWYzNY8ndjbcdx0zqTZDFQRG7BSFTKba01gMBty/a+IrPlW2c31NPcMtS
         bv6Shtj8mwjmFWd/4cdhG1XTu0aER7lvAQr33RrhXZz5bXOF4yHXGj0hEktOTXQjxA1b
         Tbr2rC6pzWHIPRb9SnVQtHJbLCMCo147NIU0pWgzaEDr+wuvwtsLE5AUvzR/XnpUcNXm
         /IkHFNRVvWul0ImS4p+eCgIzvEsZRWUJwrfa2U8IzYIoEIek4NcNW9QE5vvzi+xfeEiu
         pDe5jxwuRVHj9ecEiwixfb0dnqsy3hTX6J9JblcZwuiqVCRv1FKJrdY47KcZP4r2CcJ+
         31ig==
X-Gm-Message-State: AO0yUKVwvXZ6LGRO5z0ozn1b4yTnfCnDB4IujceH4UzgsBmhIWXivHdC
        LGr6aJ892F/F7G8/amq9934=
X-Google-Smtp-Source: AK7set8hPI+CG9fA3YEX+/Mt+S1VXGnOp5xjyHeYKEGDrRSFANGv6gt3FizhfFrL6lWm5OU7QW5Vxg==
X-Received: by 2002:a50:e707:0:b0:4ac:be83:2044 with SMTP id a7-20020a50e707000000b004acbe832044mr5842771edn.3.1677669480766;
        Wed, 01 Mar 2023 03:18:00 -0800 (PST)
Received: from [127.0.1.1] (i130160.upc-i.chello.nl. [62.195.130.160])
        by smtp.googlemail.com with ESMTPSA id f23-20020a170906085700b008e51a1fd7bfsm5721268ejd.172.2023.03.01.03.18.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Mar 2023 03:18:00 -0800 (PST)
From:   Jakob Koschel <jkl820.git@gmail.com>
Date:   Wed, 01 Mar 2023 12:17:29 +0100
Subject: [PATCH v2] x86/sgx: Avoid using iterator after loop in
 sgx_mmu_notifier_release()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230206-sgx-use-after-iter-v2-1-736ca621adc3@gmail.com>
X-B4-Tracking: v=1; b=H4sIAEg0/2MC/32NSw6DMAxEr4K8rqskfEq76j0qFklwwFL5KKGIC
 nH3JhygG0vPM6O3QyDPFOCR7eBp5cDTGEFdMrC9HjtCbiODEioXSlQYug0/gVC7hTxyOq6sCyv
 bqrD1DeLQ6Jgbr0fbp+mgQ2ylYPbkeDttryZyz2GZ/PeUrzJ9/3pWiRKtuDtT5kKYkp7doPl9t
 dMAzXEcPwEAms7NAAAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1677669480; l=2107;
 i=jkl820.git@gmail.com; s=20230112; h=from:subject:message-id;
 bh=yxGpgvoqR1I43RzN8mcTsz/pvz8P/Mq+UDMS3iV7hoo=;
 b=vSKRnd2k70SBBvEdmrjxx82VMxP+TM0QAwTN8o31nedsC3fXSqe2a9dJ5q7kC/qx/St2T1ueH3ou
 h0NPHAB4BSKuBb/zo3hw8cKLI+0rIxCeqiE5q8dgA3AoTm7y0XN9
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

Linus proposed to avoid any use of the list iterator variable after the
loop, in the attempt to move the list iterator variable declaration into
the marcro to avoid any potential misuse after the loop.
Using it in a pointer comparision after the loop is undefined behavior
and should be omitted if possible [1].

Instead we'll just use a 'found' boolean to indicate if an element
was found.

Link: https://lore.kernel.org/all/CAHk-=wgRr_D8CB-D9Kg-c=EHreAsk5SqXPwr9Y7k9sA6cWXJ6w@mail.gmail.com/ [1]
Signed-off-by: Jakob Koschel <jkl820.git@gmail.com>
---
Changes in v2:
- refactor to use 'found' variable instead of moving code into the loop
- add cover letter info into the patch
- Link to v1: https://lore.kernel.org/r/20230206-sgx-use-after-iter-v1-1-c09fb5300b5e@gmail.com
---
 arch/x86/kernel/cpu/sgx/encl.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/sgx/encl.c b/arch/x86/kernel/cpu/sgx/encl.c
index 2a0e90fe2abc..91fa70e51004 100644
--- a/arch/x86/kernel/cpu/sgx/encl.c
+++ b/arch/x86/kernel/cpu/sgx/encl.c
@@ -755,6 +755,7 @@ static void sgx_mmu_notifier_release(struct mmu_notifier *mn,
 {
 	struct sgx_encl_mm *encl_mm = container_of(mn, struct sgx_encl_mm, mmu_notifier);
 	struct sgx_encl_mm *tmp = NULL;
+	bool found = false;
 
 	/*
 	 * The enclave itself can remove encl_mm.  Note, objects can't be moved
@@ -764,12 +765,13 @@ static void sgx_mmu_notifier_release(struct mmu_notifier *mn,
 	list_for_each_entry(tmp, &encl_mm->encl->mm_list, list) {
 		if (tmp == encl_mm) {
 			list_del_rcu(&encl_mm->list);
+			found = true;
 			break;
 		}
 	}
 	spin_unlock(&encl_mm->encl->mm_lock);
 
-	if (tmp == encl_mm) {
+	if (found) {
 		synchronize_srcu(&encl_mm->encl->srcu);
 		mmu_notifier_put(mn);
 	}

---
base-commit: d2d11f342b179f1894a901f143ec7c008caba43e
change-id: 20230206-sgx-use-after-iter-f584c1d64c87

Best regards,
-- 
Jakob Koschel <jkl820.git@gmail.com>

