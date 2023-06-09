Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9673729534
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 11:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240806AbjFIJbO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 05:31:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240924AbjFIJas (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 05:30:48 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB28B4ED9
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 02:25:41 -0700 (PDT)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35984NFU013519;
        Fri, 9 Jun 2023 11:25:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=xifOO1jZLHNUlZ5ScvXzZKU9qzDbfG9UnGzAsvkDh0U=;
 b=IkRaH4pkrz5I8FyXP559Tlx51tEIAz50ru8hjR8LeWRvYBG/yKrrt0Ce6+Y2w0Xn/UGB
 +1/Nvx/m8I5v6BHfrXtZc4MXZU5gBq4wILAE2LkykhvqcGJ2tNz7AaXwaYDb+Cmvq8h0
 HRjbK6qE331ylKo1ijh2QHI6j6xxPd8WDvrrPV3IyquzfEX0VVTzjJrEJY+RsPDolqYY
 40toSQn7ATqGeOPi/fx+B9q3c0QJu+lXOLLzWajOGCAuFiMCnHku6AXivCmmpUdDHH5m
 Y62QjNZ//qsxWhFiqE92XgayiMpyZTeroH/47tVtmfAFMFoCwA2r4HsQXrwilwE+T4sh IA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3r3yse8sbs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Jun 2023 11:25:27 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id EC34F10002A;
        Fri,  9 Jun 2023 11:25:26 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id E5F4221ADCB;
        Fri,  9 Jun 2023 11:25:26 +0200 (CEST)
Received: from [10.252.12.6] (10.252.12.6) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Fri, 9 Jun
 2023 11:25:26 +0200
Message-ID: <1932df58-dbb7-c57b-03c0-fad337090ab9@foss.st.com>
Date:   Fri, 9 Jun 2023 11:25:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [RESEND PATCH 0/2] STMFX chip init couple of fixes
To:     Lee Jones <lee.jones@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC:     <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20230412105542.1231131-1-amelie.delaunay@foss.st.com>
Content-Language: en-US
From:   Amelie Delaunay <amelie.delaunay@foss.st.com>
In-Reply-To: <20230412105542.1231131-1-amelie.delaunay@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.252.12.6]
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-09_06,2023-06-08_01,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kind reminder on this series, pending for almost 3 months.

Thanks,
Amelie


On 4/12/23 12:55, Amelie Delaunay wrote:
> This series fixes the behavior of stm32_chip_init function in case
> of errors.
> 
> Amelie Delaunay (2):
>    mfd: stmfx: Fix error path in stmfx_chip_init
>    mfd: stmfx: Nullify stmfx->vdd in case of error
> 
>   drivers/mfd/stmfx.c | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)
> 
