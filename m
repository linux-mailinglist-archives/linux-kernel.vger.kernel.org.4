Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D529A5E7188
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 03:45:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232108AbiIWBpn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 21:45:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbiIWBpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 21:45:40 -0400
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27924CC8EF
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 18:45:39 -0700 (PDT)
Received: by mail-vs1-xe31.google.com with SMTP id k2so12213662vsk.8
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 18:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=1Dmy+bP/Sq6hiRo3FeUARTLKo3YFa2Gcnp/eo3QDGaE=;
        b=gZNeM3+yMp2TcsEXT0jggbv0qICW4Kn9hQdW5tAQR22k2PyxQ8EpAhng2TbfBZbTLO
         cL/n1kK/gBHjsewl/jkcd6nQ/LcnBj4TEVbg/jzWdJBUo7isUe+LEDJ1QKYu/zi/FhLD
         NNVnIlUV19IuGOZIrJruZb2Yy7em0ZDuesHINq+K6aV4Q5h0qPRR02ogYTJgQbNZm0lb
         cF33XgmRUIfW0rqUHT9kzhgnV9a2atrP/EomHAyC6AhACgOQ9zmuxuFG4SLMVProuX6p
         8Ub0kGpCEz452TpGcuHKMkTRbbGHXB3oPTv3FNk7CAa3l8FWbA2JilnM9K25OERjm7tl
         Oakg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=1Dmy+bP/Sq6hiRo3FeUARTLKo3YFa2Gcnp/eo3QDGaE=;
        b=zLkBgLDnKpHwX5sQw/rVVqcGQqfNsxCxaoxODgnFiFhfniw2f3abvp8i39A6cjAcOw
         DqwBsth6eCxt6MxvvqmhDvMARaMQ9tDwopk42Jux7Ix2mDxbTF56feyyxiJHtfTpONlm
         gEzghPbnhlXUTqAQtBYnWzYSg9JMtjnrWINZh7UsiA1YxqTydU8t3qCBNcuHl7o7/Brp
         uxfMSloV2TjSG4sbdNC5Pp8TdbCT1PWBgS1jjmKKviWI55C/Ox+a9pgqt7UuNpQRpW8a
         NZHaGn/1gC14F4eaxJwbaKAdY6gwOxBd6r7aU3qEoPvFphhyDFaWxX1LjFfi5QdFJ8Gv
         7GoA==
X-Gm-Message-State: ACrzQf3VNl+Y+tx1sGq2s64dffJB3UMH86kwVCEz48mvtnXOp8AOQD3B
        uzdqvO01Ie2B4+R/4zFTBeewc/IGBpocRgh5FR9g3rMG
X-Google-Smtp-Source: AMsMyM7HH+bxOoOJxz5t3RZVtLZ5m3CRiYrPn7MErIN0gpo3hUx+JJLQ8S69+ZJEP28u0rnv09jSdJjn3FpKM08ft1I=
X-Received: by 2002:a05:6102:538:b0:398:2ca3:bec2 with SMTP id
 m24-20020a056102053800b003982ca3bec2mr2767111vsa.56.1663897538114; Thu, 22
 Sep 2022 18:45:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220922194954.1078-1-andriy.shevchenko@linux.intel.com> <Yyz/7gWdP+ftQdIO@lorien.usersys.redhat.com>
In-Reply-To: <Yyz/7gWdP+ftQdIO@lorien.usersys.redhat.com>
From:   Yury Norov <yury.norov@gmail.com>
Date:   Thu, 22 Sep 2022 18:45:27 -0700
Message-ID: <CAAH8bW9+hGMALooLtJGtYNDWw-tBXEspn8oQ_WLrBArMaD9SZA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] cpumask: Don't waste memory for sysfs cpulist nodes
To:     Phil Auld <pauld@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?Q?Petr_=C5=A0tetiar?= <ynezz@true.cz>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
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

On Thu, Sep 22, 2022 at 5:38 PM Phil Auld <pauld@redhat.com> wrote:
>
> Hi Andy,
>
> On Thu, Sep 22, 2022 at 10:49:54PM +0300 Andy Shevchenko wrote:
> > Currently the approximation is used which wastes the more memory
> > the more CPUs are present on the system. Proposed change calculates
> > the exact maximum needed in the worst case:
> >
> >   NR_CPUS     old             new
> >   -------     ---             ---
> >   1 .. 1170   4096            4096
> >   1171 .. 1860        4098 .. 6510    4096
> >   ...         ...             ...
> >   2*4096      28672           19925
> >   4*4096      57344           43597
> >   8*4096      114688          92749
> >   16*4096     229376          191053
> >   32*4096     458752          403197
> >   64*4096     917504          861949
> >   128*4096    1835008         1779453
> >   256*4096    3670016         3670016
> >
> > Under the hood the reccurent formula is being used:
> >   (5 - 0) * 2 +
> >     (50 - 5) * 3 +
> >       (500 - 50) * 4 +
> >         (5000 - 500) * 5 +
> >           ...
> >             (X[i] - X[i-1]) * i
> >
> > which allows to count the exact maximum length in the worst case,
> > i.e. when each second CPU is being listed. For backward compatibility
> > for more than 1170 and less than 1861 CPUs the page size is preserved.
> >
> > For less than 1171 and more than 1 million CPUs the old is being used.
>
> The memory is not really wasted since it's probably temporary in userspace
> and in the kernel it _is_ temporary and is only the length of the kasprintf
> string, which is most of the time much less.
>
> But that said, it is more accurate than the previous estimate.
>
> I was wondering if you were going to try to come up with a suitable
> compile time macro :)
>
> I tested 2, 8192 and 16k since the kernel does not want to build for other
> reasons with NR_CPUS at 32k.
>
> Reviewed-by: Phil Auld <pauld@redhat.com>
> Tested-by: Phil Auld <pauld@redhat.com>

By the way, why don't we use nr_cpu_ids? It's set at boot-time, or even
at compile-time in some cases and never changed at runtime.

nr_cpu_ids is set very early, when ACPI tables are parsed. I don't think
it's possible for a userspace to observe it uninitialized. Am I wrong?
