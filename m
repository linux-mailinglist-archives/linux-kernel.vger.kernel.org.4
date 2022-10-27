Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DA4960FAE5
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 16:55:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235965AbiJ0OzL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 10:55:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235945AbiJ0OzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 10:55:01 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C788F30544
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 07:54:59 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id m6so1826719pfb.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 07:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kPYnXX3okow1kRCKteMrz1kZILFzqyga2dfyqPNexuw=;
        b=cEfkDhbsG3tWzlruT2T+yhVrvDC0e4ykbkS6TUSvMJMueQ6BVIDiPTsqqcYZtsTc+8
         LrYzP001ez9kpMJ/QQd4Gu+VMdkTELU1EMtFejqQc/LP9szyilchAjELqL/mwXd8ndzw
         fywoH45H9zctKGaXnyld1myb4JXGwSCqPQYXLXtMcFJYgtPD5EdFILCHZgFvPMCs4Uow
         +CVTppidf6VdXwZikxsTU+BJ+3ezaYvp6t/gSF/OTniNM53VRtW/XuAZ1+wZLTDliLEV
         oqhC5aYEj4e5JZFE6h8T/Rq2k9QV3HQwEqmq84tVGXIDG3D9shf5SWJICcQjADFliAMU
         lhKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kPYnXX3okow1kRCKteMrz1kZILFzqyga2dfyqPNexuw=;
        b=64AOm3nGqPHoZvdiQ9bNFpGG5BYKoFYbjhwfjQL3SnCRmgVwjQ6sVRpBb/71PUqW53
         SCfM03KWoVdaGPpc31AEBbZeWvbQGifgcBZKgVnFXA1AtLs7igWf6GfuQBitSt58znLW
         2+oGBcEGaxds/mX7u1MouhSyiamGdhPh4xJE6f1PVuYWyzL0xxaXDJspEpgOCznSXvof
         slk5zXAvH9ETuAQEnbIsDYmD+JXyC37LwsU54eYrD7ADrRxL7slCqXw/+zFuz78e4QIC
         z/P85frhB/uk7cdgZJQLuNFiO3kGAPye3rG32T7BXBJ21VI960j4Ny2E2SEiVaWxrv1z
         pcpQ==
X-Gm-Message-State: ACrzQf37xnkteEHbZD2ciDQOsQi3UgpqWocxd5MUSIrDb4/5OzUFTN09
        ilYdA7KGIPiCHWS6i0WpF9Fmcw==
X-Google-Smtp-Source: AMsMyM77yVvmwPODxDgAB3imONWVBFbWeOxtNYJsvGc7QT0gYGTWB6Y7DO0uZ0fKfEYkiUdl/H/obw==
X-Received: by 2002:a63:c112:0:b0:443:94a1:f09 with SMTP id w18-20020a63c112000000b0044394a10f09mr42823906pgf.396.1666882499230;
        Thu, 27 Oct 2022 07:54:59 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id 5-20020a170902e9c500b0018691ce1696sm1310297plk.131.2022.10.27.07.54.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 07:54:58 -0700 (PDT)
Date:   Thu, 27 Oct 2022 14:54:55 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     "Wang, Wei W" <wei.w.wang@intel.com>
Cc:     "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "dmatlack@google.com" <dmatlack@google.com>,
        "vipinsh@google.com" <vipinsh@google.com>,
        "ajones@ventanamicro.com" <ajones@ventanamicro.com>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 03/18] KVM: selftests/kvm_util: helper functions for
 vcpus and threads
Message-ID: <Y1qbv/HdkuILzNSa@google.com>
References: <20221024113445.1022147-1-wei.w.wang@intel.com>
 <20221024113445.1022147-4-wei.w.wang@intel.com>
 <Y1nMQp11RKTDX7HX@google.com>
 <DS0PR11MB6373FBC16E8515174E444692DC339@DS0PR11MB6373.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DS0PR11MB6373FBC16E8515174E444692DC339@DS0PR11MB6373.namprd11.prod.outlook.com>
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

On Thu, Oct 27, 2022, Wang, Wei W wrote:
> On Thursday, October 27, 2022 8:10 AM, Sean Christopherson wrote:
> > > +void vm_vcpu_threads_create(struct kvm_vm *vm,
> > > +		void *(*start_routine)(void *), uint32_t private_data_size)
> > 
> > I vote (very strongly) to not deal with allocating private data.  The private data
> > isn't strictly related to threads, and the vast majority of callers don't need private
> > data, i.e. the param is dead weight in most cases.
> > 
> > And unless I'm missing something, it's trivial to move to a separate helper,
> > though honestly even that seems like overkill.
> > 
> > Wait, looking further, it already is a separate helper...  Forcing a bunch of
> > callers to specify '0' just to eliminate one function call in a handful of cases is not
> > a good tradeoff.
> 
> The intention was to do the allocation within one vm_for_each_vcpu()
> iteration when possible. Just a micro-optimization, but no problem, we can keep
> them separate if that looks better (simpler).

Keep them separate, that level of optimization is not something that's ever going
to be noticeable.

I don't want to say that performance is an afterthought for KVM selftests, but in
common code it's definitely way down the list of priorities because even the most
naive implementation for things like configuring vCPUs is going to have a runtime
measured in milliseconds.
