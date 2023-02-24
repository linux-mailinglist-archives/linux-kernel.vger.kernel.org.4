Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A41E66A17C7
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 09:16:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbjBXIQh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 03:16:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjBXIQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 03:16:35 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D07FE4988A
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 00:16:33 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id bn17so1459374pgb.10
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 00:16:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677226593;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dn8fVHgRka3CBf4dzz7H6jMzvwom75gm7qdg9exDmI8=;
        b=D6OP0tN8sWZPahHKSNFOdt5zMUoSL24vbs19CEVifu6csXgKLCyaORPLR7nlYEscIW
         CMLFLxVz6oDUmrfXo6FD3CmqiwWIT+LYxZ8VpVHYH9p+SvRHEbpKMk+un+xjeKWZsbT1
         84lcvdG97Yx8HD26L8LXaUy7PDAixssklYvc57av36HofSVZlf1xvEJOAG36gDm37+vc
         QmyGjX/VXXd+QC3/MKYXwyqPzyT9wkTqgWnYYWq76RTHzJffTO9e+sIRBFV9ivz+aNMo
         g4zaMjaBz2MctSzJNPegGyCURJq2oCyD8Rb0c54cqmbOUE/gDq4iTes2X+NZSZZrRmyE
         Tc/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677226593;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dn8fVHgRka3CBf4dzz7H6jMzvwom75gm7qdg9exDmI8=;
        b=2wOk4KronCZE+gv02MkSiDd51RkKCPvlkncyfXwbP8iqaDWX8zkv0WwEFddFxwMuRX
         a4v3lcNzRJ0DonY1oEGKVUnGDxCdOFzgXafPBbSjGCcjwTIUrG8q51El/0iqhhNHcgtc
         Qd+cOJ2oR09HSJmoJX6P7ey+U4pgyJD8e60IV24lUny/zy6cF1eKL0WRc8toVP47QARK
         GuJpAMyNENjb/CizrHkw8m8t9hfheXNsHXRc2/KZPHOHXlGF+lgDQ7jxroXo3MRVKwfA
         30mK/JwOyB2JDMth3rJeY/rdUY9z7Bjm7umtdU30qqV1WBTwTDWjTs4B3KLVB+3u6lU2
         esFg==
X-Gm-Message-State: AO0yUKV/WbH00TDCvEk2pW1VRb+0SjNGSL+o41BY0XyMktuDUUt7Kpjq
        vYdi7ys6HGjY+Dvjveex2lL16Q==
X-Google-Smtp-Source: AK7set+bnaya8ymLWEYRvTWs9lZspJeRhG8CRI6ADbV1PFLfGuBYqop0ppIL4j8Q6sthEyfOWxAvzQ==
X-Received: by 2002:a62:1ccb:0:b0:5a9:d5c7:199a with SMTP id c194-20020a621ccb000000b005a9d5c7199amr12889650pfc.8.1677226593285;
        Fri, 24 Feb 2023 00:16:33 -0800 (PST)
Received: from niej-dt-7B47 (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id x16-20020aa784d0000000b0058bc60dd98dsm6408427pfn.23.2023.02.24.00.16.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 00:16:32 -0800 (PST)
Date:   Fri, 24 Feb 2023 16:17:03 +0800
From:   Jun Nie <jun.nie@linaro.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     cw00.choi@samsung.com, Nishanth Menon <nm@ti.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] OPP: Simplify set_required_opp handling
Message-ID: <Y/hyf+/EqEeTu436@niej-dt-7B47>
References: <cover.1677063656.git.viresh.kumar@linaro.org>
 <CABymUCMhoKoFHy8K6-ohrcAbyTpDe0Hig3oUM_wH4Db0-9yx+g@mail.gmail.com>
 <20230224021713.stpcykx2tjkjwyti@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230224021713.stpcykx2tjkjwyti@vireshk-i7>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 24, 2023 at 07:47:13AM +0530, Viresh Kumar wrote:
> On 23-02-23, 17:56, Jun Nie wrote:
> > It looks promising. The function get_target_freq_with_cpufreq() can be wrapped
> > to act as set_required_opps() callback.
> 
> > But my case is a bit complicated. CPU opp depends on both genpd opp and
> > devfreq opp.
> 
> I was wondering if we will have such a case soon enough or not :)
>  
> > So the genpd_virt_devs array need
> > to be modified or add another array for devfreq case. While genpd_virt_devs is
> > bounded with genpd directly and coupled with "power-domains" list in
> > device tree.
> > Current required-opp nodes are designed to be aligned with the list. I
> > am considering
> > what's the best way for back compatibility.
> 
> Please look at the top commit here:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git opp/propagate
> 
> Will this be enough for your use case ? I will post everything again once we are
> settled on a solution.

For the opp lib, this is right direction. We still need to find a method to
pass devfreq device node to opp lib, just genpd_virt_devs for power domain.
But I am not clear below is the right way yet and this also involves wider
changes. Or the opp's owner, devfreq device can be referred via opp lib?
If so, we do not need to add devfreq-devs to cpu node at all.

		cpu1: cpu@101 {
			compatible = "arm,cortex-a53";
			device_type = "cpu";
			power-domains = <&cpr>;
			power-domain-names = "cpr";
			devfreq-devs = <&cci>;
			devfreq-names = "cci";
			operating-points-v2 = <&cluster1_opp_table>;
		};

		opp-200000000 {
			opp-hz = /bits/ 64 <200000000>;
			required-opps = <&cpr_opp3>, <&cci_opp1>;
		};

> 
> -- 
> viresh
