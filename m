Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E36C060EB98
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 00:31:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233626AbiJZWbV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 18:31:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233532AbiJZWbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 18:31:18 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E39911F4B9
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 15:31:17 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id h10so12951091qvq.7
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 15:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PpTnjN/+2hyr3jwibCEvE9NjcnyxcbjRhNVuW6NzIN0=;
        b=ZtoitwBxCHtbV4pQjW6FZF+oy1WzSBIBzqTnB4CUrONscxpVldB1SSfOlXJkRRtqDN
         2FaPddVsJSa4mZZLwfERcbY80oS3IkjHrrFP8Dl0RcMNLpQ0YSu9WkD9r0LlASZCS1lx
         NqIFSqrPF4Q1X+oIt1rJc/Ev9+Ctimu40I5hwxEstTH6Vx1SzruW5Yj33yAHcg8u2/ky
         t+XwKcqZJRRQ4Qd4l09HIJ2ukqm3X4YeyBG1pMwFs/IDdJrTLMipibGF/mthyulWXbkx
         ltkHyxF+2ZsJzgMBPQWS59vIanXv7c2EUDmvX7lte89YaVwN96YK6KHpyvMeF+8hf6Mm
         EowQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PpTnjN/+2hyr3jwibCEvE9NjcnyxcbjRhNVuW6NzIN0=;
        b=cCxlJNB6wPj3HcaClkyf2wUI+QYtCgMrcc+gQ2io7EnTDfEAQSnOnuFypl4M2R5SBC
         33dmM3qnW3zCtEeEihWNlO9u2LMhkmqb5ed96nuo3VTXNWda3KjjeM8bny5bOcVKn9qh
         PRENUWkFQW0Fyw1b0S/u3DWVRSUVg69+LyTf/o6FN5d1ypFpLc8UlAUSSCrD+zBZ8r6f
         FGt8v1UY5zsMhY/X8HP53aGFZHaPfo9ADILlBr3MKftD3kpG1GH4mxBo1N6K7aoLNxxQ
         fba4UVOURswm1dAnFLpOA4aqHgy2zVdd/tHx4i2TZ3PaG5z6BuNBcSQCsak0DgZBJoou
         HU9Q==
X-Gm-Message-State: ACrzQf2wwGyIUNoE7/WkRwsrv3iVTa1vwvMw36bPk97lix5o0/KscjGe
        tklQBY6rM9loeTFE3WNknB+tugUkgL9qNQ==
X-Google-Smtp-Source: AMsMyM6bar2AE6sJe85gUEXBS22ocKkMAhvZ6HVrnsP45000FgnRmCg0qlWF1XG9pj+bu/HjdyTg7A==
X-Received: by 2002:a62:a512:0:b0:536:e2bd:e15e with SMTP id v18-20020a62a512000000b00536e2bde15emr47019512pfm.1.1666823465947;
        Wed, 26 Oct 2022 15:31:05 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id i3-20020a170902cf0300b00178acc7ef16sm3370252plg.253.2022.10.26.15.31.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 15:31:05 -0700 (PDT)
Date:   Wed, 26 Oct 2022 22:31:02 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Siddharth Chandrasekaran <sidcha@amazon.de>,
        Yuan Yao <yuan.yao@linux.intel.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v12 00/46] KVM: x86: hyper-v: Fine-grained TLB flush + L2
 TLB flush features
Message-ID: <Y1m1Jnpw5betG8CG@google.com>
References: <20221021153521.1216911-1-vkuznets@redhat.com>
 <Y1m0ef+LdcAW0Bzh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1m0ef+LdcAW0Bzh@google.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 26, 2022, Sean Christopherson wrote:
> On Fri, Oct 21, 2022, Vitaly Kuznetsov wrote:
> >   KVM: selftests: evmcs_test: Introduce L2 TLB flush test
> >   KVM: selftests: hyperv_svm_test: Introduce L2 TLB flush test
> 
> Except for these two (patches 44 and 45),
> 
> Reviewed-by: Sean Christopherson <seanjc@google.com>

Actually, easiest thing is probably for Paolo to queue everything through 43
(with a comment in patch 13 about the GPA translation), and then you can send a
new version containing only the stragglers.
