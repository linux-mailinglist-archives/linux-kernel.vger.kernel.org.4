Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BEC66EE162
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 13:54:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233945AbjDYLyI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 07:54:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234005AbjDYLyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 07:54:03 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA20013F9C;
        Tue, 25 Apr 2023 04:53:58 -0700 (PDT)
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33PBeqv7031308;
        Tue, 25 Apr 2023 11:53:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=PYQw1s1UJ4ZCRX8T/hOdGvjUGWcyLQTuH++SIg+EMBA=;
 b=PUSBuMmfHRXh+xpkXntuoqa9ndYyrnPRRSx36solurRrh8yV6R25Jss8Xp14jOg8evO8
 hQNqgnx0Jrl9Wlo7gAWxsCPCyDTWZKXlB0zkOIHasrA5Y4Qa091qHq+H9e0PCml5U6IQ
 nmdgbAYXDD/DyhM2pqBzr4wVcaLQ48noJ3FBN39a52TyqY19w7TTABwdkCeHQCgEduWh
 S15ylVu9DejlX/1+MsBRVI3SnL+fAoKNV7b0ArJrE8haC0DApjSjhU57DhwNf+vsWR0E
 +t9nvmW89sCuCRADRA7T0tlzEHsSapSySpKVXf0MK3qtVfXOgVEMEGZkquSqkYXbEJmB rA== 
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3q6d30u5ub-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Apr 2023 11:53:45 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 33P8lJji016566;
        Tue, 25 Apr 2023 11:53:44 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([9.208.129.114])
        by ppma03dal.us.ibm.com (PPS) with ESMTPS id 3q477842sp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Apr 2023 11:53:44 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
        by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 33PBrgGY27525864
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Apr 2023 11:53:42 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8574B58054;
        Tue, 25 Apr 2023 11:53:42 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4F5DB5804E;
        Tue, 25 Apr 2023 11:53:41 +0000 (GMT)
Received: from [9.160.16.18] (unknown [9.160.16.18])
        by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 25 Apr 2023 11:53:41 +0000 (GMT)
Message-ID: <841ea455-ef41-427c-7ce5-3c9c942abd14@linux.ibm.com>
Date:   Tue, 25 Apr 2023 06:53:40 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH 2/5] Glue code for optmized Chacha20 implementation for
 ppc64le.
Content-Language: en-US
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     linux-crypto@vger.kernel.org, leitao@debian.org,
        nayna@linux.ibm.com, appro@cryptogams.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        mpe@ellerman.id.au, ltcgcw@linux.vnet.ibm.com, dtsen@us.ibm.com
References: <20230424184726.2091-1-dtsen@linux.ibm.com>
 <20230424184726.2091-3-dtsen@linux.ibm.com>
 <ZEdoFv4tS69ELyNo@gondor.apana.org.au>
From:   Danny Tsen <dtsen@linux.ibm.com>
In-Reply-To: <ZEdoFv4tS69ELyNo@gondor.apana.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: zlHphbR6COsD9eRHL4IDo-_c0b1YBhGx
X-Proofpoint-GUID: zlHphbR6COsD9eRHL4IDo-_c0b1YBhGx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-25_04,2023-04-25_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 mlxlogscore=999 clxscore=1015 malwarescore=0 bulkscore=0
 priorityscore=1501 spamscore=0 impostorscore=0 phishscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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

Got it.  Will fix it.

Thanks.

-Danny


On 4/25/23 12:41 AM, Herbert Xu wrote:
> On Mon, Apr 24, 2023 at 02:47:23PM -0400, Danny Tsen wrote:
>> +static int chacha_p10_stream_xor(struct skcipher_request *req,
>> +				 const struct chacha_ctx *ctx, const u8 *iv)
>> +{
>> +	struct skcipher_walk walk;
>> +	u32 state[16];
>> +	int err;
>> +
>> +	err = skcipher_walk_virt(&walk, req, false);
>> +	if (err)
>> +		return err;
>> +
>> +	chacha_init_generic(state, ctx->key, iv);
>> +
>> +	while (walk.nbytes > 0) {
>> +		unsigned int nbytes = walk.nbytes;
>> +
>> +		if (nbytes < walk.total)
>> +			nbytes = rounddown(nbytes, walk.stride);
>> +
>> +		if (!static_branch_likely(&have_p10) ||
> You don't need the static branch in the Crypto API code since
> the registration is already conditional.
>
> Cheers,
