Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67D90692355
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 17:31:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232809AbjBJQbt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 11:31:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232057AbjBJQbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 11:31:47 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF0DA78D7E
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 08:31:28 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id a8-20020a17090a6d8800b002336b48f653so4286570pjk.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 08:31:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PVusSlIKfQbaGKDXyoB0p+8SehGAokMm2VtMejZUsGU=;
        b=hBSSDGTNRw/CYZ3HbllAF7nwMzqIHVooWkhIzckaJJdqoIWydhl/vIZyQThiVDa6zm
         LWOVmJzyMBI8a8jCDJk+Sy1ZVVI/X5BUxqW+6W2WmydS9b86VRApFkcVh6RFmc+L1K/4
         Gpj20ORe1PthOjGM24gq5xi2yhHhJQoA4zMJ2gAlqNnAJl1pFJ/dg+BTo1soZDxuyFAd
         AjGAjeYLhzFQZoMS0nbz8bWUi8kdZnAJwZLMITqsytQNmIrmOUxYKEhdauNdgDkCyhAW
         u7HrVV+ZnyQOjcMFqEHApyOLMwSH7G57wx0hpNA/9AB6rK+PSdFnbmP7C9wPbQQGb9e5
         ufSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PVusSlIKfQbaGKDXyoB0p+8SehGAokMm2VtMejZUsGU=;
        b=baKud/JHehpD2iiWKRmlfTLc+iWTIwee4ynIWZ2o9COo07wZp7m6IETVvJ3WgWoDao
         loC0ibkU5XYrhvZgqASlqNLpjtpU4a8Xt2Iq8px3/yRPsUXu/KqWZ3Ub42jZtqNVaP9W
         /1WMbhStSw5B2V7Tt5YrKKnafb7WQKUMPKh+ZpM7GNcDYLfPkYRMLjFlU1ZwCzYih9br
         chMGBiAnhCWBFIV8zQQUe54mtENyqmlbEjInM3+kxTpvp8pG8eyXA9zSmd+vpJrsiaKW
         zaRhycnAxpK9jXYJ0yQBRSFsgz0g+DOCBpaefknNdeQgSdv4BEeCn9jEj+JH34I3z2WB
         30eg==
X-Gm-Message-State: AO0yUKXc4b/Don6aAoVxdgySt/hq42gqhBRoXhK/e4a+TirukG1qzmuF
        E4U1803ml1Pa9SAaWYodRPD9IRUZ7aAE3nX7cVY=
X-Google-Smtp-Source: AK7set+qEyYRdUOwJYNfGzt6ZWjlIyIA+Gd8mNw1wMSEAQhF51IwCWqu8JgzXbfqSTzJOC8dalerGw==
X-Received: by 2002:a17:902:700b:b0:192:8a1e:9bc7 with SMTP id y11-20020a170902700b00b001928a1e9bc7mr268716plk.0.1676046688153;
        Fri, 10 Feb 2023 08:31:28 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id c7-20020a17090a674700b00230befd3b2csm5409098pjm.6.2023.02.10.08.31.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Feb 2023 08:31:27 -0800 (PST)
Date:   Fri, 10 Feb 2023 16:31:24 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Yu Zhang <yu.c.zhang@linux.intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xiaoyao Li <xiaoyao.li@intel.com>,
        Like Xu <like.xu.linux@gmail.com>
Subject: Re: [PATCH v2 05/21] KVM: x86: Disallow writes to immutable feature
 MSRs after KVM_RUN
Message-ID: <Y+ZxXJa0nMIg/f32@google.com>
References: <20230210003148.2646712-1-seanjc@google.com>
 <20230210003148.2646712-6-seanjc@google.com>
 <20230210130115.che6rqfckwt7fzqp@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230210130115.che6rqfckwt7fzqp@linux.intel.com>
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

On Fri, Feb 10, 2023, Yu Zhang wrote:
> On Fri, Feb 10, 2023 at 12:31:32AM +0000, Sean Christopherson wrote:
> > @@ -2168,6 +2187,23 @@ static int do_get_msr(struct kvm_vcpu *vcpu, unsigned index, u64 *data)
> >  
> >  static int do_set_msr(struct kvm_vcpu *vcpu, unsigned index, u64 *data)
> >  {
> > +	u64 val;
> > +
> > +	/*
> > +	 * Disallow writes to immutable feature MSRs after KVM_RUN.  KVM does
> > +	 * not support modifying the guest vCPU model on the fly, e.g. changing
> > +	 * the nVMX capabilities while L2 is running is nonsensical.  Ignore
> > +	 * writes of the same value, e.g. to allow userspace to blindly stuff
> > +	 * all MSRs when emulating RESET.
> > +	 */
> > +	if (vcpu->arch.last_vmentry_cpu != -1 &&
> 
> Use kvm_vcpu_has_run(vcpu) here? 

/facepalm

Yes, that was the entire point of adding the helper.

Thanks!
