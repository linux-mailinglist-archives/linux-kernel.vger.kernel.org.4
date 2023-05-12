Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26491700F04
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 20:42:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239089AbjELSmY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 14:42:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238620AbjELSmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 14:42:22 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AD207695
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 11:42:14 -0700 (PDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34CIdN3K018349;
        Fri, 12 May 2023 18:41:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=A0ZlywmD2aD1qzsJXpiHd4vLw+jeD/XeIFy/jQ6YHpg=;
 b=jzl74cEeenulsYMrmOGpxNR1j6AQn8Fn3FSr6IJzBkqiImzYhIUfrA5czH1NnyaxGJja
 AiiT2ri0oKLAFkzm0WrYCAZ4jv06EkkY150WvR5Mg7rlSg0u8Ldhy3e801tngzHuIx/u
 PBiZfyRMEFL0w6p5HCTYgZmxNEfEWq6J4IC7fRpTCJ5KVuYXc4uT+xh5J2YXGEOiqac0
 8CeXPYY1yVBN0N/wMoyfb5VvQONuTn4XJSh6bsdqI8eBSq01rE7r+UjJsGZkbe+0FOXN
 qjABnomlVCvYM+Tb7nZwxyuIZeWeaH4/BiXOHHAkX3sTDDqRNgXkskBzxKu4f8LKYxRx lA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qhth78mf7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 May 2023 18:41:59 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34CIehV9024517;
        Fri, 12 May 2023 18:41:57 GMT
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qhth78me5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 May 2023 18:41:57 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 34CGDJMC029893;
        Fri, 12 May 2023 18:41:56 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([9.208.129.116])
        by ppma03dal.us.ibm.com (PPS) with ESMTPS id 3qf7y9kxsb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 May 2023 18:41:56 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
        by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 34CIftDX41877892
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 May 2023 18:41:55 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 024E85805E;
        Fri, 12 May 2023 18:41:55 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E5BAD5805D;
        Fri, 12 May 2023 18:41:46 +0000 (GMT)
Received: from [9.43.118.245] (unknown [9.43.118.245])
        by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 12 May 2023 18:41:46 +0000 (GMT)
Message-ID: <431faa39-4f5c-0087-7ce5-16796ca1a9e1@linux.vnet.ibm.com>
Date:   Sat, 13 May 2023 00:11:45 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v4 05/12] sched/fair: Keep a fully_busy SMT sched group as
 busiest
Content-Language: en-US
To:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc:     Ricardo Neri <ricardo.neri@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Len Brown <len.brown@intel.com>, Mel Gorman <mgorman@suse.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        "Tim C . Chen" <tim.c.chen@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        shrikanth hegde <sshegde@linux.vnet.ibm.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <20230406203148.19182-1-ricardo.neri-calderon@linux.intel.com>
 <20230406203148.19182-6-ricardo.neri-calderon@linux.intel.com>
From:   Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
In-Reply-To: <20230406203148.19182-6-ricardo.neri-calderon@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: N_8bzCah2WlTkoBS2S9n5SgJpBoRZCYX
X-Proofpoint-GUID: Gzjm0TfiVbaoHEqaXk59UirojH1_Fja8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-12_11,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 phishscore=0 bulkscore=0 clxscore=1011 mlxlogscore=999 lowpriorityscore=0
 impostorscore=0 suspectscore=0 priorityscore=1501 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305120156
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/7/23 2:01 AM, Ricardo Neri wrote:
> When comparing two fully_busy scheduling groups, keep the current busiest
> group if it represents an SMT core. Tasks in such scheduling group share
> CPU resources and need more help than tasks in a non-SMT fully_busy group.
>
> Cc: Ben Segall <bsegall@google.com>
> Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: Ionela Voinescu <ionela.voinescu@arm.com>
> Cc: Len Brown <len.brown@intel.com>
> Cc: Mel Gorman <mgorman@suse.de>
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Tim C. Chen <tim.c.chen@intel.com>
> Cc: Valentin Schneider <vschneid@redhat.com>
> Cc: x86@kernel.org
> Cc: linux-kernel@vger.kernel.org
> Tested-by: Zhang Rui <rui.zhang@intel.com>
> Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> ---
> Changes since v3:
>  * None
>
> Changes since v2:
>  * Introduced this patch.
>
> Changes since v1:
>  * N/A
> ---
>  kernel/sched/fair.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index b151e93ec316..ea23a5163bfa 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -9566,10 +9566,22 @@ static bool update_sd_pick_busiest(struct lb_env *env,
>  		 * contention when accessing shared HW resources.
>  		 *
>  		 * XXX for now avg_load is not computed and always 0 so we
> -		 * select the 1st one.
> +		 * select the 1st one, except if @sg is composed of SMT
> +		 * siblings.
>  		 */
> -		if (sgs->avg_load <= busiest->avg_load)
> +
> +		if (sgs->avg_load < busiest->avg_load)
>  			return false;
> +
> +		if (sgs->avg_load == busiest->avg_load) {
> +			/*
> +			 * SMT sched groups need more help than non-SMT groups.
> +			 * If @sg happens to also be SMT, either choice is good.
> +			 */
> +			if (sds->busiest->flags & SD_SHARE_CPUCAPACITY)
> +				return false;
> +		}
> +
>  		break;

IIUC,

Earlier, we used to go to out_balanced if sgs->avg_load <= busiest->avg_load.
Now we go only if it is less. lets say sgs->avg_load == busiest->avg_load,
then we will return true in MC,DIE domain. This might end up traversing
multiple such group's and pick the last one as the busiest instead of
first. I guess eventually any load balance if exists will be fixed.  But
this might cause slight overhead. would it?



nit: There is typo in [2/12]  if the whole core is repeated.
+	 * CPUs. When done between cores, do it only if the whole core if the
+	 * whole core is idle.

Mentioning in this reply instead, to avoid sending another mail reply for this.


>  
>  	case group_has_spare:

