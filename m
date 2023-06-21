Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BCDC7392B6
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 00:53:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbjFUWxE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 18:53:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjFUWxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 18:53:03 -0400
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24B5919AD
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 15:53:01 -0700 (PDT)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-3f90a7325f6so53901485e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 15:53:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687387979; x=1689979979;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uvR4SCXMnMvvYTlmOiv87jstI8F7pVUARWzRPGoDViU=;
        b=B3XnY+SyYiAHiq+PUtvgg0JmbNCxSSRdM8MRmKUexED7FJwHHg7ZgfOb0b+xM6tpux
         uWQLAb6UYuN3PYRdurZSVCNukPTfrU390qZ5qPfsWDP+9dG/7Ghe1SMC0sZFXDkz2QrC
         tKUOb+BhSQq9rHdslIAq/R+zatITPKkmu0yH4GwLlDjrgbihvwkd86akMAz4sjGSYtLp
         V1NMMerTMa/LMhN4jFNFhdzCGjRxgu9yHYdYPTqK7zdamRbHpg5iZ6oVmZktZX2ZPvSQ
         wik/ugOeO2MbSiDPtjMWAGC2mT3vGdiPWXCcWTcCGAnbsbc9aQrlP3jVHrzOsgPdOlEy
         d6CQ==
X-Gm-Message-State: AC+VfDx5kq0uj7E0Pfd58pt+OEqn4cOeRUrl2kUMFOMc+xbT8yQNajww
        42I13ClGXRLtFR10fNRC9AU=
X-Google-Smtp-Source: ACHHUZ7u8X+j5g+8PtY0h1lYZMLMML5unUptQVn/ww2JQuiLTuM6xsHxmoqfF3/cUIjWPUQebVmJtg==
X-Received: by 2002:a7b:cd08:0:b0:3f7:e8e2:f377 with SMTP id f8-20020a7bcd08000000b003f7e8e2f377mr13753995wmj.12.1687387979295;
        Wed, 21 Jun 2023 15:52:59 -0700 (PDT)
Received: from gmail.com (fwdproxy-cln-117.fbsv.net. [2a03:2880:31ff:75::face:b00c])
        by smtp.gmail.com with ESMTPSA id x16-20020a05600c21d000b003f90b58df65sm11369755wmj.29.2023.06.21.15.52.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 15:52:58 -0700 (PDT)
Date:   Wed, 21 Jun 2023 15:52:56 -0700
From:   Breno Leitao <leitao@debian.org>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>, leit@fb.com,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] x86/bugs: Break down mitigations configurations
Message-ID: <ZJN/SGwvOBZmChJw@gmail.com>
References: <20230616164851.2559415-1-leitao@debian.org>
 <20230621001327.qdyebewnx7r5aiy3@desk>
 <ZJMdKUr98H8zPSAl@gmail.com>
 <20230621173135.wiprtgzslhw5z5or@desk>
 <ZJNDRSUZuZ2L+pwo@gmail.com>
 <20230621194101.bmwesljror2yqjxx@desk>
 <d9bc78ed-1f05-47db-e916-d4d8bc76634e@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d9bc78ed-1f05-47db-e916-d4d8bc76634e@intel.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2023 at 03:35:45PM -0700, Dave Hansen wrote:
> On 6/21/23 12:41, Pawan Gupta wrote:
> > Yes, a single series (or a patch) that adds config for each mitigation
> > would be good.
> 
> Do people _really_ want per-mitigation compile-time controls?  That
> seems like kinda a pain.
> 
> I Boris suggested it, but it seems like a _bit_ of overkill to me.
> 
> Would a compile-time option that just defaulted _everything_ to
> mitigations=off behavior work instead?  That way we don't end up with a
> billion new config options.

This is exactly what my original patch proposed. It solves the problem with
a few lines of changes.

https://lore.kernel.org/lkml/20230203120615.1121272-1-leitao@debian.org/
