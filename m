Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49E2E667375
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 14:45:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbjALNpL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 08:45:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbjALNov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 08:44:51 -0500
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FE2A15FEE;
        Thu, 12 Jan 2023 05:44:50 -0800 (PST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30CBSU59023169;
        Thu, 12 Jan 2023 05:44:35 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pfpt0220; bh=82CoWtK9ZDStVcz9wmegg9cqJt1I98wwF05YKhPPM7s=;
 b=iNSMpo8VU65WEiz1B4600oTeDsmIiUjPH3TiJPbkgU8LXd/Yv8RA1LnzYEoLdbbc0PMt
 LA51oB9jpj6Zm5Pdr1+IvagHYBePqJYds40DgZ6HCRvFmhJ9+KBE8JLxs+pjk/jwhYuI
 RslqtU2yM8Y29Gu71TO8R+s4YKIV0foTvtRqZpWnaYuZprGoDTB+A+QYqecjPEwv/LAF
 KWfat7xByjK1BkoshOca/nop9sf+YQl1m9y6+/ft4smILP5eLksCChN8JL3NSlJslTfO
 d8TH0/eGpCQxBZqy/X4A3zpW+4RBvVqDXub0jGC0HSNLiv9tDTXQXpDF4Cf0cCVVGtph Mg== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3n23b2j216-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 12 Jan 2023 05:44:35 -0800
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 12 Jan
 2023 05:44:34 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.42 via Frontend
 Transport; Thu, 12 Jan 2023 05:44:34 -0800
Received: from Dell2s-9 (unknown [10.110.150.250])
        by maili.marvell.com (Postfix) with ESMTP id E15A43F7051;
        Thu, 12 Jan 2023 05:44:33 -0800 (PST)
Date:   Thu, 12 Jan 2023 05:44:33 -0800
From:   Piyush Malgujar <pmalgujar@marvell.com>
To:     Adrian Hunter <adrian.hunter@intel.com>
CC:     <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <ulf.hansson@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <yamada.masahiro@socionext.com>, <devicetree@vger.kernel.org>,
        <jannadurai@marvell.com>, <cchavva@marvell.com>
Subject: Re: [PATCH 4/5] drivers: mmc: sdhci: Add option to configure sdhci
 timeout
Message-ID: <20230112134433.GA6335@Dell2s-9>
References: <20221219142418.27949-1-pmalgujar@marvell.com>
 <20221219142418.27949-5-pmalgujar@marvell.com>
 <4edc44f2-005e-803d-942c-171abd787252@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <4edc44f2-005e-803d-942c-171abd787252@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-GUID: fbEQB8rXTmL68iqyCzGxgJHrF2D4vffN
X-Proofpoint-ORIG-GUID: fbEQB8rXTmL68iqyCzGxgJHrF2D4vffN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-12_08,2023-01-12_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,

Thanks for the review comments.

On Wed, Jan 11, 2023 at 10:08:26AM +0200, Adrian Hunter wrote:
> On 19/12/22 16:24, Piyush Malgujar wrote:
> > From: Jayanthi Annadurai <jannadurai@marvell.com>
> > 
> > Add config option to choose the sdhci timeout in seconds.
> 
> This approach is not ok, but why is the change wanted?
> 

This option was just to give flexibility to opt for a different timeout value based
on requirement, for instance, to decrease the time of tuning process. 
Although it is not a mandatory change, we can remove this option and go with the
default one.

> > 
> > Signed-off-by: Jayanthi Annadurai <jannadurai@marvell.com>
> > Signed-off-by: Piyush Malgujar <pmalgujar@marvell.com>
> > ---
> >  drivers/mmc/host/Kconfig | 8 ++++++++
> >  drivers/mmc/host/sdhci.c | 3 ++-
> >  2 files changed, 10 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> > index b5b2ae0bb4625bdb9d17acdbb1887c9caa3a1f32..ab48f2bc4cff73d1aad8d7da542d761cf0346d9f 100644
> > --- a/drivers/mmc/host/Kconfig
> > +++ b/drivers/mmc/host/Kconfig
> > @@ -1132,3 +1132,11 @@ config MMC_LITEX
> >  	  module will be called litex_mmc.
> >  
> >  	  If unsure, say N.
> > +
> > +config MMC_SDHCI_TIMEOUT
> > +	int
> > +	default 1 if MMC_SDHCI_CADENCE
> > +	default 10
> > +	depends on MMC_SDHCI
> > +	help
> > +	  Default timeout value for command and data.
> > diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> > index f3af1bd0f7b955272fbd8b034ecb591860b89aed..e9bc24258746834ec9c8f13fe24456587a2b758d 100644
> > --- a/drivers/mmc/host/sdhci.c
> > +++ b/drivers/mmc/host/sdhci.c
> > @@ -1707,7 +1707,8 @@ static bool sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
> >  	else if (!cmd->data && cmd->busy_timeout > 9000)
> >  		timeout += DIV_ROUND_UP(cmd->busy_timeout, 1000) * HZ + HZ;
> >  	else
> > -		timeout += 10 * HZ;
> > +		timeout += CONFIG_MMC_SDHCI_TIMEOUT * HZ;
> > +
> >  	sdhci_mod_timer(host, cmd->mrq, timeout);
> >  
> >  	if (host->use_external_dma)
>

Thanks,
Piyush 
