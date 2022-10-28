Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A5666118E2
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 19:08:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231267AbiJ1RIY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 13:08:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231187AbiJ1RIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 13:08:05 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5091123081C
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 10:05:54 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id bb5so3828390qtb.11
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 10:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=o1wP8XSqyxONpYZllhjBchmhfCHPdbS+n9nGRAQYAjo=;
        b=hrq4vT5E4EBa1mZNQHXa8qMQaRdiK+9TB9sDEbGIbXqTGJK7w/Q/AbwqBwRFTTaLWu
         3FOBwfpiugo55xPkhPmNoMgsFo4ZHKCaQlX8NhoXJnWdWWMdazNZ47iVGoRiM5WULYam
         IRQ/0cUfTpQO0nAWE0ADtOGAQVMikHbaJagdw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o1wP8XSqyxONpYZllhjBchmhfCHPdbS+n9nGRAQYAjo=;
        b=7kW0fj67eaMLD9aO+3DO649+7hZomciY9lwIXyvzWriyJwWtwCR+hjqc9ymL97fACy
         aHTIweZejHRmHtaAwEN9QHqsJHyAisP2IWiGdIKa6xZXpxRMjjss8MSgiqpvT8vNgsun
         4en7M7u0sddzfN0vU889h8l2zmd2yfdP4O2jFE5xomkvsg2WkHTU9vYw3FulPEOQxI33
         LWEa3e1ZTf4Z+nNlOn5DEYjiEbkt9ZGLf9RGwO60FGIExOeNHhK4OGe6eGm6UsdUXzrM
         ZQd8WjQYxjXv2lFx9FXwDAzTSsGRaK0Sg5OGPPjSvTC+FXOnCsKM4eQaPVdAWtJCyt3t
         40iA==
X-Gm-Message-State: ACrzQf0DKzqPiXmVnzR4AZbLd1HPVZxcEqO/vMBP9NFBSD0wnz1W2oIn
        m/+okKr0nelkJ6uCRu/kvFtEmV6jc1XJzA==
X-Google-Smtp-Source: AMsMyM5BslORVkf2W22GI9BAJhqjzhnl+djT3hbzW+jCYcXvbK1q/7dAKO7uxNY2WBMZg35GvyC7nQ==
X-Received: by 2002:ac8:59cb:0:b0:39a:dbc7:2424 with SMTP id f11-20020ac859cb000000b0039adbc72424mr421562qtf.304.1666976747829;
        Fri, 28 Oct 2022 10:05:47 -0700 (PDT)
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com. [209.85.219.174])
        by smtp.gmail.com with ESMTPSA id x29-20020a05620a0b5d00b006b615cd8c13sm3193081qkg.106.2022.10.28.10.05.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Oct 2022 10:05:47 -0700 (PDT)
Received: by mail-yb1-f174.google.com with SMTP id n130so6786282yba.10
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 10:05:46 -0700 (PDT)
X-Received: by 2002:a25:bb44:0:b0:6bb:a336:7762 with SMTP id
 b4-20020a25bb44000000b006bba3367762mr172576ybk.501.1666976745431; Fri, 28 Oct
 2022 10:05:45 -0700 (PDT)
MIME-Version: 1.0
References: <Y1wHlSE0S5QZ+QCI@shell.armlinux.org.uk> <E1ooSWP-000FDy-5t@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1ooSWP-000FDy-5t@rmk-PC.armlinux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 28 Oct 2022 10:05:29 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi63Sw3vNJ86gzg1Tdr=_xGwGyj+mH-eT0UgaAfGAHX+A@mail.gmail.com>
Message-ID: <CAHk-=wi63Sw3vNJ86gzg1Tdr=_xGwGyj+mH-eT0UgaAfGAHX+A@mail.gmail.com>
Subject: Re: [PATCH 1/5] ARM: findbit: document ARMv5 bit offset calculation
To:     "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
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

On Fri, Oct 28, 2022 at 9:47 AM Russell King (Oracle)
<rmk+kernel@armlinux.org.uk> wrote:
>
> Document the ARMv5 bit offset calculation code.

Hmm. Don't the generic bitop functions end up using this? We do have a
comment in the code that says

 * On ARMv5 and above, the gcc built-ins may rely on the clz instruction
 * and produce optimal inlined code in all cases. On ARMv7 it is even
 * better by also using the rbit instruction.

but that 'may' makes me wonder...

IOW, what is it in the hand-written code that doesn't get done by the
generic code these days?

                     Linus
