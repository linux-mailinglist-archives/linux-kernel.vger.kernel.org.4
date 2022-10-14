Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32DA95FE9DD
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 09:55:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbiJNHzF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 03:55:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbiJNHzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 03:55:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4861F326E1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 00:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665734093;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kwtn6uvhgQEqm/XpkC52bizaNd8cjGpKe1WGKPimX2I=;
        b=UNGzN68VwMF05ZNykEjg7O9sYN7F15kZ+AYjJvFYX4arZNj2+Aabbh6TIu+WXBmZcvqIuP
        OlSK3HBshyLolCSVDzcpyecrVAqEgzlcQh9JywpscsBbrbncMaoHxPgkhuXk9gFIEEZuw7
        X7kQC4mWTF94u1b3R2EmnqNbf090y2Y=
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-60-HJtbtnfYMH2EUyIef2hhrQ-1; Fri, 14 Oct 2022 03:54:52 -0400
X-MC-Unique: HJtbtnfYMH2EUyIef2hhrQ-1
Received: by mail-vs1-f70.google.com with SMTP id d184-20020a671dc1000000b0039b46979cb9so1071095vsd.4
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 00:54:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kwtn6uvhgQEqm/XpkC52bizaNd8cjGpKe1WGKPimX2I=;
        b=xDGKDuez93/ULQshaMCj4HuE8XTk1dU+8OUBZ0Oxb+jr6zVJA+s/4MJTP/cBRS0Uxy
         gmRVdwEPi6eCe41buJhcxHap68IhTGUKptGJK3AlLlxQ9XGg1x/KJcuCm2harqdm9OwQ
         vmEfw0pTfPDtRIB2b+EW39LyUayVbb86XsbOgxMj4XXFpm7y7hijIWF3REQ/0tqaRkv9
         Q/KdVsEGXb902Qz5pmLlrOQJDP7IyPGei6AgsMAr4bO8fWwj9QarVi+htnzYW599w6DZ
         zHWWccvMDdIQ94UkUir2FmuVfaMMPVJGMltiAhsVPuucSysr9wlzbHAUOUhz4b1+79SL
         Dtzg==
X-Gm-Message-State: ACrzQf12UbvjZ7itEocMZQhA9oINedOT2m9Wlbq+y2A/qdpBqsWsQGdc
        Axk1PDf2k++wZt9xNyaZ6Se7Ie2DFMm/Ett1oLELnIvOexf8YD+g4AnmIDC1kQxkleq86SKeFjU
        +I/Y5Mk3FP2UkObhu3Ol7H6sQx8gpVodxQPrKIofw
X-Received: by 2002:ab0:7590:0:b0:3ea:d2ef:ee0d with SMTP id q16-20020ab07590000000b003ead2efee0dmr1991789uap.62.1665734091459;
        Fri, 14 Oct 2022 00:54:51 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM56JqUVAqmbVw+dtHtQM+y2Di+UwZLKyQqOqheAu6wo2RecBdTSfwx+px7+hQCfD79pvuwlD+7EI56QH9y5dR4=
X-Received: by 2002:ab0:7590:0:b0:3ea:d2ef:ee0d with SMTP id
 q16-20020ab07590000000b003ead2efee0dmr1991781uap.62.1665734091201; Fri, 14
 Oct 2022 00:54:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220919123233.8538-1-petr.pavlu@suse.com> <20220919123233.8538-3-petr.pavlu@suse.com>
In-Reply-To: <20220919123233.8538-3-petr.pavlu@suse.com>
From:   David Hildenbrand <david@redhat.com>
Date:   Fri, 14 Oct 2022 09:54:40 +0200
Message-ID: <CADFyXm5AP8pvXAKRBVNsZd5SUPziKBV0UktwORokuLU7c6Sbvg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] module: Merge same-name module load requests
To:     Petr Pavlu <petr.pavlu@suse.com>
Cc:     mcgrof@kernel.org, pmladek@suse.com, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 19, 2022 at 2:33 PM Petr Pavlu <petr.pavlu@suse.com> wrote:
>
> During a system boot, it can happen that the kernel receives a burst of
> requests to insert the same module but loading it eventually fails
> during its init call. For instance, udev can make a request to insert
> a frequency module for each individual CPU when another frequency module
> is already loaded which causes the init function of the new module to
> return an error.
>
> The module loader currently serializes all such requests, with the
> barrier in add_unformed_module(). This creates a lot of unnecessary work
> and delays the boot.
>
> This patch improves the behavior as follows:
> * A check whether a module load matches an already loaded module is
>   moved right after a module name is determined. -EEXIST continues to be
>   returned if the module exists and is live, -EBUSY is returned if
>   a same-name module is going.
> * A new reference-counted shared_load_info structure is introduced to
>   keep track of duplicate load requests. Two loads are considered
>   equivalent if their module name matches. In case a load duplicates
>   another running insert, the code waits for its completion and then
>   returns -EEXIST or -EBUSY depending on whether it succeeded.
>
> Note that prior to 6e6de3dee51a ("kernel/module.c: Only return -EEXIST
> for modules that have finished loading"), the kernel already did merge
> some of same load requests but it was more by accident and relied on
> specific timing. The patch brings this behavior back in a more explicit
> form.
>
> Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
> ---

Hi Petr,

as you might have seen I sent a patch/fix yesterday (not being aware
of this patch and that
this is also a performance issue, which is interesting), that
similarly makes sure that modules
are unique early.

https://lkml.kernel.org/r/20221013180518.217405-1-david@redhat.com

It doesn't perform the -EBUSY changes or use something like
shared_load_info/refcounts;
it simply uses a second list while the module cannot be placed onto
the module list yet.

Not sure if that part is really required (e.g., for performance
reasons). Like Luis, I feel like
some of these parts could be split into separate patches, if the other
parts are really required.

I just tested your patch in the environment where I can reproduce the
vmap allocation issue, and
(unsurprisingly) this patch similarly seems to fix the issue.

So if your patch ends up upstream, it would be good to add some details
of my patch description (vmap allocation issue) to this patch description.


Cheers,
David

