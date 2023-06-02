Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 260EC71F8F3
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 05:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233626AbjFBD13 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 23:27:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231963AbjFBD1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 23:27:25 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 196A71A2
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 20:27:19 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-3f7f864525fso15916731cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 20:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685676438; x=1688268438;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4fzVJ1Qh6n3X3yZDJNAOPlld3Ovzv7tP/YDPTpU3UdA=;
        b=Q1unEDD5B8N2OMFUKodzQfNolloTMgh+wChrYJzcIXlBbNVn0ldgIUk7WtMJqH/tQf
         Ra5VN0HBmkXb4e9+vS9Nu00wlSO+YK544nB58c4MGaghrlcPSgfpHzX3oCymvWMDUlzH
         hE7bG1lZ6KZPAoAWv1G8ewhhYScwgDncNBjo1q96QXR4ieyWDikKnm0p0TEJexzyhfZG
         f7nwsncgXV4nydaOpNTGvsZxNLCnuqTQh/0w9yRgNR6QWNhak06QWQ/NVRg+qc5MJlBJ
         Y/uujXOmJwaUeW1dHBZRP0oa+OhX+gIRwXF5ZOvNg7RcaO4xoY3pgUsyshKXZ58E2hGx
         MOJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685676438; x=1688268438;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4fzVJ1Qh6n3X3yZDJNAOPlld3Ovzv7tP/YDPTpU3UdA=;
        b=NHJ0sldaLZOsiZiT9ja647g5wBoGr0YhuCVPgwUuDSMqBDjEGwLPmmKNTW03eens9M
         TgLjVe6J2UX3jI2pGIYV3rV3L4x8TZoK5DsF4d7KaxQLP7kM2fEMJAbbr4mkmgf3VUeM
         pv+FWMis78R97NMACyPSWPtTHffK2DeK9E+2EpjhhV+ykU5IYDTEN4KnyMhhFeXS5VdS
         zhWBsmqf5o+69PK5l2pXdxCeTvnRSwCk3feRAsRKbfuqqqz2SrzlUU+KfVcA2LM7CkSa
         Ji34Pr8S2A82bW4KH6bf8FBAmLkeInZ2StgO1Omob2BS+KUmoa6mkljtPYnSTsDft4d8
         eShA==
X-Gm-Message-State: AC+VfDy5zMgsYUNAn53JkuRKp/9aUa2j93wDY6EMWrwCYzm6cAgnCpZt
        BwUOl+7ZTZ9xKZ5eKiiLkfnU
X-Google-Smtp-Source: ACHHUZ5qq/CUeWNWrIdQjdJCptiuULwNuUnpW4lEK1sxxbELp3XsV5M3T7hVKplXbzSdHnxjxOPNgw==
X-Received: by 2002:a05:622a:1004:b0:3f6:833b:2368 with SMTP id d4-20020a05622a100400b003f6833b2368mr16010417qte.46.1685676438253;
        Thu, 01 Jun 2023 20:27:18 -0700 (PDT)
Received: from thinkpad ([117.217.186.123])
        by smtp.gmail.com with ESMTPSA id r9-20020a632b09000000b0052c9d1533b6sm187387pgr.56.2023.06.01.20.27.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 20:27:17 -0700 (PDT)
Date:   Fri, 2 Jun 2023 08:57:10 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Damien Le Moal <dlemoal@kernel.org>
Cc:     lpieralisi@kernel.org, kw@linux.com, kishon@kernel.org,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v5 4/9] PCI: endpoint: Warn and return if EPC is
 started/stopped multiple times
Message-ID: <20230602032710.GB5341@thinkpad>
References: <20230601145718.12204-1-manivannan.sadhasivam@linaro.org>
 <20230601145718.12204-5-manivannan.sadhasivam@linaro.org>
 <c691d9bd-9596-373e-0abe-2e776eb0d54b@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c691d9bd-9596-373e-0abe-2e776eb0d54b@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 02, 2023 at 08:18:58AM +0900, Damien Le Moal wrote:
> On 6/1/23 23:57, Manivannan Sadhasivam wrote:
> > When the EPC is started or stopped multiple times from configfs, just emit
> > a once time warning and return. There is no need to call the EPC start/stop
> > functions in those cases.
> > 
> > Reviewed-by: Kishon Vijay Abraham I <kishon@kernel.org>
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >  drivers/pci/endpoint/pci-ep-cfs.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/drivers/pci/endpoint/pci-ep-cfs.c b/drivers/pci/endpoint/pci-ep-cfs.c
> > index 4b8ac0ac84d5..62c8e09c59f4 100644
> > --- a/drivers/pci/endpoint/pci-ep-cfs.c
> > +++ b/drivers/pci/endpoint/pci-ep-cfs.c
> > @@ -178,6 +178,9 @@ static ssize_t pci_epc_start_store(struct config_item *item, const char *page,
> >  	if (kstrtobool(page, &start) < 0)
> >  		return -EINVAL;
> >  
> > +	if (WARN_ON_ONCE(start == epc_group->start))
> > +		return 0;
> 
> WARN will dump a backtrace which is fairly scary for the user. This case is
> simply a bad user manipulation of the device, so why not simply add a pr_err()
> (optional) and return -EALREADY ?
> 

There EPF core uses WARN_ON_ONCE in other similar places, so thought of sticking
to that pattern. But I agree, WARN_ON_ONCE is not strictly required here. Will
add a error log and return the appropriate error no.

Moreover, will push a patch later to change other instances as well.

- Mani

> > +
> >  	if (!start) {
> >  		pci_epc_stop(epc);
> >  		epc_group->start = 0;
> 
> -- 
> Damien Le Moal
> Western Digital Research
> 

-- 
மணிவண்ணன் சதாசிவம்
