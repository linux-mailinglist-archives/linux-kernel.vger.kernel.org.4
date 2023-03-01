Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 705636A6C23
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 13:11:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbjCAMLO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 07:11:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjCAMLN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 07:11:13 -0500
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 041643A876
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 04:11:12 -0800 (PST)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-536bbe5f888so359409757b3.8
        for <linux-kernel@vger.kernel.org>; Wed, 01 Mar 2023 04:11:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gIjv8wTxws2tEgCoRyOLyxbnH/NFNqoZJZnY4FJxenU=;
        b=Nf1ctbON/Xa+HGQqhkTja6yP7nrbZJxwW1ZEKkvtHotZ/zGBzwRlUj4+eIaCjelQ4O
         NWXIry4I1qeSRin/7bhObDRaARldmmgXJSVEVPay5BqoT5GaF3hRNSEdK9UqlqX5iHD+
         3EWVofJ6IJac3Y/iszjbgQwrweq6qI+BM8e8lZdjF/vEdfPqx7GDFSG8ypMrt2qL+b2D
         pCTk9q1JKJ5yjda6FctUFUDAiDfG5mBTB1iF2T3DFhAlP+IHse3f+Wz4qFQOIrw1OF7V
         vDviwWRecl7xI/Zxm6WDTDsVaSju+V5TybyBrNJeozBw++gJQUKkD9N62jflM312cvU1
         H7sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gIjv8wTxws2tEgCoRyOLyxbnH/NFNqoZJZnY4FJxenU=;
        b=JkEccqlgH//ylxGI1R4ngl4+puqcNmHwBepBURlOfKk55/8CxNUgDrm5aPQsj09sb5
         hGRDEuV+poCqN1eIUR2b++99zlerLDdIHOD1cDKhfbtg8hkP50bOsUbtiki2uUTCw+WJ
         tAp9Ugquv5nHAmmFGcGiO1kw6LXQ8bQBVKEJtJy6s+FQLVgmO4kjyAenHDJwX6bU+yfL
         TZGe2MKLyESM/ibB35Ngtcx/DfkdWIgnG8WXOJ0tRPXcuh3vgicd9MpGJs9XhiNookWH
         NI+N0ON2Wdpo7BfGPDEojaLcPg7sK8hQ4kzq0v55CurYJjbuHq1i8UGU0smfGC9FugyR
         T0tg==
X-Gm-Message-State: AO0yUKUUgwHtGFKiFN8ot92rruZXMlkljiED6oXSKLRsGqSdr2YilQz7
        rwZMg8KPzNLzYZXBZnuuLiyZnPkx+nKn/zdEE42w4g==
X-Google-Smtp-Source: AK7set+Tu72vHlqdk+Utvb4jVZuScfGBW6iIUq7EkBuVeAuJvrgg2VHRkGymv+keK6qg6lrEzw1CAJ2PwjcxJ1uASN8=
X-Received: by 2002:a81:4005:0:b0:52e:dddf:82b9 with SMTP id
 l5-20020a814005000000b0052edddf82b9mr3672453ywn.10.1677672670881; Wed, 01 Mar
 2023 04:11:10 -0800 (PST)
MIME-Version: 1.0
References: <20230301012506.1401883-1-saravanak@google.com>
In-Reply-To: <20230301012506.1401883-1-saravanak@google.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 1 Mar 2023 13:10:59 +0100
Message-ID: <CACRpkdYvSv0=FcsPUpmiBT86ocJaEtZF=c=Qty6FzdVsSPggzw@mail.gmail.com>
Subject: Re: [PATCH v1] clk: Mark a fwnode as initialized when using
 CLK_OF_DECLARE* macros
To:     Saravana Kannan <saravanak@google.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernel-team@android.com, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 1, 2023 at 2:25 AM Saravana Kannan <saravanak@google.com> wrote:

> The CLK_OF_DECLARE macros sometimes prevent the creation of struct
> devices for the device node being handled. It does this by
> setting/clearing OF_POPULATED flag. This can block the probing of some
> devices because fw_devlink will block the consumers of this node till a
> struct device is created and probed.
>
> Set the appropriate fwnode flags when these device nodes are initialized
> by the clock framework and when OF_POPULATED flag is set/cleared. This
> will allow fw_devlink to handle the dependencies correctly.
>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reported-by: Linus Walleij <linus.walleij@linaro.org>
> Link: https://lore.kernel.org/lkml/CACRpkdamxDX6EBVjKX5=D3rkHp17f5pwGdBVhzFU90-0MHY6dQ@mail.gmail.com/
> Fixes: 4a032827daa8 ("of: property: Simplify of_link_to_phandle()")
> Signed-off-by: Saravana Kannan <saravanak@google.com>

Excellent Saravana, this fixes my issue!
Tested-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
