Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04AAE69848E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 20:31:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbjBOTbO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 14:31:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjBOTbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 14:31:12 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0195F3C2AC
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 11:31:11 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id fi26so24963411edb.7
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 11:31:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RED9+vAJdW3sKqtHeyKyIn11vo3x09LmIinPSfGfkd0=;
        b=MoQe7iVa3MT5PDdVl/QDU0kTTLca4GFekIkTiTQ02LvSSx5UnCUFroMNyhzDT2vzH/
         uw2jdnoctQ1jc2aut0ty7G6s2izwMb9t/kgqyDBge39MaCtw9m6s1fwN6quFCL6DkM8s
         0jF5t3yNSunFrfCUAHvHrDmjKDiRsSSvdcJN8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RED9+vAJdW3sKqtHeyKyIn11vo3x09LmIinPSfGfkd0=;
        b=P63q2qHft8zeHTQQL39I/5odi82ZJrdnEF3GOJKmZjgZIUdGonCxCEXniqbEGcN/PK
         wRvVf36jG7DSqppGCrI3TtVJF3cdNcW3pLkUYrp96Agufr57Or48BexpPpwv1wWGHuf9
         wY4i4d3UMw4rrdq5AREiEMTAC74r7BsL4GQJ+/poZKuR+085KPw0wo++grEVGIVFqFiT
         Zizq1GFfpKGA65xeKcwj1gzxvEYQ9Q8VMm/3m2ryosQLdKkwt7UG1jYrq92UlsvPZIig
         LNvRR7/sXniY9mWBThJ4wxt60u8x1vj9NLQFkQfGpOY9D8G3Sw2Cc2HvNZrGMKcV3LGY
         auVg==
X-Gm-Message-State: AO0yUKWFPSje+EhOqiMoypVs77KseqZMzf08Ot9J+TyoP60nm24/G+uD
        pygHBN3LBKF5G/R1ewPKKKv887EPJxzUzg40mLA=
X-Google-Smtp-Source: AK7set/c45NWlLmsULWgeQl/+K/7Aw8oEfsTdHFpjM47ynXl65MEJf9fEIQkXdLPl3PAsqPiP3zjDg==
X-Received: by 2002:a17:906:7312:b0:8b1:3422:ddb6 with SMTP id di18-20020a170906731200b008b13422ddb6mr4445517ejc.69.1676489468990;
        Wed, 15 Feb 2023 11:31:08 -0800 (PST)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id jt26-20020a170906dfda00b008b14ca97d4esm503377ejc.10.2023.02.15.11.31.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Feb 2023 11:31:08 -0800 (PST)
Received: by mail-ed1-f53.google.com with SMTP id t16so2126793edd.10
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 11:31:07 -0800 (PST)
X-Received: by 2002:a17:907:cc12:b0:88f:a9ec:dfd7 with SMTP id
 uo18-20020a170907cc1200b0088fa9ecdfd7mr1591050ejc.0.1676489467608; Wed, 15
 Feb 2023 11:31:07 -0800 (PST)
MIME-Version: 1.0
References: <20230215100008.2565237-1-ardb@kernel.org> <534469b750e1847e1645f9ae5ed19dcc80b82be6.camel@physik.fu-berlin.de>
In-Reply-To: <534469b750e1847e1645f9ae5ed19dcc80b82be6.camel@physik.fu-berlin.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 15 Feb 2023 11:30:50 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjEmZ19T4XpVb0_Hacm53xJG_w5ygcuorwC0xBoT-myUA@mail.gmail.com>
Message-ID: <CAHk-=wjEmZ19T4XpVb0_Hacm53xJG_w5ygcuorwC0xBoT-myUA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/5] Retire IA64/Itanium support
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Arnd Bergmann <arnd@arndb.de>, Tony Luck <tony.luck@intel.com>,
        Jessica Clarke <jrtc27@jrtc27.com>,
        Matthew Wilcox <willy@infradead.org>,
        Marc Zyngier <maz@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>, linux-ia64@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 15, 2023 at 2:17 AM John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:
>
> It's not that I don't care. I just haven't been able to bisect the bug .yet

I'm not a fan of ia64 as an architecture, but it's a bit sad to remove
it entirely. It's not like it's been a huge maintenance burden in
general.

That said, if it doesn't work, and nobody has the time and/or
inclination to figure out why, I don't really see any alternative.

             Linus
