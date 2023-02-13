Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5228B694775
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 14:52:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbjBMNww (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 08:52:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjBMNwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 08:52:51 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8B051B569;
        Mon, 13 Feb 2023 05:52:43 -0800 (PST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31DDCwYB004346;
        Mon, 13 Feb 2023 13:52:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=dkfmfXIRjpWoNu3K5PpaTpkBpSibFtUS2e97CqtZ0Nw=;
 b=XskA4RvBzYBFZkosdrmUf0Lg+c3A7U0dgBhpoj21Rz5e2tYIT8GQb5NiPdYwWv/jaKv5
 bbX9S6YfjY7i9XE7fv4Si62x8pghv5qlCqZH6CIgcllBfOuoylAei6nGEpSjkqGc72Y2
 SjzyqRRYb6jWlDk5w4A8Z03BX6NiQITcNB6t6ORjMdTgq7+XnXDSrNxrey6fSduD7NSG
 RKolJGZhcPwn2poZys0Qm/JDhj4JUnbzDew7E4frdbAkHj8wGXU8LILs2rGmSmeKMc9E
 LTBwrGYOogOjdWICroOPoLKblX2DOaOox31OghSpWzW26zcg8cWyrm3VukSj38FhbX1K /Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nqnvx10eb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Feb 2023 13:52:34 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 31DDmqOB031208;
        Mon, 13 Feb 2023 13:52:33 GMT
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nqnvx10dv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Feb 2023 13:52:33 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31DDMpFx000981;
        Mon, 13 Feb 2023 13:52:32 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([9.208.129.116])
        by ppma04dal.us.ibm.com (PPS) with ESMTPS id 3np2n75bgp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Feb 2023 13:52:32 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
        by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31DDqSQl64946564
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Feb 2023 13:52:28 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6067558056;
        Mon, 13 Feb 2023 13:52:28 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D1F8858054;
        Mon, 13 Feb 2023 13:52:26 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 13 Feb 2023 13:52:26 +0000 (GMT)
Message-ID: <f852f3d3-3d17-5204-1590-8add97033a6f@linux.ibm.com>
Date:   Mon, 13 Feb 2023 08:52:26 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v6 24/26] powerpc/pseries: Implement secvars for dynamic
 secure boot
Content-Language: en-US
To:     Michael Ellerman <michaele@au1.ibm.com>,
        Andrew Donnellan <ajd@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-integrity@vger.kernel.org
Cc:     ruscur@russell.cc, bgray@linux.ibm.com, nayna@linux.ibm.com,
        gcwilson@linux.ibm.com, gjoyce@linux.ibm.com, brking@linux.ibm.com,
        sudhakar@linux.ibm.com, erichte@linux.ibm.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        zohar@linux.ibm.com, joel@jms.id.au, npiggin@gmail.com
References: <20230210080401.345462-1-ajd@linux.ibm.com>
 <20230210080401.345462-25-ajd@linux.ibm.com>
 <f35e9ba1-5fdb-4cfa-5b41-cc55307dcd45@linux.ibm.com>
 <87pmadvm0n.fsf@mpe.ellerman.id.au>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <87pmadvm0n.fsf@mpe.ellerman.id.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: eSDkhZtczn3W6yuw4tWo_z4b3uMCRzOw
X-Proofpoint-ORIG-GUID: K1Ofr_8uIAfvl8mdqjozfg-hZHOar7Mg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-13_09,2023-02-13_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1015 mlxscore=0 phishscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 bulkscore=0 spamscore=0 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302130122
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/13/23 06:32, Michael Ellerman wrote:
> Stefan Berger <stefanb@linux.ibm.com> writes:
>> On 2/10/23 03:03, Andrew Donnellan wrote:
>>> From: Russell Currey <ruscur@russell.cc>
> ...
>>> +static int plpks_set_variable(const char *key, u64 key_len, u8 *data,
>>> +			      u64 data_size)
>>> +{
>>> +	struct plpks_var var = {0};
>>> +	int rc = 0;
>>> +	u64 flags;
>>> +
>>> +	// Secure variables need to be prefixed with 8 bytes of flags.
>>> +	// We only want to perform the write if we have at least one byte of data.
>>> +	if (data_size <= sizeof(flags))
>>> +		return -EINVAL;
>>> +
>>> +	// We subtract 1 from key_len because we don't need to include the
>>> +	// null terminator at the end of the string
>>> +	var.name = kcalloc(key_len - 1, sizeof(wchar_t), GFP_KERNEL);
>>> +	if (!var.name)
>>> +		return -ENOMEM;
>>> +	rc = utf8s_to_utf16s(key, key_len - 1, UTF16_LITTLE_ENDIAN, (wchar_t *)var.name,
>>> +			     key_len - 1);
>>> +	if (rc < 0)
>>> +		goto err;
>>> +	var.namelen = rc * 2;
>>> +
>>> +	memcpy(&flags, data, sizeof(flags));
>>
>> conversion from bytestream to integer: I think in this case it would be better to use
>>
>> flags = cpu_to_be64p((__u64*)data);
>>
>> so that the flags always in hypervisor/big endian format
> 
> I don't think it's correct to byte swap the flags here. They must be in
> big endian format, but that's up to the caller.
> 
> The powernv secvar backend doesn't byte swap the flags, if the pseries
> one did then the final content of the variable, written either by phyp
> or OPAL, would differ depending on which backend is active.
> 
> Or am I missing something?

It seems wrong to not use the cpu_to_be64p() API to convert a byte stream to flags... That's why I suggested this.

    Stefan

> 
> cheers
