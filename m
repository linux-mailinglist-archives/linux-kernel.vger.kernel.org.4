Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25BE864E2DC
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 22:14:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbiLOVNl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 16:13:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbiLOVNd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 16:13:33 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DF921705C;
        Thu, 15 Dec 2022 13:13:33 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id w4-20020a17090ac98400b002186f5d7a4cso4070591pjt.0;
        Thu, 15 Dec 2022 13:13:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1GRyBXwIl/yIj6DjGjuLYR4NV25MWL4dlrs9/synEW4=;
        b=L9mroEBZVJmwpUbs0cjhBI8GcxztTfJESPxIow5xqm7kwOthC3Z9UVqDagpD4SPV8H
         2pdAMGH0gxx97RwCm71WG6cWJZc2xdheEBF5fppqjXJvyfOlXAVBa82TNaO9ECfr0lTU
         tWnIY9O/VBIjNciO8JRsCeNPsT25c6fKtFy4u8X5X5NyDR87bZbVX3gPyl5gGZ3xDuaf
         VJjKH3MwQeSNyFcBEJb73Dc73YHMV8+qS+hqjxZ9xCxfImuXxpXjIgG+U4h6EncGqG4/
         HpvOTKJ0LE3K2iY2ra/CYQY8geLOPetbniTT7ek3Otm/MfWx8OUYhn77Fz6NF5owPZ11
         pYQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1GRyBXwIl/yIj6DjGjuLYR4NV25MWL4dlrs9/synEW4=;
        b=0455fNkVmiiUO6oANfKEC+RTITd9gkf0NyTzckrcAQJgvXj1zgpZpfB00JHw/kzCS8
         g89kaW4zY5nF6EAikWeX3EFO4WhbJCVFz+SaST5+X63aSnWG1/5uvCLa6N254H+Gwd8j
         vPVIavzkS2B4buRCrb+8A7dU5Z0kJbJu4CRPnbhb6OMntdQJSrys5wuZRQ+9DDGJDGnO
         3KmfxyR/CFpzb6bNVyashW2KByra8qa4ZoUGXNbbfcGQ2xbXsapoiXDhN8R8v9pbtkJJ
         8RiFazx2M3G3n8x9fMjTGw7DY+kcZmPBXCV+xIIJ3b3/Xui1DySRIrSKYYcmwI2VjQx3
         Z3KA==
X-Gm-Message-State: ANoB5plXHXRHx9reJaWUEg1LSuO5lOJZwDBMbW6m5VHLOhCO5rvvG2A8
        z5Q/mfkXaOit+0B/+2nYHgk=
X-Google-Smtp-Source: AA0mqf7CRRvqdGzgLS7omdB/ZLh8/ndysbNNv7QZyL65PuY8F+NTrIknSlXs9iqnYZzsWIcyWl/rtA==
X-Received: by 2002:a17:902:dacb:b0:189:e687:b373 with SMTP id q11-20020a170902dacb00b00189e687b373mr8741535plx.0.1671138812710;
        Thu, 15 Dec 2022 13:13:32 -0800 (PST)
Received: from mail.google.com ([103.229.249.253])
        by smtp.gmail.com with ESMTPSA id y2-20020a17090264c200b00190efb4071dsm81293pli.160.2022.12.15.13.13.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Dec 2022 13:13:32 -0800 (PST)
Date:   Fri, 16 Dec 2022 10:13:25 +1300
From:   Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Haowen Bai <baihaowen@meizu.com>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] [next] pcmcia: synclink_cs: replace 1-element array with
 flex-array member
Message-ID: <Y5uN9Rr3v1uWH765@mail.google.com>
References: <Y5mMWEtHWKOiPVU+@mail.google.com>
 <202212141124.736E3DE2A8@keescook>
 <Y5otilaHc6HBPCAF@mail.google.com>
 <CAHp75VdHU3g_t8u-hr1C=mttvEq-jWmMuCwaQqXToP-kH3xstQ@mail.gmail.com>
 <202212141347.9AD66DEBC8@keescook>
 <CAHp75VdqUMs1uz8zeyDi6rJKayFt6UMrm0A=-Hp8tQpCUSGujQ@mail.gmail.com>
 <Y5qim07QaqyvAtRX@mail.google.com>
 <CAHp75VcSnRPfmk9gAgz+hb7VYtL5buzDi_1e53u8b8+PrtxAvQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VcSnRPfmk9gAgz+hb7VYtL5buzDi_1e53u8b8+PrtxAvQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 15, 2022 at 10:57:57AM +0200, Andy Shevchenko wrote:
> On Thu, Dec 15, 2022 at 6:29 AM Paulo Miguel Almeida
> <paulo.miguel.almeida.rodenas@gmail.com> wrote:
> > On Thu, Dec 15, 2022 at 12:06:46AM +0200, Andy Shevchenko wrote:
> > > On Wed, Dec 14, 2022 at 11:49 PM Kees Cook <keescook@chromium.org> wrote:
> > > > On Wed, Dec 14, 2022 at 10:39:52PM +0200, Andy Shevchenko wrote:
> 
> ...
> 
> > > > > Yes, and Try to make it work with __packed. As I said, the problem is
> > > > > that the code is relying on something which is architecture dependent
> > > > > strictly speaking. And hence I disagree with Kees that v2 is okay to
> > > > > go.
> > > >
> > > > I meant that v2 is functionally identical to the existing code.
> > >
> > > Ah, sorry for misunderstanding.
> >
> > I agree with using __packed attribute to remove the extra padding (and
> > for the reasons you mentioned before). That would reduce the sizeof(RXBUF)
> > from 8 to 5 (which is good) but that is still 1 byte "too much".
> 
> What I meant with the above is that the code has to work properly with
> or without __packed. It's just to show you that this code has flaws if
> it relies on the padding.
> 

Right - that would work just as well. I will work on v3 with the
suggestions given by you (sizing calculation amendments using overflow.h
macros) and kees (adding the notes regarding the padding) then.

- Paulo A.

