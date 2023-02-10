Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1D356921B8
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 16:13:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232057AbjBJPNj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 10:13:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232462AbjBJPNg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 10:13:36 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1174F60B89
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 07:13:35 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id bu23so5367866wrb.8
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 07:13:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WIBKwdpMrpMvAU3dHz5Us90PL8NGmQBL8Vt76hdqTzo=;
        b=XqfCRC0HuDy1nUS+Y8/8F2UBcId7Pw2oC8kP8R8DAi6nszdnjk/5WWgAXGtbDcAIR0
         BXxkL7mMT72zgwaJT0dn2uhqgKzi3fPeDJIiJIPjxWKwbUGvm6j7eRkxjN4bDEU6PyMI
         XhMuCi2J9y/hWMS1GLGa8MHtOpnnnjmZCmB+Kqst7BLtjcR+bry9mKzHJXtDId7i3Jw8
         W/bpaGwjbHEkqjdrdhc2pz9XyjLSuGtKGshXv3Ez0dhyE+U43YRBywQlLafUbNv/v3hY
         c10Cz17gFH8ciLZmqEZwvAR2U4v+0jUL03N9+l5d7SQMOe0z+68mYmUs5uxpW9AlAwKQ
         wRAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WIBKwdpMrpMvAU3dHz5Us90PL8NGmQBL8Vt76hdqTzo=;
        b=sZcgKFHNJTo7MgPIRj/yVph0MrgAAbML6Dk1ScP4ehEQa13Pdu4Cw63i3KiKgdMyEe
         AHiJjWD8WasNyICprnxnrPcJ3KYkXca9h5KJtlS5S0GBNoOpU0DYbimKCqpAHFfsonYR
         u4frKbo3jQuhE2COCAX3NL5Z5lz557lhhupGn1ni4ZQfwYtOpVZ31TzpYpL8E9B3OWUx
         0SQuEH+3KDYSSLOLCMfV9d7dwwheTIhR5KaBTF0oclxgjKrnSgdxnHOSdEMP+eCpL+Ta
         dAxTKZlqbEjk1+C96ogoFNpS+E5OrZpA0CsADcPjJ6eV+SHmcz1F+2Smx7TzEZLxJ+lP
         5qMw==
X-Gm-Message-State: AO0yUKXYVLTC2LZF3hYeMbt3mo75YDBcUz9hl7v1ZKxv+an+N/lEAFpM
        cIDNFtpSv3xiE99CkR88N9kbvjHXbIAPd06XtNTYw73uGEt6PsrP
X-Google-Smtp-Source: AK7set9SDzPWVVe4cj9dUHsYRe1cEQ8jSGR1CMOIh7XUqYoqZbfWISR41pkYw7cDbGn17A0nO4wT4xh8ALFpK8YCQyI=
X-Received: by 2002:adf:dcc3:0:b0:2c3:ea92:3491 with SMTP id
 x3-20020adfdcc3000000b002c3ea923491mr473436wrm.477.1676042013418; Fri, 10 Feb
 2023 07:13:33 -0800 (PST)
MIME-Version: 1.0
References: <20230210123644.489-1-svc.sw.rte.linux@sma.de>
In-Reply-To: <20230210123644.489-1-svc.sw.rte.linux@sma.de>
From:   Eric Dumazet <edumazet@google.com>
Date:   Fri, 10 Feb 2023 16:13:21 +0100
Message-ID: <CANn89i+v06zKLoMEP-cVzhZsm8mEs+q2eWeSDMCgQ9Q=OSznDQ@mail.gmail.com>
Subject: Re: [PATCH] net: Fix unwanted sign extension in netdev_stats_to_stats64()
To:     Felix Riemann <felix.riemann@sma.de>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 10, 2023 at 1:37 PM Felix Riemann <svc.sw.rte.linux@sma.de> wrote:
>
> From: Felix Riemann <felix.riemann@sma.de>
>
> When converting net_device_stats to rtnl_link_stats64 sign extension
> is triggered on ILP32 machines as 6c1c509778 changed the previous
> "ulong -> u64" conversion to "long -> u64" by accessing the
> net_device_stats fields through a (signed) atomic_long_t.
>
> This causes for example the received bytes counter to jump to 16EiB after
> having received 2^31 bytes. Casting the atomic value to "unsigned long"
> beforehand converting it into u64 avoids this.
>
> Fixes: 6c1c5097781f ("net: add atomic_long_t to net_device_stats fields")
> Signed-off-by: Felix Riemann <felix.riemann@sma.de>
> ---

Thanks for the fix.

Reviewed-by: Eric Dumazet <edumazet@google.com>
