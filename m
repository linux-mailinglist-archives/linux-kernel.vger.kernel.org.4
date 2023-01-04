Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FC5C65DC4C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 19:42:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240074AbjADSlu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 13:41:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235215AbjADSle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 13:41:34 -0500
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A6421BEB1
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 10:41:33 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id 188so21190960ybi.9
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jan 2023 10:41:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=V1dRPJU4MdXr7AhvEfp9V8UzepfOOnVIYAc2m/AgMOQ=;
        b=CTDNr/RC+q50aWV+hPJVBcM0kwjHrJ+Squjp5dQYeMdRAlMLTYW6AUWGozIV63m6H/
         RuJ7O1HVN2+bWAj4GV+Q1ZxJvyVkhvIyGW/UxEcDrTp/wcQAhVQ+UCKP58Ynq8eACwgM
         blJj6zCXRq9pBQHqWKlQpTbTQBTxz0p2fii2A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V1dRPJU4MdXr7AhvEfp9V8UzepfOOnVIYAc2m/AgMOQ=;
        b=aaBIfuRQpKzpguLC+EcczxhtTCpmmIRr8N0WmZqD6vOWy7lAQzEO+HHNgdki+rkuCu
         Ut7xFgGflPezliYq4qT4uA+VDaRZGtiQ9SAactj8GXlDQbAaM+EGaEUH7XdwJLLXZPuW
         Fa8DiSh4ofOomwMa1dA06Zm0SOw7BaQGI7dfvx1uzQ10ANnJiXVPkbwWOJWIujIWN8Dn
         IuIlpzPzEixHJIwEQ+mpw5r2DjYpYkjU8JXtgOfNrIjLW9D4fQBk00w+ZIpuuMip/YpK
         TvZ1laZQovlrsSBH2uI4daww/ezjmtSLZv74k/5qo8ToLoIj6h6+ARo7WG4P29xK1USl
         N6Zw==
X-Gm-Message-State: AFqh2kpAjm9/fkvjo6nattZArjblgtH+VACYXS+UkDeG+l6qBtEavWje
        30Yb1as/xTA/jdf3m7ybORviyXQQ415ZpqyXKMV4WA==
X-Google-Smtp-Source: AMrXdXufVqOEwxUUW5jATjfmK3mFMUU7flZ8EEkSh4TWBLg+BZjyKS8SKCSn7EV2GQFVsVE+WE654an3oJqh4SfGDq8=
X-Received: by 2002:a25:1083:0:b0:7ae:5e48:383b with SMTP id
 125-20020a251083000000b007ae5e48383bmr439846ybq.223.1672857692715; Wed, 04
 Jan 2023 10:41:32 -0800 (PST)
MIME-Version: 1.0
References: <20230104011524.369764-1-robbarnes@google.com> <20230104011524.369764-3-robbarnes@google.com>
In-Reply-To: <20230104011524.369764-3-robbarnes@google.com>
From:   Prashant Malani <pmalani@chromium.org>
Date:   Wed, 4 Jan 2023 10:41:22 -0800
Message-ID: <CACeCKadFQEqA3tbR4fQvpc6O4L61zLCph8gigZria6CkFXEJ7Q@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] platform/chrome: cros_ec: Shutdown on EC Panic
To:     Rob Barnes <robbarnes@google.com>
Cc:     groeck@chromium.org, chrome-platform@lists.linux.dev,
        linux-kernel@vger.kernel.org, dtor@chromium.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 3, 2023 at 5:15 PM Rob Barnes <robbarnes@google.com> wrote:
>
> When an EC panic is reported, attempt an orderly shutdown.
> Force a shutdown after a brief timeout if the orderly shutdown
> fails for any reason.
>
> Using the common hw_protection_shutdown utility function since
> an EC panic has the potential to cause hw damage.
>
> This is all best effort. EC should also force a hard reset after a
> short timeout.
>
> Signed-off-by: Rob Barnes <robbarnes@google.com>
FWIW:
Reviewed-by: Prashant Malani <pmalani@chromium.org>
