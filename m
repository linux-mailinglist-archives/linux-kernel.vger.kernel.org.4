Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89C865F3A4C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 02:03:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbiJDADB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 20:03:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbiJDAC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 20:02:57 -0400
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55FE610052
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 17:02:52 -0700 (PDT)
Received: by mail-oo1-xc33.google.com with SMTP id s1-20020a4a81c1000000b0047d5e28cdc0so3771087oog.12
        for <linux-kernel@vger.kernel.org>; Mon, 03 Oct 2022 17:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=cueZVs+JemlUrpCma8cU2MoonpwhlFUlNsIey5jOwDk=;
        b=XImYLaeVrdpGlNz131QskDLw57oShRWzKlWl05q7GZnGP4fmLn3bLvHYlOU50VM4qE
         TrQfrXYjC1XKLtzwwbG6eTPBPk1J5zgX5EeI1ih1razMkvCmB7KCJ/sG2aTDHxxXW6kE
         cEFUO07c0IZLTZFRJTYwoErMenDJhy5VrY4EY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=cueZVs+JemlUrpCma8cU2MoonpwhlFUlNsIey5jOwDk=;
        b=4isCz00HGhceoOshwemi5ohLWn0Lxv/BNrrSvl6GD3B10KSDLFvmsX/XLMc0rXyWj1
         +4HOcO1MmwX60NlWge0ODgoudFyO+MruDwP08R0Q9tUoyzuQEbd69HLT2Z1xLuqWV82v
         Ay+ns3fnnJLVsD+QtNBLbgmfK3h4GaH4FftyQ7A36wShqonpixEmJag2vaI0SekTVplG
         s1f+bBCVZoEDj/irAv4O+88SbSEaRPziW7YjQu3GWfAHdZtdpK2swtTqgzTXm6XruvL/
         Z/GE+DSNYtZrtpUxfVFo+LyjZBu9dY9v/zTJC+WlfFGatZnOvoTS/ypBM18mteSXYRR4
         TD5g==
X-Gm-Message-State: ACrzQf0SYx0qZI53dxPX1tVdm+ADgL/34ckaA9AxixXWSGo7jpWsebrT
        W1C5ob1/QzXrAsIqnhYL6hHqiBiCL+5Hjw==
X-Google-Smtp-Source: AMsMyM56parTGPzYXo4akywRQ6u65OHFE9X+uLTwfWeu5dgHDdv8V/T6iAE+1WSWBDjx3ynABiT92g==
X-Received: by 2002:a4a:5e47:0:b0:476:2f9e:b30e with SMTP id h68-20020a4a5e47000000b004762f9eb30emr8552325oob.46.1664841770463;
        Mon, 03 Oct 2022 17:02:50 -0700 (PDT)
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com. [209.85.160.41])
        by smtp.gmail.com with ESMTPSA id bx21-20020a056830601500b0065689e13f52sm2666365otb.71.2022.10.03.17.02.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Oct 2022 17:02:49 -0700 (PDT)
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-131dda37dddso13828800fac.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Oct 2022 17:02:49 -0700 (PDT)
X-Received: by 2002:a05:6870:c0c9:b0:127:c4df:5b50 with SMTP id
 e9-20020a056870c0c900b00127c4df5b50mr6593752oad.126.1664841769263; Mon, 03
 Oct 2022 17:02:49 -0700 (PDT)
MIME-Version: 1.0
References: <202210010938.3922D4DCE@keescook>
In-Reply-To: <202210010938.3922D4DCE@keescook>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 3 Oct 2022 17:02:33 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjwvBc3VQMNtUVUrMBVoMPSPu26OuatZ_+1gZ2m-PmmRA@mail.gmail.com>
Message-ID: <CAHk-=wjwvBc3VQMNtUVUrMBVoMPSPu26OuatZ_+1gZ2m-PmmRA@mail.gmail.com>
Subject: Re: [GIT PULL] execve updates for v6.1-rc1
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        alpha <linux-alpha@vger.kernel.org>
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

On Sat, Oct 1, 2022 at 9:40 AM Kees Cook <keescook@chromium.org> wrote:
>
> Please pull these execve updates for v6.1-rc1. This removes a.out
> support globally; it has been disabled for a while now.

Pulled.

And I think some of the alpha side could be cleaned up a bit further,
in that I think this ends up making the osf_readv/writev system calls
be the exact same as the standard readv/writev, since the legacy OSF/1
hackery is now gone with CONFIG_OSF4_COMPAT being a thing of the past.

But it's not a big deal - cc'ing linux-alpha just in case somebody
feels inspired.

               Linus
