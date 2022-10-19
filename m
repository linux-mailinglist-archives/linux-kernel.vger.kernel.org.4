Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5967460500D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 20:59:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbiJSS7v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 14:59:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbiJSS7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 14:59:44 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 917B551A23
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 11:59:42 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id c24so18164522plo.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 11:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pWmvzKfHVAOxOnLIrYEKBPXUMKXlq9qEMIO0NCFRxkI=;
        b=QLaoWEYkGaAgeIQwtOoss3XAqd1k59ZWE/oLLsBJ/3a82SgQ5MoQVMUj0a5uyCEWZf
         X4fGaHETTYvnIum0FmsTLMahn28WLXY4g6PQRhZMSoHTiY0jOZFciwCd5nRqX7OLBMc7
         +lNliP4eTBDGYe6ABQO9g0EDpcT5S2zSal1bk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pWmvzKfHVAOxOnLIrYEKBPXUMKXlq9qEMIO0NCFRxkI=;
        b=Yako0RMABnfu4qkebuPq5EQGRiucqQNaIjGjo+sSWVNe/M/oCVTQj/FsPSx/mLTbSW
         v4lg9sDmG9bL38AZTNx5OsHqejZQlDb+1+OLy9lchEL6U8h4LTvjva/QZBg2PvcZRDj1
         RO0ir3pHhhrLoTYWaTqDiSBTm28cYpgcJG0UcnF+ZgomdG3Tz/pC9ac/HCYoJYdA/L3U
         k4Ghg5y/HR4KinTvXiz9eX2djCGsM2UY4wTc5S5BslXhKnRZQX531yN1au0wcUuBbu3g
         Ubkl/MB7Nv2w+eOL/5F859+EmzIkUHYnDHcuwHqiPrI+anDqWVURV889/UT7oFUiZp2n
         B6ww==
X-Gm-Message-State: ACrzQf0MhaW0IlNp4NBEJVPLFGUFWFOR10NOWRnhPTkHK9uvf/yy/f50
        zVu6iv47dbk9xdKGAWC6mFM3Eg==
X-Google-Smtp-Source: AMsMyM7VzEMxU5MMIeL1ESdgDm+if1bk/bWR5FyzU9DzA/x9PAPJO633dishwFybXXe26EQS/5PpnQ==
X-Received: by 2002:a17:902:6542:b0:172:95d8:a777 with SMTP id d2-20020a170902654200b0017295d8a777mr10050515pln.61.1666205981925;
        Wed, 19 Oct 2022 11:59:41 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id p7-20020a17090a284700b00200461cfa99sm255190pjf.11.2022.10.19.11.59.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 11:59:41 -0700 (PDT)
Date:   Wed, 19 Oct 2022 11:59:40 -0700
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
Message-ID: <202210191134.FC646AFC71@keescook>
References: <20221013222702.never.990-kees@kernel.org>
 <20221013223654.659758-2-keescook@chromium.org>
 <16e008b3709f3c85dbad1accb9fce8ddad552205.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16e008b3709f3c85dbad1accb9fce8ddad552205.camel@linux.ibm.com>
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 19, 2022 at 10:34:48AM -0400, Mimi Zohar wrote:
> On Thu, 2022-10-13 at 15:36 -0700, Kees Cook wrote:
> > This moves the trivial hard-coded stacking of IMA LSM hooks into the
> > existing LSM infrastructure.
> 
> The only thing trivial about making IMA and EVM LSMs is moving them to
> LSM hooks.  Although static files may be signed and the signatures
> distributed with the file data through the normal distribution
> mechanisms (e.g. RPM), other files cannot be signed remotely (e.g.
> configuration files).  For these files, both IMA and EVM may be
> configured to maintain persistent file state stored as security xattrs
> in the form of security.ima file hashes or security.evm HMACs.  The LSM
> flexibility of enabling/disabling IMA or EVM on a per boot basis breaks
> this usage, potentially preventing subsequent boots.

I'm not suggesting IMA and EVM don't have specific behaviors that need to
be correctly integrated into the LSM infrastructure. In fact, I spent a
lot of time designing that infrastructure to be flexible enough to deal
with these kinds of things. (e.g. plumbing "enablement", etc.) As I
mentioned, this was more of trying to provide a head-start on the
conversion. I don't intend to drive this -- please take whatever is
useful from this example and use it. :) I'm happy to help construct any
missing infrastructure needed (e.g. LSM_ORDER_LAST, etc).

As for preventing subsequent boots, this is already true with other LSMs
that save state that affects system behavior (like SELinux tags, AppArmor
policy). IMA and EVM are not special in that regard conceptually.

Besides, it also looks like it's already possible to boot with IMA or EVM
disabled ("ima_appraise=off", or "evm=fix"), so there's no regression
conceptually for having "integrity" get dropped from the lsm= list at
boot. And if you want it not to be silent disabling, that's fine --
just panic during initialization if "integrity" is disabled, as is
already happening.

Note that, generally speaking, LSMs have three initialization points:
LSM init, fs_initcall, and late_initcall:

$ grep -R _initcall security/*/ | wc -l
31

This, again, isn't different for IMA or EVM. The LSM infrastructure is
about gathering and standardizing the requirements needed to run security
hooks in a common way. The goal isn't to break IMA/EVM -- anything
needed can be created for it. The goal is to remove _exceptions_ to the
common hook mechanism.

BTW, are there examples of how to test an IMA/EVM system? I couldn't
find any pre-existing test images one can boot in QEMU, or instructions
on how to create such an image, but I could have missed it.

-- 
Kees Cook
