Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A147065C85C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 21:46:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238808AbjACUqc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 15:46:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238953AbjACUqV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 15:46:21 -0500
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F388415709;
        Tue,  3 Jan 2023 12:46:14 -0800 (PST)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-4b6255ce5baso6956377b3.11;
        Tue, 03 Jan 2023 12:46:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=b/kZ9pKOcebPkZheGmRobplHFLxApQR/iEoi6WL4EnY=;
        b=bOAUwEAaR6oTed+NyLFb9ISm/aOJqfKrx8bX8DdXMlrLR5MbfmEfnxz/wZ8BAIjMSe
         BUgVvcZ3qm9O6u4S9sNfLlv+HR0UPjT0S5MA2JPg7cdbj3hNMIlp8g04ivxDvijZY37h
         Wujd2/yosmbCG0uhIEVYRCStqTfXUEbGaKn+20e4zjBC4cgJcNnFYOl7H6/WTpYqveg7
         gJMS+S8L/W2M5V4kuIQltGwo4bj6C45A+p5SqB6HZwe3OHSr0hG503Jp/Rf2wwRUKu0I
         E6cGEAhYZEZyb2MNGRs3eyhOjf/UFq2c6GhyBb5SxoD334/lHU9anety0/R/REW5UEC3
         0MvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b/kZ9pKOcebPkZheGmRobplHFLxApQR/iEoi6WL4EnY=;
        b=JVrQhcG0Zvun68p7zZPHfpC66cIK18zJ9KGJ1aynSqB1c32yAoDMkcaFzuqeyFPl9n
         vinMh49YNsQ7GgeJDwXLxlbEc1jJJNcJb8mguudMDipND9ZHzKG9qOM1IOYEn7QyvEkL
         g8/0WQ0FChvk3soiZ1lVI27s0xHbmynciJvlpl3cNt2oopObFWrwoguMOy/HgXtFXiS1
         niJsh7cLU45p53lR0Oac4tchwGHNZzOTDTZSVAXADBTD+vvC1W8qGVt+EUKXgowmvQ4a
         XCsHuvgCR8LjSC9OprfeXL+0qvI1p+R1QQHrWQJVySrWpjVeli6VzPBW3XPkpcjIFMIX
         ynBw==
X-Gm-Message-State: AFqh2koCa8Dc/EzQarYcRBeLlgtN+MeOqgIzFQZ56HqyKZEREr37weHm
        6BWOSN4w9aOBoCBfbe+PoW04X8i4gocef+jQ+E4Q9wRfwtpCJxnW
X-Google-Smtp-Source: AMrXdXtiuDFT+wB0O9CyLqumM1jk+fR++NGp9bP7NyNp0nT+eQ1hp6w1SPQmD7O2fd2U3ox6grgo8H1rkpQlMRSVrZ4=
X-Received: by 2002:a81:9191:0:b0:3b6:bbd4:2769 with SMTP id
 i139-20020a819191000000b003b6bbd42769mr5384451ywg.5.1672778774230; Tue, 03
 Jan 2023 12:46:14 -0800 (PST)
MIME-Version: 1.0
References: <20221231064203.1623793-1-masahiroy@kernel.org> <20221231064203.1623793-6-masahiroy@kernel.org>
In-Reply-To: <20221231064203.1623793-6-masahiroy@kernel.org>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Tue, 3 Jan 2023 21:46:03 +0100
Message-ID: <CANiq72kXVyy1=ezU-dwj1tT_986RPvfRgBSfUGkz9SwHgAneZQ@mail.gmail.com>
Subject: Re: [PATCH 5/6] fixdep: avoid parsing the same file over again
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        rust-for-linux@vger.kernel.org
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

On Sat, Dec 31, 2022 at 7:42 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> To skip the second parsing, this commit adds a hash table for parsed
> files, just like we did for CONFIG options.

Acked-by: Miguel Ojeda <ojeda@kernel.org>
Tested-by: Miguel Ojeda <ojeda@kernel.org>

Cheers,
Miguel
