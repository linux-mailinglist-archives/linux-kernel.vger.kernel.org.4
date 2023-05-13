Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E135701978
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 21:16:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232552AbjEMTQJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 15:16:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbjEMTQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 15:16:08 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88F78272B
        for <linux-kernel@vger.kernel.org>; Sat, 13 May 2023 12:16:05 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9661a1ff1e9so1375581766b.1
        for <linux-kernel@vger.kernel.org>; Sat, 13 May 2023 12:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684005364; x=1686597364;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XXGc63SNvCrjFXmfPCdF2pPrkC/gLnguhdvxkjlzAE4=;
        b=kFXpQIXkNtIrB8fcVDwWfKPbK3gJHiRXenCIK+WS0Hzu3KkZp90Wo7mqTnC0ZXFsUE
         mU+TdSusyNuHKPjDxrv8xQg+HeVZutCRTsaiXSRJ43WuJtmtgi7YeRxDoCIwKZl2sgI0
         aVfDDes7rXFPyu4bAeADAyYPTHGUBBMSVq01ke47/MdZxsrsohzc+nqMLVFaV0HZBpcU
         meV/I4+KQRe4vBk6zfXLNoyxMV7kmwo/Else501FQ984RZncUWq4qrwvlPVJKnUvbPik
         jUD5AyPlkNR3tWZflzjt5TlfOT//rX8YgLSAXeNBYngZJLTfn/H0V2m8V+tWxNyzDK2e
         Do5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684005364; x=1686597364;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XXGc63SNvCrjFXmfPCdF2pPrkC/gLnguhdvxkjlzAE4=;
        b=OxNibRKFULNYG/LlPFCw/t5sJVHVGvYSHAM+ypr8a8YydII6y/OBcLEdZuiMxzOrLh
         rUL0d8hQuI5R1BqSUCtxISpgYzabZ6MoRlwRkHReu1IqYqYJaj4fLFIfL5WG/2EQtCpi
         /gByNhokpX0C7jQPy2n/gKXvZ4KvBO9E5fEffQoqDm44CYiwbDZnr/UK8oJbRrJIj+Gh
         vXjnHaqpT9d99fF4p6H61l31g2jaqW/bymvfz2vJpaoSmaNbVuD/JQpO9+RbkHyRB8QL
         1ZCvCk4N9mim0kowxletVyND/C/oBcpwkEgfUqAI2ydFzCsnqA2Xn1574+9AT+o4g+tZ
         vzRw==
X-Gm-Message-State: AC+VfDyltciq9mME/Xa55a6qo4PY/zUC74K9pNBBOs8+Qx55H0euwemA
        XmRmzV3GpRagF0Va/G03YZol1A==
X-Google-Smtp-Source: ACHHUZ79OAVJ58/bKklD4EZNQkaF5jxSTIoRU3SqTHYebkOObXIxcnxxanLvARJ4xySg4W8+UQyWvQ==
X-Received: by 2002:a17:906:5d08:b0:96a:ca96:3e49 with SMTP id g8-20020a1709065d0800b0096aca963e49mr3653153ejt.13.1684005363928;
        Sat, 13 May 2023 12:16:03 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:ba68:e5c9:694e:c6e4])
        by smtp.gmail.com with ESMTPSA id wi21-20020a170906fd5500b0094edbe5c7ddsm7176941ejb.38.2023.05.13.12.16.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 May 2023 12:16:03 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Evgeniy Polyakov <zbr@ioremap.net>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Jakob Koschel <jkl820.git@gmail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] w1: Replace usage of found with dedicated list iterator variable
Date:   Sat, 13 May 2023 21:15:58 +0200
Message-Id: <168400535611.15552.1786356693337116979.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230509-w1-replace-usage-of-found-with-tmp-list-iterator-variable-v3-1-e07c9603fd9d@gmail.com>
References: <20230509-w1-replace-usage-of-found-with-tmp-list-iterator-variable-v3-1-e07c9603fd9d@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 12 May 2023 13:36:10 +0200, Jakob Koschel wrote:
> To move the list iterator variable into the list_for_each_entry_*()
> macro in the future it should be avoided to use the list iterator
> variable after the loop body.
> 
> To *never* use the list iterator variable after the loop it was
> concluded to use a separate iterator variable instead of a
> found boolean [1].
> 
> [...]

Applied, thanks!

[1/1] w1: Replace usage of found with dedicated list iterator variable
      https://git.kernel.org/krzk/linux-w1/c/b332af5398a3aa1a2fdd69bb6968a8f866cc39aa

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
