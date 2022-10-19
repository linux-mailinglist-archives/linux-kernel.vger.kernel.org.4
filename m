Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D3A160541C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 01:41:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231499AbiJSXlc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 19:41:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230294AbiJSXl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 19:41:29 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18D8A147D25
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 16:41:27 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id z20so18692593plb.10
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 16:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qX77FXyzwayFF9UY0kQ94xcxC8zc5o5xZJ+OHBo+nXw=;
        b=Y4c78npINNGc2QcgMRzyCsFkTEr0YNwe6nb8+17Ld14itsUfYnuxBiAKLDQWvRkvz/
         b/Cklkto5pe0144n31+aBie4TyVGLJSsNmotT0xP2VZagNsXi+xTgX54BKi/vG8xRfPf
         jmuRM36LaNj8pa+15UGWNBJMEdtO5ZnIIYoDc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qX77FXyzwayFF9UY0kQ94xcxC8zc5o5xZJ+OHBo+nXw=;
        b=EHSRz2VqEnN1IVxuQAFskIed2fiG+RQS+LwEHl2V6sumnrxiZr2WGlr2yeTEVyM33f
         cM2GAdGqrMfbDEKuhkgfClu1p50df+FSjMYUCNKOQdfyetIB6i+bljEBdJaywuZJ6dz2
         lk/dC90zvT55Lf+kbAGvimtQBXCLc09jMf3znyqVFYmagJ3vOLIAHvxRckGOv8VsTMWe
         ix2GmSibm/FovWmA2YeQLg0V2cghP3CBFlSnnUgWF1grXm3uBF7FNYUhSMK79hQ1Mtmu
         pFJjdA6L8qzsZn39S8WZK2smHZZAr8J0Wd7udduPwG4mXxxIf6Frp4KQkGatc8Rd9O27
         zcaw==
X-Gm-Message-State: ACrzQf2QB0HPS3ssWEy0BvLSr8+UG1VnJSOUOa8rhzVU652ji6YZS47u
        RRGdQMs1WH6VjMg2ppu+loiPCw==
X-Google-Smtp-Source: AMsMyM6kdlVjxdbyAUw47freAA4rwdcnkIgWe1sFX3Mu8/Zo8iPS678Z597JrSKFoCHrDoY70W4ivw==
X-Received: by 2002:a17:902:db05:b0:185:537a:7440 with SMTP id m5-20020a170902db0500b00185537a7440mr10893824plx.13.1666222886578;
        Wed, 19 Oct 2022 16:41:26 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g8-20020a631108000000b00462612c2699sm10497716pgl.86.2022.10.19.16.41.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 16:41:25 -0700 (PDT)
Date:   Wed, 19 Oct 2022 16:41:24 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
        Petr Vorel <pvorel@suse.cz>, Borislav Petkov <bp@suse.de>,
        Takashi Iwai <tiwai@suse.de>,
        Jonathan McDowell <noodles@fb.com>,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, KP Singh <kpsingh@kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        John Johansen <john.johansen@canonical.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 2/9] security: Move trivial IMA hooks into LSM
Message-ID: <202210191639.58F18F1AA@keescook>
References: <20221013222702.never.990-kees@kernel.org>
 <20221013223654.659758-2-keescook@chromium.org>
 <16e008b3709f3c85dbad1accb9fce8ddad552205.camel@linux.ibm.com>
 <202210191134.FC646AFC71@keescook>
 <ffa58bb09df15a9debc45aaf0ed51f2b34f5c225.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ffa58bb09df15a9debc45aaf0ed51f2b34f5c225.camel@linux.ibm.com>
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 19, 2022 at 04:45:41PM -0400, Mimi Zohar wrote:
> On Wed, 2022-10-19 at 11:59 -0700, Kees Cook wrote:
> > On Wed, Oct 19, 2022 at 10:34:48AM -0400, Mimi Zohar wrote:
> > > On Thu, 2022-10-13 at 15:36 -0700, Kees Cook wrote:
> > > > This moves the trivial hard-coded stacking of IMA LSM hooks into the
> > > > existing LSM infrastructure.
> > > 
> > > The only thing trivial about making IMA and EVM LSMs is moving them to
> > > LSM hooks.  Although static files may be signed and the signatures
> > > distributed with the file data through the normal distribution
> > > mechanisms (e.g. RPM), other files cannot be signed remotely (e.g.
> > > configuration files).  For these files, both IMA and EVM may be
> > > configured to maintain persistent file state stored as security xattrs
> > > in the form of security.ima file hashes or security.evm HMACs.  The LSM
> > > flexibility of enabling/disabling IMA or EVM on a per boot basis breaks
> > > this usage, potentially preventing subsequent boots.
> > 
> > I'm not suggesting IMA and EVM don't have specific behaviors that need to
> > be correctly integrated into the LSM infrastructure. In fact, I spent a
> > lot of time designing that infrastructure to be flexible enough to deal
> > with these kinds of things. (e.g. plumbing "enablement", etc.) As I
> > mentioned, this was more of trying to provide a head-start on the
> > conversion. I don't intend to drive this -- please take whatever is
> > useful from this example and use it. :) I'm happy to help construct any
> > missing infrastructure needed (e.g. LSM_ORDER_LAST, etc).
> > 
> > As for preventing subsequent boots, this is already true with other LSMs
> > that save state that affects system behavior (like SELinux tags, AppArmor
> > policy). IMA and EVM are not special in that regard conceptually.
> 
> > Besides, it also looks like it's already possible to boot with IMA or EVM
> > disabled ("ima_appraise=off", or "evm=fix"), so there's no regression
> > conceptually for having "integrity" get dropped from the lsm= list at
> > boot. And if you want it not to be silent disabling, that's fine --
> > just panic during initialization if "integrity" is disabled, as is
> > already happening.
> 
> Being able to specify "ima_appraise=" on the boot command line requires
> IMA_APPRAISE_BOOTPARAM to be configured.  Even when specified, if the
> system is booted with secure-boot mode enabled, it also cannot be
> modified.   With the ability of randomly enabling/disabling LSMs, these
> protections are useless.

Sure, so let's get lsm= added to the lockdown list, etc. My point is for
us to work through each of these concerns and address them. I am not an
IMA/EVM expert, but I do understand the LSM infrastructure deeply, so
I'd like to help you get these changes made.

-- 
Kees Cook
