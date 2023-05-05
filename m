Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 704926F86BD
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 18:29:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232909AbjEEQ3F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 12:29:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231852AbjEEQ3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 12:29:03 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 256558A50;
        Fri,  5 May 2023 09:29:02 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 345ESadg016864;
        Fri, 5 May 2023 11:28:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=8UHWzefbFgoLLVMHfd2aLujvuk0cAfZxxiMum6dQk9U=;
 b=Q6A1DggLQZk9wTY7CEThllxmxR5D7dJ7zVNZDFHSdecS61WwCoyJIwf2wEsoIfWc/d0Z
 vDhBpZ2qMz6/AKTFcux5TU4nBL+H0vnrHfwr4e/lNQDx54uxrwmQ5CuyGdxMQkW4dBLX
 r5l1P+8zj/301PH0mmENJHv7Z349OBcXHNTUT7e60JVPXFe8kY6bKL8j6tWdhWUQNjLq
 Fc4FTxABd377uQYM0tCwbOFQqOK6kOgbb7p3L62LCsD2pGskDKklkWuKlOiRSIJeK8Ce
 9YjbR1J/mK4oFKfbYF+PLKUfqIXwt57GhODsEmmOyMdH4uh6ILDi5qdTUOGyTDFh1Rlf GA== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3q90n3q46f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 05 May 2023 11:28:57 -0500
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.26; Fri, 5 May
 2023 11:28:55 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 5 May 2023 11:28:55 -0500
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id F1258B38;
        Fri,  5 May 2023 16:28:54 +0000 (UTC)
Date:   Fri, 5 May 2023 16:28:54 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Srinivas Goud <srinivas.goud@amd.com>
CC:     <broonie@kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <git@amd.com>,
        <gcnu.goud@gmail.com>
Subject: Re: [PATCH v2 2/2] spi: spi-cadence: Add support for Slave mode
Message-ID: <20230505162854.GF68926@ediswmail.ad.cirrus.com>
References: <1681825625-10265-1-git-send-email-srinivas.goud@amd.com>
 <1681825625-10265-3-git-send-email-srinivas.goud@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1681825625-10265-3-git-send-email-srinivas.goud@amd.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-ORIG-GUID: LHN9Va--haGA1TKGG74G4RMzNRlHj07B
X-Proofpoint-GUID: LHN9Va--haGA1TKGG74G4RMzNRlHj07B
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 18, 2023 at 07:17:05PM +0530, Srinivas Goud wrote:
> Currently SPI Cadence controller works only in Master mode.
> Updated interrupt handler for Full duplex transfer in Slave mode.
> Interrupt handler rely on the TX empty interrupt even for Slave mode
> transfer due to below HW limitation.
> 
> HW limitation:
> AR 65885 - SPI Controller Might Not Update RX_NEMPTY Flag, Showing
> Incorrect Status Of The Receive FIFO
> 
> SPI Slave mode works in the following manner:
> 1.      One transfer can be finished only after all transfer->len
> data been transferred to master device.
> 2.      Slave device only accepts transfer->len data. Any data longer
> than this from master device will be dropped. Any data shorter than
> this from master will cause SPI to be stuck due to the above behavior.
> 3.      The stale data present in RXFIFO will be dropped in unprepared
> hardware transfer function.
> 
> Signed-off-by: Srinivas Goud <srinivas.goud@amd.com>
> ---

This patch appears to cause longer SPI transactions to be
corrupted on my Zynq board. Still investigating but its not
immediately obvious to me what the problem is so any
suggestions/comments on how much longer transaction testing this
has had would be great. I am using the SPI in master mode and I
am not sure exactly what transaction size hits the problem yet.

Thanks,
Charles
