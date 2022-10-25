Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5614C60D1BC
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 18:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232252AbiJYQmP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 12:42:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232024AbiJYQmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 12:42:10 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7923E816AA
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 09:42:09 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id i12so9058658qvs.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 09:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DMH1L5/T9IU73tpTkKcPO6rFkqbZT1XT8yCS4sITmQA=;
        b=EzResYwicxkSJRV84ydhuhny5KiwmpPZnp/STCsw2WFYoRYHzJZriwWB2/PnaxE32f
         zu34f+Z6LXgUFKe31aNAY+prKNFRp3HMSGuZ6pt2EkUieZo+c/4jdGPbLqcnSfvWk4ef
         T/VXX3cLM2ySxPrFrf9qx81AqBXAPHCydGo7s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DMH1L5/T9IU73tpTkKcPO6rFkqbZT1XT8yCS4sITmQA=;
        b=k6SCEeFeOlgpjB8L5ibog3hRoAO9i/1TL5Of2g8eOeENfIYOTn2RCAeyG5J1RM/kdZ
         EVZel4MXhWW9HDHujKJZwH4eyplBEk2uIccQlotU2WXIBrZaPaOJ0kO80xTqd9Jzu08v
         CbXHmcZRQHABzz953kMT9kkgRoOv9k0hv/zNvPZUJVU31PHoTUqxwe8jBxtqcXZf5CNB
         Fkg2xEvqkBMWxTR3bW25PVXOh1khR/ptTpSd3xZ9e7XBwpFim9T4c6LumP660L2BlxA4
         W5FGTN4heuGYsGbqKh/U4p50gU7O2hB8kqiudJNRFeJTE11pLNakyR9KMSHf4pfeMoSs
         aTTQ==
X-Gm-Message-State: ACrzQf2648QDrPpaA10T1/D3EEd8bhHdnVzjEegjqgaqLeFXPOgTDkSP
        deAXBf0QzLBk923zr92vdAxC+rNmoPt7Tg==
X-Google-Smtp-Source: AMsMyM6BTOJoPF4nTcfocRUXeg3SAEedmgC4lIinjwTJPQhOoHGQZeFw9Un2ioyPoMTH9iOkuNPOKg==
X-Received: by 2002:a05:6214:e6f:b0:4b4:4e78:c0e with SMTP id jz15-20020a0562140e6f00b004b44e780c0emr34043869qvb.16.1666716128449;
        Tue, 25 Oct 2022 09:42:08 -0700 (PDT)
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com. [209.85.128.179])
        by smtp.gmail.com with ESMTPSA id c6-20020ae9e206000000b006bb29d932e1sm2231862qkc.105.2022.10.25.09.42.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Oct 2022 09:42:08 -0700 (PDT)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-369426664f9so119372607b3.12
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 09:42:07 -0700 (PDT)
X-Received: by 2002:a81:114e:0:b0:36a:fc80:fa62 with SMTP id
 75-20020a81114e000000b0036afc80fa62mr17449740ywr.58.1666716126263; Tue, 25
 Oct 2022 09:42:06 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wgLV1tNP0EYz7qWK-xeKzO6bh5Kogbpn2wxKLPPpOit3w@mail.gmail.com>
 <20221025162441.GA1128834@roeck-us.net>
In-Reply-To: <20221025162441.GA1128834@roeck-us.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 25 Oct 2022 09:41:50 -0700
X-Gmail-Original-Message-ID: <CAHk-=wivKoK4VgfKB8ykQUHKhNSUYA2=m4X7k8QKaizSMvzgZg@mail.gmail.com>
Message-ID: <CAHk-=wivKoK4VgfKB8ykQUHKhNSUYA2=m4X7k8QKaizSMvzgZg@mail.gmail.com>
Subject: Re: Linux 6.1-rc2
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 25, 2022 at 9:24 AM Guenter Roeck <linux@roeck-us.net> wrote:
>
> Build results:
>         total: 152 pass: 152 fail: 0
> Qemu test results:
>         total: 499 pass: 499 fail: 0

Woo-hoo!

That was quick, for once.

> Runtime warnings

Oh.

Well, close enough, and those fixes are presumably pending too.

              Linus
