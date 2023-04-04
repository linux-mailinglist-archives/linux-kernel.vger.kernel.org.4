Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 001BF6D6304
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 15:34:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235204AbjDDNeQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 09:34:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235164AbjDDNeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 09:34:06 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6015140F8;
        Tue,  4 Apr 2023 06:33:32 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id w9so130690388edc.3;
        Tue, 04 Apr 2023 06:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680615201;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C5+woa08wseMH5MjO97pGr3JdhcbzGoi59ia9RFN3Ww=;
        b=FlZuNVXlvaoC5Wv+YnY2RdnLtndu9KzSwF8WyPljhxojtngb7HOXQEcT41x3o5Wiui
         4GcmqNxHMZ8NJ+easmKxOFdeZAy6Eagixzw/BeoDtozWcL2EnTURRezAevbLOsxdq++I
         w0+WXL1Q9Lh3tuMRCA98gyQiBzFPJq8HryHf4AmbJ6gUqr5ZVVtIqRxuNQK/U/s78KFU
         ffm9vrLAHt8oXRYLQNZa2Xi/VlJKlR6mXXN+RrVBRc8EDFFQjIxa5sq4iFqi4coRsbof
         PCeVZJwhZquMM8lKYrJUtUP1u/D4M+dbonlDEFnZH7qcOU0zG9IWntx+4ghzk3uAd+je
         W7rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680615201;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C5+woa08wseMH5MjO97pGr3JdhcbzGoi59ia9RFN3Ww=;
        b=o+icekbfX+kFP6PmCZHHVOkTJcpwJxepoo3z9b+Wr7o5lHEVXP7DdmXo7xGSdrJndQ
         gzClysVCA/Tsz1PXAZi3Ng3k3TUihAzeLlZwPBAJc3qkq34EPwD20TdlL2m//lYbYDPm
         /PeoUVmIO+dVdEIIEgv3ZoAN+xDMPhSSiPQvs53P45jnLLuepDxkKjH4vLPH017WNPMx
         yzQjpqJ27yTJFmHZpkKziNTOLNjSddbJVRhgJ8toWWsIx0uZFGiu5sRtzR2rQ3tZ9wRW
         LSHKmPgqIxJDGUotguhQ43MDnL/scPPLJvZvgiOzlT01MFwqYkMsx2b/mURGx131Kpji
         3XEw==
X-Gm-Message-State: AAQBX9c0vAkGyrVoSUb7pGcS6/K7HBc28SdWNef9cOa+5Q0RQz44GgdT
        aaX8loEzPSvoDCEbn4saBwE=
X-Google-Smtp-Source: AKy350ZdIonRRf6XX/HAyEe71VdG9jRXAAxqNYES+G+X07dyc3Y0uCX/rKruNGsa+tDIkjpFj816dg==
X-Received: by 2002:a17:906:1281:b0:947:405a:955f with SMTP id k1-20020a170906128100b00947405a955fmr2308182ejb.31.1680615200865;
        Tue, 04 Apr 2023 06:33:20 -0700 (PDT)
Received: from localhost (p200300e41f1c0800f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f1c:800:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id g1-20020a170906394100b00933356c681esm5979689eje.150.2023.04.04.06.33.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 06:33:20 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: arm: nvidia: Drop unneeded quotes
Date:   Tue,  4 Apr 2023 15:33:16 +0200
Message-Id: <168061516878.2141244.14923745008184055839.b4-ty@nvidia.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230331182159.1900674-1-robh@kernel.org>
References: <20230331182159.1900674-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

On Fri, 31 Mar 2023 13:21:59 -0500, Rob Herring wrote:
> Cleanup bindings dropping unneeded quotes. Once all these are fixed,
> checking for this can be enabled in yamllint.
> 
> 

Applied, thanks!

[1/1] dt-bindings: arm: nvidia: Drop unneeded quotes
      commit: c94673e80377d67ba36ee4059d7814b2ab98fa71

Best regards,
-- 
Thierry Reding <treding@nvidia.com>
