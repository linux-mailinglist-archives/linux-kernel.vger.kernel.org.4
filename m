Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E858C67D81E
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 23:01:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbjAZWBt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 17:01:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231490AbjAZWBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 17:01:47 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C4956BBCE
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 14:01:46 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id t12-20020a17090aae0c00b00229f4cff534so6748101pjq.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 14:01:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5JbhjLtl1lcS3CAhxrq5yfKZFfaH2pnSCNdns3oouJU=;
        b=Q6o4bwROJ1kEixGJhUp0jqak9FsRexuHEWJB31REAWu+8yFk0Z/nylWHAMza2ORvw/
         ZVv96n0hUrKl0qOeoOLF1G/kFrDFQjLxhap4278oZhDrMQE6s5RX0S3cfvTS7zd3xzFw
         hGkqVr5qrw/dXSOqvq6RqqbwJjiq45dSI4B2M8WOrKS6ic4mutYoL4uPlTaCevulaVEk
         +NB3nQTyVh9iHcEYuE7nmEo+2xxSmSWlwp4zCLW2JLsm9zqHf6TsbJI2xmbjveJXXj3M
         fnYwobI0oia6T6FqjmIsdbJrfyH2Kk/wLLELWlLNLdpWh/kFkrOB0jsyeMFp1bL1hZNe
         xn8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5JbhjLtl1lcS3CAhxrq5yfKZFfaH2pnSCNdns3oouJU=;
        b=0kd8Cf6ehu5IyxsbeiUDo/aMl6fRvWqsvIYEi79diDdzp9HAxydmez5tglT0jg8ame
         P/l8YcoMFD3xylwm5gS19V/z09fuHmzv4wHyE4Ae5a4VJofiF2kIu5J2bp9wnri+8PX7
         ayDSh226+0uaWyOiwBXnAbm40szegtmZlh9VO1ZNOUJq0vH3K1Zy3egvuEDrSDWz+Umr
         Bb7zRWeXrKBj/IZyZfWnSY7fc0+FSw7oJZKHkbLwmJG4/oaDwjq6k2LInQb9H7KajDUC
         xFD1fcRhGoN4tbC2gW401US+HQsfdPOynql3JiWnHvXWF2H3gWDcWBxgIBUXCfKRy6Zj
         US/Q==
X-Gm-Message-State: AO0yUKXbOJUxoiRmnOnhESIIhop3gEnsSU1ESoxQ5HdkQW5qCySRPJzE
        d3sRk2Y8otrkejTJhRPDX71bnoE7Gpxa3yMprt4=
X-Google-Smtp-Source: AK7set8tT2B/+o6HazEeWoCdSUXhCPVyrNgyq7+ZObjca9q8KDKZecctFwPiXh//NeBg9EXpFDM/pw==
X-Received: by 2002:a05:6a20:4c08:b0:a4:efde:2ed8 with SMTP id fm8-20020a056a204c0800b000a4efde2ed8mr1211129pzb.0.1674770505875;
        Thu, 26 Jan 2023 14:01:45 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id nm16-20020a17090b19d000b0022c0622cc16sm3824842pjb.54.2023.01.26.14.01.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 14:01:45 -0800 (PST)
Date:   Thu, 26 Jan 2023 22:01:41 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     "Huang, Kai" <kai.huang@intel.com>
Cc:     "zhi.wang.linux@gmail.com" <zhi.wang.linux@gmail.com>,
        "sean.j.christopherson@intel.com" <sean.j.christopherson@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Shahar, Sagi" <sagis@google.com>,
        "isaku.yamahata@gmail.com" <isaku.yamahata@gmail.com>,
        "Aktas, Erdem" <erdemaktas@google.com>,
        "dmatlack@google.com" <dmatlack@google.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "Yamahata, Isaku" <isaku.yamahata@intel.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>
Subject: Re: [PATCH v11 030/113] KVM: x86/mmu: Replace hardcoded value 0 for
 the initial value for SPTE
Message-ID: <Y9L4RQXuTJ4RTVcF@google.com>
References: <cover.1673539699.git.isaku.yamahata@intel.com>
 <dee30f0562d8be0102547d8eb9fc77736eae679d.1673539699.git.isaku.yamahata@intel.com>
 <20230125112434.0000512a@gmail.com>
 <Y9Fj/vgPEzfU1eof@google.com>
 <0be55c001aa1a538a02055aa244c655262228ce4.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0be55c001aa1a538a02055aa244c655262228ce4.camel@intel.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 26, 2023, Huang, Kai wrote:
> On Wed, 2023-01-25 at 17:22 +0000, Sean Christopherson wrote:
> > I agree that handling this in the common code would be cleaner, but repurposing
> > gfp_zero gets kludgy because it would require a magic value to say "don't initialize
> > the data", e.g. x86's mmu_shadowed_info_cache isn't pre-filled.

...

> > @@ -400,6 +405,13 @@ int __kvm_mmu_topup_memory_cache(struct kvm_mmu_memory_cache *mc, int capacity,
> >  		if (WARN_ON_ONCE(!capacity))
> >  			return -EIO;
> >  
> > +		/*
> > +		 * Custom init values can be used only for page allocations,
> > +		 * and obviously conflict with __GFP_ZERO.
> > +		 */
> > +		if (WARN_ON_ONCE(mc->init_value && (mc->kmem_cache || mc->gfp_zero)))
> > +			return -EIO;
> > +
> >  		mc->objects = kvmalloc_array(sizeof(void *), capacity, gfp);
> >  		if (!mc->objects)
> >  			return -ENOMEM;
> > 
> > base-commit: 503f0315c97739d3f8e645c500d81757dfbf76be
> 
> init_value and gfp_zone is kinda redundant.  How about removing gfp_zero
> completely?
> 
> 	mmu_memory_cache_alloc_obj(...)
> 	{
> 		...
> 		if (!mc->init_value)
> 			gfp_flags |= __GFP_ZERO;
> 		...
> 	}
> 
> And in kvm_mmu_create() you initialize all caches' init_value explicitly.

No, as mentioned above there's also a "don't initialize the data" case.  Leaving
init_value=0 means those users would see unnecessary zeroing, and again I don't
want to use a magic value to say "don't initialize".
