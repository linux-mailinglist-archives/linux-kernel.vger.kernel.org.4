Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03231638296
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 04:02:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbiKYDCJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 22:02:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiKYDCI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 22:02:08 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 306372A42E
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 19:02:07 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id c65-20020a1c3544000000b003cfffd00fc0so5214847wma.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 19:02:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=d2mHAX+Ri7XTGUyqfmzAnzs15T0/6XNO6AvKE26BFSA=;
        b=JrKhleV8h7fOton3xSuGNYXjtWY70fibF3QBqnH80x+yMdw3JyPdemo9WxOSQWKkJu
         3hm4XrPO+i43kGY5iHL7Bgfwd4IcLaeC0ZFdm8Ko0a2PTun9M+WB6iI/6u64BT3vF21+
         Sr7sckjZYe1pDSvGeYhaNv3pmKu44mpf3qQul1PiVL2bxq5ueLNng2ISrUCtT4ylK49v
         4R//eERIsw0rls6dzuwUUnZ6RoJtYuhG+Ip/kIbp0m4jLba+IUORKbYxOoq3nZny7AVX
         A6antPukc2gB5pZKRrIKQaaVeRqqcgoG+o+Y1EIc6xfKSY8+1Rwv7edydCzJlScr7Av1
         YVGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d2mHAX+Ri7XTGUyqfmzAnzs15T0/6XNO6AvKE26BFSA=;
        b=sIkG4873T6HfnjMaCctVef6Z8SruQNADSTgztEs1RsojUxAw9fgisc6cPO71O1M0h3
         pC0B8nBJwhi7xcKi6lzMtOhHrNU2417rQkXCuFb9HAGBrUjjpG8CVbECVIWpzG37tIT4
         68JkIUwIB+NR1r70MuA7FjNxrUYBtjiqPbQypGzJLHi1wdkV2UWbPzx2fvlordeaEHhd
         w82m6UdFXReoogE+/f2wE6am1MRXLK6NzxHyKrVli38DEZN5zqiAo+D0wKQihiaB4mn3
         E24JOeEYqVUnoa80RWzYi6Ajyf1SNU8eB0nm4qZ8mWkc4aCjtGz3ayau823U++U5wzr9
         /QgQ==
X-Gm-Message-State: ANoB5pmBA1uj3Zp3I9AmJmCMq1QffUZx8DXgoBjranL3EpNdqAj6Py1I
        1ytP5RsqZZhmpODVdgqpmyKsGpqYOd4cN41ISkg=
X-Google-Smtp-Source: AA0mqf63azPCsG6bmh4mEHijH2STsWH3zWO1FiPnFSffXHBiISJL81V4D7vNxA+sdQDoeVTkpMeKIQKTUToL3yQpCNk=
X-Received: by 2002:a05:600c:4e50:b0:3d0:bda:f2c with SMTP id
 e16-20020a05600c4e5000b003d00bda0f2cmr12664563wmq.117.1669345325660; Thu, 24
 Nov 2022 19:02:05 -0800 (PST)
MIME-Version: 1.0
References: <20221123095058.669684-1-richard.xnu.clark@gmail.com>
In-Reply-To: <20221123095058.669684-1-richard.xnu.clark@gmail.com>
From:   richard clark <richard.xnu.clark@gmail.com>
Date:   Fri, 25 Nov 2022 11:01:54 +0800
Message-ID: <CAJNi4rMbZZbCCKu-Mth3YF-YubHkcgi=VHsd=FyWc77a54pKYA@mail.gmail.com>
Subject: Re: [PATCH] workqueue: Remove the unbound release work from the
 per-cpu type
To:     tj@kernel.org
Cc:     jiangshanlai@gmail.com, linux-kernel@vger.kernel.org
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

Hi Tejun,

Would you pls help take a look at this? Or point to someone who is
maintaining the workqueue subsystem, I can ping him/her...

Richard

On Wed, Nov 23, 2022 at 5:51 PM Richard Clark
<richard.xnu.clark@gmail.com> wrote:
>
> Both the per-cpu and unbound workqueue will call init_pwq(...) currently,
> the latter will init an unbound release work for the pwq which is unnecessary
> for the per-cpu type workqueue.
> This commit will remove this work item from the per-cpu workqueue by checking the
> wq->flags in init_pwq(...), the work is still reserved for the unbound workqueue.
>
> Signed-off-by: Richard Clark <richard.xnu.clark@gmail.com>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> ---
>  kernel/workqueue.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> index 7cd5f5e7e0a1..01bdfb74081e 100644
> --- a/kernel/workqueue.c
> +++ b/kernel/workqueue.c
> @@ -3807,7 +3807,8 @@ static void init_pwq(struct pool_workqueue *pwq, struct workqueue_struct *wq,
>         INIT_LIST_HEAD(&pwq->inactive_works);
>         INIT_LIST_HEAD(&pwq->pwqs_node);
>         INIT_LIST_HEAD(&pwq->mayday_node);
> -       INIT_WORK(&pwq->unbound_release_work, pwq_unbound_release_workfn);
> +       if (wq->flags & WQ_UNBOUND)
> +               INIT_WORK(&pwq->unbound_release_work, pwq_unbound_release_workfn);
>  }
>
>  /* sync @pwq with the current state of its associated wq and link it */
> --
> 2.37.2
>
