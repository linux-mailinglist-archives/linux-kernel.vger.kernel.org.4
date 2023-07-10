Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7176474DD3B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 20:21:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233215AbjGJSVL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 14:21:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233210AbjGJSVG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 14:21:06 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14812189
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 11:21:05 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-579d5d89b41so58719897b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 11:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689013264; x=1691605264;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yhm7lkAW9orMfOYHjd/5dYd0uQAaVWnXZNrOPRGwAMk=;
        b=bauIEglhYtSUpQEGJ5MFJO2lO1bljPT/PQiw41sSQa66PlAtksYyxnngkbJTaRzi0k
         LfANZdalulYnZgfp9gsAl3A2bLrM9ZV8SRfzZVAwnmhSvRY8X3XpAR5PPKPOiqmMfTFo
         xo3JGAEQYnnHz8I5VSf95fwUgMwY/GoW1d9IHHrWF4LG93tW/6QTUJo0AD2RGWkSIHlQ
         zeXeP/jj1//A97wgFvXjCfbEydu/z7/0T2Dm6ZuV7fANw23IilCiz2J7MH2qTsyvsQSC
         kC9s/SWnJeoCnkIVtxjVCPIaZUk7JBfxERDuJ/2ZFqP1IF1ho9nfPK8jvVr4nNuw4+Dv
         /ugQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689013264; x=1691605264;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yhm7lkAW9orMfOYHjd/5dYd0uQAaVWnXZNrOPRGwAMk=;
        b=jtgCgBzJL1iwVS+61Vezj2OyVkYWiDUBMRZlRCIObcBVdng8XY5BD6urVWVc8J2Mr8
         UpSCq3ShVbIyFTzM9LUEaV9wvMbgBF7+EhXUBaRz4xb7D2au+WIxxcNnv1IJXdrscpsL
         ZFvdPjr2GXCwASd+jVrFMZT/M8QzBEn1jUq6ZlqhBdIZg/8m4agk3LuIjzTyrG8rEydn
         fhRtZxafQxcfTnw0AX3qZcdItxHl6gS3IzDjjaxgqQymn6Ewdy6/G+PM7JrPDb92uk16
         qvvp8CiIEPfDByJzQ7SPp0GJ8hvH+/sKl2DM2pGQ299OJ8YgMOyt3fw5mZV4wxVipT5q
         SKcw==
X-Gm-Message-State: ABy/qLZDXZTZQfclg9dtPTDqQOcpcxefHCjzt9+dBa10ynExHC0GNQRt
        jg1TmI1UOdZJJWN4pWcyQNbJcNHsV/s=
X-Google-Smtp-Source: APBJJlFTqnqFcKqqwUhppO6qdx3bWwI4+Dl3oTjfbS88WWdNOtiVzYXHJlktPl5wWi1tavnTxS5azQ==
X-Received: by 2002:a81:6754:0:b0:577:65ea:78fb with SMTP id b81-20020a816754000000b0057765ea78fbmr14881970ywc.19.1689013264158;
        Mon, 10 Jul 2023 11:21:04 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y66-20020a0def45000000b00565d056a74bsm95160ywe.139.2023.07.10.11.21.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 11:21:03 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 10 Jul 2023 11:21:00 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 6.5-rc1
Message-ID: <f9380db1-fe66-4793-a4b8-1fdfe8b79f3f@roeck-us.net>
References: <CAHk-=wj8sPDVoWgaceAs1AiwZrHV8mtC3vQNGbeV6-RypJi6aw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wj8sPDVoWgaceAs1AiwZrHV8mtC3vQNGbeV6-RypJi6aw@mail.gmail.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 09, 2023 at 02:17:59PM -0700, Linus Torvalds wrote:
> Right on schedule two weeks after the 6.4 release, here we are and the
> merge window is closed.
> 

Build results:
	total: 157 pass: 156 fail: 1
Failed builds:
	sparc64:allmodconfig
Qemu test results:
	total: 520 pass: 502 fail: 18
Failed tests:
	<all sh4>

The failures are tracked at
https://linux-regtracking.leemhuis.info/regzbot/mainline/.
The following patches are needed to fix the problems.

sh: mach-r2d: Handle virq offset in cascaded IRL demux
sparc: mark __arch_xchg() as __always_inline

Guenter
