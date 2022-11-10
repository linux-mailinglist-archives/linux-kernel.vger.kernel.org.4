Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 354E46248B6
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 18:53:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231358AbiKJRxk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 12:53:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231364AbiKJRxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 12:53:36 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75C35240B4
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 09:53:34 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id d20so2040291plr.10
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 09:53:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2oKQDlB6eYx+fAXvKZFnqwvhnIR4JQKKCXs9/v8+asA=;
        b=USq4b5Vh1OXggTCD0w44axvUCuw0wgwmRJONRIlB95PFBRewtOpmoKc7I2XbMFe+Jt
         py6SLDlrcfHe9Q3VO4+7dfiMGs6dPX9qHKjrdWteekp4+U/DoQ8k4+BtA12MyhPAKSwW
         oWUbDGwbmbtRu0HlyiAF1gzP3/dmYGn+4ag1yp2zQxUQz3Y8R8NAepQDJa1zRgnFTAwp
         482q2MupCDGAkGCVertYK1p6MwGRwEAvRckuUOPwVBujunwWETFLz4d1bnde8cgKCLkj
         6U6T7ZnM4yWVZOheoRcwISEPaZCMlXQ5G+O2GSFI15kWlhWhoPX3ZMRej3KuRu/bUqnC
         oRxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2oKQDlB6eYx+fAXvKZFnqwvhnIR4JQKKCXs9/v8+asA=;
        b=iorJaec20GmtUkO4H6XLA4NEDiXPXvMhBnqq5WFJDH0n355k2XQC2DpuUQICr3c1w3
         uC+tFJZRIzh9MDDxkDW2MwUmjrKZz5jrVW9kzxdZjYi/L2xMn+NTjnp7HjJd3xcGMdha
         581sLc4rVie3txksnjWKQqvzZNxGUOMfLxsErEr4CwdvQzOI3r8jbXMUgnKStCN2Sr8I
         +jtZHooB+tgivNVWgnpdf3iYiwvWXHjBgri2dmSJPRlegGPmLMVU0pdpQoVJJCQJ1CUU
         NjG22KC4bKbQBxoDQVBBEJM9zej9kvXDptzTS79eejn2zrdcukOUcs1l8JeynnSiXfJz
         LLXg==
X-Gm-Message-State: ANoB5plkb6BZMAzg71p9AOG5XPV4zdadu+EGKuzyk48AXsEtwA9biMj2
        Ur3BMS3VadnRFCjE428/QUaYZQ==
X-Google-Smtp-Source: AA0mqf5Tm7voUfqlq46fUuj/FQZ0U+LCKMGUSx8RMJOkkJOakWUAIRLRpdmCoJrBserqv+E6AVAQEA==
X-Received: by 2002:a17:903:120f:b0:188:82fc:e259 with SMTP id l15-20020a170903120f00b0018882fce259mr18758217plh.61.1668102813812;
        Thu, 10 Nov 2022 09:53:33 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id i13-20020a170902c94d00b00172e19c5f8bsm11666966pla.168.2022.11.10.09.53.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 09:53:33 -0800 (PST)
Date:   Thu, 10 Nov 2022 17:53:29 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Chao Peng <chao.p.peng@linux.intel.com>
Cc:     Fuad Tabba <tabba@google.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-api@vger.kernel.org, linux-doc@vger.kernel.org,
        qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Hugh Dickins <hughd@google.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Steven Price <steven.price@arm.com>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vishal Annapurve <vannapurve@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        luto@kernel.org, jun.nakajima@intel.com, dave.hansen@intel.com,
        ak@linux.intel.com, david@redhat.com, aarcange@redhat.com,
        ddutile@redhat.com, dhildenb@redhat.com,
        Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com,
        Muchun Song <songmuchun@bytedance.com>, wei.w.wang@intel.com
Subject: Re: [PATCH v9 4/8] KVM: Use gfn instead of hva for mmu_notifier_retry
Message-ID: <Y206mVuJlXjO10qx@google.com>
References: <20221025151344.3784230-1-chao.p.peng@linux.intel.com>
 <20221025151344.3784230-5-chao.p.peng@linux.intel.com>
 <CA+EHjTySnJTuLB+XoRya6kS_zw2iMahW9-Ze70oKTf+6k0GrGQ@mail.gmail.com>
 <20221104022813.GA4129873@chaop.bj.intel.com>
 <Y2WSXLtcJOpWPtuv@google.com>
 <20221108071624.GA76278@chaop.bj.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221108071624.GA76278@chaop.bj.intel.com>
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

On Tue, Nov 08, 2022, Chao Peng wrote:
> On Fri, Nov 04, 2022 at 10:29:48PM +0000, Sean Christopherson wrote:
> > The APICv case that this was added for could very well be broken because of
> > this, and the resulting failures would be an absolute nightmare to debug.
> 
> Given the apicv_inhibit should be rare, the change looks good to me.
> Just to be clear, your will send out this fix, right?

Ya, I'll post an official patch.
