Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0B9B6B6E78
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 05:30:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbjCME35 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 00:29:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbjCME3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 00:29:53 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 057C22A6FA
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 21:29:53 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id ja10so1913153plb.5
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 21:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678681792;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tGBVFM9mbPIVHC9rXj6OPzc8C/19j9yNx14zyFsXvH8=;
        b=M2+xZ+iNboDHIPqIHwVoeH+JSPyVg4gRbP/fwxPAK+klraSPF1gtiOK1YfND/ws7kY
         ym17y111uOhbLczAdv9ek0SUb18hhuinTBDDwTqd0hUk2BWjVv2B4oA47jlv9mPQBg+d
         3JWbXc2W9B0V6j1xmvGPs81aev1RjrfY4Mgre6V71pfwUOmphAO04efNlLxDeI9D0H6u
         rSaymUDWsIvHhNroWPNbhSXq67iYXqv0aG0nfrEXSDwYCLy8QNwJHquRU/tY4yRjrD2J
         OBFcf7Bn7oSzRX6AhpuflnLxtO1qNDFWXNAPskw+BjY7RicpkxRFYY63fxEBCX63V+r2
         CKqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678681792;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tGBVFM9mbPIVHC9rXj6OPzc8C/19j9yNx14zyFsXvH8=;
        b=GWCyqM+pHCCB+vGDe7O6gTVcEFK83YMmqOzo9QdeKRGi8LlGAM0zlpYhJ1T4aE6yid
         NgHQwOPl092Meb0nsARK/NRHBR5nlvpE0UCUGq+3dShC+7Yk1ernUHZe4BNN4fFguAfM
         qXboNMnHr6vBwsR4qsv1nNYRQkEuxYEJpe+/XFpCzWAN2kzTjncmhRUT4SCpHWcdDXMg
         018cHBSNOQWM7Q8EN9MVvfeo5/Oe3M0+e6e5UiFfRbB2SQ5rB/Jsu6GWnFc1esYKmDda
         CNeXl8sdmfKJkK/45uG5763SmITyYHSu/N6UTbZy7SGPtwt2DbxaLlr5ZtRd8+v6/36S
         8CEQ==
X-Gm-Message-State: AO0yUKUeKU2j8aIyidlJTqt8mWRCK5qNfhJQaKVqBOl8U36ynrUAXSP1
        iuPcvA2xqUpM/uMgv8AtH9ZQuImIC40YRfVqBBc=
X-Google-Smtp-Source: AK7set/xWr1pRI/17n1xuEpcm3qLqtNJ7KA+F/Z2u8xgNVhZ0jI3WoYxGu5AlyQXxhp9qtU1Gx6spg==
X-Received: by 2002:a17:902:ce92:b0:19c:f8c5:d504 with SMTP id f18-20020a170902ce9200b0019cf8c5d504mr15905079plg.59.1678681792544;
        Sun, 12 Mar 2023 21:29:52 -0700 (PDT)
Received: from localhost ([122.172.83.155])
        by smtp.gmail.com with ESMTPSA id y64-20020a636443000000b004fbb48e3e5csm3592427pgb.77.2023.03.12.21.29.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 21:29:52 -0700 (PDT)
Date:   Mon, 13 Mar 2023 09:59:50 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] opp: Use of_property_present() for testing DT property
 presence
Message-ID: <20230313042950.n5o3nufftybnbvbf@vireshk-i7>
References: <20230310144719.1544374-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230310144719.1544374-1-robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10-03-23, 08:47, Rob Herring wrote:
> It is preferred to use typed property access functions (i.e.
> of_property_read_<type> functions) rather than low-level
> of_get_property/of_find_property functions for reading properties. As
> part of this, convert of_get_property/of_find_property calls to the
> recently added of_property_present() helper when we just want to test
> for presence of a property and nothing more.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/opp/of.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied. Thanks.

-- 
viresh
