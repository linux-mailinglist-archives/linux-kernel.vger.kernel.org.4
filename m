Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE4BD6981F6
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 18:28:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbjBOR2O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 12:28:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjBOR2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 12:28:12 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C708E61A4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 09:28:11 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id 16so13215690pfo.8
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 09:28:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2ytIXtBMLaEzgl8nCOojDhuJnkjo8SNB1+fmJCWKDec=;
        b=fqg9pR4pkxUP+fSaVNFOyFumiQ7kCpUiFLpRoF9Yig0NoDdXKQsWHRpQ+pHiR4eK9s
         FWnb3OVGq37uC+1bap7XfR4iwwdkc32E12Ia3nwuPVrJZbzUayEC+1ZR9iAavvjeWr3X
         tSQtqkIMxSbFbaEMrNMuGAzXpWWeIc7Nvy6rIa0K5jdRDuIbU3T304htERUS5Ll2Grmn
         BeKmozhLYRnHVql6MiZZzbx2WatoAd7szmePWMDNuPjROL5OsDQMF0PgDHTfSJJN9X0l
         jgPUlYRhMcl8Hdg5wJo7w/X+ogL9poTri8dE/r/0lAOeavlJ77Ckty7Gw6LQRJkcY0+U
         4FsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2ytIXtBMLaEzgl8nCOojDhuJnkjo8SNB1+fmJCWKDec=;
        b=HRiTaBTjEZp9rPJis3QYtfEzsdVI4Fi7LXD0Ua+XI+Fy0i2ifh1GUwuSditbR3aO/p
         qTEpAJ8+KuDp5Vs904vIfZeAj5YP7NKNryWALTfusbqTc6IBidxYAeCIMbOSvcUOCLha
         VIm++J0YogcezbsGJ3YaVCoWxxC3GyQZOziJx4ovNA7QwYm9Kipfp1K5yV1Z9wRYMvqU
         BHuYKyXAOnxN/EgJUEA2VpeHIvaGQJvUOmLbh3UiPXcL3gb7wfuGv4Jz6dokz5srviHn
         FX0LLuRCLePllRLRe7j0eE8q8yjWlNwEYVSedni00xAzfBNqVXm9RxprDXG9JXPGRGl8
         vwJQ==
X-Gm-Message-State: AO0yUKXpY4zw7MmYqxT3w6FXDMHVbWguPEnecZVS54OZq+cUHEzrlfcs
        uyyeM7JQ2jm/OWnWHzn/PPEBEA==
X-Google-Smtp-Source: AK7set/WRs8AQercUyxungJ3ysiBO18zVNykQiapuwPrn3FrfbAa/2uLqMzNwJSXlUzZbzWP2r8mJw==
X-Received: by 2002:a62:1c44:0:b0:5a8:515a:eba4 with SMTP id c65-20020a621c44000000b005a8515aeba4mr2171491pfc.10.1676482090851;
        Wed, 15 Feb 2023 09:28:10 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id 15-20020aa7914f000000b0058d9428e482sm11895322pfi.85.2023.02.15.09.28.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Feb 2023 09:28:10 -0800 (PST)
Date:   Wed, 15 Feb 2023 17:28:06 +0000
From:   Carlos Llamas <cmllamas@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Jialu Xu <xujialu@vimux.org>, Vipin Sharma <vipinsh@google.com>
Subject: Re: [PATCH] scripts/tags.sh: fix incompatibility with PCRE2
Message-ID: <Y+0WJuh1fIg0oEpR@google.com>
References: <Y+snZioVyo82mAUj@kroah.com>
 <20230214204142.1514599-1-cmllamas@google.com>
 <Y+0MwIucdhrCVzs8@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+0MwIucdhrCVzs8@kroah.com>
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

On Wed, Feb 15, 2023 at 05:48:00PM +0100, Greg Kroah-Hartman wrote:
> 
> Shouldn't this get a "Fixes:" tag with the commit that caused the
> problem?  And if this affects older kernels (as it does), it should also
> get a cc: stable?

I was hesitant to mark 4f491bb6ea2a as the offending commit as it was
PERL5 and PCRE2 that decided to drop this functionality. The commit was
technically correct before this. However, you are right that this
impacts stable too and if it makes the backport process easier I'll add
the "Fixes:" tag and cc: stable as suggested.

--
Carlos Llamas
