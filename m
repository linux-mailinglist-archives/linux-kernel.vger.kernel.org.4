Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AED10729286
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 10:17:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240151AbjFIIR3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 04:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240131AbjFIIR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 04:17:27 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A02A2269A
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 01:16:54 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2b1a7e31dcaso15774861fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 01:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686298610; x=1688890610;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sbn/vidH7Q/LymlGmJYhGt3pz85OqWNGAZA4SRnTzBo=;
        b=fK9Ln5svpVf7phjZS+mbqw7W8KLEUddvL82nQQBDjWef1EMHZyKJu5uSv0ylG497DS
         77MDbGVz1ZJvyDJZ9TjECpi9s94vl0lFXkz6ecpCvDqgEUjDl/Upf0uiqbB0dWBChzOu
         2ermRRb2EaSeuuAPz/RLtXhUUHu/O2eSGWzGcv6WqHiMuopaSxz2F5WTcJwHAEb+DXn/
         xxURipHrESsmhHsJzbs8DTZxRnWA3ZeVb5Qx+rYMdnWqgWiCg8xCvdhSe1neH97i0MBQ
         RTQRbC4I5/z9CibtNsSEzrWYEodFJ6Bb14j8xKSNI/Bo4vQX9JayOrs9SIFG4f8LVI20
         qQJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686298610; x=1688890610;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sbn/vidH7Q/LymlGmJYhGt3pz85OqWNGAZA4SRnTzBo=;
        b=F9d/a2A/0QktPYG39jg9NzX7S2OuofUBhWpx5bxdsO6L6+jBv5VbKX1ZoAoHc57nw0
         LIB+DBG/w4zlhv8w87nIYOEkTc3VnRPWsZR8tICpTqXPHO6hAqDJJO3t1dovxwVrpKbH
         ++vKxhK9k6+LR0EA1CSGe1xhi+m3/yKWQHyrkW4nK4NhynNKTzYW+9vNTRMny36yoz5c
         mdhEG3OFT7x3wPT7lF8uftP1ztD9LQsRXiuNSfYeD7a+7IfHkiwfdw+agH4wGo0hg9EX
         ZWS3K1RYwbni1h779vDQEH6JXRjrLDqMxGBgMuVJX4k3C+hmUe7tn/NDweUgEzJqw608
         OAkw==
X-Gm-Message-State: AC+VfDwiaEIbRMg5h4LDy9PiehloN6tJfC+jCsUxymIG9KTMzY30oXBf
        iv+8G7JHviYC8ixC7wtKVB0wYw==
X-Google-Smtp-Source: ACHHUZ72gjhpE6xfNIyCw1g194Gn1jxiJKWv4N13KPXnSFqysK5VlWgjRHhNj6J11ET014zr7Acx1Q==
X-Received: by 2002:a19:4f52:0:b0:4f4:eeb4:ba70 with SMTP id a18-20020a194f52000000b004f4eeb4ba70mr424776lfk.32.1686298610392;
        Fri, 09 Jun 2023 01:16:50 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id m6-20020adfdc46000000b0030e5bd253aasm3768435wrj.39.2023.06.09.01.16.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 01:16:49 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        Xianwei Zhao <xianwei.zhao@amlogic.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
In-Reply-To: <20230510091129.151669-1-xianwei.zhao@amlogic.com>
References: <20230510091129.151669-1-xianwei.zhao@amlogic.com>
Subject: Re: [PATCH V4] arm64: dts: add support for C3 based Amlogic AW409
Message-Id: <168629860953.1192110.7115363386706217680.b4-ty@linaro.org>
Date:   Fri, 09 Jun 2023 10:16:49 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 10 May 2023 17:11:29 +0800, Xianwei Zhao wrote:
> Amlogic C3 is an advanced edge AI processor designed for smart IP camera
> applications.
> 
> Add basic support for the C3 based Amlogic AW409 board, which describes
> the following components: CPU, GIC, IRQ, Timer, UART. It's capable of
> booting up into the serial console.
> 
> [...]

Thanks, Applied to https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git (v6.5/arm64-dt)

[1/1] arm64: dts: add support for C3 based Amlogic AW409
      https://git.kernel.org/amlogic/c/02310be6f080071e1b9e2021fd6dd655bd842aad

These changes has been applied on the intermediate git tree [1].

The v6.5/arm64-dt branch will then be sent via a formal Pull Request to the Linux SoC maintainers
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

