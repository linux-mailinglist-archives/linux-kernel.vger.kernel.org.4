Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68A466DAEEC
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 16:43:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233807AbjDGOns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 10:43:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230135AbjDGOnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 10:43:46 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB860FA
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 07:43:44 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id t4so37246923wra.7
        for <linux-kernel@vger.kernel.org>; Fri, 07 Apr 2023 07:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680878623; x=1683470623;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4y2vTh12wvHzVyTsbfEPBX95l9liSSCPzdmz8EpwIAM=;
        b=eSTzTJ++Yr5AonzNMm+PKZMNKh16H4wNG7Ja5V0Ey6dXViJfAmNx0uYvLC8A02nU0V
         IAgy2aaJbf1xHJcAiUwH2CQro/YQ63kjjrtHy99bXymQpSsTnIx85+HBj/vp9SK+eupn
         AfYunddRcSirOyouplefXDaeIFs5B24J25LmnVp0KaNdMNxjj+qAxxkn5jF/MPcC12w2
         cwnQC2Kfl3Xfo31oBRuk63pDPyDKSKZvRNREKeI60k2+T7hfm5W8xnOx3K9GRCVzT3Sh
         H06QWq3pPtYiWZp1gtZGCAOPw98w6xhV6v6Gyp489I+1TxKEUUKrQvH47I80XipQQHLU
         fhDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680878623; x=1683470623;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4y2vTh12wvHzVyTsbfEPBX95l9liSSCPzdmz8EpwIAM=;
        b=BoJh/0QjeInlcc2NDPqcYtDJncsjRN4DmhLmjoKiO9v/oQRGBywyYCRb8dM+XrVO77
         ug82Mvz8gsYyv/wycTLjBmHSqhm6xAfNnxUy+toRGsS0UhFINa4JBD0xBFlt1Tm+pNsk
         +Zeq7Kkaq5drEZ6tfJlVc9Hw8bKlrZRPNDDNAO0gdah6zkFB11LEH3zmWKaM2jXUDVxh
         UAjDSeW/MBksvlMEtznJbGIL7M5Nn6jgsTNGY13XbGePkR7rj7XMX64rX5bgF4Uvkl7j
         2Zzr3mZNUKQR+Y5/Ub97HRnhj0qn3Gqa8bih0gor8pYUibn3VSO3CEHwunUOq5LxnH2n
         x7yg==
X-Gm-Message-State: AAQBX9fL9i3xss8W2BxKL9/d1mvZ0rFSmPHzIqhQHOUWvKGH/6uBGhIA
        RtxRI1H95PiwtSRLSzjZQEQYbQ==
X-Google-Smtp-Source: AKy350YbOhKCjXDaonDjuR5CDVgiwS6hEPL+WFj/oy38rfc3QnZkRYr/w/jNMogzEGRVQ7B2fLHzHA==
X-Received: by 2002:a5d:508a:0:b0:2ef:afd5:5e0f with SMTP id a10-20020a5d508a000000b002efafd55e0fmr1332009wrt.56.1680878623397;
        Fri, 07 Apr 2023 07:43:43 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id y10-20020adfdf0a000000b002efb121b75fsm1678082wrl.58.2023.04.07.07.43.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 07:43:43 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
To:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kelvin Zhang <kelvin.zhang@amlogic.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>
In-Reply-To: <20230407102704.1055152-1-kelvin.zhang@amlogic.com>
References: <20230407102704.1055152-1-kelvin.zhang@amlogic.com>
Subject: Re: [PATCH] dt-bindings: arm: amlogic: add C3 bindings
Message-Id: <168087862262.952906.1621259082439192676.b4-ty@linaro.org>
Date:   Fri, 07 Apr 2023 16:43:42 +0200
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

On Fri, 07 Apr 2023 18:27:04 +0800, Kelvin Zhang wrote:
> Document the new C3 SoC/board device tree bindings.
> 
> C3 is an advanced edge AI processor designed for smart IP camera
> applications, which does not belong to Meson series.
> 
> Therefore, modify the title field accordingly.
> 
> [...]

Thanks, Applied to https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git (v6.5/arm64-dt)

[1/1] dt-bindings: arm: amlogic: add C3 bindings
      https://git.kernel.org/amlogic/c/b2255e4195ea509b51c33b7a182e764c37901129

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

