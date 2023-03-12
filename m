Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0893D6B68BD
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 18:21:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbjCLRVd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 13:21:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbjCLRV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 13:21:29 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D69C3401E
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 10:21:28 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id r15so12659541edq.11
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 10:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678641687;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QTA6R2LrBiJ7VAOX3AvoCmGBilAuWFgDh0TJKfRWgzA=;
        b=lKZQp7g0zaeYPn0svLome8SlJfWqQ+YDihmJBT/5iVfCeiFF0wA+ukX+0PsyjhlrFT
         imv3w2P2I3JeDuKgKBso4JBcrTOxbOPtSDCZI0FgJ0ZIA3YkdsiOwpTQMZMlSQY55XDu
         MrT/5+gkhq1Ub+KnEm4PS4Geihbwt1rVSueEwC8vcfsjZOifLKclV82Htjp6C5+kzbDe
         c/2Cw6/z7dUFWERsS3kKHmpxC22yWmtlKj/EJmyuOlIcrLPDMuuyZul+Wv7wvyUvqobc
         UBYicdEunu7hENy5JwkEtSynFzASD3GatDPZqK2fq1Zr/3elGKE+XHAzgDWEfv8IE06Z
         5RvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678641687;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QTA6R2LrBiJ7VAOX3AvoCmGBilAuWFgDh0TJKfRWgzA=;
        b=c5C4GyRYfqyXUCGTIUGYVaZgjhtOs643W9jdIVa+mjXUkkH7n1iPI8cYv9jBJu7La8
         sJ+R7CZmB+Rh22d4AXI6tEbWFPKj12NkjlEUNtvRlpAGkM6rMn3JY8yZInOQ3K2LPOZI
         /o9YoPxh+aIPVZnxgMUGz3JGssrhzD8Uqw5lUBoFBIfsyojZVza4/YT+wVhdMe6fnzLI
         JMHWnR9Hlbxmb4NTzCzd+Ai7UWG/R9VDvv47zCYk/UWVaKHgQBd5zQxdpzSngr9ILc7W
         xB5M8UE3rKZpTN48+2N4Zt18hbNRYMm7c/ASTtAC1wd3aTkbmvOzJfKPW/msEXtCbrsL
         6XcQ==
X-Gm-Message-State: AO0yUKVG5jXsfXf4Jz+c0IhM0Ot3WdaNLxBtlptxc+Kfv/XYFS+4wxrS
        VRVffBSHxB8dX8L3/Jha40TvodbcXM+vGKdNKjE=
X-Google-Smtp-Source: AK7set+WgFT6cviQ7gs5OYFQ/+65x65tbHbZel/BjUFKSgbRM5oByMGyDFSIgs0QylHSnnh1vLgu3Q==
X-Received: by 2002:a17:906:6ad1:b0:8eb:27de:240e with SMTP id q17-20020a1709066ad100b008eb27de240emr32394996ejs.13.1678641686900;
        Sun, 12 Mar 2023 10:21:26 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:d9f6:3e61:beeb:295a])
        by smtp.gmail.com with ESMTPSA id y13-20020a50ce0d000000b004fa380a14e7sm2055395edi.77.2023.03.12.10.21.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 10:21:26 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Wei Xu <xuwei5@hisilicon.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: hisilicon: use "okay" for status
Date:   Sun, 12 Mar 2023 18:21:20 +0100
Message-Id: <167864162129.395859.5462304450333936857.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230127101834.93818-1-krzysztof.kozlowski@linaro.org>
References: <20230127101834.93818-1-krzysztof.kozlowski@linaro.org>
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

On Fri, 27 Jan 2023 11:18:34 +0100, Krzysztof Kozlowski wrote:
> "okay" over "ok" is preferred for status property.
> 
> 

Applied, thanks!
(Patch was waiting for quite a long on the lists, let me know if anyone wants
to pick it up instead)

[1/1] ARM: dts: hisilicon: use "okay" for status
      https://git.kernel.org/krzk/linux-dt/c/aff750faa5ac699df7ade5a31b6ba52ab1072d8a

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
