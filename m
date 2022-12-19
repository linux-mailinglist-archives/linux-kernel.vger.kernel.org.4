Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B4B965158C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 23:27:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232656AbiLSW1k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 17:27:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231931AbiLSW1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 17:27:37 -0500
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C277B12754
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 14:27:36 -0800 (PST)
Received: by mail-qv1-xf2e.google.com with SMTP id u10so7196035qvp.4
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 14:27:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZrwtJ99mPIdpn902Yl38nd5oEw4ClksCy0+9+58YOqk=;
        b=UxBXVJKdoZanEEmT4XKAQM87Fh/57YuHSQEYg1wo90BnAGQGnB/Ad1wbxqkLVpoHgL
         esx1oQJsxI+i7FnsC7+M248zlv2RvHmMvMQgHmLAMP2bd1xf2qw+HG3ywTkikv8pyk73
         pQGD2dslClLgSdx8JKeggnTAWU+Ne2E3P31Gk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZrwtJ99mPIdpn902Yl38nd5oEw4ClksCy0+9+58YOqk=;
        b=y8zboBp1jrGDPtbwD47+VI0CyBSaPf95xqTVVF38Nz8dMTud1JJ16f2/aOnnSx9wMq
         nrTvFutbPyiHftczJU3XsrYt3IsUhH/HFyHyU+eQjJyI2PnDVY9BXZBpBnz8CEKEJLu0
         sCO7kNZLkyHf7k1mXK/L25bQ7pi8VDCfzifrfw2+MD1GwNAX/ZYbTfX3a8pRd4dTqQsZ
         Wf4WYL7EoPiFwwjxAe38VpL281cUEFgCzJwShtjKCx3eBR81YmRRbGv4Tnro3bnzzT0+
         RRiurew/otPYhrrOxEWlNKObw5yHmViy+uYXwRntq0nN47gSqOrhjn3namXzw7FbamNu
         YSkQ==
X-Gm-Message-State: AFqh2kplsIdforhABFsqiBxAz8nLaC0Q07cwpQ52FNb59hKIWd45U8CL
        Rhn9ErX/0jo2TLI2wNuiPoD+tUimGssH2DR+
X-Google-Smtp-Source: AMrXdXvNwDRdXalSUNktQC09QmvfVtWnSFt6LNw1tsPDBPHN6dz0/qi00rgoTMZa4+zKOWZb3v88GA==
X-Received: by 2002:a05:6214:3507:b0:4c7:7370:3c07 with SMTP id nk7-20020a056214350700b004c773703c07mr13924190qvb.13.1671488855639;
        Mon, 19 Dec 2022 14:27:35 -0800 (PST)
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com. [209.85.219.44])
        by smtp.gmail.com with ESMTPSA id bp31-20020a05620a459f00b006bb2cd2f6d1sm7856594qkb.127.2022.12.19.14.27.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Dec 2022 14:27:34 -0800 (PST)
Received: by mail-qv1-f44.google.com with SMTP id o12so7194230qvn.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 14:27:34 -0800 (PST)
X-Received: by 2002:a0c:c690:0:b0:4f0:656b:c275 with SMTP id
 d16-20020a0cc690000000b004f0656bc275mr1406822qvj.129.1671488854458; Mon, 19
 Dec 2022 14:27:34 -0800 (PST)
MIME-Version: 1.0
References: <0b37729c-535f-4864-aa2e-4f6088f8e63e@app.fastmail.com>
In-Reply-To: <0b37729c-535f-4864-aa2e-4f6088f8e63e@app.fastmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 19 Dec 2022 16:27:18 -0600
X-Gmail-Original-Message-ID: <CAHk-=whBeiVWAWUrPj__03MPBpQRF313-Mw05jo08Lxvx2zGcw@mail.gmail.com>
Message-ID: <CAHk-=whBeiVWAWUrPj__03MPBpQRF313-Mw05jo08Lxvx2zGcw@mail.gmail.com>
Subject: Re: [GIT PULL] asm-generic bits for 6.2
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linux-kernel@vger.kernel.org,
        Linux-Arch <linux-arch@vger.kernel.org>
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

On Mon, Dec 19, 2022 at 2:29 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> are available in the Git repository at:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git asm-generic-6.2-1

Nope.

That's not the right repository.

And the right repo doesn't have that tag.

Re-do, please?

         Linus
