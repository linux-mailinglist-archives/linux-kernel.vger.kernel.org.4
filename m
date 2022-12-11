Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CFD2649531
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Dec 2022 18:14:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230337AbiLKROu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Dec 2022 12:14:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbiLKROq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Dec 2022 12:14:46 -0500
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [217.70.178.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 671CDE0A5;
        Sun, 11 Dec 2022 09:14:45 -0800 (PST)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id DBE9F100004;
        Sun, 11 Dec 2022 17:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1670778883;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rBDims/zkL1hUiQmCOcc4chEh7a5Jbi2KbYlhUI9MIA=;
        b=memQZf3frHdebnPRjVSe3lRVg/+Xk4rIjKElSq13xvse53ZNtO8mDkF2YZchgSv54YkNFJ
        09cWmF4OoJldYEJRZyL8fBi46G481IgIVUcueJuvQuKB9aKJ8hgdKUphgZ3+XtEM8AAyJn
        mLTPkWCk5wdZWKQkJujdDrfFXM7+uyWaGReB7S55b+lMihH33KxXz0p01blA8zw7ZjZ5VM
        bRR4V4+FpwWvU+ETs71IX9iAPE276ODJgiqDKI5OmDtbVUx7XCWjfzdEyUF8dICds7PsSW
        Q0DElObMBQXu3FDWNJqruvUwpxqWVQVKTGarZVM0oeSr8Pyt1rS0OKNGeYdD6A==
Date:   Sun, 11 Dec 2022 18:14:41 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Kees Cook <keescook@chromium.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     linux-hardening@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>,
        Romain Perier <romain.perier@gmail.com>, llvm@lists.linux.dev,
        Tom Rix <trix@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Daniel Palmer <daniel@thingy.jp>, linux-rtc@vger.kernel.org
Subject: Re: [PATCH v2] rtc: msc313: Fix function prototype mismatch in
 msc313_rtc_probe()
Message-ID: <167077884687.347026.2422549159298910618.b4-ty@bootlin.com>
References: <20221202184525.gonna.423-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221202184525.gonna.423-kees@kernel.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Dec 2022 10:45:30 -0800, Kees Cook wrote:
> With clang's kernel control flow integrity (kCFI, CONFIG_CFI_CLANG),
> indirect call targets are validated against the expected function
> pointer prototype to make sure the call target is valid to help mitigate
> ROP attacks. If they are not identical, there is a failure at run time,
> which manifests as either a kernel panic or thread getting killed.
> 
> msc313_rtc_probe() was passing clk_disable_unprepare() directly, which
> did not have matching prototypes for devm_add_action_or_reset()'s
> callback argument. Refactor to use devm_clk_get_enabled() instead.
> 
> [...]

Applied, thanks!

[1/1] rtc: msc313: Fix function prototype mismatch in msc313_rtc_probe()
      commit: 21b8a1dd56a163825e5749b303858fb902ebf198

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
