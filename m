Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AD2062DB0D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 13:38:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234823AbiKQMiw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 07:38:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234648AbiKQMit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 07:38:49 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5B5A71F3B
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 04:38:48 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id v28so1624544pfi.12
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 04:38:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zp3c04UgsO642CTDLrQtBDqG8kkhqKp0rcovQL+99UI=;
        b=IdGUNhLwGzU6Ft16WaaDI69WkZxTSnWWMFM5OCfCjwJp6AYTlRKK8yEYeEBXfQpzAn
         ZwQb4qA1/IFweomkA/ECAhRqA4U01wUuafmgn6Qa9F9ktepp04hp8xQrAzH/kT/KVbNs
         ZzyfjwzErH6r/TzqvbFIDYg5LREwJ28M1rw20fir0tKQOYEL3IWwpSwdn38FrjgzhFI7
         9FYu4SJvvaD6rkDwNrsTWjiz4I1r07qeWCDUkRVVDcoDj3wwcR9VYPqfWBmSzUjTpcIm
         611qXXCmSvpYGc1TA+nRL6Pzun4MN7R0UsfCiRYEKntVXs7/p5+BHqQu16hPCOk8kDFf
         8rXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zp3c04UgsO642CTDLrQtBDqG8kkhqKp0rcovQL+99UI=;
        b=0k/QpH0xsJzd7TJdMN/xto61TXGL9G4HLFnmBSXglxuvS4LNb86UdpY9nKC1NrbWEr
         Z2Gfpj7+NyJG/PBQIp3VAMGUzFZ2yq1JRskyO9klWr+OFB1muOt0xrhXwumoXyrQtWqE
         yky+oWb4iz1kJaA1tAtumlOg3+AxJ6F7lT2E1ghGVIFssprPOH8rg+TvIgTCkmB03DkS
         z8rs2p+ySWbgwxVDGnDajsO5TmtioIPkzGNVVUFTGAJmkR+BWeE7KLFxvZ7SD6Q+e2vH
         FVmNHpg+FrAEQXiELbZDzN10vrF1R4Vyp87/9ulKmv/klACCxGsAcXDoEnd/hZBmYOc4
         vJaw==
X-Gm-Message-State: ANoB5pkiSm/fWMmZnB2fMjGsJivotsqZ7+gshkokYiVlrGPjlwGjwTcK
        YrVc79eo44qlPkJW8zvoncSj
X-Google-Smtp-Source: AA0mqf4hm3wB6rMWKzlah1bNY3uCQyjDr05R8iD4P68ORutJSUYHKw2sKcDzbo3XAcxAPjfPAntBmA==
X-Received: by 2002:a62:442:0:b0:55f:8da3:71d2 with SMTP id 63-20020a620442000000b0055f8da371d2mr2808498pfe.37.1668688728266;
        Thu, 17 Nov 2022 04:38:48 -0800 (PST)
Received: from thinkpad ([117.193.208.31])
        by smtp.gmail.com with ESMTPSA id p12-20020a170902eacc00b00177f82f0789sm1181514pld.198.2022.11.17.04.38.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 04:38:47 -0800 (PST)
Date:   Thu, 17 Nov 2022 18:08:41 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     andersson@kernel.org, viresh.kumar@linaro.org,
        krzysztof.kozlowski+dt@linaro.org, rafael@kernel.org,
        robh+dt@kernel.org, johan@kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v7 0/4] qcom-cpufreq-hw: Add CPU clock provider support
Message-ID: <20221117123841.GI93179@thinkpad>
References: <20221117053145.10409-1-manivannan.sadhasivam@linaro.org>
 <20221117101903.sw3hxaruj5sfhybw@bogus>
 <20221117111207.GA93179@thinkpad>
 <20221117115203.356vexlpca746o6m@bogus>
 <20221117115807.GF93179@thinkpad>
 <20221117120846.yhmilsndw2bmmvnv@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221117120846.yhmilsndw2bmmvnv@bogus>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2022 at 12:08:46PM +0000, Sudeep Holla wrote:
> On Thu, Nov 17, 2022 at 05:28:07PM +0530, Manivannan Sadhasivam wrote:
> > On Thu, Nov 17, 2022 at 11:52:03AM +0000, Sudeep Holla wrote:
> > > On Thu, Nov 17, 2022 at 04:42:07PM +0530, Manivannan Sadhasivam wrote:
> > > > On Thu, Nov 17, 2022 at 10:19:03AM +0000, Sudeep Holla wrote:
> > > > > 
> > > > > Why do you need the above 3 changes if the below(4/4) will ensure
> > > > > cpufreq_get(cpu) returns the clock frequency. I was expecting to drop the
> > > > > whole "confusing" clock bindings and the unnecessary clock provider.
> > > > > 
> > > > > Can't we just use cpufreq_get(cpu) ?
> > > > > 
> > > > 
> > > > This can be possible for OPP implementations for the CPUs but not for other
> > > > peripherals making use of OPP framework like GPU etc... Moreover this may end
> > > > up with different code path for CPUs and other peripherals inside OPP framework.
> > > > 
> > > 
> > > Fair enough, you can use this for non-CPU devices. But you are adding this for
> > > CPUs here. Is the consumer unaware that this is a CPU or non-CPU device ?
> > > If so, make sense. Otherwise, it is unnecessary to go through the clk
> > > framework to get CPU frequency.
> > > 
> > 
> > The consumer here is the OPP framework and yes it doesn't have the knowledge of
> > the device it is dealing with (for this context).
> 
> Ah OK, I thought it is something else. Does this mean OPP is tied with clk
> framework or clock bindings ? Is this for some specific feature ?

AFAIK, OPP framework needs to know the current frequency of the device it is
dealing with for setting the device's OPP. So it uses clk_get_rate() of the
first clock of the device. If the clock is not available, then it uses the
frequency in the first entry of the OPP table (since it is going to be the
minimum freq of the device).

As you can see, the clk_get_rate() is eminent for switching the OPPs and since
OPP framework doesn't know what device it is dealing with, it cannot use
cpufreq_get().

> Or is it
> compulsory for all the devices using OPP ? Just wondering how this affects
> SCMI which doesn't use or provide clocks yet.

Is SCMI node itself has the OPP tables? Or the consumer nodes of the SCMI?

TLDR; If you tell OPP framework to set a new OPP for a device, it needs to the
know the current frequency of the device. And it is not manadatory now, but in
the future maybe.

Thanks,
Mani

> -- 
> Regards,
> Sudeep

-- 
மணிவண்ணன் சதாசிவம்
