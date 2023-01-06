Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 860B9660800
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 21:16:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236680AbjAFUQW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 15:16:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236631AbjAFUPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 15:15:55 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 980D182F57
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 12:14:27 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id w4-20020a17090ac98400b002186f5d7a4cso6358027pjt.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jan 2023 12:14:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=euU3G/ya0gtqqY9FQvfGrmCYDfDSO1DRx03jpA8QOoU=;
        b=DxpJV32juCIC7h57KYTRrjCuSAEKETG43oBjZgf71yvmAQHb0L6DqYb1TF0bUPTUta
         zq/0lgACacdY+WTeXku5JZ3Y1TAbuKWHPO8sa/cyKEk48X+V8Ut3URpj3vxBHM867N28
         dEqxrQbhpBIzPD95jnlH21RK+ftUvSSFMAtOc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=euU3G/ya0gtqqY9FQvfGrmCYDfDSO1DRx03jpA8QOoU=;
        b=ShgVIWAOtreR7aMpHy/MIYvZwUJYVKHvGzqbzKWNHoytfox82UqLb7L0VpNrv/On2w
         gNuD//mT6xiqZCTaMlMRMAl+NaKOTmTW+8syq+gdi3c+96vFu5xtIqPZ6GI0WHEW/mW9
         V2Ewl5J6SCr//f3P+5kkwDi8HnYN1Z+j9fer/QHIGSNhHJpHJKZybttUPAK68gfDf4ti
         ihJD6F4DMP1DLzzl+U3jYf5m7nvKr2EGIVV0LK9F9Gfn+cA1njbXe8hSG/uW3DpTcq0O
         4HJobFro0qvvCOFA0KQSnUEl8JOuv9j4hXbx9tu1CIbSTFdDoOy7qAkXhGxrStAvo0rN
         QcQA==
X-Gm-Message-State: AFqh2kp34ZQGkAA8swAo4JBxo0H/gHNKR5gzD3h9eNDiDVbbZMqZUTmw
        GfSyeRixxS+u+B+NceU8jMtQpw==
X-Google-Smtp-Source: AMrXdXtkvQ+XpEzmJFaUJ0JVX00yVP9flnzGcmoU0MwhgVx2K6M1UpjXmeQnvV8L4me6P8O7LDJT/A==
X-Received: by 2002:a05:6a20:3d26:b0:a7:8c43:d669 with SMTP id y38-20020a056a203d2600b000a78c43d669mr74101910pzi.51.1673036019131;
        Fri, 06 Jan 2023 12:13:39 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e2-20020a170902784200b0019309be03e7sm1347726pln.66.2023.01.06.12.13.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jan 2023 12:13:38 -0800 (PST)
Date:   Fri, 6 Jan 2023 12:13:37 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Cc:     Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        kernel test robot <lkp@intel.com>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Sean Anderson <sean.anderson@seco.com>,
        Alexandru Tachici <alexandru.tachici@analog.com>,
        Amit Cohen <amcohen@nvidia.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: minimum compiler for Linux UAPI (was Re: [PATCH v3] ethtool:
 Replace 0-length array with flexible array)
Message-ID: <202301061209.4EA0C177@keescook>
References: <20230106042844.give.885-kees@kernel.org>
 <CAG48ez0Jg9Eeh=RWpYh=sKhzukE3Sza2RKMmNs8o0FrHU0dj9w@mail.gmail.com>
 <CAMZ6RqJXnUBxqyCFRaLxELjnvGzn9NoiePV2RVwBzAZRGH_Qmg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMZ6RqJXnUBxqyCFRaLxELjnvGzn9NoiePV2RVwBzAZRGH_Qmg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 06, 2023 at 11:25:14PM +0900, Vincent MAILHOL wrote:
> On Fri. 6 Jan 2023 at 22:19, Jann Horn <jannh@google.com> wrote:
> > On Fri, Jan 6, 2023 at 5:28 AM Kees Cook <keescook@chromium.org> wrote:
> > > Zero-length arrays are deprecated[1]. Replace struct ethtool_rxnfc's
> > > "rule_locs" 0-length array with a flexible array. Detected with GCC 13,
> > > using -fstrict-flex-arrays=3:
> [...]
> > > diff --git a/include/uapi/linux/ethtool.h b/include/uapi/linux/ethtool.h
> > > index 58e587ba0450..3135fa0ba9a4 100644
> > > --- a/include/uapi/linux/ethtool.h
> > > +++ b/include/uapi/linux/ethtool.h
> > > @@ -1183,7 +1183,7 @@ struct ethtool_rxnfc {
> > >                 __u32                   rule_cnt;
> > >                 __u32                   rss_context;
> > >         };
> > > -       __u32                           rule_locs[0];
> > > +       __u32                           rule_locs[];
> >
> > Stupid question: Is this syntax allowed in UAPI headers despite not
> > being part of standard C90 or C++? Are we relying on all C/C++
> > compilers for pre-C99 having gcc/clang extensions?
> 
> The [0] isn't part of the C90 standard either. So having to choose
> between [0] and [], the latter is the most portable nowadays.
> 
> If I do a bit of speleology, I can see that C99 flexible array members
> were used as early as v2.6.19 (released in November 2006):
> 
>   https://elixir.bootlin.com/linux/v2.6.19/source/include/linux/usb/audio.h#L36
> 
> This is prior to the include/linux and include/uapi/linux split, but
> believe me, this usb/audio.h file is indeed part of the uapi.
> So, yes, using C99 flexible array members in the UAPI is de facto
> allowed because it was used for the last 16 years.
> 
> An interesting sub question would be:
> 
>   What are the minimum compiler requirements to build a program using
> the Linux UAPI?

You're right -- we haven't explicitly documented this. C99 seems like
the defacto minimum, though.

> And, after research, I could not find the answer. The requirements to
> build the kernel are well documented:
> 
>   https://docs.kernel.org/process/changes.html#changes
> 
> But no clue for the uapi. I guess that at one point in 2006, people
> decided that it was time to set the minimum requirement to C99. Maybe
> this matches the end of life of the latest pre-C99 GCC version? The
> detailed answer must be hidden somewhere on lkml.

I would make the argument that the requirements for building Linux UAPI
should match that of building the kernel...

-- 
Kees Cook
