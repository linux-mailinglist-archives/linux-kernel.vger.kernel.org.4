Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDB6367FA95
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 20:55:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234529AbjA1Tz0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 14:55:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234507AbjA1TzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 14:55:24 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85D47234D6
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 11:55:22 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id l1so3753321qkg.11
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 11:55:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qbp9QaNDZWJkPD4EX8FVMT1Tf9hwMQACYdEjENlwtsU=;
        b=aClggjBpSo0dFaEaJIufElfuIIXiVg48b4HEDmAU9Il3GXJe+8V6hwT1wUFfqXfdi+
         QJghwDrMoX3LSPAixk1mbpVtS1vBSfdUDMwOU0T+WbZwOyiUjg4d7VI38XTuPhEzouhS
         GuTXr/D3Yp57OOflAFovkJwzpHbWPs5lId27yXFOl+PRX5IrlxURaHI8w3JYfBEUdC7F
         gRCdW2D4XrTfvLFJi+nowL6UO8ALsK8FRylc13hULqLYwEeggUJTYWDZo+6W/3qunTv1
         oy83Jwo/QRnEOAfDKzFdKabhSVlk/tusu0JNQMYpLmMrk71juj0ZX0gFOP3vhrTCwzUe
         zP3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qbp9QaNDZWJkPD4EX8FVMT1Tf9hwMQACYdEjENlwtsU=;
        b=aa2mqGhszkYk8yybB8T7qwfGXiz6eGIrwvK0XCHVC4af8IPr6g6YqzVxX/SfMycAG3
         xvlv/ZLP08quXJ8DoOPRZ6lE7uhTAqyp/H/dfWHFTHdQt8nuEPiGcIE0degh1SxGe+Br
         DeugnQ3CRVmymQaG73OVw+R7c5YMzk4qZA2hrFajq8v0ZGW8Xl0Ku+YvDPl4KC9WQg8v
         nJu47StyNhK6kszKA59OSIAgJ9YYy/cJlflgwaZ7rHC5EMTCnmAsGQjhsvhdKGOZvBLa
         JcrbIszXU3Al3xRQSaqqLkOKNGULCuc+WMzEf4nqt/Kl5Ba5XjmaMb61Fuu+K4gwhxii
         C8qQ==
X-Gm-Message-State: AFqh2kqPCVxyKVaj/ZrRzh0h85KNWIFdI+W07bQKv61VsI5Gqa4HXhe8
        9c/k5SkNpl7WkGDexizBrnarLoLrB+rh/5kagyY=
X-Google-Smtp-Source: AMrXdXvJYwjhNwl80QknzB3ZE1bCEaEDhrhA/Qx3wY0ugJWoV/QT87p/6OXwoI6XIXEVhqsU5luZvzFSw2T9CRYwt8Q=
X-Received: by 2002:a05:620a:1214:b0:706:9677:5fdd with SMTP id
 u20-20020a05620a121400b0070696775fddmr3008606qkj.283.1674935721101; Sat, 28
 Jan 2023 11:55:21 -0800 (PST)
MIME-Version: 1.0
References: <20230127155135.27153-1-andriy.shevchenko@linux.intel.com> <a903947619f94dfa88d3dd147b7a5e95@AcuMS.aculab.com>
In-Reply-To: <a903947619f94dfa88d3dd147b7a5e95@AcuMS.aculab.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 28 Jan 2023 21:54:44 +0200
Message-ID: <CAHp75VcZgkuOA3pSrg7cN36EAB4Y0jV2xFNfj-sGp_C17J2yAQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] lib/string: Use strchr() in strpbrk()
To:     David Laight <David.Laight@aculab.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andy@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>
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

On Sat, Jan 28, 2023 at 4:51 PM David Laight <David.Laight@aculab.com> wrote:
>
> From: Andy Shevchenko
> > Sent: 27 January 2023 15:52
> >
> > Use strchr() instead of open coding it as it's done elsewhere in
> > the same file. Either we will have similar to what it was or possibly
> > better performance in case architecture implements its own strchr().
>
> Except that you get a whole load of calls to strchr() for (typically)
> very few characters.
> So the cost of the calls dominates, anything that tries to speed up
> strchr() for long strings will also slow things down.

Hmm... I haven't seen the calls, I assume gcc simply inlined a copy of that.

...

> Although I very much doubt strpbrk() is used anywhere where
> performance matters.

strsep()/strspn() are the users.

-- 
With Best Regards,
Andy Shevchenko
