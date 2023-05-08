Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F83A6FA2C5
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 11:00:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233434AbjEHJAm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 05:00:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233409AbjEHJAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 05:00:35 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AA7B22736
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 02:00:07 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-50bc22805d3so6566632a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 02:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683536405; x=1686128405;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d/AWIT+PFMLxeIPWQVWMCPgO/JtqKltH6oPdKTinvNM=;
        b=rcOfDWRjLe9N9MkVGXioB2eb8R7zklcSRsKP30ATe289ZIggP9Y6D7Xv51nKhwTjF5
         xYPE0u3onV22S+g0bNWWcO8+1zchNz58q5RPMBBX7l0S/2PxxMmivpoxW+kKhpxC1mxI
         aoq5W7kPR5DzFr4Mk1qitP2OaU+o60Sx88yiFvi4Jd9GQVODTg2BqrAohUR59fYT2377
         PQ/xT3TcG3XXTtDGUrWPQKwMERi4aHTVz/f2cEBq+3WHh48cxnYY7DALB/5cHbWjYtj7
         so+ZLOqZtdqmHN6lhtUfqm/fhbMbner9+coBVmuJs178mEIusuxbQgw38KIXhw988YVj
         XFQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683536405; x=1686128405;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d/AWIT+PFMLxeIPWQVWMCPgO/JtqKltH6oPdKTinvNM=;
        b=Ot+t0VzRO6MlsCTrO6+g+oxjYzQ3ZqAlqbzNndnV8P4yyuE3hRc4NFFvvQN+qqjjsh
         I1Ix4e1zrfxKmbzO7knTGstLJCSbdjeVc0YBXVVCEx4TBAJcYonXCHqmCT5yuotY0E0/
         3u5ZhT9hvw921NnG/NbVl2eST6xLgNldTlaK9yLnKaFdyifPYeb8ZX3UYBERRnZdFcCR
         lRdb3udjzkIasRxuLgqc0JZFlurMUvpWthwqTmg5CHrWbHRYYsRUK/J3q4tWA+mQg4p4
         Qu4SooHyqInBEWXbbKyd7cdsuOEVvwfmKO8r7m3ANPn+/0mBGKWDc0mblmIGKeCuSszq
         PINQ==
X-Gm-Message-State: AC+VfDyOtEzRl6kSrKtUZiQhhRFnzq/58b+xz3K2q7BmLjnoNkhog0Y7
        VHenhHuOCKDA+LWazgCIMNpbCw==
X-Google-Smtp-Source: ACHHUZ5Qq+u7E6Kf2cfwfJ1fQQRd45Btua8FYgZkqTI00N7kVLc5fTBWl+DlOacrXV0NOZuS/4RFDg==
X-Received: by 2002:a17:907:1c18:b0:932:cec7:6801 with SMTP id nc24-20020a1709071c1800b00932cec76801mr9085880ejc.54.1683536405541;
        Mon, 08 May 2023 02:00:05 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:50e0:ebdf:b755:b300])
        by smtp.gmail.com with ESMTPSA id jz4-20020a170906bb0400b0094bb4c75695sm4718953ejb.194.2023.05.08.02.00.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 02:00:05 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     zbr@ioremap.net, Haowen Bai <baihaowen@meizu.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] w1: w1_therm: Use max() instead of doing it manually
Date:   Mon,  8 May 2023 10:59:38 +0200
Message-Id: <168353638586.78189.6492861371761968883.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <1646908169-8050-1-git-send-email-baihaowen@meizu.com>
References: <1646908169-8050-1-git-send-email-baihaowen@meizu.com>
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


On Thu, 10 Mar 2022 18:29:29 +0800, Haowen Bai wrote:
> Fix following coccicheck warning:
> drivers/w1/slaves/w1_therm.c:1452:18-19: WARNING opportunity for max()
> 
> 

Applied, thanks!

[1/1] w1: w1_therm: Use max() instead of doing it manually
      https://git.kernel.org/krzk/linux-w1/c/1aa75bf5174c8243505a27476422060fce630cb1

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
