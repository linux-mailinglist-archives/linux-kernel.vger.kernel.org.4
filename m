Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52F4A6012AF
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 17:25:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231376AbiJQPZX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 11:25:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbiJQPZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 11:25:20 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FB2531EFC
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 08:25:15 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id j16so19014464wrh.5
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 08:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VZYVsksDtqwMhKI9pLO96NsNwXlR/Zc6fECSUWcfYvM=;
        b=loV8pcQ0VH7CSJZBQKJNUBD5gUGjphK138G2Vr0pUFl2hnQjhDNQsmcxOUMHVjZdNS
         kp6rLFoXEEZlMKcL018jlO+y3l2Mrp4Jhboi4EwUkUsib0YhBEusEvf31v2voSd90j+x
         RYCnGy22RpUw88J+/P4j1A3vSyzTwga/FtH7lyNU6PFMxuzP0uh72hQArEJhDcPYUk75
         g/QrFG7tmLmllRJWp+2XmsxP1vTIZnVcRfYFlA2ohe9A9yslYIZj8ov0iOUjBcQBm2Fk
         s3j+P9ur4/2ZezPhxzHUzydUoBxp+6dkJf7E9SAzCDI90tNzZBsNH759pk976J2xfQlq
         Tvzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VZYVsksDtqwMhKI9pLO96NsNwXlR/Zc6fECSUWcfYvM=;
        b=kM1v+PksuyE9ZBafZDD8W+I618L1/QKcCkIHoIu6pz87n1h9XYkF5R2rRMdMzcW/nh
         bi1g+fSUkbJfW+bZy86N/iRtNhPZ1viP7knP3As64oTYYN0MMPXb4BD2B14+xJZIlUaa
         8uQ42I1aG8QAplby/5BA9oSYMwjPB1gT70G//iVe3Fxqh573w63pFjP4oLmvVkJO7G+6
         Fm7y7lnSWMoec5RaGlWA+jXHFOw8/Tyna0SIY6nxOtvhmsl6IAMT/nhn24NkEi2MletW
         CQsi5ge7whbFY4jfOgymg6G1naFDCkNrJbEqgjDrDh90GCTa6Zix6JlxdN4iDCroeQXI
         ElfA==
X-Gm-Message-State: ACrzQf235KFAxyYSl61uYzAfgrTWCyH5imJgx3Io6V1hE9/TKbAKtjL1
        9LePXmjtJh3C6yanT4zh3Gldng==
X-Google-Smtp-Source: AMsMyM77wWshVlky9KSI5+U5hfTIhi0l0mEFqE4J649NfP0lv0covsJc7zie3crYcrA5ylJ0MK860A==
X-Received: by 2002:adf:fc10:0:b0:22e:55e5:9bb5 with SMTP id i16-20020adffc10000000b0022e55e59bb5mr6540090wrr.112.1666020313851;
        Mon, 17 Oct 2022 08:25:13 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id g2-20020a05600c000200b003c5571c27a1sm12894977wmc.32.2022.10.17.08.25.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 08:25:13 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-amlogic@lists.infradead.org,
        Kevin Hilman <khilman@baylibre.com>
In-Reply-To: <20221012185234.never.936-kees@kernel.org>
References: <20221012185234.never.936-kees@kernel.org>
Subject: Re: [PATCH] firmware: meson_sm: Fix memcpy vs iomem type warnings
Message-Id: <166602031304.3572695.12870664862275915316.b4-ty@linaro.org>
Date:   Mon, 17 Oct 2022 17:25:13 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 12 Oct 2022 11:53:16 -0700, Kees Cook wrote:
> Use memcpy_{toio,fromio}() instead of memcpy(). Silences warnings from
> Sparse:
> 
> drivers/firmware/meson/meson_sm.c:170:17: warning: incorrect type in argument 1 (different address spaces)
> drivers/firmware/meson/meson_sm.c:170:17:    expected void const *
> drivers/firmware/meson/meson_sm.c:170:17:    got void [noderef] __iomem *sm_shmem_out_base
> drivers/firmware/meson/meson_sm.c:170:17: warning: incorrect type in argument 2 (different address spaces)
> drivers/firmware/meson/meson_sm.c:170:17:    expected void const *
> drivers/firmware/meson/meson_sm.c:170:17:    got void [noderef] __iomem *sm_shmem_out_base
> drivers/firmware/meson/meson_sm.c:206:9: warning: incorrect type in argument 1 (different address spaces)
> drivers/firmware/meson/meson_sm.c:206:9:    expected void const *
> drivers/firmware/meson/meson_sm.c:206:9:    got void [noderef] __iomem *sm_shmem_in_base
> drivers/firmware/meson/meson_sm.c:206:9: warning: incorrect type in argument 1 (different address spaces)
> drivers/firmware/meson/meson_sm.c:206:9:    expected void const *
> drivers/firmware/meson/meson_sm.c:206:9:    got void [noderef] __iomem *sm_shmem_in_base
> drivers/firmware/meson/meson_sm.c:206:9: warning: incorrect type in argument 1 (different address spaces)
> drivers/firmware/meson/meson_sm.c:206:9:    expected void const *
> drivers/firmware/meson/meson_sm.c:206:9:    got void [noderef] __iomem *sm_shmem_in_base
> drivers/firmware/meson/meson_sm.c:206:9: warning: incorrect type in argument 1 (different address spaces)
> drivers/firmware/meson/meson_sm.c:206:9:    expected void *
> drivers/firmware/meson/meson_sm.c:206:9:    got void [noderef] __iomem *sm_shmem_in_base
> 
> [...]

Thanks, Applied to https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git (v6.2/drivers)

[1/1] firmware: meson_sm: Fix memcpy vs iomem type warnings
      https://git.kernel.org/amlogic/c/7dc69c7d073e6004a281db8f7f15cf6ebf702ea0

These changes has been applied on the intermediate git tree [1].

The v6.2/drivers branch will then be sent via a formal Pull Request to the Linux SoC maintainers
for inclusion in their intermediate git branches in order to be sent to Linus during
the next merge window, or sooner if it's a set of fixes.

In the cases of fixes, those will be merged in the current release candidate
kernel and as soon they appear on the Linux master branch they will be
backported to the previous Stable and Long-Stable kernels [2].

The intermediate git branches are merged daily in the linux-next tree [3],
people are encouraged testing these pre-release kernels and report issues on the
relevant mailing-lists.

If problems are discovered on those changes, please submit a signed-off-by revert
patch followed by a corrective changeset.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git
[2] https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
[3] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git

-- 
Neil
