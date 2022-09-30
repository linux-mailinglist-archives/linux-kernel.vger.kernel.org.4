Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 112C35F0AE8
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 13:45:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231722AbiI3LpX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 07:45:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231439AbiI3Lon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 07:44:43 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB5B746622;
        Fri, 30 Sep 2022 04:39:58 -0700 (PDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28UBaJEB022039;
        Fri, 30 Sep 2022 11:39:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=fy7BmPRWBoBvtpDaEgCutX6c90Lw54tYYYhiSde15yU=;
 b=EV439FPD1ZZ2Vv0oXLROf59IFRhEud40ViBKdMf64F8NTrADvBVPLXTuzAFaCXCD4hJY
 uSju3MbcFlCev4g8/bvaI64pJ/bbIAvcLOzMJoh5RvBwDnHfzOlfG+p0TsTOYrnGBxLd
 4q6M65HHUPNo4EO59ihn1zOndcv49NR27pMOaLCwdSJ1/hgQ/5CUys2t48PjUWT2PlKn
 VlqOnqVW8PhlmQqIDZtfW6wYg0zUGc4pzrDteeme7M+UuTxwfuIeiKbbcryIAOjExocc
 0M5yKpc9ySRUCP4wpe7rF26v2iXIvEVj1pbRCeyS7SUnMTJ0doRLAhZklOijzOHYuljj IA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jwyc78stv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Sep 2022 11:39:01 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 28UBagrf026344;
        Fri, 30 Sep 2022 11:38:58 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jwyc78shg-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Sep 2022 11:38:58 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 28UAZlNl001272;
        Fri, 30 Sep 2022 10:48:30 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma06ams.nl.ibm.com with ESMTP id 3jss5j806n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Sep 2022 10:48:30 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 28UAmShx65601946
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Sep 2022 10:48:28 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 214754C044;
        Fri, 30 Sep 2022 10:48:28 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A2E744C040;
        Fri, 30 Sep 2022 10:48:21 +0000 (GMT)
Received: from [9.43.99.23] (unknown [9.43.99.23])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 30 Sep 2022 10:48:21 +0000 (GMT)
Message-ID: <bf4ec1cb-49a4-f5cd-8fd0-c70b287180c0@linux.ibm.com>
Date:   Fri, 30 Sep 2022 16:18:15 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 01/15] perf/mem: Introduce
 PERF_MEM_LVLNUM_{EXTN_MEM|IO}
Content-Language: en-US
To:     Ravi Bangoria <ravi.bangoria@amd.com>, peterz@infradead.org,
        acme@kernel.org
Cc:     jolsa@kernel.org, namhyung@kernel.org, eranian@google.com,
        irogers@google.com, jmario@redhat.com, leo.yan@linaro.org,
        alisaidi@amazon.com, ak@linux.intel.com, kan.liang@linux.intel.com,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        tglx@linutronix.de, bp@alien8.de, x86@kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        sandipan.das@amd.com, ananth.narayan@amd.com, kim.phillips@amd.com,
        santosh.shukla@amd.com
References: <20220928095805.596-1-ravi.bangoria@amd.com>
 <20220928095805.596-2-ravi.bangoria@amd.com>
From:   kajoljain <kjain@linux.ibm.com>
In-Reply-To: <20220928095805.596-2-ravi.bangoria@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: pee7jtCLux7StWR11fcyOkmE5TJzH3PI
X-Proofpoint-ORIG-GUID: -B38wWBJndklsAYL4I03oLa-fj8vMFbs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-30_04,2022-09-29_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0
 lowpriorityscore=0 bulkscore=0 mlxlogscore=825 mlxscore=0 adultscore=0
 clxscore=1011 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209300073
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/28/22 15:27, Ravi Bangoria wrote:
> PERF_MEM_LVLNUM_EXTN_MEM which can be used to indicate accesses to
> extension memory like CXL etc. PERF_MEM_LVL_IO can be used for IO
> accesses but it can not distinguish between local and remote IO.
> Introduce new field PERF_MEM_LVLNUM_IO which can be clubbed with
> PERF_MEM_REMOTE_REMOTE to indicate Remote IO accesses.
> 
> Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
> ---
>  include/uapi/linux/perf_event.h | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
> index e639c74cf5fb..4ae3c249f675 100644
> --- a/include/uapi/linux/perf_event.h
> +++ b/include/uapi/linux/perf_event.h
> @@ -1336,7 +1336,9 @@ union perf_mem_data_src {
>  #define PERF_MEM_LVLNUM_L2	0x02 /* L2 */
>  #define PERF_MEM_LVLNUM_L3	0x03 /* L3 */
>  #define PERF_MEM_LVLNUM_L4	0x04 /* L4 */
> -/* 5-0xa available */
> +/* 5-0x8 available */
> +#define PERF_MEM_LVLNUM_EXTN_MEM 0x09 /* Extension memory */

Hi Ravi,
    Here we are adding entry explicitly for accesses to Extension memory
like CXL. In future if we want to extend it for cache or other accesses
, we again need to add new entries.
Can we rather add single entry say PERF_MEM_LVLNUM_EXTN and further can
use reserved bits to specify memory/cache?

Thanks,
Kajol Jain

> +#define PERF_MEM_LVLNUM_IO	0x0a /* I/O */
>  #define PERF_MEM_LVLNUM_ANY_CACHE 0x0b /* Any cache */
>  #define PERF_MEM_LVLNUM_LFB	0x0c /* LFB */
>  #define PERF_MEM_LVLNUM_RAM	0x0d /* RAM */
