Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B8DB74F839
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 21:03:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231228AbjGKTDg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 15:03:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbjGKTDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 15:03:34 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8824A170A
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 12:03:32 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-3142a9ff6d8so6583179f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 12:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689102211; x=1691694211;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nmSVSNwgLZpR0raFsCoGwYAG8k2Ntlem8DSOC/Pp7Qo=;
        b=oaHblHM5peWlUa6d0SRcNDSmZaF4zsyl75i4lnx4g99nZccx2ydhPYpwAt+GAKTI82
         1Ig1iT/nj17vUL8Fk8w/UiebsMcMQFO2lPQo0wkbgypUklSfLb+omNjcDXFE4ZQIAx82
         X5/gtXYwcsJOepy09D8AUadVssEsDu4xZJskld+sKK7d7AYLrT0Tqr91UIKeRxsYPUII
         L8V+7Gdo6OLrP19nCOglzlUHehlwCX6gTqgC/qTu2FEVDqubzRN1kELVInyVdF2K69fp
         fHxYmRPlhNkn3BO7fTHv7Tn2O2ttJu+HQeqyt9CH6laKNesN9064bWCu5pmKJw4jdKNW
         Vaig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689102211; x=1691694211;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nmSVSNwgLZpR0raFsCoGwYAG8k2Ntlem8DSOC/Pp7Qo=;
        b=H8/St81H53NMdx69ElLoKnHVuJDKkx9AAGU5ubo05mzgDpMsftvkK8GE6vyqbOx0FP
         D8ZwB/qJxbHluyhr5Y9hsTTwkcVzFWTHyU9CL0Lum6EqrpWKL+V60CnN/rMlhEbaqmRH
         7Lo+erGLEVzD8cGOSxAQy4pw3+19Zj64VkC1gcIS51lF0nkeHOsgfflAXnvm0REWUdmU
         y6dwKh4dkv20bC7ijapWB5+sQhogp9S8OFZzP2KzpJdwike0QhHC0EXbkkKfl8bJb7cz
         XOU3VVKGvryYOp76tzeW8cuT4Py152Yu30zF09BEHXzXAWCCwQymWRytrx8BwUSYwX/h
         pU4g==
X-Gm-Message-State: ABy/qLbCPD+XbgViM3Jzd/s1nO1HiC5oNm8rOKX5/jN4paG4WKJ84BmK
        Dv89ktjrbn4qe4q4IacUBZd7iiwmHzq1ig==
X-Google-Smtp-Source: APBJJlFuIi3pappe2fS1dup66MIYhcW7UUygU++B51fKmhaxkEr9f1RifCsk5AoTV4zbCWIkjm3X9w==
X-Received: by 2002:a05:6000:512:b0:313:dfa2:1a85 with SMTP id a18-20020a056000051200b00313dfa21a85mr18408320wrf.27.1689102210934;
        Tue, 11 Jul 2023 12:03:30 -0700 (PDT)
Received: from jernej-laptop.localnet (82-149-1-233.dynamic.telemach.net. [82.149.1.233])
        by smtp.gmail.com with ESMTPSA id v2-20020adfe4c2000000b0031434c08bb7sm2958135wrm.105.2023.07.11.12.03.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 12:03:30 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Chen-Yu Tsai <wens@csie.org>, Samuel Holland <samuel@sholland.org>,
        Maxime Ripard <mripard@kernel.org>,
        Mans Rullgard <mans@mansr.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev
Subject: Re: [PATCH 2/3] clocksource: sun5i: remove pointless struct
Date:   Tue, 11 Jul 2023 21:03:29 +0200
Message-ID: <3428514.QJadu78ljV@jernej-laptop>
In-Reply-To: <20230630201800.16501-3-mans@mansr.com>
References: <20230630201800.16501-1-mans@mansr.com>
 <20230630201800.16501-3-mans@mansr.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne petek, 30. junij 2023 ob 22:01:27 CEST je Mans Rullgard napisal(a):
> Remove the pointless struct added in the previous patch to make
> the diff smaller.
> 
> Signed-off-by: Mans Rullgard <mans@mansr.com>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej


