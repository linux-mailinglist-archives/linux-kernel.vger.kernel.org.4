Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 459295EB32D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 23:33:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbiIZVdf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 17:33:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230321AbiIZVdc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 17:33:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29CEC79680
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 14:33:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BA644B8111B
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 21:33:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B955C433C1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 21:33:28 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Upl2d2V2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1664228006;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MlKljb2sjNEQTGH6V9odAf4e2ie2Ygz4/aI+VIepQkY=;
        b=Upl2d2V2+NcvmXbIYmOIDayMTvmqRZj5kFQ2JODyxCses2hpzN9irZX0e2gI4dxxwYf/iC
        0j24T3GauXksNkezwcDS13YE1U9mDh5v4/zF7VFjCjU3pv1bymnawY8t7kK7JGiihGym/A
        +sPRnveFrjwWgKQqP+4nqFBR23JRP6Y=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id ae3d1e90 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Mon, 26 Sep 2022 21:33:26 +0000 (UTC)
Received: by mail-vs1-f48.google.com with SMTP id p4so7883781vsa.9
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 14:33:26 -0700 (PDT)
X-Gm-Message-State: ACrzQf0e54Ar/0FK35gQp7fYQf0fZJKuO5ndDSW+WhH01oHTlGw+ldwJ
        xVRCnaD2UODgML8cE4uQ/mQ+LZ2CWhfGTr30ai8=
X-Google-Smtp-Source: AMsMyM5HGQM+uIkbFqhMwRBYGWHCP9NY6FHUH+/bapP/NoHqr5H+IV5S8Z5v4aRCxgBMdoFdQB6f4gohFvvjCYvWtxA=
X-Received: by 2002:a67:d81e:0:b0:398:2c98:229b with SMTP id
 e30-20020a67d81e000000b003982c98229bmr9491854vsj.73.1664228005127; Mon, 26
 Sep 2022 14:33:25 -0700 (PDT)
MIME-Version: 1.0
References: <CAHmME9pRXpTc2g5R-xj7hTrG00iQ6WLSSRooag1NPzJnyV90Nw@mail.gmail.com>
 <20220926133435.1333846-1-Jason@zx2c4.com> <20220926133435.1333846-2-Jason@zx2c4.com>
 <202209261127.0FBA8B7@keescook>
In-Reply-To: <202209261127.0FBA8B7@keescook>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Mon, 26 Sep 2022 23:33:14 +0200
X-Gmail-Original-Message-ID: <CAHmME9ri2YHN9OEen2sw2TimNZO5Swca41qumxu_LmbqUztEKA@mail.gmail.com>
Message-ID: <CAHmME9ri2YHN9OEen2sw2TimNZO5Swca41qumxu_LmbqUztEKA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] minmax: clamp more efficiently by avoiding extra comparison
To:     Kees Cook <keescook@chromium.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 26, 2022 at 8:30 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Mon, Sep 26, 2022 at 03:34:35PM +0200, Jason A. Donenfeld wrote:
> > [...]
> > In this case, we actually gain a branch, unfortunately, because the
> > compiler's replacement axioms no longer as cleanly apply.
> >
> > So all and all, this change is a bit of a mixed bag.
>
> I'm on the fence -- I think the new macro is a more correct way to
> describe the operation, though on the other hand, the old way provides a
> simple way to compose the bounds checks.
>
> I suspect we should probably optimize for _performance_, not code size,
> so if the new branch is actually visible via cycle counts in "perf"
> output, probably we shouldn't use this patch, and instead add a comment
> about why it is defined the way it is.

I *want* the better algorithm to yield better performance, because
that's a much less confusing world. But it seems like we have grounds
for suspecting that might not be the case. So until I come up with
some real measurements, I agree we should hold off on this 2/2.

Jason
