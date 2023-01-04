Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 239A165DD94
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 21:21:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240177AbjADUVH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 15:21:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240099AbjADUVA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 15:21:00 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 016C01A39A
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 12:21:00 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id cp9-20020a17090afb8900b00226a934e0e5so1779871pjb.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jan 2023 12:20:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ueNCUU1joH9euY/HbmmGVwjQyc0PYYIVO96OTHvE0ao=;
        b=mCq6iUj955VpBOpUETCMOCmcUi1ndMguPbyRF6qZ0v5PbnVVMV+07vADKpC6zvPVAb
         YXLF7NzAyLstD/k14xDceObNSrKJ0Ju/HAzJI3oIA64Kl0TYO38dHAVGipD+tf2UuNX8
         VimsU88ok764ibdxxjRj4kV4NjzhJKx8IIFLwBvXc3XhcrXfJK1/O/MEA0cV97KqKge0
         G3ai6QlpSNioH+CVCiFtiyv9JnBi8lOfhxrsCf8qLEw1NPag4WQhHAQE2SvWU4HGfKCK
         ZxVU3LYJigf8w8KFzm4ySCVUMkK+N4Soqg3OMUqXrf2zs+4Ow2szCLiIsf7a5TY+lRGN
         ubMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ueNCUU1joH9euY/HbmmGVwjQyc0PYYIVO96OTHvE0ao=;
        b=0uXp86t3Tu8fdscqtPfzArzvuTjywKKdvACu/5xdY9mU5xqQiHqEwnBbqHdUtui5C9
         GyPOfjbzQf3X8B54xxvo42+loASyZH7fVx8pGKd1jZVs2XflPlbzNvvz6S+dqSz5Nhpj
         3CgU3xGmKLhN454TxgYBSRuRSEe0ww+vKfZX9q3YKf/m9rozGoF8jLsAA2m4A88KdXH3
         nsrCtlIDL3sBi/CAbzMwpKuEhDI3RX8aB/ZUahrek1LMwFXiapFOiGrs1wb6h4qOwRvt
         wZHZh2Rw3UzmPGeFvaHccY87+r9VkbqMCsMVWMp2/4kdtspYh+FMQ16HQdSaUKP/Uzp7
         gsCw==
X-Gm-Message-State: AFqh2krUwp9IcD42F4wty9IS3WCvs1zyJ2oX0gwl/4ninAndWVuzCz3A
        /jFXoJXOTLZfUH7iJDAG7uaCqA==
X-Google-Smtp-Source: AMrXdXvfBIZC9DvEaP53sNu9pwqkiHq9ym1mhOPVLfxa1brwpGlZtnRItERHkla0EY6ySKVDU1XVKw==
X-Received: by 2002:a05:6a20:3b25:b0:b4:1a54:25c6 with SMTP id c37-20020a056a203b2500b000b41a5425c6mr1548126pzh.1.1672863659413;
        Wed, 04 Jan 2023 12:20:59 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id s6-20020a170902ea0600b001913c5fc051sm24720394plg.274.2023.01.04.12.20.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 12:20:58 -0800 (PST)
Date:   Wed, 4 Jan 2023 20:20:55 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     David Woodhouse <dwmw2@infradead.org>
Cc:     Paul Durrant <pdurrant@amazon.com>, x86@kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v6 2/2] KVM: x86/xen: update Xen CPUID Leaf 4 (tsc info)
 sub-leaves, if present
Message-ID: <Y7Xfp3Izlc6VPEzC@google.com>
References: <20221220134053.15591-1-pdurrant@amazon.com>
 <20221220134053.15591-3-pdurrant@amazon.com>
 <Y7XWHr1kb4AHd4Lv@google.com>
 <0e58d9a6bc8bf15c23feff25ec24e9b3c26945cc.camel@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0e58d9a6bc8bf15c23feff25ec24e9b3c26945cc.camel@infradead.org>
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

On Wed, Jan 04, 2023, David Woodhouse wrote:
> On Wed, 2023-01-04 at 19:40 +0000, Sean Christopherson wrote:
> > 
> > arch/x86/include/asm/xen/hypervisor.h also open codes the signature.  Rather than
> > add a KVM-specific define, what about putting in xen/cpuid.h?  (I've had a version
> > of this series sitting in my todo pile for far too long, sorry).
> 
> xen/cpuid.h is an external header imported from Xen itself so in
> general I'd prefer to avoid modifying it unless we also send the
> changes upstream.

*sigh*  Fool me once...

Can we shove it into arch/x86/include/asm/xen/hypervisor.h?  Or is including
that in KVM too confusing/ugly?
