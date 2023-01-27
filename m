Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69FC767EE14
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 20:19:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235152AbjA0TTw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 14:19:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234507AbjA0TTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 14:19:32 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 098437E05F
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 11:19:10 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id lp10so5489601pjb.4
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 11:19:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=G1KhvTZLo0k/BHNeMbUMxtqL2lwt9xvnRAr6RZgraY0=;
        b=p65r0uGI5MsLvJ8EBUrRFp+HHMVSd0G8G/Wjljr+covLJNbz3A/4w+NfTKzcv7AINb
         MbmmX1BWevt7mZGlreuBgSGVdMZ8g0IMwOdQza0hYj9wzZjA2kyrFWec0dLtrbck6gKx
         IY5tp84hWnpVajObPYGmmaM5SKisDGE6acuit/HjlTau7KrvnvNLS8F62ZYOFT32LlrF
         x1wCqZsqK9W5Ry6n7yPwlvp//nL1CtywHfsQnK4dysMg/MjddwoJaYDk7a1b7ipslAo1
         GrNS2Yo3qYNZIrw712Baj/WCNOsLfaKs+mLknAKi+oikyPF50LQfyi2QdmGTdkMzV+Td
         IQdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G1KhvTZLo0k/BHNeMbUMxtqL2lwt9xvnRAr6RZgraY0=;
        b=MuO8v7vDFIdUCUoRXDIEknr0YIEeFmGJOhv5hqFoJAr89gR8j96PIwmy8KtycVKfQx
         8GC2Ex3HBMH5nwGZYtm+EFJ/86F4T4Try8XS9R5YWjKPDJEq6vmfpTbq4NbTr8CsjB3s
         pkLCT81pjrE5OA1LMTI3PQ/sDmuVv+ABM6Sw9+HjtOkxq/Ck4b/f+6ZzAaFK8V3o1zkK
         +s3nRXRjqvUAZsB69tdKuhvmzJNJ8h8xMsuOEcawvQKZPh5evNkJXPOFQYNuy+oWous/
         UeRpLdthzlc0IjVrXAknYVH3qwekosQUbnar9Qv61WCTADrHGM5KsWFN4q1lgp3jSlQQ
         a1+w==
X-Gm-Message-State: AO0yUKWXMbnlr7LuDCtYT7inqYYLdzHkQyeuYgovbH59CdpluACj5aG7
        sDt3L9/z/gebQPoTpQvu76KEpQ==
X-Google-Smtp-Source: AK7set9ZEGUnRAP+lDeTXBvv1lmR4A+BCCh0vXOO/RgE/rISRYWf9Ngzyp2685zXhIjQAYTq3qxthg==
X-Received: by 2002:a17:90a:6949:b0:219:f970:5119 with SMTP id j9-20020a17090a694900b00219f9705119mr80468pjm.1.1674847150271;
        Fri, 27 Jan 2023 11:19:10 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id v3-20020a17090331c300b001869ba04c83sm3182021ple.245.2023.01.27.11.19.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 11:19:09 -0800 (PST)
Date:   Fri, 27 Jan 2023 19:19:06 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     David Stevens <stevensd@chromium.org>
Cc:     David Woodhouse <dwmw@amazon.co.uk>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] KVM: x86: replace kvm_vcpu_map usage in vmx
Message-ID: <Y9QjquvzoL7kKHWE@google.com>
References: <20230127044500.680329-1-stevensd@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230127044500.680329-1-stevensd@google.com>
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

On Fri, Jan 27, 2023, David Stevens wrote:
> From: David Stevens <stevensd@chromium.org>
> 
> This series replaces the usage of kvm_vcpu_map in vmx with
> gfn_to_pfn_cache. See [1] for details on why kvm_vcpu_map is broken.
> 
> The presence of kvm_vcpu_map blocks another series I would like to
> try to merge [2]. Although I'm not familiar with the internals of vmx,
> I've gone ahead and taken a stab at this cleanup. I've done some manual
> testing with nested VMs, and KVM selftests pass, but thorough feedback
> would be appreciated. Once this cleanup is done, I'll take a look at
> removing kvm_vcpu_map from svm.

Woot, been waiting for someone to take this one, thanks!  It'll likely be a week
or two until I get 'round to this, but it's definitely something I want to get
merged sooner than later.
