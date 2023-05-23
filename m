Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C81BE70DDBA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 15:42:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236793AbjEWNmC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 09:42:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236491AbjEWNmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 09:42:00 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4FB3CE52
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 06:41:40 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C8DD7139F;
        Tue, 23 May 2023 06:42:24 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 400DD3F840;
        Tue, 23 May 2023 06:41:38 -0700 (PDT)
Date:   Tue, 23 May 2023 14:41:35 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     "lihuisong (C)" <lihuisong@huawei.com>
Cc:     andersson@kernel.org, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com, shawnguo@kernel.org,
        arnd@arndb.de, krzk@kernel.org, linux-kernel@vger.kernel.org,
        soc@kernel.org, wanghuiqiang@huawei.com, tanxiaofei@huawei.com,
        liuyonglong@huawei.com
Subject: Re: [PATCH v2 1/2] soc: hisilicon: Support HCCS driver on Kunpeng SoC
Message-ID: <20230523134135.jkkhcwfihflp775m@bogus>
References: <20230424073020.4039-1-lihuisong@huawei.com>
 <20230522072211.8894-1-lihuisong@huawei.com>
 <20230522072211.8894-2-lihuisong@huawei.com>
 <20230523093922.f2y4wrz3vkzi7kmw@bogus>
 <928a893b-6596-8d40-ce0e-80059a363d11@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <928a893b-6596-8d40-ce0e-80059a363d11@huawei.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 23, 2023 at 07:57:42PM +0800, lihuisong (C) wrote:
> 
> 在 2023/5/23 17:39, Sudeep Holla 写道:
> > On Mon, May 22, 2023 at 03:22:10PM +0800, Huisong Li wrote:
> > > The Huawei Cache-Coherent System (HCCS) is a bus protocol standard
> > > for ensuring cache coherent on HiSilicon SoC. The performance of
> > > the application may be affected if some hccs ports are in non-full
> > > lane status, have a large number of CRC errors and so on.
> > > 
> > > This driver provides the query interface of the health status and
> > > port information of HCCS on Kunpeng SoC.
> > > 
> > > Signed-off-by: Huisong Li <lihuisong@huawei.com>
> > > ---
> > >   MAINTAINERS                          |    6 +
> > >   drivers/soc/Kconfig                  |    1 +
> > >   drivers/soc/Makefile                 |    1 +
> > >   drivers/soc/hisilicon/Kconfig        |   19 +
> > >   drivers/soc/hisilicon/Makefile       |    2 +
> > >   drivers/soc/hisilicon/kunpeng_hccs.c | 1287 ++++++++++++++++++++++++++
> > >   drivers/soc/hisilicon/kunpeng_hccs.h |  196 ++++
> > >   7 files changed, 1512 insertions(+)
> > >   create mode 100644 drivers/soc/hisilicon/Kconfig
> > >   create mode 100644 drivers/soc/hisilicon/Makefile
> > >   create mode 100644 drivers/soc/hisilicon/kunpeng_hccs.c
> > >   create mode 100644 drivers/soc/hisilicon/kunpeng_hccs.h
> > > 
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index eddbc48c61e9..fe0e796e8445 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -9399,6 +9399,12 @@ S:	Maintained
> > >   W:	http://www.hisilicon.com
> > >   F:	drivers/spi/spi-hisi-sfc-v3xx.c
> > > +HISILICON KUNPENG SOC HCCS DRIVER
> > s/HCCS/HCCS INFO or QUERY/ ?
> From the current features, what you suggest is suitable.
> But this driver will support to the setting feature.

Ah OK, I wasn't aware of that, in that case it is fine to keep it as is
and add comment about future feature expansions so that the name makes
more sense them. I assumed it is more a query interface.

I also assume the settings with just control performance and is fully
safe and stability of the system is taken care.

[...]

> > > +
> > > +/* PCC defines */
> > > +#define HCCS_PCC_SIGNATURE_MASK		0x50434300
> > > +#define HCCS_PCC_STATUS_CMD_COMPLETE	BIT(0)
> > I am not really sure if we keep duplicating this. I will try to cook up
> > a patch consolidating these.
> Yes, these info is better placed in a global header.
> Do I need to do this in this series?
> Or do not modify it, and then process all related code in your patch.

Fair enough, we can do that later. I don't want to block this for that reason.

-- 
Regards,
Sudeep
