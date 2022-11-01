Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F0AF614A31
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 13:00:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230406AbiKAMAS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 08:00:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230316AbiKAMAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 08:00:16 -0400
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64DC4D5B
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 05:00:15 -0700 (PDT)
Received: by mail-vs1-xe2f.google.com with SMTP id t5so5618090vsh.8
        for <linux-kernel@vger.kernel.org>; Tue, 01 Nov 2022 05:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OyhJRlri+Ua8la0vT3fYEy+X4DHeUkraR4jrupnv/Ro=;
        b=LLWUSWTahHJNf74iOqqhW3ealUpzKgZr3mY7FFxf/p9Jc38hodpkHq8elNbEsL8W4T
         Z9M/8nV0IJiEMr7eUiqtsjP65sPJvOU2qjEg4c+ZalXiBhz65Qfm594sSPtXf/HPTq/L
         gtsz/aS98e1AdIsUvhdiHMC4IfEgvnyHHaH3kOGHOSRil7+bu9JOD6VMCKKnvH5OlL5l
         a3ZMKkl4104+7rZGJAMG7Y47KStW2gfuLuphCf2sgaJVoqdQGvFpj19n+tDhrCaXuh4r
         zaOCOKC+9y0iUXi3qJQLF6emzicjCh85WAVoi1cGPs7T4Y8nlbcbPoij0+yFAgCHggw4
         Z6JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OyhJRlri+Ua8la0vT3fYEy+X4DHeUkraR4jrupnv/Ro=;
        b=g4CBQ2J0zXDXDS0KfnjWeSwHjI1F21ygmBq8kG8riOIemXvxoQpxVXISfV2++8nhwe
         AP+lbcOu7O3M0MFaw2hZBMHTd5C5C23uoPw49EUgS/qk+eUBHI+ON4tqfmF0mCLT90Ox
         OuL7DH1Xcoo58cfBMIIsrs2xeJgLCmgHzQCvHqFhfbBhc7Yt38CrWHaTVas3O2xJBQ0S
         U+EMwA/HUrvBHS/YJBNznf7dWZeqclsofgNZQ+3AggEAfRcwtAiwjMZqx/qEULmHn2Ia
         PW+RmgPHsKiLsYgQvej8r4d4U2ZbdSJALsQ4TVMyzRJYSudhc97pyBLVDeCwdvY8A+Ks
         s/PQ==
X-Gm-Message-State: ACrzQf2RACy7HFYaN5PYToL2qUIXEiCeukZjBYJf7Ni511BlRptGZAkb
        pzla1YnN/53H1AeJRX+l+0vpM1p/x69v/58qif/wnw==
X-Google-Smtp-Source: AMsMyM45tMNHb3fFKpqRgP2ZyymkN3exp6A62pwnq8o3DEMttkS7aIUy0I1Di48cJ/Ke90w1GFxStn9bMpNfnB57tvM=
X-Received: by 2002:a05:6102:534c:b0:3a7:c31a:a661 with SMTP id
 bq12-20020a056102534c00b003a7c31aa661mr6871842vsb.7.1667304014246; Tue, 01
 Nov 2022 05:00:14 -0700 (PDT)
MIME-Version: 1.0
References: <20221024112959.085534368@linuxfoundation.org> <20221024113002.025977656@linuxfoundation.org>
 <CAMSo37XApZ_F5nSQYWFsSqKdMv_gBpfdKG3KN1TDB+QNXqSh0A@mail.gmail.com> <Y2C74nuMI3RBroTg@kroah.com>
In-Reply-To: <Y2C74nuMI3RBroTg@kroah.com>
From:   Yongqin Liu <yongqin.liu@linaro.org>
Date:   Tue, 1 Nov 2022 20:00:03 +0800
Message-ID: <CAMSo37Vt4BMkY1AJTR5yaWPDaJSQQhbj7xhqnVqDo0Q_Sy6ycg@mail.gmail.com>
Subject: Re: [PATCH 4.19 092/229] once: add DO_ONCE_SLOW() for sleepable contexts
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Eric Dumazet <edumazet@google.com>, Willy Tarreau <w@1wt.eu>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Benjamin Copeland <ben.copeland@linaro.org>,
        =?UTF-8?B?RGFuaWVsIETDrWF6?= <daniel.diaz@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Greg

On Tue, 1 Nov 2022 at 14:26, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, Nov 01, 2022 at 02:07:35PM +0800, Yongqin Liu wrote:
> > Hello,
> >
> > As mentioned in the thread for the 5.4 version here[1], it causes a
> > crash for the 4.19 kernel too.
> > Just paste the log here for reference:
>
> Can you try this patch please:
>
>
> diff --git a/include/linux/once.h b/include/linux/once.h
> index bb58e1c3aa03..3a6671d961b9 100644
> --- a/include/linux/once.h
> +++ b/include/linux/once.h
> @@ -64,7 +64,7 @@ void __do_once_slow_done(bool *done, struct static_key_true *once_key,
>  #define DO_ONCE_SLOW(func, ...)                                                     \
>         ({                                                                   \
>                 bool ___ret = false;                                         \
> -               static bool __section(".data.once") ___done = false;         \
> +               static bool __section(.data.once) ___done = false;           \
>                 static DEFINE_STATIC_KEY_TRUE(___once_key);                  \
>                 if (static_branch_unlikely(&___once_key)) {                  \
>                         ___ret = __do_once_slow_start(&___done);             \


This change works, it does not cause kernel panic again after this
change is applied.

-- 
Best Regards,
Yongqin Liu
---------------------------------------------------------------
#mailing list
linaro-android@lists.linaro.org
http://lists.linaro.org/mailman/listinfo/linaro-android
