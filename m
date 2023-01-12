Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71459666982
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 04:16:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230270AbjALDQa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 22:16:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234465AbjALDQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 22:16:26 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A41DDED5
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 19:16:25 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id h7so8665625pfq.4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 19:16:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vLgPPN/4BKYUAbBjp/lumqd5Fur98RZfMwe+XyGuCwQ=;
        b=bjXrKiCPcZ1mnQB/Agf1ffHwErEiwRmfS6XnouNbhPpnaIuZaCD09u1ys66wou6XEw
         aaPN9EXY0LAew2P3ohjpZskr5qgSGp3QaLiFdo16ELAMQe1VMt2aDRFOXNSQHo3pLGL8
         uhqGa2RHwvcDX/6hf9PzbxTyGzLpCINmbGeTT91OqvzD4gSMnKgoriAVNyN5ZvivE85/
         AGSowIYMVw6BgLRHWI0MWlNIA6Bhoot5jzNw319eFU6V/CTTG7vSIb3sV5D2EGdjEurl
         oMsTt2sAycgXCq3NPWK5lv9Xp3FO+pLxWSEwZLtNwqG3lIi8OA9g5y3VEmmE4xN1LRUO
         xkbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vLgPPN/4BKYUAbBjp/lumqd5Fur98RZfMwe+XyGuCwQ=;
        b=V8lpvS5FaOfeYAh+GyMqJIlfBu+uYJpUgSwl2DrR481qwmxjO5zFqDcWHJvAVUoOxi
         dYYf3uTm71Alq2naddPugtMYl2Ts/8vo9Ay0ERDEkKRM8ZadpazYmbaE8CgmzN36kq/L
         woe/eRnDZ/qlj8ybFbjRH6e8jW6ivF5XRN9O48M6wIUh41g+dcnmn78i0r3EgDNdDcQ9
         mSrlyKsPjg5abOhn2rcavsBuTziwgrdPvW7S/6/O7ySnx27tpmwDTW02ZYYpqbpV5cAy
         2BMCbO3Jf0XH8RfHfkaxHbnGv0BQqf0utbizIKkvIbGHh3pTHPeLgEmtEDGw8C5Bygh2
         BnJg==
X-Gm-Message-State: AFqh2kqREnsYscJbJ9pVOPGR1AQt68EqxlkwW/dQuGBO5Ly345MLANku
        UWx/cI0w9nmG2NWlyuGAaWHNvw==
X-Google-Smtp-Source: AMrXdXu0yK+AtehwqkneInZrjlawWZChNyitggarUNAuCygfbreHfMWSkCNhz90t8Dh3rmThDleTEA==
X-Received: by 2002:a62:38d8:0:b0:588:4739:9a23 with SMTP id f207-20020a6238d8000000b0058847399a23mr12688063pfa.15.1673493384626;
        Wed, 11 Jan 2023 19:16:24 -0800 (PST)
Received: from localhost ([122.172.82.107])
        by smtp.gmail.com with ESMTPSA id 63-20020a621942000000b0056d98e359a5sm10660750pfz.165.2023.01.11.19.16.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 19:16:23 -0800 (PST)
Date:   Thu, 12 Jan 2023 08:46:21 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Luca Weiss <luca@z3ntu.xyz>
Cc:     linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] dt-bindings: cpufreq: cpufreq-qcom-hw: Add missing
 compatibles
Message-ID: <20230112031621.rphz4zu63ibul374@vireshk-i7>
References: <20221016090035.565350-1-luca@z3ntu.xyz>
 <4899603.LvFx2qVVIh@g550jk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4899603.LvFx2qVVIh@g550jk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11-01-23, 20:48, Luca Weiss wrote:
> Hi Viresh,
> 
> gentle bump, I hope this patch could get applied in-time for the next merge 
> window.

I thought Bjorn applied this patch long back. But now that I look back
at his email, he applied 2/5 and replied to 1/5, probably because
there wasn't a cover-letter available :(

Sorry for the confusion, applied now.

-- 
viresh
