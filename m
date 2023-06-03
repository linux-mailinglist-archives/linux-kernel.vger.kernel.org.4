Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBD86720CB6
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jun 2023 02:53:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236963AbjFCAxY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 20:53:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236929AbjFCAxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 20:53:20 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39E8B1B7
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 17:53:06 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-bac6a453dd5so3430383276.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 17:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685753585; x=1688345585;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=US4vHwNOcm3/zMnVF1blo1rgU4JeS0wRpb0+OG6CxyU=;
        b=n1aqXE43vnadMoQue8MwOBH7UzzRGNU4a7MYwWJEgxtSRqhEg3u2pTBB6HBu6ixRhc
         1z09YLLoFo6iFOIMmz4+V/8t6PUNqu3jcL5vagc4ijr6WBc33tXSMNEyI2Ru+To6zZxG
         4MXGazcSn/HjpZcvldbLNW1egIH4LJJW9WcMDqNUYHF11Nv+FJMbupqMEpBjvqSrHgO4
         c6elvg9n9pBKuXV8fBzGTQTerProyvnmFGqNZe1IiAS+eHPE9QgDcee8XF3cay1tz50e
         f5to9zAYA26RqCUL6bUvHnEDWNNhRelMvXrPrWgphncVBr5kC7uFJMU/rmIzvwwJGMsC
         Rpbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685753585; x=1688345585;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=US4vHwNOcm3/zMnVF1blo1rgU4JeS0wRpb0+OG6CxyU=;
        b=VYOfOS3nFWXhxfDUvvwmOrt7ROGME6YFWo/kDTXxEnsG0q79XiiWLm47cmP1v/uJXj
         EnpW+U3sduixSevEe7++pugdpUgeckA0O54Shy1+xhj3dB6Urja36L8eceSkjFUZnFdZ
         zeW1UD6TaH8RXE5qUbNXn43ZZdG+4f4hWnb2i5zWd73nXsO7MgDCttf9YGPlqd/Z4IVJ
         5RfMalWlMlfKK3xHPTOv9x07MRTEtAou5rj48XRfr2z4+Ljq/RGy/FMu49AjOjSK3bh9
         u7CKOBXY07grwyhaTp7kpS5tB0jRwD9YFpC68yYmkoS8JRzwZeZWoDHOWbX/v3z8ILnG
         aUeg==
X-Gm-Message-State: AC+VfDz4P8gEOVJM1bzrUymTfLuomZgCivyjjZf5Nx/wn+QH1E/hquSr
        Oc0WV6HUDL01Wmus7JPvStiuFi/Op4w=
X-Google-Smtp-Source: ACHHUZ7mLA1RGKqYc/9z4KiEVtFUM1M+06Ebd3MgrKbFHDLx1gYQ3SqMWbBe2PSpTk5HvI4USPTSP1oJluE=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:1009:b0:ba8:2e69:9e06 with SMTP id
 w9-20020a056902100900b00ba82e699e06mr2756914ybt.1.1685753585343; Fri, 02 Jun
 2023 17:53:05 -0700 (PDT)
Date:   Fri,  2 Jun 2023 17:52:26 -0700
In-Reply-To: <20230602011920.787844-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230602011920.787844-1-seanjc@google.com>
X-Mailer: git-send-email 2.41.0.rc2.161.g9c6817b8e7-goog
Message-ID: <168574913785.1016961.3776399676561784984.b4-ty@google.com>
Subject: Re: [PATCH 0/2] KVM: x86: Fastpath accounting fixes
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 01 Jun 2023 18:19:18 -0700, Sean Christopherson wrote:
> Fix two bugs where KVM fails to account/trace exits that are handled
> in the super fast fastpath.  SVM doesn't actually utilize the super fast
> fastpath, i.e. patch 1 only affects VMX and the bug fixed by patch 2 is
> benign in the current code base.
> 
> Found by inspection, confirmed by hacking together a small selftest and
> manually verifying the stats via sysfs.
> 
> [...]

Applied patch 1 to kvm-x86 fixes (for 6.4), and patch 2 to kvm-x86 svm (for 6.5).
Should have posted these separately...

[1/2] KVM: x86: Account fastpath-only VM-Exits in vCPU stats
      https://github.com/kvm-x86/linux/commit/8b703a49c9df
[2/2] KVM: SVM: Invoke trace_kvm_exit() for fastpath VM-Exits
      https://github.com/kvm-x86/linux/commit/791a089861fc

--
https://github.com/kvm-x86/linux/tree/next
https://github.com/kvm-x86/linux/tree/fixes
https://github.com/kvm-x86/linux/tree/svm
