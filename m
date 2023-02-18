Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06FA369BAC1
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 16:39:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbjBRPjf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Feb 2023 10:39:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjBRPje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Feb 2023 10:39:34 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72E3316AF5
        for <linux-kernel@vger.kernel.org>; Sat, 18 Feb 2023 07:39:32 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id t19so2999947edi.13
        for <linux-kernel@vger.kernel.org>; Sat, 18 Feb 2023 07:39:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Fhk/LkcUqvmtS88Fsav13SkCJ/dBHDE7V+3gF5t/b4A=;
        b=MP597z2WR0qOWuRDBVzTfxR4AeV+HiWWU2uhGXYK/uk7PAfvaRtx2Y2YXtN46Lfs/j
         AWs4R2tTWt+933UrqGuMHOU4IqohGnT/RqNWQ8vG3mAwrpaqrXSj25DkWKMOiwNXA9Dv
         oyVAXW0nL4GgWR1aPWMUc7amir2zCfbV3Cd0bKQmypAh2aLZ2HpN2FtE7Byzhhmq7MHA
         LampGVrcO7TwGb3wZC1z5VmDSAkdYYFac8cs7KwPHUqN46qHfxaiB/3n1LLLPPDxdpln
         GatHGBfg8dPCcr7k0x3oXetlo9gnWbutOA5s+9lfqZ6uJM8DjQNP/zeAk9178VJdUnBA
         Oxug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fhk/LkcUqvmtS88Fsav13SkCJ/dBHDE7V+3gF5t/b4A=;
        b=IKktK9YIqRq3QTbT3ZJwwNuy1mrqJoSehPGjyps2tb//dAK96thgRRcShnCUiajutV
         VVmgMfvPvuXJaxMlHdgoNWWh2dArRdyXS+79Vpb9kK5gtv4qoxyg/e6T9PCPMbx2GuRU
         /jrWNwIDJU04TxwzB0UINMbedX5Tw9YVf1aEyd0sEPxS+Uk/Ki8708jy5uJahyNJIXVb
         SWLassT+hEamaLxF3SeKQEACcpmcRNM+DZy5lOoqEitYeO1tqVvKNMQZg7oyCpBTLs0O
         jKJYirrw0SYom2aTdIG8/DYeyyW49UBNeBaUuftDxH2ozNVCVW0ZAIJ7y/L3QnjBVLbB
         tyfQ==
X-Gm-Message-State: AO0yUKW5IcCgPhibcapFgpRfIV1zEJSTZGM3vp+raXCuHe371FoPdzlw
        6pcNNKRsZugd6SZxLUgDznqYecHOAlx9Ib06M+Y=
X-Google-Smtp-Source: AK7set+vFRITxhRNR9KOBSvon1FZkyHd4S6hRd+JrHh7YNLrepBEdvEyBlkKQiNvgavMaIKNoOC1Yhxheuo/9nEWOLQ=
X-Received: by 2002:a17:906:9f25:b0:88d:ba79:4310 with SMTP id
 fy37-20020a1709069f2500b0088dba794310mr317170ejc.0.1676734770845; Sat, 18 Feb
 2023 07:39:30 -0800 (PST)
MIME-Version: 1.0
References: <202302161054598138273@zte.com.cn>
In-Reply-To: <202302161054598138273@zte.com.cn>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sat, 18 Feb 2023 16:39:20 +0100
Message-ID: <CAFBinCB72j5hYhpmWJ8T1kQcfVf_wrMF=vBAFPLGL3BRq5qV5g@mail.gmail.com>
Subject: Re: [PATCH v2] reset: meson: Use devm_platform_ioremap_resource()
To:     ye.xingchen@zte.com.cn
Cc:     p.zabel@pengutronix.de, neil.armstrong@linaro.org,
        khilman@baylibre.com, jbrunet@baylibre.com,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 16, 2023 at 3:55 AM <ye.xingchen@zte.com.cn> wrote:
>
> From: Ye Xingchen <ye.xingchen@zte.com.cn>
>
> Convert platform_get_resource(), devm_ioremap_resource() to a single
> call to Use devm_platform_ioremap_resource(), as this is exactly
> what this function does.
>
> Suggested-by: Philipp Zabel <p.zabel@pengutronix.de>
> Signed-off-by: Ye Xingchen <ye.xingchen@zte.com.cn>
Thanks for your contribution! Please add my:
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
