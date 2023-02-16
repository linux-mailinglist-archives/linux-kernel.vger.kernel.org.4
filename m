Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82DC8698D5B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 07:47:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbjBPGrj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 01:47:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjBPGri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 01:47:38 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE533131
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 22:47:36 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id v6-20020a17090ad58600b00229eec90a7fso5523888pju.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 22:47:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4qpioYTyQtTtjJe3geEn16Jct1xWWb8Il+Kua3hbeGc=;
        b=GxEiY7Tfjlpz9ExzdjnJ8yKtXehKViyvt+Rk2G6MhK99Ud80Gd1s0DsDs2qNVDSHcz
         GjNYSq8NaUE0mqwmtN54PoBzyERbBC429po2OYgtui81a9SqPZxYRWs+PyUyxaK8R9q/
         EuGNEK2Nxr5eQqNVi4CAIA/AfqIIPkccGygZK6HnrBjIUdsZxExk8FS0IpEO4lmlTsqD
         YAhUykXyiowJBCl75MOTUZbkKTfdV3GBeWSJ+FxNd0ed8uVMbUezFZmdXQruTb+WHQ6E
         nAGwEvhRtphhen8BK7zLuY6ghmYxInR1Epgn0amxJWRLc34DkXU/VgirIsPSel2UIaMy
         nZew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4qpioYTyQtTtjJe3geEn16Jct1xWWb8Il+Kua3hbeGc=;
        b=tb3yvQNy0qF7enrp7qpigppuLqJT5eSifrezTdoGK5+d3i9I5Ie33M/ZQvmqjHvh4Z
         lyFYSrLV/fmwtwoNhhe7kJZ9NumB6cEgSCjSDuA1SXHrYiPdV6VryoYGTQpFcbU0QHH7
         3fGaH2yD8aKLGNIhANkV1+6tsvQWAEXNn8XiNv5qonshpODncwPaWQi7e1V20k9c6S0B
         q7TUYBOgLq1kK85ffKWFxnDOuR0CGJOxzfH1EYJR7//63QHTQ9jugqoBWTN6G0tNPoRY
         h5taQIROVX/aXQAQ3l+Yp7sqXHwaiez0BVSds7Il/Sskm1uYzBtXRuhgEhEn4z9O0VZJ
         t8Bw==
X-Gm-Message-State: AO0yUKXFbhWo+wo0rHgL04RrnwXe9F35C9MMEUAzx4qExBsSMLBqh5lL
        dG1lK/xUkRqIA8veo0iZgaWX
X-Google-Smtp-Source: AK7set9/O64pkn5dwSLCBKkisQzKtJcxKk2DnAafwqAfyzzLwryc1GWe4c5jRqNump84swALWKmltg==
X-Received: by 2002:a17:903:2888:b0:198:b99c:f6ee with SMTP id ku8-20020a170903288800b00198b99cf6eemr4198563plb.65.1676530056201;
        Wed, 15 Feb 2023 22:47:36 -0800 (PST)
Received: from thinkpad ([117.217.179.87])
        by smtp.gmail.com with ESMTPSA id d12-20020a170902b70c00b00176b84eb29asm440124pls.301.2023.02.15.22.47.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Feb 2023 22:47:35 -0800 (PST)
Date:   Thu, 16 Feb 2023 12:17:27 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Johan Hovold <johan@kernel.org>, Viresh Kumar <vireshk@kernel.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, andersson@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        robdclark@gmail.com
Subject: Re: [PATCH 2/2] OPP: Disallow "opp-hz" property without a
 corresponding clk
Message-ID: <20230216064727.GA2420@thinkpad>
References: <cover.1669012140.git.viresh.kumar@linaro.org>
 <c03c4f2b9d4dcc3264d1902606c6c5c464b4b043.1669012140.git.viresh.kumar@linaro.org>
 <Y3snGQet8yc7HnJK@hovoldconsulting.com>
 <20221121073946.GE11945@thinkpad>
 <20230125042145.hrjpnskywwqn7b6v@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230125042145.hrjpnskywwqn7b6v@vireshk-i7>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Rob Clark

On Wed, Jan 25, 2023 at 09:51:45AM +0530, Viresh Kumar wrote:
> On 21-11-22, 13:09, Manivannan Sadhasivam wrote:
> > That's right. I have proposed to do the similar change to other SoCs as well
> > once the series was completely merged. I thought of doing so for 6.3.
> > 
> > Btw, there seems to be one more candidate:
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/boot/dts/qcom/sm8250.dtsi#n2537
> > 
> > Looks like newer SoCs that has the GMU within the GPU block doesn't have clock
> > property. This is because, GMU is the one supplying clocks to the GPU unlike the
> > old SoCs where the clocks used to come from GCC itself.
> > 
> > But we do have a GMU devicetree node, so it should be a matter of adding the
> > clock provider support as done for cpufreq and represent it in devicetree.
> > 
> > I'll ping Rob Clark and see how to get it done.
> 
> Any update on this Mani ? I want to get the hack removed if possible.
> 

Hi Viresh,

Sorry for the delay. I've submitted the dts changes [1] to handle the CPU clocks
for the rest of the Qcom SoCs.

For the Qcom GPUs, I've CCed Rob Clark who is the maintainer.

Rob, here is the background on the issue that is being discussed in this
thread:

Viresh submitted a series [2] back in July to improve the OPP framework, but
that ended up breaking cpufreq on multiple Qcom SoCs. After investigation, it
was found that the series was expecting the clocks supplied to the OPP end
devices like CPUs/GPUs to be modeled in DT. But on Qcom platforms even though
the clocks for these nodes are supplied by a separate entity, like CPUFreq
(EPSS/OSM) for CPUs and GMU for GPUs, there was no clock property present in
the respective nodes. And these nodes are using OPP table to switch frequencies
dynamically.

While the series was merged with a hack that still allows the OPP nodes without
clock property in DT, we came to an agreement that the clock hierarchy should
be modeled properly.

So I submitted a series [3] that added clock provider support to cpufreq driver
and sourced the clock from cpufreq node to CPU nodes in DT.

Likewise, it should be handled for the adreno GPUs whose clock is managed by
GMU on newer SoCs. Can you take a look at this?

Thanks,
Mani

[1] https://lore.kernel.org/linux-arm-msm/20230215070400.5901-1-manivannan.sadhasivam@linaro.org/
[2] https://lore.kernel.org/lkml/cover.1657003420.git.viresh.kumar@linaro.org/
[3] https://lore.kernel.org/linux-arm-msm/20221117053145.10409-1-manivannan.sadhasivam@linaro.org/

> -- 
> viresh

-- 
மணிவண்ணன் சதாசிவம்
