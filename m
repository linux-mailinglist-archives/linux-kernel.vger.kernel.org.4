Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9F436B1AA9
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 06:18:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbjCIFSV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 00:18:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjCIFST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 00:18:19 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F8BF3402F
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 21:18:16 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id l1so1066557pjt.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 21:18:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678339096;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=d7NmRbnOpMKZ9/VW9/POAunQQIMGvt6ilad4QXpo07k=;
        b=BQHYo6oOshr1q8v1UcTa1lX5HoLMyGOm0sNk4kYogyNVfBKADGQXYZhkAkjeZSf+FN
         FaSjpDKZtBw0tlwtpuF+cSFu7vS68qsm9K3K5lihwSbiQzJFoIvqSIaheJ+6Qocuecc2
         WO0ad0s/xyOYE/N8BuSirCLgEXJVy+SbjOF/pVDEpvWsB+Y9e6hyJ5eBXfseCFq/FmA9
         VBHNBzQVzqjO3EO8kjXjAtfhLioBHZsoSP0T4bW/fEi1GX9WYD6NKRBSbc8rzcckcZaI
         3P5Ib77CwAGzaU2OIlwlLx8VjNfS2kfN7C8DJbsu/DqxS0kxadeY6pKGp6M+BAJmbBei
         YDVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678339096;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d7NmRbnOpMKZ9/VW9/POAunQQIMGvt6ilad4QXpo07k=;
        b=0tJMOkTdZqzwcavkGVXMRO+ECRZtlw94aVMFH1nFj/OoD6EmRYtR3MxkWWjcxSJihg
         +hlGel44mkbk0NIEYC1H4EJLbqxR6mg3smTWV6e5UmP9Zz6dAHd8svc3BOdjAQAXX04r
         RzufLRq+jJlWnyJcpLbj+Vl3gCPHw80PaotV3UNDoOKZfidRB5WKJ5nF6nLsuzTJSph+
         Y9wAMXftjpN2YBSCwUjNprNYkz/5OJoT7E2zywjFb1hfe/UDJe08LA/mEznLQuzb7R8v
         MKh9ydcx0jayIEVXiYy7+Y7VI/RbXbD+YQW4PCwYSjhRtyyMGDHfB3wokylR6tVHH+G0
         aBKQ==
X-Gm-Message-State: AO0yUKWsNsXPSYBB4vFIDvuEQ0bf9fMc6k1ZeoSMFw4sRzDQfTunLTCd
        nEjLYZh2GyLhUPRd+/dkQ/uTXw==
X-Google-Smtp-Source: AK7set9HKs3hbvPy6qiZFByeTcF2y768wncnZy6L+FK9NKtEBpVdzZN3s2bQC8AAS3ydC5FGgh1S3Q==
X-Received: by 2002:a17:90a:6485:b0:237:461c:b44d with SMTP id h5-20020a17090a648500b00237461cb44dmr21061669pjj.46.1678339095527;
        Wed, 08 Mar 2023 21:18:15 -0800 (PST)
Received: from google.com (77.62.105.34.bc.googleusercontent.com. [34.105.62.77])
        by smtp.gmail.com with ESMTPSA id g3-20020a635203000000b005035f5e1f9csm10033068pgb.2.2023.03.08.21.18.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 21:18:15 -0800 (PST)
Date:   Thu, 9 Mar 2023 05:18:11 +0000
From:   Mingwei Zhang <mizhang@google.com>
To:     Vipin Sharma <vipinsh@google.com>
Cc:     Zhi Wang <zhi.wang.linux@gmail.com>, seanjc@google.com,
        pbonzini@redhat.com, bgardon@google.com, dmatlack@google.com,
        jmattson@google.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [Patch v4 03/18] KVM: x86/mmu: Track count of pages in KVM MMU
 page caches globally
Message-ID: <ZAlsE0dei9I1MfpW@google.com>
References: <20230306224127.1689967-1-vipinsh@google.com>
 <20230306224127.1689967-4-vipinsh@google.com>
 <20230308223331.00000234@gmail.com>
 <CAHVum0cMAwyQamr5yxCB56DSy7QHuCvTG06qRrJCGiZWQV+ZTw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHVum0cMAwyQamr5yxCB56DSy7QHuCvTG06qRrJCGiZWQV+ZTw@mail.gmail.com>
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

> >
> > 1) Previously mmu_topup_memory_caches() works fine without a lock.
> > 2) IMHO I was suspecting if this lock seems affects the parallelization
> > of the TDP MMU fault handling.
> >
> > TDP MMU fault handling is intend to be optimized for parallelization fault
> > handling by taking a read lock and operating the page table via atomic
> > operations. Multiple fault handling can enter the TDP MMU fault path
> > because of read_lock(&vcpu->kvm->mmu_lock) below.
> >
> > W/ this lock, it seems the part of benefit of parallelization is gone
> > because the lock can contend earlier above. Will this cause performance
> > regression?
> 
> This is a per vCPU lock, with this lock each vCPU will still be able
> to perform parallel fault handling without contending for lock.
> 

I am curious how effective it is by trying to accquiring this per vCPU
lock? If a vcpu thread should stay within the (host) kernel (vmx
root/non-root) for the vast majority of the time, isn't the shrinker
always fail to make any progress?
