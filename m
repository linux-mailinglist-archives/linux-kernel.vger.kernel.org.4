Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 821DE65F382
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 19:10:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235180AbjAESKT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 13:10:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235333AbjAESKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 13:10:03 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47C99391
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 10:10:02 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id 17so40195897pll.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 10:10:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Hci7kuPmp0G+r8pqabU4lcvicEVVbwT1Q+T1O/951Ik=;
        b=aTE8qGtOVzAikGJA9toY6kjjg2uoj06K5DnWBCQhRXgtn60cD8mJHx8PxBXYEiHmGO
         zWoHWI+04AnGc1rHfoUVUL8N0fiJInDMHJqnrthvewFe5zJO63jB6bPlO6vW/jbAfW+T
         22GVVoBYFCeskjVZtGDwzqhU8RaPnPmkctUjSEJzvZLEZR67HOa2BGdu0aM2osyX7HK1
         R/RHrLrGQ0kY1xgKreeCjZehRMNjdBHx6Uuy8pgNHmYmJETn9V4X/ium2fBexm3zbzZx
         Ouc3wb3a6eS6ZXdhKQZ3Li7muv0FKFmXbwxNRAyaOFPeFHMXSYfBoimA7cv2V+pjj4RY
         4YJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hci7kuPmp0G+r8pqabU4lcvicEVVbwT1Q+T1O/951Ik=;
        b=jYJXX9yntt2ea3m85heZLuG+1GmNZMFgtlO1sGARz9PNAIRvAGQqif+oy6ZB4jX4A6
         06Lfwxc65vhIKKuBFxkzBBB+a4cWsOqs2oUCtUnWO6pHyUWkK5Om6j2jrZa1yGLUgMeB
         tSzps9OMqFcA5pMqUW+MT/ma1Le/QwSfelGX0R0k0kCsHXg2JgZesQ9M9TPnGReaxeao
         77EgxHqdmXQF17cJrGn8Id3e+HsjLhTNTby439baDTh9YIAuLaeBicgubgp4hxOWDiiw
         ART7ubFgJ8Lpp+vJcUAWAXgYiNz4X35Dae3eOQR2XHqGqikVCjptLqtMCxnpMR/2lsi1
         yQpQ==
X-Gm-Message-State: AFqh2krDfaaAr8ZtmPdAomEqc7VdRqjnh5uKv4lrVAv4yrq0lrB8BJOj
        q6JgmDhTtgo63hIFh+Ya+MHlwA==
X-Google-Smtp-Source: AMrXdXvGLvHWpmbZbBkUu0IqU9CeD0PZablWiW3ohh1nTJfCtiAOgsk0DPUFxWhP5FUEx8AsYHdYxw==
X-Received: by 2002:a17:902:c385:b0:192:8a1e:9bc7 with SMTP id g5-20020a170902c38500b001928a1e9bc7mr3874plg.0.1672942201683;
        Thu, 05 Jan 2023 10:10:01 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id j7-20020a170902da8700b0018980f14940sm26262102plx.178.2023.01.05.10.10.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 10:10:01 -0800 (PST)
Date:   Thu, 5 Jan 2023 18:09:57 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Paul Durrant <xadimgnik@gmail.com>
Cc:     Paul Durrant <pdurrant@amazon.com>, x86@kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH v6 1/2] KVM: x86/cpuid: generalize
 kvm_update_kvm_cpuid_base() and also capture limit
Message-ID: <Y7cSdYWX8e3FqlrO@google.com>
References: <20221220134053.15591-1-pdurrant@amazon.com>
 <20221220134053.15591-2-pdurrant@amazon.com>
 <Y7XU2R0f3pCYF9uz@google.com>
 <82fbc53e-be3e-b516-2420-dc27e5b811e8@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <82fbc53e-be3e-b516-2420-dc27e5b811e8@gmail.com>
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

On Thu, Jan 05, 2023, Paul Durrant wrote:
> On 04/01/2023 19:34, Sean Christopherson wrote:
> > Since the struct is a 64-bit value, what about making this a pure getter that
> > returns a copy?
> > 
> > static struct kvm_hypervisor_cpuid kvm_get_hypervisor_cpuid(struct kvm_vcpu *vcpu,
> > 							    const char *sig)
> > {
> > 	struct kvm_hypervisor_cpuid cpuid = {};
> > 	struct kvm_cpuid_entry2 *entry;
> > 	u32 function;
> > 
> > 	for_each_possible_hypervisor_cpuid_base(cpuid.base) {
> > 		entry = kvm_find_cpuid_entry(vcpu, function);
> > 
> > 		if (entry) {
> > 			u32 signature[3];
> > 
> > 			signature[0] = entry->ebx;
> > 			signature[1] = entry->ecx;
> > 			signature[2] = entry->edx;
> > 
> > 			if (!memcmp(signature, sig, sizeof(signature))) {
> > 				cpuid.base = function;
> > 				cpuid.limit = entry->eax;
> > 				break;
> > 			}
> > 		}
> > 	}
> > 
> > 	return cpuid;
> > }
> > 
> > 
> > 	vcpu->arch.kvm_cpuid = kvm_get_hypervisor_cpuid(vcpu, KVM_SIGNATURE);
> > 	vcpu->arch.xen.cpuid = kvm_get_hypervisor_cpuid(vcpu, XEN_SIGNATURE);
> 
> Yes, if that's preferable then no problem.

I like it (obviously), but it's probably worth waiting a few days to see what
others think before posting a new version.
