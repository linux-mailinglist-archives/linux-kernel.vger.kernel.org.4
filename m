Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EC7F725141
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 02:54:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234515AbjFGAx7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 20:53:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240047AbjFGAxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 20:53:55 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 619921732
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 17:53:54 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-babb76a9831so9961142276.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 17:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686099233; x=1688691233;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pD9JHpKa9k5ZTt3oQtanv15RS2ukb+oCEMW4HydPPPc=;
        b=4K4GdjQlGVzj7cMvF1aWAyUT1TBmSn3cSo54e+6hd/SRJFIYpbMwVydbVz8akfdd9o
         YSKbt31ky2uOnw8CCliU694KWa7dqgIXSBL2mIy40+paqzpk/0KvNvmkrf/d2xXNfjOA
         4gY9iEMRmQD2ObEmKsD3+7FnL+ubsVrsplXhzlRbVeA9m+fOLB9f9CK9kHdQoIHuEZ+t
         6E7+uOy4bvM4B+xKY5GT4QmBBia7duM7Sr8B6DbgnyR/+qP2nkJEgJbhHhgnvwbGLA/z
         jwiKKm73iQ5FEOjET211bijHaiFLQADbhvMdP5Ci5qk4pQU76wFpR0eApwP31iwMfd3o
         yLRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686099233; x=1688691233;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pD9JHpKa9k5ZTt3oQtanv15RS2ukb+oCEMW4HydPPPc=;
        b=jJV9hAQOFhJpOpJLxHYDP/3sSJ/YvrhtyozZxWx5nDNEdOq3b5NmhReqrhmZBgMr0m
         LDeBldWU0FJUd5ajVMxIqeJtzDcaSKiiCCE+a11wa2c8gljRKdQuW+XcgGMyvoWBsxV6
         yMqOBzCvsI0jnQ1HBiE1R8hdIll1LUaLfhtwSaf1gqHCgZHfYrT2NaB+5drKxvFZeo3K
         KXyfT8yu331Imb1bWCqblCGNZLcer4CQ25g0ld0z1ZB8Qr5TgvJPZdqPBSNoOIJ5J8U5
         cUUNoJsl+Do581S2vGK7HmlxdCSmLcH4TS7jOgpgdL0eGHMCpwv9vGIuFPLEqs/zEdL8
         V2PQ==
X-Gm-Message-State: AC+VfDzxpgwMHEmkq9angddATA6pnVwOT9+KuhKdLlE04wJkBYwMrtUG
        bCG3zv8PmP7suU/wKU0rxfDIx4eR/p4=
X-Google-Smtp-Source: ACHHUZ4DFXG1xXJqUvdqCKKlCCwxV/qDcG6kNSxVlXhWXoWbCpJKlcsChumJb3kitTfzWf+4OHeMyk3Uxqk=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:188c:b0:ba8:8d92:caea with SMTP id
 cj12-20020a056902188c00b00ba88d92caeamr1413698ybb.1.1686099233638; Tue, 06
 Jun 2023 17:53:53 -0700 (PDT)
Date:   Tue,  6 Jun 2023 17:53:42 -0700
In-Reply-To: <20230602010550.785722-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230602010550.785722-1-seanjc@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <168608971339.1368390.3660632949496517559.b4-ty@google.com>
Subject: Re: [PATCH] KVM: x86: Use cpu_feature_enabled() for PKU instead of #ifdef
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jon Kohler <jon@nutanix.com>
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

On Thu, 01 Jun 2023 18:05:50 -0700, Sean Christopherson wrote:
> Replace an #ifdef on CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS with a
> cpu_feature_enabled() check on X86_FEATURE_PKU.  The macro magic of
> DISABLED_MASK_BIT_SET() means that cpu_feature_enabled() provides the
> same end result (no code generated) when PKU is disabled by Kconfig.
> 
> No functional change intended.
> 
> [...]

Applied to kvm-x86 misc, thanks!

[1/1] KVM: x86: Use cpu_feature_enabled() for PKU instead of #ifdef
      https://github.com/kvm-x86/linux/commit/056b9919a16a

--
https://github.com/kvm-x86/linux/tree/next
https://github.com/kvm-x86/linux/tree/fixes
