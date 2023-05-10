Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FB606FD3D5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 04:27:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbjEJC1H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 22:27:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjEJC1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 22:27:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A177BE72;
        Tue,  9 May 2023 19:27:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2E440638BB;
        Wed, 10 May 2023 02:27:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5CDFC433D2;
        Wed, 10 May 2023 02:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683685620;
        bh=cN0Zpp3nHcYA73LBWkAJJmQrp5R/ZueRrOEoHH93crM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=AH4HBOXQ4c+QTwsy5Y4zsYIv19Q+xSPT0PKhTBTMtf3h3PPP9aq17NdyydL0rWU26
         HF/BFdbhbayZ3XUNDZWfYAwCVDBgYRP2tc+6UUUz0VRs1C15TSRIK6d9D/7eA9qEU8
         6rR0NdvH9z49wQa315z/xKDYkctlC1bP0kPdTUcnMF7arKdknTsrnfID+sx/JxlAwT
         cnIB+8puquAWZTRerX//0yJuI8yji27y3DfyiMoA8alAER76soB4PqUVs/lZdt/dDd
         uoyFwQyO/UqZaESqXRJaF1e9TJEhzdoT+OGnj1H3FuX30Bhp3kohpxQjuvFCrrpJsa
         72KQaPjUp0VGA==
Date:   Tue, 9 May 2023 19:26:58 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Abel Vesa <abel.vesa@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>,
        Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Bjorn Andersson <andersson@kernel.org>
Subject: Re: linux-next: build failure after merge of the mmc tree
Message-ID: <20230509192658.56cfb27b@kernel.org>
In-Reply-To: <20230510111833.17810885@canb.auug.org.au>
References: <20230510111833.17810885@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 May 2023 11:18:33 +1000 Stephen Rothwell wrote:
> Hi all,
> 
> After merging the mmc tree, today's linux-next build (x86_64 allmodconfig)
> failed like this:
> 
> error: the following would cause module name conflict:
>   drivers/soc/qcom/ice.ko
>   drivers/net/ethernet/intel/ice/ice.ko
> 
> Exposed by commit
> 
>   31dd43d5032a ("mmc: sdhci-msm: Switch to the new ICE API")
> 
> I have used the mmc tree from next-20230509 for today.

Looks like the driver itself came from:

commit 2afbf43a4aec6e31dac7835e65d52c867f2be400
Author: Abel Vesa <abel.vesa@linaro.org>
Date:   Fri Apr 7 13:50:26 2023 +0300

    soc: qcom: Make the Qualcomm UFS/SDCC ICE a dedicated driver

? The Intel Ethernet driver is 5 years old:

commit 837f08fdecbe4b2ffc7725624342e73b886665a8
Author: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date:   Tue Mar 20 07:58:05 2018 -0700

    ice: Add basic driver framework for Intel(R) E800 Series

so AFAIU the MMC driver needs a new name?
