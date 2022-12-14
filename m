Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BAF264D21E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 23:07:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbiLNWH2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 17:07:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbiLNWHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 17:07:25 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F18A61EEF5;
        Wed, 14 Dec 2022 14:07:23 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id x11so3665239qtv.13;
        Wed, 14 Dec 2022 14:07:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5/39cbinCm2DlY6z44q1qFPXCL75QR7vAT6pW5+yC8Y=;
        b=iLYrwhVnnNIL/F6TsTsvS9Shdni52MY2EjTZE2RucUeMYmjxAiipoGvckF8Hv8cXzO
         XQrblOKgcOqF5DxvUJlpsPLHeVhF9+sBjCUbW8hZ3n2GaSsLWAuV773rMukDU0z+QUGY
         5Pow4U6J+dk0BU556isbAaQG0ZhxN1F6hX9LFuoXlg5QZqGtcscAsJeTAulmfTRBLfKL
         jINWBk4+2Dz7FIHt65DQbvfgVdDpCdqalUqyN+ei4MUn0URzwnng8dwKbqSrbje7w6NJ
         mdl+g1JU8rKZno5jIRa9tUisz4UnaN/ZHUV19wxGx2lP9wUrfBMexoTiX6nXjp33vr2O
         48MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5/39cbinCm2DlY6z44q1qFPXCL75QR7vAT6pW5+yC8Y=;
        b=jCCfFR+8ZGVwaSm/ugSObWxlxXYEZUUi2JQJZ+ZOKHt+mnnH5BMHypj3NXMcil+028
         YODR3Zm7wxsUYi64k3AjtX5OSdcQ3d9K/jP3TFXQBhf+wS3kjZ2mJyfF3wMC7Vto48+Q
         bKECP9U2EuhGY5VKxTPJEBCIQqOqnZvYChAoeH1LVZDPpKYGG8IlJJCzK/gwJgzV7BU/
         oaBFDH2euy4LpLb8tv3KmdgAi5bgV0jMHceLXj0zgk1jn+/fyV5y2EnjelNcUpW7J/9B
         QFqv3xbOA5ePI3ZAxK/OrJVwZVdi1dd9lRg08unlSoeA4tmf4ZwzHfMxtZ2eoCjOgH4+
         YWPA==
X-Gm-Message-State: ANoB5pm6eTb2t1d58SKiiDJYieVLSEZw0MZ+jHSJV/YtdXG8BEe1GzQ2
        UEoO+lt9byHTL55lzyRQiiiPCeZ8s5Ff+UW+lCQ=
X-Google-Smtp-Source: AA0mqf6mUwKlSDOlkhQHSbAqiZFQHKjcVjQaDVm2zvGjx0vP0jSbepa69mG+0GZTmQab4bXnHCqn1uaWHvBy7nQpFE4=
X-Received: by 2002:ac8:730c:0:b0:3a8:175b:a966 with SMTP id
 x12-20020ac8730c000000b003a8175ba966mr854132qto.384.1671055643046; Wed, 14
 Dec 2022 14:07:23 -0800 (PST)
MIME-Version: 1.0
References: <Y5mMWEtHWKOiPVU+@mail.google.com> <202212141124.736E3DE2A8@keescook>
 <Y5otilaHc6HBPCAF@mail.google.com> <CAHp75VdHU3g_t8u-hr1C=mttvEq-jWmMuCwaQqXToP-kH3xstQ@mail.gmail.com>
 <202212141347.9AD66DEBC8@keescook>
In-Reply-To: <202212141347.9AD66DEBC8@keescook>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 15 Dec 2022 00:06:46 +0200
Message-ID: <CAHp75VdqUMs1uz8zeyDi6rJKayFt6UMrm0A=-Hp8tQpCUSGujQ@mail.gmail.com>
Subject: Re: [PATCH] [next] pcmcia: synclink_cs: replace 1-element array with
 flex-array member
To:     Kees Cook <keescook@chromium.org>
Cc:     Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
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

On Wed, Dec 14, 2022 at 11:49 PM Kees Cook <keescook@chromium.org> wrote:
> On Wed, Dec 14, 2022 at 10:39:52PM +0200, Andy Shevchenko wrote:
> > Yes, and Try to make it work with __packed. As I said, the problem is
> > that the code is relying on something which is architecture dependent
> > strictly speaking. And hence I disagree with Kees that v2 is okay to
> > go.
>
> I meant that v2 is functionally identical to the existing code.

Ah, sorry for misunderstanding.

> > The full change should be something like
> >
> > check_add(sizeof(), max_frame_size)
> > kcalloc(8, size)
>
> Right -- this would fix the existing mistakes in size calculation (and
> is certainly better).

Glad to hear that we are on the same page.

-- 
With Best Regards,
Andy Shevchenko
