Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B74B71455B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 09:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbjE2HVg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 03:21:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjE2HVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 03:21:34 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EE82A6;
        Mon, 29 May 2023 00:21:32 -0700 (PDT)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34T6TFJd022657;
        Mon, 29 May 2023 09:21:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=R7U12OfPWbuKgyybSdqlH6r+NAGEknQL5yOH75+Ki/o=;
 b=mWTzap13IJD3sGmFPOA13Bs0t5d4pbafMu/Co6c4yHZ6oMTKxRLdVzGEToWs0IGUroNE
 QP8XfIRu9woFIYgnX97OZuo95eM/AFE1JWze1wNiqzOKITvsJ1CLLDxfMBUTIlm+ZFZ/
 FBrZ6qj9twziD55xCwawiWR/CNMciHj8YUaZa+z1Br7LL4tV528fSTPjtWU59aU92Db2
 eOpkZZ6wwruqY0h27P58IQd+Br0quuuOXF5mYuYH6E/WG1ObvkGfGUCKr115WlqWnG/g
 QfRuciXKo3pg0Dsakv3Ll9/s+AK8ty6lMl0IzMFg6wbiuu/JxiG6F3KJJduixrcFexxJ SQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3quag27vxa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 May 2023 09:21:05 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 03EAB100039;
        Mon, 29 May 2023 09:21:04 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id EEF0B2132FC;
        Mon, 29 May 2023 09:21:03 +0200 (CEST)
Received: from [10.201.21.9] (10.201.21.9) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Mon, 29 May
 2023 09:21:02 +0200
Message-ID: <312a7c7a-165c-eb17-b6af-4c708d33afb4@foss.st.com>
Date:   Mon, 29 May 2023 09:17:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [RFC PATCH 1/4] tee: Re-enable vmalloc page support for shared
 memory
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
CC:     Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <op-tee@lists.trustedfirmware.org>
References: <20230523091350.292221-1-arnaud.pouliquen@foss.st.com>
 <20230523091350.292221-2-arnaud.pouliquen@foss.st.com>
 <ZG2yw0xZ6XGGp9E5@infradead.org>
 <18a8528d-7d9d-6ed0-0045-5ee47dd39fb2@foss.st.com>
 <ZHCoJEkVinvsB2lZ@infradead.org>
From:   Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>
Organization: STMicroelectronics
In-Reply-To: <ZHCoJEkVinvsB2lZ@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.201.21.9]
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-29_04,2023-05-25_03,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/26/23 14:37, Christoph Hellwig wrote:
> On Wed, May 24, 2023 at 04:01:14PM +0200, Arnaud POULIQUEN wrote:
>>> As per the discussion back then: don't just blindly do the same dumb
>>> thing again and fix the interfae to actually pass in a page array,
>>> or iov_iter or an actually useful container that fits.
>>>
>>
>> I suppose your are speaking about this discussion:
>> https://lore.kernel.org/all/20221002002326.946620-3-ira.weiny@intel.com/
> 
> Yes.
> 
>>
>> If I'm not mistaken, I should modify at tee_shm_register_kernel_buf API and
>> register_shm_helper inernal function, right?
>>
> 
>> What about having equivalent of shm_get_kernel_pages in an external helper (to
>> defined where to put it), could it be an alternative of the upadate of the
>> tee_shm API?
> 
> I think the fundamentally right thing is to pass an iov_iter to
> register_shm_helper, and then use the new as of 6.3
> iov_iter_extract_pages helper to extract the pages from that.  For
> the kernel users you can then simply pass down an ITER_BVEC iter
> that you can fill with vmalloc pages if you want.
> 

Thanks for the advice!

Regards,
Arnaud
