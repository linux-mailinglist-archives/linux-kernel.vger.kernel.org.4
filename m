Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19CBB6CF9E2
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 05:59:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbjC3D7g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 23:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjC3D7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 23:59:34 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7A3210A
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 20:59:33 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id s8so11658308pfk.5
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 20:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680148773;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q25BjYFhUOQUROkZ0ZzAszfBEC4NCamXHxL/4xSLcMQ=;
        b=NbyeVMSimzD6VgEF9mdpMS3oGIirpVhDdWV+jb3dJBm3UCN1sW5PyQN2PccnZbdZcj
         BsSGJJrDc2l8Ofo0myog1VVI5Aw0F0FjRCfeB5g1ipaDF0gEfpK0Rq8Eqqx9hstfHzwy
         XX3v36eJIckhmHQFPr/8ZJey/aQ9xvBz784zgT5KPYv81ITpqYMQxNSvh4MNBRCefAK/
         5VS3VZ2dv3745ORC6O8Z2zrgIhZvxfZSAlCtWGcF3OdhSqCXgHgrwllh2MJr2c18g1dJ
         HHmoaQRyckis3bYhdzKb17HRjwc6Ka7hkLVr2fFufzbBQq7gXYKIOCFBQNYVRikAkJEH
         BqKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680148773;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q25BjYFhUOQUROkZ0ZzAszfBEC4NCamXHxL/4xSLcMQ=;
        b=WixnSOhEPlc5TrW2deHqZNiFTiLrIJ/oAQnaDxKePbtV3OJuwmVpySnr0h75kBPiDJ
         C5PRVHI/5CpBCTNA3+FkaV52IIAlH0eIxbQ7MlmUyjhr7fe/dliD55vb1KhPSCZ23YzG
         ZlxMkOCGryBWHqz+oFtJLp4n4+P1WNGQ/ZnqwXv3jKz7rzFoVYs9KHEifMVcKVnG9pSS
         c1Cu2WF4Inae2OppWX0xg1YzBKB9Jsi1a4A5+RiueHUADbEdg5nXEiTaEepilfMMobIV
         sKO/xmifdFK2VWnWDvQ15KSOlqfX22pQdQVxCAGn6NfyPUmm6J8U7rGxkpHC24qgj0oc
         a0ww==
X-Gm-Message-State: AAQBX9esdqt57KthWN8o7okyRH9ekWz2NNEMs82XeKjYaCYpTss333Hp
        WI24C0MnyIVtE9LIBo43QC/8qQ==
X-Google-Smtp-Source: AKy350ZdZDO3PRGGrrT+/YuyGadl5IRqO6n1xJBuLwHHNp/q4reg5l1w/HV8vpa1jUJmhsJ1XknWmA==
X-Received: by 2002:aa7:98c3:0:b0:62d:9b86:632 with SMTP id e3-20020aa798c3000000b0062d9b860632mr8620120pfm.9.1680148773161;
        Wed, 29 Mar 2023 20:59:33 -0700 (PDT)
Received: from localhost ([122.172.85.168])
        by smtp.gmail.com with ESMTPSA id z18-20020a63e552000000b0050f6add54fcsm19246877pgj.44.2023.03.29.20.59.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 20:59:32 -0700 (PDT)
Date:   Thu, 30 Mar 2023 09:29:30 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 0/8] qcom-cpufreq-hw binding improvements
Message-ID: <20230330035930.lv5bz43bkbdfnbhm@vireshk-i7>
References: <20230308-topic-cpufreq_bindings-v1-0-3368473ec52d@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230308-topic-cpufreq_bindings-v1-0-3368473ec52d@linaro.org>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08-03-23, 02:26, Konrad Dybcio wrote:
> This series tries to better sanitize what's actually allowed on which
> SoC and lowers the minimum frequency domain count to 1, as that's what's
> present on at least QCM2290.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
> Konrad Dybcio (8):
>       dt-bindings: cpufreq: cpufreq-qcom-hw: Allow just 1 frequency domain
>       dt-bindings: cpufreq: cpufreq-qcom-hw: Sanitize data per compatible
>       dt-bindings: cpufreq: cpufreq-qcom-hw: Add QCM2290

Applied these three, thanks..

-- 
viresh
