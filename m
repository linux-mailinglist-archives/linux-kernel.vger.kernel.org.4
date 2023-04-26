Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9B116EFC65
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 23:22:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233643AbjDZVWU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 17:22:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjDZVWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 17:22:19 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0646E3A9F
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 14:22:18 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-64115e652eeso341689b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 14:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682544137; x=1685136137;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+a377yCD1wSb+Qu8Ib9DWat+5hlFzs3PwSGlnB4gbjU=;
        b=ryzPabqBQwhFylX0rvzXob4cLb11By20FCmqTGU3ClS2fd0qXPHCYL+CL4N18kacJV
         JgUNUldXU+snxKa/jqwK8PxHjS73u44KJebunfB6zuG673vnOGZfM1wd4c5HMwINDFnX
         4TvkgE2GlatrMtae4CPNcEDJPHbIfsF/A1+2GCkiblTrhyAYME1Fs/wuxiyxO88L1W1M
         E0f+PJ4oqKYcU2qIoeq6+U2JM5FIryenp1ucY1RrRsiBxQmb1O7BR9tyo/oU1v0L9PgE
         vA9O5eCeISSG98ccRvLimOEo3RKr3Bpiazg+jkmHITkBFaWa9PVsli6JzjE7WVG0Mgzk
         hFzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682544137; x=1685136137;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+a377yCD1wSb+Qu8Ib9DWat+5hlFzs3PwSGlnB4gbjU=;
        b=T9gUOTeOCbObrHnDvHoFCkKm7pbdFOGtlwh6DimdPDQgAE5nsrSMUDz5H/YeVguNw7
         7+Kf5VwUTLbNTRJSq8OG20ryhnBMwfuzE+2jpKBCyxHL+sUL2jGWc/3ygAJOyVZra+O2
         cdx8D+XOQS9rrU+cJPd9aPfZ1TOk0kUHvTisH0ZIvae6TAGu9JlYJIZ3/q4Nfp0+5PAf
         f5BMKx5Sb5TRmh02Trknxi8RZ1/OvWVpARzFORHBoppyPOiRhcU0ivahWdh3J0yIkdk1
         ExrFm+lwXiuQK+yxKtyJLVQt9wlTV+h2CuW+ziaggVzHSDrNbL1dDAK/N6Op35A7+FGa
         1IZQ==
X-Gm-Message-State: AC+VfDyoscHumshQpE95O8+6SME87U0vOBQsdgVF7/4cB+g9BG2dN0+A
        mZrBtnuqadzwL7aVTxRxu1NJ2Q==
X-Google-Smtp-Source: ACHHUZ7NgXoOrUmgkrPNWaGKrwZDIMoIzqaxuGehwFA0p0mZQp7W5FLRWAq9jI1V1FcTphBgEFfJZA==
X-Received: by 2002:a05:6a00:99b:b0:63b:7489:f77 with SMTP id u27-20020a056a00099b00b0063b74890f77mr5206312pfg.0.1682544137258;
        Wed, 26 Apr 2023 14:22:17 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id j9-20020a056a00234900b0063d3d776910sm11756164pfj.138.2023.04.26.14.22.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Apr 2023 14:22:16 -0700 (PDT)
Date:   Wed, 26 Apr 2023 21:22:13 +0000
From:   Carlos Llamas <cmllamas@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <brauner@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        Liam Howlett <liam.howlett@oracle.com>
Subject: Re: [RFC PATCH 1/3] Revert "binder_alloc: add missing mmap_lock
 calls when using the VMA"
Message-ID: <ZEmWBYRYwgj2GikY@google.com>
References: <20230424205548.1935192-1-cmllamas@google.com>
 <ZEdi2Gd_eWiJ1CrP@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZEdi2Gd_eWiJ1CrP@kroah.com>
X-Spam-Status: No, score=-14.5 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,FSL_HELO_FAKE,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 25, 2023 at 07:19:20AM +0200, Greg Kroah-Hartman wrote:
> On Mon, Apr 24, 2023 at 08:55:46PM +0000, Carlos Llamas wrote:
> > This reverts commit 44e602b4e52f70f04620bbbf4fe46ecb40170bde.
> > 
> > This caused a performance regression particularly when pages are getting
> > reclaimed. We don't need to acquire the mmap_lock to determine when the
> > binder buffer has been fully initialized. A subsequent patch will bring
> > back the lockless approach for this.
> > 
> > [cmllamas: resolved trivial conflicts with renaming of alloc->mm]
> > 
> > Cc: Liam Howlett <liam.howlett@oracle.com>
> > Cc: Suren Baghdasaryan <surenb@google.com>
> > Signed-off-by: Carlos Llamas <cmllamas@google.com>
> > ---
> >  drivers/android/binder_alloc.c | 31 ++++++++++---------------------
> >  1 file changed, 10 insertions(+), 21 deletions(-)
> 
> Why is this series "RFC"?  What needs to be done to be able to submit it
> as a real patch series?

No real reason. Just wanted to get feedback from the mm folks first.
I'll go ahead and submit the v1.

> 
> Also, as the commits you are reverting are in older kernels, please
> properly cc: stable in the signed-off-by area, and add a fixes: tag for
> the commit you are reverting when you resend these as a real series.

Sounds good, thanks!
