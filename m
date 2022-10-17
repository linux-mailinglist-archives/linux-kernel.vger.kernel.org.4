Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D465A601942
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 22:20:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbiJQUUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 16:20:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbiJQUUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 16:20:07 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54A1D1838F
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 13:20:05 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id l3so6031376ilg.13
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 13:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YRhYRpu0dqcQqekWtrDSxx4wp7OV63THRnBbHmneQ6c=;
        b=JOcKnnsMgsvnDqvKq8PYNhfupjvgGBGw3g+v847kkpzYhIUEQXqIKJfFkxr1v9j55T
         7K0yIgTzhaTsmlQ4XC6RigOPPWH97io+/ZUu2Qbs7gca1D7xan6Y4DanT/hlz4pkBtYX
         m1CkBiewUM/YBQO0SdHRMlCrk6WoLuQ8lGT4w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YRhYRpu0dqcQqekWtrDSxx4wp7OV63THRnBbHmneQ6c=;
        b=DJIWv3kEA/ruuFfmsVQAuR/rRv6kvNpUUXnZk9RO3x0ZFAyDbZqXc0VV8V5073AM4V
         o7RA7YYRwIXX1a0pNsTsScQI2UBfOV63sVr3rVvY0wNHM1VW61UOplPMD/9kI9EX6DdP
         CS7WQjmfas55wylL1BfaFmRVbR3HFsqUTPo1pcYd4l4GjbhyFE3Ut1QgDtAN6QJ3xe5F
         JMlPYWf5VitJY84t5aYmRI8Af5Fb5X4Zb+IzshULojJacO9FA7O/UTOnco+EQv9Ypx0B
         4cNiLnH0a4jI7gmHlLAg4MwfGzjLo7omCKGPEhFhVqxPpa+Bnl0WzSuI9vSgYuIb/v8k
         JmhQ==
X-Gm-Message-State: ACrzQf2sNOmxz8JFqHsLKYBQRPCFHQAZDpkZEW/vqps6EOTQyh2OAf1V
        74FCYUiBhhokex0ZoOm+NSDeOGR2Tvq/sg==
X-Google-Smtp-Source: AMsMyM6a7CHPqvMR2O2WUbQyA5wKqbTmwfHTLJSaaEwQMqUlWpn7DpLoZ+m3j6KoKDuQItOiGt0JOA==
X-Received: by 2002:a63:2a81:0:b0:43c:5fa6:1546 with SMTP id q123-20020a632a81000000b0043c5fa61546mr11977034pgq.43.1666037485318;
        Mon, 17 Oct 2022 13:11:25 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a188-20020a624dc5000000b005629d8a3204sm7673993pfb.99.2022.10.17.13.11.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 13:11:24 -0700 (PDT)
Date:   Mon, 17 Oct 2022 13:11:23 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] pstore: migrate to crypto acomp interface (take 2)
Message-ID: <202210171307.32A5D9C07@keescook>
References: <20221006234138.1835739-1-keescook@chromium.org>
 <191ec24d-35d4-e4e5-85f7-d7301984e647@igalia.com>
 <202210171100.5BAC4A5CC8@keescook>
 <CAMj1kXHzrRTVcxb5+hgUPV3tjekPcDWzVf6cG_Mc9JJmYBz2Mw@mail.gmail.com>
 <202210171227.35ED875219@keescook>
 <CAMj1kXEJQ8gh-iXZNL8bNcmV=JCmKHNp5BnhYthhSOyR5h79_g@mail.gmail.com>
 <202210171237.DF5D4A3FD7@keescook>
 <CAMj1kXGmsJNg7En-55aRF+ApicPD_Opkh8Jw+oTorSOSO+cfuw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXGmsJNg7En-55aRF+ApicPD_Opkh8Jw+oTorSOSO+cfuw@mail.gmail.com>
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 17, 2022 at 09:45:08PM +0200, Ard Biesheuvel wrote:
> On Mon, 17 Oct 2022 at 21:40, Kees Cook <keescook@chromium.org> wrote:
> > Okay, so strictly speaking, eliminating the per-CPU allocation is an
> > improvement. Keeping scomp and doing in-place compression will let
> > pstore use "any" compressions method.
> 
> I'm not following the point you are making here.

Sorry, I mean to say that if I leave scomp in pstore, nothing is "worse"
(i.e. the per-cpu allocation is present in both scomp and acomp). i.e.
no regression either way, but if we switch to a distinct library call,
it's an improvement on the memory utilization front.

> > Is there a crypto API that does _not_ preallocate the per-CPU stuff?
> > Because, as you say, it's a huge amount of memory on the bigger
> > systems...
> 
> The library interface for each of the respective algorithms.

Where is the crypto API for just using the library interfaces, so I
don't have to be tied to a specific algo?

-- 
Kees Cook
