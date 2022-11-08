Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22BFE621C6D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 19:50:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbiKHSuI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 13:50:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiKHSts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 13:49:48 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1DE568284
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 10:48:50 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id f63so14160889pgc.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 10:48:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1L5kOZNHYfCA3IRYVLUmKIQqOspk+Yz3BJ9Q+3CIhRs=;
        b=W78BfCdzW3rFNxBBa9CJ99fIOIknqSWEHZQpGE4CP0gnNR+4VJ+1rYb8sEs0NBsASe
         K4rEBjnnoCJk0a33aTy3cf9rfMp4VkUTZPwynhqWc6xUvWZh5c7hCT/NquaGP8tWiAmk
         hcNg7xenoISlUZ3pmp4wYxBJpQOoNNtgg3hIJ2CWRKxb7/HZIa1PVdjWFm4ksV+cIxq8
         YrF3aINsofbWuXc8co8smgqZQglTdPK9ATlmu723Lc7vcDYFsIrqGa+4SDMwuJYOSwOW
         VL0XN5QRJNpA74ovJB+2axjmbYlMF5U+hQWpwC53WgZLq2bVPa2W9STH+x/xfs2jlapp
         IPrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1L5kOZNHYfCA3IRYVLUmKIQqOspk+Yz3BJ9Q+3CIhRs=;
        b=mz5nvYRSkoD7sHNS55pyOX7CYLBmeXiauClBl+nRYQZzJSyZP/oPD8rAr0zBpC1dvm
         dprh42bmmKeDodb8WNZvltW7i2PL39RcIjchbJ7NW42dUtNe2Tws/OOAlQm4pCPMpjXj
         b2k4aOwpJE2dwTKjzetadi9zUP9cT1sq8R9kTBDExoA12qVhc3VvOtTz8ndfo7ZUgbQB
         rriAbTKLT23xLZ1olXS32JNdT0KXmZfBIu9Hkqn3O/eA7s0agcEIEz/1n+MtEXUHCOpq
         Qz5/eH62ko4lFz2gNR8qWkwOdeC9LTRxxO/l5zBvU7outMxyf4/Q3FO7SYtV7n4g3cK2
         9h5Q==
X-Gm-Message-State: ACrzQf1aNDctDF4xgw1rGsIt9ImdmRWWlqKLdufo6KKymgUJzh9Mm2oo
        kY9DTRAAZ2el/NpS2iGpf0riRg==
X-Google-Smtp-Source: AMsMyM5S9PjQE+J86OOSmzTz+w8ShiglmFoLAyopqlYc5Iemshl9f9rh9AOUnKWCV3mF3rIgtAIvgw==
X-Received: by 2002:a05:6a00:1a44:b0:528:6af7:ff4a with SMTP id h4-20020a056a001a4400b005286af7ff4amr57736839pfv.78.1667933330266;
        Tue, 08 Nov 2022 10:48:50 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id e13-20020a17090301cd00b0018855a22ccfsm7325722plh.91.2022.11.08.10.48.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 10:48:49 -0800 (PST)
Date:   Tue, 8 Nov 2022 18:48:46 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     "Huang, Kai" <kai.huang@intel.com>
Cc:     "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Yamahata, Isaku" <isaku.yamahata@intel.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "Shahar, Sagi" <sagis@google.com>,
        "Aktas, Erdem" <erdemaktas@google.com>,
        "isaku.yamahata@gmail.com" <isaku.yamahata@gmail.com>,
        "dmatlack@google.com" <dmatlack@google.com>
Subject: Re: [PATCH v10 005/108] KVM: TDX: Initialize the TDX module when
 loading the KVM intel kernel module
Message-ID: <Y2qkjnpZsWEFBe6G@google.com>
References: <cover.1667110240.git.isaku.yamahata@intel.com>
 <99e5fcf2a7127347816982355fd4141ee1038a54.1667110240.git.isaku.yamahata@intel.com>
 <0feaa13fa5bf45258f2ebb8407eaefadf5c48976.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0feaa13fa5bf45258f2ebb8407eaefadf5c48976.camel@intel.com>
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

On Tue, Nov 08, 2022, Huang, Kai wrote:
> > +int __init tdx_hardware_setup(struct kvm_x86_ops *x86_ops)
> > +{
> > +	int r;
> > +
> > +	if (!enable_ept) {
> > +		pr_warn("Cannot enable TDX with EPT disabled\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	/* MOVDIR64B instruction is needed. */
> > +	if (!static_cpu_has(X86_FEATURE_MOVDIR64B)) {

Nit unrelated to Kai's comments: use boot_cpu_has(), not static_cpu_has().  This
is run-once code that's not a hot path so there's zero reason to trigger patching.

> > +		pr_warn("Cannot enable TDX with MOVDIR64B supported ");
> 					   ^
> 					   without
> > +		return -ENODEV;
> > +	}
> 
> I think you should explain why MOVDIR64B is required, otherwise this just comes
> out of blue.
> 
> Btw, is this absolutely required?  TDX also supports Li-mode, which doesn't have
> integrity check.  So theoretically with Li-mode, normal zeroing is also OK but
> doesn't need to use MOVDIR64B.
> 
> That being said, do we have a way to tell whether TDX works in Ci or Li mode?
> 
> 
> 
