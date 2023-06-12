Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F265D72BC43
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 11:27:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234531AbjFLJ1S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 05:27:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234703AbjFLJ0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 05:26:20 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD30344A9
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 02:20:23 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3f7e4953107so64735e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 02:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686561622; x=1689153622;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=otJCdOhglUPqvCsRPiFCc48HcC5AAnpHmKD+QmYUjHs=;
        b=Dyg6HMndIPLYMWfoGxl7n7NRxVRskxhBZOR6fEyrFNYbBgYFaP4qntq25Vrz9J2cft
         zO+O4s577L+Coq4d1iky56D+LQ8F2yx6JBs25J17shPG3TcVaPhkEcCvT538duQbaOEY
         Z0Iva64KK+4dPO0/ILD3vUYguScD+An4uEzXhZN7n6oAa0FVMIRmzVR4oTMD5VMKxzWR
         FpsgzwcnpUWmZZGs0vBNVmdbIQ9ZFIq4PUHBvbwnmreK9YsSb9jjUDMYwrdEWDp3lBgV
         NT8J81CPtLdpY7RyfOJpBDMIwKj/Vgt6r1t6rN4SAddonIJk8brpu5UF4FVUoDX06gJm
         F8Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686561622; x=1689153622;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=otJCdOhglUPqvCsRPiFCc48HcC5AAnpHmKD+QmYUjHs=;
        b=Q6l5PhneTFvSmVTUaJupdazQ9Oknr1ZUaBX+wm7WmGHucRWFfU7jLfp2R9PeyBsMr1
         upWr/UeuM+YUt6iba5m1xGqWIHDCoKBU6CuJikSppZwEqe4M0xEbyW5+6WGUHR6ayz5h
         Hzp12wmdqRFqR1/FknhN0FovC0omT36eZja18Bz9G4iyVGBHwzlp5JJFAIaTqSLbT+NR
         WnBFdSadcJRqGQHZFkNkwfyu6ClKuS7JqDkpfZ1gl8Dn4nHcpl6rr3htTVKj8klPnzL8
         wCD9Y9NbctxM4Tm19HaELuSKc3hOFzBOJB4BUs7tKuee3JHGxpeDDKmnpuzASXIFJy+x
         2n5g==
X-Gm-Message-State: AC+VfDx52KD4vYbL992O7kOcOZJuVoLPOLcTP50e8iEPFYv0ldw8mtMa
        SLX6sWttUo4hJvPWEiWnmXCvBg==
X-Google-Smtp-Source: ACHHUZ4mNCOxZlSL9PDghMOkP1a2TYFkupsco7D0NYsOtKN5IjO/YfGXsn81zyhwoYWot+Qg5iB49g==
X-Received: by 2002:a05:600c:3d86:b0:3f7:e463:a0d6 with SMTP id bi6-20020a05600c3d8600b003f7e463a0d6mr326701wmb.0.1686561622064;
        Mon, 12 Jun 2023 02:20:22 -0700 (PDT)
Received: from google.com (44.232.78.34.bc.googleusercontent.com. [34.78.232.44])
        by smtp.gmail.com with ESMTPSA id x2-20020adfec02000000b002ffbf2213d4sm11974482wrn.75.2023.06.12.02.20.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 02:20:21 -0700 (PDT)
Date:   Mon, 12 Jun 2023 09:20:16 +0000
From:   Mostafa Saleh <smostafa@google.com>
To:     Will Deacon <will@kernel.org>
Cc:     Oliver Upton <oliver.upton@linux.dev>, maz@kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-kernel@vger.kernel.org, tabba@google.com,
        kaleshsingh@google.com, catalin.marinas@arm.com,
        yuzenghui@huawei.com, suzuki.poulose@arm.com, james.morse@arm.com
Subject: Re: [PATCH] KVM: arm64: Use different pointer authentication keys
 for pKVM
Message-ID: <ZIbjULC2p5aTZu8w@google.com>
References: <20230516141531.791492-1-smostafa@google.com>
 <ZHEa+HAixbYijQTA@linux.dev>
 <ZHSJ38WATzgJF7SR@google.com>
 <20230608215525.GA2742@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230608215525.GA2742@willie-the-truck>
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

On Thu, Jun 08, 2023 at 10:55:26PM +0100, Will Deacon wrote:
> On Mon, May 29, 2023 at 11:17:51AM +0000, Mostafa Saleh wrote:
> > On Fri, May 26, 2023 at 08:47:52PM +0000, Oliver Upton wrote:
> > > On Tue, May 16, 2023 at 02:15:31PM +0000, Mostafa Saleh wrote:
> > > > When the kernel is compiled with CONFIG_ARM64_PTR_AUTH_KERNEL, it
> > > > uses Armv8.3-Pauth for return address protection for the kernel code
> > > > including nvhe code in EL2.
> > > > 
> > > > Same keys are used in both kernel(EL1) and nvhe code(EL2), this is
> > > > fine for nvhe but not when running in protected mode(pKVM) as the host
> > > > can't be trusted.
> > > 
> > > But we trust it enough to hand pKVM a fresh set of keys before firing
> > > off? I understand there is some degree of initialization required to get
> > > pKVM off the ground, but I question in this case if key handoff is
> > > strictly necessary.
> > >
> > > There are potentially other sources of random directly available at EL2,
> > > such as the SMCCC TRNG ABI or FEAT_RNG. Should pKVM prefer one of these
> > > random implementations and only fall back to host-provided keys if
> > > absolutely necessary?
> > > 
> > According to my understanding, the kernel is still completely trusted at
> > this point (it sets the initial page table for the hypervisor), so I
> > believe it should be fine to trust it for ptrauth keys. However, I agree,
> > it would be better if the hypervisor can get its own keys through
> > firmware/hardware if supported. I will add this in V2.
> 
> I appreciate the sentiment, but I think we should avoid adding additional
> complexity here if it adds no security benefit. If nothing else, it adds
> pointless overhead, but beyond that it gives the false illusion of a
> security boundary.
> 
> Prior to deprivilege, the kernel can write to the hypervisor text, modify
> its stage-1 page-table and change its data values. I think the pointer
> auth keys are the least of our worries if it's compromised...

Thanks a lot Will for explaining this.

Oliver, what do you think for V2, about it including FEAT_RNG/TRNG in EL2?

Thanks,
Mostafa
