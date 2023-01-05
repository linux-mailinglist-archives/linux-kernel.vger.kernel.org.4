Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF5E765ED20
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 14:33:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232864AbjAENdi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 08:33:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232676AbjAENda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 08:33:30 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10A1F2F79C
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 05:33:29 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id o8-20020a17090a9f8800b00223de0364beso2007900pjp.4
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 05:33:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=P1XTYzDF9NJQbx4B1YsRwvEAHgL0fcQoxLMdSzR8vZs=;
        b=GuqmWhu4ipfzeo5HktK3MzfCI/ZrekXDMAJgFC9c4nrIwWfyXY+Uj+c8C1a0QpbPts
         I6r+gXYIsnRn5VBxpIEbULISKk0yzbDAZP256LblS1+FoPQ+AUBq5UHZOf2jgLsXwnAG
         wU04oqcQJl9qK4PLmpdssHxZ3v2Erc0ALQjV7UgAuuEslPWCanymTxqZt+cCWCpK9Ay8
         Wxq4HYWn4ClKswVoz3kBso7kwOgoE0OhxeA6KN1BOpBIxCY1xGFsxXIS9DnggygelAy1
         8tfqUvZR6VMSgCd3KgXQqggX+PFonQqLWKYd9yMGhUagvAUTb4NDwghLV8rGrBBJyeS2
         UsxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P1XTYzDF9NJQbx4B1YsRwvEAHgL0fcQoxLMdSzR8vZs=;
        b=r4ndTF3zt/SbAqh3sTzynznx85gsWbZEKM9VsOG3hh99IXnuu+ubl2bN5aZjb3ZYan
         954klv9nBf3ccAQ8qBbWJncrJx7rP23kORgEJe42Hu4MeAsyZLrRpQDHnXsKeRa0u0hx
         g+C4HrO1CIU0tiXxBnKA+K4rk3my0pQEibFXhxcdxR1/zZpfc2EWlxetgiqgCpS8IaT0
         2tL7sck0a0wimQ8wf5HqyOFxmmDv34Wg3W8ZsQmgSCRZBCZ7FsqinlxhwpLMIFLqwRJY
         Sp3dk5ZLPWCinSYZyhbPaYL6QTrTI7iE2vqoWWCqQaPvtVNVR/qz0KDPfrQD5KsU2+H0
         /pag==
X-Gm-Message-State: AFqh2kpse/YXCKIS55P5l6ZvSRZWIAEQmGUr81rhwjPvVCNunosSDY2o
        +FcvLdOx7aUhq4AtHEJJBQQY
X-Google-Smtp-Source: AMrXdXtpjWCms1lufElm6OEGP5Qs4jSawz8d0bczXV7qXGNcgQsg/SWKwxSPduTYO6qBfTVjO/5lJg==
X-Received: by 2002:a05:6a21:3583:b0:9d:efc0:62 with SMTP id az3-20020a056a21358300b0009defc00062mr62581142pzc.10.1672925608376;
        Thu, 05 Jan 2023 05:33:28 -0800 (PST)
Received: from thinkpad ([27.111.75.153])
        by smtp.gmail.com with ESMTPSA id e28-20020a056a0000dc00b00576f7bd92cdsm14807409pfj.14.2023.01.05.05.33.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 05:33:27 -0800 (PST)
Date:   Thu, 5 Jan 2023 19:03:21 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     lpieralisi@kernel.org, robh@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, kw@linux.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_krichai@quicinc.com,
        johan+linaro@kernel.org, steev@kali.org
Subject: Re: [PATCH 1/1] PCI: qcom: Add support for system suspend and resume
Message-ID: <20230105133321.GB4463@thinkpad>
References: <20230103074907.12784-1-manivannan.sadhasivam@linaro.org>
 <20230103074907.12784-2-manivannan.sadhasivam@linaro.org>
 <Y7Qqv+kyREvXdRu1@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y7Qqv+kyREvXdRu1@hovoldconsulting.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 03, 2023 at 02:16:47PM +0100, Johan Hovold wrote:
> On Tue, Jan 03, 2023 at 01:19:07PM +0530, Manivannan Sadhasivam wrote:
> > During the system suspend, vote for minimal interconnect bandwidth and
> > also turn OFF the resources like clock and PHY if there are no active
> > devices connected to the controller. For the controllers with active
> > devices, the resources are kept ON as removing the resources will
> > trigger access violation during the late end of suspend cycle as kernel
> > tries to access the config space of PCIe devices to mask the MSIs.
> > 
> > Also, it is not desirable to put the link into L2/L3 state as that
> > implies VDD supply will be removed and the devices may go into powerdown
> > state. This will affect the lifetime of storage devices like NVMe.
> > 
> > And finally, during resume, turn ON the resources if the controller was
> > truly suspended (resources OFF) and update the interconnect bandwidth
> > based on PCIe Gen speed.
> > 
> > Suggested-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >  drivers/pci/controller/dwc/pcie-qcom.c | 52 ++++++++++++++++++++++++++
> >  1 file changed, 52 insertions(+)
> 
> I just gave this a quick spin on the sc8280xp-crd, and unfortunately
> this change appears to break suspend (e.g. hangs during suspend or
> resume). Setting a non-zero (250 MBps) peak bandwidth during suspend
> makes things work again.
> 
> Presumably something is relying on these interconnect clocks to remain
> enabled. And isn't that expected as we need to set a non-zero icc bw to
> enable the interconnect clocks during probe?
> 

After suspend, I assumed that there won't be any access to the controller
specific registers, so thought it should be fine. And it works on X13s too.
Maybe, the access to device config space is triggering issues on CRD? I will
check with Qcom.

> I'm afraid I won't have time to look into this for a while myself, but
> have you tried this on the CRD, Mani? 
> 

Thanks for testing, Johan!

I did not test this on CRD. Since both X13s and CRD are sharing the same
SoC, I thought it would work on CRD too. But since you have tested and
reported the issue, I will look into it.

> One obvious difference is the modem on the CRD which I believe neither
> of our X13s have, but this seems like more of a general problem.
> 

Yeah, this seems to be a platform issue. I will check on this behaviour and
report back.

Thanks,
Mani

> Johan

-- 
மணிவண்ணன் சதாசிவம்
