Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 963447206D7
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 18:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236386AbjFBQHn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 12:07:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236543AbjFBQHi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 12:07:38 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BFAA1B7
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 09:07:33 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-974638ed5c5so138267066b.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 09:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1685722051; x=1688314051;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pSyIWuON41xIpPsAfkdJjA0fkmYqrGMTTzJNJtvl1ho=;
        b=Vfh0HBQP9WOsPk/09//1NgyAMTU3HloZI1+GuAjqp7Fz2sCHJT3TJDGpnjaenHHbm0
         UUZ8MzC5kEuRRtA9XkhfAaN3TrUXjYS6ZQtW2KsYAjAW4haZVnfVVP74giz+deURrLFv
         3AoYjMY0jdGEkHl0URpi1IWo8dzeCJVXNWmhE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685722051; x=1688314051;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pSyIWuON41xIpPsAfkdJjA0fkmYqrGMTTzJNJtvl1ho=;
        b=Vp/Kjscg/ej+LVcKyBU5JpgHwHDzQVqKinHXeiCr0oaJbbMCZWN2+/BxYkrEGQ7E+M
         Oa6oGaIMrzlJQy4tar1lXZc/yoQTVCddXWFyTMcIqOCcGvNTsj1wwefFEGmN4EGqoCtW
         jZl3VFPFp9GJpJMcFvjgaN3FkNpaLrNrR3bz9yhDppn5IesZug6ldd2WRvDO0w31SDXA
         A8LK1aEY8ocuRHAOV9Tx06udQQHsx4QZjvaHaqFrJSKmu3FdadTExCAyZG4AV0m+KaE+
         E3AQvS/6B1/eq2f5MdYoM0VbwmIHAD666KqkBh1jHRiB3mfSk+Iyf7aIwNRxi7LyOmgk
         QRvQ==
X-Gm-Message-State: AC+VfDw+9q2S8m356QMX1tEKGnCGiXcw3HzQ0MUcA6fiFE/yysNym6B9
        5C5XbmbiOHv9wG6Dyzpd+jWb/RPcJCwVdioiV+jVdVuv
X-Google-Smtp-Source: ACHHUZ5XcQnLEFvz8kZuRsmUm4pSQ3y2t86BG/Hxm3YL/vJ5OjWJyicucLZYnI7p0gCHsy5Xoa70NA==
X-Received: by 2002:a17:907:168d:b0:976:a0b2:bf0a with SMTP id hc13-20020a170907168d00b00976a0b2bf0amr207100ejc.7.1685722051743;
        Fri, 02 Jun 2023 09:07:31 -0700 (PDT)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id dk23-20020a170906f0d700b009746394662asm782626ejb.53.2023.06.02.09.07.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Jun 2023 09:07:31 -0700 (PDT)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-96fab30d1e1so482562166b.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 09:07:31 -0700 (PDT)
X-Received: by 2002:aa7:c0ce:0:b0:516:2dcf:d027 with SMTP id
 j14-20020aa7c0ce000000b005162dcfd027mr2836164edp.10.1685722030936; Fri, 02
 Jun 2023 09:07:10 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=whu8Wh4JP1hrc80ZvGgVW4GV6hw1vwzSiwOo9-1=Y1dWw@mail.gmail.com>
 <ZG/a+nrt4/AAUi5z@bombadil.infradead.org> <CAHk-=whiXzqprmQNRui3LbKQwvM8fg4nyAzWcU5qZs+kxBVzrA@mail.gmail.com>
 <ZHRpH-JXAxA6DnzR@hovoldconsulting.com> <CAHk-=wh6sXSO63kka+EWEqq0tGwtOnXYFWMXPQ6T_wZa+Np3MQ@mail.gmail.com>
 <ZHSeOUpKtyc8VKx5@hovoldconsulting.com> <ZHTCK2_1pF61yWIr@hovoldconsulting.com>
 <CAHk-=wg7ihygotpO9x5a6QJO5oAom9o91==L_Kx-gUHvRYuXiQ@mail.gmail.com>
 <ZHYitt7P7W+8ZlSB@bombadil.infradead.org> <499e30cc-d015-8353-1364-50d17da58f47@redhat.com>
 <ZHd8bLPY4OQCb/Z5@bombadil.infradead.org> <ba60bca6-b682-4c27-3c54-2512b6f16151@redhat.com>
In-Reply-To: <ba60bca6-b682-4c27-3c54-2512b6f16151@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 2 Jun 2023 12:06:54 -0400
X-Gmail-Original-Message-ID: <CAHk-=whwFoC30zoTfsQAvkDRvgMCovwKGW_R1PPnqiF+YemcOA@mail.gmail.com>
Message-ID: <CAHk-=whwFoC30zoTfsQAvkDRvgMCovwKGW_R1PPnqiF+YemcOA@mail.gmail.com>
Subject: Re: [PATCH 2/2] module: add support to avoid duplicates early on load
To:     David Hildenbrand <david@redhat.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Johan Hovold <johan@kernel.org>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Petr Pavlu <petr.pavlu@suse.com>, gregkh@linuxfoundation.org,
        rafael@kernel.org, song@kernel.org, lucas.de.marchi@gmail.com,
        christophe.leroy@csgroup.eu, peterz@infradead.org, rppt@kernel.org,
        dave@stgolabs.net, willy@infradead.org, vbabka@suse.cz,
        mhocko@suse.com, dave.hansen@linux.intel.com,
        colin.i.king@gmail.com, jim.cromie@gmail.com,
        catalin.marinas@arm.com, jbaron@akamai.com,
        rick.p.edgecombe@intel.com, yujie.liu@intel.com,
        tglx@linutronix.de, hch@lst.de, patches@lists.linux.dev,
        linux-modules@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, pmladek@suse.com, prarit@redhat.com,
        lennart@poettering.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 2, 2023 at 11:20=E2=80=AFAM David Hildenbrand <david@redhat.com=
> wrote:
>
> What concerns me a bit, is that on the patched kernel we seem to hit more=
 cases where
> boot takes much longer (in both kernel configs).

So it potentially serializes the loads to the same file more, but in
the process uses much less memory (since the ones waiting will not
have done any of the "load file contents and uncompress them"). So
it's a bit of a trade-off.

We could complicate things a bit, and let other callers return -EEXIST
a bit earlier, but I'm not convinced it really matters.

Honestly, taking too long because user space does something stupid and
wrong is not a kernel bug. Not booting because we use too much memory
- that's problematic. But booting slowly because udev does several
thousand unnecessary module loads is entirely on udev.

                 Linus
