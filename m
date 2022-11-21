Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A8B5631A60
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 08:38:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbiKUHiX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 02:38:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbiKUHiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 02:38:21 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F38E12084
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 23:38:20 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id z26so10603089pff.1
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 23:38:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rH9EuZ3g0Ive6CfCrOeecFWxtnI4QmU2cNBkBprx728=;
        b=U0kSCF/EiIIvm+QW7ribLr1fjKhMh0qtZytMexRccMzfwXB64P+KGhnPPKW8WayDZt
         fmZ/6meNe0mxSc421VijbV5fpPmE/7l3RW+G/8RFWAbCuhXOtDhTEXBpqw43xpc0tCRJ
         zmlVH7pwNtsiZsCis3KUkbSdquE6g8FLGLSV2f7CDRFCHAiHsY1rcvxnROdWYN/FXZOF
         pemijZVxg5t92UqE0vQHoumD3vB/yDYNBM1DEwGVxcSBrRnvr6QRp6OGCFZ3oIDCvzr+
         RhjnrotlhXr/EC4VEiqBrMUG31+knbJzOcMeqJA1prbgd6fRo1y5tXQc0Sd5+YwjdSuU
         7mew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rH9EuZ3g0Ive6CfCrOeecFWxtnI4QmU2cNBkBprx728=;
        b=KyEgBrjFcyOmEhn4DuHIhlXUozLG8c4e650XXIvszfHFc9zSj5aEeiOQztw7YSUsi6
         yTs99jAq7Q3SgD3/LcF7p5yYM9IZBCI2D0zu8kCZDwrPSc2W6Ksnb2yTqQXNmSYoDizt
         BQ1yUx6XrqkKSOMPSLu5hrHTzcTKlSB/aDDrs82oEuovRUbDarOlA9octOSWY7qaRln7
         aBcPsuf9rIoS9HHq7ARwx+t1OKu1Iw2AbL3LpgFnW6y7sGej933I/e7YM+zQ7GlJbGct
         sDDk+QHye4IydjRhF2EKmbKw5+fxEKi5awhLIg0w8p6RKt8VKyKveR/V8vopb/RLQBVL
         3Ntg==
X-Gm-Message-State: ANoB5pmhkpCggIXBPNznrRM8ENjNJn00jiFs6VAo+2H2QrQjHj6l1yiB
        YjhzFFs9v5Id9DMN7sxhwVSofw==
X-Google-Smtp-Source: AA0mqf6yFQ/Zr1sQ3IL7aOEj2UOcufWyMxP7ToL5NqRCj1mAEVbIvOn06Bf2MT27iiWbf2u73NjWkw==
X-Received: by 2002:aa7:9d0b:0:b0:572:6da6:de4f with SMTP id k11-20020aa79d0b000000b005726da6de4fmr18747774pfp.26.1669016299760;
        Sun, 20 Nov 2022 23:38:19 -0800 (PST)
Received: from localhost ([122.172.85.60])
        by smtp.gmail.com with ESMTPSA id c4-20020a17090a558400b00210c84b8ae5sm6943843pji.35.2022.11.20.23.38.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Nov 2022 23:38:19 -0800 (PST)
Date:   Mon, 21 Nov 2022 13:08:17 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, andersson@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] OPP: Disallow "opp-hz" property without a
 corresponding clk
Message-ID: <20221121073817.7ollj7jeixrx5og5@vireshk-i7>
References: <cover.1669012140.git.viresh.kumar@linaro.org>
 <c03c4f2b9d4dcc3264d1902606c6c5c464b4b043.1669012140.git.viresh.kumar@linaro.org>
 <Y3snGQet8yc7HnJK@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3snGQet8yc7HnJK@hovoldconsulting.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-11-22, 08:22, Johan Hovold wrote:
> On Mon, Nov 21, 2022 at 12:27:48PM +0530, Viresh Kumar wrote:
> > This removes the special code added by the commit 2083da24eb56 ("OPP:
> > Allow multiple clocks for a device"), to make it work for Qcom SoC.
> > 
> > In qcom-cpufreq-hw driver, we want to skip clk configuration that
> > happens via dev_pm_opp_set_opp(), but still want the OPP core to parse
> > the "opp-hz" property so we can use the freq based OPP helpers.
> > 
> > The DT for Qcom SoCs is fixed now and contain a valid clk entry, and we
> > no longer need the special handling of the same in the OPP core.
> 
> Didn't this affect also sc8280xp?

I assumed Mani fixed all affected Qcom SoCs :(

> Perhaps you can hold off with applying
> this one for a bit until the needed devicetree changes are in linux-next
> for all the affected platforms.

Sure.

> (It looks like Mani's series only updated sm8450 and I guess Bjorn
> hasn't picked up that one up yet either.)

I applied that series today to my cpufreq/arm/linux-next, since it had
cpufreq updates too and these patches are rebased on top of them.

-- 
viresh
