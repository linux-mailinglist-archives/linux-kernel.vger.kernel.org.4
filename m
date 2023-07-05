Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E72F748B58
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 20:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232266AbjGESQw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 14:16:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231913AbjGESQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 14:16:48 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B6B11990
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 11:16:44 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2b69e6d324aso114499651fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 11:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1688581002; x=1691173002;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uOCzHF6TeZOh/T6LG7TLxf5MJTLpI91P/1ClVUmyuwg=;
        b=HAKsdikJQHsqyKeRIGJhLJiwa8//spEF0NN0KMtYh6ukbRubOaYXxa/fFUj5JweKmw
         uFtEORgU2gQJZh8Gw2TWSjwRM2zlohJPPdz0eDanZq8TPGKk5OrUEdwmCjNaD9FSFwxr
         7o3A6wZj+5iFHtb9IxlfqsuPZ+zx3tu4KvVok=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688581002; x=1691173002;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uOCzHF6TeZOh/T6LG7TLxf5MJTLpI91P/1ClVUmyuwg=;
        b=hJcc0fOQqvp9C6x+k23bFgkTWcxH12p03t92HwZ48GzIB9/lPOqIJaxAubCmIFROvn
         C4tRKeR+7DWAPbKGrdHv1vsSnKv53+rGaKf8Q6aJEm7XDdlFp5V8L38Bmu9GOUa2ts4x
         1Kbq+eJvCHx6tZk5MGdzRdlKGa9e4HREVj+WGx5PMRTzZ3qUDyezfqCUbpZLes0uJQ/j
         yiDyQWYxMdcBexZY3xO7NYx+lgRBjDof0Cm6gnIMfvnQXwXNleZFSX/LCrJGtGUEWUjU
         X4JP/c75TFGLmNt93uun/jWER35m0eD8l/30HBll1naL7CmOl7VaffT/nsuvI9TFQlkN
         iQxA==
X-Gm-Message-State: ABy/qLbmWRLK1NlSNJCtw2s43hSfFXYQwkCtKzkpgATYm1ouTHMEkr2r
        FQuyj3Q/WLWH5GWBRDnA5jOhmwvhdtgn2YnO6pbhtTOj
X-Google-Smtp-Source: APBJJlHAJGOd/8VFkqK6CsCJo0is5qk1hrMgFvkgnngB8zGLaAk6uafZKG3Ye2zz1i5vnYvVmCuY0w==
X-Received: by 2002:a2e:9dd0:0:b0:2b6:fc80:c45f with SMTP id x16-20020a2e9dd0000000b002b6fc80c45fmr2865426ljj.13.1688581001901;
        Wed, 05 Jul 2023 11:16:41 -0700 (PDT)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id i12-20020a170906850c00b00992f81122e1sm7071095ejx.21.2023.07.05.11.16.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jul 2023 11:16:41 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-51e29ede885so524032a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 11:16:41 -0700 (PDT)
X-Received: by 2002:aa7:d31a:0:b0:51d:d30c:f1e3 with SMTP id
 p26-20020aa7d31a000000b0051dd30cf1e3mr11388908edq.16.1688581001073; Wed, 05
 Jul 2023 11:16:41 -0700 (PDT)
MIME-Version: 1.0
References: <ZKUkQTLeDMNIyyK7@matsya>
In-Reply-To: <ZKUkQTLeDMNIyyK7@matsya>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 5 Jul 2023 11:16:24 -0700
X-Gmail-Original-Message-ID: <CAHk-=whPwD-7x=g9zR2xZ0=4EopwoJxaY=qX=T71vwWEcmaGWg@mail.gmail.com>
Message-ID: <CAHk-=whPwD-7x=g9zR2xZ0=4EopwoJxaY=qX=T71vwWEcmaGWg@mail.gmail.com>
Subject: Re: [GIT PULL]: Generic phy subsystem updates for v6.5-rc1
To:     Vinod Koul <vkoul@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
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

On Wed, 5 Jul 2023 at 01:05, Vinod Koul <vkoul@kernel.org> wrote:
>
> Hello Linus,
>
>  - New support:
>    - TI J784S4  gmii phy and SGMII support
>    - Rockchip RK3588 naneng combo phy
>    - Mediatek mt8195 hdmi phy
>    - Qualcomm UFS PHY for sa8775p, SM7150, PCI phy for SDX65
>    - Drop Thunder Bay eMMC PHY support
>
>  - Updates
>    - Further cleanup for Qualcomm phys and support for PCIe RC
>    - Xilinx zynqmp SGMII support
>    - Cadence Sierra PCIe + SGMII PHY multilink configuration
>    - Phy subsystem platform remove callback

Pretty much none of the explanations seem to be true. The Thunder Bay
changes happened the last merge window.  The alleged 8195 changes do
not seem to exist. The RK3588 changers are nowhere to be found.

And the sparx5 changes - that seem to be a noticeable part of this -
aren't mentioned.

I pulled, then unpulled.

                    Linus
