Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A46971486E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 13:18:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231443AbjE2LSD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 07:18:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231436AbjE2LSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 07:18:00 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A7DDD2
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 04:17:58 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3f7024e66adso24665e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 04:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685359076; x=1687951076;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=I+lZausDryKG4ZO3Nqwp8m14ca0rBbgR6EbQ29PXNuc=;
        b=PO2JytkJv+VJn62NFUGU6ShfAlH/PsBE+8W6DxWhBq/UC8fHtabftJqNjIkkyinugL
         bZVjMV+qoFLcMQ5F0K9hkbw0SJxrMu+wJC5vCLRtZbj3HrT2D1dZmmxifZ1xFQjZxtTJ
         Dt1byvQYMkKsbhulNIYKkHXjnTXTAdiDyLCvPAkc3gKpe/gkNlipSd1390Itl5PKzOPe
         tn4uZEkdwMZL8uxmNnauSmUmY6T1bvIlnaOtLHhitosqFzOhWZhj+4+m/8d6D6a4WNsV
         FMQEco3KGwf4SGGYH8/hETD/xnVtQ/C4UXobbRYOZJLJyQXuGTYn14H8urIwpDvXUG3e
         7eEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685359076; x=1687951076;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I+lZausDryKG4ZO3Nqwp8m14ca0rBbgR6EbQ29PXNuc=;
        b=a2nqCblLv+WHhnuVYNqZMqq/VJb+90kbz+Npfmqmqf4jfuda5O/5AI5iejMZGjkwBc
         xLUUrq7xYszB3V0ZQn/ngH2D4MWrpxbZyY2UOtdWjitpezQZ00oFYOVueN9jRkiX/I17
         6+hJBk7WtSD4ArZYJsVKyAS3Z9GaFy2IJxPmsjJuFKIEyJK7lUUDnZb+7LjTwydIlVA1
         1ELtYYAlF5TtDs1P4lo4X5ekJvW00LUGrYJZUJ2qak/2uBZlW9hItNWJlJ0Q8qlGjBbu
         FA+vSpisDaBlN6NtkQUUNS+3Se+FR2+NjqowJJKO3nWZzRh3Hn/ri14QA8bTE9YN2Wv5
         mz5w==
X-Gm-Message-State: AC+VfDx/PZNiwBpLtCswnwyAhYRyh+gTyCct22dTE+gCahePDYnbmbem
        oWdGeRVLOw8OvxMBeDc5kivhRw==
X-Google-Smtp-Source: ACHHUZ7xBl6bStss7nwx99oIzv0OGh31v16NM+89xyXK86HZHTCFsi/YXJiP732JrW9t9QfMa+XPGA==
X-Received: by 2002:a05:600c:3b0d:b0:3f1:70d1:21a6 with SMTP id m13-20020a05600c3b0d00b003f170d121a6mr444931wms.0.1685359076605;
        Mon, 29 May 2023 04:17:56 -0700 (PDT)
Received: from google.com (44.232.78.34.bc.googleusercontent.com. [34.78.232.44])
        by smtp.gmail.com with ESMTPSA id o4-20020a5d4744000000b003062675d4c9sm13449166wrs.39.2023.05.29.04.17.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 May 2023 04:17:56 -0700 (PDT)
Date:   Mon, 29 May 2023 11:17:51 +0000
From:   Mostafa Saleh <smostafa@google.com>
To:     Oliver Upton <oliver.upton@linux.dev>
Cc:     maz@kernel.org, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org,
        tabba@google.com, kaleshsingh@google.com, will@kernel.org,
        catalin.marinas@arm.com, yuzenghui@huawei.com,
        suzuki.poulose@arm.com, james.morse@arm.com
Subject: Re: [PATCH] KVM: arm64: Use different pointer authentication keys
 for pKVM
Message-ID: <ZHSJ38WATzgJF7SR@google.com>
References: <20230516141531.791492-1-smostafa@google.com>
 <ZHEa+HAixbYijQTA@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZHEa+HAixbYijQTA@linux.dev>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Oliver,

Thanks for reviewing the patch.

On Fri, May 26, 2023 at 08:47:52PM +0000, Oliver Upton wrote:
> On Tue, May 16, 2023 at 02:15:31PM +0000, Mostafa Saleh wrote:
> > When the kernel is compiled with CONFIG_ARM64_PTR_AUTH_KERNEL, it
> > uses Armv8.3-Pauth for return address protection for the kernel code
> > including nvhe code in EL2.
> > 
> > Same keys are used in both kernel(EL1) and nvhe code(EL2), this is
> > fine for nvhe but not when running in protected mode(pKVM) as the host
> > can't be trusted.
> 
> But we trust it enough to hand pKVM a fresh set of keys before firing
> off? I understand there is some degree of initialization required to get
> pKVM off the ground, but I question in this case if key handoff is
> strictly necessary.
>
> There are potentially other sources of random directly available at EL2,
> such as the SMCCC TRNG ABI or FEAT_RNG. Should pKVM prefer one of these
> random implementations and only fall back to host-provided keys if
> absolutely necessary?
> 
According to my understanding, the kernel is still completely trusted at
this point (it sets the initial page table for the hypervisor), so I
believe it should be fine to trust it for ptrauth keys. However, I agree,
it would be better if the hypervisor can get its own keys through
firmware/hardware if supported. I will add this in V2.

> > The keys for the hypervisor are generated from the kernel before it
> > de-privileges, each cpu has different keys, this relies on nvhe code
> > not being migratable while running.
> > 
> > This patch adds host/hyp save/restore for the keys.
> > For guest/hyp, they are already handled in common kvm code in
> > __guest_enter, where they are saved/restored if they are not
> > trapped.
> 
> Try to avoid "this patch" or any self-referential language in the
> changelog. Just directly state what the patch does:
> 
>   Similar to guest entry/exit, start context switching the pointer
>
I will update it in V2.

Thanks,
Mostafa
