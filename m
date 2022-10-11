Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 742495FBB7A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 21:45:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbiJKTpQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 15:45:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbiJKTpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 15:45:11 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99C5813F06
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 12:45:10 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id h10so14211310plb.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 12:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GVtoJncJvV9JbwcQybBBO15fdWkH5vLrkghv2pFNTkI=;
        b=bFMI0t0d0c0x8fZOIqrKH5+f4GC5xQgxqaLDAhlbX64NX4v1AlFdkaKR6Hy4QXd6F7
         kZLADu3iVAuRv9qTNKKwh3I13f5ADzdPlYHZOSw8J8eHCY82L9HO1d6EivoJoD756VbS
         4RybUFSki1prXgenm2m/sRVjoBMYGPvozPpXWLKJ37C1e6/DH/PvN5vX3FDE+YgdqHFR
         LP0hCp4So2ZYfTPWtuj4iYmw+6BMz+93UuCfM9L6Sub08LxCmE+vu2Rej+ZSd/acvy1/
         F6g5G13XILplUcOAp/9QhD3PYy1m31RpLjWmLkQw52hyYLiJK//csS3brmVE6Eot8few
         6GZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GVtoJncJvV9JbwcQybBBO15fdWkH5vLrkghv2pFNTkI=;
        b=q4STYStCNnHpxe6ybqY0GodsSaT2DBFFnAV2fpSafu3aLd5iatf5AhLRCuv9K0HzV4
         6cNURWf17C3k6GS2ZIbdBjkdFtXB4EkjkpjjwWV1bFzYRFqkDYpEAaOmZkOmEysQIZUw
         Uf1Bign1g45181vtH6n2EyP6XIwYhmb4gAm07GO9kj15E3ooKYBnrnG0VEydInLtHxX9
         8H/n9QSf1O+Ypit2hi0AmySnP9cn1co6FYOrltep7mKSh21XKwJX0DZAcDx1oK7TcEJR
         IQlEhG/sYb8+hUVFqytfS98xAPBIcHfRSUthkbiecpcyLHuB7s+MCrPW0zv3VERDm/7U
         jZUg==
X-Gm-Message-State: ACrzQf3BOpo0yMngEhSKZCYCNgrtR9uGGxbM4rOFYepfBp/KuYA6NS9X
        A+B473EWBIiOLuTTkEEj6thIJPilYE7/NQ==
X-Google-Smtp-Source: AMsMyM4BKa4VjUZWkwtVUZAmzVt1d2Ff1emeOLllGAimkQcZ/oFrcNT/6umHLZU5hcBDv09Ah+SH8Q==
X-Received: by 2002:a17:90b:4c87:b0:20b:4ace:485e with SMTP id my7-20020a17090b4c8700b0020b4ace485emr832778pjb.167.1665517509799;
        Tue, 11 Oct 2022 12:45:09 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id r3-20020a63ce43000000b0042b5095b7b4sm8297337pgi.5.2022.10.11.12.45.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 12:45:09 -0700 (PDT)
Date:   Tue, 11 Oct 2022 19:45:06 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Carlos Bilbao <carlos.bilbao@amd.com>
Cc:     pbonzini@redhat.com, vkuznets@redhat.com, wanpengli@tencent.com,
        jmattson@google.com, joro@8bytes.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, bilbao@vt.edu
Subject: Re: [PATCH] KVM: SEV: Fix a few small typos
Message-ID: <Y0XHwmNDJj68pKp5@google.com>
References: <20220928173142.2935674-1-carlos.bilbao@amd.com>
 <Y0W7J9+2P2u83EaD@google.com>
 <515927f6-a53e-519e-6d7b-80f26f6f8946@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <515927f6-a53e-519e-6d7b-80f26f6f8946@amd.com>
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

On Tue, Oct 11, 2022, Carlos Bilbao wrote:
> On 10/11/22 13:51, Sean Christopherson wrote:
> 
> > On Wed, Sep 28, 2022, Carlos Bilbao wrote:
> > > @@ -3510,7 +3510,7 @@ bool sev_snp_init_protected_guest_state(struct kvm_vcpu *vcpu)
> > >   	ret = __sev_snp_update_protected_guest_state(vcpu);
> > >   	if (ret)
> > > -		vcpu_unimpl(vcpu, "snp: AP state update on init failed\n");
> > > +		vcpu_unimpl(vcpu, "SNP: AP state update on init failed\n");
> > >   unlock:
> > >   	mutex_unlock(&svm->snp_vmsa_mutex);
> > > @@ -4170,7 +4170,7 @@ void sev_es_prepare_guest_switch(struct vcpu_svm *svm, unsigned int cpu)
> > >   	/* PKRU is restored on VMEXIT, save the current host value */
> > >   	hostsa->pkru = read_pkru();
> > > -	/* MSR_IA32_XSS is restored on VMEXIT, save the currnet host value */
> > > +	/* MSR_IA32_XSS is restored on VMEXIT, save the current host value */
> > >   	hostsa->xss = host_xss;
> > >   }
> > > @@ -4223,7 +4223,7 @@ struct page *snp_safe_alloc_page(struct kvm_vcpu *vcpu)
> > >   	 * Allocate an SNP safe page to workaround the SNP erratum where
> > >   	 * the CPU will incorrectly signal an RMP violation  #PF if a
> > >   	 * hugepage (2mb or 1gb) collides with the RMP entry of VMCB, VMSA
> > > -	 * or AVIC backing page. The recommeded workaround is to not use the
> > > +	 * or AVIC backing page. The recommended workaround is to not use the
> > >   	 * hugepage.
> > >   	 *
> > >   	 * Allocate one extra page, use a page which is not 2mb aligned
> > SNP support doesn't exist upstream, looks like this was generated against an SNP
> > branch.
> You're absolutely right. The only typo that's upstream is "currnet" in
> sev_es_prepare_switch_to_guest(). Not a big deal.

Ya, and that typo should (eventually) go away entirely:
https://lore.kernel.org/all/YzOTOzUzKPQSqURo@google.com

