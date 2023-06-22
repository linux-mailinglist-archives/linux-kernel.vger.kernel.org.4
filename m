Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86B157397FB
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 09:15:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbjFVHPw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 03:15:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjFVHPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 03:15:50 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89A84E69;
        Thu, 22 Jun 2023 00:15:47 -0700 (PDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35M75nW4022900;
        Thu, 22 Jun 2023 07:15:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=LDHaapSVWvbIG0L5Ay14IB3K+j+a/r4eE/xCCjB5YdU=;
 b=HA3MVg/sgFNQXA6d15zutPP7LY3BoVrQjoqDkDl3w8e/yhZhjJIZB22/aMeg/nwpzZYM
 5fy27OOiRpEeEfhJdlQ7N12+M5B/bgea42niSXFtHu4A4mUFH/dLEP0BFiPikYyFFXY+
 R3Y0u0OOilRbQk75AbP6nHL0gDjHdaRI6xW0nYT2+mES5b+zV5Qf0vh5Mu+W2Pv/JB5r
 pmiGQCfCAqxhFULLNST9RL5dsS/hNODo+JL4tgbuectIFU5zQ7WM3z9UXXRgbaMVNI6v
 tZ4ajrBfV+AD2DJFixgjDfC1SFbirY3rq7cPwTfMbvFNuiBpw/PP5870QQv2R+JYpLqD qQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rchep0ca8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Jun 2023 07:15:31 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35M76P2o027008;
        Thu, 22 Jun 2023 07:15:30 GMT
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rchep0c9g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Jun 2023 07:15:30 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35M2t6Du017857;
        Thu, 22 Jun 2023 07:15:28 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma05fra.de.ibm.com (PPS) with ESMTPS id 3r94f52gcp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Jun 2023 07:15:28 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 35M7FPNd42336864
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Jun 2023 07:15:25 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1578A2004B;
        Thu, 22 Jun 2023 07:15:25 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C39CE20043;
        Thu, 22 Jun 2023 07:15:24 +0000 (GMT)
Received: from [9.152.224.35] (unknown [9.152.224.35])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 22 Jun 2023 07:15:24 +0000 (GMT)
Message-ID: <98375832-3d29-1f03-145f-8d6e763dd2d2@linux.ibm.com>
Date:   Thu, 22 Jun 2023 09:15:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH] s390/net: lcs: fix build errors when FDDI is a loadable
 module
Content-Language: en-US
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     kernel test robot <lkp@intel.com>,
        Simon Horman <simon.horman@corigine.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
References: <20230621213742.8245-1-rdunlap@infradead.org>
From:   Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <20230621213742.8245-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: GOC3sp2yjV-PtfW51iFc-kKLnElSNJ5g
X-Proofpoint-GUID: Os9Pko7AHpcTwayR_5Q8NJ1gz5T5P4-r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-22_04,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 clxscore=1011 suspectscore=0 mlxlogscore=999 bulkscore=0 impostorscore=0
 priorityscore=1501 mlxscore=0 malwarescore=0 lowpriorityscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306220057
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 21.06.23 23:37, Randy Dunlap wrote:
> Require FDDI to be built-in if it is used. LCS needs FDDI to be
> built-in to build without errors.
> 
> Prevents these build errors:
> s390-linux-ld: drivers/s390/net/lcs.o: in function `lcs_new_device':
> drivers/s390/net/lcs.c:2150: undefined reference to `fddi_type_trans'
> s390-linux-ld: drivers/s390/net/lcs.c:2151: undefined reference to `alloc_fddidev'
> 
> This FDDI requirement effectively restores the previous condition
> before the blamed patch, when #ifdef CONFIG_FDDI was used, without
> testing for CONFIG_FDDI_MODULE.
> 
> Fixes: 128272336120 ("s390/net: lcs: use IS_ENABLED() for kconfig detection")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: kernel test robot <lkp@intel.com>
> Link: lore.kernel.org/r/202306202129.pl0AqK8G-lkp@intel.com
> Suggested-by: Simon Horman <simon.horman@corigine.com>
> Cc: Alexandra Winter <wintera@linux.ibm.com>
> Cc: Wenjia Zhang <wenjia@linux.ibm.com>
> Cc: linux-s390@vger.kernel.org
> Cc: netdev@vger.kernel.org
> Cc: Heiko Carstens <hca@linux.ibm.com>
> Cc: Vasily Gorbik <gor@linux.ibm.com>
> Cc: Alexander Gordeev <agordeev@linux.ibm.com>
> Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
> Cc: Sven Schnelle <svens@linux.ibm.com>
> Cc: David S. Miller <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> ---
>  drivers/s390/net/Kconfig |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff -- a/drivers/s390/net/Kconfig b/drivers/s390/net/Kconfig
> --- a/drivers/s390/net/Kconfig
> +++ b/drivers/s390/net/Kconfig
> @@ -6,11 +6,13 @@ config LCS
>  	def_tristate m
>  	prompt "Lan Channel Station Interface"
>  	depends on CCW && NETDEVICES && (ETHERNET || FDDI)
> +	depends on FDDI=y || FDDI=n
>  	help
>  	  Select this option if you want to use LCS networking on IBM System z.
>  	  This device driver supports FDDI (IEEE 802.7) and Ethernet.
>  	  To compile as a module, choose M. The module name is lcs.
>  	  If you do not know what it is, it's safe to choose Y.
> +	  If FDDI is used, it must be built-in (=y).
>  
>  config CTCM
>  	def_tristate m
> 


Wow Randy and Simon, you are reacting faster than I was able to evaluate this yesterday.
2 thoughts:

1) As ETHERNET cannot be a module and this patch prevents FDDI from being a module, then 
128272336120 ("s390/net: lcs: use IS_ENABLED() for kconfig detection")
is kind of pointless and can as well be reverted instead of doing this fix.
Or am I missing something?

2) I wonder whether

  	depends on CCW && NETDEVICES && (ETHERNET || FDDI)
 +	depends on FDDI || FDDI=n

would do what we want here:
When FDDI is a loadable module, LCS mustn't be built-in.

I will do some experiments and let you know.

Alexandra



