Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 736586C8964
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 00:39:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231949AbjCXXjB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 19:39:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231928AbjCXXi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 19:38:59 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15779166C1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 16:38:58 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id m10-20020a17090a4d8a00b0023fa854ec76so2853868pjh.9
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 16:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679701137;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wUgmVGu7JMLyhIBxdk3j4kkCkWbrL8dDSyYl1zRhg0w=;
        b=d6ADcfyxTBVfBIjmhQODsTyomiWP5T0esWmdFF45Cke7kUunNxzXYXPkWOV1QzLEFB
         qjLAaGydwMMVhj69+hB5U777eY+Mk475NLopGpeXWETlW2rh0Wv7aHp+tfdoDkp/GTA/
         NzZ0of0wr4VE3JqRRbwfNIoYp+NMbk41qxzn0kquCrBeEZiikWHiPweQUtRJlZNUT0XU
         4w1je1AidBU4uF2iJndNn9JE2dqFyNKP57gDUWoyVMYBwp9PM8n4a8kqhsR2hmZe34RG
         L7ctLRdeErSxEkz17wKDEKOPARsjBKSGMADTgkZijshRM1sd1iVNmh/STBbQZ0bAkzg4
         eBcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679701137;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wUgmVGu7JMLyhIBxdk3j4kkCkWbrL8dDSyYl1zRhg0w=;
        b=Iib5/mu6Xsgr3l2bnOXz782LnOyw2UxVI4i9DIZhnxMcMOiDaM23AbIK2QB9UUfMVy
         zkcpYEYBmHHLgDLG9vdjsaOSriRGwuqiq8Vz7M6iuB4aKdaRftQdGNkuCX1cotb/kO/m
         Vip/ibZZC0Pav3nxR21l+0g22ebpGD9K/d1g7J7i/o00blw9W6SkisNlgl8CRqtGY0r9
         KQlzYqC/+iLoxQnrMFNWhjG3Hhl8c5lMkcsuTldaZGAszomgCCiBHZ4wTZtrjG+XwYL2
         FE6FZ5Dz3TJutqYkLaThnciY/b9XCgaSyxJOlxmIIRw6xhfBpbIdpp8B3hwCLRu2Ue9Z
         xa6g==
X-Gm-Message-State: AAQBX9dXwmW8lFgr9aWv6eU3K/9fL4KID+44Rr0jIBUMRySUbtvOz18h
        N9Imk2qSvd0WZI58J0P9iahRBO5oEAU=
X-Google-Smtp-Source: AKy350ZW72ypzlyQN7Yp1KN2QZDP9GxE6Z9VFyQCUCkP1GWSmZ0RbiUhz/bMEerx3YAT/JiT/MM49wxpNZ8=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:d516:b0:234:13d8:ed5b with SMTP id
 t22-20020a17090ad51600b0023413d8ed5bmr1376116pju.3.1679701137579; Fri, 24 Mar
 2023 16:38:57 -0700 (PDT)
Date:   Fri, 24 Mar 2023 16:38:12 -0700
In-Reply-To: <20230216202254.671772-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230216202254.671772-1-seanjc@google.com>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Message-ID: <167969133728.2756130.12262089372774789220.b4-ty@google.com>
Subject: Re: [PATCH] KVM: x86: Assert that the emulator doesn't load CS with
 garbage in !RM
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hou Wenlong <houwenlong.hwl@antgroup.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Feb 2023 12:22:54 -0800, Sean Christopherson wrote:
> Yell loudly if KVM attempts to load CS outside of Real Mode without an
> accompanying control transfer type, i.e. on X86_TRANSFER_NONE.  KVM uses
> X86_TRANSFER_NONE when emulating IRET and exceptions/interrupts for Real
> Mode, but IRET emulation for Protected Mode is non-existent.  WARN instead
> of trying to pass in a less-wrong type, e.g. X86_TRANSFER_RET, as
> emulating IRET goes even beyond emulating FAR RET (which KVM also doesn't
> fully support).
> 
> [...]

Applied to kvm-x86 misc, thanks!

[1/1] KVM: x86: Assert that the emulator doesn't load CS with garbage in !RM
      https://github.com/kvm-x86/linux/commit/65966aaca18a

--
https://github.com/kvm-x86/linux/tree/next
https://github.com/kvm-x86/linux/tree/fixes
