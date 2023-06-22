Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B92217398BF
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 09:58:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230474AbjFVH6i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 03:58:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230453AbjFVH6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 03:58:33 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 866031FEA
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 00:58:06 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2b455855fb2so94585441fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 00:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687420679; x=1690012679;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eoH4TBC0JXa4HF+16J32SMlFEUZb3HDAGDzfvr+ddQI=;
        b=Cqk7bC+rMdN6LWVm4P1WxZhVVsQ1i+A2OBJpHjrP0dcYZ9kttyL616l4E4STIgjc8X
         sGq0F336C1y2Q0ixgy9e+Pk4UXNuUMEEaPURL6qo8R+6CuI/kbqVjfPq+/s0DG6xlktM
         sWsNr5G9uC6tzDfjhpDHt3XWtQ8pIt0tlRnATo5VLg1OUdV02xxhdVulbzeXc9G95Gki
         YI5kh4+wBKF2F36x0SASlSO6FGmHuRuz5UveUuuC8qL1c2DPGFkqaPX9DmPi40UYb+86
         HOw0qIcMPNzf1h1eYf4E9Ie7rrjwe+1F/5PAS7+FAIQLG/Dt+VTGHsqEir1KbsHsvq/b
         of3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687420679; x=1690012679;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eoH4TBC0JXa4HF+16J32SMlFEUZb3HDAGDzfvr+ddQI=;
        b=luQTTKWyD4KfAIa2kj5i7WMG7jU88RCmML4kDtTjkvkXSR7F1fzRe9hLwm9tYDFXx8
         9hYyjLRvQJxiTXJhqWYcrC3lD7QjdHNPlMpFakPjVWFZNUZ51fHJQdcLRJXdNlzLM/4y
         SlUOjEUej+QRYvN2XFDKqzvfkBbx9ln+L0AlB5aN4zFxaP5JXlXmZP/NcG5K0Ha4QpAv
         QCEhVeUN52Eop1R9F6XDUnQ5tcaqjGna+eOXpcM2oTuQTFHb19fDHbwWjOWsvuYEn9dV
         jN38f2kGCdaBUCv12zPFhs6jFxA6fkKLQB9nCgslEweevWjCp+DZDez2RVEVu7nr7zYb
         Qsng==
X-Gm-Message-State: AC+VfDxk4kxGGl5SzfgT9CAh6mrcsVPAFt8zNPcoMWm3G0rDfpcoePQ1
        oiMUFgTdsqByMVmCIQs1QPj75w==
X-Google-Smtp-Source: ACHHUZ5UXqIo89zYUy4OGRb5+TvhvC+o+5R16dzg4IwyRN20Eiakd5XgdOMmN2DFgAkviZpRz1d8ug==
X-Received: by 2002:a2e:90d2:0:b0:2b5:80c9:126d with SMTP id o18-20020a2e90d2000000b002b580c9126dmr4225985ljg.46.1687420679046;
        Thu, 22 Jun 2023 00:57:59 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id u23-20020a05600c00d700b003f78fd2cf5esm7000683wmm.40.2023.06.22.00.57.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 00:57:58 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
To:     Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>
Cc:     "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <38f87b22-d9a8-b8d8-ba7b-a2c2d7311b04@gmail.com>
References: <38f87b22-d9a8-b8d8-ba7b-a2c2d7311b04@gmail.com>
Subject: Re: [PATCH resend] MAINTAINERS: add PHY-related files to Amlogic
 SoC file list
Message-Id: <168742067824.2178283.2801774863315651148.b4-ty@linaro.org>
Date:   Thu, 22 Jun 2023 09:57:58 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 15 Jan 2023 15:26:05 +0100, Heiner Kallweit wrote:
> Add PHY-related files to the Amlogic SoC file list.
> 
> 

Thanks, Applied to https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git (v6.5/drivers)

[1/1] MAINTAINERS: add PHY-related files to Amlogic SoC file list
      https://git.kernel.org/amlogic/c/9e70e49474bb37ba8f43336d8a775d503b20aebc

These changes has been applied on the intermediate git tree [1].

The v6.5/drivers branch will then be sent via a formal Pull Request to the Linux SoC maintainers
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

