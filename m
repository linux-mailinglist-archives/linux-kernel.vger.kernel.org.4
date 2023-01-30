Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4C2568040A
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 04:07:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235409AbjA3DHD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 22:07:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232637AbjA3DHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 22:07:01 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AA341BAE6;
        Sun, 29 Jan 2023 19:07:00 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id me3so28009742ejb.7;
        Sun, 29 Jan 2023 19:07:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=o3ntMQlqb0JzrJC4tchjcfSk9a30/CGTxcCGy9x2Jf0=;
        b=jSDfboJPPTFZPs1T1iP1IFvxzTcUaOyhvKCke2TUwIuWfnaeCqvtjFwn8oD7Qysl90
         Z3r1GhbNMoaF5Bu+pmcaK6zOUhil3T/BYhYeGMUcvS7CmRkxJhV5ezotOl8tDuKKT77A
         EREbxkz18kq2O3tHmcWF2igYlOscg2StfEpvM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o3ntMQlqb0JzrJC4tchjcfSk9a30/CGTxcCGy9x2Jf0=;
        b=2t8erVuaEbHkPmzPMICWBxRVh2Q6HTaFMILxhUthN58grbdr+pFeKX4V27eY3WgQzP
         MfGM747n64Koymzyb8GKXwQvkVsJKXjqk4fpdAQe4bcroghOJbsL+I4hjv735skb2Ewc
         EG9lzcdslTkzaSZUbbc6QTT2ijHVmewjnC6spbjVf5yRIrA1T+5tvlGj4uMrEx6Zzdqx
         bjmEpIE8ENiRcGt5M7WVGIf7J7ymH+bKlAnKyvi0sCue7Pal81tAA8lYyYTXcHUd2LOj
         8cJHqKSKMcMcPAOvDMW13mrcgtfOQjhHKScfIheVw7XJF7lM5EBmMhPJlpz86aUsg8+6
         cBTg==
X-Gm-Message-State: AFqh2krqwov4GO72r/1G+XgnHQeg+sgUgUVxIWuJAkTBmbDpkeiZ3VMV
        nrONKwqkRWz9bYaMRwAB6CobEBv8zG8NqsY3kz5O8aQk
X-Google-Smtp-Source: AMrXdXvY4IZW4tVAv3tuOBdVoBSU3iHW5DrVeKtBVjPj7EOVrNscPenJ6jiivMGThIDybslCR9togqBCi+9397ULv8Q=
X-Received: by 2002:a17:906:9ea5:b0:84c:a863:ebf3 with SMTP id
 fx37-20020a1709069ea500b0084ca863ebf3mr9489326ejc.100.1675048018726; Sun, 29
 Jan 2023 19:06:58 -0800 (PST)
MIME-Version: 1.0
References: <20220818101839.28860-1-billy_tsai@aspeedtech.com>
 <CACRpkdYpp_1JJQmuX27pECxN0cjzciCuETLPTrSYKqpX0FPABQ@mail.gmail.com>
 <e501d2fb-aaa0-470d-a8d5-5f8e97898df7@beta.fastmail.com> <CACPK8XfQ=uarsOgJ7LaXqLyGG2vSF-47RkAEV=T2gruapx-yfg@mail.gmail.com>
 <CACRpkdZPxZgWJ3jjiesOFGXmwzZFqeByZyx1VCy5pDWyVQHy+A@mail.gmail.com>
In-Reply-To: <CACRpkdZPxZgWJ3jjiesOFGXmwzZFqeByZyx1VCy5pDWyVQHy+A@mail.gmail.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Mon, 30 Jan 2023 03:06:46 +0000
Message-ID: <CACPK8XcL-T_zv0aoeM5DJzGirp6dqD9UOn6=enSZDLao6hg2bg@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: aspeed: Force to disable the function's signal
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Andrew Jeffery <andrew@aj.id.au>,
        Billy Tsai <billy_tsai@aspeedtech.com>,
        linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Jan 2023 at 12:39, Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Thu, Jan 19, 2023 at 2:54 AM Joel Stanley <joel@jms.id.au> wrote:
>
> > As foreseen by Andrew, this caused a regression. On the Romulus
> > machine the device tree contains a gpio hog for GPIO S7. With the
> > patch applied:
>
> OK shall I just revert the patch?

Yep! I was going to send a revert but I thought I should write up a
commit message. If you're happy just putting a revert in with a note
that it caused a regression that's enough for me.
