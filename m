Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0F4662FE99
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 21:12:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231756AbiKRUMF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 15:12:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231377AbiKRUMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 15:12:03 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7576A24F1B
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 12:11:57 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id y203so5893796pfb.4
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 12:11:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=AK84sEdglhKCy6lbEOsoadaKi0CogPRpI+bWM1SmryQ=;
        b=WPthLEWV8/nmjV+9mrnybjGy68E4abEuiuKlH6X2eBDDtC20XGdn7tqHiTRv2UfQBL
         9XVgktEIEs6br7pfDfStGVLDbCjJ7zWesVacptX6G4kd/fZLZSda+k48ggfwmEvJJ1HA
         yotDf6DldktAl+G/6miuDzX1uMNW808rtJbNR0cW1Lmsjpl7n2D6tqyjA6viMYqtQ1k8
         0/l/RskUX+L50dTRoMVSq0fX2ZBjfEujj0yu+MJY4iRbIB+GU7pb0REnTuqfV9vnl4lS
         OA1uvrVR5uglsiThUmNkyrnsXbkaiTwkimXOfov+M6cOWD5pzgJf/HQkked41xXQGCNW
         lsAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AK84sEdglhKCy6lbEOsoadaKi0CogPRpI+bWM1SmryQ=;
        b=afF7ZAF7Y+Bg22SfjvVf8f92LWALdI4LM+XiFClLNHxuRBloikdP5D0t4wX9+ME7yz
         867UMHLOi2eZm92/QUj9KnkmxM9C8atK2mMxdf2k6H03D11NU6RZWaHat+5vmM2+qsYn
         Cft1ZwXdVAgi7+khyjHHpdWPMFfH9bWT09Ksk4NpSKMHpDv6onj+w5SK1CZOpIKHXSNK
         HMHxs4VHMMTZMtbFiV6iwTJv8Fjnqr8Kw4uHnjJc5qVJo4LNz7yNQdHwlu60MSBT/gVo
         4csW9YVPwv83ytxDYBS8FvqGRJ0AVcQwOOCKoXRzA3pGbpQ1TNANTL9ucvQ29xQmbweT
         lzSA==
X-Gm-Message-State: ANoB5pnl/VhvsR98Q+JelsykpEisiyNvS4z/tW+cn/yEzggJzM82adBM
        w2tnyyCUlRJNeTWhDntb0IPcHQ==
X-Google-Smtp-Source: AA0mqf4njVmoedXQxhge+yjqgPduMedQtamMTRZ+5kOkotW9We/i9F6LJhVWrBtIk0cYkUwcFQUClQ==
X-Received: by 2002:a62:838f:0:b0:56c:8b7:f2dc with SMTP id h137-20020a62838f000000b0056c08b7f2dcmr9520267pfe.16.1668802316864;
        Fri, 18 Nov 2022 12:11:56 -0800 (PST)
Received: from localhost ([75.172.139.56])
        by smtp.gmail.com with ESMTPSA id s187-20020a625ec4000000b0056b8181861esm3703210pfb.19.2022.11.18.12.11.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 12:11:56 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Nicolas Frayer <nfrayer@baylibre.com>, peter.ujfalusi@gmail.com,
        vkoul@kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     glaroque@baylibre.com, nfrayer@baylibre.com
Subject: Re: [PATCH v3] dmaengine: ti: k3-udma: Deferring probe when
 soc_device_match() returns NULL
In-Reply-To: <20221117184406.292416-1-nfrayer@baylibre.com>
References: <20221117184406.292416-1-nfrayer@baylibre.com>
Date:   Fri, 18 Nov 2022 12:11:56 -0800
Message-ID: <7h4juw9g4z.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nicolas Frayer <nfrayer@baylibre.com> writes:

> When the k3 socinfo driver is built as a module, there is a possibility
> that it will probe after the k3 udma driver and the later returns -ENODEV.
> By deferring the k3 udma probe we allow the k3 socinfo to probe and
> register the soc_device_attribute structure needed by the k3 udma driver.
> Removed the dev_err() message as well as it's deferring and not failing.
>
> Signed-off-by: Nicolas Frayer <nfrayer@baylibre.com>

Reviewed-by: Kevin Hilman <khilman@baylibre.com>
