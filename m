Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DEDF6369C4
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 20:19:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237968AbiKWTTC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 14:19:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238984AbiKWTS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 14:18:56 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5662938B0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 11:18:55 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id w23so17477574ply.12
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 11:18:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kdNaYNJoqZ0zaws1qMwaqeMsoZbKMbkmo8GOxmOy1jc=;
        b=L6E0U3d3pPFmjeYCFQr0cBSEq45AA0KodB05VKYYbI2kFtz/n4zbRPzcPRvwSfLmJ1
         UV5HjHM/rCcN+ykr3xN2sr5rWAw6wpyzk3M4W3XOtOH8P+h6Wd9rLNwYaV/ooHjft9oS
         ZYnOvGfQQy9OuizMlKboeYXWqgVEpRftPlbbm6cPle9FFkz941aOuu7lXWMG6i4EoTFx
         hYjdX4IirhnxX3NW3+2b+gPwc85HCz5E1c85WeK22uuWenAiorLsbYWcdnqKl1+Z+2vu
         6KfdgVdZEQ49GOHUEBDRf1qOuka4evpsxfRxTL59OkuxZV2mnYRK/GSrqkumGgROK6lW
         6Jjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kdNaYNJoqZ0zaws1qMwaqeMsoZbKMbkmo8GOxmOy1jc=;
        b=J8q78gtLJTsw2FH4g2wQ7lSZnWp/e5fXhfthog7ZHqr6lAyPgE5Cwu1QeGren9jVIO
         dArU7/74K1X8i4EpjJ9lqZnJFGd1QWF9kMZKe9KUVZ0F8SpZSyP9b2W5bWWNKoj1CdSP
         OwA9t7/cvgbp1kY1iITnTHwCQiFLb1KGvCA9t7p+IWzyln/aMAHPFgEhSldQmTQCP/0J
         kEIGiFUJFbu9rS0hSCCc2lmNCxWaJz7ZuxLVbGYpYui32RbwCc2jSL1cdrBwNWnYvTB8
         y638ibXKM/cNjVyzMFTwmRrQ/UeoJAO1lFPv0xRtmNJa6M6ko7Dz5UVkNIoy3iAGwXfO
         OKmA==
X-Gm-Message-State: ANoB5pnHGRU4V5/Lk+E8+/WkzUDv9kbAgH1CZSzxnbW1Lrd+Pyi0lFEA
        AwoXWxv+obELJOLxjjcu2WV0vg==
X-Google-Smtp-Source: AA0mqf4cliIzotOhoD+7RiQRLBcc/vxgX3rMEOJi4k2pQoDyoldrlWaDJnFHqqjuKhgTZGyHPkaJsw==
X-Received: by 2002:a17:903:1245:b0:187:3921:2b2d with SMTP id u5-20020a170903124500b0018739212b2dmr10757401plh.13.1669231134765;
        Wed, 23 Nov 2022 11:18:54 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id d9-20020a17090a114900b002189672d688sm1749790pje.20.2022.11.23.11.18.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 11:18:54 -0800 (PST)
Date:   Wed, 23 Nov 2022 19:18:50 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Li, Xin3" <xin3.li@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: [RESEND PATCH 5/6] KVM: x86/VMX: add kvm_vmx_reinject_nmi_irq()
 for NMI/IRQ reinjection
Message-ID: <Y35yGltCxrwueOqn@google.com>
References: <BN6PR1101MB2161E8217F50D18C56E5864EA8059@BN6PR1101MB2161.namprd11.prod.outlook.com>
 <Y3IFo9NrAcYalBzM@hirez.programming.kicks-ass.net>
 <BN6PR1101MB2161299749E12D484DE9302BA8049@BN6PR1101MB2161.namprd11.prod.outlook.com>
 <Y3NZQBJugRt07udw@hirez.programming.kicks-ass.net>
 <DM5PR1101MB2172D7D7BC49255DB3752802A8069@DM5PR1101MB2172.namprd11.prod.outlook.com>
 <Y3ZYiKbJacmejY3K@google.com>
 <BN6PR1101MB21611347D37CF40403B974EDA8099@BN6PR1101MB2161.namprd11.prod.outlook.com>
 <BN6PR1101MB2161FCA1989E3C6499192028A80D9@BN6PR1101MB2161.namprd11.prod.outlook.com>
 <Y302kxLEhcp20d65@google.com>
 <Y33k6MBEN3brakDL@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y33k6MBEN3brakDL@hirez.programming.kicks-ass.net>
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

On Wed, Nov 23, 2022, Peter Zijlstra wrote:
> On Tue, Nov 22, 2022 at 08:52:35PM +0000, Sean Christopherson wrote:
> 
> > Another wart that needs to be addressed is trace_kvm_exit().  IIRC, tracepoints
> > must be outside of noinstr, though maybe I'm misremembering that.
> 
> You are not, that is correct. Another point to be careful with is usage
> of jump_label and static_call, both can be used in noinstr *provided*
> they don't actually ever change -- so boot time setup only.
> 
> If either of them were to change, text_poke_bp() has a clue in the name.

I think we're mostly ok on that front.  kvm_wait_lapic_expire() consumes multiple
static keys that can change at will, but that can be kept outside of the noinstr
section.  

Thanks!
