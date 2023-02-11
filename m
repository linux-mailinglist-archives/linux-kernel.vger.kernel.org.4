Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E904692C6E
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 02:07:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbjBKBHY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 20:07:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbjBKBHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 20:07:22 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF42C6A30D
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 17:07:21 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id j14-20020aa7928e000000b00593bca77b0dso3389952pfa.9
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 17:07:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+7bVeIY1PbqOirWdgJRd29ZTEGdTbk1KiTUdqiq2xys=;
        b=NbsW7bgmb9w0c8Z3wplH9CxbF5d465YV9a6YZEeC+gL458CwvYjti1VMnaWP7Z2PFD
         E3/PdrXz/tTnfsoFefOwwVxzT36bcbhU7oebgg5APoEThEgu/6cZk95YA4wfdWBk65Ow
         W179TfNdJJpecVUeDQV5MAeQQjjyjhcAnWTzxX1V+jxChyb0I7jzq5fAr0ypHWmMTqLi
         Ha2dEtfLO4MeqORSEr5rqXDMpQq5wkd+PQAgHBvO7JLIHTPlrzeNBPVMxa77XP5iH9S3
         k+VctLEs1L9ncxca78xCABQM5jbL6I8WKIHSUxK8u3ykjZsj0lssnecu/SEqKpOQHsy9
         /vOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+7bVeIY1PbqOirWdgJRd29ZTEGdTbk1KiTUdqiq2xys=;
        b=DPdyZonhdMnL6ybjtfY8mm3+tCCQtQ8vYL3CRvOtAFZTeSFzWc0APeT+GaMSjG9SUF
         GWt1t85aBCqhhJdcIGW+9VfGpYsYJpEq9Dki7jdX7ZMndAoXm3NntAQCFCMLDFrgN1Cj
         keGRRckPWkWKobyPhuRFpKsoczT82DD2Sw7FTAF0H3qeKz8PLXWesvu6+lEg0vCFS2KP
         /oVP4khksEOgibNL+2O02yxGxsXg9cGRSLZxasFpIjVWZsfAoESSPyXeZ/8hxkWFQO64
         cUObbh2cvynZFOZwYTcl9kSXN5kZeXQqM/4yBRieROM9OYOqFgVdDFv133X2Pn60YVcL
         P+7Q==
X-Gm-Message-State: AO0yUKWpN0dfER1VP6r47GPT3xioxvH/wdtXquXMpFPcAkbkVLYioU/4
        m+bqr08oTTF9s8UN39ZpLP2u18qfbt8=
X-Google-Smtp-Source: AK7set8ZmZNKui4cyuIsZGJTyzW/4AnMfllWwuRWb6Ts7zjbrK7PidBuDnGgnzSzaS9mPCFxb/DCVfJ3PqA=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:e281:b0:230:3649:a362 with SMTP id
 d1-20020a17090ae28100b002303649a362mr2681970pjz.131.1676077641450; Fri, 10
 Feb 2023 17:07:21 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Sat, 11 Feb 2023 01:07:19 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.1.581.gbfd45094c4-goog
Message-ID: <20230211010719.982919-1-seanjc@google.com>
Subject: [PATCH] KVM: Protect vcpu->pid dereference via debugfs with RCU
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wrap the vcpu->pid dereference in the debugfs hook vcpu_get_pid() with
proper RCU read (un)lock.  Unlike the code in kvm_vcpu_ioctl(),
vcpu_get_pid() is not a simple access; the pid pointer is passed to
pid_nr() and fully dereferenced if the pointer is non-NULL.

Failure to acquire RCU could result in use-after-free of the old pid if
a different task invokes KVM_RUN and puts the last reference to the old
vcpu->pid between vcpu_get_pid() reading the pointer and dereferencing it
in pid_nr().

Fixes: e36de87d34a7 ("KVM: debugfs: expose pid of vcpu threads")
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 virt/kvm/kvm_main.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index d255964ec331..b7b72c8fb492 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -3867,7 +3867,10 @@ static int create_vcpu_fd(struct kvm_vcpu *vcpu)
 static int vcpu_get_pid(void *data, u64 *val)
 {
 	struct kvm_vcpu *vcpu = (struct kvm_vcpu *) data;
-	*val = pid_nr(rcu_access_pointer(vcpu->pid));
+
+	rcu_read_lock();
+	*val = pid_nr(rcu_dereference(vcpu->pid));
+	rcu_read_unlock();
 	return 0;
 }
 

base-commit: 7cb79f433e75b05d1635aefaa851cfcd1cb7dc4f
-- 
2.39.1.581.gbfd45094c4-goog

