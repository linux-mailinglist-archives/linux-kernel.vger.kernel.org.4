Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F56A622E67
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 15:52:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbiKIOwE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 09:52:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbiKIOwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 09:52:02 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DCCB1115
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 06:52:00 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id u6so17279656plq.12
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 06:52:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XeOFALjP4//bjPWLGTjPjIDysDczrY32pqpS/JBJ2aM=;
        b=dzc2j21Z19okNpdO/OG3vUOhmVC//w/sykljjJTVJPG9Bwyi9Dg3GqsAX8V6j4q58k
         Jzwfq2I5a8tktAdnuywWGW1D71R0jq1CQ33O6h0k8v1xyqOyXQ3DCygTa//OdE/Qczuj
         rqofOhdMAXa8nSHmLrpMM58HWgun+/+buQiLWVWtldZVCJmTabOe+ZnRO17Saux+xPep
         B4WHFfFjQKAdQxVfx2SUIi5wzcNpl4jFEoY0GGSkYLz4YTh7MTk5rP/0URlZpNEz28pR
         zW5z0xsNpW7DZheVbJBSS8hEvlzJnAa3Mii13K7mIT3MN/AGpE7PwpvmRlICa+umCy8E
         gsaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XeOFALjP4//bjPWLGTjPjIDysDczrY32pqpS/JBJ2aM=;
        b=OcL8d20UoTTh3vunO8hf9ejmZ4i5Vbm0M19nLKHgbsoWTs4cfHtEdpcPfUWsH7yAYq
         Ub0QxMFz11i/hRn34yrZke3ZPJfxyZRKK1Iim2pZNVp81Kh/7HWmjajtRKN5sM4WUowS
         5IkzZOFxyjSFAoXK2jDooHmu61wdbjRwYfCtN9jXy2GcThONpyZyEx7jzvWkug5W5yVp
         KJfgfvamGO7+N43bLV7MJrhJexRNqooMN87n0pmh3/NDyBmNdWMftMTXdKOz3NOZ5szy
         TVALd3/Wqw8DymlGigGMfGjyo4blkQx9ZhHZTzzRUcE2gGhl1rJtxJR++/P+ToRglhlD
         u8lg==
X-Gm-Message-State: ACrzQf2oOKpoBzrhVb30lMsNlhVIxZr8JJXlecuB6vRP8KJrz+evcBCe
        5ZkxiNEvRU0eVKz8qUJRGE3+G/OxDenDkA==
X-Google-Smtp-Source: AMsMyM7cS/NQlLGyLM98aZixQixRLTspiMLHh8S33ld8nKp+9Cn7QtIiI2O2s0Q+Rpwuhtg5XFXL5g==
X-Received: by 2002:a17:902:b68b:b0:186:aee0:53ec with SMTP id c11-20020a170902b68b00b00186aee053ecmr62375926pls.90.1668005519533;
        Wed, 09 Nov 2022 06:51:59 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id a2-20020a170902710200b00176b3d7db49sm9224863pll.0.2022.11.09.06.51.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 06:51:58 -0800 (PST)
Date:   Wed, 9 Nov 2022 14:51:55 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Like Xu <like.xu.linux@gmail.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] KVM: x86/svm/pmu: Add AMD PerfMonV2 support
Message-ID: <Y2u+i1Qd9HkuwlGr@google.com>
References: <20220919093453.71737-1-likexu@tencent.com>
 <20220919093453.71737-3-likexu@tencent.com>
 <Y1sKf/PgwHwtAibK@google.com>
 <107f4040-e4cd-82df-01bc-f0d6a22be053@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <107f4040-e4cd-82df-01bc-f0d6a22be053@gmail.com>
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

On Wed, Nov 09, 2022, Like Xu wrote:
> On 28/10/2022 6:47 am, Sean Christopherson wrote:
> > What happens if userspace sets X86_FEATURE_PERFCTR_CORE when its not supported?
> > E.g. will KVM be coerced into taking a #GP on a non-existent counter?
> 
> I'm getting a bit tired of this generic issue, what does KVM need to do when
> the KVM user space sets a capability that KVM doesn't support (like cpuid).
> Should it change the guest cpuid audibly or silently ? Should it report an
> error when the guest uses this unsupported capability at run time, or should
> it just let the KVM report an error when user space setting the cpuid ?

KVM should do nothing unless the bogus CPUID can be used to trigger unexpected
and/or unwanted behavior in the kernel, which is why I asked if KVM might end up
taking a #GP.
