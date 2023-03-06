Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E295A6AC3D1
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 15:50:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231177AbjCFOtn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 09:49:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbjCFOti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 09:49:38 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39106449D
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 06:49:16 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id cw28so39646524edb.5
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 06:49:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678114154;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nh6XKFz+T6WxhqqPVlLeQRxcOS/87/Io/Bax+zCSLTs=;
        b=vDgjHqLuhZeBrv2nf3j5BRaFdwPn1c1/hZ38yzI8sspL8Et9YWL8M1KFYyvfu1VX1z
         /X+pteStVbdgmLP1GrUqV2Jn+jYrT1+MWyTC4MQ4Rqf/c+BSpuTDr3WzdgXGMEx3oCq8
         n+P8RIlOpgak/BnhSV9IKmqPdUqUH0J8C6vDAulHvNKxoN9N/u4tBUBLwjLtaYXG+DNe
         XpJS/IFA4xqf/5/NTXe6xBX5ergZtu/72vPNMCOTceqRuseaMoWODfdSgm2VRi7Cz55Q
         1EOMi82eWfY9qjMhPXZ/k4mb3Uy5dkdaTgCGdHcwbfNIFbJB8Mh4Xuyc53O3hzpTmOkv
         uOBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678114154;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nh6XKFz+T6WxhqqPVlLeQRxcOS/87/Io/Bax+zCSLTs=;
        b=GCAJ20kK8AzzaLy/bNfV2web3JxSE/WBSS/3sikpinTImd8JXIPY/P36rF+9/7RMw2
         XnB8HlhkskoMrKgqRwULKc6Jd/DkpPgq7LY38R9wbpiT06TOEGhbwwADickm9Ke7j+rc
         NxgK3+OIttS+q5IVtID0+NXSKp8DPxVtrues8A27D01aMeHzRt64zBKcN1syTuR6cqFK
         wSc69A4I1/AV4sBz0PaStx7OIKD5lzXZu2pornUHkV8mLivOlLZyMd2uTgaqmTAZep2/
         tZVOCcs3Nb+nImOCJreqbiT0BkY1MzGYvnVUF+0x6hCaEIP6WoJ1EKGiiqhEZ04Ecmzj
         9/Qg==
X-Gm-Message-State: AO0yUKVYk7eWfywDQkFxhHkapvYVsoIFaxlW4LQQSalIzkZBVmRvTfcw
        91TafNNIhgNyay6GJuqqVUWaCw==
X-Google-Smtp-Source: AK7set89acS5FAn/13g3IEOQgIv3zAF1UVIKPzKnLTl+AGGpNn17Ns7cLvofX2V+yDagk4jalWY6cw==
X-Received: by 2002:a17:907:2ce1:b0:8b1:32dd:3af with SMTP id hz1-20020a1709072ce100b008b132dd03afmr16097875ejc.28.1678114154047;
        Mon, 06 Mar 2023 06:49:14 -0800 (PST)
Received: from krzk-bin.. ([2a02:810d:15c0:828:c1e7:5006:98ac:f57])
        by smtp.gmail.com with ESMTPSA id j22-20020a1709066dd600b008e6bd130b14sm4706760ejt.64.2023.03.06.06.49.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 06:49:13 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Sam Protsenko <semen.protsenko@linaro.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Chanho Park <chanho61.park@samsung.com>,
        linux-clk@vger.kernel.org, Sumit Semwal <sumit.semwal@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        David Virag <virag.david003@gmail.com>,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH v3 2/6] clk: samsung: Remove np argument from samsung_clk_init()
Date:   Mon,  6 Mar 2023 15:49:08 +0100
Message-Id: <167811414390.14916.3902557610865008921.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230223041938.22732-3-semen.protsenko@linaro.org>
References: <20230223041938.22732-1-semen.protsenko@linaro.org> <20230223041938.22732-3-semen.protsenko@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Feb 2023 22:19:34 -0600, Sam Protsenko wrote:
> The code using `np' argument was removed from samsung_clk_init(). Remove
> that leftover parameter as well.
> 
> No functional change.
> 
> 

Applied, thanks!

[2/6] clk: samsung: Remove np argument from samsung_clk_init()
      https://git.kernel.org/krzk/linux/c/9753e4c7b552f009c10be5a22c65509cb61de893

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
