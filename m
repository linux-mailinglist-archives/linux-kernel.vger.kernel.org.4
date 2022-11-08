Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A5A1621F66
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 23:39:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbiKHWjh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 17:39:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiKHWje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 17:39:34 -0500
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A6B160354
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 14:39:34 -0800 (PST)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-13d9a3bb27aso17094670fac.11
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 14:39:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/iT2V0+tQxLZsJICdQg59XlFu2/MLGUwh4giryzJ2M0=;
        b=ICm23jsQ4wdOkSkDuvly1QVqoPytp9haz2v1LjvoeGLVJH9FIR4AyyOH/NFjOrtxi1
         B/H6EBQqzG7LanFT66euegYuzZFZZiTmk/DcaMWZtl1n4lK6Az2iCmQ3HxD++xJOx8Qd
         HkOMIF1ZZ2Ohq0FCllMqc2J4z135+5BpkMihQLi5XuVlfDhicgi3lxbE3h/5TDttK7Mf
         pOfN3kaFDtIlLyD4sozk8RI1jslvNTObnkLpfycgwiQEQPAL6l/HZpE1jjEHhgip8JzZ
         3gs8i7tZ2V56xO1OCuHRfEKQ/oxejvmnKNz9oY57bkozIMB8nOzi/d5oLykBS2UpRcNp
         pq/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/iT2V0+tQxLZsJICdQg59XlFu2/MLGUwh4giryzJ2M0=;
        b=CGN6aW1jd+U0qXH/4No93dN6f2mQgpJjDVq60lG0ffy0cdxd56hMyLuv+7dvbzgWb2
         fjXwTb31dYH9njJwKXuFkkOJ7wpFu7IKVBKPa7BQ3EwFnQ/1t1W9FzVtBpuEJdZS+EPi
         rZ1XCkAewF+JxOwZPfynpJ10T0GWeJNr9H32h3EIGv+EqVzTm3dyrxzRDG27khx2BXGx
         ULwYRFM6+nbGf68cfYU+k7N9fgePTotAlv8IF/XtZo6viUBXGapugjk26qnsMmgfjT+N
         Md1FzuPW2d92/crjO1sg4QUp7DVWUDifZGsyMgHOYHOhQasOovy4bHMbg1yt/AzXHfIP
         LloA==
X-Gm-Message-State: ACrzQf31VTFzqj02iUDfp7nLGN5qLwiWkw+lt46eaX96k7JjxSe6e4He
        F9rv5oD1Pk7mSBF0RKuA24bVCbGB128aaVkH5xXXMQ==
X-Google-Smtp-Source: AMsMyM4IufYTlvc6thSOGbvJFOSUOuyMiyKKIhnuNmYNTwpkUcVkstkGJdDySVWlN34cPCqWVOREmvOavwxL3Nc1Ajs=
X-Received: by 2002:a05:6870:b6a3:b0:13b:f4f1:7dec with SMTP id
 cy35-20020a056870b6a300b0013bf4f17decmr34481709oab.282.1667947173215; Tue, 08
 Nov 2022 14:39:33 -0800 (PST)
MIME-Version: 1.0
References: <000000000000e915eb05ecf9dc4d@google.com> <Y2qjerZigLiO8YVw@zx2c4.com>
In-Reply-To: <Y2qjerZigLiO8YVw@zx2c4.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 8 Nov 2022 14:39:22 -0800
Message-ID: <CACT4Y+a3bJmMf8JNm=SZYOKtgSVnOpY4+bgdT4ugLLhVV-NCEA@mail.gmail.com>
Subject: Re: [syzbot] linux-next boot error: WARNING in kthread_should_stop
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     syzbot <syzbot+25aae26fb74bd5909706@syzkaller.appspotmail.com>,
        herbert@gondor.apana.org.au, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
        linux@dominikbrodowski.net, olivia@selenic.com,
        sfr@canb.auug.org.au, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Nov 2022 at 10:44, 'Jason A. Donenfeld' via syzkaller-bugs
<syzkaller-bugs@googlegroups.com> wrote:
>
> Already fixed in the tree.

Hi Jason,

The latest commit touching this code in linux-next is this one. Is it
the fixing commit?

commit e0a37003ff0beed62e85a00e313b21764c5f1d4f
Author:     Jason A. Donenfeld <Jason@zx2c4.com>
CommitDate: Mon Nov 7 12:47:57 2022 +0100
    hw_random: use add_hwgenerator_randomness() for early entropy
