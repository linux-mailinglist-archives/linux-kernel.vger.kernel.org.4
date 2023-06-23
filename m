Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 870C773B39D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 11:31:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231514AbjFWJbQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 05:31:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231329AbjFWJbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 05:31:13 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D309BA
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 02:31:11 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-51a200fc3eeso440909a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 02:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687512670; x=1690104670;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JLFwH4eBWV8TuG7DAqy/vHsuR9p8j/9lG+R/AMg9I/k=;
        b=oJcl3zycgUyjw1yjRBXJX66UN5Z9p4GU+6A/jWsYGpH3qm3qLG21zJnPHVKelfdJbV
         +rzEcaksYtn+q2Mlu7vqEns/3fcpSTXGwzOT28r4vay/A+jr6qT2GR2qPYbsMAPmpNsQ
         dlCS96JJn1nfp4SonPAX7nqvi3sFcF4EILU+yCvcB3+CtfZmgHa0xyV2pluWyRZJePjO
         6Y4GPWVCgBkgTeqB1tlaiJ4YwSTspBJgtt4RYsII15y5+ES2nagdrb1ic2Yd+4l0GkGk
         7LfOb5N6oUF3IPoYrchOk86tbZCrmUztytn6vFNcqAQ5ejtEeFXL3FuGGC3BZoNwDSbA
         KuvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687512670; x=1690104670;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JLFwH4eBWV8TuG7DAqy/vHsuR9p8j/9lG+R/AMg9I/k=;
        b=Z034skubCvnwRb6AGMViYjEtb766dMWgfkfQL/SI5me2x4CLUq5kbCNR5yEZAovjio
         Br8jYxOjyfTQguLrM95LuxkBGz0qei9+WBTz6vXDh0mMb6uT+PF3kzjK8VhjrhFFv6+7
         CO+44LLcCwMbO6izGLlfOsvstz0TUVaOpiLuadCREXSwntYi5Dy+q1lvnLvNnxCuPfPq
         fy7QD58/oswxu931AYr7JpGkKN4kp6lBrbz4QuLLoJ2xCqquBhhmD8NhSa1fltFEtEhj
         s0CjPIZGstDXJGEjCyyPEEUstbZgyAZiFIjp0URlSPtBc/EVhspZSWachjKKBz/gc/k7
         cD4Q==
X-Gm-Message-State: AC+VfDwaIy0xvxppztJvy1LArJBggeBZLxQG6Ium3oG8aqINO/cyBcOz
        g5oVUXsbU2dEGgQcg7v1k2oNGg==
X-Google-Smtp-Source: ACHHUZ4JaP+Pqk0Z7oAQQSZxL6UfD0mbBGoboDYtfbo9ZKzOwEO6Jzm07ztubc9TOtqzz3p7UhwYeA==
X-Received: by 2002:a17:906:4786:b0:987:f6d6:572c with SMTP id cw6-20020a170906478600b00987f6d6572cmr15484680ejc.25.1687512669865;
        Fri, 23 Jun 2023 02:31:09 -0700 (PDT)
Received: from hera (ppp089210114029.access.hol.gr. [89.210.114.29])
        by smtp.gmail.com with ESMTPSA id a6-20020a1709063a4600b00987e76827b2sm5695214ejf.53.2023.06.23.02.31.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 02:31:09 -0700 (PDT)
Date:   Fri, 23 Jun 2023 12:31:07 +0300
From:   Ilias Apalodimas <ilias.apalodimas@linaro.org>
To:     Jan Kiszka <jan.kiszka@siemens.com>
Cc:     Masahisa Kojima <masahisa.kojima@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: Re: [PATCH v6 0/4] introduce tee-based EFI Runtime Variable Service
Message-ID: <ZJVmW6aa87swMy82@hera>
References: <20230622085112.1521-1-masahisa.kojima@linaro.org>
 <8ce9f761-347d-1e8c-17d7-241d88c82451@siemens.com>
 <CAC_iWjJ28uKVpz_FrJ6dcUjCkrV9w5UO4WRr9SQxYFPmtmj59w@mail.gmail.com>
 <65d010fa-c801-eb4f-352f-8bfb52a67c85@siemens.com>
 <ZJSbE/82z+319sTL@hera>
 <8318ced2-9a4a-c0f3-f4ca-f56bf8beaa20@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8318ced2-9a4a-c0f3-f4ca-f56bf8beaa20@siemens.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


