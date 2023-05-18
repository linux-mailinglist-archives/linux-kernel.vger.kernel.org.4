Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F34FB707C01
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 10:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbjERI2x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 04:28:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbjERI2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 04:28:51 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ACB71A5;
        Thu, 18 May 2023 01:28:50 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34I7jt9E000734;
        Thu, 18 May 2023 03:28:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=Ke9hxqTS2X0CNWzRXq+VmPkxwmQQSVH2a7FX1qzBCGs=;
 b=g82xL0lP8Xc2zOquFlNLMBPimHg2Q04pWRBtfZlrpN6tehsT2HOAo+/XtAF6OPpA9o4F
 NX3GY6ESrYFdy7qvrCTBrVNSBvyx5xhegOfjR2WrELfN66cHJdWwhLiv7/23w4zLK38l
 4vWwsagjGzX0EJsSMMPeZzzecvFfVpq+TTUZjCCEr53KJTxTaJ97ykrMpFfatMl69A7x
 jUV4/LUyOwZW9KQDTRBa7KxeUfPJqtwYNROCsyZ+OdX7zIzRm7aMgiGW7XSu9lbtthLo
 nGCfJqlyWVQJe/t0+drS0992Mcg4VaubqPOVo9dyi7eEiaIj+RxWgCSPdv0jGhXDbLTu fA== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3qj7y16p0f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 May 2023 03:28:33 -0500
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.26; Thu, 18 May
 2023 03:28:31 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.26 via Frontend
 Transport; Thu, 18 May 2023 03:28:31 -0500
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 187FCB38;
        Thu, 18 May 2023 08:28:31 +0000 (UTC)
Date:   Thu, 18 May 2023 08:28:31 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     kernel test robot <lkp@intel.com>
CC:     <broonie@kernel.org>, <oe-kbuild-all@lists.linux.dev>,
        <srinivas.goud@amd.com>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
Subject: Re: [PATCH] spi: spi-cadence: Interleave write of TX and read of RX
 FIFO
Message-ID: <20230518082831.GX68926@ediswmail.ad.cirrus.com>
References: <20230517163157.639974-1-ckeepax@opensource.cirrus.com>
 <202305180824.qIPSXIQQ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <202305180824.qIPSXIQQ-lkp@intel.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-GUID: jJKwlmzfafxkqbxPlQzFnbgm4LAZ4r6V
X-Proofpoint-ORIG-GUID: jJKwlmzfafxkqbxPlQzFnbgm4LAZ4r6V
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 18, 2023 at 09:55:11AM +0800, kernel test robot wrote:
>    drivers/spi/spi-cadence.c:127: warning: Function parameter or member 'clk_rate' not described in 'cdns_spi'
>    drivers/spi/spi-cadence.c:309: warning: Function parameter or member 'ntx' not described in 'cdns_spi_process_fifo'
>    drivers/spi/spi-cadence.c:309: warning: Function parameter or member 'nrx' not described in 'cdns_spi_process_fifo'
> >> drivers/spi/spi-cadence.c:309: warning: expecting prototype for cdns_spi_fill_tx_fifo(). Prototype was for cdns_spi_process_fifo() instead

oops... yeah kernel doc should have been updated as well. I will
respin, functionally the patch should be fine.

Thanks,
Charles
