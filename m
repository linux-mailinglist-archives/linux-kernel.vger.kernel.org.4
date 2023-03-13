Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81FC46B6FB1
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 07:56:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbjCMG4B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 02:56:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjCMGz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 02:55:59 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0A354D616
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 23:55:58 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id r15so17216523edq.11
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 23:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678690557;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=68t53gvmnckd79R+6Q5eQlJvYe/ZNkZDBgwKVccmvF0=;
        b=UEHgBCYWBOs6Rv4dAAPfTOlQMu+oI9b93bsaN47eXaUSTR6Py2Cuf9jrdO+fqpUVoM
         roobCo4q3efl0lFOvvpL9XHBE8veEK6STx1EMiLA8UGZf4UUAgUo1xnn/UxFjjznuccZ
         fnjUETyC0sY0NUP6dO6vaU+m8wtBTG/Qnc+qjOvX2+z4s/mxWgQ3NN9z2g36I3/ZoN4N
         EBPdCTpZ/voeM0Vc+eddsG3r5FYtBOlUyXCkMZUIq/q/vVfGQYlpNTKFaZh/IGVcrH3R
         qeiLSxOLpiIBHxL0Kbra+fW2Wkk8SxF+Jr9891juoaDZYKmRFCf8fxLyKvJRrc9lgLwq
         bjaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678690557;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=68t53gvmnckd79R+6Q5eQlJvYe/ZNkZDBgwKVccmvF0=;
        b=FLGysCXsK7D15blLHOIjuRaS3hIWTZOYwEBTz3NKHU/QuvX8Y/AC5DcgpswGlIR337
         0GOB7MlylBSHASg/+KROgZ6L2wMnJMmjMTyn/6OloVDYSjzb/EINyVk34trT7fjNExO/
         Sn3YioHZX1ytHPtdEFWVBw3ihshA2qypN7B9c8vaUHn7p7M4Vs8YgFrDNJn4mTWKpuUn
         abekrBVwYZBzlfHrpHEJkv1zIL3fCiPijzCssQkwcbMwxN/5KyVGS/kEO/rqtZ/rk5jr
         KEKoMrS8mHgbVfldpZDTJtpB/E/UI1dF77nzKQDbGU+FV6vLJ0kNReQjgl6ywjh+F1No
         93cQ==
X-Gm-Message-State: AO0yUKXasHgddTp8+6/mYaYtwoy6Q+8V3ruSo9JXBmT2XxbVSfuUQ9JQ
        k6szpir3R7G6dpEvpOn6LIpa8Q==
X-Google-Smtp-Source: AK7set8/5t4r0ELJPYB0lTz5b6ulPt7gDq65c4aNksBLofkqZkr2GA3EnQ5yKTY3bKV6UhHke5RMGA==
X-Received: by 2002:a05:6402:654:b0:49e:1f0e:e209 with SMTP id u20-20020a056402065400b0049e1f0ee209mr11393039edx.10.1678690557308;
        Sun, 12 Mar 2023 23:55:57 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:f052:f15:3f90:fcb3])
        by smtp.gmail.com with ESMTPSA id hd31-20020a170907969f00b008ce5b426d77sm3116873ejc.13.2023.03.12.23.55.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 23:55:57 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Russell King <linux@armlinux.org.uk>,
        Rob Herring <robh@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH] ARM: exynos: Use of_property_read_bool() for boolean properties
Date:   Mon, 13 Mar 2023 07:55:55 +0100
Message-Id: <167869055285.8213.17268784442522016058.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230310144655.1540655-1-robh@kernel.org>
References: <20230310144655.1540655-1-robh@kernel.org>
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

On Fri, 10 Mar 2023 08:46:54 -0600, Rob Herring wrote:
> It is preferred to use typed property access functions (i.e.
> of_property_read_<type> functions) rather than low-level
> of_get_property/of_find_property functions for reading properties.
> Convert reading boolean properties to to of_property_read_bool().
> 
> 

Applied, thanks!

[1/1] ARM: exynos: Use of_property_read_bool() for boolean properties
      https://git.kernel.org/krzk/linux/c/2b8ed0c89f5dc7af756473651deb1be1770d2136

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
