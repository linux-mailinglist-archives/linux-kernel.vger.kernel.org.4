Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FAAF6214E3
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 15:06:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235062AbiKHOGL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 09:06:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234930AbiKHOGH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 09:06:07 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F6B569DE2
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 06:06:05 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id b2so38876134eja.6
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 06:06:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GpBlIUZEfOwEP9IS/XhmdW+OK8YEFJPb0qslTTwM8LA=;
        b=G2tw6syaKrZ9i6qFJ4Im4X/BfQmmU7eAsyByDEY51iFL2OrE5tMSycHaS2ddwzYGAg
         FrVCouumxhX8R0i1C93qvK38yQvgxZ5z3UKDt8VAsIVkCKHncsL4igQxN38GSGXuSJa1
         lRzxYFTe7faDdUw+txbWB8O1Y26qthDxGMPaOfNpvVWTxYRm9/4V8qXqt0wmsjPLOdFF
         WAOIHUoQlYkyWS8xHeaASVnbnuh1twsHWOQSBH9IxWWHYcZI9vQHlEJQrhdLHMkKEHfS
         VuQ2wL11iFNP1p7bR4oCnBscxaljN/dZHD5qpv5or90+3Aty/q+oOOdn9ChjmBltY90t
         BRIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GpBlIUZEfOwEP9IS/XhmdW+OK8YEFJPb0qslTTwM8LA=;
        b=E7nlBEyTbzEz5EaJApbq+BwfhB6xU7nqaMGeV3VlSa+OcSIAqj7fd/Aj+pDiz/a8hg
         KxUshx8qrE3ceAyKrNyeBjPpi0FDXN3z6K7flN1JNDSZQp31FnMlslFEaZPYMePHmBh5
         oFs7ZmHhzvO7uMY8zHOkb36IGovYiHxTC9BwEDLTQLIKFM/G5/JpOaM8+vMUOIW/2In+
         Eg103LEKFzNdtcB8qE/4ojen+bMcKzmglGVMffgUSZ41d2Bavsds/qBIySUfOaGuEzne
         J7IM7C6G6xgIlBHfH7CXsVlLoztlobwAzEwK/uu1wwZWqfEdreq8zzMfVMPBbJ7DDqnr
         +EIw==
X-Gm-Message-State: ACrzQf33pqXKwtpf6KTtoaOJYD/t1+C8ZYO5ub8Ts0ke1lb/NBLGpP34
        ZFX0v+V0ufLv4N25MEx3KOvdRLEuTzVL7cPWfXkKVw==
X-Google-Smtp-Source: AMsMyM4C+VzClPjPzgoTJUBtvYBgC5RKL6nA2Tz1uWNQjJ4dPsW+w1fcdtCEvLGnOPENtyLeUvqugoc6YVcvvFmBBcc=
X-Received: by 2002:a17:906:4c4b:b0:7ad:a197:b58e with SMTP id
 d11-20020a1709064c4b00b007ada197b58emr54205327ejw.203.1667916363679; Tue, 08
 Nov 2022 06:06:03 -0800 (PST)
MIME-Version: 1.0
References: <20221103011713.138974-1-liaochang1@huawei.com>
In-Reply-To: <20221103011713.138974-1-liaochang1@huawei.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 8 Nov 2022 15:05:51 +0100
Message-ID: <CACRpkdZY1SBEZKBZvHVk9LK7jvCo0eBxLmJKkFk9UPH_uP=iwQ@mail.gmail.com>
Subject: Re: [PATCH] ARM: module: Reclaim the unwind list of module on kmalloc failed
To:     Liao Chang <liaochang1@huawei.com>
Cc:     linux@armlinux.org.uk, ardb@kernel.org, nico@fluxnic.net,
        rmk+kernel@armlinux.org.uk, chenzhongjin@huawei.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 3, 2022 at 2:20 AM Liao Chang <liaochang1@huawei.com> wrote:

> When unwind table allocation failed, it needs to reclaim the unwind list
> of module to avoid potential NULL pointer exception and memory leakage.
>
> Fixes: b6f21d14f1ac ("ARM: 9204/2: module: Add all unwind tables when load module")
> Signed-off-by: Liao Chang <liaochang1@huawei.com>
> Cc: Chen Zhongjin <chenzhongjin@huawei.com>

Looks good to me:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Please put this into Russells patch tracker.

Yours,
Linus Walleij
