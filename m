Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1402361547A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 22:57:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbiKAV5X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 17:57:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbiKAV5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 17:57:21 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D550C13EA8
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 14:57:19 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id l22-20020a17090a3f1600b00212fbbcfb78so287153pjc.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Nov 2022 14:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IHsWXQ49lddtj26zGFMc9IeJUhtq7xWwaZJ/MCojYX8=;
        b=K89JQH8oIioWEZWTcsH3xMptW613Ahz9m/s1j2ziS7uaCmmQJWvT6yOgjljh+WPC1Q
         QVubGByb0ISay5Djv+DYsLVZ9OanmBDrEZ2oo0sFOB1GXUnhHt9IQmtKWfcGoORJWsIQ
         mmbq8VC/EaIVpySyczVvu9cGJaEIGdvB1aUSY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IHsWXQ49lddtj26zGFMc9IeJUhtq7xWwaZJ/MCojYX8=;
        b=6xMiLa5DPqZO/jZPVvVa/SIihy3e3ab9KwS+4487s7bkYI9YN6ScqTjncjgL87idEs
         IM5lJc7xNFaejCDrpa2jh52NUzZbmmN/9gjTkGIhU5zMu1j556QIZ6IVvgWHpzLtrGB+
         7lMXw2Nlw6vJxHrYtiSOe4k1z8Xc8BbLn/rdDdb4hKjeVA2releej6Lr8GgB4o3JM1Rj
         UODxiTjZOEFY/qMLzynTgP89qfaxHtzkQqJ1YCcvAAsE4k6d7FCAj7cwyPzoekIhwOrk
         uXzT+QddeMxO1+z9VwX0eIEanHJDpwIgKZGzE4XQ3vCAplKUQpycACpTWoGvj7cmFR+p
         Gdjw==
X-Gm-Message-State: ACrzQf3Iykc+YsTYtxtRZmV8YnTr8wDeAviDP6EodXz5u8iyTcbnKJmJ
        +PJ/DjJXrx5+TBWG08cfa+jdNr3a8DPXoA==
X-Google-Smtp-Source: AMsMyM5kJ4jjmnBy9Y7rFPCgzA5dY/0CFB4OzDmPzwVetJE3f5UU8d75DlyTrzC31QtKCVuv1AbKKw==
X-Received: by 2002:a17:90a:2a8b:b0:213:9ae5:b9ab with SMTP id j11-20020a17090a2a8b00b002139ae5b9abmr22489555pjd.110.1667339839417;
        Tue, 01 Nov 2022 14:57:19 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q8-20020a170902dac800b0017854cee6ebsm6866474plx.72.2022.11.01.14.57.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 14:57:19 -0700 (PDT)
Date:   Tue, 1 Nov 2022 14:57:18 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Dr. David Alan Gilbert" <linux@treblig.org>
Cc:     shaggy@kernel.org, jfs-discussion@lists.sourceforge.net,
        linux-kernel@vger.kernel.org,
        syzbot+5fc38b2ddbbca7f5c680@syzkaller.appspotmail.com
Subject: Re: [PATCH] jfs: Fix fortify moan in symlink
Message-ID: <202211011456.6B73479@keescook>
References: <20221022203913.264855-1-linux@treblig.org>
 <202210241021.6E9E1EF65@keescook>
 <Y1beLWto/J2W1Stu@gallifrey>
 <202210281526.B32C79C4@keescook>
 <Y10hBcMrAYPZzghw@gallifrey>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y10hBcMrAYPZzghw@gallifrey>
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 29, 2022 at 01:48:05PM +0100, Dr. David Alan Gilbert wrote:
> * Kees Cook (keescook@chromium.org) wrote:
> > This looks like a GCC bug (going at least back to GCC 10.2)[1], but some
> > extra care around the macro appears to make it go away, so the reporting
> > variable doesn't get confused/re-evaluated:
> 
> Thanks for chasing that; are you also going to file a gcc bug?

No, I haven't had the time to minimize a PoC, so I'm not sure it would
make a very good bug report.

-- 
Kees Cook
