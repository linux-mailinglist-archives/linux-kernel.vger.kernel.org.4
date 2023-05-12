Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DA79700AC6
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 16:55:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241581AbjELOzB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 10:55:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241553AbjELOyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 10:54:54 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D088D11540
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 07:54:41 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3f435658d23so39784765e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 07:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683903280; x=1686495280;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BKfmgbuszdvDDc9sqyY46erImsNPtg5y7vnASGC/Nak=;
        b=cH5TTtx7stq/st9Qq4O+vbohxE4rN1CuSAohhK7s/wz+/cIwG8rhfNfhsqiL/f6mGl
         ulxtXOlv1Wc8wVYjs7tZ5LfykgvCDorpIwwNpELTW/3Bdh2ZEIk0lzAIJMSMSqwRA2TN
         xDdeOnKMOkAGmKfPlMxGobR0fYKuOHzk3h4xDFQwvK9gCHZlXVbCU2Ji4k2rc4Buy2/y
         XAOCU6viGcrHD2jwQ0bUguKRvwTFIb30LelHqTaD/td1zCKCqtQLWwBSgeJzUObHEVpk
         w+J+6DwU7RNYb26vLfoilddxYN93EJd3V9rSt45gWvDI05/jNIBwkiPFtxDTfEavuXCA
         Ggyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683903280; x=1686495280;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BKfmgbuszdvDDc9sqyY46erImsNPtg5y7vnASGC/Nak=;
        b=PPR4T50GunPSMcWlgbZCntzu9+7dG/YZKk77FSEc+Kxp49S8D+TERpWpLNgDjcmNgL
         TLVMmsTx+RFFd/1ERoMfgZsoDXNeljK5soFueTPPwwqaXVsOhbmbJ6h6EK/e+NarkIZ5
         SJa5WMEWywHKHRBvLMMVe7a8kXvLhahRx2qkX1A2KQG8QeVpyszRBSdWYU4IvwB3SuZv
         VZHy2hD4SQ/5Sg8+A2BJehLhDP1sKcfFKI+rE4CwcR/oTjqZm3+CXRKU1yiLCWDj9FjV
         yoVvJ+5AaIHt3hHKZ3ecfPlUyTQGr3JkW4SD4bRyOjvXF/dJhTtD8bBbDXZzkwaI5Rf+
         5UWA==
X-Gm-Message-State: AC+VfDw7D+vkHfefkPT6jb++g5o0sHmAeK7ACLw2Nk67dK6urD39mhWG
        qj3aBNK0jam9rr2uRsBtNneo3g==
X-Google-Smtp-Source: ACHHUZ5tPyHi33MTRX57RF55CmFbX40lS2fT/2Lh8npaFZmKporo8/VuwJMbk9Kq7r0wEJuakQsG/w==
X-Received: by 2002:a1c:f401:0:b0:3f0:3ab2:a7e5 with SMTP id z1-20020a1cf401000000b003f03ab2a7e5mr18894557wma.34.1683903280118;
        Fri, 12 May 2023 07:54:40 -0700 (PDT)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id v2-20020a1cf702000000b003f32f013c3csm28953540wmh.6.2023.05.12.07.54.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 07:54:39 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Richard Acayan <mailingradian@gmail.com>
In-Reply-To: <20230327210217.60948-1-mailingradian@gmail.com>
References: <20230327210217.60948-1-mailingradian@gmail.com>
Subject: Re: [PATCH v2 0/2] misc: fastrpc: Fixes for issues in userspace
Message-Id: <168390327884.185210.15199527234235828124.b4-ty@linaro.org>
Date:   Fri, 12 May 2023 15:54:38 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 27 Mar 2023 17:02:16 -0400, Richard Acayan wrote:
> Changes since v1 (20230130222716.7016-1-mailingradian@gmail.com):
>  - use /* */ for comments (2/2)
>  - exclude demonstration from final commit message (2/2)
>  - accumulate review tags (1-2/2)
> 
> Hi everyone,
> 
> [...]

Applied, thanks!

[1/2] misc: fastrpc: return -EPIPE to invocations on device removal
      commit: 578b3c7d15e65770a9b6317343a523e58f97d037
[2/2] misc: fastrpc: reject new invocations during device removal
      commit: 3a1f192ad1b46a2d783f54f1008e25d81d42587c

Best regards,
-- 
Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

