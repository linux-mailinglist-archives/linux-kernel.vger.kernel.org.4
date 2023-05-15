Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A4CE702D37
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 14:55:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242047AbjEOMza (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 08:55:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242088AbjEOMzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 08:55:10 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1711A19AE;
        Mon, 15 May 2023 05:55:04 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34F4x0NA022883;
        Mon, 15 May 2023 07:55:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=p9o/h+5z2tpJ6ghKbunX+2J/YOG2H11uQhqDGGzJJGs=;
 b=XcGWUNi4xrEtsTlLIlmRZYuZUC3v4fp4Ou6Dz8rgMXbf9D4fkosNj4DTall9vA7z08NK
 zlJYHHhKHqdlmQjH2Q157JGRxJ4VVHsMtwJyc4vev6cz+mIN6ud46XJBxuZw6xHtX3ev
 vQKL2Ml+K7xJy32kNc0SP2or6AeIZMmuw4Oidq0j0aqF8mznKePbUs5+WPhN3CbZhNVh
 csW8KJV+nzIAIHn9DuTfFiHSGNl/iBrwXD14nqrnyOM701O7QROKqJb28SNEDoS9UKdz
 zgpjDcUd7shfMoGvPUcgGy3bP7Xi03BVf7hU6fwDIODbG646rp4d6RHKxosY8Vn9KoV2 gg== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3qj6ymtupp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 May 2023 07:55:00 -0500
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.26; Mon, 15 May
 2023 07:54:59 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 15 May 2023 07:54:59 -0500
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id F209011A8;
        Mon, 15 May 2023 12:54:58 +0000 (UTC)
Date:   Mon, 15 May 2023 12:54:58 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     "Goud, Srinivas" <srinivas.goud@amd.com>
CC:     "broonie@kernel.org" <broonie@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "patches@opensource.cirrus.com" <patches@opensource.cirrus.com>
Subject: Re: [PATCH 1/2] spi: spi-cadence: Avoid read of RX FIFO before its
 ready
Message-ID: <20230515125458.GT68926@ediswmail.ad.cirrus.com>
References: <20230509164153.3907694-1-ckeepax@opensource.cirrus.com>
 <PH8PR12MB6675F6CC30254C5EED898FD5E1789@PH8PR12MB6675.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <PH8PR12MB6675F6CC30254C5EED898FD5E1789@PH8PR12MB6675.namprd12.prod.outlook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-GUID: 1EsWVxX1B7jrP1WIp6kuBTASOcaJxh9v
X-Proofpoint-ORIG-GUID: 1EsWVxX1B7jrP1WIp6kuBTASOcaJxh9v
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 15, 2023 at 12:04:38PM +0000, Goud, Srinivas wrote:
> >-----Original Message-----
> >From: Charles Keepax <ckeepax@opensource.cirrus.com>
> >Sent: Tuesday, May 9, 2023 10:12 PM
> >To: broonie@kernel.org
> >Cc: Goud, Srinivas <srinivas.goud@amd.com>; linux-spi@vger.kernel.org;
> >linux-kernel@vger.kernel.org; patches@opensource.cirrus.com
> >Subject: [PATCH 1/2] spi: spi-cadence: Avoid read of RX FIFO before its ready
> >-		while (trans_cnt) {
> >-			cdns_spi_read_rx_fifo(xspi, 1);
> >-
> >-			if (xspi->tx_bytes) {
> >-				if (xspi->txbuf)
> >-					cdns_spi_write(xspi, CDNS_SPI_TXD,
> >-						       *xspi->txbuf++);
> >-				else
> >-					cdns_spi_write(xspi, CDNS_SPI_TXD,
> >0);
> >-				xspi->tx_bytes--;
> >-			}
> >-			trans_cnt--;
> >-		}
> >-		if (!xspi->tx_bytes) {
> >-			/* Fixed delay due to controller limitation with
> >-			 * RX_NEMPTY incorrect status
> >-			 * Xilinx AR:65885 contains more details
> >-			 */
> >-			udelay(10);
> >-			cdns_spi_read_rx_fifo(xspi, xspi->rx_bytes);
> >+		cdns_spi_read_rx_fifo(xspi, trans_cnt);
> Cadence SPI configured in Slave mode,  when threshold is half of FIFO depth cdns_spi_read_rx_fifo() function continuously in read mode, 
> due to this we see incorrect data received on the Master side as Slave is failed to update the TX FIFO on time.

Apologies I am having a little trouble following this are you
saying this part of the patch cases issues for you running in
slave mode?

Thanks,
Charles
