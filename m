Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 249CC6CB8AA
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 09:51:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbjC1Hut (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 03:50:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232144AbjC1Huq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 03:50:46 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2504D420A
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 00:50:13 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id u11-20020a05600c19cb00b003edcc414997so6731342wmq.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 00:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679989809;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SChvSSb/SRcsLKxwF2svsDucGRCoUm07182sZYmBoNM=;
        b=oj5Mdf2jkdk5NhG/RmJvDPSKUWbt8I4xdd/RR3JnfnBFAx3J54bf7VzK2Y3pw0NswH
         rU5AYkv8jYtKHoTGF3ySrsJHBEf2OpbTlflgeXDOexiD2gH456ytvZ9C6TBZlmxtIkyH
         7l+lh7abddcsUUj2tryK4rGg06QVfcOk9TvygRKfMXOX6IIGfhYPTCp9Cu7J6o1EBd4e
         040ae/MRjkjLB6ZxeUbVt7a0inP8xsoesHZIuRqbHc0LAYNeQzNEFNZlJ/UdpfdUzmBl
         dVVCbbNSwl9L1TbrGRFc6ithCohZzunH7YAy+fK+7R3yffRNmYq47+FyhBD4OCLRqWQ9
         UFyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679989809;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SChvSSb/SRcsLKxwF2svsDucGRCoUm07182sZYmBoNM=;
        b=ADP2aDpCvm2sBrIIGIN/3fejcWb1kMF0UbOXZw9YcfxchtpG7iVH+iaeGLx8kKB+CD
         fo1oCWRZlLetTFvDEHW8OsdXTp2Ka3DsftrY9r0LEv0QpFNH2Zsq3CZlKXaBy4nQCTkJ
         lnM74boyPgAPT65E5snrBm10uSv0LByS7ZPJMZ5Zgeg9ODN98XKeKzbR5PF26nvFu6yD
         d3BlzACCsraUIiwc4/GiifvT23psLcdKQDd+qv75olQ6ZntBQuDsVm0YtPclT0UAO08/
         V0zHz/clvc7HhlyJS54jccihABSbb55R1md5b9XdyjUjo4AJHtAP/SBLZWtqbrzg50mA
         DNOw==
X-Gm-Message-State: AO0yUKVfypbsjb0Z/5pgwZBzz/8WG9niSDpt2BGNQxfhyFln1NaEsAHh
        OVdbOnIBn/Jgfwm43J0TWIawI/Fhdu0v1m+4KZbZt1Jn
X-Google-Smtp-Source: AK7set/L/mW1tAj1qo5ca5xnWMQ4csh1yJ7NP0m5e6IY+5PLNs11lRdHsi5Y6cgsmIrZinxOjMKR6g==
X-Received: by 2002:a05:600c:22d4:b0:3ed:b56c:9496 with SMTP id 20-20020a05600c22d400b003edb56c9496mr11274673wmg.31.1679989809280;
        Tue, 28 Mar 2023 00:50:09 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id w2-20020a5d6802000000b002cfe687fc7asm26827310wru.67.2023.03.28.00.50.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 00:50:08 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230327170222.4107746-1-robh@kernel.org>
References: <20230327170222.4107746-1-robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: soc: amlogic: Drop unneeded quotes
Message-Id: <167998980857.903588.15028659186028325608.b4-ty@linaro.org>
Date:   Tue, 28 Mar 2023 09:50:08 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.1
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 27 Mar 2023 12:02:22 -0500, Rob Herring wrote:
> Cleanup bindings dropping unneeded quotes. Once all these are fixed,
> checking for this can be enabled in yamllint.
> 
> 

Thanks, Applied to https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git (v6.4/drivers)

[1/1] dt-bindings: soc: amlogic: Drop unneeded quotes
      https://git.kernel.org/amlogic/c/1b61fdfdd656b3940cff24c25c211777389174b0

These changes has been applied on the intermediate git tree [1].

The v6.4/drivers branch will then be sent via a formal Pull Request to the Linux SoC maintainers
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

