Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 548445F3ED1
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 10:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbiJDIv4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 04:51:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbiJDIvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 04:51:53 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4A5C4D25E
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 01:51:51 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a2so7259962ejx.10
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 01:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=S1b/OO3SZm2YnaPLWGQoEy/42rvD+WkD7fL93s4ce5M=;
        b=ALQlbMyjhrx8mXGmP6x1GBpEIsMbQaydhr8rCtaomv8zxtVe6VJ8RWsGBXGqZ2Q4UF
         eppd9C01Y4onxIB9y4fCPQAkqJjfHy2Qt9jzFTaQmIfPXIIfw9pENs3f+WP9jc62vker
         e1bKWSUtzT+gNXCIWVokUg6OVXpZSiuD31WQVZOiClvx6yul3B0xaUukRlCHnzwXbAkN
         Jgycg0eSj9t0og0PO+uPZpETqs78HEdPtqtKfWuivw1sN/3aj+96p6Z8gf7NBPAWxUR9
         9w5VA+penQynX5RvVSRS94VivOylYEBidQNmkkxGmj1fgCZPWs1joe9dqojdn3vAm9JI
         zuaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=S1b/OO3SZm2YnaPLWGQoEy/42rvD+WkD7fL93s4ce5M=;
        b=phrl2JoZnXzYe/K/s72fS+OS3aWxfJ0Xxg3J23mAr4MCmt7tGqzHeWNH0JBOPGQvVo
         MOrZ7odOdnenHurOUQcfYjWFsC6paAaDCHQH/DuAj9xy1SfYQ8XyOwr0kMWI42tXxKTF
         awBSD8emhNcJOnzJE+AFwP8TZyFky2SproLSrHDdsMTWYALt+cRmri7KU7yLRbO+LSGT
         c5vnDFkpfvCQwIiNFGdWQ64GHepljgTra+08hUPet5hFA62dBnVle5dooKNpIzVUY6Xy
         xMOmwpDB5IbQOJkyuUbV7hVvrgfAA0otIrgLD7+aFjXhUPLLxgQW2yqBgLxtIBzo67kB
         odlw==
X-Gm-Message-State: ACrzQf364DzXu919UKJDC1hs6pyJnR4P1ks8zwB+AYMUdcLtn7Raa5/m
        sR7+iyOr1oehIqCSBb31VC+3RYeDKY6gMuvdw4Jsdg==
X-Google-Smtp-Source: AMsMyM44v9eZkzVncfXA0lAdhvFDT+i549wX8cbxiLoWo3qX4k1RLnZnuk7IfTWEqUUgR6b6T+jOM+6wvbLEBjqTuFo=
X-Received: by 2002:a17:906:58c8:b0:6fe:91d5:18d2 with SMTP id
 e8-20020a17090658c800b006fe91d518d2mr18634384ejs.190.1664873510152; Tue, 04
 Oct 2022 01:51:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220928174739.802806-1-f.fainelli@gmail.com>
In-Reply-To: <20220928174739.802806-1-f.fainelli@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 4 Oct 2022 10:51:39 +0200
Message-ID: <CACRpkdYfDM8mbtpJa5dQrhY1VCShwawnk0urG9zH5-fu53VhKw@mail.gmail.com>
Subject: Re: [PATCH] ARM: ubsan: select ARCH_HAS_UBSAN_SANITIZE_ALL
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ardb@kernel.org>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        Nick Hawkins <nick.hawkins@hpe.com>,
        John Crispin <john@phrozen.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nicolas Schier <n.schier@avm.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>,
        open list <linux-kernel@vger.kernel.org>,
        bcm-kernel-feedback-list@broadcom.com, anand.gore@broadcom.com,
        william.zhang@broadcom.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 28, 2022 at 7:47 PM Florian Fainelli <f.fainelli@gmail.com> wrote:

> From: Seung-Woo Kim <sw0312.kim@samsung.com>
>
> To enable UBSAN on ARM, this patch enables ARCH_HAS_UBSAN_SANITIZE_ALL
> from arm confiuration. Basic kernel bootup test is passed on arm with
> CONFIG_UBSAN_SANITIZE_ALL enabled.
>
> Signed-off-by: Seung-Woo Kim <sw0312.kim@samsung.com>
> [florian: rebased against v6.0-rc7]
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Pretty cool that it "just works", I was thinking to myself that I
should try this one
day. Sorry I was late to look at the patch.

Have you also looked at KCSAN?

Yours,
Linus Walleij
