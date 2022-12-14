Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5CC764D300
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 00:08:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbiLNXIc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 18:08:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbiLNXIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 18:08:31 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3C62442C5
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 15:08:29 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id 186so1572688ybe.8
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 15:08:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vZgv8EhWuu7DQFQY4mJ5kzf06cgtGS9MhJTBMdbQdg0=;
        b=Koukpy5AE0R74wwmwaMXhF46GU5v5aDNy2Jd8NkkRCgJejSeBSVpIBXxeu3saRYGT1
         y2+PwFoV6aVmiaJO5iPUYnO84UGDrxKRdZi63ek/5LG0vNJecS7cFYwl78bMcUGTRbxv
         ngpXjOpusqbvGKDter8WwtD9RU3Xu5av0o9QB4FzTo/RNc4wRylDqMm39o5WU3QKf4UD
         CFI6Xvgl+Ox+wf/Pah3/SG5UvM8xD4wLyxBVdCA20ySpQ1BwALlv0Y6ldERQ/6gFGSEF
         j5sjsmQpkdvDFzl9ZYOdz5Xpo7hc+9UYZOs98AJO+h/Ozo8ly2kJM6CHxwZET08V4lhD
         xPNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vZgv8EhWuu7DQFQY4mJ5kzf06cgtGS9MhJTBMdbQdg0=;
        b=JK3NSjayGsC+l2+z6IIDjssiW2Z8gFOnUBT5x+eJFnvtI4HfCAWTKBI3cCdI8Iu+bM
         NcBAYupZjEM4wXouNNRl68T0vkXcZscmZuR7dAvFvSvu/YpKiNP05o+iVE2Ek1wGZ1dU
         qgVNBUFQz9YQzS75BnzmtRtG0VLtNVgiaENT+SI3rUEhcQf8stIjsYoxFF0d9K3aVLj8
         PSyjUH6Szz6usY3LBoUQ+NGZd72VXiRVkXRFCWDTqotIF1VuUrRsurltwGOvm6KedMx2
         XTf5LFxGVcSQ3qRw/sswMziqnPumY1RUAt84JFnjB33KjG/JcnSPD2kIYF0RJ4ql/1OI
         vS1w==
X-Gm-Message-State: ANoB5pmeAEUqUsMkzfa6Q6jALfsvZJA+MVJ1dehRSa4RMPEQk3/9Cad4
        mcUVE8bQ1mlSD/zkmV3fMHOGASc12Mr4bQS7qzuJ
X-Google-Smtp-Source: AA0mqf5zEGj7IlUugrJSTvJJCmGceei0TWZxlPYzo4RRB+j7cdwpC54RbVyhHmqhFUqcpGJ2Cv7d0AqnePcFYHSvj9Y=
X-Received: by 2002:a25:e755:0:b0:6f1:2a94:40f2 with SMTP id
 e82-20020a25e755000000b006f12a9440f2mr68918602ybh.332.1671059308800; Wed, 14
 Dec 2022 15:08:28 -0800 (PST)
MIME-Version: 1.0
References: <20221205203253.3923812-1-jstultz@google.com> <202212141453.C79E68F@keescook>
In-Reply-To: <202212141453.C79E68F@keescook>
From:   John Stultz <jstultz@google.com>
Date:   Wed, 14 Dec 2022 15:08:17 -0800
Message-ID: <CANDhNCpFzG4sR1qcrWe+c=SzBfCMBm-Vv-50U4NTTC_awkto2Q@mail.gmail.com>
Subject: Re: [RFC PATCH] pstore: Switch pmsg_lock to an rt_mutex to avoid
 priority inversion
To:     Kees Cook <keescook@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Wei Wang <wvw@google.com>,
        Midas Chien <midaschieh@google.com>,
        "Connor O'Brien" <connoro@google.com>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>, kernel-team@android.com
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

On Wed, Dec 14, 2022 at 2:53 PM Kees Cook <keescook@chromium.org> wrote:
> On Mon, Dec 05, 2022 at 08:32:53PM +0000, John Stultz wrote:
> > Wei Wang reported seeing priority inversion caused latencies
> > caused by contention on pmsg_lock, and suggested it be switched
> > to a rt_mutex.
> >
> > I was initially hesitant this would help, as the tasks in that
> > trace all seemed to be SCHED_NORMAL, so the benefit would be
> > limited to only nice boosting.
> >
> > However, another similar issue was raised where the priority
> > inversion was seen did involve a blocked RT task so it is clear
> > this would be helpful in that case.
> >
> > Feedback would be appreciate!
>
> This looks fine to me. Is there an appropriate "Fixes:" tag that could
> be used?

Not other than the ~3.19 era original introduction of the pmsg.c file
where that mutex was introduced, I don't think.

But I'll respin with that.

thanks
-john
