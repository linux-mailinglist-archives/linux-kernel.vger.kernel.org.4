Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1835267EB4F
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 17:44:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232303AbjA0QoA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 11:44:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbjA0Qn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 11:43:57 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FEB38D093;
        Fri, 27 Jan 2023 08:43:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B9514B8211E;
        Fri, 27 Jan 2023 16:43:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6301DC433EF;
        Fri, 27 Jan 2023 16:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674837791;
        bh=TfWsIjnpXj9UAEiaerVWeiYol3ufC+0UIEjPrYdaesw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=go9Fo8j18qfSnkxp59u+WDQI5I10RGKfJGEyGGYdnTy1jR5/ovkRthMBZ8VOtNvjh
         h/s9kRDAgw5opS82jQ0bGP3DdqXvq7KT14SVsfFNstdrjmSwMVj/7JECDo3bJ5ZHdt
         LcjMddly8bRsg1iT82vcbRA+mSpghIrCEGDF++2/ziK/Tw/44cr4830knQHbO5o43u
         Ie0QQ1WeH9xBqd7QVtvMa4USWgsyXS4rOr7yqaCLu09rhf9sn7yWNBWrabDuV9X+nX
         8eI6vsDY1m01D61OsfiMgpcS/lhdg61nw83PpoVeelVl8orXFF3MS+VUAYcjM/okuC
         3kq5yVvMvb/Eg==
Received: by mail-lj1-f180.google.com with SMTP id k38so6136389lje.5;
        Fri, 27 Jan 2023 08:43:11 -0800 (PST)
X-Gm-Message-State: AFqh2koptC5c54D7GxiqRD2fybIXtE4FZSj6cIvj6bBXflgh9nhtVefA
        6yzRERl5BgegdV+sYQ0kqg27CvCA9Fa/2VSs2Vg=
X-Google-Smtp-Source: AMrXdXvrkDQ3Xeyopqiy3GVRgj/q/1qJFaiCTsHSRNxdefODJEls8a0/hNtLqPNTmQL3P05Dk3ZTaIMuNnTzalNKH+o=
X-Received: by 2002:a2e:bc25:0:b0:28b:663a:168d with SMTP id
 b37-20020a2ebc25000000b0028b663a168dmr2153457ljf.53.1674837789401; Fri, 27
 Jan 2023 08:43:09 -0800 (PST)
MIME-Version: 1.0
References: <20230125185004.254742-1-song@kernel.org> <Y9IYTI3pWuKbJ3bC@bombadil.infradead.org>
 <CAPhsuW7ipGS=RhowYSp06DBYOY31sYoup7-Je+CEuKCxJsHavQ@mail.gmail.com>
 <Y9Lp+5mqxP0bgvrM@bombadil.infradead.org> <20230127131351.GB3911997@roeck-us.net>
In-Reply-To: <20230127131351.GB3911997@roeck-us.net>
From:   Song Liu <song@kernel.org>
Date:   Fri, 27 Jan 2023 08:42:57 -0800
X-Gmail-Original-Message-ID: <CAPhsuW5jyo7gHyfojZArWXp5rOMsR9xWJEE62GhABXKSWKK8VA@mail.gmail.com>
Message-ID: <CAPhsuW5jyo7gHyfojZArWXp5rOMsR9xWJEE62GhABXKSWKK8VA@mail.gmail.com>
Subject: Re: [PATCH v2] module: replace module_layout with module_memory
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guenter,

On Fri, Jan 27, 2023 at 5:13 AM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On Thu, Jan 26, 2023 at 01:00:43PM -0800, Luis Chamberlain wrote:
> > Guenter Roeck,
> >
> > Any chance you can give this branch a good spin on your multi-arch setup
> > to see what may below up?
> >
> I assume I shoud test v3 ?

Yes, please. The one in the modules-testing [1] branch is already v3.

Thanks,
Song

[1] https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/log/?h=modules-testing
