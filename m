Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C95585BDB54
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 06:20:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbiITEUH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 00:20:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiITEUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 00:20:04 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B8D221E39;
        Mon, 19 Sep 2022 21:20:03 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id q3so1731571pjg.3;
        Mon, 19 Sep 2022 21:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=8W++mQUvSSiZYDmTJHzAKiPmuDVQP9ByjdOW/BfpvAA=;
        b=R8eXOgPthRbfn7XaZp9SfDXQbc+pMGow7oVsoOSmvm5Upin22H7lFvqpu8+rdPnfl7
         hRIwdc+Pr7roFGpkREpEirTQuvW6yqHBz0xnMGX7JWLTYAEqlZB54/M9iao7q1X+EKSi
         yVqx9XCEUKhc9VOpP4A22eTUTCsHsK9uh8Un45NrBXOFgsKjvtobbuWVHxsoEryqQ3cC
         IjzumQky4SJKL9v/6rRDRJ6QdJGhKkMmZXAcPNhRkqAVcrnyoPOaPUkmfiLfdy3qeHie
         VHSXHvfpXN/RCl6Jkn+Mgz+gM086XSFAddzbeo0FZhRRWkCS2YAAdiI+CysjzW9KzHxP
         3aVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=8W++mQUvSSiZYDmTJHzAKiPmuDVQP9ByjdOW/BfpvAA=;
        b=zE0qmm5tlV/UkOV1sHSf8sMh6rVJvKjUvAhi0ptuKcApX828S8JqwK0dh8lTNuj0Zb
         +vc44sB6wK3I7wDHbuXQFWCYGKEFd7yDcqerHLi4BZTv4AADYSYMbGRI8YNV3KvYXjzl
         ZVa0Cr9hZ5pvoGH3+TtPyHR+dsxhjtBCAAEj/iTPy8auAvGMKUpJkYUCwmLUBFLkC85b
         9bWmRueYgEMsN1VV5vWbOSBkjB7bW74HERgcZsO5B8nB4Dgq1XFBDT0KI3ib3F84FvjO
         7jPdkodQ3NtQrQJXlTt1+Wvru9BpArtPL6PSjsgkp906uZRH40GoMLi//vCZaqNwxStB
         Snsw==
X-Gm-Message-State: ACrzQf2Z3+M5MaUAtEWBJ2vlL467ckjYe/3aWpUu54RuE96qyTwKor9K
        /m5aBmxO1NHlScuOWyT4Hhw=
X-Google-Smtp-Source: AMsMyM5Ba2tOWGG85vx4ihGR87exW6KXXAeL/IXoBUH+Ga1jMQuGL0yo1wLt+wDKn9U0dPe/GlDk7g==
X-Received: by 2002:a17:902:7c11:b0:178:a6ca:4850 with SMTP id x17-20020a1709027c1100b00178a6ca4850mr3097414pll.111.1663647602763;
        Mon, 19 Sep 2022 21:20:02 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:b095:5d5d:4c28:8088])
        by smtp.gmail.com with ESMTPSA id jj11-20020a170903048b00b00176da1aae5asm255288plb.70.2022.09.19.21.20.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 21:20:02 -0700 (PDT)
Date:   Mon, 19 Sep 2022 21:19:59 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Yunlong Jia <yunlong.jia@ecs.corp-partner.google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Henry Sun <henrysun@google.com>,
        Douglas Anderson <dianders@chromium.org>,
        Bob Moragues <moragues@chromium.org>,
        Yunlong Jia <yunlong.jia@ecs.com.tw>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johnny Chuang <johnny.chuang.emc@gmail.com>,
        linux-input@vger.kernel.org
Subject: Re: [PATCH v3 2/2] input: touchscreen: elants_i2c: Add eth3915n
 touchscreen chip
Message-ID: <Yyk/b29aG2ivpkf5@google.com>
References: <20220909102720.v3.1.Ib599a6001558a4afd11016e7016d74dce748a749@changeid>
 <20220909102720.v3.2.I22ae48d8ee064456073a828393704809360c4368@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220909102720.v3.2.I22ae48d8ee064456073a828393704809360c4368@changeid>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yunlong,

On Fri, Sep 09, 2022 at 10:27:55AM +0000, Yunlong Jia wrote:
> The eth3915n requires more delay time than the eth3500 when poweron
>  & reset.
> Define EKTH3915_POWERON_DELAY_MSEC as the poweron delay time of eth3915n,
>  about 80ms.
> Define EKTH3915_RESET_DELAY_MSEC as the reset delay time of eth3915n,
>  about 300ms.
> 
> Signed-off-by: Yunlong Jia <yunlong.jia@ecs.com.tw>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> 
> ---
> 
> Changes in v3:
>  1. Add poweron delay time.

This materially changes the patch so I do not believe you should have
kept Doug's reviewed-by tag. I also do not understand what this delay is
for. Is this the minimal time for the reset line to stay high? Something
else?

Thanks.

-- 
Dmitry
