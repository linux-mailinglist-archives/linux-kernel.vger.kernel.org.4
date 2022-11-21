Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46F92632364
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 14:25:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbiKUNZR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 08:25:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbiKUNYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 08:24:45 -0500
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFA732DA9A;
        Mon, 21 Nov 2022 05:24:43 -0800 (PST)
Received: by mail-qv1-xf30.google.com with SMTP id cz18so1635923qvb.13;
        Mon, 21 Nov 2022 05:24:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/Yl0zc076DQLM52TWhkF4fUAm1X/8fkFILkE20L898o=;
        b=q0ZwOO761XTx1Mja/SAU+MsKq/vzVBj216fbX/M7le1SY2WT3jpAmhIgLhNKCNG91z
         NvpodCZFp3mrL+cQGlYoc3DfI5DhyG3rtSXW1OgdOjJNgXsiWKMoSZbp8u+NKInCWCwz
         BNpG8lPRvQuMiQV6gvzzrg67dgtH3eI0Nr5KNXga18DfFt1ScCMNELI1pM5PwauFSq2L
         qu7FubI5AvvYJQEdrTvT/W5CD1GTGRokT0kaC0ZUi+VKpccA33Gi180OTCg+898wB7c+
         rjwaXOb1Bja6IRjcVLEO0VY3k2JA/z8TY3PCGWSynQDiKengdoFw3AsyniuBzUaSA4mO
         3alw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/Yl0zc076DQLM52TWhkF4fUAm1X/8fkFILkE20L898o=;
        b=f7hY6tzADtZ8ht0EA/o6zQt+CaPScPK1svwkKAjZfYjVqYS2gnO0OLIKbreLUttPaJ
         Q789GbhMM/8TtEQwWn33aJ4qaBLDDOzCGrtq6IZwb16KlqZQ6fg/uk2rJPcPHnqaudhN
         USNOA/4F7Fj3DjRbEpGnL0RmiixjDtRYxMuvuTPJPmTSAXPKuQWsyax47Ox1ADwwcYV1
         GODGNwW7drLQ8F6tVvdVp9fTwzbrdX3UQ7oFxNDtXAFKHmPeUclkp9vyzHok19TA4kyO
         LlyX5W5F4esZxA9+ePR2sdm+2mPqH0ZVfekuYLLuccwFugnLxEhdpIU9w3baDaUlM6xI
         wLpw==
X-Gm-Message-State: ANoB5pmi7+0hq5hDIyTU9tuDQeX/8fLyMdwaGVnxpmICHWrmgfZLybQp
        zEGHEvuJZjSceyktMlsIaF7faalwSBCa36vvRQdQraCN
X-Google-Smtp-Source: AA0mqf4ExSTorXvZ/s39GKGZY5emEEEEXSr2P8Xs1ZI5kKhzUyMmOI58MyU/6Jyc5lVGg/wFYhJXIPRCWP5/TVlkIh4=
X-Received: by 2002:a05:6214:5cc2:b0:4c6:a622:cb4f with SMTP id
 lk2-20020a0562145cc200b004c6a622cb4fmr7038488qvb.97.1669037082947; Mon, 21
 Nov 2022 05:24:42 -0800 (PST)
MIME-Version: 1.0
References: <20221121123833.164614-1-mmkurbanov@sberdevices.ru>
 <20221121123833.164614-3-mmkurbanov@sberdevices.ru> <e61c6d8d-90d1-8cde-03c8-00d8f7e62160@sberdevices.ru>
In-Reply-To: <e61c6d8d-90d1-8cde-03c8-00d8f7e62160@sberdevices.ru>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 21 Nov 2022 15:24:06 +0200
Message-ID: <CAHp75Ve8_obbSA-24RXd1p4W4NQg9VEBwGC4W9pYSwrY0RRCHg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] leds: trigger: pattern: notify usespace if pattern finished
To:     Martin Kurbanov <MMKurbanov@sberdevices.ru>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>,
        kernel <kernel@sberdevices.ru>, Pavel Machek <pavel@ucw.cz>,
        Raphael Teysseyre <rteysseyre@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 21, 2022 at 2:44 PM Martin Kurbanov
<MMKurbanov@sberdevices.ru> wrote:
> On 21.11.2022 15:38, Martin Kurbanov wrote:

> In the previous patch series feedback you mentioned two main problems:
> sysfs node creation time and life cycle, and sysfs node creation method.
> Let me explain why I didn't fix the above items.
>
> 1) About sysfs node creation time and its life cycle. In my opinion,
> sysfs node should exist only when user has activated pattern explicitly;
> otherwise, it will mislead potential user in the case when pattern is
> not activated, but sysfs node existed.

OK.

> 2) About pattern_trig_attrs. We need to use sysfs_notify_dirent()
> instead of sysfs_notify(), cause sysfs_notify() can sleep on the lock,
> but it's not acceptable for the pattern code in the timer context.
> Considering this, we have to create sysfs node in the
> pattern_trig_activate() directly and retrieve kernfs_node for required
> sysfs_notify_dirent() routine.

Is there a guarantee that nobody is using the removed node?
If no, what would be the problems with that if any?

-- 
With Best Regards,
Andy Shevchenko
