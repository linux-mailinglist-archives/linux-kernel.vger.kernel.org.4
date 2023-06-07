Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 566857254EF
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 08:58:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238563AbjFGG6X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 02:58:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238532AbjFGG6U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 02:58:20 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D28B19BD
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 23:58:15 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-652dd220d67so5933320b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 23:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686121095; x=1688713095;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nh4fHWBEz1Sr5TZZkrEsU0UWH1SdtjGoipfMtexv460=;
        b=bnBzP0j8cMrMInZQJqBsvQThQ1CjUgDjBdvee1vofjBKqB3P7P/QYSPwz5EEvOiWP2
         keVs4n6XcSdF6cTjCYzGq+/StlwCittJpYHPMBRbT/vcy6AArwOQm0h/7THFl1JeJ0Vg
         I2bI/uigd+Ctccth+LZpsbEq6m7nI+DjcbDIxbssfS1+GcTcyebckEv01y20eX14Eyfc
         lRBGrvynQq6UR35LU1MZuAn3NWmT5g1vJMkls1OZfxxBt/r63ClI4RQBb5zQCB93SyiN
         hVb20EWDVrrlDACHfxIbA6/do4YYIzRnmMhK2XSV+IszkXAKXz+1IVEViYHBHM7yz+Xs
         mnYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686121095; x=1688713095;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nh4fHWBEz1Sr5TZZkrEsU0UWH1SdtjGoipfMtexv460=;
        b=RExnmdeHxP9BU5dQmcJYYMvLKi3IOxtiTfYsxf4UE1R7X8G80p9MsyaDmFMwKF4cJy
         9D3lH179kRZViwcMz8WY5BaWnXi2Efp89DgNXg8rE4hCZ1brfyW91/h5mrp+6ik4cn1c
         PTjsPrJSU2bJbHyuQccuMdbXL5ulu52lAtLSNqktxf0zZThFE3FltQWglPgUCLHgVk0Z
         0ZO44rdvCksVxAQIIBM8pF51cxf5HgG46uT4+kUHJnMbO+B4SFuQMaLgBKPKQR5Vtgbp
         r2tsYpVyQWzpOJ0rpTNPzPLPbaTb9ftIFNRd7j2D+7X8IYq0GVTFnzR3ALTbL5HQIop3
         I93Q==
X-Gm-Message-State: AC+VfDzUbu/ud9iEYzurrUD9+TciooZDmD7TC8HUdZFfWEGafrOMbuKL
        YR3c14ORgmg5OujWFstCGb8Z
X-Google-Smtp-Source: ACHHUZ7SORdiyujXnnRSGiVRS/CQfk/KmBM4qEEakzslTa7SK9spwRxfTllyzMqkaMeA45eOHSs3uQ==
X-Received: by 2002:a05:6a21:3a84:b0:10a:fad7:43bf with SMTP id zv4-20020a056a213a8400b0010afad743bfmr2058569pzb.39.1686121094787;
        Tue, 06 Jun 2023 23:58:14 -0700 (PDT)
Received: from thinkpad ([59.92.97.244])
        by smtp.gmail.com with ESMTPSA id h129-20020a636c87000000b0050f9b7e64fasm8482555pgc.77.2023.06.06.23.58.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 23:58:14 -0700 (PDT)
Date:   Wed, 7 Jun 2023 12:28:09 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Jeffrey Hugo <quic_jhugo@quicinc.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, mhi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, loic.poulain@linaro.org
Subject: Re: [PATCH 3/3] net: mhi: Increase the default MTU from 16K to 32K
Message-ID: <20230607065809.GB5025@thinkpad>
References: <20230606123119.57499-1-manivannan.sadhasivam@linaro.org>
 <20230606123119.57499-4-manivannan.sadhasivam@linaro.org>
 <b8a25a70-8781-8b82-96d8-bc1ecf2d5468@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b8a25a70-8781-8b82-96d8-bc1ecf2d5468@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 06, 2023 at 07:50:23AM -0600, Jeffrey Hugo wrote:
> On 6/6/2023 6:31 AM, Manivannan Sadhasivam wrote:
> > Most of the Qualcomm endpoint devices are supporting 32K MTU for the
> > UL (Uplink) and DL (Downlink) channels. So let's use the same value
> > in the MHI NET driver also. This gives almost 2x increase in the throughput
> > for the UL channel.
> > 
> > Below is the comparision:
> > 
> > iperf on the UL channel with 16K MTU:
> > 
> > [ ID] Interval       Transfer     Bandwidth
> > [  3]  0.0-10.0 sec   353 MBytes   296 Mbits/sec
> > 
> > iperf on the UL channel with 32K MTU:
> > 
> > [ ID] Interval       Transfer     Bandwidth
> > [  3]  0.0-10.0 sec   695 MBytes   583 Mbits/sec
> > 
> > Cc: Loic Poulain <loic.poulain@linaro.org>
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >   drivers/net/mhi_net.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/net/mhi_net.c b/drivers/net/mhi_net.c
> > index 3d322ac4f6a5..eddc2c701da4 100644
> > --- a/drivers/net/mhi_net.c
> > +++ b/drivers/net/mhi_net.c
> > @@ -14,7 +14,7 @@
> >   #define MHI_NET_MIN_MTU		ETH_MIN_MTU
> >   #define MHI_NET_MAX_MTU		0xffff
> > -#define MHI_NET_DEFAULT_MTU	0x4000
> > +#define MHI_NET_DEFAULT_MTU	0x8000
> 
> Why not SZ_32K?

Makes sense. Will change it in next iteration.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
