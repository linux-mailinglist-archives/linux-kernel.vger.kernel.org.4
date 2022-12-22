Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7244C653A26
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 01:38:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234815AbiLVAio (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 19:38:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiLVAim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 19:38:42 -0500
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01EF91A051
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 16:38:41 -0800 (PST)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-45f4aef92daso8657687b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 16:38:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yzZhw6ffUxADtGAtnmUBgN031mQuJfIajgUr9oqVk30=;
        b=dpRdWg62PLIUZnk08JFnInnXwlKhrq+AJ+tLVEj9OK/VkhR0WZ7LSpDc7zqXfXtxrV
         EzPbW5sJeh6WjQFbHvXeoRPsp1ZYsD0udH2dQEXEOc3nl/3DTQx0YY6TLDKMnYnEQ8mF
         g61IP8JQt7AujwnTNvKoJj3/6C9WWpB4lWumw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yzZhw6ffUxADtGAtnmUBgN031mQuJfIajgUr9oqVk30=;
        b=8FEyQ9GhUwj9DkwcsGATDzc539qHuRzzPF4mJN5ye1kH6ER2c8QkBgeGOoCsVjJ85N
         vo84SFs67wM0cRr3Sw1ALRgepzDc03yODRyLshIMLcq4ucD9Ciw04WgTUIwcBmtOzIPf
         2MxzB97WjGBgsRsy7pP8QT+/07H9bDcO1TayW5wR5i1y+3qg6V0pMx2SQgczVsb2I1+C
         qph2AcwKH8359Sq4Mq9M893Bvvts3N5f8KuBieq6KEVZ2w5n6SRw2mrFV1/w5BJLv5tj
         3KogJABFZB/pOgcPHzUppCWE4ouCc32oDzrR9m7zup7zkNzzNysviomxmu3Ed+/pjcC7
         ghwg==
X-Gm-Message-State: AFqh2krouEf1nwObyJVo87OiP9BZAXehSDSz2vtZ1zjpqGFaeTFClLZ3
        K2mj2GLL7fPmuRS5oKp5VNi2WuUrPJgLHDOjqEfVPA==
X-Google-Smtp-Source: AMrXdXuJubKyhMZ6g8xPpr2vkvCRX54HmxW9BmdrsrKktXZz4aqmlb/i0oHqB0rL6LFiIbe8BQq/LHF5A5WBdGKMLwk=
X-Received: by 2002:a05:690c:c98:b0:3c8:cd0e:87d6 with SMTP id
 cm24-20020a05690c0c9800b003c8cd0e87d6mr400912ywb.272.1671669520177; Wed, 21
 Dec 2022 16:38:40 -0800 (PST)
MIME-Version: 1.0
References: <20221221185540.2265771-1-robbarnes@google.com>
 <CACeCKafZu=46NE--r9W-wtJWAhj8=s46yCBO4N4u5nt4COqYAQ@mail.gmail.com> <CA+Dqm30XF=wDVcdUabbHySp-fwf+zFNqXpdYDW3bDTOwRbkiZw@mail.gmail.com>
In-Reply-To: <CA+Dqm30XF=wDVcdUabbHySp-fwf+zFNqXpdYDW3bDTOwRbkiZw@mail.gmail.com>
From:   Prashant Malani <pmalani@chromium.org>
Date:   Wed, 21 Dec 2022 16:38:28 -0800
Message-ID: <CACeCKafGg5=1MQQdCtXDm-3LE2VsixHPsUDngRwQXUvAwQ=u=Q@mail.gmail.com>
Subject: Re: [PATCH] drivers/cros_ec: Handle CrOS EC panics
To:     Rob Barnes <robbarnes@google.com>
Cc:     Guenter Roeck <groeck@chromium.org>,
        chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
        dtor@chromium.org, Benson Leung <bleung@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 21, 2022 at 3:55 PM Rob Barnes <robbarnes@google.com> wrote:
>
> On Wed, Dec 21, 2022 at 12:23 PM Prashant Malani <pmalani@chromium.org> wrote:
> >
> >
> > Can you provide a link (either in the commit, or here in the comment)
> > to the coreboot/BIOS code which uses this value? I feel this should
> > be documented in some form that correlates the caller and the callee.
>
> Link: https://chromium-review.googlesource.com/c/chromiumos/third_party/coreboot/+/4023535

Thanks. Please add a code link (for example, I could find [2], but you
could use another code mirror
if there is a canonical one for coreboot) to the commit description,
or in the comment when you send
out v2.

> > Any reason we cannot use the existing event_notifier (with value argument)?
> > It's a system panic, so I doubt that computational overhead for other
> > notifier block
> > listeners is a concern.
>
> The value field is already being used for "queued_during_suspend" in
> event_notifier.

OK, I suppose you could use the data pointer...

It's just I find having a notifier for a single use case overkill(even
2 would be fine); one could get away with exposing a method
in cros_typec_debugfs via a local .h file (it can compile to a stub if
cros_typec_debugfs is not compiled to the kernel);
the LPC code can then just call that method instead of invoking a notifier.

Best regards,

-Prashant

> > [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=bdc48fa11e46f867ea4d75fa59ee87a7f48be144
[2] https://github.com/coreboot/coreboot/blob/ff6b3af113f84a1957dcdf8a8179a751ce08becf/src/ec/google/chromeec/acpi/ec.asl#L15
