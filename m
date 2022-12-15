Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB61264D5DC
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 05:29:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbiLOE3c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 23:29:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiLOE3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 23:29:24 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CCC631EE3;
        Wed, 14 Dec 2022 20:29:23 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id t18so5887211pfq.13;
        Wed, 14 Dec 2022 20:29:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1r0u0A1WptWkIvm6YdryJeqFLCv2drBlsiURXvnV+Vc=;
        b=li2mdodu7SvA0wkvxfIDkRKtud7njzwwAluJ/mUOoOhPhQ0GSYRY03D/3bUGr+XohN
         7kKEy3rpJLbhgjazL1zknuBcLVBb6P74q9Uq2USt1IZUXv8/rKqa58D8JxUqMcODeiLd
         O51lD7OwUfmxm3y5bbmuSIs3WLoWsfHvcBQHoimxkgqAB/MtECemFcl1efTmmP7zjOo7
         kOunrH73UfNdVAGAH0Daa84MJAoE91SnWMd9W0IkTs6QN2DpN46M/Le4eN0oRclRBZK0
         t/6bWBU0LK6NEy8GB7brI/+xn14txanLWD5Q/SnfGPX5AVwAHkSkW6aQ48axzhcUjAc0
         C3Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1r0u0A1WptWkIvm6YdryJeqFLCv2drBlsiURXvnV+Vc=;
        b=7PwW+PpYa8wn5vhHoAQq4LB1rQFrdRuZ9Lcr2GtQpJZdj+cV0MjsJuCJwxtmsPlOLe
         JylVFxflhfNy8W90A36clLBoCA7pSghgLYEhtCcIPPOe6r0DMOecAIMu7zEY1eYDqdZX
         75K4jYHoLI9ZKR5zkG22ceGL1wjCrwBun3B/NgB9Jed6BW/iDgTvJ6SIbSFeSZmHbNOM
         GbWKwHd38TMkMhO+XxA5jkqmmo0qxzvUIxnnqZDkhLChgeQMN5aTI98B6+ngyoWZ2KoQ
         vnTyUd96X8zjw05cO+JfcWjvTItebtR1WQUmAtIxoQbsQwCiMwRKz+CQPaeXg9AFbkVt
         A0Qw==
X-Gm-Message-State: ANoB5plogwYPMsd0Aoj8HOZl4JHWQmxuWTQFDzk4wJWxICmecUaQB8ko
        NlfB5Nl5I+Q+WzvjhN/DUdc/nQ/aW5NWvJgM
X-Google-Smtp-Source: AA0mqf7c7js48IggK/2tD5t/9qCiy43LZ9AYH2nqjklRVivtcyCwlsI5QJz9202669zWLWzgeRo8yg==
X-Received: by 2002:a62:16d0:0:b0:576:a899:78e2 with SMTP id 199-20020a6216d0000000b00576a89978e2mr6234595pfw.1.1671078562784;
        Wed, 14 Dec 2022 20:29:22 -0800 (PST)
Received: from mail.google.com (125-237-37-88-fibre.sparkbb.co.nz. [125.237.37.88])
        by smtp.gmail.com with ESMTPSA id r3-20020aa79623000000b00575bab45644sm649333pfg.61.2022.12.14.20.29.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Dec 2022 20:29:22 -0800 (PST)
Date:   Thu, 15 Dec 2022 17:29:15 +1300
From:   Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Haowen Bai <baihaowen@meizu.com>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        paulo.miguel.almeida.rodenas@gmail.com
Subject: Re: [PATCH] [next] pcmcia: synclink_cs: replace 1-element array with
 flex-array member
Message-ID: <Y5qim07QaqyvAtRX@mail.google.com>
References: <Y5mMWEtHWKOiPVU+@mail.google.com>
 <202212141124.736E3DE2A8@keescook>
 <Y5otilaHc6HBPCAF@mail.google.com>
 <CAHp75VdHU3g_t8u-hr1C=mttvEq-jWmMuCwaQqXToP-kH3xstQ@mail.gmail.com>
 <202212141347.9AD66DEBC8@keescook>
 <CAHp75VdqUMs1uz8zeyDi6rJKayFt6UMrm0A=-Hp8tQpCUSGujQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VdqUMs1uz8zeyDi6rJKayFt6UMrm0A=-Hp8tQpCUSGujQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 15, 2022 at 12:06:46AM +0200, Andy Shevchenko wrote:
> On Wed, Dec 14, 2022 at 11:49 PM Kees Cook <keescook@chromium.org> wrote:
> > On Wed, Dec 14, 2022 at 10:39:52PM +0200, Andy Shevchenko wrote:
> > > Yes, and Try to make it work with __packed. As I said, the problem is
> > > that the code is relying on something which is architecture dependent
> > > strictly speaking. And hence I disagree with Kees that v2 is okay to
> > > go.
> >
> > I meant that v2 is functionally identical to the existing code.
> 
> Ah, sorry for misunderstanding.
> 

I agree with using __packed attribute to remove the extra padding (and
for the reasons you mentioned before). That would reduce the sizeof(RXBUF)
from 8 to 5 (which is good) but that is still 1 byte "too much".

Piggying back on a suggestion Kees gave before:

-       info->rx_buf_size = sizeof(RXBUF) + info->max_frame_size;
+       info->rx_buf_size = sizeof(RXBUF) - 1 + info->max_frame_size;

That way RXBUF->data will point to the first byte of the frame_size 
(MGSLPC_INFO->max_frame_size) which is what is actually needed.

> > > The full change should be something like
> > >
> > > check_add(sizeof(), max_frame_size)
> > > kcalloc(8, size)
> >
> > Right -- this would fix the existing mistakes in size calculation (and
> > is certainly better).
> 
> Glad to hear that we are on the same page.
> 

That makes sense to me.

thanks!

- Paulo A.
