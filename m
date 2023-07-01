Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B1F2744A3F
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 17:29:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbjGAP2d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jul 2023 11:28:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjGAP2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jul 2023 11:28:30 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 988058F
        for <linux-kernel@vger.kernel.org>; Sat,  1 Jul 2023 08:28:29 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2b69f958ef3so47707281fa.1
        for <linux-kernel@vger.kernel.org>; Sat, 01 Jul 2023 08:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1688225307; x=1690817307;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VtKOnvujSI4dbxDlJZ+F1PfbCBHZHBBwN0TgTtCMsfU=;
        b=hJk9K/sz2CAxuKFinP2kXG/Xu8GZyVY0Y4t8CMHhZn+BRVTSUd1DPEl6e6zFuvu7cp
         55adpHLuQYQCgwjK4VQlZuiLghzRcSrHpnEwlzVA8TtGVX+kLiZ+UHgmXHNjVmwhT1L/
         maYUAhWqupcgjdmzOiogePrFdjlxMo+XRzrxI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688225307; x=1690817307;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VtKOnvujSI4dbxDlJZ+F1PfbCBHZHBBwN0TgTtCMsfU=;
        b=JxxwSIhEjunNhGDK9RYbkZyjuaSAc1UookiZTgY/FXRhYPN6nkxo68LGbtG6tLPR4z
         Zge6/DNXRcZG2zskj4h2jUHDdZb+RKoIH34p9Q5LyvSjTiXtCelJq6Ki8iy4j4hmTl6K
         0ynEVYCZafVH9cB74lsY5X7TX8Rb1luCfzANwZfdhZBLcFyyEkhdRLr5/SHEFh6mpsGR
         zFOCVttmtTnihrmwR/MiwONmXdc9qsuGYuOemc72W6CM4s4ud36GowaNxDSZxBWQ6tZH
         1brk74R+SJrfFqPqKZ32/K4mmS+33D0enq9CtikqtLOkoRKWhhlhRDD3DbeEAg2r4CfE
         CTxw==
X-Gm-Message-State: ABy/qLYS+s7yF8t+xmkNZrQMhFzqL0mBtiGKdMvo1WdVCTSh//cqeRVj
        jgGiEAsheA78L6cpStK97z6+QiHeFFJtAeBDve6IJ8w7
X-Google-Smtp-Source: APBJJlExurvqe66CyLjLOt4XHD5VvB+s+vK3Ry5sWs6pQQ52548HC5oeHR1KtT4Phk8QzumXgoiTrQ==
X-Received: by 2002:a2e:300c:0:b0:2b4:6e21:637d with SMTP id w12-20020a2e300c000000b002b46e21637dmr4149606ljw.35.1688225307629;
        Sat, 01 Jul 2023 08:28:27 -0700 (PDT)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id oz26-20020a170906cd1a00b00992b3ea1ee3sm3102847ejb.159.2023.07.01.08.28.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Jul 2023 08:28:27 -0700 (PDT)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-51d7e8dd118so3353534a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 01 Jul 2023 08:28:27 -0700 (PDT)
X-Received: by 2002:aa7:c616:0:b0:51d:d2b9:54a0 with SMTP id
 h22-20020aa7c616000000b0051dd2b954a0mr3576929edq.2.1688225306845; Sat, 01 Jul
 2023 08:28:26 -0700 (PDT)
MIME-Version: 1.0
References: <202306300950.2BE7567101@keescook> <20230701-antrieb-rundbau-4b30efb507b2@brauner>
In-Reply-To: <20230701-antrieb-rundbau-4b30efb507b2@brauner>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 1 Jul 2023 08:28:09 -0700
X-Gmail-Original-Message-ID: <CAHk-=whtRbwWsh9M8fju_Q4rKBfAiruzBKrhnjiqH3-UNAocMA@mail.gmail.com>
Message-ID: <CAHk-=whtRbwWsh9M8fju_Q4rKBfAiruzBKrhnjiqH3-UNAocMA@mail.gmail.com>
Subject: Re: [PATCH] pid: use struct_size_t() helper
To:     Christian Brauner <brauner@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Jun 2023 at 23:45, Christian Brauner <brauner@kernel.org> wrote:
>
>   [..]         However, we do apparently have a dedicated
> struct_size_t() helper for exactly this case. So switch to that.

Applied,

               Linus
