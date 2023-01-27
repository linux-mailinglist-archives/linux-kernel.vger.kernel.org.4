Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8D4567EDE3
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 19:55:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233768AbjA0Szc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 13:55:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbjA0Sza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 13:55:30 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1E211BEA
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 10:55:29 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id r18so3785385pgr.12
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 10:55:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Igfps6aP8kh1+cVeMvcSa2ip+rhsULh5w6MIHdX1qiA=;
        b=gyuAr7eMmv7qZydl+v1ADBW7yoM2NhxQAz6d9mX1DdnuKP1KCeOvm/r0THWV6tk06Z
         Bvs50RYXhjzKLl552/kpoAvoewpcbltY6Offj/ogQi1oTCNleyb8nFwjCMR9daIpodrq
         2lbZ6/JT727RxFcp/ea6re3J2LmW2sahkCqCo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Igfps6aP8kh1+cVeMvcSa2ip+rhsULh5w6MIHdX1qiA=;
        b=s2pqjbBFYiRYYDrXUOYcwR+xPaXWvTRO/bNXr97CEU+pfMGEXWbyD+Q9tyailyGOhW
         fKotN50pZj4j4vglKpZJbxX4iWSe7R8YGpGwtE/NCz2TAd+yrXz/S1G9sV9n/YQsCm7z
         PyY5Rv5U9x3/8lCyL3Tj+C2wfxkPavYPRykREglATHDoSAQPQBxkQV396BV8pJ5TWbEy
         DNcdWjnyxzsXh6ZcsNMKeAVLiFrRA6+xx5ZVJhuDYmcJE2Ev+LgFoEZAo5u9/QLcLsBf
         9AN7i9Cs3JTjEh8mNFHA0qCITiLU3Kk5194duezmiemgoSYYJQfmcB6Bh1RxSTGg1w06
         wHqw==
X-Gm-Message-State: AO0yUKWW88S8fWfiYB8kxGEssZKI1ETl6mBQD54LnmOVg4OZWbXqoCZ0
        RqZqUPxWRBVNbK19VDiCr3xDmg==
X-Google-Smtp-Source: AK7set/tABYg6nKPM2cH7tzqLY1+kEINdEyNRQlVu2/jJroTea1vkMnVqL2yIp5EQ92nmg/qU4r8kw==
X-Received: by 2002:a05:6a00:21c2:b0:592:5eab:3402 with SMTP id t2-20020a056a0021c200b005925eab3402mr4882696pfj.28.1674845729170;
        Fri, 27 Jan 2023 10:55:29 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c7-20020aa78c07000000b00576259507c0sm2963985pfd.100.2023.01.27.10.55.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 10:55:28 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     andriy.shevchenko@linux.intel.com, linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>, andy@kernel.org,
        linux@rasmusvillemoes.dk, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v1 1/1] lib/string: Use strchr() in strpbrk()
Date:   Fri, 27 Jan 2023 10:55:25 -0800
Message-Id: <167484572215.2632904.14390662378665291104.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230127155135.27153-1-andriy.shevchenko@linux.intel.com>
References: <20230127155135.27153-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Jan 2023 17:51:35 +0200, Andy Shevchenko wrote:
> Use strchr() instead of open coding it as it's done elsewhere in
> the same file. Either we will have similar to what it was or possibly
> better performance in case architecture implements its own strchr().
> 
> Memory wise on x86_64 bloat-o-meter shows the following
> 
>   Function           old     new   delta
>   strsep             111     102      -9
>   Total: Before=2763, After=2754, chg -0.33%
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] lib/string: Use strchr() in strpbrk()
      https://git.kernel.org/kees/c/a5f5ee7c49da

-- 
Kees Cook

