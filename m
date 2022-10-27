Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A883F60FD9D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 18:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236124AbiJ0Q4X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 12:56:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236249AbiJ0Q4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 12:56:18 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 286F917A02A
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 09:56:14 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id h185so2056703pgc.10
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 09:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=R53WK2VMBi999TWTmmW7DP/C36/3TjYtBesfKsubmBI=;
        b=BN2fRaT/LM2Tn120Q3WjdWpDuJcEnDEKyc/+xL2D0uLq3p2tznv75V/u9RlG/IzA16
         3A/u5tl93bXlEWIj5VYM68d0GJkGqeckmkChLDIrgJM7cNBwD+d6TA6Dc+wKSeKoyItI
         cAAkd00zsgmsZOKUBU778IDDP8t6iwHd7AQM5TUX2FpxyRrd+5kduoNor1bJaQjRJq5t
         z7ojCH82/Ok6xHMtBtDQZs54lI7lMq24kpVq1nfWwErhTEo7ohgu+RrkW4IBHH4ks9/5
         HPWZr1RmwABEOwbCxpUEQ5arV8gDwwfkRrSXzvnfzTBpTgKB5trEXNRNGK5lV0LPVv4K
         D1/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R53WK2VMBi999TWTmmW7DP/C36/3TjYtBesfKsubmBI=;
        b=gylh3/5HRinCTFKjeS8dYzegBf5KA0DG2apQAn9UKvHvpOn5U87FTbsIl3fIj5dTYK
         Bidn899Qid8cjqVm/wCizWM35rXbOKg/8yhM+wmlBgaBFAWUVvjk7NWxNnFHna+XZbck
         NC/oBKyGBYMTMzh7dTI98WMDj/hRyhZQ5nW5uW1Qo5n3enmlVaWnJ/nJEnNfN5q2XwhO
         f3QDqzp5/5ZlGtS/ZZfZr2DU9iU44AmwDrVmMl7Rgva77o7ZAROKhuiW/ssQcYXvXGIi
         FPoxVWoE+KHO47/mllhqPcA3ESFt6GJ2fiLVEa+Vr24KRp5Qs2ApHKrN8oKjhjh8a4U6
         x58w==
X-Gm-Message-State: ACrzQf0J+CQgHQt452DddxKq8zqP6o3gSUneefWISelLtFYFx7baTJvN
        24lc0d9yztYvjpDEHJcPqoXnuw==
X-Google-Smtp-Source: AMsMyM5rw2WyE82KgSud6t706admcPOeHNOoMBoT75zlOCAH8PlcfvdQnB7viaau/GMnM8pJAF6EzA==
X-Received: by 2002:a63:fb09:0:b0:43c:b1c6:b335 with SMTP id o9-20020a63fb09000000b0043cb1c6b335mr43524190pgh.276.1666889774120;
        Thu, 27 Oct 2022 09:56:14 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id i63-20020a62c142000000b0053e62b6fd22sm1377251pfg.126.2022.10.27.09.56.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 09:56:13 -0700 (PDT)
Date:   Thu, 27 Oct 2022 16:56:10 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michal Luczaj <mhal@rbox.co>,
        David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH v2 03/16] KVM: x86: Always use non-compat
 vcpu_runstate_info size for gfn=>pfn cache
Message-ID: <Y1q4KkVQLpuZSX+V@google.com>
References: <20221013211234.1318131-1-seanjc@google.com>
 <20221013211234.1318131-4-seanjc@google.com>
 <afad5f40-03ef-1380-9bfe-03bbaaed47a9@redhat.com>
 <Y1qZagwM0dMBjYhe@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1qZagwM0dMBjYhe@google.com>
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

On Thu, Oct 27, 2022, Sean Christopherson wrote:
> On Thu, Oct 27, 2022, Paolo Bonzini wrote:
> > On 10/13/22 23:12, Sean Christopherson wrote:
> > > Always use the size of Xen's non-compat vcpu_runstate_info struct when
> > > checking that the GPA+size doesn't cross a page boundary.  Conceptually,
> > > using the current mode is more correct, but KVM isn't consistent with
> > > itself as kvm_xen_vcpu_set_attr() unconditionally uses the "full" size
> > > when activating the cache.  More importantly, prior to the introduction
> > > of the gfn_to_pfn_cache, KVM _always_ used the full size, i.e. allowing
> > > the guest (userspace?) to use a poorly aligned GPA in 32-bit mode but not
> > > 64-bit mode is more of a bug than a feature, and fixing the bug doesn't
> > > break KVM's historical ABI.
> > 
> > I'd rather not introduce additional restrictions in KVM,
> 
> But KVM already has this restriction.  "struct vcpu_info" is always checked for
> the non-compat size, and as above, "struct vcpu_runstate_info" is checked for the
> non-compat size during its initialization.

Ah, I forgot those are the same size:

		BUILD_BUG_ON(sizeof(struct vcpu_info) !=
			     sizeof(struct compat_vcpu_info));
