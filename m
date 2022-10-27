Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDC2D6101F6
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 21:49:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236660AbiJ0Ttp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 15:49:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236019AbiJ0Ttm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 15:49:42 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBFD01A82B
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 12:49:40 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id z17so1887832qkj.8
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 12:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IZvmWLTFu1pJfxfIKPo4Qzw+QHUwqjXY5ckHaNck6Jc=;
        b=fTbxvhkB9Q+Fe33eN2TIiuiGsYcoayGZo/GVlgIPaPIi4E4PWHQg+tILioAu1pxy47
         SPB/HWIwL/rp1BPAalsZtvSEPPUlAgagvZZeBgnks/VLrKBeuDwVfjzxhCp8NrsMDPgH
         YqgIu238xCH5sedRqUOy5B71c+BZ22fWTQrb4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IZvmWLTFu1pJfxfIKPo4Qzw+QHUwqjXY5ckHaNck6Jc=;
        b=ql7S+Bv0CGtfQY6c9U6MeIurIQFvmo++M/XbQu1Gx8B+HlYSZzRwKMpPx6G9dm9YCV
         li9Y5qrGurjvzrbh1Ocgv+vlpA1RrO1Xl7XnuaDcBnuTABv8CBrvQRRnXryP/KNKSWkI
         9eyTEQ32z1Qjn7AMVDdqhp7/U8886PYkaSVv9KGv2FdA+FEyBEE9xdGM5tkGTTVGgM/w
         IWU8NNPuoOHfVE2um3YuAwgOMAbnjQ+Hz1XfswsA+uLrZlaVMZk7szifB9Jyebc619iY
         HoPcFUC1L+5QbneaxIV4WGJEH1bkpijSde1LjFCKcEuyjh0nIPC0tmCfC8ms6G6w4lvC
         02uw==
X-Gm-Message-State: ACrzQf3FQbsYBYVBrn7nYxO2aYcTp1YyCYXtAduNBQ7DNCpZbUGXnRbn
        MbsWDh3CEFPnmPr0ddRdoBZQF+xjb8DXVQ==
X-Google-Smtp-Source: AMsMyM4M2kvETrnvYfmMCDzqIjbIdK9NN04GkIaOzD4NmmsRtBncoyg+SucMEK6UYDnM01SZBIfE9A==
X-Received: by 2002:a05:620a:f8d:b0:6e8:4406:1c41 with SMTP id b13-20020a05620a0f8d00b006e844061c41mr36255683qkn.108.1666900179581;
        Thu, 27 Oct 2022 12:49:39 -0700 (PDT)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com. [209.85.128.176])
        by smtp.gmail.com with ESMTPSA id x29-20020a05620a0b5d00b006b615cd8c13sm1497716qkg.106.2022.10.27.12.49.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Oct 2022 12:49:39 -0700 (PDT)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-3691e040abaso26794057b3.9
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 12:49:38 -0700 (PDT)
X-Received: by 2002:a81:d34c:0:b0:349:1e37:ce4e with SMTP id
 d12-20020a81d34c000000b003491e37ce4emr45951805ywl.112.1666900178558; Thu, 27
 Oct 2022 12:49:38 -0700 (PDT)
MIME-Version: 1.0
References: <20221027165054.270676357@linuxfoundation.org> <8617f970-2a72-799b-530d-3a5bb07822a6@roeck-us.net>
 <Y1rbQqkdeliRrQPF@kroah.com> <20221027192744.GC11819@duo.ucw.cz>
In-Reply-To: <20221027192744.GC11819@duo.ucw.cz>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 27 Oct 2022 12:49:22 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgweH9GibJBzuEZNBGKbYPrs4NchT0YLuyxk1=N7gsWog@mail.gmail.com>
Message-ID: <CAHk-=wgweH9GibJBzuEZNBGKbYPrs4NchT0YLuyxk1=N7gsWog@mail.gmail.com>
Subject: Re: [PATCH 5.10 00/79] 5.10.151-rc1 review
To:     Pavel Machek <pavel@denx.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>, stable@vger.kernel.org,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net
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

On Thu, Oct 27, 2022 at 12:27 PM Pavel Machek <pavel@denx.de> wrote:
>
> Alternatively you can modify the caller to do /bin/sh /scripts/... so
> it does not need a +x bit...

Generally we should be doing both.

Make it have the proper +x bit to show clearly that it's an executable
script and have 'ls' and friends show it that way when people enable
colorization or whatever.

*And* make any Makefiles and tooling use an explicit "sh" or whatever
thing, because we've traditionally let people use tar-files and patch
to generate their trees, and various stupid tools exist and get it
wrong even when we get it right in our git tree.

So belt and suspenders.

But in this case, I think our tools already do the "run shell" part:

  Makefile:PAHOLE_FLAGS   = $(shell PAHOLE=$(PAHOLE)
$(srctree)/scripts/pahole-flags.sh)

no? And at least in my -git tree, it's already executable.

Maybe one of those "various stipid tools exists" is in the stable
tree. I didn't check.

           Linus
