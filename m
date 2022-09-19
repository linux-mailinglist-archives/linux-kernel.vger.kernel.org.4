Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 116145BC52C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 11:18:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbiISJSK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 05:18:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbiISJSH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 05:18:07 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D46D1F627
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 02:18:06 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id dv25so62909314ejb.12
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 02:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=71tJeFVKAFJ3SyXs+rHfkSElvEqevvrgispgsbeaJQk=;
        b=oKnCZapF9aLxY830pJtvgk/IqGq1UKs9KlKo2+7C/xa1SuE7wtYq0h07vI3SAe+5iv
         sZp9QpRF/wCHDF88iDwOzJPZtPm116YC+uIMZ2ormEb9EWPLjfuP334xZbz6uSvBSjsf
         pSarGpzCUKkYESOBiTTlxBerflIEXIXz0oq7Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=71tJeFVKAFJ3SyXs+rHfkSElvEqevvrgispgsbeaJQk=;
        b=UtwOEAbcMAJmPHX1Pp9U7sBLdhZ6DlJ2Clvrz8D0xZOfiHmvYDEUFoRtwOmiFqvzYc
         pnKmHKwuOEm6/hf3HxhNun6l25rlCtovcRPuoPGdLnvWBlu0nhGr3R58/PjEgIget8+0
         nH6vL8vdh0gCWwCzKEEi+f1D0gmaxQG1iPWl1WK/9T2mLlkB8tcIOwaFz8XVhOzJTlUs
         qjr53vzi31TKgfLDDlLa+1P0oOCOiQ5JHmdnhDqUfvIm1aZM8lzTfVYG1JVaisw/oZmg
         6N0bTYt13wxHCZk+VWc43kL7zaK3P27plgJUjjBtVxild0VbKGTPB9PoWE6l57lC2tJf
         rZjQ==
X-Gm-Message-State: ACrzQf3j2vIJYS0a+mWBQJYhOTVwuMBbKZNsrnEEG/CmVZTqGO51P/kq
        ZYsjEoIrfF+B7OVNCetvrziYw87VDtCt0PUzCc+WPQ==
X-Google-Smtp-Source: AMsMyM7lt/rH/e2dmoH4VM3K1NvxvNman4UFrxYursBOoYlQYK+kXdH9VUYpWMT3bzFEiOzHguoTyZgzZ1pnuqAqHJU=
X-Received: by 2002:a17:907:6087:b0:77a:51e9:8e86 with SMTP id
 ht7-20020a170907608700b0077a51e98e86mr12197341ejc.31.1663579084797; Mon, 19
 Sep 2022 02:18:04 -0700 (PDT)
MIME-Version: 1.0
References: <CAOf5uwk=Tx+W-JuJBXUYjt2BLmSvr9Q153D1RTyJG_cmeO4AUw@mail.gmail.com>
 <826cd775-14d2-12ae-2e96-cf0766aa1502@redhat.com>
In-Reply-To: <826cd775-14d2-12ae-2e96-cf0766aa1502@redhat.com>
From:   Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date:   Mon, 19 Sep 2022 11:17:53 +0200
Message-ID: <CAOf5uwmKfcC0OiiuN82tUzcE1XkPuA3N3u+o3Ue_ZPNJqeSM+g@mail.gmail.com>
Subject: Re: Correlation CMA size and FORCE_MAX_ZONEORDER
To:     David Hildenbrand <david@redhat.com>
Cc:     Mike Rapoport <rppt@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David

On Mon, Sep 19, 2022 at 10:38 AM David Hildenbrand <david@redhat.com> wrote:
>
> On 15.09.22 23:36, Michael Nazzareno Trimarchi wrote:
> > Hi all
>
> Hi,
>
> >
> > Working on a small device with 128MB of memory and using imx_v6_v7
> > defconfig I found that CMA_SIZE_MBYTES, CMA_SIZE_PERCENTAGE
> > are not respected. The calculation done does not allow the requested
> > size. I think that this should be somehow documented and described but
> > I did not
> > find the documentation. Does it work this way?
> >
> > With CMA_SIZE of 8MB I need to have FORCE_MAX_ZONEORDER=12 if I have
> > the default FORCE_MAX_ZONEORDER=14 the min size is 32Mb
>
> The underlying constraint is that CMA regions require a certain minimum
> alignment+size. They cannot be arbitrarily in size.
>
> CMA_MIN_ALIGNMENT_BYTES expresses that, and corresponds in upstream
> kernels to the size of a single pageblock.
>
> In previous kernels, it used to be the size of the largest buddy
> allocation granularity (derived from MAX_ORDER, derived from
> FORCE_MAX_ZONEORDER).
>
> On upstream kernels, the FORCE_MAX_ZONEORDER constraint should no longer
> apply. On most archs, the minimum alignment+size should be 2 MiB
> (x86-64, aarch64 with 4k base pages) -- the size of a single pageblock.
>
> So far the theory. Are you still running into this limitation on
> upstream kernels?
>

I can run 6-rc2 on my board. I test again but according to it, if I
put 4M as CMA in cma=4M in boot
parameters, the result is 32Mb of CMA. Apart of that seems that
process lime tiny membench can not even start
to mblock memory

Michael

> --
> Thanks,
>
> David / dhildenb
>


-- 
Michael Nazzareno Trimarchi
Co-Founder & Chief Executive Officer
M. +39 347 913 2170
michael@amarulasolutions.com
__________________________________

Amarula Solutions BV
Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
T. +31 (0)85 111 9172
info@amarulasolutions.com
www.amarulasolutions.com
