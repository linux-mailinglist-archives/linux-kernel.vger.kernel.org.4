Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57CB45F3A7F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 02:20:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbiJDAUa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 20:20:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbiJDAUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 20:20:23 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EA3812D01
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 17:20:22 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-1326637be6eso5122861fac.13
        for <linux-kernel@vger.kernel.org>; Mon, 03 Oct 2022 17:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=KDirZKludynJAQMkevqVYFO9iXAJsphavJFWStzbFqw=;
        b=S/SQ9Q+AQduFC8tL8YQbDrp+oISUO260VFWdJo+rwPI/o8Lh0vhX0Dsre8it2u+6t3
         WmcIZTOLFS3I8Aghe89U6F2WcLrG7GIg09Nrc0ebZf4q0+AoBpqA2xEYbVC9ITUilxxS
         fpv+gFLsoSPyiYScbLvABZ6SlEsPhgW431nA4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=KDirZKludynJAQMkevqVYFO9iXAJsphavJFWStzbFqw=;
        b=aZTAkuzOtZAR/N36WPC7n05xwmDkIh0NIMrYmiqzI9gvxIe75581gdVQUEEUXNmBd3
         pDpQ5ijm6Il4HqP/lO3CF23U8uqP04DfFNxsikLYdphu2kqQBsRJBIxJMZ2I6th3HWr4
         A0hbzls//zHcZDMy7uzK7wsanSX5ImKOiK/C9JPTvb2AXJXQTM8jmL+q9HNOePBIdYwk
         knBSxQSo9zrTjfy5cnVEVyHaYTbJhXfnkb1YThCtYZ7kfp8nRw0E25l0y5EEjTQ5sCoH
         3+Ki9biM3UbghoN9MdEc81oweASbd9WBWgTAu/kgEfgJlVkAlri7nQ1f7vxJLVB50o34
         J0CQ==
X-Gm-Message-State: ACrzQf3Fjwxz1lPi/xapwL37hvBjyRUg7Ijmzy8uJo0HQex+hdDt0uCN
        /4i+G678MKq6Cs2thGEY77TwqIZdUio10w==
X-Google-Smtp-Source: AMsMyM6AfdpvZxowNjCx+RWf3uD3uVk59jbFuG4I4n/kp6mGq1i9X4GZaAVWcPvJKxdnes4pujtehg==
X-Received: by 2002:a05:6870:3449:b0:11d:1e78:266c with SMTP id i9-20020a056870344900b0011d1e78266cmr6890197oah.122.1664842821242;
        Mon, 03 Oct 2022 17:20:21 -0700 (PDT)
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com. [209.85.167.172])
        by smtp.gmail.com with ESMTPSA id m18-20020a056870889200b0012d939eb0bfsm3259664oam.34.2022.10.03.17.20.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Oct 2022 17:20:20 -0700 (PDT)
Received: by mail-oi1-f172.google.com with SMTP id s125so12970043oie.4
        for <linux-kernel@vger.kernel.org>; Mon, 03 Oct 2022 17:20:20 -0700 (PDT)
X-Received: by 2002:aca:b957:0:b0:351:4ecf:477d with SMTP id
 j84-20020acab957000000b003514ecf477dmr5055919oif.126.1664842820161; Mon, 03
 Oct 2022 17:20:20 -0700 (PDT)
MIME-Version: 1.0
References: <YzN+ZYLjK6HI1P1C@ZenIV> <YzSSl1ItVlARDvG3@ZenIV>
 <YzpcXU2WO8e22Cmi@iweiny-desk3> <7714.1664794108@jrobl> <Yzs4mL3zrrC0/vN+@iweiny-mobl>
 <YztfvaAFOe2kGvDz@ZenIV> <4011.1664837894@jrobl> <YztyLFZJKKTWcMdO@ZenIV>
In-Reply-To: <YztyLFZJKKTWcMdO@ZenIV>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 3 Oct 2022 17:20:03 -0700
X-Gmail-Original-Message-ID: <CAHk-=whsOyuRhjmUQ5c1dBQYt1E4ANhObAbEspWtUyt+Pq=Kmw@mail.gmail.com>
Message-ID: <CAHk-=whsOyuRhjmUQ5c1dBQYt1E4ANhObAbEspWtUyt+Pq=Kmw@mail.gmail.com>
Subject: Re: [PATCH][CFT] [coredump] don't use __kernel_write() on kmap_local_page()
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     "J. R. Okajima" <hooanon05g@gmail.com>,
        Ira Weiny <ira.weiny@intel.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 3, 2022 at 4:37 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> One variant would be to revert the original patch, put its
> (hopefully) fixed variant into -next and let it sit there for
> a while.  Another is to put this incremental into -next and
> merge it into mainline once it gets a sane amount of testing.

Just do the incremental fix. It looks obvious enough ("oops, we need
to get the pos _after_ we've done any skip-lseeks on the core file")
that I think it would be just harder to follow a "revert and follow up
with a fix".

I don't think it needs a ton of extra testing, with Okajima having
already confirmed it fixes his problem case..

                Linus
