Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B64D664D1F5
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 22:49:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbiLNVtG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 16:49:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiLNVtD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 16:49:03 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6832440460
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 13:49:02 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id v13-20020a17090a6b0d00b00219c3be9830so649715pjj.4
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 13:49:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+31TVcZbQVfkTbbiw5O9TBq3yKVpcplDaH8+a0gR/CM=;
        b=Efm0dbIKL/j9IJ0lYIGfx5YCAi57xWuL62QscFdjVcC+VEa+TDKuePOyXXBMb0phGV
         6HBMc7hy1r0pyD+pkeyJ52USB7IiiKuUECs50RyxqZnlJK/dedgdiCWrrTssYzhesZyE
         f5OKQ/kslON/oYUWCJ++K2F6LWKDOY4GlAJeI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+31TVcZbQVfkTbbiw5O9TBq3yKVpcplDaH8+a0gR/CM=;
        b=gAWTMFHK4MxwwqpKvAAJ/VutMCU4Fg/7V+XLxnNs76wKJcK9Xxoh7YOZPTTivcUJWO
         5SNbUMxRMdRQ/PPmVWxoPkWQxC9ld2qhBuXDRA+sd7y3OxWJSg1u8BpLTE7M72YVL8md
         nZMG8AQf6zvmEFE6nqc/I2dZ5YM1V517P9+fvVkJcE6XTT3rOLjr1rJ6gHthzke06GxS
         /R/W4BxAUXohEgvu0L8e52MZIu29SEwl6shFrR+ojX/eIMs9YbahYRHKG+4OzfKZOmKE
         KH18vn9pJef+OocVFUldGJP23Bynce+sBMLSMaX9xwoWPCueApYcb/+FdDOUmMtLD7MI
         piVg==
X-Gm-Message-State: ANoB5pnDuwZ3lhRNbmr+NV0mpmBK8SAIyW4VjjQrHdgIAjDvFL+mShoJ
        za7TUgsjzn84f1hH6rflzLKNTQ==
X-Google-Smtp-Source: AA0mqf4CevhzWpnsEH+YwSnhMAcIQAMxfeL7BLkWOMsUAnIgZZi+JoiUyR/RD9XAXkYybl5sC53aqw==
X-Received: by 2002:a17:903:2ca:b0:189:8329:dba8 with SMTP id s10-20020a17090302ca00b001898329dba8mr32167358plk.39.1671054541957;
        Wed, 14 Dec 2022 13:49:01 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u18-20020a170903125200b001897916be2bsm2290041plh.268.2022.12.14.13.49.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Dec 2022 13:49:01 -0800 (PST)
Date:   Wed, 14 Dec 2022 13:49:00 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Haowen Bai <baihaowen@meizu.com>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] [next] pcmcia: synclink_cs: replace 1-element array with
 flex-array member
Message-ID: <202212141347.9AD66DEBC8@keescook>
References: <Y5mMWEtHWKOiPVU+@mail.google.com>
 <202212141124.736E3DE2A8@keescook>
 <Y5otilaHc6HBPCAF@mail.google.com>
 <CAHp75VdHU3g_t8u-hr1C=mttvEq-jWmMuCwaQqXToP-kH3xstQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VdHU3g_t8u-hr1C=mttvEq-jWmMuCwaQqXToP-kH3xstQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 14, 2022 at 10:39:52PM +0200, Andy Shevchenko wrote:
> Yes, and Try to make it work with __packed. As I said, the problem is
> that the code is relying on something which is architecture dependent
> strictly speaking. And hence I disagree with Kees that v2 is okay to
> go.

I meant that v2 is functionally identical to the existing code.

> The full change should be something like
> 
> check_add(sizeof(), max_frame_size)
> kcalloc(8, size)

Right -- this would fix the existing mistakes in size calculation (and
is certainly better).

-- 
Kees Cook
