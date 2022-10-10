Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28F085FA467
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 21:57:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbiJJT5f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 15:57:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiJJT5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 15:57:31 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 323436C138
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 12:57:30 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-132b8f6f1b2so13562186fac.11
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 12:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=M8uyUjEJR//bZXPKOY27qzuplDCO6DMXj9UQvWKRnws=;
        b=FobSKKzVUOOjjfpa3KBD+BbpDxa3pcBVtD16L1m+hHqk/vBBDGrc1DLEAAjfQmEdpo
         Nfl+wTL3Ash0E9flHmSa3JitVaB3E30PhqSlA47DNFVWRw8tDBBOuwbgyZgHJEZe2g9A
         cHXxeSDe3X1TzJsmoQNiunyc3FVotC2yaW0YE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M8uyUjEJR//bZXPKOY27qzuplDCO6DMXj9UQvWKRnws=;
        b=fhwsGxnDRZ3Irg4GyanRylVpCODvj2jxY6w7NJDRUbKaK8TMr8t1n+Zmh7O6SbXppd
         fFxX7z2afnzTPsIZxfRzb2s91brsLoYnubh6A0/hfqBOGQqXSA/EawuvOEFCEDttQMQo
         MNIyZlMrD2Vv/cbuPhhGYFK0bgwPzYR+uJhX1QHVSjZinQixoNqpf6heODAypxWShj04
         qbnV8B93XwsSi18aUWeksoB8C5gEoDDsc3SwRUv+L3PoMsviXEsLPV2PDAKda9WMd1qn
         FYQurhspQuSxA2wcfWybIFD7Z+ks8LUk4mtu51/MW2CsdarnTAp4JNVnQDuAqGw+fKtg
         86Ww==
X-Gm-Message-State: ACrzQf1qyscn8R/UyW6wIj09KuLG10JPx4W3qqhRxPFMkfw/8G04jMk8
        kKJbbxwFdGL+xYd1Vm2PYspdps2/MPxNWg==
X-Google-Smtp-Source: AMsMyM61wS8DCZdvzZSpT4vJqrl/KHU0b1u4vgYBPEOBT4T0u5I0wTEesvpF4kj/EDp+UqDEumWphg==
X-Received: by 2002:a05:6870:350a:b0:12d:91cd:cd50 with SMTP id k10-20020a056870350a00b0012d91cdcd50mr16778927oah.249.1665431848970;
        Mon, 10 Oct 2022 12:57:28 -0700 (PDT)
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com. [209.85.161.46])
        by smtp.gmail.com with ESMTPSA id q36-20020a4a88e7000000b004728e64dc0fsm4497490ooh.38.2022.10.10.12.57.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Oct 2022 12:57:28 -0700 (PDT)
Received: by mail-oo1-f46.google.com with SMTP id s125-20020a4a5183000000b0047fbaf2fcbcso6535045ooa.11
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 12:57:28 -0700 (PDT)
X-Received: by 2002:a4a:aeca:0:b0:480:2413:1edc with SMTP id
 v10-20020a4aaeca000000b0048024131edcmr6524242oon.96.1665431847914; Mon, 10
 Oct 2022 12:57:27 -0700 (PDT)
MIME-Version: 1.0
References: <CAK7LNASzGEiQfPTaLmhG4k7VAwB5yznd-VqWdJHEF2YjgSQTcA@mail.gmail.com>
 <CAK7LNARfd1mbL8bE14NfRCmVU+wRZjxCuBVTBNQ-negr5nms4w@mail.gmail.com>
In-Reply-To: <CAK7LNARfd1mbL8bE14NfRCmVU+wRZjxCuBVTBNQ-negr5nms4w@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 10 Oct 2022 12:57:11 -0700
X-Gmail-Original-Message-ID: <CAHk-=whG854+ki8fpvtMjjmgvbby=OnDS4e7-vY0DUCO6AYRUw@mail.gmail.com>
Message-ID: <CAHk-=whG854+ki8fpvtMjjmgvbby=OnDS4e7-vY0DUCO6AYRUw@mail.gmail.com>
Subject: Re: [GIT PULL] Kbuild updates for v6.1-rc1
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
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

On Mon, Oct 10, 2022 at 12:53 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> I have not got any feedback on this pull request.
> I started to be worried because we are in the 2nd week of MW.

I merged it earlier today, I just haven't pushed that out yet.

I had some issues with my main machine, so things got delayed a bit:

  https://lore.kernel.org/all/CAHk-=wjNaJWvvUKTk43H-OtdP+wnM31tw8v4oz5t1TzfO4x+TQ@mail.gmail.com/

but it is all sorted out now and I'm catching up.

             Linus
