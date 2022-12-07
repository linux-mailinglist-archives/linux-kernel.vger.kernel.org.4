Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F263646455
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 23:54:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbiLGWyW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 17:54:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbiLGWyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 17:54:20 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0604A2AEB
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 14:54:20 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id k7so18444644pll.6
        for <linux-kernel@vger.kernel.org>; Wed, 07 Dec 2022 14:54:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=X95/3NyG/PFSS/i+8U7qOxb5jThhUkb5XEu6rEhsTrU=;
        b=Z7haVOgwEq5sAekY9q8Ah2yUkKEM7ScPk7TCouLeeQ6VRp+7x0O5YnnThjcPvw9eL3
         KOnmJ5C4cR+91vITC1Nt3f9pptmGwBqGffqt1VXnfm1Imi16sADA39GBVPxU/1nDNWA0
         kABjSVNBjxJcMkXHy/SGtUrTZHa0bCcf5WYAo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X95/3NyG/PFSS/i+8U7qOxb5jThhUkb5XEu6rEhsTrU=;
        b=TiY8j/HJ2xgC5VRj1Yrnw5tIiLFZ3Qa+4wgblhcYdPrAAPOl4YRU18+kFoEY0CiG45
         Re1/r7UO0SAzjM8jIQNf6bUor6nvbrM70sUCHZIUdZjP4jmy621xgWf95ic1xk7cvr/O
         nfUvIA8Rd2VXynvE05POK0FLdyMzQWSUJlfIZPtdy2/UWWMbrz4344Ti6uE2YO/0CRAv
         y/6GmTmrJdnIaPO64/GVHaLcv33xvzSO3eo2b0Gt4meUIhPeBu8a17xMqWrNPAuwHBKG
         Rsxxx4g8dCFOdM5cMUD/q8ElRyAYGX5ZqVm/XdeI2S6PHvY4GDPUFL8BeXjrDCKGYjkr
         1NYg==
X-Gm-Message-State: ANoB5pn8fcGrfQuDJmpyELMx7H7/Hhna0uGpG/Gw2km8nRW+jjTZw/fb
        8zj4EEOGgUp+bt4z+EhLPU2dOw==
X-Google-Smtp-Source: AA0mqf4KODRFHXuxWbkkNT/qeEQ77F4Z9AxFhfXBiw0kmuY9J9oZiSPLig3c4735F3k64jx8jjIwsg==
X-Received: by 2002:a17:90a:ff04:b0:219:eeb9:943f with SMTP id ce4-20020a17090aff0400b00219eeb9943fmr998410pjb.49.1670453659460;
        Wed, 07 Dec 2022 14:54:19 -0800 (PST)
Received: from chromium.org (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id lj9-20020a17090b344900b002139459e121sm1647137pjb.27.2022.12.07.14.54.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 14:54:18 -0800 (PST)
Date:   Wed, 7 Dec 2022 22:54:17 +0000
From:   Prashant Malani <pmalani@chromium.org>
To:     Victor Ding <victording@chromium.org>
Cc:     linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev,
        groeck@chromium.org, dustin@howett.net, gustavoars@kernel.org,
        gregkh@linuxfoundation.org, sebastian.reichel@collabora.com,
        dnojiri@chromium.org, lee.jones@linaro.org, bleung@chromium.org,
        tinghan.shen@mediatek.com, tzungbi@kernel.org,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH v2] platform/chrome: cros_ec_typec: zero out stale
 pointers
Message-ID: <Y5EZmSSbOFRpfBNj@chromium.org>
References: <20221207093924.v2.1.I1864b6a7ee98824118b93677868d22d3750f439b@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221207093924.v2.1.I1864b6a7ee98824118b93677868d22d3750f439b@changeid>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Dec 07 09:39, Victor Ding wrote:
> `cros_typec_get_switch_handles` allocates four pointers when obtaining
> type-c switch handles. These pointers are all freed if failing to obtain
> any of them; therefore, pointers in `port` become stale. The stale
> pointers eventually cause use-after-free or double free in later code
> paths. Zeroing out all pointer fields after freeing to eliminate these
> stale pointers.
> 
> Fixes: f28adb41dab4 ("platform/chrome: cros_ec_typec: Register Type C switches")
> Fixes: 1a8912caba02 ("platform/chrome: cros_ec_typec: Get retimer handle")
> Signed-off-by: Victor Ding <victording@chromium.org>
Acked-by: Prashant Malani <pmalani@chromium.org>

Hey Tzung-Bi, it looks like you've already created a tag for the
v6.2 pull request, so I don't know if it's too late to apply this
for the current dev cycle.
So, I've not applied it, but have left the Acked-by tag.

Please feel free to apply it if there's still room for it before
you send out the pull request.

Thanks!
