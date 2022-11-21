Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 767D7631951
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 06:04:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbiKUFEq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 00:04:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiKUFEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 00:04:43 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 085B71CB19
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 21:04:40 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id b62so10195693pgc.0
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 21:04:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qrMqh8nIzBj0rcQAnGuTQVL6D8xs7vnCoBc93q4h/+Q=;
        b=G2rBkk0qVJF3gkH+xd86yQYplumpJ4CWmeia7/qm7d/KfvA7PdsJ6ovCRo+XIC3zPI
         1A5ecQL1IBKcu7KNXCFsz0jFVTrS00cnoUmKEoG7Ehwq9g9b+4RbaSnDTZX0i7vJVNut
         +uKAch8R9y4hl06kAzL7iTL9FacKYxAG04VBEp90gNCay0oEC2W/IWrzERCBC/HRzfmR
         agM9tDUICiuxJlFeybHhUvyxo4wt8zVCTGrWWd25e4CDP3d4IpiUq/fgpyElUXiihB6R
         3h4a7mW4EPjQdoTBRKOanM73rtkLwxC31yV7RiBRMw2O/bn1XWG8bcZVDWX1PS9ZCpl1
         Rc6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qrMqh8nIzBj0rcQAnGuTQVL6D8xs7vnCoBc93q4h/+Q=;
        b=6aWSJS389uv3PsYzVyar3/yCX5YJ2zYkYl7M5ts+fC99WmOv+zCeV+4Ecq1q7nbsXV
         VyszlNIf1YZIM16VzhZkqg7T3O/krLNWVbY4VyB7C02i2dJ/pWWepJ48TqSu6rRCfeW1
         md/DsbF/HzovCx+/9jb60Jo8DM3dKxtEco8wQmhg6qSqDJZRUv8nlEJfxY5ntSjZjBht
         ETkCYPIYUG/mP5jTeECAfgyiQO9MisVJGbXZuNPlS2OSmqI1n6FuFg3PWnNExXzOyIOv
         ZDJXK+3nhdcS7vOs75pmDH9dfUGDxT4Wo7B+wO+17M24/jopdyT2EqWaKXIhpFDIy/aU
         A8wg==
X-Gm-Message-State: ANoB5plC44hdyaYKVtWCxGf9r6wNHYJaq6uwMtFHvD8J+uGAHg2ML6Zj
        pyeHBvaunx+3vSYrjNacfwQA7Q==
X-Google-Smtp-Source: AA0mqf6WyJjqtln70CdGw/0GblSJQ3FaM0LyNWl8qeG/M7Yq5tlQd2wsisHPLyH0dVVe/WH5WsIhzw==
X-Received: by 2002:aa7:942f:0:b0:56b:a149:1d89 with SMTP id y15-20020aa7942f000000b0056ba1491d89mr735135pfo.83.1669007079516;
        Sun, 20 Nov 2022 21:04:39 -0800 (PST)
Received: from localhost ([122.172.85.60])
        by smtp.gmail.com with ESMTPSA id d4-20020a170902cec400b0017f64ab80e5sm8574461plg.179.2022.11.20.21.04.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Nov 2022 21:04:36 -0800 (PST)
Date:   Mon, 21 Nov 2022 10:34:34 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     andersson@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        rafael@kernel.org, robh+dt@kernel.org, johan@kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        stable@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v7 4/4] cpufreq: qcom-hw: Fix the frequency returned by
 cpufreq_driver->get()
Message-ID: <20221121050434.5qyp46vkc5aj6nxe@vireshk-i7>
References: <20221117053145.10409-1-manivannan.sadhasivam@linaro.org>
 <20221117053145.10409-5-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221117053145.10409-5-manivannan.sadhasivam@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17-11-22, 11:01, Manivannan Sadhasivam wrote:
> The cpufreq_driver->get() callback is supposed to return the current
> frequency of the CPU and not the one requested by the CPUFreq core.
> Fix it by returning the frequency that gets supplied to the CPU after
> the DCVS operation of EPSS/OSM.
> 
> Cc: stable@vger.kernel.org # v5.15
> Fixes: 2849dd8bc72b ("cpufreq: qcom-hw: Add support for QCOM cpufreq HW driver")
> Reported-by: Sudeep Holla <sudeep.holla@arm.com>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  drivers/cpufreq/qcom-cpufreq-hw.c | 42 +++++++++++++++++++++----------
>  1 file changed, 29 insertions(+), 13 deletions(-)

A fix should always be the first patch in the series as it needs to be
backported.

I can reorder this if it won't break anything for this time.

-- 
viresh
