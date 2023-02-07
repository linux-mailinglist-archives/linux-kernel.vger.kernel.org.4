Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4815D68D255
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 10:15:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231345AbjBGJPI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 04:15:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231395AbjBGJPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 04:15:06 -0500
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF94B36476
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 01:15:05 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id a1so17707846ybj.9
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 01:15:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=q8jBVuw64zr+++4naEUhmf8QMT+GB68ff/CcL3gGnDk=;
        b=NWlZW+1yt6Dn6Z2iU3Hm59DGjYhkWJYoHVsD+bAUodoF+FaamRhb/AUYydjendGFUO
         ZHKaeU/1EyJcdLHBaadRpFCxZ2Mggbg80NX1tmi6vzsFaO5zwCM7mCrnZHD1JjG/B1r6
         bqgOqg5D+H353oCu3RcqkPZoZEW6YxwfCJ2ziCAgsa0Nj8BoVkX3BkjuDW5U3EsvGJGc
         YEXIIqREmxLzUU5hPd15s1Be2EFNFSRdEbfsY9L22U7rW6vMeWywFpRVFwE1lOGXzqVm
         521qqGp8mnebLHZkaK+OaMgMCGH+r1nOx78Vg1Z1qLaLpwShT7tjF+k01pdc0Lk5DwOk
         vncQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q8jBVuw64zr+++4naEUhmf8QMT+GB68ff/CcL3gGnDk=;
        b=eiKghWEoVGYlADdxilYUMc0hcRRLI5yTm3/R2H0zRtBPswVHm6JC4/v2ZtCaDAgiQW
         7FVEE3loCx69kQnjlPf9P3IeG2OPkaaINaUKZmChrMPgsTT/ILXY1ASMvXISoo4Exc13
         FYaCgUAYJpy4/Etrqajz9nQ0XAXv+bvTNY8r5mtlGyHpcGOSBo1rQ9I4fu6vozKxXb5q
         C+fHwsCsS37peGt2aQe1y/TgQ8eTBXC1oKscrc+1rrgNXcvW4w2SSBgvF+JL22FAXjmt
         1U7mJc1/s1lsGlWsW252rXIv35FIS4HnWanvDCSrjemULygvefdh2NQOgZc0+tLQQ100
         zixg==
X-Gm-Message-State: AO0yUKUNTF2YKScs4LskZ/xeU4pLQxyzBUf5MTQuUsTZ8ZzO5gu/rCT1
        dTHICcJyxOiW42D8CWX+ceZnV1X2dHD3qw1pq8omxQgm/SpVJA==
X-Google-Smtp-Source: AK7set+yZ7oot/nLJBhp936PRtnytfQjFAtinpDu6O4RQZtagOF92fdcaz69150IfHZum63k6nVKWxw2gVVw1WaXgSQ=
X-Received: by 2002:a5b:6c5:0:b0:88f:946:bd98 with SMTP id r5-20020a5b06c5000000b0088f0946bd98mr323446ybq.24.1675761305145;
 Tue, 07 Feb 2023 01:15:05 -0800 (PST)
MIME-Version: 1.0
References: <20230206141558.20916-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230206141558.20916-1-andriy.shevchenko@linux.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 7 Feb 2023 10:14:53 +0100
Message-ID: <CACRpkda+5s3X-g5C=42m3Xh-A=mpR-2hLasht6bMT89L9XBJQg@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] pinctrl: intel: Restore the pins that used to be
 in Direct IRQ mode
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy@kernel.org>,
        Jim Minter <jimminter@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 6, 2023 at 3:16 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> If the firmware mangled the register contents too much,
> check the saved value for the Direct IRQ mode. If it
> matches, we will restore the pin state.
>
> Reported-by: Jim Minter <jimminter@microsoft.com>
> Fixes: 6989ea4881c8 ("pinctrl: intel: Save and restore pins in "direct IRQ" mode")
> Tested-by: Jim Minter <jimminter@microsoft.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Patch applied for fixes.

Yours,
Linus Walleij