[...]

> >>>>
> >>>> But that is not yet resolving the architectural problem with that
> >>>> userspace daemon dependency. What are the next steps for that now?
> >>>
> >>> We are trying to find some cycles to work on that, however, I don't
> >>> have a time estimate on that.  But the question is different here.
> >>> Since this addresses the problems distros have wrt to SetVariableRT
> >>> (even for a limited set of platforms) are we ok pulling this in?  I
> >>> can't think of a technical reason we shouldn't.  The supplicant
> >>> limitations are known and the firrmwareTPM has a similar set of
> >>> problems.
> >>
> >> It will not change we have to do on the distro side because we have to
> >> deal not only with the startup issue and StMM but also with fTPM and
> >> with shutdown. Only an in-kernel supplicant for RPMB would resolve that
> >> according to my understanding.
> >>
> >
> > Exactly and it's worth noting that even that will come with some minor
> > limitations.  E.g the randomseed variables set by the efistub currently
> > won't be supported as the modules will come alive way later.  But it's all
> > reasonable compromises for hardware that wasn't designed to have a
> > dedicated storage in the secure world and support runtime variables sanely.
>
> My feeling is that such simpler setups will be the minority, simply
> because eMMCs with RPMBs are standardized, often included anyway, so
> come "for free".
>

Yea maybe, I always have the (maybe false) hope that hardware will evolve
sanely.

> >
> >> But the question is fair if we can evolve from this stage here to an
> >> in-kernel approach without causing breakages or other headache to
> >> distros adopting it (too early). That's why I asked for the roadmap.
> >
> > Exactly and this is my point as well.  I can't see a technical difference
> > other than 'you won't need to launch the supplicant'.  The only thing we
> > need to keep in mind is introduce the fallback between the supplicant and
> > the (future) kernel supplicant gracefully.  People might still need to run
> > the supplicant for other reasons.  But if we design it with the kernel
> > module taking precedence over the supplicant we should be fine.
> >
> > So since we lived with it a for a few years, I suggest we let it soak a bit
> > and get tested while we try to move the supplicant bits needed over to the
> > kernel. In the meantime patch #4 needs some adjustments, so I'll rethink
> > the supplicant vs kernel module scenario in case I missed something.
>
> Were there distros adopting all this already? I thought this was a
> privilege of custom integrations where you can evolve things simply in
> lock-step? At least Debian wasn't considering all these dependencies
> yet, even though now providing tee-supplicant. We are patching it for
> now [1].

I've been working with Fedora and the OP-TEE community to get some of the
pieces in place. As a result, Fedora already compiles the TEE client without
RPMB emulation support [0]. We've also fixed the optee-client and removed the
compile time dependency of choosing the right RPMB.  The device the
supplicant now binds to is selectable at runtime [1]. With these two
already merged the user-space tee client is hardware agnostic (as it should
be).

There's two things missing from distros
- Lift the !PSTORE Kconfig limitation this patchset carries so distros can
  unconditionally enable the module in their builds.  But we can do this
  later while coordinating with distros that build the userspace packages
  correctly.
- Distros needs to scan for the rpmb they want to control in sysfs and
  launch the supplicant with the appropriate --rpmb-cid option

[0] https://src.fedoraproject.org/rpms/optee_client/blob/rawhide/f/optee_client.spec
[1] commit 5a69d55d6596 ("tee-supplicant: add --rpmb-cid command line option")
    in the optee_client repo

Thanks
/Ilias
>
> Jan
>
> [1]
> https://github.com/BaochengSu/isar/commit/d7646e3bb9d882b26eaf2517fece624010cdd46e
>
> --
> Siemens AG, Technology
> Competence Center Embedded Linux
>
