Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F3F06082DC
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 02:29:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbiJVA3H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 20:29:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbiJVA3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 20:29:03 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0C352B4E85
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 17:29:02 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id k9so3750614pll.11
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 17:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vbin2EPqUmXPJ6xPLH+ERynu4O+L2S0zduYye9vK2V4=;
        b=JCKRRiNYR9C40uQh2CHaKj9sSleYIthTr605LiwWq+EFYDkEoqEevgZlMgh8vPNRk6
         PF4zbp2AL5KrkyZFbBnhuXdDoL10LLi0geZm8snrMXH6kR4BHW72WqhePZ6ozAzwREOv
         Ejp6bnGxylG+JW2FqGLXHiJN42NdFnbNaAOsE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vbin2EPqUmXPJ6xPLH+ERynu4O+L2S0zduYye9vK2V4=;
        b=TF9V674cwEB9/NPZiYGSHaFO+ElT2p9/syAQYLwYp//dE/DBB84e+zCfbOjjndT+3C
         iL5csGQv2mI4+KdVqjjiYbEgQsWjsDdbpunvOf8iocoqZxgD+AA9a6wp9RU/ulX1rS/6
         +ogNAnoa4y3/WgAe2LK8O3pZOh+tYFgO5AscWy2vSrezX61zGKUDh7eUnuI+5SIqZPYo
         CUwDL2FHnylpmMc1j4p1Z/Ur4F1gweSqqcma60iMCLZ9yLggjQgblF4sm7vqVye9D4q/
         0I+ELTT8VGMPhx+fjxqGysnwKZBVX7NL/7OX6MJcSZVVpW0WEvpTq9d7VOviyDEGs4ll
         A+WQ==
X-Gm-Message-State: ACrzQf0W/ZOiTKWt8ETmG8bUrOIp9v0YE7g633hJw77FnYMmZ9tCd4ii
        sFQNM+gQ4z6OD7mryCzvd0ZhkA==
X-Google-Smtp-Source: AMsMyM5ATXbUbYr3pLTSGOUKefFCpmfHiVhlEARSHoYpzgEfEEB2a8QsQTARugBvJm/il4ZnFYrWtw==
X-Received: by 2002:a17:90a:ad05:b0:212:c550:f0e9 with SMTP id r5-20020a17090aad0500b00212c550f0e9mr9614764pjq.246.1666398542367;
        Fri, 21 Oct 2022 17:29:02 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:d6f0:dbbb:c195:162])
        by smtp.gmail.com with ESMTPSA id x16-20020a17090a165000b0020aaa678098sm2127398pje.49.2022.10.21.17.29.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 17:29:01 -0700 (PDT)
Date:   Fri, 21 Oct 2022 17:28:59 -0700
From:   Brian Norris <briannorris@chromium.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Benson Leung <bleung@chromium.org>,
        chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
        Samuel Holland <samuel@sholland.org>,
        Julius Werner <jwerner@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>, stable@vger.kernel.org
Subject: Re: [PATCH] firmware: coreboot: Register bus in module init
Message-ID: <Y1M5Sw6Zs8PYzIIu@google.com>
References: <20221019180934.1.If29e167d8a4771b0bf4a39c89c6946ed764817b9@changeid>
 <af9c4bfd-d3fb-1c7a-fb38-0d8bbd507449@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af9c4bfd-d3fb-1c7a-fb38-0d8bbd507449@roeck-us.net>
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 19, 2022 at 06:20:08PM -0700, Guenter Roeck wrote:
> On 10/19/22 18:10, Brian Norris wrote:
> > Currently, get_maintainers.pl tells me Greg should pick this up. But I
> > CC the chrome-platform list too, since it seems reasonable for Google
> > folks (probably ChromeOS folks are most active here?) to maintain
> > Google/Chrome drivers.
> > 
> > Let me know if y'all would like this official, and I'll push out a
> > MAINTAINERS patch.
> > 
> 
> I think that would be a good idea.

Done:

[PATCH] MAINTAINERS: Add drivers/firmware/google/ entry
https://lore.kernel.org/lkml/20221021172624.1.I119456791d197eb7d159f09e7479d8759008a954@changeid/

Brian
