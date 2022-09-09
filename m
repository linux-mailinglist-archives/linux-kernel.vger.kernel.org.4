Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39D765B3A5D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 16:09:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232147AbiIIOIP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 10:08:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231251AbiIIOHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 10:07:36 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BA5B10306C
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 07:05:42 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-12803ac8113so4120352fac.8
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 07:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=I6ADPzEiooQjq05+LtdvGJfr2nP2w0nBmCIYS00kkYc=;
        b=kUgpmFBISpZIoFjqAY4L2SPWwEpbSIUzkb62MRHQ2x64jn9IBodtg7iSYSCxQkZoaj
         xA5Xnpzd6TrRT7DBmBJAhaTM0vcLKJ8IlKpD/PJq1qT4YniqkUm0nU4NWnH8Iq/fe2NI
         Y0rstic3BlGoJphrtBmAUeBwfH50iabgOVFlNU49j+BnToMuYiXuzXxN4HDAOMsT4Vj9
         7ZLeq38bqo/1Yx1QVFCZpyXNm2Rj2YGb+ZuW+/gz0r4uDxazaYExHCjXH48NPDJJzYTr
         17teuZV5PvfIa6//QADbabH+fbrAbj7wnpfCXQRwRFD7s7RjPSxLZHbCLf2DBkswR9Uu
         yzOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=I6ADPzEiooQjq05+LtdvGJfr2nP2w0nBmCIYS00kkYc=;
        b=RSPeaicadhyR+O+ECSaG+ig0Gp3x8iCR+N9gLMnqWaKZl/BHypKRmAGKu5I7nm/Uim
         PldHwkut7m0ATzkKSa9W6ZoNHD5+JkxnkDfakJnUNSZBP75X6oDglBuPoHLxx0IHeUZc
         woCbqj77FVm3tKk64okJmQ25a034IV/3yY/bL4jpiisimmliLq7TEhI6UZGHba7GBCgv
         fc1yMQ3xdcG9JOXhxoXQ1aFEnnHLFgLBI5vwPiXgij/XRk9z1VcEWWZ1ZQyNkzQaIfl5
         ddAOZKYFUml1dUrjSpv66XapA3A5nKJilL4WAPvhqLrqiWN0onkqfLq+3ckC8mRKwB64
         ldoA==
X-Gm-Message-State: ACgBeo1o45Iad9ZIRwSC2yezKy292gqniQZFF2lyx7f5MGJeT3Ne8rT/
        xKKAtbdvz+R03t1CZH5uUJ25hQBipd6h7F27CBe6
X-Google-Smtp-Source: AA6agR53AZ40atMarXdqAH5ACA3XpzH6OGafmmoN3e93leai1NOximUNW9oVLsBDAl8qK85HlaUVw0Z7WKHbR8hIXxw=
X-Received: by 2002:a05:6870:5808:b0:128:afd5:491f with SMTP id
 r8-20020a056870580800b00128afd5491fmr5130175oap.136.1662732341451; Fri, 09
 Sep 2022 07:05:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220908220222.267255-1-nathanl@linux.ibm.com>
In-Reply-To: <20220908220222.267255-1-nathanl@linux.ibm.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 9 Sep 2022 10:05:30 -0400
Message-ID: <CAHC9VhSWmgRxH_5yVfg=ujni_qpWd33NkXS9wKa+1n4fNMtZwA@mail.gmail.com>
Subject: Re: [PATCH] lockdown: ratelimit denial messages
To:     Nathan Lynch <nathanl@linux.ibm.com>
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, jmorris@namei.org, serge@hallyn.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 8, 2022 at 6:02 PM Nathan Lynch <nathanl@linux.ibm.com> wrote:
>
> User space can flood the log with lockdown denial messages:
>
> [  662.555584] Lockdown: bash: debugfs access is restricted; see man kernel_lockdown.7
> [  662.563237] Lockdown: bash: debugfs access is restricted; see man kernel_lockdown.7
> [  662.571134] Lockdown: bash: debugfs access is restricted; see man kernel_lockdown.7
> [  662.578668] Lockdown: bash: debugfs access is restricted; see man kernel_lockdown.7
> [  662.586021] Lockdown: bash: debugfs access is restricted; see man kernel_lockdown.7
> [  662.593398] Lockdown: bash: debugfs access is restricted; see man kernel_lockdown.7
>
> Ratelimiting these shouldn't meaningfully degrade the quality of the
> information logged.
>
> Signed-off-by: Nathan Lynch <nathanl@linux.ibm.com>
> ---
>  security/lockdown/lockdown.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

This seems reasonable.  While the last visible lockdown message to the
console might be incorrect/old, I think it would give the user a good
indication that lockdown is being hit and hopefully preserve the start
of the denial storm.  It is also worth noting that this does introduce
a spinlock to this code path, but since it is only an issue on error I
doubt it will have any significant impact.

I'll leave this until next week to give people a chance to
comment/object, but if there are no further comments I'll plan on
merging this into lsm/next.

> diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
> index 87cbdc64d272..a79b985e917e 100644
> --- a/security/lockdown/lockdown.c
> +++ b/security/lockdown/lockdown.c
> @@ -63,7 +63,7 @@ static int lockdown_is_locked_down(enum lockdown_reason what)
>
>         if (kernel_locked_down >= what) {
>                 if (lockdown_reasons[what])
> -                       pr_notice("Lockdown: %s: %s is restricted; see man kernel_lockdown.7\n",
> +                       pr_notice_ratelimited("Lockdown: %s: %s is restricted; see man kernel_lockdown.7\n",
>                                   current->comm, lockdown_reasons[what]);
>                 return -EPERM;
>         }
> --
> 2.37.1

-- 
paul-moore.com
