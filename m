Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 826FB742AD5
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 18:50:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbjF2Qul (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 12:50:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231508AbjF2Qui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 12:50:38 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C23630F1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 09:50:37 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5618857518dso6988207b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 09:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688057436; x=1690649436;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=P7X1f1JkCDNqEyBhjNE0NVCYk7dv7XgPQ/wMLYU+XyQ=;
        b=a6lSBajW3W02rYZGgR3/o0i9lxzRFVovXoe3Q3JaBs8FdTwqUBneab7VBjiCfUhcLA
         0ufpIbSR4EeP/geTQzfXNnnIbTwqIf0t30LMWe6PpIWGthQ/XTooya1lmeGiSvs6YA5S
         mswOiz4kIhsywRvIn1fanIuT6NZHga1wspana2xVtBxT5giHdB7sN6MIVZl44cmlJnNO
         1CGKzS+KzlyEF3Q2aNAESdMDCcdGN0e8CIBhnwCbVpSChU+zztHsa7BZhyNcGQZmHaPF
         L9/xLJSMfJm4abmW4kcT3CxN4cTptlZaENvbIcJ9kj1ojgO1prkD1YbHNJi4caKPO1dv
         6E7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688057436; x=1690649436;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P7X1f1JkCDNqEyBhjNE0NVCYk7dv7XgPQ/wMLYU+XyQ=;
        b=hb7SIcdl29vp+r73Mz6Yl6TPKv2/yM7XTVXwMKJ4YSR+zrK4fpan2tT3Q/FXXajbqI
         prpD08J/BcKSQ5SP/RxQA+YE4+xW29Y/htb54HuNkuAu7iEuOcmZkqz9/QpwSFmLwvZL
         caDvYd/DrsaOhdnDCMXPQBuObcYKBxDxiMhqtJEwNluvxAKDnfE2QmFyBQyps1PqmfOg
         Y0ivMnWrKQBJdYvyo9PmNjD5JN8Vv10Kq+rIwuz7QwAja5ewYsV5euQPxheJk7PN0DWs
         tDKEqKym0E5dEUlO6gDeaz4hi3uZXjJIP360dmsEgwTdsRbwMwofbHnURK8Kc5rpfCwX
         801g==
X-Gm-Message-State: AC+VfDyZFZQlGzNTH7qsCKPq5EeVIRfF7aNtpDo1rGIH1D3PoBr4/RVa
        ltO+so4cPn9sqqrvuBe0bHexkLVXy5k=
X-Google-Smtp-Source: ACHHUZ4lX+OOByfNcIUyoAakFmq15S+MSm5QkF+XEVSIc/gfVC4dKYToyRXyN+5uRHV6F/tF6oW/LjK/pqc=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:b647:0:b0:56d:3c2b:2471 with SMTP id
 h7-20020a81b647000000b0056d3c2b2471mr15652904ywk.3.1688057436218; Thu, 29 Jun
 2023 09:50:36 -0700 (PDT)
Date:   Thu, 29 Jun 2023 09:50:34 -0700
In-Reply-To: <Y/ZFJfspU6L2RmQS@google.com>
Mime-Version: 1.0
References: <20230217231022.816138-1-seanjc@google.com> <20230217231022.816138-9-seanjc@google.com>
 <20230221152349.ulcjtbnvziair7ff@linux.intel.com> <20230221153306.qubx7tfmasnvodeu@linux.intel.com>
 <Y/VYN3n/lHePiDxM@google.com> <20230222064931.ppz6berhfr4edewf@linux.intel.com>
 <Y/ZFJfspU6L2RmQS@google.com>
Message-ID: <ZJ22Wts4WKKD19bN@google.com>
Subject: Re: [PATCH 08/12] KVM: nSVM: Use KVM-governed feature framework to
 track "vVM{SAVE,LOAD} enabled"
From:   Sean Christopherson <seanjc@google.com>
To:     Yu Zhang <yu.c.zhang@linux.intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Maxim Levitsky <mlevitsk@redhat.com>
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 22, 2023, Sean Christopherson wrote:
> +Maxim
> 
> On Wed, Feb 22, 2023, Yu Zhang wrote:
> I'll opportunistically massage the comment to make it more explicit about why
> VMLOAD needs to be intercepted.
>  
> That said, clearing the bits for this seems wrong.  That would corrupt the MSRs
> for 64-bit Intel guests.  The "target" of the fix was 32-bit L2s, i.e. I doubt
> anything would notice.
> 
>     This patch fixes nested migration of 32 bit nested guests, that was
>     broken because incorrect cached values of SYSENTER msrs were stored in
>     the migration stream if L1 changed these msrs with
>     vmload prior to L2 entry.

Aha!  Finally figured out what this code is doing.  KVM intercepts VMLOAD so that
KVM can correctly model the VMLOAD behavior of dropping bits 63:32, i.e. to clear
svm->sysenter_eip_hi and svm->sysenter_esp_hi.

So the code is correct.  I'll add this comment:

	/*
	 * Intercept VMLOAD if the vCPU mode is Intel in order to emulate that
	 * VMLOAD drops bits 63:32 of SYSENTER (ignoring the fact that exposing
	 * SVM on Intel is bonkers and extremely unlikely to work).
	 */
