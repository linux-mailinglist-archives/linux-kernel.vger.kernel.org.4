Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 409D9611AA9
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 21:10:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbiJ1TKj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 15:10:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiJ1TKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 15:10:37 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61F7F578B6
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 12:10:35 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id o28so1421992qkl.4
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 12:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ovE5YzrgrqjUaqk1z5SrG916L1YKgz031z7kIQxrJ8o=;
        b=A6FvUYZMIbmkWpQQWCDpM5Ci38l0NzF+kXhGSvNAuNLlgQ3mgBvtotnvA/Jc+vFtTG
         r28VWYRwpy3/taPygrXuHFWdADnLNSukjmoj7UIr3zVBLuKkx5eoUt4HwQD6yM+GauPL
         jfY3M0u41BZtxwEC4GEsJCUr4Z7u7hCJwy6cE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ovE5YzrgrqjUaqk1z5SrG916L1YKgz031z7kIQxrJ8o=;
        b=VAAZ+DS6cvAMQZnkzs3usLsysMNsd1zxhZSrGJi+aHrxYJPYkv+hxhaSKDgjAa0QYx
         Yanusw3k/jyscd+f52HmfZQYOKigYw4uIqGfJ2nty0W3ltOA+VO1nWAfpIUG5K78/yfX
         DrSreQII8alsAk2Dc3L/yzz/jISkZkiRnkTV0tewK2kwMsi2TlhSh9s24K1nTRjtFj5E
         HPYGxco3q5YUxN8Org1PQtlSASVBmQhTGB5VxggKBki7eiIB/sn2lwJE/KSOhwRp6dVS
         VLcHSJWEsvb0XQxs2SIxkv6VCtQggYSQLXaBCxleD1mlfGIFAIAtOdEpABWkUIGE7wfQ
         71mA==
X-Gm-Message-State: ACrzQf0SYi30zIZz9m8Eexj6CvFj3Flm1ieabY2WQtd8JsJDAopHCP05
        qj8wTR+cIw3aUwlalRqxhePXYjA+kdCJYw==
X-Google-Smtp-Source: AMsMyM6ToRi6/85wHhQsJYedd+HjBbqvi/btDiuc+aEYMdIJ3l01rRWtdWeY2y5ECaiPkaizwY6MeQ==
X-Received: by 2002:a05:620a:4606:b0:6ee:e73b:aecb with SMTP id br6-20020a05620a460600b006eee73baecbmr544309qkb.681.1666984234330;
        Fri, 28 Oct 2022 12:10:34 -0700 (PDT)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com. [209.85.128.172])
        by smtp.gmail.com with ESMTPSA id j66-20020a37b945000000b006f87d28ea3asm3393075qkf.54.2022.10.28.12.10.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Oct 2022 12:10:32 -0700 (PDT)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-3691e040abaso55700307b3.9
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 12:10:32 -0700 (PDT)
X-Received: by 2002:a81:1902:0:b0:36b:2578:f6e2 with SMTP id
 2-20020a811902000000b0036b2578f6e2mr930931ywz.352.1666984232488; Fri, 28 Oct
 2022 12:10:32 -0700 (PDT)
MIME-Version: 1.0
References: <Y1wHlSE0S5QZ+QCI@shell.armlinux.org.uk> <E1ooSWP-000FDy-5t@rmk-PC.armlinux.org.uk>
 <CAHk-=wi63Sw3vNJ86gzg1Tdr=_xGwGyj+mH-eT0UgaAfGAHX+A@mail.gmail.com>
 <Y1wVTkIZjoMVfxOK@shell.armlinux.org.uk> <CAHk-=wh75aOWvaEhYsAcCJSRzhy8MO_SdvDzB6zmvVs+FeAr6w@mail.gmail.com>
In-Reply-To: <CAHk-=wh75aOWvaEhYsAcCJSRzhy8MO_SdvDzB6zmvVs+FeAr6w@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 28 Oct 2022 12:10:16 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi5Ud30Od-=buKvrvinemR7uVuTUkbKqCGu_ySZPjLVfA@mail.gmail.com>
Message-ID: <CAHk-=wi5Ud30Od-=buKvrvinemR7uVuTUkbKqCGu_ySZPjLVfA@mail.gmail.com>
Subject: Re: [PATCH 1/5] ARM: findbit: document ARMv5 bit offset calculation
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Yury Norov <yury.norov@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org
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

On Fri, Oct 28, 2022 at 12:01 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> In contrast, the arm code doesn't do the "min()" at all, and if there
> are bits after the bitmap (in a partial byte), it will just return
> those bits.

No, I did misread the code. It returns 'size' for the no bits case,
and the 'movlo r0, r1'; does the right thing for the "bits past the
end" case too.

I guess I need to get better at reading arm asm.

                Linus
