Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E69816C2F7B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 11:49:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230419AbjCUKt3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 06:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230410AbjCUKtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 06:49:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFC155259
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 03:49:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7BE0AB81289
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 10:49:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DE89C4339E;
        Tue, 21 Mar 2023 10:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679395748;
        bh=lFrhGmdkTFxcK/nSQtquZbsauyHMMzGRh7efYYXHDPo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JR/nMl0sAK2bVSXiC1DPMMbcGlrE8/62NrjsAh9CJH82qAYCy0lbsuqmNSPOpLzS7
         Xk0gykLi3WrcpUVhjh3NfUTYwV7EDPolA1tkgooppWcTb1JE6BC1G8bHqLKLpjutED
         D63rhek8VTSdxZQXQdiv6RQRFk06Yrja7+1ORTcwBZsjiAsvNQ7BEoG+GNvsQqKwk4
         JshAQybdAszRiF4cT6WMvqYICUdyUdjKVpeqy2JSpK2vJHKZc6I6L+XOXNHtabCZHP
         vro1WRtEcVxQymfJ6Hnm0s/HjMI09Ter4DGJVjS1kkehpLNnniFaD6I1L2g2xNzg9l
         OIDoHqKHZ+9Ng==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1peZZY-0004Yz-0G; Tue, 21 Mar 2023 11:50:32 +0100
Date:   Tue, 21 Mar 2023 11:50:32 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     will@kernel.org, joro@8bytes.org, robin.murphy@arm.com,
        andersson@kernel.org, johan+linaro@kernel.org, steev@kali.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] iommu/arm-smmu-qcom: Limit the SMR groups to 128
Message-ID: <ZBmL+FW44VjxycaA@hovoldconsulting.com>
References: <20230321091332.18334-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230321091332.18334-1-manivannan.sadhasivam@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 21, 2023 at 02:43:32PM +0530, Manivannan Sadhasivam wrote:
> On some Qualcomm platforms, the hypervisor emulates more than 128 SMR
> (Stream Matching Register) groups. This doesn't conform to the ARM SMMU
> architecture specification which defines the range of 0-127. Moreover, the
> emulated groups don't exhibit the same behavior as the architecture
> supported ones.
> 
> For instance, emulated groups will not detect the quirky behavior of some
> firmware versions intercepting writes to S2CR register, thus skipping the
> quirk implemented in the driver and causing boot crash.
> 
> So let's limit the groups to 128 and issue a notice to users in that case.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
Tested-by: Johan Hovold <johan+linaro@kernel.org>

Johan
