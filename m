Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F2D15B78E3
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 19:54:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233683AbiIMRxO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 13:53:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232903AbiIMRwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 13:52:36 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC04C6AA35
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 09:52:05 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id b21so12428122plz.7
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 09:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date;
        bh=mOxAMUogtoyYUzgUNAUeU/aryd/IVil8/scHRPr/eFw=;
        b=aarOS6S7gYd7JGHJjJgCzUOjml0HcNO0Qmcym4j8zO0MvyOYbMrv0NxMtO2a/biFeQ
         o0Xqn+dWFXNJzrgeE2QE0cSXP23X8q+mc2+Y6jcWYs42+TLO57Qj5PF0GOfSZ+W3oDop
         Hjd10pmYMHhG34tcVzS6yGrrZp3Jgsl5RznXwu3BH0iHpUWU+Bce0fwXz7z4e4xFEDuO
         nGFvSS7r9yJdv+sDJ0OrxlFZKj9accAm479+GhXPR0rBu3//OAY6e+jcJ1GhJdtdGVpp
         RqTSvPnZpP/tVL/Uljnzi5t/dbPPqTDnARrx5Om9TX8+H8yd08jvpc3rKWAzudTSlLp8
         qvnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date;
        bh=mOxAMUogtoyYUzgUNAUeU/aryd/IVil8/scHRPr/eFw=;
        b=spGzN04JnSOAa/wUPsIwAFgH2OWiZ3XU0IR+4ksCTohbgPDnh9xFjap5LELzUwYWH9
         gEg5CgZoF3gLY5iHaukEoxmTN9JVPNQbeyJB5HZjenpWDoh7KSBQPJQb3RRWN9UrL7gA
         5UMFhM/kswrDM6Ndz4uhQSqCcaU1LgojNLz90Rw3F/4+akXysTnokPlF/rB0uqPUrPsp
         CGOFmTxWRap9mthGaW030/X/72KJQLoPG7c+sMevT82Mcn0Gq0PbIkJBmqYskDkXQeqb
         afdf7hXgcQcVp465d2+pTXME8G13zSuzAFR8qpWnsL2Jl5PbQZc+wrgPF1aCa5kZ9jbu
         O31A==
X-Gm-Message-State: ACgBeo3L+BCbwtGSu6UTmMv/UQJONBs0Q4GfrC8ZmYqMk9+brNW0EXeA
        NB6807ivEOqDrIcqwU8a4nRY
X-Google-Smtp-Source: AA6agR5G8ywMFC6Ev8+ovqpgBABc21gMNzFuXa9i0WAbkzl9/zuBT2661JF0GnSjQQYvMlf9iMJogg==
X-Received: by 2002:a17:903:186:b0:178:2ca7:fae5 with SMTP id z6-20020a170903018600b001782ca7fae5mr11829857plg.173.1663087925186;
        Tue, 13 Sep 2022 09:52:05 -0700 (PDT)
Received: from workstation ([117.202.184.122])
        by smtp.gmail.com with ESMTPSA id x1-20020a170902ec8100b0017854cee6ebsm335327plg.72.2022.09.13.09.52.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 13 Sep 2022 09:52:04 -0700 (PDT)
Date:   Tue, 13 Sep 2022 22:21:59 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        lpieralisi@kernel.org, robh@kernel.org, kw@linux.com,
        bhelgaas@google.com, treding@nvidia.com, jonathanh@nvidia.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kthota@nvidia.com, mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V1] PCI: dwc: Use dev_info for PCIe link down event
 logging
Message-ID: <20220913165159.GH25849@workstation>
References: <20220913101237.4337-1-vidyas@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220913101237.4337-1-vidyas@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 13, 2022 at 03:42:37PM +0530, Vidya Sagar wrote:
> Some of the platforms (like Tegra194 and Tegra234) have open slots and
> not having an endpoint connected to the slot is not an error.
> So, changing the macro from dev_err to dev_info to log the event.
> 

But the link up not happening is an actual error and -ETIMEDOUT is being
returned. So I don't think the log severity should be changed.

Thanks,
Mani

> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index 650a7f22f9d0..25154555aa7a 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -456,7 +456,7 @@ int dw_pcie_wait_for_link(struct dw_pcie *pci)
>  	}
>  
>  	if (retries >= LINK_WAIT_MAX_RETRIES) {
> -		dev_err(pci->dev, "Phy link never came up\n");
> +		dev_info(pci->dev, "Phy link never came up\n");
>  		return -ETIMEDOUT;
>  	}
>  
> -- 
> 2.17.1
> 
