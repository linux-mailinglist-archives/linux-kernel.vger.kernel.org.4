Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3E6D73BCF2
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 18:45:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231770AbjFWQp4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 12:45:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231732AbjFWQpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 12:45:53 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8DED2941;
        Fri, 23 Jun 2023 09:45:49 -0700 (PDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35NGb2OW021505;
        Fri, 23 Jun 2023 16:45:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=I8SWemhR+QCoNTe129luI4bSps2rAXe9z6RPAhhT/B0=;
 b=sDJeKgtyxzShgDBYJ6THoB01wXVRHLtw95uyHDEc/3MwHRtuM/DZo/uVsaGjyLjly151
 bIW8ctPJQcyNqJM1OnmZtArPr5cTuKFUCS4ubFiE0110+DHJwI0qVmp2QDS6s1h5Jgf3
 Hn36cNXCry6UqMuASwu23vqP2H5pLb1hahR+dmrscInr4M4jUZiFVffE2hIuI3nQSiNs
 kumtMygMOXUVsr621JqjjzeetcebNGI8cmLgGYaEbnyDir4m6ckJPR3pbZCHbPfe9tbJ
 htPkSBsyQHujAH8y4gdwY6pUhGQhapJc9jZKVwXO1misALIbPJPNCx0Ar93ezGYEZw/e Hw== 
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rdesarewx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Jun 2023 16:45:22 +0000
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35NFE3AW016016;
        Fri, 23 Jun 2023 16:45:21 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([9.208.129.117])
        by ppma03wdc.us.ibm.com (PPS) with ESMTPS id 3r94f6fuh8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Jun 2023 16:45:21 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
        by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 35NGjKvU5767738
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 23 Jun 2023 16:45:20 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0633258059;
        Fri, 23 Jun 2023 16:45:20 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 63D405804B;
        Fri, 23 Jun 2023 16:45:19 +0000 (GMT)
Received: from [9.61.119.251] (unknown [9.61.119.251])
        by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 23 Jun 2023 16:45:19 +0000 (GMT)
Message-ID: <9cc6addc-cd41-7794-79a0-5c776946f492@linux.ibm.com>
Date:   Fri, 23 Jun 2023 11:45:19 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 3/4] spi: Split transfers larger than max size
To:     Mark Brown <broonie@kernel.org>
Cc:     Vincent Whitchurch <vincent.whitchurch@axis.com>,
        krzysztof.kozlowski@linaro.org, andi@etezian.org, kernel@axis.com,
        alim.akhtar@samsung.com, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20220927112117.77599-1-vincent.whitchurch@axis.com>
 <20220927112117.77599-4-vincent.whitchurch@axis.com>
 <6dff003d-c727-e4a3-b5d3-f58beb2b02cb@linux.ibm.com>
 <ZJS6OnzRapPCboC8@finisterre.sirena.org.uk>
Content-Language: en-US
From:   Eddie James <eajames@linux.ibm.com>
In-Reply-To: <ZJS6OnzRapPCboC8@finisterre.sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: rpLJitQz5Z2uiSLhRQ6yHppBOusY_BTH
X-Proofpoint-GUID: rpLJitQz5Z2uiSLhRQ6yHppBOusY_BTH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-23_08,2023-06-22_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 phishscore=0 mlxlogscore=999
 lowpriorityscore=0 adultscore=0 clxscore=1015 malwarescore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306230148
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/22/23 16:16, Mark Brown wrote:
> On Thu, Jun 22, 2023 at 02:48:36PM -0500, Eddie James wrote:
>> On 9/27/22 06:21, Vincent Whitchurch wrote:
>>> A couple of drivers call spi_split_transfers_maxsize() from their
>>> ->prepare_message() callbacks to split transfers which are too big for
>>> them to handle.  Add support in the core to do this based on
>>> ->max_transfer_size() to avoid code duplication.
>> I've been testing AT25 functionality in linux 6.1 and I believe this patch
>> is breaking the AT25 protocol. It will split a write command up such that
>> some of the data is in a different transfer than  the write enable and
>> address. According to my understanding of the AT25 spec, that doesn't
>> work... Someone correct me if I'm wrong though. Do we need a flag to
>> enable/disable this behavior depending on the client perhaps?
> Could you be more specific about the manner in which you think this is
> breaking things?  The size of transfer is immaterial to the client
> device on SPI, the client will be counting clocks while the chip select
> is asserted.  How the controller chooses to split things up is really
> not particularly visible or relevant, it might bitbang things out one
> bit at a time, transfer a single word at a time or batch things up
> further.  So long as the chip select is asserted it's all the same to
> the client device.


Ok, I understand better now. Agreed it shouldn't make a difference, but 
this is actually a limitation of the spi controller I'm using (spi-fsi). 
The controller cannot handle multiple transfers keeping the chip select 
enabled... I guess the driver can batch transfers in the message to get 
around this, unless you want to add a flag for that behavior.


>
> In any case this is all based on the maximum transfer size advertised by
> the conteroller driver, if the device can physically handle larger
> transfers then there's no reason for it to set a limit.  If the driver
> can't physically handle larger transfers and it does make a difference
> then the system simply won't work.


Yep, this is also an artifact of the spi-fsi driver having different 
transfer size limits for writes and reads. Funnily enough the at25 
driver doesn't truly respect the max transfer size (it doesn't include 
the write command and address bytes in the calculation against the max 
transfer size) so that's how this worked previously.

Thanks!

Eddie


