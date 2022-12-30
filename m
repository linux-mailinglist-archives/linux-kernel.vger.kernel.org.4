Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 779D6652C93
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 06:55:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234413AbiLUFzu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 00:55:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234409AbiLUFzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 00:55:42 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A3421DDD4
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 21:55:38 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id 130so9966085pfu.8
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 21:55:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TaGVUxRUg0LoszCXjRP27hhaB8J+I3ZvWI15G+yWA+I=;
        b=Q4X+/Nj5MG5IJNmLNnYZO/3PjdSmzZnvtqzOIF7vVgzizc31le+nFsOp0ozBrnntm0
         dlQd+fC4HdT0xQyQB3PUk5lUIIjuLwXRpVfYP5GsDg2NqXyQexDmnGV/BbatjAW+e3yI
         S7Pg//+r1sNLRKqJJiohIA1CFqjf6q2eFZ501XnRW/m0TrBmd3T6t7pULd+pOOoBrPab
         3CrD/pYazWJZ3m4lOMZg8iS1AD2xGqB487XWqu2C4g42Yy9MNDEwIT0XcfdYL0zbl86W
         jGmW8Qf9f5o8SjSXRRLtphSYh6rfcU07tG6DAfh4xwQh2uZLUJDYGfCJ23rMUSU9W5rW
         w2Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TaGVUxRUg0LoszCXjRP27hhaB8J+I3ZvWI15G+yWA+I=;
        b=BZ8aCpUau5pKnJsKRVpL8c9+GgDVSMc4ZV2+pvfNh+AYU1bnleC5WHmqYSB+1a/keX
         7n4Lk04KI+csqKpLgmob2qnGQJaOGKYpDIM5s11VwT8ybrSIoAYoDyOXy9q5LEkWgxme
         L1lCv8BiuApKGmbhznWTaGc62h/xl4/cAudBW7R2/ySWhLJAhj349RjFeklbOrgnaCER
         sdhyhiqFQyXiuvuOe3V9/XArSamqyl50MogOy67u72GKovwqSBXM2vImptT1JQczsyCe
         qy9cqwnjtk1QwCe4csE9sbgegH8N0x19dI1uPTEJkNNaYJ1y4FwtdmEDb6DqnpClFKwg
         6itQ==
X-Gm-Message-State: AFqh2krExno0+Kb/S2vLALCG7egk1iZMnOWegunny6f4cDD0+Lynu3KQ
        IWXK8RHazy5f6LXVaIo/41PU
X-Google-Smtp-Source: AMrXdXtp5/WrpKvsBrj1r58d1R59LMAQOzJMUCEth4YEP8J7CqflCHtNTidWpMyzqLMFNwkCbCZ0kQ==
X-Received: by 2002:a62:644b:0:b0:577:51b1:375e with SMTP id y72-20020a62644b000000b0057751b1375emr1211143pfb.26.1671602137937;
        Tue, 20 Dec 2022 21:55:37 -0800 (PST)
Received: from thinkpad ([117.217.177.7])
        by smtp.gmail.com with ESMTPSA id o198-20020a62cdcf000000b00575d90636dcsm9616173pfg.6.2022.12.20.21.55.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 21:55:36 -0800 (PST)
Date:   Wed, 21 Dec 2022 11:25:26 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Steev Klimaszewski <steev@kali.org>, andersson@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        tony.luck@intel.com, quic_saipraka@quicinc.com,
        konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, james.morse@arm.com,
        mchehab@kernel.org, rric@kernel.org, linux-edac@vger.kernel.org,
        quic_ppareek@quicinc.com, luca.weiss@fairphone.com,
        ahalaney@redhat.com
Subject: Re: [PATCH v3 06/15] arm64: dts: qcom: sc8280xp: Fix the base
 addresses of LLCC banks
Message-ID: <20221221055526.GB2922@thinkpad>
References: <20221219182958.476231-1-manivannan.sadhasivam@linaro.org>
 <20221219182958.476231-7-manivannan.sadhasivam@linaro.org>
 <CAKXuJqgL5GsyjaNpkeMf4=72sjw+6ytFUm+yt1WjLyoFLrgm3g@mail.gmail.com>
 <20221220095207.GA38609@thinkpad>
 <Y6JLV4XG/6xDFrN/@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y6JLV4XG/6xDFrN/@zn.tnic>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 21, 2022 at 12:55:03AM +0100, Borislav Petkov wrote:
> On Tue, Dec 20, 2022 at 03:22:07PM +0530, Manivannan Sadhasivam wrote:
> > This is a genuine use-after-free bug that happens because the edac core frees
> > the memory assigned to "llcc_driv_data" pointer that gets passed as "pvt_info".
> > 
> > Here, the LLCC driver is one creating the "qcom_llcc_edac" platform device and
> > also allocating memory for "llcc_driv_data". But since during qcom_edac driver
> > removal, we are just unregistering the driver and the platform device still
> > stays around, the edac driver is not supposed to free any memory associated
> > with the platform device.
> 
> If you mean
> 
> __edac_device_free_ctl_info()
> 
> it is very well supposed to free it as it allocates it in
> edac_device_alloc_ctl_info().
> 
> If qcom_llcc_edac_probe() simply goes and assigns something of its own
> to edev_ctl->pvt_info, then that driver gets to keep the pieces ofc.
> 

Right. It is the issue of the qcom driver from the start.

Thanks,
Mani

> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette

-- 
மணிவண்ணன் சதாசிவம்
