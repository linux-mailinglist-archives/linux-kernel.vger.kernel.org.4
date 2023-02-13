Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35154693DB4
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 06:04:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbjBMFEg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 00:04:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjBMFEf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 00:04:35 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F339DC162
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 21:04:33 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id bg2so1493612pjb.4
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 21:04:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Cq2Mt5IgFuRz+Dg5gGVSgc7JNioKJ+vyevcaRsQ8/Dk=;
        b=XQFAOmcKsL4NUry+FgCLYWfIbnAckIpsc1e7WWxGHgHqqFqO4P5vKOLnSfjotm6Km1
         ywVZDGwQQ4OrzN2MD9V1rf9GIgGFB3e0Qfb4ZA8UYdYjUYhrDmVEm5vgiOsKGAJd8+ww
         m28Mbh/GrkyujfyM4Zh/SQItW4jlfW41cQe7NgcMiUfVullRSuRGmy6TLrYCf4hTkLOG
         odqFB3BliehB0/1uO70gIdw3DsY+9C0s4AqDQ3wrVxcWFygVg1X1GVZuTnnIeQiLjWja
         R9zj34VJjCQFspS72+plj00FjepJNId3N1xHUlOvi2NKp6x4dHJvQIfp4TdCKX9MdTpo
         e+CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cq2Mt5IgFuRz+Dg5gGVSgc7JNioKJ+vyevcaRsQ8/Dk=;
        b=6I+tHpLPmvf3g3bXvrQOha/NznXrVxsOP5uwjsqkxTsF39c6PTdPUH7c0KFYrrz51u
         hLSFw6X8FAnwZqfX6o5cOG3bjcoPvMmK5PET7TsUx/xGzbA5HR4C5RO3sDPehcPeW+sd
         NtD6LPJDmFX3mX9nT10HafCROYlQfG8JEFDa8HFMDwfzzErExKo7bEBV8d+YaKmWfQ8e
         RKkpZEDlf8DnEQSUCeO/+V/GvcpvvFULNXZJaU4+uuiXsDtEes6MR3MIaSNjWleux00l
         3OKwQfwBzexPeUNk6R2/tSbVj3lTsOwsMHo/Ty9gk3McsVaYk4JG3/77aoMztZACxWzu
         XE4g==
X-Gm-Message-State: AO0yUKU+MjTTgsEhr6kxh3CdpQbnguUivGYdzpBh7c1mNEHod7a05KTQ
        IzBLL7tZvJNZWPWXBQWrHPKQCw==
X-Google-Smtp-Source: AK7set9XiywEdoa+M+ipPblxIE9rdVgmOumuyiq6YmdkUUvHhebrgJDfig+6A2CZ+j9f/fMtfSRVPw==
X-Received: by 2002:a17:902:e5d2:b0:19a:7f4b:3ed4 with SMTP id u18-20020a170902e5d200b0019a7f4b3ed4mr8883064plf.30.1676264673461;
        Sun, 12 Feb 2023 21:04:33 -0800 (PST)
Received: from localhost ([122.172.83.155])
        by smtp.gmail.com with ESMTPSA id r10-20020a170902be0a00b00199524dc67bsm7149422pls.163.2023.02.12.21.04.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Feb 2023 21:04:32 -0800 (PST)
Date:   Mon, 13 Feb 2023 10:34:30 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Christian Marangi <ansuelsmth@gmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Ilia Lin <ilia.lin@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/3] dt-bindings: cpufreq: qcom-cpufreq-nvmem: specify
 supported opp tables
Message-ID: <20230213050430.n3wszmi5kslvhdtl@vireshk-i7>
References: <20230208153913.24436-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230208153913.24436-1-ansuelsmth@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08-02-23, 16:39, Christian Marangi wrote:
> Add additional info on what opp tables the defined devices in this schema
> supports (operating-points-v2-kryo-cpu and operating-points-v2-qcom-level)
> and reference them.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
> Changes v6:
> - No change
> Changes v5:
> - Swap patch 1 and patch 2 to fix dt_check_warning on single
>   patch bisecting 
> Changes v4:
> - Add patch split from patch 1

Rob / Krzysztof,

I am looking to apply this patchset for next release if it is ready, are you
comfortable giving your Acks for the entire series yet ?

-- 
viresh
