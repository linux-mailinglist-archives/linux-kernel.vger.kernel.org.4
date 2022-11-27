Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20686639CCF
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Nov 2022 21:31:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbiK0UbZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 15:31:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbiK0UbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 15:31:12 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A1B0E0E2
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 12:30:59 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id h16so5559829qtu.2
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 12:30:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VVVV5Ph5SK/OS62unjAwI3Y7rdzzZ2t2R4gZShlA4OM=;
        b=WeQaiAyw9KILxh5RJhge3ru/9yApAWiKaCjRKqKhLfZkEBpQhxjQRnFbRZoP0GaLSj
         NRnRlEzBbL4gnwtWe6Oofbt+x1QUokHkiFiRTve97LK1L9uUu6oWXRU1zC61E7FGZKB/
         a24NLF/BmVlln5+LSHa2jKgFhf9MgoW+ibel8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VVVV5Ph5SK/OS62unjAwI3Y7rdzzZ2t2R4gZShlA4OM=;
        b=cNFU+7TqjGdoH/BOohnuV03y52+6hWuSwzB+oiXBprfYCzBjIv5T5Q5/JbJBjsKp14
         l23IGIjEgVrZvPl6VZWi303SUU9SZW2uAVJR9b7/x3c1Z3URcaLnjt0eD6AAGxx162uM
         8JuVwA6QhkC1G6WgG8YgZnpT1Pm63L0mgJXoYwJpkY4nDV1GiNscYHMdObdj9RGi/RcK
         lWnChrNgDMhPWL+hxWkJnybCA874Kp4ffuGDltPqVZJH49eGpuNyhmWbZ2dSWv/iXoRs
         y/FRhvatndQDjdoO+eQXi8bqadbtidCToOCkcLM0HRQDLchrRIvMJCafZ9QMcBj06sum
         03dQ==
X-Gm-Message-State: ANoB5pmXl1xgkGdYeUdeiQCkUkQ1yAiO+ySQZBvcnvt2UW0lq9Eb+EDd
        Jk6Y+bxdOLvypOSoygn1Fu5/Gx5ra0u9Bw==
X-Google-Smtp-Source: AA0mqf4XZxxsqeQm/jCgZ1j5vfMeVqWb7rLH+Lb08XSbDms2JkcnLezhk7h0FDqbmz+mHls1tBIG0Q==
X-Received: by 2002:a05:622a:5a14:b0:3a5:bf05:f0dd with SMTP id fy20-20020a05622a5a1400b003a5bf05f0ddmr26916063qtb.342.1669581058290;
        Sun, 27 Nov 2022 12:30:58 -0800 (PST)
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com. [209.85.160.173])
        by smtp.gmail.com with ESMTPSA id r9-20020a05622a034900b003a526675c07sm5832042qtw.52.2022.11.27.12.30.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Nov 2022 12:30:57 -0800 (PST)
Received: by mail-qt1-f173.google.com with SMTP id w9so5521493qtv.13
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 12:30:57 -0800 (PST)
X-Received: by 2002:ac8:518b:0:b0:3a5:49fa:3983 with SMTP id
 c11-20020ac8518b000000b003a549fa3983mr44383440qtn.436.1669581056930; Sun, 27
 Nov 2022 12:30:56 -0800 (PST)
MIME-Version: 1.0
References: <166956961686.104691.2021186998003391429@leemhuis.info>
In-Reply-To: <166956961686.104691.2021186998003391429@leemhuis.info>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 27 Nov 2022 12:30:41 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgDryP6ezpPJADG+g0KvLcbO4Q-y2d64wgifKBc+mB9gQ@mail.gmail.com>
Message-ID: <CAHk-=wgDryP6ezpPJADG+g0KvLcbO4Q-y2d64wgifKBc+mB9gQ@mail.gmail.com>
Subject: Re: Linux regressions report for mainline [2022-11-27]
To:     "Regzbot (on behalf of Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 27, 2022 at 9:32 AM Regzbot (on behalf of Thorsten
Leemhuis) <regressions@leemhuis.info> wrote:
>
> Hi Linus! Below is a slightly edited report from regzbot listing all
> regression from this cycle that the bot and I are currently aware of.

Thanks. This looks fairly reasonable (assuming I get that networking
fix next week - the others are in the "won't delay a release" category
as far as I'm concerned).

But it looks like I'll be doing not just an rc7 but an rc8 regardless
of the current regression state just because I still see too much
noise.

              Linus
