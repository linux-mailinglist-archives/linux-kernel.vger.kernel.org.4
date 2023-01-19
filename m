Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B95A067438C
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 21:36:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbjASUgw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 15:36:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230074AbjASUgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 15:36:47 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A51A49AAB0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 12:36:46 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id j16-20020a170902da9000b00194c056109eso1946252plx.18
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 12:36:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pgZXxu6xB/BEes7deu2wLBXk37A215LCr3P0IdqMWvA=;
        b=CXpiYlK3Tq4ZdVuhlFMCjkJlE6wMrxk8Au37HF3vSlctQPw+kpu5nPxJCPDyfQRhWT
         7r2oYvgh67qW8/nwt6koTMvYqbhDdW+5tj/Sf+Et6qxhKSxMd6Lacns/aaRVfkpmwfh7
         v/iLBQ+v2nxdvyOIKatiBjyxIIRm8W5TZ5XsntXKN5G0sfDMjWSIHcOfpiJzd/flWWfv
         wZyNss1LSSa9CH9NpnzvefplKBaI7kYrkT6yKiF8/ONND7kIz7vMESTrduFJGb0Qk5pG
         1fm1ouHGMfztC2645URPGS5E+/2LLk+vKLv0Ygekq6mO8DpLu9S/2S8T4R+2u44DzVD3
         vEhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pgZXxu6xB/BEes7deu2wLBXk37A215LCr3P0IdqMWvA=;
        b=U7aEmmdgGfa+5Gkn12z+qTgWa87dikf+5RNhN2vOHbG/NblPNxTJf/d8vapa6R46pA
         XMb0v9lr6UBuhkzcIT1FW152i/i9pDhq5OFp6ri/KB0i7lgm7B9hp8/9MTcUJlMBTgLb
         2no0SHGv3mqH65NYVgKB8y8sBQJwGm0BftjWoO2OxbdXmLrXjrUfj/JJy6xtA6YV3XAc
         G1V6XWePhRVvke6Vhxjrafcq9BkGWFzYUWDy20KEh5i+saN9vvrXoOn75IdCLxHXWv9v
         mhIRbwXxlw10dkAVqBNQNMkw6K/6qO5z2qn49xNuFyWIx1Ff5oR/Wt7Rg1XqYME8OmwI
         TVbQ==
X-Gm-Message-State: AFqh2krERnvvhv4zjAMw3+pUJGJOCNvHzNMgozUvwN3yP3a+muuOYKP2
        Kjg5W9w2/6x04p2+bPQBCsTN59k2540=
X-Google-Smtp-Source: AMrXdXuZHdODfkF+foaLMzLhhcCvRj/U9gWzaQ56sDdyJJ1cmO2Kr3nEjMRm8qS+DNlPEYq82o41J8TfSFA=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:690f:b0:229:1e87:285c with SMTP id
 r15-20020a17090a690f00b002291e87285cmr1599919pjj.200.1674160606002; Thu, 19
 Jan 2023 12:36:46 -0800 (PST)
Date:   Thu, 19 Jan 2023 20:35:24 +0000
In-Reply-To: <202211231704457807160@zte.com.cn>
Mime-Version: 1.0
References: <202211231704457807160@zte.com.cn>
X-Mailer: git-send-email 2.39.0.246.g2a6d74b583-goog
Message-ID: <167408775757.2362935.3713773100695862688.b4-ty@google.com>
Subject: Re: [PATCH linux-next] KVM: x86: remove redundant ret variable
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>, zhang.songyi@zte.com.cn
Cc:     pbonzini@redhat.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Nov 2022 17:04:45 +0800, zhang.songyi@zte.com.cn wrote:
> Return value from apic_get_tmcct() directly instead of taking
> this in another redundant variable.

This patch was whitespace damaged, please fix your setup.  I manually applied it
(and one other) since it's a trivial change, but I likely won't have that luxury
for future patches.

Applied to kvm-x86 apic, thanks!

[1/1] KVM: x86: remove redundant ret variable
      https://github.com/kvm-x86/linux/commit/14bd05184168

--
https://github.com/kvm-x86/linux/tree/next
https://github.com/kvm-x86/linux/tree/fixes
