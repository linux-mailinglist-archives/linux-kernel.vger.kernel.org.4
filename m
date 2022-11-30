Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B0CE63D517
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 12:59:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234907AbiK3L7B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 06:59:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234650AbiK3L65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 06:58:57 -0500
X-Greylist: delayed 182 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 30 Nov 2022 03:58:52 PST
Received: from cmccmta1.chinamobile.com (cmccmta1.chinamobile.com [221.176.66.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3B6FA6F35B
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 03:58:51 -0800 (PST)
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from spf.mail.chinamobile.com (unknown[172.16.121.13])
        by rmmx-syy-dmz-app04-12004 (RichMail) with SMTP id 2ee4638744c2ae6-72a2d;
        Wed, 30 Nov 2022 19:55:47 +0800 (CST)
X-RM-TRANSID: 2ee4638744c2ae6-72a2d
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[223.108.79.98])
        by rmsmtp-syy-appsvr07-12007 (RichMail) with SMTP id 2ee7638744ab87e-1ba3b;
        Wed, 30 Nov 2022 19:55:46 +0800 (CST)
X-RM-TRANSID: 2ee7638744ab87e-1ba3b
From:   liujing <liujing@cmss.chinamobile.com>
To:     seanjc@google.com
Cc:     pbonzini@redhat.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com,
        linux-kernel@vger.kernel.org,
        liujing <liujing@cmss.chinamobile.com>
Subject: [PATCH] KVM: x86: Redundant variable assignments can be merged
Date:   Wed, 30 Nov 2022 06:55:04 -0500
Message-Id: <20221130115504.4282-1-liujing@cmss.chinamobile.com>
X-Mailer: git-send-email 2.18.2
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When reading kvm code, find the 'r' variable declaration
and then assign the value in kvm_vm_ioctl_get_irqchip and
kvm_vm_ioctl_set_irqchip function, It can be combined into one sentence.

Signed-off-by: liujing <liujing@cmss.chinamobile.com>
---
 arch/x86/kvm/x86.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 2835bd796639..4be353d5c09d 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -6002,9 +6002,8 @@ static unsigned long kvm_vm_ioctl_get_nr_mmu_pages(struct kvm *kvm)
 static int kvm_vm_ioctl_get_irqchip(struct kvm *kvm, struct kvm_irqchip *chip)
 {
 	struct kvm_pic *pic = kvm->arch.vpic;
-	int r;
+	int r = 0;
 
-	r = 0;
 	switch (chip->chip_id) {
 	case KVM_IRQCHIP_PIC_MASTER:
 		memcpy(&chip->chip.pic, &pic->pics[0],
@@ -6027,9 +6026,8 @@ static int kvm_vm_ioctl_get_irqchip(struct kvm *kvm, struct kvm_irqchip *chip)
 static int kvm_vm_ioctl_set_irqchip(struct kvm *kvm, struct kvm_irqchip *chip)
 {
 	struct kvm_pic *pic = kvm->arch.vpic;
-	int r;
+	int r = 0;
 
-	r = 0;
 	switch (chip->chip_id) {
 	case KVM_IRQCHIP_PIC_MASTER:
 		spin_lock(&pic->lock);
-- 
2.18.2



