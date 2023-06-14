Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E7D673064A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 19:47:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234613AbjFNRrx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 13:47:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbjFNRrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 13:47:51 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAF0E1FCA
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 10:47:50 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1b01d3bb571so39267215ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 10:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686764870; x=1689356870;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pahPkO0A0xvJpC9q7OxrgTq9XBv6GY3/19wvuwgWy7w=;
        b=Jp9663v2Ur9j+sO1peNsN9CUt76CiyEyaNfhR4LiIcYWV4AYrOSTuu97bnvZUkq/fi
         qvItQhhFxDktHwBm5BNP14iQe6z514r0PynyVv9AObaz56s8+HNdKq3quDej6NFYi/Xf
         hLu48J96Dri+ztLzQFRpRwNhCwZxDmIjEG/Hc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686764870; x=1689356870;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pahPkO0A0xvJpC9q7OxrgTq9XBv6GY3/19wvuwgWy7w=;
        b=jpdbcFT3FFsQJPLgpmJU/+Lo34+ygD0CZ2/xngZGuo3Kp0qEyUO5MH8rRCq8gPPYfF
         7LlmXJp2ycgxqZoBK841DxzFQadUoWLM12VFvF+K059GAE5phWc6TAp+DezjfPfftc9W
         3kCqkGOX5/47H6f8ETwyE0BV5X0sCqbcdwkE375jom9lGQFFb+wF0PV5GSM4l7vrYDgQ
         kj88Tm4zCyxt0cZxYl0+3FKd8FshKp8WfVpwyBu13o3OE8Q2Yyw7srH+5GV8Om+4ndqQ
         wPM38Re5uBco5M5JvwPjNeMg6hxjPx9XYUfn8LEh0eMbH4IREZprLLseUVx2LcnhbnP6
         pm+A==
X-Gm-Message-State: AC+VfDx8pW3zwx0XB045VCnisOo8tYQ4q7BxuQe8WD+qrjcgGo5V1rty
        oKOCe9ggGV5R87yOektqko/P9A==
X-Google-Smtp-Source: ACHHUZ5VskLMzbZGXrNjV51Hzl4l5gNwNRrCfrzTfpF46wje0zph3+xFGqeCrGuazX7BuFiPBFIqPw==
X-Received: by 2002:a17:902:b489:b0:1b3:7de7:f83f with SMTP id y9-20020a170902b48900b001b37de7f83fmr11826333plr.26.1686764870206;
        Wed, 14 Jun 2023 10:47:50 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id d8-20020a170902cec800b001b3d756a6f4sm5695149plg.13.2023.06.14.10.47.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 10:47:49 -0700 (PDT)
Date:   Wed, 14 Jun 2023 10:47:48 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernel test robot <oliver.sang@intel.com>,
        kernel test robot <lkp@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        =?iso-8859-1?Q?J=F3_=C1gila?= Bitsch <jgilab@gmail.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] usb: ch9: Replace 1-element array with flexible array
Message-ID: <202306140957.EC4977655@keescook>
References: <20230613210400.never.078-kees@kernel.org>
 <ZIjzGCMWrar3kf1L@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZIjzGCMWrar3kf1L@work>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 13, 2023 at 04:52:08PM -0600, Gustavo A. R. Silva wrote:
> On Tue, Jun 13, 2023 at 02:04:04PM -0700, Kees Cook wrote:
> > With "-fstrict-flex-arrays=3" enabled, UBSAN_BOUNDS no longer pretends
> > 1-element arrays are unbounded. Walking wData will trigger a warning,
> > so make it a proper flexible array. Add a union to keep the struct size
> > identical for userspace in case anything was depending on the old size.
> > 
> > Reported-by: kernel test robot <oliver.sang@intel.com>
> > Closes: https://lore.kernel.org/oe-lkp/202306102333.8f5a7443-oliver.sang@intel.com
> > Fixes: df8fc4e934c1 ("kbuild: Enable -fstrict-flex-arrays=3")
> 
> I always have mixed feelings about a 'Fixes' tag applied to a commit
> like this (one that enables a compiler option that avoids the introduction
> of buggy code), when we are addressing the potentially buggy code that
> the option is inteded to prevent. (thinkingface)

Yeah, I've been on the fence about this too. Since it's fixing a
(modern) coding style issue, there's nothing wrong technically. i.e. I
can't say "Fixes: ...usb commit..." since this isn't a bug. But it's
fixing a warning introduced by the fstrict-flex-arrays=3, and tracking
those issues is useful. But, it's not really fixing _that_ commit, as
it's doing exactly what it should be doing. So, perhaps, in the future I
can just mention it more directly in the commit log without a Fixes tag.
For example, this should probably have been written as:

 Since commit df8fc4e934c1 ("kbuild: Enable -fstrict-flex-arrays=3"),
 UBSAN_BOUNDS no longer pretends 1-element arrays are unbounded. Walking
 wData will trigger a warning, so make it a proper flexible array. Add a
 union to keep the struct size identical for userspace in case anything
 was depending on the old size.

 Reported-by: kernel test robot <oliver.sang@intel.com> Closes:
 https://lore.kernel.org/oe-lkp/202306102333.8f5a7443-oliver.sang@intel.com

-Kees

-- 
Kees Cook
