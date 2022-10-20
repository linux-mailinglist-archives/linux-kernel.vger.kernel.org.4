Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B0C2606089
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 14:47:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbiJTMrh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 08:47:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbiJTMre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 08:47:34 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31E2218B088
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 05:47:33 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id b5so19116785pgb.6
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 05:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=puPrUXZK0sU2nL/Dv5W0joxWJT4bAL8pPriVwGk3Wbg=;
        b=JTLNeaBJ9BU2HAKbhIriPxN7ME+Ztp20XUO4VooC0vV+9vUoAoWvfpopmZZHJVoa9P
         d0plpmcIv91CQF5bgQQel8l55bJjdtC4D5amwT6sWW+UlidZkTQ5Yw6kapRll9XntNax
         DHlm+7qi46CM+9W2CB6UGqqWzarVxicTSxU9ZIuYyRFvWSB2Sk2UAMNoMLmu/fWYWNL4
         ILMlGroW/iFE4YrL9l4PrjL0O77MrWROeJeQytgJwfCVwpRSPb1kNzt2E1kNGRgWXSWb
         JpmfmCGy7Zs+P7TV7u13hhUyn4ptlXshAnY6iXfMVzrqE+np9MPOUF7S54Nyg6IuhPXe
         4o1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=puPrUXZK0sU2nL/Dv5W0joxWJT4bAL8pPriVwGk3Wbg=;
        b=KOViTVnotCAvPN9xNY2fyICo2HX679DVYeP1bp/b0mfIIhZ7xI6XETI0DHovPMnufy
         MtA/2lEbNFYZ/X6NeGdpaEDLAg+QZ/eQKf0fMvaw12sdCbyQyueiPuvdobGMDYKlSR8t
         ss5vlrq8xPXqf1/LY/PeGAqbLz5LaJHyPMnNS68ti3UnQ+t80Ws2tXghMaOqwJG7gSXR
         a6fLwdIC0Nbx6oyEpAPrgwp2T9FfKV1FuerTwXoJf0YOjAc63kPG4HofQ9QZ5PQW8okz
         dvM4XagGW/fDGAZ7O3dIKYki72J7Z7joIsArkHYaLF/tCB81tM/k6u3NPtw27FKPzfsj
         6p8Q==
X-Gm-Message-State: ACrzQf3yKBZiAy1sNE3knPwP+tytT05LUw1gwXsXyRJn/4qOOig2s2UL
        Aj3j4klYz3SgkCdwu0JpKunxlivFXV/wTRif
X-Google-Smtp-Source: AMsMyM76/lj6+QAOB8gUCoxo0XMSw8YQQEYhAHX6BidP3Tl0NBlXJswP4vJMdhg+Sci4wE/osjNKVw==
X-Received: by 2002:aa7:8011:0:b0:567:70cc:5b78 with SMTP id j17-20020aa78011000000b0056770cc5b78mr9768392pfi.29.1666270052667;
        Thu, 20 Oct 2022 05:47:32 -0700 (PDT)
Received: from [127.0.0.1] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id m12-20020a170902768c00b00176675adbe1sm2035164pll.208.2022.10.20.05.47.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 05:47:31 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Yuwei Guan <ssawgyw@gmail.com>, paolo.valente@linaro.org
Cc:     Yuwei.Guan@zeekrlife.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221018030139.159-1-Yuwei.Guan@zeekrlife.com>
References: <20221018030139.159-1-Yuwei.Guan@zeekrlife.com>
Subject: Re: [RESEND PATCH] block, bfq: remove unused variable for bfq_queue
Message-Id: <166627005112.161439.5489216534046304449.b4-ty@kernel.dk>
Date:   Thu, 20 Oct 2022 05:47:31 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-d9ed3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Oct 2022 11:01:39 +0800, Yuwei Guan wrote:
> it defined in d0edc2473be9d, but there's nowhere to use it,
> so remove it.
> 
> 

Applied, thanks!

[1/1] block, bfq: remove unused variable for bfq_queue
      commit: 33566f92cd5f1c1d462920978f6dc102c744270d

Best regards,
-- 
Jens Axboe


