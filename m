Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98D77601A6F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 22:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231411AbiJQUio (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 16:38:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231190AbiJQUiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 16:38:17 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1EEB80E8D
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 13:36:09 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id e129so11464094pgc.9
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 13:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/DNUgQk7rQANqDSMtoJoYUOw4oQuNQKM8I6m3nk0AGE=;
        b=YzfeGM4m6J3abKwEOKljd0JgEPkmOomTt9HwLUISAMGSblNS7OCJ6O1zBMqf6PhsmN
         zCU8Z5hHj4bkVMMh7lc4lbGrHTkQl24Fr9jCl4EgMhMr8/W9Hg3rdPzraOFFL8lW7ZAq
         bVGWYOz9cE8Kz7gBzvDAHlQtq8ZgNUyoGVB8U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/DNUgQk7rQANqDSMtoJoYUOw4oQuNQKM8I6m3nk0AGE=;
        b=mgQFdUB0F7cxwu6oOHm+1NhY8973RW1txnwzKYrJJS4RtJzutK9el3Bab93DHjLZBF
         XUiygmusMQXNmftKnJyE85ozkZruvRkeduUkyhqef1JAaFsBOQPDxRkAYJq6bHBNsuQy
         IXyyfZTEmYtABMaIw7UrGvEWVmEVa9uF55Fw0bWFjuZCNOiKPoyntboE2ri3f1h+42ao
         hUlKN3/BqXs002bWEX+G22FLMAKbhbnJqZIi++s3suKsxtKLZ6Xn9K4kAytwUq993EP+
         oD5rK4fwWc0PISTahIjV+c2/bjWBVIVyoNP2eOZXjURB2yHPTSYqU7umEzNYAmvoSieG
         m9og==
X-Gm-Message-State: ACrzQf1C0SemebMRGhZLv87vE9UkdHvfqxVN9d0fC0XustN1Jshnw8hZ
        F5krHfaeHEwqlRccnGUCATVbIw==
X-Google-Smtp-Source: AMsMyM68pSTudLPa7hJy8BAwqvdQjj1kQLn4ssdt75W+B4lqRnrjftLjk8uol0BPMm6mdcJmNtwVjA==
X-Received: by 2002:a63:c145:0:b0:44e:9366:f982 with SMTP id p5-20020a63c145000000b0044e9366f982mr12011932pgi.584.1666038957593;
        Mon, 17 Oct 2022 13:35:57 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w1-20020a170902ca0100b00174f61a7d09sm6963867pld.247.2022.10.17.13.35.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 13:35:56 -0700 (PDT)
Date:   Mon, 17 Oct 2022 13:35:55 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] pstore: migrate to crypto acomp interface (take 2)
Message-ID: <202210171333.309A3D9@keescook>
References: <20221006234138.1835739-1-keescook@chromium.org>
 <191ec24d-35d4-e4e5-85f7-d7301984e647@igalia.com>
 <202210171100.5BAC4A5CC8@keescook>
 <CAMj1kXHzrRTVcxb5+hgUPV3tjekPcDWzVf6cG_Mc9JJmYBz2Mw@mail.gmail.com>
 <202210171227.35ED875219@keescook>
 <CAMj1kXEJQ8gh-iXZNL8bNcmV=JCmKHNp5BnhYthhSOyR5h79_g@mail.gmail.com>
 <202210171237.DF5D4A3FD7@keescook>
 <CAMj1kXGmsJNg7En-55aRF+ApicPD_Opkh8Jw+oTorSOSO+cfuw@mail.gmail.com>
 <202210171307.32A5D9C07@keescook>
 <CAMj1kXHced1khwsrHqMUmECh_7irYOckFd+Sx3z9KSmsL7tPxw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXHced1khwsrHqMUmECh_7irYOckFd+Sx3z9KSmsL7tPxw@mail.gmail.com>
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 17, 2022 at 10:13:52PM +0200, Ard Biesheuvel wrote:
> On Mon, 17 Oct 2022 at 22:11, Kees Cook <keescook@chromium.org> wrote:
> >
> > On Mon, Oct 17, 2022 at 09:45:08PM +0200, Ard Biesheuvel wrote:
> > > On Mon, 17 Oct 2022 at 21:40, Kees Cook <keescook@chromium.org> wrote:
> > > > Okay, so strictly speaking, eliminating the per-CPU allocation is an
> > > > improvement. Keeping scomp and doing in-place compression will let
> > > > pstore use "any" compressions method.
> > >
> > > I'm not following the point you are making here.
> >
> > Sorry, I mean to say that if I leave scomp in pstore, nothing is "worse"
> > (i.e. the per-cpu allocation is present in both scomp and acomp). i.e.
> > no regression either way, but if we switch to a distinct library call,
> > it's an improvement on the memory utilization front.
> >
> > > > Is there a crypto API that does _not_ preallocate the per-CPU stuff?
> > > > Because, as you say, it's a huge amount of memory on the bigger
> > > > systems...
> > >
> > > The library interface for each of the respective algorithms.
> >
> > Where is the crypto API for just using the library interfaces, so I
> > don't have to be tied to a specific algo?
> >
> 
> That doesn't exist, that is the point.

Shouldn't something like that exist, though?

> But how does the algo matter when you are dealing with mere kilobytes
> of ASCII text?

Sure, though, this is how we got here -- every couple of years, someone
added another library interface to another compression aglo. I tore all
that out so we could avoid having to choose a single one, but was left
with the zbufsize mess (that, yes, doesn't matter). So now pstore can
just not care what compression is chosen.

-- 
Kees Cook
