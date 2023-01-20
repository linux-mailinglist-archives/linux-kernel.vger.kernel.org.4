Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEAF7675296
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 11:34:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbjATKej (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 05:34:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbjATKei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 05:34:38 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C3BC73ED6
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 02:34:36 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id h16so4410398wrz.12
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 02:34:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7fX3mc+YjogrHVXWeOExgCkZ7irYgZc44evQFqB4yXo=;
        b=PQ+4/QX3edZkW5nktjCeiKQaqz0s9TS/A8qsSGn6w1OQ+ZVmrRriq8YMBak2Z54Ofr
         lLYZVDz9l1MSh5zzLN6BKLZCLIVhlu9jba7pKTEwmcBy2AFk+4km153z1vmeGyVdJkoQ
         b8yir85UiHur5T+tl1wLLzc5R2bcIGmIXRSZCTDWfQUanGseYXvSlroeLIfry8COw9y+
         2alAwGuL/wyfKUq3+qLgxF9fv8C+rsMH7cp1UUaRn07wTMP5/isxzsycrHUlir5cChZr
         cFBb+qrLZfuGEct1qoWmhMc3UwSwhCL2ZTjZ8d1gRFQArp0fGyp7GV7l5XyBTmo2D61Q
         Koiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7fX3mc+YjogrHVXWeOExgCkZ7irYgZc44evQFqB4yXo=;
        b=anApJcUrJKyuvZjAiPOJyXAJQ9bqjyKaunEDin/awlP5aKzKK9wlF0fnWHKYKFOhUT
         PPnRx1ZP5JrVu7cHy4nAn+aGmOK4MON7cPbasyiNpSIf8Mrj+Ua4xyXq2XK25LCZ93wW
         Fi5CyUR3gqX88twTibWH0xYNtNiNfTnlIeeeryfejQ4PoDxv0F5jd/dOd3csXufl6pi7
         +j8jWJAWGlJC8toRFCttlSUxK5b7br6xxVWpZHQxVKRZw/kg13k5LMGjGQNSVdk5fG7b
         aHHjxsxFUnHEGRCVnU7x7FA3GPyYMybcS9jGlvFnIndGU91JUNP1sCQ2jXMZVwIkIHjx
         9qrQ==
X-Gm-Message-State: AFqh2koGr1hBmz3HXxpy9LdALms5js+3ORsNFbF81l/b33OdSNmF/Uwd
        jeGJmQl40p6koB5d9n6wX9sHVA==
X-Google-Smtp-Source: AMrXdXuVVyvDKmq0gNU0v15CB00d8cMIgLXGZEAJOfCKktaVVtiDtnaGGFK6x9zyYYxgTjm3AZYaTA==
X-Received: by 2002:a05:6000:1085:b0:2be:4e3e:fa0f with SMTP id y5-20020a056000108500b002be4e3efa0fmr3966527wrw.71.1674210875141;
        Fri, 20 Jan 2023 02:34:35 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id a1-20020a5d4d41000000b002bdef155868sm16140191wru.106.2023.01.20.02.34.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 02:34:34 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230120072108.138598-1-krzysztof.kozlowski@linaro.org>
References: <20230120072108.138598-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] ARM: dts: meson8: align OPP table names with DT schema
Message-Id: <167421087432.1116851.7586477497533295504.b4-ty@linaro.org>
Date:   Fri, 20 Jan 2023 11:34:34 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.11.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 20 Jan 2023 08:21:08 +0100, Krzysztof Kozlowski wrote:
> DT schema expects names of operating points tables to match certain
> pattern:
> 
>   meson8-minix-neo-x8.dtb: gpu-opp-table: $nodename:0: 'gpu-opp-table' does not match '^opp-table(-[a-z0-9]+)?$'
> 
> 

Thanks, Applied to https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git (v6.3/arm-dt)

[1/1] ARM: dts: meson8: align OPP table names with DT schema
      https://git.kernel.org/amlogic/c/5f4416849f0e2909189263ab76a1dd533f597d72

These changes has been applied on the intermediate git tree [1].

The v6.3/arm-dt branch will then be sent via a formal Pull Request to the Linux SoC maintainers
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
