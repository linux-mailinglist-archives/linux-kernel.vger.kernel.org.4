Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E40C7434E5
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 08:21:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232079AbjF3GVN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 02:21:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbjF3GVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 02:21:08 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 558E8297C
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 23:21:05 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4fb863edcb6so2481169e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 23:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1688106063; x=1690698063;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rRbIAUxLipf503mIOlM3ZYKM925BvMPEOuWIEIxYBNQ=;
        b=CrM6MIO3GbfCj7zT1PPreU9nBHcw3pL/wAJMWj/NG6NeXgv4aBmucz9ql8bN1LC4vX
         HlIlN5FBkN7BYKCt3/ZnFgrdAngpdi5v0rQat2VCu9pYg1D0qUz8yI5yP/SdsDn4bR3C
         O/+dKjILp1NTKG9/D6ERNgIfWmhq45YtWaqp0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688106063; x=1690698063;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rRbIAUxLipf503mIOlM3ZYKM925BvMPEOuWIEIxYBNQ=;
        b=JTeY3XlrlVyvmBObbdw3fdE9dBRb2hAF3oLJkFCjMCxENq7SCzNL3IzsxWzBwB6PHA
         sU1Wby+YGFOnYoP28RuhNdyyK6HZE+3Aei/tg63sU/Rnk8OBwiUmGwVxRAMy+kkf0Cik
         1t/5hg/gdDlpFJNRkn1+Epy0b1vdEZa2O8HrKoRjH42WGzb94lg7MoamLuTWlMG55v3K
         xwRT0YgAInW/zQHPfVcIwisOS5MhvMAlgec86AlnyK0F7E8kdw/jPgsh8KEFtj+4wFrI
         lZLyOGcBrVNH8c0MLybL2RfqTf3f+SysvVIQ7cA4G/lsq8gT/+mIE4cYOid0jro1o0WK
         tTQw==
X-Gm-Message-State: ABy/qLbZBvx6NeN9CiOod9X+Rn6ZjmAq6XLVLqPiC12CjtpGAc7j51RY
        vjp6txWC/VnNemAPqi16EQiPqA7ZEisJYuqsC9TwLpJK
X-Google-Smtp-Source: APBJJlFG+qVMly5sckyRApFM7g9nnvRKqY+hRHREnDbfKAADrbm4EQod/6MZZpBjBegTt7bBjTxGdA==
X-Received: by 2002:a05:6512:ea0:b0:4f8:6882:ae9d with SMTP id bi32-20020a0565120ea000b004f86882ae9dmr1775262lfb.69.1688106063545;
        Thu, 29 Jun 2023 23:21:03 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id e25-20020ac25479000000b004f3b3f5751bsm111730lfn.275.2023.06.29.23.21.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jun 2023 23:21:02 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2b6994a8ce3so22931971fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 23:21:02 -0700 (PDT)
X-Received: by 2002:a05:651c:206:b0:2b6:9f64:c375 with SMTP id
 y6-20020a05651c020600b002b69f64c375mr1282639ljn.47.1688106061998; Thu, 29 Jun
 2023 23:21:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230630055626.202608973@linuxfoundation.org>
In-Reply-To: <20230630055626.202608973@linuxfoundation.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 29 Jun 2023 23:20:45 -0700
X-Gmail-Original-Message-ID: <CAHk-=when9OgPprG57O+DtVFM7X9_wb6x2h4Veq4Gu6TUvxyiQ@mail.gmail.com>
Message-ID: <CAHk-=when9OgPprG57O+DtVFM7X9_wb6x2h4Veq4Gu6TUvxyiQ@mail.gmail.com>
Subject: Re: [PATCH 6.4 00/29] 6.4.1-rc2 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Jun 2023 at 22:59, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> Linus Torvalds <torvalds@linux-foundation.org>
>     gup: add warning if some caller would seem to want stack expansion

Did you decide to take that one after all?

It's not exactly wrong, and it might help find any odd cases, but I do
suspect you can get syzbot etc to trigger the warning. It's designed
to find crazy users, and syzbot is - pretty much by definition and by
design - one of the craziest out there.

            Linus
