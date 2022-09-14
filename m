Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 535565B816A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 08:13:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbiINGNr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 02:13:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbiINGNM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 02:13:12 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 710797198F
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 23:12:58 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id go6so9316195pjb.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 23:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date;
        bh=nOBwV7zD7+DTTpu2RK0hUunUjebAM5dH9U/z6ps0Qmg=;
        b=YbpxUjlQOGGXqj2Xh2EVFLGC/I8prjgaJZkYUd0xwMKcjkguC4b1JtZNGIAawgMaAc
         srtLXKEJ0V2nj7DGlfF/I9k36k3nCDoaZb11y+BX0t8809jCz+RsqE8l3xvyDL/uxp58
         YsMwUdz3AT4XgJ+B7w3GCmqhvKnR61cZfsSWwBvBCuAi11MkUQ67sD7ETsUs1XxlCafR
         JKqnMwPVW76MGgoyE4sYizePXDpKYYFSDpCykAC4GXRQyVUuvl12cx9j6nKmVHfo13HD
         oHpdLKAe/dhihEqkGYt3jhVfl5EKCstqZCEd9MqTYL6VKNqfBmJmlxR1wGk82TeksBK5
         8mDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date;
        bh=nOBwV7zD7+DTTpu2RK0hUunUjebAM5dH9U/z6ps0Qmg=;
        b=bYmJicNGhN0W2NzDVNkwVxAZmeGSID4qBOBwmdrBvQSVPHcsU2cV6JSyk3lt0vn6HC
         F5hp1lW596knW99E2I5DY/PPiRKsB1ujfdE7SUk0Z2RBRJsFC7blBEMSS7uGclAI5GGy
         Vh4Tj2xULuj1E4FCm+MKahZkCV2zv6KDylDqpUXc/PEl0F0Mg5ap6M8zFXHRkPjrb424
         g+PGo7U7LCk3iKgFhsLFUc96jL1bZP0VzcaykU4/+YMDw/uZvBk12EVQwekf1Ed7fM4+
         Bw+wLKU0/Mm9HRiJru61KKVN2MGORPxyOvX86mnruLP+4VSWy/4NRNMBtepWK0Ets4Rj
         omcg==
X-Gm-Message-State: ACgBeo3+oJFjxRtQfvPxc2k0OTUj0eLK9P7ddreE3i2DWvwyVh5T6ROJ
        PorNkgYCMEgZWgP4LZWOpx+M
X-Google-Smtp-Source: AA6agR7WwlEHge+gEuiwlOhrUSQc02S25CmbQjEC8HIHt2FaG+cUdWkvyeQSALaa+F+JpdxOXv3rFw==
X-Received: by 2002:a17:903:41c6:b0:178:348e:f760 with SMTP id u6-20020a17090341c600b00178348ef760mr12675069ple.123.1663135977914;
        Tue, 13 Sep 2022 23:12:57 -0700 (PDT)
Received: from workstation ([117.202.184.122])
        by smtp.gmail.com with ESMTPSA id h6-20020a170902f54600b0016c4546fbf9sm9676237plf.128.2022.09.13.23.12.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 13 Sep 2022 23:12:57 -0700 (PDT)
Date:   Wed, 14 Sep 2022 11:42:51 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     Vidya Sagar <vidyas@nvidia.com>, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com, lpieralisi@kernel.org,
        robh@kernel.org, kw@linux.com, bhelgaas@google.com,
        treding@nvidia.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, kthota@nvidia.com,
        mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V1] PCI: dwc: Use dev_info for PCIe link down event
 logging
Message-ID: <20220914061251.GC16459@workstation>
References: <20220913101237.4337-1-vidyas@nvidia.com>
 <20220913165159.GH25849@workstation>
 <b1c243b0-2e6e-3254-eff0-a5276020a320@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1c243b0-2e6e-3254-eff0-a5276020a320@nvidia.com>
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

On Tue, Sep 13, 2022 at 06:00:30PM +0100, Jon Hunter wrote:
> 
> On 13/09/2022 17:51, Manivannan Sadhasivam wrote:
> > On Tue, Sep 13, 2022 at 03:42:37PM +0530, Vidya Sagar wrote:
> > > Some of the platforms (like Tegra194 and Tegra234) have open slots and
> > > not having an endpoint connected to the slot is not an error.
> > > So, changing the macro from dev_err to dev_info to log the event.
> > > 
> > 
> > But the link up not happening is an actual error and -ETIMEDOUT is being
> > returned. So I don't think the log severity should be changed.
> 
> Yes it is an error in the sense it is a timeout, but reporting an error
> because nothing is attached to a PCI slot seems a bit noisy. Please note
> that a similar change was made by the following commit and it also seems
> appropriate here ...
> 

I got the concern. But the problem here is, we cannot distinguish if the
error is due to slot empty or an actual issues with link/phy. Also it
should be noted that if the slot is empty, the dwc core anyway waits for
the link to be up. IMO this is a boot time overhead that could be
avoided if the specific instance could be disabled in platform data like
devicetree.

> commit 4b16a8227907118e011fb396022da671a52b2272
> Author: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> Date:   Tue Jun 18 23:32:06 2019 +0530
> 
>     PCI: tegra: Change link retry log level to debug
> 
> 
> BTW, we check for error messages in the dmesg output and this is a new error
> seen as of Linux v6.0 and so this was flagged in a test. We can ignore the
> error, but in this case it seem more appropriate to make this a info or
> debug level print.
> 

On some of the Qcom based platforms, we avoid this situation by
disabling the specific PCIe node in devicetree for which we know that
there would be no devices connected.

This not only avoids the error message in log but also removes the time
spent waiting for link to be up.

Thanks,
Mani

> Jon
> 
> -- 
> nvpublic
