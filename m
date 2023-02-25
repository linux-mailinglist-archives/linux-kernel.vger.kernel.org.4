Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B19646A2A64
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 16:07:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbjBYPHC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 10:07:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjBYPHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 10:07:01 -0500
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E91A410246
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 07:06:59 -0800 (PST)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-536bbef1c5eso58394387b3.9
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 07:06:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8ERi5FLnF/YWrOX8AIYlxpKdMnYcL8B+SdTpGo/A/Ek=;
        b=l70Z9nIDTwefKvKKBpkRSWs9O2BYJvOva7iR2rqnc6rCsljstIyAVjnMdgTZGiiv7C
         MiYvZn0cBZtNqcTUNuUBRokMLOJVEOFIkTsMEGUJrmgEgAatZ7nDDG8EVfDRuoX2iPCx
         Pu8lw1+7vQMwPmL6zj9p1Cao7L2dEeyJPcMQU+2ac9ZqDmxum0zCeXtXlcfUjQPY97qA
         upBMTeZdw0mnXNz4yVjAxJqz8Qh28vMYu7JUizus3WQZ+UTVHvJ1vxPn2MpYJvj+yCsa
         gKzaAvc9YP02tQnThoqvgABSJf6SMtAy4+r9NPJ7yp/Qo5ZBl9Kp55W8mF9wZ+9sI9GO
         +Ykw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8ERi5FLnF/YWrOX8AIYlxpKdMnYcL8B+SdTpGo/A/Ek=;
        b=5ePDyq8p87eRGXVQU1Fv8wevs8VVXc/zuJJUpBibs59kgNAkDRTo3XawoiYjFfwhvz
         ATzfUJ3ByNmVp9mcl9BZkwpSnronXlG3CIjO/TWEoHO5nsQqpI0d1zCviQuMRFv1ae+Y
         UB4FDwEIT7TWgyQnVbX+Q/nLufLUNBdFWSicq8CVTTr+61Un6PzLmLoyAmSLIxzQ0wRG
         YWuLHlw+puN4DqGFwZ18GTdnGt2Ua8rASBnzVKw5kZEnoEFUePr0YhzHui6zZyzfiXqO
         LryEGzZn45NbxHlbk9ThftPwLVSUUDg1Sno1IbX3fJVJE6D7W+ZsX0H5WJROVUOGOZIt
         HWJA==
X-Gm-Message-State: AO0yUKWZUkZaKc5jtZYCL0oRL03cg0LkusL6xXf8gxXLju7uKmYkp/gG
        TI4SC6UFZ8DekX09zG+3TeJnLeVYHdo94niEUmuEqw==
X-Google-Smtp-Source: AK7set/8pba/GaedacTEZLYpVAOJK0SVJoN9f8UbYajPU7zUClVmBVofERzBlyt10EkI/7Prx30iO/+nj9ShUfp2h6U=
X-Received: by 2002:a25:790d:0:b0:9f1:6c48:f95f with SMTP id
 u13-20020a25790d000000b009f16c48f95fmr4920394ybc.5.1677337619087; Sat, 25 Feb
 2023 07:06:59 -0800 (PST)
MIME-Version: 1.0
References: <CACRpkdamxDX6EBVjKX5=D3rkHp17f5pwGdBVhzFU90-0MHY6dQ@mail.gmail.com>
In-Reply-To: <CACRpkdamxDX6EBVjKX5=D3rkHp17f5pwGdBVhzFU90-0MHY6dQ@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 25 Feb 2023 16:06:48 +0100
Message-ID: <CACRpkdb5dWOqRZpjcmx0M4H_REcZ+K6zY0tPz0K-hH9o_Ybd+g@mail.gmail.com>
Subject: Re: Regression in probing some AMBA devices possibly devlink related
To:     Saravana Kannan <saravanak@google.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 25, 2023 at 3:28 PM Linus Walleij <linus.walleij@linaro.org> wrote:

> I have a boot regression for Ux500 on mainline, but bisecting mainline
> isn't quite working for misc reasons :/

I however managed to revert Gregs entire branch for driver core
with:

git revert -m 1 a93e884edf61

And this makes the regression go away, so I'm pretty sure it has
something to do with the device link patches.

Yours,
Linus Walleij
