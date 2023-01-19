Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 738C2674412
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 22:12:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbjASVMK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 16:12:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbjASVK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 16:10:26 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D65D0A1999
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 13:03:48 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id r8-20020a252b08000000b007b989d5e105so3587586ybr.11
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 13:03:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=66eoUQLINoCSZe5217U1Za9CcjZ6XPwbHrQAdTCRdT0=;
        b=F3B5GY4i6AvBwIMPRt9TTV7xIiShSyVc0ke4P2PCipYOd7eMwwmcR7LCzt7gaXlEC8
         goE/ndzrH9yBB6TJwR1G2FOFx5NezouPVAtRR8uaQ4HyWGtPsATT8tEZWiWcLcyO03L4
         N9ceEQntNJV8Xh7pN9ZvMEaSUMklFqz6A31p1s9IuQjIzYP8ik6InjSi37jRMLiEpYpx
         +Hq+Pz8UgWsFp16M6wmBLLXQT+cgkBoHXHn5UmZPynEm1IYzvvHrNoxdd+fnDIE51aWz
         BFE36UWOpkM+XA/Ho5oB5xF/TLREf8amXzqqRpJK514YP22lvXEYiQNhDox9Hh/6Tkgr
         1vTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=66eoUQLINoCSZe5217U1Za9CcjZ6XPwbHrQAdTCRdT0=;
        b=6i9FxCg9hHJdVVzgkVuepOcgBc3ndtTFkCFloB7dnyaGVDlU1u6JadT10+c3Rfqmvl
         RXKp/rYvBxd8aErp403l8vEKl90nITPQgLr2RxnAWBeqEM5BduMkxFh/fo4/oSsqFaDI
         Kh04l3PhyjyJGwtRazWHvVA7CkdgJ8jrvAa82b/ywhNsIdGAT/rBpMuOYn5vh8eitF5Z
         VLqttAi6Bj1MeVku5cR9iIf9KgD+rvzZa5VELf5PFh9HW0zUg4vfTAmpr4GdNEn64SJz
         RsTkcXeEDZ16dqxwiMSaxM8gWQyCp0toTFMYkYx7dBluwp3gAw6iw8P58HVEY2lpj/GN
         1s2g==
X-Gm-Message-State: AFqh2kr1wiTW0YrbsoHTv5hulXv/RtD47FI50hpogKrMahw4S3Ku4ZnU
        bpl9ODkOzgwGxWd193SYlm+jwd2RELQ=
X-Google-Smtp-Source: AMrXdXsQQJdr3aUFiThwbmTDiIynCoVVfraAW9LljNpH9q1hCzIigCtiKAPQFE/ofE17HM+6Qw7M8PWE6Es=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a5b:38a:0:b0:6fb:b4af:e56e with SMTP id
 k10-20020a5b038a000000b006fbb4afe56emr1324727ybp.60.1674162228549; Thu, 19
 Jan 2023 13:03:48 -0800 (PST)
Date:   Thu, 19 Jan 2023 21:03:36 +0000
In-Reply-To: <20221119003747.2615229-1-seanjc@google.com>
Mime-Version: 1.0
References: <20221119003747.2615229-1-seanjc@google.com>
X-Mailer: git-send-email 2.39.0.246.g2a6d74b583-goog
Message-ID: <167408889183.2366972.15087378165814021774.b4-ty@google.com>
Subject: Re: [PATCH] KVM: VMX: Access @flags as a 32-bit value in __vmx_vcpu_run()
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 19 Nov 2022 00:37:47 +0000, Sean Christopherson wrote:
> Access @flags using 32-bit operands when saving and testing @flags for
> VMX_RUN_VMRESUME, as using 8-bit operands is unnecessarily fragile due
> to relying on VMX_RUN_VMRESUME being in bits 0-7.  The behavior of
> treating @flags a single byte is a holdover from when the param was
> "bool launched", i.e. is not deliberate.
> 
> 
> [...]

Applied to kvm-x86 vmx, thanks!

[1/1] KVM: VMX: Access @flags as a 32-bit value in __vmx_vcpu_run()
      https://github.com/kvm-x86/linux/commit/55de8353fc67

--
https://github.com/kvm-x86/linux/tree/next
https://github.com/kvm-x86/linux/tree/fixes
