Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEE0D686C38
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 17:57:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231491AbjBAQ5U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 11:57:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbjBAQ5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 11:57:18 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 518B061D58
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 08:57:16 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id mf7so34563865ejc.6
        for <linux-kernel@vger.kernel.org>; Wed, 01 Feb 2023 08:57:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5QwLG2T0p0/wJ6lz+hF7UZawl4kCGwRAecIdikVjtEo=;
        b=FjiELNOx4rVbcVrAuGwCv258MtT3ykNsIol/GqUpI0nt+Edk0r1icdxutjlmTcXBWW
         GZ0V9voJ08dFm3E2wMYq6E7SMJ9cZWjL2ObcTY7C1ggoWR7sihQ/Afp4BDOKJGDCotPv
         D4Jdlut/yMLyzF9tvIMo4sXDiX9IdrBmHptId5qYX8Q6tKdFCufPLxz/0/jSaarruZ9e
         YftF69lT280fZq2surf4jBOozRQOl8Huf+8cVVp6k6pCXbi5EQQp6IZJW+2J3x1TTvJZ
         Q7GuvvU7UTTVyyvsoKlHyf1jcZMugXO52qvphTuNl2WtYU2DriOkvH0D53/yQc8Vwpeb
         CIKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5QwLG2T0p0/wJ6lz+hF7UZawl4kCGwRAecIdikVjtEo=;
        b=6KmroTU7ZrNVzMsiH6pgEwOGJOAF1mElsAUPNa9mGj0GHm1XQkyiyjayY7FAgfp26I
         eyP+PU9Z8VbbKVsfImodTXeT2roTANPI3VbXnlbWA2TjD001mubZnWpQMyvw8emX2ZpP
         nDdf3rg5HVKe+RNnGkCVOEpYrVkHf+kALRr4ZCgj9UUcIkDwegi8C4RkYU+HFTUN9VR1
         jlonmeb/vYqAyLcjbyVSVffhLhane+9ep/S8NqoOCVsKNGD+FEVJ61uXFBsOGCW73j+8
         PBU1d4hagCgHr2/IFWgK3ion8iNXLzGOSiAbJ4Ip+oLkYLkQg5Z4ONWfFTkH5j7xcbyQ
         AjRA==
X-Gm-Message-State: AO0yUKUCr/USZGt+1G55kdTpLLduj8DxQhdqH3K44WkXjPv3o1njoE2X
        ocQ13lrrqKyy7l6+u8gyttxUHQ==
X-Google-Smtp-Source: AK7set9KH3KAy6EZVpBWgeg+qNgCuSj1hLv7Q2CPEU+vYqF8yGOPPNkySgRFVjuyZvEfvpW8fknKDg==
X-Received: by 2002:a17:906:2c6:b0:887:87e2:5102 with SMTP id 6-20020a17090602c600b0088787e25102mr7004327ejk.13.1675270634684;
        Wed, 01 Feb 2023 08:57:14 -0800 (PST)
Received: from google.com (64.227.90.34.bc.googleusercontent.com. [34.90.227.64])
        by smtp.gmail.com with ESMTPSA id d13-20020a170906344d00b0088385cd6166sm7094168ejb.195.2023.02.01.08.57.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 08:57:13 -0800 (PST)
Date:   Wed, 1 Feb 2023 16:57:09 +0000
From:   Quentin Perret <qperret@google.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Mark Brown <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.linux.dev, kvmarm@lists.cs.columbia.edu,
        kernel-team@android.com
Subject: Re: [PATCH 0/4] KVM: arm64: Fix CPU resume/on with pKVM
Message-ID: <Y9qZ5XoXW1XQ70eE@google.com>
References: <20230201103755.1398086-1-qperret@google.com>
 <86bkmd1ly4.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86bkmd1ly4.wl-maz@kernel.org>
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

On Wednesday 01 Feb 2023 at 14:48:03 (+0000), Marc Zyngier wrote:
> On Wed, 01 Feb 2023 10:37:50 +0000,
> Quentin Perret <qperret@google.com> wrote:
> > 
> > When using pKVM, we do not reset the EL2 exception vectors back to the
> > stubs for e.g. Power Management or CPU hotplug as we normally do in KVM.
> > As consequence, the initialisation perfomed by __finalise_el2 is missing
> > on e.g. the CPU_RESUME path with pKVM, hence leaving certain registers
> > in an incorrect state.
> > 
> > One such example is ZCR_EL2 which remains configured with SVE traps
> > enabled. And so using SVE on a CPU that has gone through a hotplug
> > off/on cycle leads to a hyp panic. Not good.
> > 
> > This series fixes this by macroizing the first half of __finalise_el2
> > (that is, the part that is not specific to VHE) to allow its re-use
> > from pKVM's PSCI relay.
> 
> For the series:
> 
> Reviewed-by: Marc Zyngier <maz@kernel.org>
> 
> I think it might be a bit late to send this as fixes for 6.2 (my
> latest pull request for kvmarm-fixes-6.2-3 is still in limbo), so I'd
> suggest we take it for 6.3.

Works for me.

> How do you want to deal with the backports? None of the patches have a
> Cc: stable, and only the last one has a Fixes: tag, but cannot be
> applied standalone.

Right, I wasn't sure what was best -- the first patches aren't really
fixing anything per se but yeah, we kinda need them...

Happy to re-post a version with the same 'Fixes:' tag on all patches and
'Cc: stable' everywhere if that makes things easier. Wdyt?

Cheers,
Quentin
