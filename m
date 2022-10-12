Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AEFB5FCA8C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 20:24:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbiJLSYV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 14:24:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbiJLSYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 14:24:17 -0400
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81B755591
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 11:24:16 -0700 (PDT)
Received: by mail-oo1-xc32.google.com with SMTP id s125-20020a4a5183000000b0047fbaf2fcbcso10561288ooa.11
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 11:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Uf4Q6mDzkHYolnexbxAtn/OulhdrRZBn/s//1eNnWwg=;
        b=MbeVngOZRHdoMllqTr4IQcXLSoP5HSPH4ieXT+UiAMWOPHKMyuBGVLI4tobfVhYpD1
         I6gOpReKUcBJphu0tM4SusihsfwEb9xO+GAt/f7Ut9XGkjAfcjlG7uKD4P4WTaciyCQZ
         fOpKxBXfiyt1ebHN+vzAtzDc/Szljf1htXxWI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Uf4Q6mDzkHYolnexbxAtn/OulhdrRZBn/s//1eNnWwg=;
        b=f4fClsWsNsoMULPOn56Th0rl9bkYHaBcr9vwoz4uTj8mB4jChhu7alihvkEocvxkMz
         K9h4fSIP1TbpAyYS2xktdNoKtagWBSwZ0djHT9uUoW/rgjvSmmGlLio4a8QrOyYyPNoM
         LDSuMJ5ISfYyru8vvTP0STsDcp7aStSwttbNkcq+OaW+EYtY2VPmPs3pVmOQB/lkeHsi
         AoqoIl3z95EkSEwvEs415UUTvXUTMpqob9cVDL5GUfc0Gq97FSc5tJP+yT7Mpk0lnbgl
         0qWUGo2CMwK4ciK3lhxzddsohaJSW//u7mqiIMYIgwvR1of2St+KMxZLVMBWbIWQrJSz
         Ya0A==
X-Gm-Message-State: ACrzQf06JA11VTdqMO0FND+WPVEV5YLHZ/WxcRspYP2XIGVxYq/fNLNd
        j+cVuTsEwBRihdbbWE89NdadXfuq/906mw==
X-Google-Smtp-Source: AMsMyM7r3WzkaaLUj1u2Y9O1MRC4vd15RsUK8HOC57M/YwMd9kMU8ycCY4rf7qUaGWMQk8/AcpQFeg==
X-Received: by 2002:a05:6830:2a11:b0:660:dab1:6bb1 with SMTP id y17-20020a0568302a1100b00660dab16bb1mr13824796otu.116.1665599054907;
        Wed, 12 Oct 2022 11:24:14 -0700 (PDT)
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com. [209.85.161.51])
        by smtp.gmail.com with ESMTPSA id cm21-20020a056830651500b00660d73c8bdesm7751347otb.50.2022.10.12.11.24.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Oct 2022 11:24:12 -0700 (PDT)
Received: by mail-oo1-f51.google.com with SMTP id m11-20020a4aab8b000000b00476743c0743so12686770oon.10
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 11:24:12 -0700 (PDT)
X-Received: by 2002:a05:6830:4421:b0:661:8fdd:81e9 with SMTP id
 q33-20020a056830442100b006618fdd81e9mr9723555otv.69.1665599051939; Wed, 12
 Oct 2022 11:24:11 -0700 (PDT)
MIME-Version: 1.0
References: <20221012144846.2963749-1-chenhuacai@loongson.cn>
In-Reply-To: <20221012144846.2963749-1-chenhuacai@loongson.cn>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 12 Oct 2022 11:23:55 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj=62F=soverz1NT41B1_CMtaxnUZX+_qGQ3mbeQdjivg@mail.gmail.com>
Message-ID: <CAHk-=wj=62F=soverz1NT41B1_CMtaxnUZX+_qGQ3mbeQdjivg@mail.gmail.com>
Subject: Re: [GIT PULL] LoongArch changes for v6.1
To:     Huacai Chen <chenhuacai@loongson.cn>
Cc:     Arnd Bergmann <arnd@arndb.de>, Huacai Chen <chenhuacai@kernel.org>,
        loongarch@lists.linux.dev, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, Guo Ren <guoren@kernel.org>,
        Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
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

On Wed, Oct 12, 2022 at 7:51 AM Huacai Chen <chenhuacai@loongson.cn> wrote:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git tags/loongarch-6.1

Grr.

This was rebased mere hours before the pull request.

Much (all?) of it has been in next - with different commit IDs, of
course, but the question remains why you have rebased it?

It just makes it much less convenient for me to check "was this in
next?" and is generally a *horrible* thing to do.

                       Linus
