Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49F366FA2D4
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 11:01:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233343AbjEHJBd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 05:01:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233602AbjEHJAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 05:00:55 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C1F122725
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 02:00:34 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-9659e9bbff5so768132666b.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 02:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683536413; x=1686128413;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PBzioUPmPxWqOkTI6gwe94hiIYOth3djVQkKcgaJJpA=;
        b=ymGaXjTcqrqZoMVRQkQ04gJL1AHkZPPitqc4vcsmL/ha+FwwjIfcFM3DFC+Wq2bw/y
         7eb6+6xQmYsdGNpZCRb0LFi980txKsKV/unPFfH4uF98SYgMIO4MifSicgyTEbOoLiNZ
         iyhTefQR1/ldbuV4GnhLqtp4mJveVIZKydS7qtpq9bHfNgFklzzj/oD7piCvjhCkgaLg
         Wsx/xQrCgMrwxtxcdViTpkzjBBfu/yxcOXgGbrpRsZF4pr9M4j1LH6TTGB75byLS+Kwb
         fTNjWO70B69m54FyeTbphR/aq5qrYJWOlXpQUJZ8jrzubPjQw1X13limcPlCOWuJd6xX
         8qGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683536413; x=1686128413;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PBzioUPmPxWqOkTI6gwe94hiIYOth3djVQkKcgaJJpA=;
        b=ZPwNUfOexeXHcFc5qfKihVG9SncfZyGmNPzTqoqUP9UcdCc3L4ph2CGF+ajP89sABU
         6YC39cQIM4w2HISdzY+bbDRvM8lXD9AbWZa+UXw2bjFB5E5tkIDI6vLzHYry/AlbaSVU
         fuI5KuUJKZDhJbZlVxJOxiSIRuZjzYfITElh82oElonpETLLCS3efI/D5TkK5xxwgjnc
         ZnSdOL5Caf8ylsfc0RA885/nR2i9C9AtUXzQQsT30rDniDnX54h2F2n9lLq/uy+7W6AK
         C1vSU1RzqmBBH7mFSPAVNJ0KTK1hMRvVtJbzdMIiirwifnR0Gc87nMR9maVT2HxrKd0I
         y+cQ==
X-Gm-Message-State: AC+VfDxD0rGgsbJjdSZ8rJr6cVTZfizSIm4ywAAh4opHcAiBYn1v0S5A
        VgBr/UqA1kfG1B5ZQ3ZuL14UMg==
X-Google-Smtp-Source: ACHHUZ6Fj426vCUbioccDPAAlleFxGw5RQLbiaE0CVoWWeV1G1vSEI4G8XcRqc+GdlepxttZ4QqZcw==
X-Received: by 2002:a17:907:9482:b0:968:4d51:800b with SMTP id dm2-20020a170907948200b009684d51800bmr941959ejc.1.1683536412950;
        Mon, 08 May 2023 02:00:12 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:50e0:ebdf:b755:b300])
        by smtp.gmail.com with ESMTPSA id jz4-20020a170906bb0400b0094bb4c75695sm4718953ejb.194.2023.05.08.02.00.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 02:00:12 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Akira Shimahara <akira215corp@gmail.com>,
        Ivan Zaentsev <ivan.zaentsev@wirenboard.ru>,
        Stefan Wahren <stefan.wahren@i2se.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Stefan Wahren <stefan.wahren@chargebyte.com>,
        Michael Heimpold <mhei@heimpold.de>,
        regressions@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] w1: w1_therm: fix locking behavior in convert_t
Date:   Mon,  8 May 2023 10:59:45 +0200
Message-Id: <168353638584.78189.6729435069680377239.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230427112152.12313-1-stefan.wahren@i2se.com>
References: <20230427112152.12313-1-stefan.wahren@i2se.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 27 Apr 2023 13:21:52 +0200, Stefan Wahren wrote:
> The commit 67b392f7b8ed ("w1_therm: optimizing temperature read timings")
> accidentially inverted the logic for lock handling of the bus mutex.
> 
> Before:
>   pullup -> release lock before sleep
>   no pullup -> release lock after sleep
> 
> [...]

Applied, thanks!

[1/1] w1: w1_therm: fix locking behavior in convert_t
      https://git.kernel.org/krzk/linux-w1/c/dca5480ab7b77a889088ab7cac81934604510ac7

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
