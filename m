Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB05B659B7A
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 19:43:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235159AbiL3SnU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 13:43:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231210AbiL3SnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 13:43:17 -0500
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A4ED193D5;
        Fri, 30 Dec 2022 10:43:17 -0800 (PST)
Received: by mail-io1-f46.google.com with SMTP id g20so11518317iob.2;
        Fri, 30 Dec 2022 10:43:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bo9uiJL+jQwXg/fmSBNdw4FLuv03OF+8Leb88B6BpXY=;
        b=acNNmHz0N5oMexsM6/3PY1qYtj12Nah/kOlT/408nzaSdoqwyIY5c1gMJFwoM/d206
         N8vsnNstAOS1fDGrEbdbq7KQUZGNpKyI5HTWyAP370/CfhDAR/a7mEFaKO6/mhbif0wk
         C8qA5xRoGwhiViJmP6q0MsYnt8MOUaEBK3pooXQmfHn2UAZxYM2vUDspNegpTWor234t
         gr/riKz7LYpcMyzm19nPoHZ0VT9/KHYOPxgFdmPXVt8itkZt6xGK8WyATrMqH4ivx4QX
         Y7tNhwZ6lsfkmfgu1EJtkBTYLmAHhoYIAAKTRNyB9knSLTQdCeTBe7q+P9YHd5Meiv3+
         clPA==
X-Gm-Message-State: AFqh2koIQbWLxrQBdc4Q28qqoWQi2rJLmII7Sqh+VBi19x3+gvYeCDvQ
        Dfg7EeLRvwxISpVdRzB7A7j8ixr5alog1s0Qals=
X-Google-Smtp-Source: AMrXdXu+0JX+rmTGKCCKC+77wZZQDyTntId0U1blt/eLvzfrlcs2+9ogm4oG7QM3z1IOBVEZsePiVwyzUWuTJJ6tmB4=
X-Received: by 2002:a05:6638:8d:b0:38a:3357:8a4 with SMTP id
 v13-20020a056638008d00b0038a335708a4mr2599316jao.53.1672425796354; Fri, 30
 Dec 2022 10:43:16 -0800 (PST)
MIME-Version: 1.0
References: <20221229125957.45923-1-andriy.shevchenko@linux.intel.com> <20221229125957.45923-2-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20221229125957.45923-2-andriy.shevchenko@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 30 Dec 2022 19:43:04 +0100
Message-ID: <CAJZ5v0j3Dv5DJh4oN+i2qXi=zU8PhGeMsUY2v-mZU5tKJWmsxg@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] pm: Introduce DEFINE_NOIRQ_DEV_PM_OPS() helper
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Paul Cercueil <paul@crapouillou.net>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 29, 2022 at 1:59 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> There are a few drivers and might be more in the future that
> open code the functionality of proposed DEFINE_NOIRQ_DEV_PM_OPS()
> helper. From now on they may switch to the new helper and save
> a few lines of code.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  include/linux/pm.h | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/include/linux/pm.h b/include/linux/pm.h
> index 93cd34f00822..eba96822b1d9 100644
> --- a/include/linux/pm.h
> +++ b/include/linux/pm.h
> @@ -444,6 +444,11 @@ const struct dev_pm_ops __maybe_unused name = { \
>         SET_RUNTIME_PM_OPS(suspend_fn, resume_fn, idle_fn) \
>  }
>
> +#define DEFINE_NOIRQ_DEV_PM_OPS(name, suspend_fn, resume_fn) \
> +const struct dev_pm_ops name = { \
> +       NOIRQ_SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn) \
> +}

There is NOIRQ_SYSTEM_SLEEP_PM_OPS(), so why is the above needed in addition?

> +
>  #define pm_ptr(_ptr) PTR_IF(IS_ENABLED(CONFIG_PM), (_ptr))
>  #define pm_sleep_ptr(_ptr) PTR_IF(IS_ENABLED(CONFIG_PM_SLEEP), (_ptr))
>
> --
