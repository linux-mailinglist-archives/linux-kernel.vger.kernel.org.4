Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0558564C754
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 11:44:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238007AbiLNKo3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 05:44:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238008AbiLNKoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 05:44:25 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0C77233BB;
        Wed, 14 Dec 2022 02:44:24 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id i20so2106329qtw.9;
        Wed, 14 Dec 2022 02:44:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZDIL6PfgnP6z43gsepEkQm3fUfrrHQIHaFFTMO+nX+w=;
        b=bqJcB8rqreRUhEUdlcFPtd/gqim3dUGGU/B2KGqSaxIf+RAYo6tmx8nFK5ZWhQG114
         J1FmbnjZUou7+An5geok+Tdm02OGFTswxTE8HdF5VQSTVueqwHqnXvv7esp+/KAW7mrq
         nGoY6JMr6h2TBgfBvX+opQUd1uxRETZB8WnhsnqSFYkAu9bcK2LjKdaP3Humbr0H/Fha
         N3fq852fIAyjzr0bxCjVqB3l+SxhM5z+Yhp8ZIKI/yL2f6anAt4uEMF3hm4v2Aazwnxi
         4caRNXGgO66ycZzYqBdVT4iD70S3kdCZGe5gP8bESZM4xwYzucEAuWt2g7eXZ4T9hSqi
         Lk/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZDIL6PfgnP6z43gsepEkQm3fUfrrHQIHaFFTMO+nX+w=;
        b=bci5y3IFBlillvsYyxnYswyPmoMlE5vcdU3M/ifWrfoH7xROl8b41cyEnL8OIc6MB/
         7Kqd1b6qsG/9saKsUqMyHzDsjuz52DCxvEtpFcGUDcMV+MZDmTnSC6gkyooXKkB3Vbhp
         Im/daw8I5FOUVNUuXf9xKAhrvmKcvuH98fdisF+t9QDCIYJf0Zf2WPM8OW0iz0OiGYUh
         NKNhA+jXH9NNcgBoebucTNXDZDrzXceaRylJGMvGjevgNMKwIPW8uGMO47iKLqplExXR
         NOVqbSJt30qWhS+5u2W+BlnUzkU+HSjJ3BJ2Drru7nUhzIJ+IfgJMtbi7+xB3/2p+pGw
         iPaw==
X-Gm-Message-State: ANoB5pm9QEXptGtrZdJIvXC3zyxZXkNKEYOJMaU9SYXbLpqiZGZoCnHZ
        vl7RwzIHT5k1SEYyxvlAsiFFmFJ6A4tvfAms/xA=
X-Google-Smtp-Source: AA0mqf5tb1B2/qwbkS7yM3pg2zu32mvNCOhkrHG63c0Vc2ewslHnJhLoZb4HrKCqHI7fFmJZikciIzpvMwnMpls3JhY=
X-Received: by 2002:ac8:5501:0:b0:3a5:cb82:109b with SMTP id
 j1-20020ac85501000000b003a5cb82109bmr88723174qtq.61.1671014663932; Wed, 14
 Dec 2022 02:44:23 -0800 (PST)
MIME-Version: 1.0
References: <Y5mMWEtHWKOiPVU+@mail.google.com> <Y5mQTOqFOGbJMerV@mail.google.com>
In-Reply-To: <Y5mQTOqFOGbJMerV@mail.google.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 14 Dec 2022 12:43:48 +0200
Message-ID: <CAHp75Vd914H7swqqqydSLYOJh-4=+rWNCUdqizaQQxmVtpiMSA@mail.gmail.com>
Subject: Re: [PATCH v2] [next] pcmcia: synclink_cs: replace 1-element array
 with flex-array member
To:     Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Haowen Bai <baihaowen@meizu.com>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
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

On Wed, Dec 14, 2022 at 10:58 AM Paulo Miguel Almeida
<paulo.miguel.almeida.rodenas@gmail.com> wrote:
>
> One-element arrays are deprecated, and we are replacing them with
> flexible array members instead. So, replace one-element array with
> flexible-array member in struct RXBUF. No changes were required
> within the source code because of the existing padding in RXBUF struct

You shouldn't rely on padding. Make you change robust independently on
the padding. See also below.

> It's worth mentioning that doing a build before/after this patch
> results in no binary output differences.

This is interesting...

> This helps with the ongoing efforts to tighten the FORTIFY_SOURCE
> routines on memcpy() and help us make progress towards globally
> enabling -fstrict-flex-arrays=3 [1].
>
> Link: https://github.com/KSPP/linux/issues/79
> Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=101836 [1]

>

The blank lines are not allowed in the tag block (in case you want to
have Link: to be recognized as a tag).

> Signed-off-by: Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
> ---
> Changelog:
>
> - v2: removed changes to how the size of RXBUF was calculated. I
>   changed my mind after thinking about the existing padding in the
>   struct. Happy to discuss it if anyone sees it differently.

I feel worried about in particular this code:

/* each buffer has header and data */
info->rx_buf_size = sizeof(RXBUF) + info->max_frame_size;

which means that entire rx_alloc_buffers() should be revisited. Also
take into account the use of one or more macros from overflow.h for
memory allocation.

-- 
With Best Regards,
Andy Shevchenko
