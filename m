Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BB1A675C6B
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 19:05:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbjATSFD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 13:05:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231167AbjATSE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 13:04:57 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B77D359E46
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 10:04:56 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id g23so5981626plq.12
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 10:04:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2OuajGsQxBU53T1LkCzzlNc9v38dGdSuaz3Ry16782k=;
        b=cv4xGHqJsuZvK2ZarceReQkinlRWj2RKHI/IXlEeZ8KhlCt9vSO+50shUgMQe8U7Xo
         o/N48hI9fEfkAoRXatBZOk/BX0ATkFJL8snFudzFxL3kNQ9mKICA/iOJSXzXo2qLmZNF
         8twvT7FVamMuP5tkEBBz1tL29FrI4hkbo5KtFr9UgvArdoGmLJNRcJR9SXOwhW03BQNG
         VvQ5wv+icw52V1um0S2V9vmsnnONdVfyOW6vf7J6e74roX9rmFAD2M2mhIVkp66B3fmX
         EuRuzMryXhDtQSyIsM/pnUMX+I5wmG9EwAsk0P9XQZKaRKc/AhS07ScnQZ1vfJbrvcvr
         XJGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2OuajGsQxBU53T1LkCzzlNc9v38dGdSuaz3Ry16782k=;
        b=1G8RUgNxcP9/LJMqzLKhW77hgCNMn+BvJmc20pSFwSY8qp4K5YPDVnwveAEl/aUs/i
         gEGpWX+t+6wPYKEq5mTRf4M9Xcbt4l8G8Pa6bgAIUnv72xWMrb7xSccxL6WlSNr3b2un
         e5wI5KfY8AGuQ8kz2Ussz1FAtqjdYhVThezAuL1A803667Eu4lKhlvJMQpro9OLqCLXb
         1ml6jATyHELehtW6eUiGzj0v6eMu0dkqHlkRQDzjzYvSCQSTjScNFt6qMMyKlwzuhft3
         1H6Mj8iHgXPWps79hbWuDm/qDSIOUdWnml6SkX9+BBKfBwEIfy4a1403qiKCTcoYMiBE
         zzGQ==
X-Gm-Message-State: AFqh2kpppful4gDbcVNla50fQGqF6YNsyQEV813pvr/Bf3oVsXQl7van
        2JKc4eZC69cDgbU/eRXI4h7GjQ==
X-Google-Smtp-Source: AMrXdXuQhxYzud0iE3IRvL3V0n7Ork0xtZ6zEcwNtunFJm0FHpzqoz+cUMFDIt1LhNt+V+5xPvsjoQ==
X-Received: by 2002:a17:903:404c:b0:191:4367:7fde with SMTP id n12-20020a170903404c00b0019143677fdemr268549pla.0.1674237896052;
        Fri, 20 Jan 2023 10:04:56 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id f5-20020a170902684500b0019488a36e2asm11100991pln.277.2023.01.20.10.04.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 10:04:55 -0800 (PST)
Date:   Fri, 20 Jan 2023 18:04:51 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Freedesktop DRI List <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Documentation <linux-doc@vger.kernel.org>,
        Linux KVM <kvm@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Oded Gabbay <ogabbay@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jeffrey Hugo <quic_jhugo@quicinc.com>,
        Ofir Bitton <obitton@habana.ai>,
        Aaron Lewis <aaronlewis@google.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH linux-next 3/3] kvm: x86/pmu: Add blank line separator
 before KVM_CAP_PMU_EVENT_MASKED_EVENTS code path list
Message-ID: <Y8rXw6g8JZkajrZ5@google.com>
References: <20230120123534.137413-1-bagasdotme@gmail.com>
 <20230120123534.137413-4-bagasdotme@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230120123534.137413-4-bagasdotme@gmail.com>
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

On Fri, Jan 20, 2023, Bagas Sanjaya wrote:
> Stephen Rothwell reported htmldocs warning when merging kvm-x86 tree:
> 
> Documentation/virt/kvm/api.rst:5070: ERROR: Unexpected indentation.
> 
> Fix the warning by adding a blank line separator before
> KVM_CAP_PMU_EVENT_MASKED_EVENTS code path list to determine guest access.
> 
> Link: https://lore.kernel.org/linux-next/20230120130927.3100f935@canb.auug.org.au/
> Fixes: 651daa44b11c0e ("kvm: x86/pmu: Introduce masked events to the pmu event filter")
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---
>  Documentation/virt/kvm/api.rst | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
> index a477186c57c193..83e3acc9e3211d 100644
> --- a/Documentation/virt/kvm/api.rst
> +++ b/Documentation/virt/kvm/api.rst
> @@ -5067,6 +5067,7 @@ An encoded event will follow this layout::
>  
>  When the guest attempts to program the PMU, these steps are followed in
>  determining if the guest should have access:
> +
>   1. Match the event select from the guest against the filter events.
>   2. If a match is found, match the guest's unit mask to the mask and match
>      values of the included filter events.
> -- 

Squashed this into the offending commit, thanks!
