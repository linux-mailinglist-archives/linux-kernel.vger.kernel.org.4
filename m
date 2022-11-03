Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03A846178EF
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 09:41:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbiKCIlq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 04:41:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbiKCIlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 04:41:44 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D62EBF68
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 01:41:42 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id v1so1516683wrt.11
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 01:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W9DytQ1lu/QgUtGO9mzgm9cxKNspCA3RpOmraCTiE/0=;
        b=ihPXTyZfARlzx3zOeMgnhgDEhAPFQtxt1dh/8v6xYYs43Ecge13lHiGYkcUjZQKcJS
         CDeRGSDlcKyd1uI4AgO4P9gq3fZ3SNRCBMA2TZEjJCqLXcDv3MEcWmJuVrulMa6b5HEX
         lLQREkxj4BSVnbxmqIM5YHhXNpnGBG4egcSsybFwYgGBRhk+DlrVgFNqvq5gFelw5SD9
         qSkT5x7/PLTP4wbL4yQeez8JMxmUKGGMYlwV5pVthv+ut4P9xGSsBH0w+iOW887dPP7U
         vNUeeAqjOO0oBRa0HY2IYYnyPbzoJrVrNA6CAb4/6oSszx5tjSuroRv8mOQwks2K5bt3
         8wLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W9DytQ1lu/QgUtGO9mzgm9cxKNspCA3RpOmraCTiE/0=;
        b=cyj70XRrwQs2DFtP1uIXAt08hz+Sz/dgqsLEXMX77MEMLMkL5pVZgwkpX+Hj42owVO
         VT/aEClsLi3BLDZMuQOq+3oQ4g4oAb6shXnLUanRLTbnvJe1lmRPGRwAzcEuVIb90VFf
         RtkynS1GjdFS0zJFXsHBo92xj/zB9UCOlMPkTJgO2+i/P+MhbS2e6Qq7xPTkH1tMRGtN
         JWF5+e2HKWKyTGMo5sbB6hm2dIknyJJzLyWA3WJ7jQg5gqAJLgwNjaEInTXJtpNBQ9Xr
         Qbz60BIFrG24RCQUJ8xA4RcOke/sFf8cv9ATV9xEIKASJ9nQ2VxVvoosSt78OpZ6DrvV
         kbcQ==
X-Gm-Message-State: ACrzQf26zVovOeqkipYltrVnOOW/6QXwMVPM4ampCtDRspQJPdaWa6qs
        ++i34oDdmq2Tn7FnMs/oBbYRXQ==
X-Google-Smtp-Source: AMsMyM7hD2iS4TPUK2fXFcCk74ymN/Esmn+RsmRn2QjdiPKVFaUKmnE6zQeDBpcdQb0f/AtWUQ4wSA==
X-Received: by 2002:adf:eb51:0:b0:236:cfcc:76e4 with SMTP id u17-20020adfeb51000000b00236cfcc76e4mr12571984wrn.291.1667464901174;
        Thu, 03 Nov 2022 01:41:41 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id c19-20020a05600c0a5300b003c21ba7d7d6sm504178wmq.44.2022.11.03.01.41.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 01:41:40 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     patches@lists.linux.dev, dri-devel@lists.freedesktop.org,
        Kees Cook <keescook@chromium.org>, llvm@lists.linux.dev,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>
In-Reply-To: <20221102155242.1927166-1-nathan@kernel.org>
References: <20221102155242.1927166-1-nathan@kernel.org>
Subject: Re: [PATCH] drm/meson: Fix return type of meson_encoder_cvbs_mode_valid()
Message-Id: <166746490033.1047451.8509801800691914580.b4-ty@linaro.org>
Date:   Thu, 03 Nov 2022 09:41:40 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 2 Nov 2022 08:52:42 -0700, Nathan Chancellor wrote:
> With clang's kernel control flow integrity (kCFI, CONFIG_CFI_CLANG),
> indirect call targets are validated against the expected function
> pointer prototype to make sure the call target is valid to help mitigate
> ROP attacks. If they are not identical, there is a failure at run time,
> which manifests as either a kernel panic or thread getting killed. A
> proposed warning in clang aims to catch these at compile time, which
> reveals:
> 
> [...]

Thanks, Applied to https://anongit.freedesktop.org/git/drm/drm-misc.git (drm-misc-next)

[1/1] drm/meson: Fix return type of meson_encoder_cvbs_mode_valid()
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=6c4e4d35203301906afb53c6d1e1302d4c793c05

-- 
Neil
