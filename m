Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E406A5F7E1F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 21:37:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbiJGThr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 15:37:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbiJGThm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 15:37:42 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CFC680BFC
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 12:37:35 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id b5so5492768pgb.6
        for <linux-kernel@vger.kernel.org>; Fri, 07 Oct 2022 12:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ff9Lv+FN/GWXqwSTZxjiwDXpmSdIrf3YmbG0MGrPgVc=;
        b=VlRr1V6Idgt4KzWPPbvSMRO66kz+Ff0xHjzryukuShG1IzcFxi5flXPWCpSZUStDmy
         6oKq1tIeCGh6pfRD8nhd6T1eIWwsxa2OvJKOeKzEPWbjaj/VmcfbbxvbgZ+D908Q7wok
         4O87lpLH/tjBApdg/vyuzT8FNLXfEElHCzP8g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ff9Lv+FN/GWXqwSTZxjiwDXpmSdIrf3YmbG0MGrPgVc=;
        b=ZTQDlsJsfHHzxnpTyTndAHIrsps10/P0HDoZ8jZloeiMTnL10HngMTMBCTNnlhpTye
         Yz4HhZd0iYhCuqQPggp6/NxhUEGVc042QxLWH+o8NaYkt6J5USZRBgJelG35kP7fsxvj
         9bK27mC2I0nyON+a/XRcKzdmrW1I1ZScDPW/S1cH+nk0wSdfLXja0UJfB4Ch+DwhK3z8
         KpEW83atMTtr+LI7ZsQ0GtdCHXjcQCnB2wwvrughe4t6hZSShTmTtNB2/kqHF8FCoapF
         RGCv+fwCF8MrxCeZz8L3DDEjPpS5TrMj1cjTt+KCvo49ag8L99hYWPhFDDSKJaTHZ1oS
         gGjg==
X-Gm-Message-State: ACrzQf1uHRBKvw8aqX5M9vWp5H00Ix8U7L+ElcTZPAn10cY/BjpIppcW
        RaFH5mUKU+q2Xo4/PRDmdXDZdnyKz9hkHw==
X-Google-Smtp-Source: AMsMyM4irTfygNevj1c5d81McGTDpuVCk1drpk18tsm9PEpRiMfjA7Ogc3DgTMAzXp/16/4kyWk0nQ==
X-Received: by 2002:a05:6a00:3392:b0:547:f861:1fad with SMTP id cm18-20020a056a00339200b00547f8611fadmr6809701pfb.16.1665171454246;
        Fri, 07 Oct 2022 12:37:34 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id n1-20020aa79841000000b005289a50e4c2sm2038654pfq.23.2022.10.07.12.37.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Oct 2022 12:37:33 -0700 (PDT)
Date:   Fri, 7 Oct 2022 12:37:32 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        kernel-dev@igalia.com, kernel@gpiccoli.net, anton@enomsg.org,
        ccross@android.com, tony.luck@intel.com
Subject: Re: [PATCH 5/8] pstore: Fix long-term implicit conversions in the
 compression routines
Message-ID: <202210071234.D289C8C@keescook>
References: <20221006224212.569555-1-gpiccoli@igalia.com>
 <20221006224212.569555-6-gpiccoli@igalia.com>
 <202210061634.758D083D5@keescook>
 <CAMj1kXF27wZYzXm1u3kKSBtbG=tcK7wOwq6YTwpFg+Z7ic4siQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXF27wZYzXm1u3kKSBtbG=tcK7wOwq6YTwpFg+Z7ic4siQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 07, 2022 at 10:47:01AM +0200, Ard Biesheuvel wrote:
> On Fri, 7 Oct 2022 at 01:36, Kees Cook <keescook@chromium.org> wrote:
> >
> > On Thu, Oct 06, 2022 at 07:42:09PM -0300, Guilherme G. Piccoli wrote:
> > > The pstore infrastructure is capable of compressing collected logs,
> > > relying for that in many compression "libraries" present on kernel.
> > > Happens that the (de)compression code in pstore performs many
> > > implicit conversions from unsigned int/size_t to int, and vice-versa.
> > > Specially in the compress buffer size calculation, we notice that
> > > even the libs are not consistent, some of them return int, most of
> > > them unsigned int and others rely on preprocessor calculation.
> > >
> > > Here is an attempt to make it consistent: since we're talking
> > > about buffer sizes, let's go with unsigned types, since negative
> > > sizes don't make sense.
> >
> > Thanks for this! I want to go through this more carefully, but I'm a fan
> > of the clean-up. I'd also like to get Ard's compression refactor landed
> > again, and then do this on top of it.
> >
> 
> Isn't this the stuff we want to move into the crypto API?

It is, yes. Guilherme, for background:
https://lore.kernel.org/linux-crypto/20180802215118.17752-1-keescook@chromium.org/

-- 
Kees Cook
