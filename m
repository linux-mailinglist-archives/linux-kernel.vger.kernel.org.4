Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25039730654
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 19:51:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232350AbjFNRvF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 13:51:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231902AbjFNRvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 13:51:03 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0A761FCC
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 10:51:02 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1b505665e2fso5421035ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 10:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686765062; x=1689357062;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3/I2do6Z6gZ6unzst7lh9npAw6MAC0D/vuLuo+dzEqw=;
        b=YwjB5BetF8xrADn+8eQ78U269QBvqwes0a2nzGglXjB7TgByuYSfqmhoY5xue/z5X0
         tq2zCglxd/tYRtEPs60mzNYeYgzV7Iih0BOYeGVwlACA9Yplu8v4JvT7jIH+daAXVTjE
         E69ZAWehzHNQK99sHoxZ/ql5D7GR+zgbphIkY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686765062; x=1689357062;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3/I2do6Z6gZ6unzst7lh9npAw6MAC0D/vuLuo+dzEqw=;
        b=BgrZllHs0oqxaGNCZvYRQ3jfAVVHjqUffMuJYp/sVDMytdvSy0PL+mRkaM7e1dajje
         y+PqXAKXR8zFmF6bNODHA/b4rUByR2QIoXqWLv+OW9Vq9ZLpBJ55RRLbEj7YYSs4Sg7r
         TwuDKDpj0SqB+U3YK6NbqehKRsdI4Qvdqc+Wv/Zt+OxvYWuUJQjullAuL64dLeMwOA2C
         l6y2UvO99p8HKCUv6zOmDBdBUFCgrj5fPmHjyozod4xStf0xtkpCImFR5JFdQVKvQoP1
         YuZCgAUdj32UTGXORmlMaqeGb4vX2YD0gK7/YbPsUD+jvHwdiNi8J3Fu8o49u6LVNWp4
         ckDg==
X-Gm-Message-State: AC+VfDzO6dLz0YIYZJauYCWB/9Bif02VtNJ05stFQHVQuO5WcnUFxJ4O
        ucIH791EeAOq2BMy8VcZb8mm8vtTW7B+JQzsWBI=
X-Google-Smtp-Source: ACHHUZ6rXYzID35U6HKju3ksoay8FG7T++6LuQV7o7eKQMSqHhQGS8UDgXvzoSYUGwuJ4CrBSSvnAQ==
X-Received: by 2002:a17:902:da91:b0:1b3:fe0e:57ef with SMTP id j17-20020a170902da9100b001b3fe0e57efmr3428119plx.23.1686765062171;
        Wed, 14 Jun 2023 10:51:02 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id c1-20020a170902724100b001ab2b4105ddsm7072047pll.60.2023.06.14.10.51.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 10:51:01 -0700 (PDT)
Date:   Wed, 14 Jun 2023 10:51:01 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-hardening@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Albert Briscoe <albertsbriscoe@gmail.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>
Subject: Re: [PATCH] usb: gadget: function: printer: Replace strlcpy with
 strscpy
Message-ID: <202306141049.BF86FA8F1F@keescook>
References: <20230613004341.3540325-1-azeemshaikh38@gmail.com>
 <202306131229.B5F2D9F@keescook>
 <CADmuW3VEiseKt2UM9o9jzzR8nEawh1jxANyxdZcxk89U65pXEQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADmuW3VEiseKt2UM9o9jzzR8nEawh1jxANyxdZcxk89U65pXEQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 14, 2023 at 10:12:14AM -0400, Azeem Shaikh wrote:
> On Tue, Jun 13, 2023 at 3:30 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > On Tue, Jun 13, 2023 at 12:43:41AM +0000, Azeem Shaikh wrote:
> [...]
> > > -     result = strlcpy(page, opts->pnp_string, PAGE_SIZE);
> > > -     if (result >= PAGE_SIZE) {
> > > +     result = strscpy(page, opts->pnp_string, PAGE_SIZE);
> > > +     if (result == -E2BIG) {
> >
> > I think "< 1" might be a better test here.
> 
> Curious, why "< 1" instead of "< 0"?
> 
> > >               result = PAGE_SIZE;
> > >       } else if (page[result - 1] != '\n' && result + 1 < PAGE_SIZE) {

It's for this case above where "result" may be used in an array index,
and if it's 0 or less, there will be a negative array index (due to the "-
1"). So, here, it needs to be "< 1" instead of the more traditional "< 0".

-- 
Kees Cook
