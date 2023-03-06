Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 752DD6ACF64
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 21:45:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbjCFUpl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 15:45:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbjCFUpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 15:45:39 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D8366513B
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 12:45:37 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id ay14so40361039edb.11
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 12:45:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1678135535;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=euPDw9xX5ZNQ+1jvrQuq5hNCSBxgvLUEg2aMsYlQrV0=;
        b=MLiNXMkTK3oTY2FUOAkJmLgTu7+iuVMcQQEDaFU/WVqI92jWu9wpn9N/OVHKG3v46m
         0Hl8sHJYs+qumbLhDBCuRjYf7d2dg1RsilInBNrOzZ5HgkYOX+/Yi2fO2/afOWLkKSEe
         a5+SvY3lXHBC3aN7KiFPQCOqFdvD50StgH3Ac=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678135535;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=euPDw9xX5ZNQ+1jvrQuq5hNCSBxgvLUEg2aMsYlQrV0=;
        b=WiKmUblQCnmAgaPo+buKUsmeKO3U3Kmlm9qKrDYh6zeGzKvh36HsiDsx6zmlno98sU
         p5H3vHnzlzpjksdEJWIjc1edetSeMM0j4Ov0DznTtGQZroxKMKQUEhBm7g0S79JCWT16
         DkgCZH+Tqu0lVcD2I8HdDRm2i73qbEE5IezkjYHCnaSMpzZO7CGbnHhgW/uVv/5wuNpe
         cnXRhrpp3zsyF2wRpC5zDPvSCc9ROeweFMHmKjTrGu9xRRQqSmeyAPuHu5pXcOFMqw/v
         KKMlmZZwRjw5BY8huJJ6anGIucdXeFd/BhEdc6hpKIdsf4ySS12+Cq+GCYil7iZ54ZHt
         gs/Q==
X-Gm-Message-State: AO0yUKXNX79RWmNOSSNlILonMDAS6svqLIeVgbQ2+4KhQpEKFj692FnA
        G42rFUFG57FPg4vxQC3MiVF+2Pu4AmsAppqsvizwIjRC
X-Google-Smtp-Source: AK7set+ugJFkJ/r6xkSaV8drQo6e3CpWZHnp3xlv5urlXEqC8J4es2rjbWzODOPk74IfjAucpTSkGg==
X-Received: by 2002:a17:906:b882:b0:8b2:3e72:1022 with SMTP id hb2-20020a170906b88200b008b23e721022mr11623569ejb.29.1678135535520;
        Mon, 06 Mar 2023 12:45:35 -0800 (PST)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id hy3-20020a1709068a6300b008e57b5e0ce9sm5021323ejc.108.2023.03.06.12.45.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Mar 2023 12:45:35 -0800 (PST)
Received: by mail-ed1-f47.google.com with SMTP id ay14so40360801edb.11
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 12:45:34 -0800 (PST)
X-Received: by 2002:a17:906:398a:b0:877:747e:f076 with SMTP id
 h10-20020a170906398a00b00877747ef076mr5456305eje.0.1678135534613; Mon, 06 Mar
 2023 12:45:34 -0800 (PST)
MIME-Version: 1.0
References: <20230306152204.49836-1-andriy.shevchenko@linux.intel.com> <ZAZDvtjsjxrbbEeA@smile.fi.intel.com>
In-Reply-To: <ZAZDvtjsjxrbbEeA@smile.fi.intel.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 6 Mar 2023 12:45:18 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgQEuzVkSOWZ1gPOysniURWvmbUkFVP6GSU52FmBrZSVA@mail.gmail.com>
Message-ID: <CAHk-=wgQEuzVkSOWZ1gPOysniURWvmbUkFVP6GSU52FmBrZSVA@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] cpumask: Fix typo nr_cpumask_size --> nr_cpumask_bits
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Yury Norov <yury.norov@gmail.com>, linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 6, 2023 at 11:49=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> In another thread we still mention this. Interesting...
> what did I miss?

You didn't miss anything, your typo fix is correct, and the same typo
just exists in that other thread too. For all the same reasons for the
original typo (possibly together with some cut-and-paste from said
comment).

         Linus
