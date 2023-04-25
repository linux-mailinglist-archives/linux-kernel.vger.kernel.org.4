Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 403136EE183
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 13:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233658AbjDYL6j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 07:58:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233892AbjDYL6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 07:58:32 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12FC74C0C;
        Tue, 25 Apr 2023 04:58:24 -0700 (PDT)
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33PBnDTr000928;
        Tue, 25 Apr 2023 11:58:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=XChf822fBz7pcuvL0Rw0vcWCMdx3TekKKlF+GQ1BEOY=;
 b=jLNmfcRyqx98Il4Rf4UxA8Tcct5qvULDoZfO8IwHw83GBfLQqP0BFAoGWhDsFn0H+KDc
 TQ3TdrrR5g9W79lRDq66CZN3FWWkP3CfPFOvkH8aeQBmENwUG+NdCaEwuf7L2JQ8qiyo
 xJDac6Cb4A2PuqNARYAaUnUYxKNM5eQmAe8Sw4I8xGVXEZN4j5754RRX0hTZ+XjEvSAK
 tB+RbKycVq6q4URb74vmZzMdsH36Y6Tap1sgBSc8S+l3rhc+7TRx2JCZTJs7nbDWAal5
 bYkBebhIe1xr+fyCWL8pG4/Kjwc7i3c3fkiseaSDO+RlkqY4bxYNjjiPK+ZF8nisFhU2 0Q== 
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3q6earr9g2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Apr 2023 11:58:12 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 33P96Ii2015923;
        Tue, 25 Apr 2023 11:58:11 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([9.208.130.101])
        by ppma03dal.us.ibm.com (PPS) with ESMTPS id 3q47784396-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Apr 2023 11:58:11 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
        by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 33PBw9rO16188024
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Apr 2023 11:58:10 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C87AA58054;
        Tue, 25 Apr 2023 11:58:09 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8CA435803F;
        Tue, 25 Apr 2023 11:58:08 +0000 (GMT)
Received: from [9.160.16.18] (unknown [9.160.16.18])
        by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 25 Apr 2023 11:58:08 +0000 (GMT)
Message-ID: <3dd118d7-8ba9-33ff-fc3d-030c601df0d1@linux.ibm.com>
Date:   Tue, 25 Apr 2023 06:58:07 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH 4/5] Glue code for optmized Poly1305 implementation for
 ppc64le.
Content-Language: en-US
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     linux-crypto@vger.kernel.org, leitao@debian.org,
        nayna@linux.ibm.com, appro@cryptogams.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        mpe@ellerman.id.au, ltcgcw@linux.vnet.ibm.com, dtsen@us.ibm.com
References: <20230424184726.2091-1-dtsen@linux.ibm.com>
 <20230424184726.2091-5-dtsen@linux.ibm.com>
 <ZEdovn1XbEUptK+m@gondor.apana.org.au>
From:   Danny Tsen <dtsen@linux.ibm.com>
In-Reply-To: <ZEdovn1XbEUptK+m@gondor.apana.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: BbxoMNJ3dhrS0Z9Z14v7l8l5J4AUHGAt
X-Proofpoint-GUID: BbxoMNJ3dhrS0Z9Z14v7l8l5J4AUHGAt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-25_04,2023-04-25_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 mlxscore=0 adultscore=0 mlxlogscore=879 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 clxscore=1015 impostorscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304250103
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Did not notice that.  Will do fix it.

Thanks.

-Danny

On 4/25/23 12:44 AM, Herbert Xu wrote:
> On Mon, Apr 24, 2023 at 02:47:25PM -0400, Danny Tsen wrote:
>> +	if (likely(srclen >= POLY1305_BLOCK_SIZE)) {
>> +		bytes = round_down(srclen, POLY1305_BLOCK_SIZE);
>> +		used = crypto_poly1305_setdctxkey(dctx, src, bytes);
>> +		if (likely(used)) {
>> +			srclen -= used;
>> +			src += used;
>> +		}
>> +		if (srclen >= POLY1305_BLOCK_SIZE*4) {
>> +			vsx_begin();
> Your chacha code has a SIMD-fallback, how come this one doesn't?
>
> Thanks,
