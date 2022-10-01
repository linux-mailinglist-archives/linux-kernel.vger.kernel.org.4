Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E06225F1A50
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 08:28:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbiJAG2Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Oct 2022 02:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiJAG2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Oct 2022 02:28:13 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15B5213DD8B;
        Fri, 30 Sep 2022 23:28:13 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id 10so2045506pli.0;
        Fri, 30 Sep 2022 23:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=k2HY/9fTWjD6yOUfkXa90L9vnBK9YBSc4ZyQwrFqunU=;
        b=N6aMnXgZPio+JDqAgd7OoztzGDn5YRVaEHhpQVxjh2Qa4mTgDGjA8NC/4mvctST5xW
         smeisubUybmDrk14fWCj1EDsnVZfbZOkKA/1Pxys/GqDmnohuonql4qYjXYLw4pS2S05
         xTWqIVq4bRe9GvSmSM4cZnAb+lSznS3slJhvL2IUtvQjS9O9vn5pjv/z1pwHjDTKp7/U
         KM30Kl9ak5T5/v7C3sxP8aRZubIRCw7t8bd1yyV3/GwX8TM7lne/ME3ezDpqVcDCnoQH
         6i9cLiUsaOm1yntVBuiJgLinn6hZtIb3wOcryJwC76FvFEEcsi0Pd/31Z5GddirzhEaP
         yhrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=k2HY/9fTWjD6yOUfkXa90L9vnBK9YBSc4ZyQwrFqunU=;
        b=kVwYPZ7ocCxleGHVacUf4PBeZrDgw9JyESjYXJ7rTpYjNW5RV7Rv5DzNeLkv7zrjpX
         RwxwQpxhwPv0qy7wMBCSMgpx/S6nr5f12EP/OjTkabIueBbnC67FFm+F19gU/RsI41io
         ZDzHalG3flXK0n2IIbk0iPY79vuDbSQuiSIFdFElEnzdMfxaDLeWuQom0fcoVIgkT4Qf
         CWNo9Fceql8oVtbhm0BkaOweryTHMZ7DvjQrZkgb8Wz1PCbMrHAriX6QOHM4uvD1aQlC
         yrOG4tF4UAa0lk5LyPxipVYwzzqRi88WKjxfHfxEUGD4COgJ3sIsL77PsM74G7Du6Ly0
         2WlA==
X-Gm-Message-State: ACrzQf1ppa/FKFgLdBZTThGCo3egIhNYaA+wPo0AferMK0cMqO4DmUm3
        9KynW/X3ZloRRDvgxASU78c=
X-Google-Smtp-Source: AMsMyM5hUfLusi1pDlwlsfEM1qZvQ6LzZmDCgYBkMt8EErnV2H9a+OTQit3hERCFi0h8OWG9Oks4Vw==
X-Received: by 2002:a17:902:8217:b0:176:e41d:b804 with SMTP id x23-20020a170902821700b00176e41db804mr12308819pln.111.1664605692437;
        Fri, 30 Sep 2022 23:28:12 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:63e7:415:943b:4707])
        by smtp.gmail.com with ESMTPSA id y8-20020a62ce08000000b0055817a49b28sm2946161pfg.67.2022.09.30.23.28.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 23:28:11 -0700 (PDT)
Date:   Fri, 30 Sep 2022 23:28:08 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-input <linux-input@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ondrej Jirman <x@xff.cz>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        linux-sunxi@lists.linux.dev
Subject: Re: [PATCH v4 2/4] Input: pinephone-keyboard - Add PinePhone
 keyboard driver
Message-ID: <Yzfd+GC7mH3P2Y0Y@google.com>
References: <20220618165747.55709-1-samuel@sholland.org>
 <20220618165747.55709-3-samuel@sholland.org>
 <CAHp75VcXNTxusT5N_8JvYWMhUyY_sAUzTcT3h0hz2bAawv6ThQ@mail.gmail.com>
 <2e6499b8-d8f4-b63a-689b-1e93aca7c210@sholland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2e6499b8-d8f4-b63a-689b-1e93aca7c210@sholland.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 20, 2022 at 11:12:46PM -0500, Samuel Holland wrote:
> On 6/19/22 6:43 AM, Andy Shevchenko wrote:
> > On Sat, Jun 18, 2022 at 7:10 PM Samuel Holland <samuel@sholland.org> wrote:
> >>
> >> The official Pine64 PinePhone keyboard case contains a matrix keypad and
> >> a MCU which runs a libre firmware. Add support for its I2C interface.
> > 
> > ...
> > 
> >> +#include <linux/crc8.h>
> >> +#include <linux/i2c.h>
> >> +#include <linux/input/matrix_keypad.h>
> >> +#include <linux/interrupt.h>
> >> +#include <linux/module.h>
> >> +#include <linux/regulator/consumer.h>
> > 
> > Missed
> > types.h
> > 
> > ...
> > 
> >> +#define PPKB_ROWS                      6
> >> +#define PPKB_COLS                      12
> > 
> > ...
> > 
> >> +       for (col = 0; col < PPKB_COLS; ++col) {
> >> +               u8 old = old_buf[1 + col];
> >> +               u8 new = new_buf[1 + col];
> >> +               u8 changed = old ^ new;
> >> +
> >> +               if (!changed)
> >> +                       continue;
> >> +
> >> +               for (row = 0; row < PPKB_ROWS; ++row) {
> >> +                       u8 mask = BIT(row);
> >> +                       u8 value = new & mask;
> >> +                       unsigned short code;
> >> +                       bool fn_state;
> >> +
> >> +                       if (!(changed & mask))
> >> +                               continue;
> >> +
> >> +                       /*
> >> +                        * Save off the FN key state when the key was pressed,
> >> +                        * and use that to determine the code during a release.
> >> +                        */
> >> +                       fn_state = value ? ppkb->fn_pressed : ppkb->fn_state[col] & mask;
> >> +                       if (fn_state)
> >> +                               ppkb->fn_state[col] ^= mask;
> > 
> > Can't it be converted to use bitmap APIs?
> 
> This is a 2D matrix, with one byte per column, and one bit per row. There are
> only 6 rows, so two bits per byte are unused. Converting this to the bitmap API
> would unnecessarily complicate things.

We could have a constant bitmap masking the unused bits so they are
always skipped.

Anyway, I made a few edits and applied, we can continue improving the
driver in an iterative manner.

Thanks.

-- 
Dmitry
