Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F359721873
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jun 2023 18:08:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231779AbjFDQIT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 12:08:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjFDQIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 12:08:17 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9497BD
        for <linux-kernel@vger.kernel.org>; Sun,  4 Jun 2023 09:08:16 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1ae64580e9fso95745ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 04 Jun 2023 09:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685894896; x=1688486896;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MT6YZiuz37HgWSCT/DG/v2E2JSUlRRZpIh9BRpWmVMk=;
        b=GzIgGJ7IC/wjbYmLe+r34uKpGISvrOBJAY/A+7q9fE5poImr/gyR2OFea1Bn4lDAsX
         UZOPJA+9K+rN5UN9BrU0oOvLRIgYOmrzeVpUtLNZtPCXG3yzHMqsJ67HjywY2y81L711
         7eHKfWgObGFSragPSFvoHIZDOClyK718aXF9kwuPGcJ44ba9HqxvIZSb8snucKCDLHrR
         lCOzd3XOqyYdyLLUCaHUVDMlA+ZMdNoE17ltFBB5r5p4BAJA0HFqnlIZzHEZC+eKdvwS
         IMg1+U+6YY8JNG7eXj2q8IqB634KRzq+5Mu85kdrcmA0rFcWTSJhI1j2nmpUONkgBz1x
         26eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685894896; x=1688486896;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MT6YZiuz37HgWSCT/DG/v2E2JSUlRRZpIh9BRpWmVMk=;
        b=Y+r8j87ccmyB88VmDkwY9zjHSNYB1zetOPl6gTqfPmFYHuqJTTSj8CL6DcPYyGJYVt
         aXflRxlpkCrYAb9IdF/K76EGRAVeuw21e+IjxeJR660ZdrirMzwyVNbpu5oGD4BcYdg5
         1J8HNtbS5jXuKVRdobUvRRsck6rlQqUQfM66jeBCaTsAaoh/7+0+rRj1JHoBmbvRjFOr
         V2ic2EZCEk+Pi2eyVw+vkexxNJnDbi9LnXygjhRnVRUCmpV0aNl3WMx6TiMJ4GCUxlQh
         7DDyqrLqP9sA/Fo6PUAH9h0gNm0Z101REpeEcD+B8fLMdTejbYSdG6hT70HpSETsO7NL
         vPfw==
X-Gm-Message-State: AC+VfDyDbUPo16xqDke/w+ksvT55laPD6fJklYIYZLTNo250N4JGiob4
        GHJj9LsITMnVP9jYC/RqXFoCTpyfs+1M6YNKdn6X3w==
X-Google-Smtp-Source: ACHHUZ4TJGCveCZ7HzAy/slKfxS6X2jOEylBTFXhUPLsItcGHMqEXHA2A9cHBgvULWRcBGGi8qjE7g==
X-Received: by 2002:a17:903:2055:b0:1af:90ce:525f with SMTP id q21-20020a170903205500b001af90ce525fmr469981pla.22.1685894896164;
        Sun, 04 Jun 2023 09:08:16 -0700 (PDT)
Received: from google.com (223.103.125.34.bc.googleusercontent.com. [34.125.103.223])
        by smtp.gmail.com with ESMTPSA id t11-20020a63dd0b000000b00543b4433aa9sm340946pgg.36.2023.06.04.09.08.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jun 2023 09:08:14 -0700 (PDT)
Date:   Sun, 4 Jun 2023 09:08:10 -0700
From:   Reiji Watanabe <reijiw@google.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH] perf/core: Drop __weak attribute from
 arch_perf_update_userpage() prototype
Message-ID: <20230604160810.eu7egpjrcb6ettoh@google.com>
References: <20230603082519.1088285-1-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230603082519.1088285-1-maz@kernel.org>
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

On Sat, Jun 03, 2023 at 09:25:19AM +0100, Marc Zyngier wrote:
> Reiji reports that the arm64 implementation of arch_perf_update_userpage()
> is now ignored and replaced by the dummy stub in core code.
> This seems to happen since the PMUv3 driver was moved to driver/perf.
> 
> As it turns out, dropping the __weak attribute from the *prototype*
> of the function solves the problem. You're right, this doesn't seem
> to make much sense. And yet... It appears that both symbols get
> flagged as weak, and that the first one to appear in the link order
> wins:
> 
> $ nm drivers/perf/arm_pmuv3.o|grep arch_perf_update_userpage
> 0000000000001db0 W arch_perf_update_userpage
> 
> Dropping the attribute from the prototype restores the expected
> behaviour, and arm64 is able to enjoy arch_perf_update_userpage()
> again.
> 
> Reported-by: Reiji Watanabe <reijiw@google.com>
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Will Deacon <will@kernel.org>

Tested-by: Reiji Watanabe <reijiw@google.com>
