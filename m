Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C427D6AC3D3
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 15:50:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231207AbjCFOtq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 09:49:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230386AbjCFOtj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 09:49:39 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81EF51FFC
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 06:49:17 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id x3so39519726edb.10
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 06:49:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678114155;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bFVOxxJWmcBBAsxjQVvaTc6NhO3PyYN3/IVM+H/3TK8=;
        b=mCym/pE56yl4VukDNNE4rO0NjAXcvF2OTUAhc4snUaI+4AP/j2l03QrlYqvvI6QSNJ
         p1BeqQ0alynnVREfBRWWNArPfkxOZcV1P0nuKd4QFJh2Zp4qm2Rk65d0R/bbLl1hF41f
         n+3JDWK4OOPzaeSFNogvFnC9ZCto7j4lMiF3LuhUwwtxjFbaefROGZcPvxkkT2R3vZbm
         xnZ6DTN4UmkiGB9MMI45EIYUe/j1IYSMUP9vajnRMiTa7ZQKHrdRHKBIOQrTUvjkL1vg
         6PMmzRY+N9CoMrLzizdprfVRLRrtPSAG1ilJy8G52J9bXJvXTN7JHrMtSqZvb6M8Wf8S
         4g9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678114155;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bFVOxxJWmcBBAsxjQVvaTc6NhO3PyYN3/IVM+H/3TK8=;
        b=G4qQLcob3/yijUhQcivkYr75LYQgRZJcNPqkyGdqoivac0xFO6dJM9KrOlqUr96L3j
         1zBkhJQgvNh5Q5uhlZefjbGuEptQwGTQLfUvG4mGne7c1lISg10TREGUiaBZqTL6D+pB
         RPS+Qj52xd0zwwID5AvsJgKfO5L88agmkZqCK/l618G5Hqt6G7SB/b3FRFu8JF9mqw8J
         1U9bAZunE2iLOCAKGSyTDuqw3kQoHOvBm36scbCXz4y8R77vH6nZ6TTCl0Nklz3dqRpV
         4zIcLEN7rnYHjEkWedgm/7OlLgUhwYnfzps4ekPplefdDPZuMbqjZ4XqQGKmEsYkvEV4
         EjqQ==
X-Gm-Message-State: AO0yUKX025261gbrT5DdLb7O8EMUNT10DJ8UmQN62hEMUXevNXyqnzzM
        vJa+hARDJL8fdhG3uZ3yAieQjg==
X-Google-Smtp-Source: AK7set8Y+Txg75rlmOiw6y13eDoYl8DExz4HfdO9c4x195v+eyQ7yohO5Z/vQkJkjEHlsfuOL4JKzA==
X-Received: by 2002:a17:906:384a:b0:8f0:143d:ee28 with SMTP id w10-20020a170906384a00b008f0143dee28mr11127962ejc.16.1678114155460;
        Mon, 06 Mar 2023 06:49:15 -0800 (PST)
Received: from krzk-bin.. ([2a02:810d:15c0:828:c1e7:5006:98ac:f57])
        by smtp.gmail.com with ESMTPSA id j22-20020a1709066dd600b008e6bd130b14sm4706760ejt.64.2023.03.06.06.49.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 06:49:14 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Sam Protsenko <semen.protsenko@linaro.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-clk@vger.kernel.org, Sumit Semwal <sumit.semwal@linaro.org>,
        Chanho Park <chanho61.park@samsung.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        David Virag <virag.david003@gmail.com>,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH v3 3/6] clk: samsung: Set dev in samsung_clk_init()
Date:   Mon,  6 Mar 2023 15:49:09 +0100
Message-Id: <167811414390.14916.14779906355644398581.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230223041938.22732-4-semen.protsenko@linaro.org>
References: <20230223041938.22732-1-semen.protsenko@linaro.org> <20230223041938.22732-4-semen.protsenko@linaro.org>
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

On Wed, 22 Feb 2023 22:19:35 -0600, Sam Protsenko wrote:
> Some drivers set dev to context in order to implement PM. Make that part
> of samsung_clk_init() instead of assigning `ctx->dev = dev' separately.
> 
> No functional change.
> 
> 

Applied, thanks!

[3/6] clk: samsung: Set dev in samsung_clk_init()
      https://git.kernel.org/krzk/linux/c/211e03f66a15d1e90ee2cddebb7e3b5bf0af50a9

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
