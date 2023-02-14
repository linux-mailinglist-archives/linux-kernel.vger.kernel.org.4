Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21473696C14
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 18:54:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233178AbjBNRyd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 12:54:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232067AbjBNRyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 12:54:31 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B199F2D160
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 09:54:30 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id gn39so3768551ejc.8
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 09:54:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gqG/enM8HfFTvnPDTpPzWk+Glm0amvtJkxf2NVo378E=;
        b=F+u65dsx99puM87w0HTzdq91Z0GfWip8hAbSdGjMMAN4XnQWUxvrD78auJ/6uRGwB2
         n3MHj6R+v/jFIpV6WZGax/PLLHuAW73dsd51EGdX4rRw1ddLtG1dK9u5CFfbwyz1CWP3
         bMtMSrbwjB44kodOjX9RvlF5yKfhU3XqIfoI4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gqG/enM8HfFTvnPDTpPzWk+Glm0amvtJkxf2NVo378E=;
        b=2R+bfzqOb6ksRGwY46YJRJE7wAUmao8o6kU7Q4cGQznt/cWk0m6PWv7ldZvt0t1W/z
         4wrLeLA8zLixuuDJSaYqZXoiHBhdNNO+i92hG3LWs1ypzo7Tcffcy0Nrulq/qHVpf0VL
         +CDrTkGX7M8X20gUnFlOYqY59k+H2CacGItE5/TzR14nV1LRSKWzyGaDSAPEGLBr4WZc
         lzYmiJX9ZpkPbLMACzc9QehSLr8xVzP+Q+7Q2hNLeSO/bQlSegCOVWqXp5NWbSkwijNy
         oB97LIqW2wgjyL//3LOF6BpVPzbgsRgAkdbiG93MpmesCb5V2m6O4IJrupkaEfFnlJKw
         +j1Q==
X-Gm-Message-State: AO0yUKUuvhzhK6FEFqzzxBDVzegvMjel7aqGoLrGwov71FmhhhyAiLqw
        9hh0u8AVquMwLkffc5gg/kXyzW2j5944WSapzzM=
X-Google-Smtp-Source: AK7set9B00JG39N/UceXxzR0nJLRlGW5XGv5FHgm1HVALHy0nz3+H2Qe5jkMtOa32njJmV3R3qMG7g==
X-Received: by 2002:a17:906:d8b:b0:888:4f0e:bb72 with SMTP id m11-20020a1709060d8b00b008884f0ebb72mr3403799eji.40.1676397268933;
        Tue, 14 Feb 2023 09:54:28 -0800 (PST)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com. [209.85.218.53])
        by smtp.gmail.com with ESMTPSA id z10-20020a17090674ca00b00889db195470sm8544622ejl.82.2023.02.14.09.54.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Feb 2023 09:54:28 -0800 (PST)
Received: by mail-ej1-f53.google.com with SMTP id qw12so42124119ejc.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 09:54:28 -0800 (PST)
X-Received: by 2002:a17:906:8585:b0:8af:2ad9:9a1d with SMTP id
 v5-20020a170906858500b008af2ad99a1dmr1732354ejx.0.1676397267927; Tue, 14 Feb
 2023 09:54:27 -0800 (PST)
MIME-Version: 1.0
References: <20230213144745.696901179@linuxfoundation.org> <05984672-d897-6050-3e8b-3e7984c81bd9@roeck-us.net>
 <1cd10087-87fe-048e-c9ed-0a5d32c50764@roeck-us.net>
In-Reply-To: <1cd10087-87fe-048e-c9ed-0a5d32c50764@roeck-us.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 14 Feb 2023 09:54:11 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgnKpVzL14X0+cLQcWuQmjPAvgrDGF69JRMjgc4rA0VfQ@mail.gmail.com>
Message-ID: <CAHk-=wgnKpVzL14X0+cLQcWuQmjPAvgrDGF69JRMjgc4rA0VfQ@mail.gmail.com>
Subject: Re: [PATCH 5.10 000/139] 5.10.168-rc1 review
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de
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

On Tue, Feb 14, 2023 at 9:51 AM Guenter Roeck <linux@roeck-us.net> wrote:
>
> Reverting the nvmem patches fixed this problem.

But upstream is fine?

                 Linus
