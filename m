Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5733E6C61FF
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 09:39:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbjCWIje (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 04:39:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231431AbjCWIjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 04:39:05 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5241637B70;
        Thu, 23 Mar 2023 01:37:45 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id cy23so83076166edb.12;
        Thu, 23 Mar 2023 01:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679560663;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GICzYJuZSuUCn45nyDLfAR5+CyYyPzlWvW+cK0yjdzI=;
        b=KRcs8iOTSBhpkt1U6EnEyD9Pis2zwpbUeq0uwMGjT64pEACMv+iymWc2EeZX6g2Mea
         z9P7FeQP8snjTAG7v5FbSzHMvs4pJBvGz9lLkgxKqqU2na+XpqYZYa+meP1QhrQLMVa/
         t6NcZenr1DSxF1sOAZuq66bn5GGqFVUIECGS/8zeAh66te7NqsH5W3qg+0IpVfq55zsb
         VFXTsXdza5b6N67qsctLvx/IdspoAp6zkwdQc2VFTu24lCbiJ2fPOCioF/KBn9N3IR5V
         SStp8WFPn4fBVtzuoojmTlFd5kSa3nyCi4EcHz3I7CgjHFZ+DQOMeK+0tKdsagmfdxn1
         N0gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679560663;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GICzYJuZSuUCn45nyDLfAR5+CyYyPzlWvW+cK0yjdzI=;
        b=7Sj1XTvFAWgBixGLGgmp0UaYdP4uozR/waz1VCHHeNakuOHrpHxW3AjVj+XzogDqGa
         tDmLG99g2YcRjjg52HsTaJ2XCFfnvmb+oE7PFk1U0aZnf/551P9u5ME0cYP0LZ5L+N27
         D04bu4UmzrQFEX1lYtpREFymldxrRYzvPAr3n5ouuj+C0MWNv2wRzoNfc4yM3KAJ8b7C
         2N+VE74ghtz5Ce3RXEHugA9zVdnuU2xUfdPvg5jsY1ZWFzJ9Hn7fFkww/8N6zN8xkOiF
         pCILXbOUss5CUeSsWVL4+ggDlWpGOmGqPt8lWzj0spPmd+n6Dq0RXeU4T/OP5uWRcUrx
         1s8A==
X-Gm-Message-State: AO0yUKXUpnC4ii25F81TBakYMuntcuunMhinwlQWBzUmwl1+yT+djnyx
        s2IMg9oEIUAehmOXkDJ7DO3qHclv7yk=
X-Google-Smtp-Source: AK7set9UmJMactIFDbD2WL6H1MiyAvI7uQW4ru8+mTPBcqpuoICJeSD6GGusyyZxR9/1cFHaJGcrFQ==
X-Received: by 2002:a17:906:868f:b0:8f1:937c:f450 with SMTP id g15-20020a170906868f00b008f1937cf450mr8839212ejx.13.1679560663557;
        Thu, 23 Mar 2023 01:37:43 -0700 (PDT)
Received: from localhost (p200300e41f1c0800f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f1c:800:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id h27-20020a17090634db00b00933f31034f2sm5571281ejb.38.2023.03.23.01.37.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 01:37:43 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     linux-tegra@vger.kernel.org,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH] arm64: dts: tegra: drop serial clock-names and reset-names
Date:   Thu, 23 Mar 2023 09:37:42 +0100
Message-Id: <167956063896.504776.1342558454400507763.b4-ty@nvidia.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230123151543.369724-1-krzysztof.kozlowski@linaro.org>
References: <20230123151543.369724-1-krzysztof.kozlowski@linaro.org>
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

On Mon, 23 Jan 2023 16:15:43 +0100, Krzysztof Kozlowski wrote:
> The serial node does not use clock-names and reset-names:
> 
>   tegra234-sim-vdk.dtb: serial@3100000: Unevaluated properties are not allowed ('clock-names', 'reset-names' were unexpected)
> 
> 

Applied, thanks!

[1/1] arm64: dts: tegra: drop serial clock-names and reset-names
      (no commit info)

Best regards,
-- 
Thierry Reding <treding@nvidia.com>
