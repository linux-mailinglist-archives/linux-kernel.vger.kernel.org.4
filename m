Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03AFE6FA2CB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 11:00:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233295AbjEHJAx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 05:00:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233052AbjEHJAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 05:00:36 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2E7822709
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 02:00:09 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-50be17a1eceso8290091a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 02:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683536408; x=1686128408;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nl/BPBGh2VygeBbr5k4Z8jCelLG5j/WEtxJHo5ILE74=;
        b=pVkY2f45E2qpSEv3mENat/NYpgfS/SMgf0Gy4hgv+o+9FwBz9uBTRRBVZWHFQbdi1e
         um4UXUIDHxfHIgi3gF/SnFSXHDeaItGF4bb3RkRo8OGEeuQ7Sh8EOGgo3kw7/uqaE1ZJ
         PyBqOwZJrSLfNJwy9AudjzRfo5rtmGGnCstpmGt5jI36dlpIbc6wOKkujrJ5VxdN3lY9
         HHjEYQ95DP3xDduTr0gCmBswNQ97S6T3nzptV6iZRiGV4iktmHQ6xcPfInO5uDLel6e9
         5vaCubwsHWgkW7I7eIJwQIOASL+TdwP/nGbekHI/xjfl8Y2Gti9WT0bIFG5IR9AOIz7n
         sEGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683536408; x=1686128408;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nl/BPBGh2VygeBbr5k4Z8jCelLG5j/WEtxJHo5ILE74=;
        b=aN7C429geCOLo+t8wBJygtsNf1vm4i371Rx37SaFyrwSdRf7v2/vrd8wMpCsVByuia
         eWyi8Zeg89g5xUHVDjIaNVbvPpoXu0gw5N3WiUKuo+9l4Z4Q1+OnHtG+XFVUh9hCfNde
         rex1tnYZEna++mMGHOnLKO/G6DXwnQ+E/LFvA7P7IONQ37IcC+XFNnbmJuFJ08WjBIHG
         XBzLHnwH+h7B7TsVUlSiRm5IyiulYgdD5r9AfV1kRbCdNw97HJ2HJB8i5BgwWAkZjXTe
         uFbWtAneG+YMCesSAnjHMSKptJfwzxZRzd0m6jg9c1B8tbRP/KZBKeqAmpjwACP5RBdo
         nNHQ==
X-Gm-Message-State: AC+VfDxJbxjANWfKKNIhZNiDwJn11uY1jWMr8wef1pysk271aY80giNm
        W+DepQKhEV8Bw31S12wXM/36ZA==
X-Google-Smtp-Source: ACHHUZ4ACNqi+WNJEe29c9Fkz0U+3NBY2+EEUqiFEvZxU7lXwKkgJ8Wn33fSAijXsV7uvgdK+ipQYg==
X-Received: by 2002:a17:906:fd8e:b0:961:a67:28d with SMTP id xa14-20020a170906fd8e00b009610a67028dmr7641831ejb.22.1683536408385;
        Mon, 08 May 2023 02:00:08 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:50e0:ebdf:b755:b300])
        by smtp.gmail.com with ESMTPSA id jz4-20020a170906bb0400b0094bb4c75695sm4718953ejb.194.2023.05.08.02.00.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 02:00:08 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Evgeniy Polyakov <zbr@ioremap.net>,
        Dan Carpenter <error27@gmail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Greg Kroah-Hartman <gregkh@suse.de>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: (subset) [PATCH] w1: fix loop in w1_fini()
Date:   Mon,  8 May 2023 10:59:41 +0200
Message-Id: <168353638586.78189.7497040406891984516.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <YKUeCfjQqt5NuSta@mwanda>
References: <YKUeCfjQqt5NuSta@mwanda>
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


On Wed, 19 May 2021 17:17:45 +0300, Dan Carpenter wrote:
> The __w1_remove_master_device() function calls:
> 
> 	list_del(&dev->w1_master_entry);
> 
> So presumably this can cause an endless loop.
> 
> 
> [...]

Applied, thanks!

[1/1] w1: fix loop in w1_fini()
      https://git.kernel.org/krzk/linux-w1/c/83f3fcf96fcc7e5405b37d9424c7ef26bfa203f8

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
