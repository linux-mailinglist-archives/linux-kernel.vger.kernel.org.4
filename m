Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 130BA72E884
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 18:30:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233048AbjFMQ1s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 12:27:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237244AbjFMQ1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 12:27:40 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B96AFA1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 09:27:36 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3f7f7dfc037so113895e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 09:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686673655; x=1689265655;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bb4r2L6AwZcib8eVRxm1j5QUlHnbK0ehOb0SKNt4SPU=;
        b=e1nUAZBxdwX20Geah9m+G2IuD80yh27ymA1hBhn7th6kdEYIhlb08tJahgei4NPXLE
         TlgGmEgc/p6XQ6zk4vL56FkhUwBSL2bytiyhe160o8dx4NCqmLjbae7t31KRCQRN5KNx
         3hhxUBhBgtAs7xhBDEFEufLFY2enbRYoWTN9q/jrnljkFWOGqQoYNSZT7gfzthNY+WR1
         4hcYZG9ZLw+0nMSl1O2pRZ17wkZjAUMR12qlZ8VWScwA7kRnDpTOd0fpeeb9vJ0IX5fB
         9qkvdJmUkTsAE0tRIFrrg7DjwsArDvIScL8EA1RoZxyN0KzqhZZR/IeLyckCMNlJx8dv
         8dVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686673655; x=1689265655;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bb4r2L6AwZcib8eVRxm1j5QUlHnbK0ehOb0SKNt4SPU=;
        b=Rygg98GT0bi1cOhkySIYhqxeg1L5+2M1U3AkKBkeUmu6UbwFPBG5KosgLlqP0VjSol
         ATbPXzCofDeoYMhnt7F0Fl6nA4/kXEURmzzAopK03b4YRqUPUAtWuyq11zckJXFsQtzc
         MwZNFOHkTkAETVzs9XW/w7qHyptIXAQaZqXgon0x0M/PufVyqCgTdsKo4tuidIpi3fwk
         gR31CBSnSjJfeObCUqifBxrtGNeNuKk6KgIJz+SUwR7nFqcL2T2ydEb4HIJwP/1nhUFR
         /C50U1Qa5trcyXH2cDEa2CWHyVeuVo86OGfFYkJXPugkpQRe4asQxbkGXhc9UME3OrMD
         PoXw==
X-Gm-Message-State: AC+VfDwzOL+mSGpxhagQYJh3iVurPAalEOIN9kxPYY4bbOclRy14DS7a
        xBXYUzXpbZrub8T4eHXWHbT8MQ==
X-Google-Smtp-Source: ACHHUZ7WP0YlatKkxy7A15OCib42caMtXP4jusH0MPAzWXQ3c89i4Ak3A54HsaSwRdX46YQ2Sv6VAA==
X-Received: by 2002:a05:600c:3c86:b0:3f7:3654:8d3 with SMTP id bg6-20020a05600c3c8600b003f7365408d3mr148549wmb.2.1686673655192;
        Tue, 13 Jun 2023 09:27:35 -0700 (PDT)
Received: from google.com (44.232.78.34.bc.googleusercontent.com. [34.78.232.44])
        by smtp.gmail.com with ESMTPSA id t11-20020a7bc3cb000000b003f60eb72cf5sm14998338wmj.2.2023.06.13.09.27.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 09:27:34 -0700 (PDT)
Date:   Tue, 13 Jun 2023 16:27:30 +0000
From:   Mostafa Saleh <smostafa@google.com>
To:     Oliver Upton <oliver.upton@linux.dev>
Cc:     kvmarm@lists.linux.dev, maz@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        suzuki.poulose@arm.com, kaleshsingh@google.com, tabba@google.com,
        yuzenghui@huawei.com, catalin.marinas@arm.com, james.morse@arm.com,
        will@kernel.org
Subject: Re: [PATCH] KVM: arm64: Use different pointer authentication keys
 for pKVM
Message-ID: <ZIiY8lrLKv4amCu7@google.com>
References: <20230516141531.791492-1-smostafa@google.com>
 <168665854178.2681974.13725664134174024912.b4-ty@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <168665854178.2681974.13725664134174024912.b4-ty@linux.dev>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,FSL_HELO_FAKE,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Oliver,

On Tue, Jun 13, 2023 at 12:16:02PM +0000, Oliver Upton wrote:
> On Tue, 16 May 2023 14:15:31 +0000, Mostafa Saleh wrote:
> > When the kernel is compiled with CONFIG_ARM64_PTR_AUTH_KERNEL, it
> > uses Armv8.3-Pauth for return address protection for the kernel code
> > including nvhe code in EL2.
> > 
> > Same keys are used in both kernel(EL1) and nvhe code(EL2), this is
> > fine for nvhe but not when running in protected mode(pKVM) as the host
> > can't be trusted.
> > 
> > [...]
> 
> Applied to kvmarm/next, thanks!
> 
> [1/1] KVM: arm64: Use different pointer authentication keys for pKVM
>       https://git.kernel.org/kvmarm/kvmarm/c/fb737685beee
> 
> --

Thanks! I did more testing and I found a bug in this patch.

It seems there is another entry point for the kenrel where pauth was
not handled properly "kvm_host_psci_cpu_entry", I will investigate this
further and send V2.

Sorry for the inconvenience!

Thanks,
Mostafa
