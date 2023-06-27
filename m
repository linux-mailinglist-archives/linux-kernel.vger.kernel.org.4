Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D99E67404F7
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 22:26:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231365AbjF0U0l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 16:26:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbjF0U0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 16:26:39 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D0581BD1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 13:26:38 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-98d34f1e54fso514171966b.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 13:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1687897597; x=1690489597;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZZrPHSDW5enXdUA/+h3OiDc6V9OxKvnH/ntjoCa20hE=;
        b=dUzODIT1UtxuXm3z346utCTVO3bXpuw3S5JXg3vp72+iJ09RnogGzOYqqhcfpxn0cn
         7N4lxn76UbcACEx+dQ18wxN2+mbl9oSdKp4bX+nNlE5pUJyO/mczTsW4rWSjF+XwnEGr
         9usdaMHfFDb/wFnZ4g9Mhh70Qm46u9jd/rAO4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687897597; x=1690489597;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZZrPHSDW5enXdUA/+h3OiDc6V9OxKvnH/ntjoCa20hE=;
        b=SUn5Yi+dZLfiVrAveBZCC2VpuQ/RnLKQtzzbIc5gMyM7YMhsyFdYMYgAMQFG02Qwig
         YPRPlQibLGpTzpgpblbs23fZMVq6M2WZV1L5vbr6HIykhSXBzy85//8BYrz583y4S4m8
         z2Ra5LedWkAP0HXjNEiq+6SX7YE970z/xqQa1XNpJ5/5ry1bXqK4JdttiX5iJhirrp80
         SgcEMidRlUC8DHB88PHkGa5iuZvl5WcLXhn55uvuOOjrdi+OtWJosb0nY0lmtV12G0p7
         P23yUBpqKDCZR2BRskBa+z9Q49B7naTw2+28PXe+C5pXCN3QMjJ/PY37cA68mhEoVTG7
         rnXg==
X-Gm-Message-State: AC+VfDzfS6iQR3dvzPTHyHnLWpeXZMTefgMfjUJfsirVL9Wz+Ey+CXCd
        VbElLyusaepCQPG5ZaQyuVb82/BKttmPFaznz0sgeGd2
X-Google-Smtp-Source: ACHHUZ7lL1Ew5dwmzrwzsbqkfJOOZrdIi4mXWq6sS826QVCXqOHOxl4rCVmODUZ/WLC7KKC0d2Dzkg==
X-Received: by 2002:a17:907:9303:b0:973:d06d:545f with SMTP id bu3-20020a170907930300b00973d06d545fmr24281064ejc.24.1687897596723;
        Tue, 27 Jun 2023 13:26:36 -0700 (PDT)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id o18-20020a170906289200b00982b204678fsm4893998ejd.207.2023.06.27.13.26.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jun 2023 13:26:35 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-51d5569e4d1so3849597a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 13:26:35 -0700 (PDT)
X-Received: by 2002:aa7:c743:0:b0:51d:9ddf:f0f3 with SMTP id
 c3-20020aa7c743000000b0051d9ddff0f3mr3243757eds.31.1687897595271; Tue, 27 Jun
 2023 13:26:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230627110038.GCZJrBVqu/4BfdyBeN@fat_crate.local> <CAHk-=wghuOwXtMH9u7RAW694BOwf_Q9TeWR2v=GgLy0gjTfu4A@mail.gmail.com>
In-Reply-To: <CAHk-=wghuOwXtMH9u7RAW694BOwf_Q9TeWR2v=GgLy0gjTfu4A@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 27 Jun 2023 13:26:18 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi9Uwo3-uwB4rT=wK2VKhGq3yEp_U-b2kruogCT=13Mjg@mail.gmail.com>
Message-ID: <CAHk-=wi9Uwo3-uwB4rT=wK2VKhGq3yEp_U-b2kruogCT=13Mjg@mail.gmail.com>
Subject: Re: [GIT PULL] x86/misc for 6.5
To:     Borislav Petkov <bp@alien8.de>,
        Noah Goldstein <goldstein.w.n@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Jun 2023 at 13:11, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Finally: did I already mention that this is completely untested?

Oh, this part is buggy:

+               asm("addq %1,%0\n\t"
+                   "adcq $0,%0"
+                   :"=r" (temp64): "r" (temp64_2));

and it needs to show that 'temp64' is an input too.

Dummy me.

The trivial fix is just to make the "=r" be a "+r".

In fact, I should have used "+r" inside update_csum_40b(), but at
least there I did add the proper input constraint, so that one isn't
actively buggy.

And again: I noticed this by looking at the patch one more time. No
actual *testing* has happened. It might still be buggy garbage even
with that "+r". It's just a bit *less* buggy garbage.

I will now go back to my cave and continue pulling stuff, I just had
to do something else for a while. Some people relax with a nice drink
by the pool, I relax by playing around with inline asm.

                Linus
