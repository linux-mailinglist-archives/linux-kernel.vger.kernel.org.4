Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5301D74DAED
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 18:21:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbjGJQVo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 12:21:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbjGJQVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 12:21:35 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BEF6183
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 09:21:32 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-6686ef86110so2418830b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 09:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689006092; x=1691598092;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vfcPZlZr3mdkM9arjRR44/bpm6ljGJo75Sv2bEfD5mU=;
        b=KjWKZE1qcXhZVpoj2YhhO7r+UYXQH30t6sXWA7bXsx0b1usqPAT6OmGete3KdH/UbH
         dYyKBYJoCwXyg1axVKJcrYmgrvZZT+aR/2/077bDAa5XvsAlj3PIpXTmywc+s5Wq99PU
         5Wt6CBXe/uQYTfkkbefkKGd1QPFjyfol75vQOcfQ5ZXOJf5Nlg9f5J8yYuL4wLljwgTP
         oYWlCqvZup0IbKuMVwCljSkuTLP4iQCKrPe6eEQC0su2DosBvzBXA8bVfw17f+bxxA/P
         jyQNwSHBTrCbEKbpyLaLVvWdgYuPx3kgh51QM54fhb4AlfjL/+xA/r6LtwrR6NF3Xs6U
         Mf/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689006092; x=1691598092;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vfcPZlZr3mdkM9arjRR44/bpm6ljGJo75Sv2bEfD5mU=;
        b=Me48XCWy/ixf4bynYfun4/GPVU1Qzb7fuDfIcsS4Y23m6VZQooXkkt2VN7XfklIt9h
         1PF3mf9MmU9tqx5iLjMfb5dA7LSyBknCTiShI/0wN5gDlSoFwZ0Gyu1s3UD3vCQYqYtH
         +xY5s46AlmjFU6OSKZP8f/f/zpcLQHSdOZQs1p6OFIccI1scWBNurtHeCe3FqP+R/gXs
         16Q3TszUOAIqaX21QhE4ca7/rsF3UcTogS0F3rNokxz9nn4XT3qzq/V9UixJ9Sbdnbei
         5taaUT7rziUxa2xt44Y5iH9fSCBPDkY9vhTj5fzyecaIR8BzxvyeuJVdCucSIF2TlxQr
         xtnA==
X-Gm-Message-State: ABy/qLZQZV9pqJueOg5cCXdL1TyXPKSVoI6Kmk8zl5/mV96+gzwxizeM
        yHEUalRnaXh4cuFF5YsRtobrNwXkAGoqo4fNjKX4A+JQ
X-Google-Smtp-Source: APBJJlGkFx0CYRDda5KUqcE39FlDkt7F0hKQEq1zWT22hVli6mVGbCQWDCBw6ZqXDnLRzLoWWsw0Eg==
X-Received: by 2002:a05:6a20:6a0f:b0:12e:5fd0:f4af with SMTP id p15-20020a056a206a0f00b0012e5fd0f4afmr12498820pzk.28.1689006091878;
        Mon, 10 Jul 2023 09:21:31 -0700 (PDT)
Received: from google.com (41.183.143.34.bc.googleusercontent.com. [34.143.183.41])
        by smtp.gmail.com with ESMTPSA id i5-20020a1709026ac500b001b80b342f61sm77877plt.268.2023.07.10.09.21.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 09:21:31 -0700 (PDT)
Date:   Mon, 10 Jul 2023 21:51:22 +0530
From:   Ajay Agarwal <ajayagarwal@google.com>
To:     Johan Hovold <johan@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Sajid Dalvi <sdalvi@google.com>
Subject: Re: [PATCH] Revert "PCI: dwc: Wait for link up only if link is
 started"
Message-ID: <ZKwwAin4FcCETGq/@google.com>
References: <20230706082610.26584-1-johan+linaro@kernel.org>
 <20230706125811.GD4808@thinkpad>
 <ZKgJfG5Mi-e77LQT@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZKgJfG5Mi-e77LQT@hovoldconsulting.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,FSL_HELO_FAKE,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 07, 2023 at 02:47:56PM +0200, Johan Hovold wrote:
> On Thu, Jul 06, 2023 at 06:28:11PM +0530, Manivannan Sadhasivam wrote:
> > On Thu, Jul 06, 2023 at 10:26:10AM +0200, Johan Hovold wrote:
> 
> > > Finally, note that the intel-gw driver is the only driver currently not
> > > providing a start_link callback and instead starts the link in its
> > > host_init callback, and which may avoid an additional one-second timeout
> > > during probe by making the link-up wait conditional. If anyone cares,
> > > that can be done in a follow-up patch with a proper motivation.
> 
> > The offending commit is bogus since it makes the intel-gw _special_ w.r.t
> > waiting for the link up. Most of the drivers call dw_pcie_host_init() during the
> > probe time and they all have to wait for 1 sec if the slot is empty.
Mani, can you please explain how my commit made the intel-gw driver
special? The intel driver actually fails the dw_pcie_host_init if the
link does not come up. That was my motivation behind adding the fail
logic in the core driver as well.
> 
> Just to clarify, the intel-gw driver starts the link and waits for link
> up in its host_init() callback, which is called during probe. That wait
> could possibly just be dropped in favour of the one in
> dw_pcie_host_init() and/or the driver could be reworked to implement
> start_link().
> 
> Either way, the call in dw_pcie_host_init() will only add an additional
> 1 second delay in cases where the link did *not* come up.
> 
> > As Johan noted, intel-gw should make use of the async probe to avoid the boot
> > delay instead of adding a special case.
> 
> Indeed.
> 
> Johan
Johan, Mani
My apologies for adding this regression in some of the SOCs.
May I suggest to keep my patch and make the following change instead?
This shall keep the existing behavior as is, and save the boot time
for drivers that do not define the start_link()?

```
diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index cf61733bf78d..af6a7cd060b1 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -492,11 +492,8 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
                if (ret)
                        goto err_remove_edma;

-               if (pci->ops && pci->ops->start_link) {
-                       ret = dw_pcie_wait_for_link(pci);
-                       if (ret)
-                               goto err_stop_link;
-               }
+               if (pci->ops && pci->ops->start_link)
+                       dw_pcie_wait_for_link(pci);
        }

        bridge->sysdata = pp;
```
