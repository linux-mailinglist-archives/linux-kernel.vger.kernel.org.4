Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4630E69B567
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 23:20:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbjBQWU0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 17:20:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbjBQWUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 17:20:24 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88D0563BF3;
        Fri, 17 Feb 2023 14:20:19 -0800 (PST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31HKZTg4015157;
        Fri, 17 Feb 2023 22:20:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : subject; s=pp1;
 bh=mhjb/9tQC18m3DhbPkph4yznk7N7qkt/C7MEhpyUlaw=;
 b=EmRI3W7mwpln/lGJil90AkGhWxyb8obVLwOz8QGWdcR6X8icseAJNwe3Fkua78vb3iBZ
 CiDd+3SqTy0jqZwTc1UY3hEaArElbX3RtxuW5XqZREZrV3hKqgVlLgS03aQNwghFPmSy
 PHRBz+8ZOKi3iSnsQHCaijH344voSvebh0rvozAbkTomqpbOgegS8gnal1fZFyIciI7i
 Bw2SkajqoUnrQKfyRN32y6rWq6p9P0ZaHX0PkSdJqGIraRKfqwBTM4ngwCxoDdOcipEG
 0Bc48ZNcoqE2VwuJqPfUwbeA8SAuMadrBmq8sV6UJexEhmMVP9lZ7jfX2kChabEldqVN 9A== 
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nte73dte4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Feb 2023 22:20:10 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31HM0lgZ000883;
        Fri, 17 Feb 2023 22:20:09 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([9.208.129.120])
        by ppma04dal.us.ibm.com (PPS) with ESMTPS id 3np2n82cr9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Feb 2023 22:20:09 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
        by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31HMK7Vv60031332
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Feb 2023 22:20:08 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D884E58052;
        Fri, 17 Feb 2023 22:20:07 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 57C7358054;
        Fri, 17 Feb 2023 22:20:07 +0000 (GMT)
Received: from [9.163.28.78] (unknown [9.163.28.78])
        by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 17 Feb 2023 22:20:07 +0000 (GMT)
Message-ID: <02d4b4b5-4292-aef0-8e20-7ec031348e91@linux.ibm.com>
Date:   Fri, 17 Feb 2023 16:20:06 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.7.2
Content-Language: en-US
To:     "Elliott, Robert (Servers)" <elliott@hpe.com>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>
Cc:     "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "leitao@debian.org" <leitao@debian.org>,
        "nayna@linux.ibm.com" <nayna@linux.ibm.com>,
        "appro@cryptogams.org" <appro@cryptogams.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ltcgcw@linux.vnet.ibm.com" <ltcgcw@linux.vnet.ibm.com>,
        "dtsen@us.ibm.com" <dtsen@us.ibm.com>
References: <20230217161805.236319-1-dtsen@linux.ibm.com>
 <20230217161805.236319-2-dtsen@linux.ibm.com>
 <MW5PR84MB1842DB9DF917B9B3B83A005BABA19@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
From:   Danny Tsen <dtsen@linux.ibm.com>
In-Reply-To: <MW5PR84MB1842DB9DF917B9B3B83A005BABA19@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: XYCtLY4FySTB1k31z7lEQ3LapKtKWems
X-Proofpoint-GUID: XYCtLY4FySTB1k31z7lEQ3LapKtKWems
Subject: RE: [PATCH v3 1/6] Update Kconfig and Makefile.
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-17_15,2023-02-17_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 mlxscore=0 spamscore=0
 malwarescore=0 lowpriorityscore=0 phishscore=0 clxscore=1011
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2302170193
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robert,

Power10+ means Power10 or later.  Other modes were not stripped by the 
perl script.

Thanks for the comments I will fix the suggestions.

-Danny

On 2/17/23 3:44 PM, Elliott, Robert (Servers) wrote:
>> +config CRYPTO_P10_AES_GCM
>> +	tristate "Stitched AES/GCM acceleration support on P10+ CPU (PPC)"
>> +	depends on PPC64 && POWER10_CPU && CPU_LITTLE_ENDIAN
>> +	select CRYPTO_LIB_AES
>> +	select CRYPTO_ALGAPI
>> +	select CRYPTO_AEAD
>> +	default m
>> +	help
>> +	  Support for cryptographic acceleration instructions on Power10+ CPU.
>> +	    This module supports stitched acceleration for AES/GCM in
>> hardware.
> Is "Power10+" a specific architecture or does that mean "Power10 or later"?
>
> Please follow the newer wording conventions for the menu item and
> help text, more like:
>
> config CRYPTO_AES_GCM_PPC_P10
>          tristate "AEAD cipher: AES in GCM mode (Power10)"
>
>          help
>            AEAD cipher: AES cipher algorithms (FIPS-197) with
> 	   GCM (Galois/Counter Mode) authenticated encryption mode (NIST SP800-38D)
>
>            Architecture: powerpc64 using:
>            - little-endian
>            - Power10 features
>
>            [some description here]
>
> Also, all the other powerpc cra_driver_names follow
> 	alg-arch
> not
> 	arch-alg
>
> so
> 	.base.cra_driver_name	= "p10_aes_gcm",
> might be better as
> 	.base.cra_driver_name	= "aes-gcm-p10",
>
> Patch 4 seems to have code for lots of other modes like CBC and XTS.
> Does the perl script strip out all of that?
>
>
>
