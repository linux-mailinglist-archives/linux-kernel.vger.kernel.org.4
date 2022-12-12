Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 560F164A631
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 18:49:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232657AbiLLRtj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 12:49:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232100AbiLLRth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 12:49:37 -0500
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11F2DD5D
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 09:49:36 -0800 (PST)
Received: by mail-vs1-xe36.google.com with SMTP id k185so12018099vsc.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 09:49:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MOjULHTt7nLPet/vxlEOzclUsoaCmUAkQsVZp1GujxA=;
        b=OVPooWVg0d9eqFjdwIu/t1V+VaF6fmj9sRArWnJcXCR5LHGnqYfUMDxcAYw14Ks7El
         isxqxVZcOXaBHdyQU1fHFyM4paxtwqnKCsjBR/WvsfJ7GNUC/NBHvGL0UcfHOQtmkUbP
         TlYxu0IQerIMtvqwAggp7KAuZ6PeSnUcPfb7c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MOjULHTt7nLPet/vxlEOzclUsoaCmUAkQsVZp1GujxA=;
        b=Pbddvhx1dgNekdxlZ5xNTUZ528Frnn71QMGJ08cdMchKwBkUKSyEVRJvxolr+ySzAt
         ZPAhweHM3+ejvdnl5BxeH0i42Cou3Ep/b4UVlhba03tpT5RV/hlzaHK8sMgZ0HH03ydI
         kSRHbkK0vdBQI7Y1g/03ePywr55EA42NCTCmR1eB2wsyAwFQwsEHZkSUuyA5pO6m3DQ6
         YHwmU7yhp4fjUbFIWFbrfEC+9pWuDhow0I/Iyabo2pLEseR73gKO8qNWkdplk/fopDfI
         JOou0RWi4qdyyNxI8LwSOzJJBCA/OQK5OF0HTXbVhmUiJU4Ms4tWxRcYZucmZYpkoj+/
         +X0Q==
X-Gm-Message-State: ANoB5plmQJq93AQkJo0oh0ZtUl+RGKtPcdTH98POn+Wu5fJnNtb3s2Jz
        duVbwLO5uDdsSbCqjjPf0fhoqbb0EfEQJqLf
X-Google-Smtp-Source: AA0mqf6vChL5SUBMQBhyS9TNr7I0C4u23CR6/WqEb9agZXxCLk0Vuuzx30XCpnhIAD5yq4laODjEhw==
X-Received: by 2002:a67:f854:0:b0:3b2:a92d:a1ed with SMTP id b20-20020a67f854000000b003b2a92da1edmr7902867vsp.30.1670867374801;
        Mon, 12 Dec 2022 09:49:34 -0800 (PST)
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com. [209.85.160.178])
        by smtp.gmail.com with ESMTPSA id v5-20020a05620a440500b006f474e6a715sm6199471qkp.131.2022.12.12.09.49.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Dec 2022 09:49:34 -0800 (PST)
Received: by mail-qt1-f178.google.com with SMTP id c7so2072546qtw.8
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 09:49:34 -0800 (PST)
X-Received: by 2002:a05:622a:1745:b0:3a6:8b84:47ce with SMTP id
 l5-20020a05622a174500b003a68b8447cemr33321945qtk.678.1670867373893; Mon, 12
 Dec 2022 09:49:33 -0800 (PST)
MIME-Version: 1.0
References: <b7ece19c-e50e-0709-7be1-2945883d155b@monstr.eu>
In-Reply-To: <b7ece19c-e50e-0709-7be1-2945883d155b@monstr.eu>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 12 Dec 2022 09:49:18 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiuqbgRZcotVf93Db4+gcPz8yAhW0mMfNZbEkM66rNB3Q@mail.gmail.com>
Message-ID: <CAHk-=wiuqbgRZcotVf93Db4+gcPz8yAhW0mMfNZbEkM66rNB3Q@mail.gmail.com>
Subject: Re: [GIT PULL] arch/microblaze patches for 6.2-rc1
To:     Michal Simek <monstr@monstr.eu>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Thu, Dec 8, 2022 at 2:07 AM Michal Simek <monstr@monstr.eu> wrote:
>
> Microblaze patches for 6.2-rc1
>
> - Cleanup PCI support

That tag looks normal in the email, but it's actually nastily encoded.
When I fetched it, I did this:

     git cat-file tag FETCH_HEAD | hexdump -c

and it shows

...
0000080   9   3   5   4   6       +   0   1   0   0  \n  \n   M   i   c
0000090   r   o   b   l   a   z   e 302 240   p   a   t   c   h   e   s
00000a0 302 240   f   o   r 302 240   6   .   2   -   r   c   1  \n  \n
00000b0   -       C   l   e   a   n   u   p       P   C   I       s   u
00000c0   p   p   o   r   t  \n   -   -   -   -   -   B   E   G   I   N
...

Note how the "spaces" between "Microblaze", "patches", "for" and "6.2"
are not actually regular space characters, but \xc2\a0, which is utf-8
encoding for unicode character A0 ("no-break space").

Please don't do that.  I have my editor show odd characters as hex
codes (I don't want any hidden information), which is why I noticed,
and I'm not sure why/how you did it.

               Linus
