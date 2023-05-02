Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A201C6F4D47
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 00:55:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230480AbjEBWzb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 18:55:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230434AbjEBWzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 18:55:25 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1800B40C0
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 15:54:50 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-50bc394919cso5143883a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 May 2023 15:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1683068001; x=1685660001;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gGYH0ymg0qnLFd82gKT1P94uLDse1D7zbN1XWJORZiw=;
        b=dLEcI/gtk4y3XXKZzuMzFb+aWD2tDemtXP8EkOvupKqiipBLixsYLGUruheYMNc194
         KFEU8wVufilGdRKFyOexNw/18Wl2z9f1XVv3WP+NkBXZcpHUJsl/BAbhdASLRJYwS2Ov
         v78nLz+IE/5kxhIWNFdXfTn1/KQE0syVqQkgc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683068001; x=1685660001;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gGYH0ymg0qnLFd82gKT1P94uLDse1D7zbN1XWJORZiw=;
        b=IMAhLRL/ybTI031Azz3WP+jG3IPJJ+gNV20gqQyJRsLpEXIm7mEfF8RTCbQ37fjgAR
         0m8M7ZWY9k1ssR9z1e+uM3RpdFEOvkHkimIiQFEWWr1Qj8tKaOq5EWk3qUg9cn0CRRrW
         qGq4967GtKV+D8YFs2e6sfqU3sxXvi3rP9dhIDV60AMiWDLOkwERLdoHpuQRmLkJWPOW
         Kp0yDNNfITkRNA1g89lsAfg1cvJaLB/bgDubUmnzEvnIOffohi2yEgenIDpYHHbXMBCb
         Zz6hvO+XnInw/vTo+ZdOUOzuBJarvIzaDziRxZNVwUXDcamFCj28qsk7l8CTiX3QfNZi
         Zj+A==
X-Gm-Message-State: AC+VfDx0EV8gPD/0hS+/xk9tAs6QnGy8QQy93XHNMSPOoLCvsrpBEf67
        K9kAxWDoXkXf2V71zL7E+pIzO/pzJswRgv0rOujkDg==
X-Google-Smtp-Source: ACHHUZ5UdsFCbVG9UYkGjkLX1gGJkAXYFMYqytuMtNOSr8uHRxxNiL+qlfeJZjpQ6LV0OeRFZWCHKQ==
X-Received: by 2002:a17:906:6a15:b0:95e:ce4b:b333 with SMTP id qw21-20020a1709066a1500b0095ece4bb333mr1688900ejc.53.1683067524169;
        Tue, 02 May 2023 15:45:24 -0700 (PDT)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id h26-20020a1709070b1a00b00960681949cbsm7278808ejl.134.2023.05.02.15.45.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 May 2023 15:45:23 -0700 (PDT)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-50bc394919cso5134262a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 May 2023 15:45:23 -0700 (PDT)
X-Received: by 2002:a17:907:608f:b0:94a:71b6:c007 with SMTP id
 ht15-20020a170907608f00b0094a71b6c007mr1579397ejc.8.1683067523093; Tue, 02
 May 2023 15:45:23 -0700 (PDT)
MIME-Version: 1.0
References: <CACRpkdZ=bpsSKKgqGbGThvVAZc8fEx2vStbm9GUaZ5s1p5YGmQ@mail.gmail.com>
In-Reply-To: <CACRpkdZ=bpsSKKgqGbGThvVAZc8fEx2vStbm9GUaZ5s1p5YGmQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 2 May 2023 15:45:06 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjznm=EdyP=oeMoGUaTad80RZSOzs-iCWWTHAGJykJLpQ@mail.gmail.com>
Message-ID: <CAHk-=wjznm=EdyP=oeMoGUaTad80RZSOzs-iCWWTHAGJykJLpQ@mail.gmail.com>
Subject: Re: [GIT PULL] pin control bulk changes for v6.4
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 2, 2023 at 1:29=E2=80=AFPM Linus Walleij <linus.walleij@linaro.=
org> wrote:
>
> There will be one conflict, in the at91 pio4 driver, which is against
> a fix I sent in earlier. The version from my tree goes.

No, it's a mix of the two - the dev_err_probe() simplification from
this pull, and the irq domain name removal from your earlier fixes
tree.

                Linus
