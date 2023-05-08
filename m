Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48BDD6FA2D5
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 11:01:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233713AbjEHJBj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 05:01:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233607AbjEHJA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 05:00:56 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8EB023497
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 02:00:35 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-959a3e2dd27so752880666b.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 02:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683536414; x=1686128414;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o+wAkvBV4vWk+JSuZzEHX77Tgv9/h1giLrSEpEx00Nw=;
        b=cHYNPb7PP1d6l6QTflQgGCYjvcoYvnOdHN4v5HM8qfDPry42vMXeGVdlqkiJ8V0lUa
         E82RJcVvDFZR+QtNbF3vILE9IEjmSXf51sc8qDagQcKbno4vhLyUZbIvGZF8KTzgVcQE
         epRmxVwqld/tSwvNX4y+Rbn3c7b+D8jXqFJPZl3up+i6zkmzC9MgM5rPP/1cEDrTIGIi
         Hj1E3gGG5bN9LxUZ5aBnp3i4hU9wpqIb/N9cpfh6/oaqukf/M3VI5ZLq9oAFPonoqlk/
         M8acJcletz7BeJRQRAfWaaGeYNjkl12lzbxVh5fL3f0zKDOvF86MEBgcnm2EWk3hP3p9
         GZBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683536414; x=1686128414;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o+wAkvBV4vWk+JSuZzEHX77Tgv9/h1giLrSEpEx00Nw=;
        b=MQK19iox/8Asao1jyIvKFZFu+4fd8dTqTK3ylOvwhini7M6hwaYyNOgZgMXZBihpWs
         SqdWWApxhVvpl5LbzTvHNszck3L2zd/RctsxalzqzDNCHUeNKxQAK1xhT6EybF1qNloh
         giq0kaf/hPJL8GKQiBeEhRmoRn2L3trb55Ig1r8QI4a6ca5rPszAMkf7YVnHpF05Mt47
         qjXT+8R0dZ7pdQuTKvxuwC9JKXNpe+cZ2YA7qOBg23473jcy/eKXwolHehJhheQGWnV2
         8EGd8QcQtQy8AGFqBTmmvhpWR1B1/U9qrdPkRtcVo1Mgc1fMYNcZoy3hItZ2Cw37Ju3b
         FZIw==
X-Gm-Message-State: AC+VfDzfufj7mDwds3025/W/k//LGW6vhH1jPR72eMCjVYb8IUWF3Waj
        3CclAA2ewiqtFnbwCHZGpgvRZA==
X-Google-Smtp-Source: ACHHUZ4uzdzhkvHhMl8PfUghTNpmoYOLLklupYBM1zwgqhy9cH6djdKGNlRFQNHoj1CtJrS0h+Yc4g==
X-Received: by 2002:a17:906:dc93:b0:965:9602:1f07 with SMTP id cs19-20020a170906dc9300b0096596021f07mr8908240ejc.39.1683536413947;
        Mon, 08 May 2023 02:00:13 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:50e0:ebdf:b755:b300])
        by smtp.gmail.com with ESMTPSA id jz4-20020a170906bb0400b0094bb4c75695sm4718953ejb.194.2023.05.08.02.00.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 02:00:13 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     zbr@ioremap.net, Jason Wang <wangborong@cdjrlc.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] w1: no need to initialise statics to 0
Date:   Mon,  8 May 2023 10:59:46 +0200
Message-Id: <168353638586.78189.4410499030295048106.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220508023400.102244-1-wangborong@cdjrlc.com>
References: <20220508023400.102244-1-wangborong@cdjrlc.com>
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


On Sun, 08 May 2022 10:34:00 +0800, Jason Wang wrote:
> Static variables do not need to be initialised to 0, because compiler
> will initialise all uninitialised statics to 0. Thus, remove the
> unneeded initializations.
> 
> 

Applied, thanks!

[1/1] w1: no need to initialise statics to 0
      https://git.kernel.org/krzk/linux-w1/c/ecaed1a26f7215f48420a9c02e229b84b5fbb882

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
