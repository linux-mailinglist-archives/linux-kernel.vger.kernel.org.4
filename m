Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD86B60C0C6
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 03:16:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbiJYBQs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 21:16:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230527AbiJYBQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 21:16:22 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A20B75143E
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 17:34:30 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id b12so34075087edd.6
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 17:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=23CZ4vA4i98W1nbCbv2ZjLLFBQ1q7plrKRviYMc9dQY=;
        b=gUtM1bX+9AmKX0fN+I2coUZ/gBg5Zmg+i1ZO44YmZLIMFCKsYf5MbCnmv3nYoYBM9T
         Nk+Opwq8i7lXrs6x+2lkbcakPKleOk5ygjBcjiKOAVSA/LVrtj3bPz1Zn+gWXsKa3mV7
         7V0idwlnPxnsM3bKEtlZeAwhPMHKlf5jv1bM4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=23CZ4vA4i98W1nbCbv2ZjLLFBQ1q7plrKRviYMc9dQY=;
        b=ECS+KCObA06dF5EGxsdrevJSil0Ne7sYxf7EdcGZUbST6Ss2iZdUEIEjHE1GTk1bYB
         qV1XK6JEnXcz4bz/oAMD4Xuzue8/LfSyFcEw+IJbJXnqen4DyOD2wwVCGs4tcXk3VYEt
         eDp/zgcpEFLnMxJf2AAWTC4b+9jqODIOxkQ2psoNGEshDyo1kOQ/OOUD0+F6JCvmr+/L
         Ma2WHa7rEGQoqaBThWaAa647mXrdCwzTwPBb8C1m6G+hxZKmjh6ERWqjbMUrkwqwsaXi
         4Veq1Vz+vZr22hGhBgdiyC7mdN/iF7UrIjiiGLL+enqeFx85HCcifNMPBZl2mg7IavRk
         GXsw==
X-Gm-Message-State: ACrzQf2FWvxUiGaDh5SWnWzJ/8t2F4KQvg4TYKdP2yVk6gBFy/3WFPJZ
        kKc6BTbCXqO6+vYeTCHstxI18I2H+Umxc3bh
X-Google-Smtp-Source: AMsMyM4icRGwvjQ64ZJ3VCzVuqxI77jy4F4/CKwgCweqVKEexjqUcsdJvvzN7apjw5j6O30YQIYCJg==
X-Received: by 2002:a50:871a:0:b0:461:52a9:1da6 with SMTP id i26-20020a50871a000000b0046152a91da6mr17314609edb.94.1666658068388;
        Mon, 24 Oct 2022 17:34:28 -0700 (PDT)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com. [209.85.221.41])
        by smtp.gmail.com with ESMTPSA id t16-20020a50ab50000000b00461bd82581asm607849edc.84.2022.10.24.17.34.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 17:34:27 -0700 (PDT)
Received: by mail-wr1-f41.google.com with SMTP id h9so7389727wrt.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 17:34:27 -0700 (PDT)
X-Received: by 2002:a05:6000:3c1:b0:236:5779:546d with SMTP id
 b1-20020a05600003c100b002365779546dmr12326195wrg.405.1666658067197; Mon, 24
 Oct 2022 17:34:27 -0700 (PDT)
MIME-Version: 1.0
References: <20221019145600.1282823-1-john.ogness@linutronix.de> <20221019145600.1282823-2-john.ogness@linutronix.de>
In-Reply-To: <20221019145600.1282823-2-john.ogness@linutronix.de>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 24 Oct 2022 17:34:15 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XQ8WFoZUm=P+kKo2oGAfSGOmadvhDkE4PQe6_-33zi_w@mail.gmail.com>
Message-ID: <CAD=FV=XQ8WFoZUm=P+kKo2oGAfSGOmadvhDkE4PQe6_-33zi_w@mail.gmail.com>
Subject: Re: [PATCH printk v2 01/38] serial: kgdboc: Lock console list in
 probe function
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        kgdb-bugreport@lists.sourceforge.net, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Oct 19, 2022 at 7:56 AM John Ogness <john.ogness@linutronix.de> wrote:
>
> From: Thomas Gleixner <tglx@linutronix.de>
>
> Unprotected list walks are not necessarily safe.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> Reviewed-by: Petr Mladek <pmladek@suse.com>
> ---
>  drivers/tty/serial/kgdboc.c | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
