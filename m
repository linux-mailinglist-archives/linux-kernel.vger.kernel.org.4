Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFA3870658F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 12:46:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbjEQKqj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 06:46:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjEQKqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 06:46:37 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A08CE97;
        Wed, 17 May 2023 03:46:36 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34H6Ye5k010531;
        Wed, 17 May 2023 05:46:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=sRGJh5o2DA79DjdFheuNkuTMul+lTmOesNItZcaV51g=;
 b=UA1PgTpweGDIuz7gZTZM689wRyow0OwRHwYG79ojqcV3NyTleB07o+Psoy/CyQFqXStu
 1lsKRrxgp20KJ3mcRpV3FG0hZfcvIcqy7hDEiflmQfaR4aYVgDMRf/0o1tFDm5HGRZUR
 6JoOSnTAMABzdxSEyFsSNqv9b2vigI+YLF21iwLbbFnnf4iEhnsuu4Lt/NJlBIdz3Iev
 UHehSDcGhQzZ4ent2J7AXCs/YfkWfGeWiU3sslKECe2359Pe+WWvPWte8OWq35riGKVM
 sS8l9BKPTspdL3NQbrBkReiZkjsDWQ70vMKjphcu3K2XO/tnv6QSzxPULuG226fAiSre gA== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3qj7y15g6h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 May 2023 05:46:31 -0500
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.26; Wed, 17 May
 2023 05:46:29 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 17 May 2023 05:46:29 -0500
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id B01C511CA;
        Wed, 17 May 2023 10:46:29 +0000 (UTC)
Date:   Wed, 17 May 2023 10:46:29 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     "Goud, Srinivas" <srinivas.goud@amd.com>
CC:     "broonie@kernel.org" <broonie@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "patches@opensource.cirrus.com" <patches@opensource.cirrus.com>
Subject: Re: [PATCH 1/2] spi: spi-cadence: Avoid read of RX FIFO before its
 ready
Message-ID: <20230517104629.GW68926@ediswmail.ad.cirrus.com>
References: <20230509164153.3907694-1-ckeepax@opensource.cirrus.com>
 <PH8PR12MB6675F6CC30254C5EED898FD5E1789@PH8PR12MB6675.namprd12.prod.outlook.com>
 <20230515125458.GT68926@ediswmail.ad.cirrus.com>
 <PH8PR12MB6675A433C8B129AA96B5C853E17E9@PH8PR12MB6675.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <PH8PR12MB6675A433C8B129AA96B5C853E17E9@PH8PR12MB6675.namprd12.prod.outlook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-GUID: NWnnnyWmGdAx5jCQfCQ4fmew7dkE3WIC
X-Proofpoint-ORIG-GUID: NWnnnyWmGdAx5jCQfCQ4fmew7dkE3WIC
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

On Wed, May 17, 2023 at 05:24:10AM +0000, Goud, Srinivas wrote:
> >On Mon, May 15, 2023 at 12:04:38PM +0000, Goud, Srinivas wrote:
> >> Cadence SPI configured in Slave mode,  when threshold is half of FIFO
> >> depth cdns_spi_read_rx_fifo() function continuously in read mode, due to
> >this we see incorrect data received on the Master side as Slave is failed to
> >update the TX FIFO on time.
> >
> >Apologies I am having a little trouble following this are you saying this part of
> >the patch cases issues for you running in slave mode?
> Yes, we see issue with this patch when we run in Slave mode.
> 
> When any master is in continuous read mode (anything > FIFO depth), 
> with updated logic cdns_spi_read_rx_fifo() function in cdns_spi_irq
> continuously in read loop to read complete half FIFO data.
> due to this Slave failed to write the TX FIFO on time and result in
> incorrect data in Master receive. 
> Whereas in my previous patch, data read and write happening byte wise,
> by which we are making sure data availability in TXFIFO on time.

That is a very tight system if reading 64 sequential memory locations
is the timing difference between success and failure, Linux is
not a real-time OS.

But I don't really mind moving back to a byte-wise operation. Although
we need to avoid the issues introduced by the first attempt at that. I
will have a look at doing a patch to put the byte-wise back in.

Thanks,
Charles
