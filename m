Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C47B0717A81
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 10:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234841AbjEaIqa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 04:46:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235014AbjEaIqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 04:46:05 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C35FE5D;
        Wed, 31 May 2023 01:45:36 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34V8FgUk001519;
        Wed, 31 May 2023 03:44:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=vJJUQXuP1zJPj3ce0A9Wr6NYnYeBp+whmXdzJL+iqvE=;
 b=Tq2BGP/EtFPwlJticgRSv7MW+TGJEG7Q2x5c1/K1jq5eAWwDL9sEGOtUh0CjRCwYZQIc
 ZxauFkDT2zNBtTLhcNK2PLTSnlqXOLHnB6cl5/QFDhs9MXUvLaVED4AJfhuiTWEodkyY
 A3PRSJIJ3OewTA2IqRbmKSbkNnIsZTCPi6oimHjiiwL2VXfsamIpFdSG22Ajij6ET/4J
 C2d5GrUhYn+CGEx1M071xT3ZxRJMxsJnjzBL8IAQ61MdS7ZO4qPf6qnh62w+Y0BcUro8
 1sqXF1PXkNbs/+bx3eJrR+b3M5YYgJQ+yJt9FUgj+//+mjTfqnKbA0SnmDywbXQUoygS 7Q== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3quf90v70y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 31 May 2023 03:44:31 -0500
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.26; Wed, 31 May
 2023 09:44:29 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.26 via Frontend
 Transport; Wed, 31 May 2023 09:44:29 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id E867B468;
        Wed, 31 May 2023 08:44:28 +0000 (UTC)
Date:   Wed, 31 May 2023 08:44:28 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     "Mahapatra, Amit Kumar" <amit.kumar-mahapatra@amd.com>
CC:     "broonie@kernel.org" <broonie@kernel.org>,
        "lee@kernel.org" <lee@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "yung-chuan.liao@linux.intel.com" <yung-chuan.liao@linux.intel.com>,
        "sanyog.r.kale@intel.com" <sanyog.r.kale@intel.com>,
        "pierre-louis.bossart@linux.intel.com" 
        <pierre-louis.bossart@linux.intel.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "patches@opensource.cirrus.com" <patches@opensource.cirrus.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "git (AMD-Xilinx)" <git@amd.com>
Subject: Re: [PATCH v2 5/6] spi: cs42l43: Add SPI controller support
Message-ID: <20230531084428.GG68926@ediswmail.ad.cirrus.com>
References: <20230530122112.1314458-1-ckeepax@opensource.cirrus.com>
 <20230530122112.1314458-6-ckeepax@opensource.cirrus.com>
 <BN7PR12MB28024FF756EFAE44E1713FBDDC489@BN7PR12MB2802.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <BN7PR12MB28024FF756EFAE44E1713FBDDC489@BN7PR12MB2802.namprd12.prod.outlook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-GUID: LiPE974ipEMDMTzP39xGZ1i43uYQChdU
X-Proofpoint-ORIG-GUID: LiPE974ipEMDMTzP39xGZ1i43uYQChdU
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 31, 2023 at 05:26:46AM +0000, Mahapatra, Amit Kumar wrote:
> > +       if (spi->chip_select == 0)
> 
> New set/get APIs for accessing spi->chip_select were introduced by
> https://github.com/torvalds/linux/commit/303feb3cc06ac0665d0ee9c1414941200e60e8a3
> please use these APIs instead of accessing spi->chip_select directly.
> 
> > +       /* select another internal CS, which doesn't exist, so CS 0 is not used */
> > +       if (spi->cs_gpiod)
> 
> Same here for spi->cs_gpio
> 

Thanks, I will get these fixed up for v3.

Thanks,
Charles
