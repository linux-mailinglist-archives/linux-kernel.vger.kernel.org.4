Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8206B5EC5BB
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 16:17:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231178AbiI0ORV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 10:17:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230180AbiI0ORR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 10:17:17 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F41D9F3129
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 07:17:15 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id e129so3463013pgc.9
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 07:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=TE1h0tXI69QqgJWcHgjeTioa3ZwRda4MJ9Sc/wCDzzg=;
        b=YN7Mog61UCCTVS94silmiyUdd7/fRmgBomGNgBtBb+O9AagrFmf4B6OaZsEPXvHnja
         FX3mNlWYFgetXs5tZ+szcYmgV6mzGOawlhOYpA+f9ISmsal9WvJEeRuYbqncBP6Z5WW9
         WPnl2MeU0OzUQs5gDOwI02PIermPYtYnURsIc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=TE1h0tXI69QqgJWcHgjeTioa3ZwRda4MJ9Sc/wCDzzg=;
        b=ZC8cRP/JJxCPjr8gnkMvGPgk1awV+OTLVqvDcLwP4d/x/B3TqraG6beA6lGC6+o9kI
         Rvz93ihe2ztooSAj5Zpg9HFsvGyJgcKEHgeTJQzLaR5Lml9igUgeaL/5AmNVXGmdFuda
         l1b2shrY2OmHIQvAVTZLYkkjI59HJcasF7XQAfZi3mlbD3ILn7Ej8jf1SfdUltqYUa2J
         gNf4KeZ05IOVykjrMEl07Cj3MR6tuj/mJWnlhOBnnLF+LvA1on6tkm/ljNgc5Y86xE4y
         v6F0tPGJHHHrYaq2ahCQgNxcUvFNKkpsrt9RiabzIo9COoPZ9afrZeADXkzog3EmqyoX
         Pgow==
X-Gm-Message-State: ACrzQf1OCsPG5jpdEovVOEqX3UMxsA4VotKYvnAJtOa+Civm4Y2rql1C
        b61p/LgvbCOqA9cKmr3FodWAWtVFQY3Wdw==
X-Google-Smtp-Source: AMsMyM7KbY/E60EbyRjcklkSOysNEnDaz9fVUnoMOgz7UGZURZ/ymeWMECXglF9T1HFfeqaGrOkpcw==
X-Received: by 2002:a05:6a00:22cf:b0:545:90f3:8b96 with SMTP id f15-20020a056a0022cf00b0054590f38b96mr30197003pfj.58.1664288235077;
        Tue, 27 Sep 2022 07:17:15 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u9-20020a170902e5c900b001769206a766sm1594503plf.307.2022.09.27.07.17.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 07:17:14 -0700 (PDT)
Date:   Tue, 27 Sep 2022 07:17:13 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] random: use init_utsname() instead of utsname()
Message-ID: <202209270717.E8B133F28@keescook>
References: <20220927092920.1559685-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220927092920.1559685-1-Jason@zx2c4.com>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 27, 2022 at 11:29:20AM +0200, Jason A. Donenfeld wrote:
> Rather than going through the current-> indirection for utsname, at this
> point in boot, init_utsname()==utsname(), so just use it directly that
> way. Additionally, init_utsname() appears to be available nearly always,
> so move it into random_init_early().
> 
> Suggested-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
