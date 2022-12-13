Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CD5A64AD0B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 02:32:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234114AbiLMBcr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 20:32:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234101AbiLMBch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 20:32:37 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC9A91CFE0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 17:32:34 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id j16so10697281qtv.4
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 17:32:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2eqfa1XIBCm6hdVVCJy7q3CDQSZOeuXGCdncD/RyVHQ=;
        b=BVvVXFKCWlL+28CaWZrxozLYkVmJ7nKRWx1pTdi6ral8n0X7EZK+/eVNXCRP69319e
         912y6oIwz7nUqvyF7b1a5tlXNicP19OGma5unRKw8ipxgdwIOCSH0YGUwBmzBd6HX4uK
         Fq3WjMBgGwTlPn43iJwELDMI+ecMotnu7X528=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2eqfa1XIBCm6hdVVCJy7q3CDQSZOeuXGCdncD/RyVHQ=;
        b=BGVMsfWDzJa9KGbPGlxvOc5G6+EeZKKCoTbZxfU+dKa7PzK8+zX6RJq1LEMMismjp2
         W8eAfM7Vx8E+47SAPcmJoZQeysKqbEtYRQ0cJ9BoucDqaT5sGIykHpw5/IFQuaqSruwc
         Gc9uA0SUBfx9CNme5OgmdoB3lS0Pl6h/9mtppYCWYNjUFO7kqT4H9/+JJlu7+vyy3sDj
         X2e6yd/hXXMwkb7wWpu/10I8IRXcibmzwvptiG2vsrS0ynqW8JQZw30fsckKUefnU9t3
         wpNUC09qVaUZG/oGNkIjgx4W2dMwcoCRYWDyk77C7A8oyoL74yLu63/VFCa9aERgHXLA
         aeKw==
X-Gm-Message-State: ANoB5plAW2FjpUz1hrC8V/g8SJB9eQ9NooT2BMen1kGjQpipgStnoKRc
        zEb95RKA3ZJQ47t9qVJXG2fOnJSt467M9680
X-Google-Smtp-Source: AA0mqf46qvImlxKurJHbxpFhUD5YoX77FCVgSeiZDqvzW1tzdblh7A7WAZvGk5gmDZz3O1crDT3hBw==
X-Received: by 2002:a05:622a:408e:b0:3a6:21cb:cca4 with SMTP id cg14-20020a05622a408e00b003a621cbcca4mr28586821qtb.10.1670895153485;
        Mon, 12 Dec 2022 17:32:33 -0800 (PST)
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com. [209.85.160.178])
        by smtp.gmail.com with ESMTPSA id bl14-20020a05620a1a8e00b006faa2c0100bsm6927547qkb.110.2022.12.12.17.32.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Dec 2022 17:32:32 -0800 (PST)
Received: by mail-qt1-f178.google.com with SMTP id fz10so10695997qtb.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 17:32:32 -0800 (PST)
X-Received: by 2002:ac8:4988:0:b0:3a7:ef7b:6aa5 with SMTP id
 f8-20020ac84988000000b003a7ef7b6aa5mr7544619qtq.436.1670895151958; Mon, 12
 Dec 2022 17:32:31 -0800 (PST)
MIME-Version: 1.0
References: <20221212134425.b20b80955e5e8a4a36ce1b9a@linux-foundation.org>
In-Reply-To: <20221212134425.b20b80955e5e8a4a36ce1b9a@linux-foundation.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 12 Dec 2022 17:32:16 -0800
X-Gmail-Original-Message-ID: <CAHk-=whD2ouXCgWK27x7KQt7pQ2Xckzr9Gkkzqs3ZcPH_A2g-A@mail.gmail.com>
Message-ID: <CAHk-=whD2ouXCgWK27x7KQt7pQ2Xckzr9Gkkzqs3ZcPH_A2g-A@mail.gmail.com>
Subject: Re: [GIT PULL] non-MM commits for 6.2-rc1
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, mm-commits@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Mon, Dec 12, 2022 at 1:44 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> - A series from Yang Yingliang to address rapido memory leaks

"rapido memory leaks"?

[ Goes off to look at the commits ]

Ahh. Typo.

           Linus
