Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 219B26FA118
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 09:32:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233452AbjEHHc1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 03:32:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233441AbjEHHcT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 03:32:19 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A89A11E9B3
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 00:32:10 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-50b37f3e664so7608321a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 00:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683531129; x=1686123129;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uVwziNhIELnrU+msU0cBqkd5hQoILFKtwmATbaq5QLA=;
        b=EYF+5tkUKxgkjCSY5WCaTpcQMRTq1sqsxay0yL9Du4kthI/wyGl/WAM9N4yiUh1H0Z
         r0eXZ9Y/4C9asr/mZRm7eZJ0STqFHTC0LQjfbDeH9IWDNufBoG7DHIH/l/UBhJX//1gT
         IQly3Pahxthg49j3/bKzdJtKgkNvFO64sNk2RhWiaoFVuSgCNijEU8sI2E0OyEr/C8UJ
         GY1GnE2ebX/1DVTdVTwYMdFc7dcV2ZBhlmjtSkIuv+8alFtmnwIBnkCCfB42t4sM/cfB
         H+gyM8wVUzw+x2NOBHrZpGgddT38coyC3OqLSjV+AykRVOJK8o6wheOlSFCxD9+UxjdB
         WIjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683531129; x=1686123129;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uVwziNhIELnrU+msU0cBqkd5hQoILFKtwmATbaq5QLA=;
        b=PFY3n9Hl4ea775vKJxaAoKB72UjpnRYL4gfQKPi0NuXm47Fu6EwjnhQ89hKP5O8dc1
         zh+2qBOOu8396ms0dF+AsMfM9bgqU06INafeNa1SkmAG+g+kSKw+ZgTJ3i4WXnRHuWUu
         jcu4Du1jRWjpXsU06Y3H5eYLzOOo3nK9ogO7Zm0VbsqWOrjBehJH2m5ocEZMMnBRwpgR
         kYQoN7QlKf0EiLxRI8K8wlSV4JvXpTDrz2SJNxYCdZnY/j8rbYJ8hXnbqeEfQjXR4qx/
         HUpV6e1KGj+S9tIXLZQourRP2hlBZrLRulcLiXBETkLkaF+IC8+zHLYfRpd9BW0wLhIH
         xvwA==
X-Gm-Message-State: AC+VfDz6eSSuKqWVRDjR6h8MM1bBzPEjSeMSNSlYGN2AlkQrk1Q1SHox
        7/RqVM/EEb3xFl/BJbDS3KwNNQ==
X-Google-Smtp-Source: ACHHUZ6qm8w6e7V9hkRXe1GUsKJWnoFAYhj2cejiwFkjKzXzUZrfMpDmzfA8q55ifm5Z/O9EE2+qKQ==
X-Received: by 2002:a17:907:94c3:b0:947:4481:105b with SMTP id dn3-20020a17090794c300b009474481105bmr7226148ejc.3.1683531129062;
        Mon, 08 May 2023 00:32:09 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:50e0:ebdf:b755:b300])
        by smtp.gmail.com with ESMTPSA id jz27-20020a17090775fb00b00932fa67b48fsm4594535ejc.183.2023.05.08.00.32.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 00:32:08 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Shunqian Zheng <zhengsq@rock-chips.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Luca Weiss <luca@z3ntu.xyz>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: dt-bindings: ov2685: Correct data-lanes attribute
Date:   Mon,  8 May 2023 09:32:02 +0200
Message-Id: <168353111984.70771.6252965278692799714.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230419-ov2685-dtschema-fixup-v1-1-c850a34b3a26@z3ntu.xyz>
References: <20230419-ov2685-dtschema-fixup-v1-1-c850a34b3a26@z3ntu.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 19 Apr 2023 17:58:27 +0200, Luca Weiss wrote:
> When adapting the original doc conversion to support 2 lanes, minItems
> should've been added as well since the sensor supports either 1 or 2
> lanes. Add minItems to make the validation happy again.
> 
> 

Applied, thanks!

[1/1] media: dt-bindings: ov2685: Correct data-lanes attribute
      https://git.kernel.org/krzk/linux-dt/c/048bce15da19e46ce5e866a48338929c76ca4152

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
