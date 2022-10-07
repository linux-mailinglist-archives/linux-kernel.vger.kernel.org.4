Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FE595F7A2D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 16:59:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbiJGO7Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 10:59:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbiJGO7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 10:59:03 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BAD8DD8B2
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 07:58:59 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id gf8so4618458pjb.5
        for <linux-kernel@vger.kernel.org>; Fri, 07 Oct 2022 07:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ApS1gjiguDXZcZz0fMT7VsMAGGvTEXNN7etXS65aF2E=;
        b=P9at1gy00LaQ67U9E1PqFxXj/+/Ep5lZ2MxNKcytXi47pMqLiyWzEa/Xe2j6FHWM4y
         /hs7KujqnFNPAE3jZS5MWMfe3+xQAhIhJuW1dyoA1ekhjNaxULNBuqb/2klgeUPGWkYF
         5S5WGPJDOLGI8G3dhBrFVznCIwrT7f7u07MoT7kQCn0HddgT1cP9+6D1aAApMjbGxIQJ
         KQ5lGGS71MMnAnQJ7FClUslBS7YWByNlLuUfhv2PRp7+0dcRnApGUnnJxK061ld3oLrF
         aqw3+neqPNcUW0v6HArS65p+1L4Mc4p5Eyi3bOlG00rA6Ll3S9qG/ECPlhkMQusT3cha
         xF/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ApS1gjiguDXZcZz0fMT7VsMAGGvTEXNN7etXS65aF2E=;
        b=Bb//JkaBHW5ew2coVisc3tkPk6dPTc5eNqYEgVsTts9MXX+eVcBR3QoyN/DnTrjdeH
         cggKT8154eG7K29msm629o0u10RzBk1oaMS/OlXNFKRlXX7o0vbCqcnJqD5KSwKHF2vP
         NY6X8RtBIlF7zQvduIM1DcPkeKawZMVSFdABFvPfwjl9nIdggVQLgKB2dkUIVrW5EbMA
         QgcmQ3kP7rReg9ebJVN2ZFLugpCb8Qoh6A53vLHGriHzI8F0IGW5pLJK9yqTRSQ8Zu9U
         1+WcltWcAexeYutcBemsoyNlKVCBz9icX0ft3GbmqXHiZALkzVK9bm6nDOMw3W5t/sOk
         F82Q==
X-Gm-Message-State: ACrzQf0EksB7yvxxOhMyO6UepmlLOGywnV9B3QblycOmdaCPD2ke9Pag
        CoHPZwkH9+hdAaXFsLwJNAXIqA==
X-Google-Smtp-Source: AMsMyM642quwEQBN0ZX14M9u9coJDsTKuGQ1cCzLKA6Dq2TZW06v6vpj0wGS9syx5rD7OWwlzHZvqw==
X-Received: by 2002:a17:90b:3ec1:b0:202:f490:e508 with SMTP id rm1-20020a17090b3ec100b00202f490e508mr5980841pjb.156.1665154738493;
        Fri, 07 Oct 2022 07:58:58 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id m22-20020a63ed56000000b0043a0de69c94sm1750587pgk.14.2022.10.07.07.58.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Oct 2022 07:58:57 -0700 (PDT)
Date:   Fri, 7 Oct 2022 14:58:54 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Chao Peng <chao.p.peng@linux.intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org, qemu-devel@nongnu.org,
        Paolo Bonzini <pbonzini@redhat.com>,
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
Subject: Re: [PATCH v8 2/8] KVM: Extend the memslot to support fd-based
 private memory
Message-ID: <Y0A+rogB6TRDtbyE@google.com>
References: <20220915142913.2213336-1-chao.p.peng@linux.intel.com>
 <20220915142913.2213336-3-chao.p.peng@linux.intel.com>
 <Yz7s+JIexAHJm5dc@kernel.org>
 <Yz7vHXZmU3EpmI0j@kernel.org>
 <Yz71ogila0mSHxxJ@google.com>
 <Y0AJ++m/TxoscOZg@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y0AJ++m/TxoscOZg@kernel.org>
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

On Fri, Oct 07, 2022, Jarkko Sakkinen wrote:
> On Thu, Oct 06, 2022 at 03:34:58PM +0000, Sean Christopherson wrote:
> > On Thu, Oct 06, 2022, Jarkko Sakkinen wrote:
> > > On Thu, Oct 06, 2022 at 05:58:03PM +0300, Jarkko Sakkinen wrote:
> > > > On Thu, Sep 15, 2022 at 10:29:07PM +0800, Chao Peng wrote:
> > > > > This new extension, indicated by the new flag KVM_MEM_PRIVATE, adds two
> > > > > additional KVM memslot fields private_fd/private_offset to allow
> > > > > userspace to specify that guest private memory provided from the
> > > > > private_fd and guest_phys_addr mapped at the private_offset of the
> > > > > private_fd, spanning a range of memory_size.
> > > > > 
> > > > > The extended memslot can still have the userspace_addr(hva). When use, a
> > > > > single memslot can maintain both private memory through private
> > > > > fd(private_fd/private_offset) and shared memory through
> > > > > hva(userspace_addr). Whether the private or shared part is visible to
> > > > > guest is maintained by other KVM code.
> > > > 
> > > > What is anyway the appeal of private_offset field, instead of having just
> > > > 1:1 association between regions and files, i.e. one memfd per region?
> > 
> > Modifying memslots is slow, both in KVM and in QEMU (not sure about Google's VMM).
> > E.g. if a vCPU converts a single page, it will be forced to wait until all other
> > vCPUs drop SRCU, which can have severe latency spikes, e.g. if KVM is faulting in
> > memory.  KVM's memslot updates also hold a mutex for the entire duration of the
> > update, i.e. conversions on different vCPUs would be fully serialized, exacerbating
> > the SRCU problem.
> > 
> > KVM also has historical baggage where it "needs" to zap _all_ SPTEs when any
> > memslot is deleted.
> > 
> > Taking both a private_fd and a shared userspace address allows userspace to convert
> > between private and shared without having to manipulate memslots.
> 
> Right, this was really good explanation, thank you.
> 
> Still wondering could this possibly work (or not):
> 
> 1. Union userspace_addr and private_fd.

No, because userspace needs to be able to provide both userspace_addr (shared
memory) and private_fd (private memory) for a single memslot.

> 2. Instead of introducing private_offset, use guest_phys_addr as the
>    offset.

No, because that would force userspace to use a single private_fd for all of guest
memory since it effectively means private_offset=0.  And userspace couldn't skip
over holes in guest memory, i.e. the size of the memfd would need to follow the
max guest gpa.  In other words, dropping private_offset could work, but it'd be
quite kludgy and not worth saving 8 bytes.
