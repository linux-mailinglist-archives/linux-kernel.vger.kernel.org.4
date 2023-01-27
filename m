Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9828067E09E
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 10:47:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233266AbjA0JrN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 04:47:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233237AbjA0JrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 04:47:09 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95EEB80F80
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 01:47:07 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id fl24so3035474wmb.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 01:47:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HBIolSlZ00EwbeKxt9JEN283WvP67aZfjKFSntuEpWw=;
        b=xMM3VO5T4P9E5qmtfMQrKqowljMqE0Jig9p/WmIy4oAW57OtbhDCzr8n609LTLRNy0
         cOshi6gndyzzlBXqNxcQfSDUFY+FUZSwA8OcjF75kXZhNkebj5sKgtpFB67J93/PREOs
         sy1bj5rnxVDft0eBeGjUKnZw80BbzhZbayy42A9oVtZZLbT4uF7GlM+nG+YbZaaLgR+b
         PJsjHvZnPzQY1nFg/4P/FtBGPo1AocKQebCaZ489TXYAFoCcQLE0bQLu9NoCSda+JH7d
         IYByK4kK/7Vl1P/ClvNfGS8uoKay3tcWtCioD4gKX6cOWlHJlpb2P02X++OTefMDCO8X
         OYyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HBIolSlZ00EwbeKxt9JEN283WvP67aZfjKFSntuEpWw=;
        b=wUUiwWKczBrCj4ieVjH+99HfCsrzcYLkrKeaLGHL8tPnxYWgpqH1v7pTV44v7GFNfn
         ntvE7hU8WO7dao2RM0MgXOrf68Gx0JdORKB+LocntrKBcF8sEqWL1q4eINBFBrSmRwq0
         dp4EG++MPO67GpjmK8M+V8rmEeUKo/4G0Uu5KtGUrKr7+vpHAZoiuwfKymJJfVSXLe46
         gzuQ82/qaHDZ8i6ML7VrKB8dnPDEr8qmwPL6AOzVw3qMn2d5Hyz7Bi4FoOh9DJoAgLVe
         4laaE1BVGeZsIz4cSCqoXnyVtUONOiL7hUfKEGWhI9aDEHxp15ve+eXjjabjUs6oY1yJ
         TQDw==
X-Gm-Message-State: AFqh2kod0uUJiOx/9LX27jarYUPqr0IPHK7YKh+7kTJW6uSbdZ9sNXfP
        tuqiODOBKVXjMDoA/DCwLVmpiUKmRMVFvvGx
X-Google-Smtp-Source: AMrXdXvcM3Kdm6orrizc223QRtb+ndLyWOi5p5goOkVMJ8rcN3PCm+DMGrz4qGmvIoz+j+5byc8Aag==
X-Received: by 2002:a05:600c:a4d:b0:3db:1d6:16f7 with SMTP id c13-20020a05600c0a4d00b003db01d616f7mr36374561wmq.23.1674812825815;
        Fri, 27 Jan 2023 01:47:05 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id h20-20020a05600c351400b003dc1300eab0sm8042087wmq.33.2023.01.27.01.47.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 01:47:05 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jisheng Zhang <jszhang@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH] ARM: dts: berlin: align UART node name with bindings
Date:   Fri, 27 Jan 2023 10:46:58 +0100
Message-Id: <167481277325.62929.11022928494197799320.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230123151539.369654-1-krzysztof.kozlowski@linaro.org>
References: <20230123151539.369654-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Jan 2023 16:15:39 +0100, Krzysztof Kozlowski wrote:
> Bindings expect UART/serial node names to be "serial".
> 
> 

Applied, thanks!

Let me know if anyone preferred to take it via sub-arch/SoC maintainer tree.
I'll drop it then.

[1/1] ARM: dts: berlin: align UART node name with bindings
      https://git.kernel.org/krzk/linux-dt/c/2ba4ff82f9dd312fb9f77168f159698c93f4841b

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
