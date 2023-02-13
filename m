Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22110694498
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 12:33:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231156AbjBMLc7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 06:32:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbjBMLcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 06:32:54 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EE493595;
        Mon, 13 Feb 2023 03:32:51 -0800 (PST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31DBO8vm015161;
        Mon, 13 Feb 2023 11:32:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : in-reply-to : references : date : message-id : mime-version :
 content-type; s=pp1; bh=YavUgS/7WqUzBkoJqcc47oGKhpBEX+AUP+9lgzPdmZE=;
 b=fFTNnLXrgj/c0/UONGhu4DbXM//AEG3wrifHE3w72WlV8Vb1ui7y8mHRw6yq3bvkKJXE
 PflKiwFN+djICFIHr+vGFnBFv9PrFkMIEgVLkIXWG6VuQevjvuP6GtGP0i55Oi+g7Z72
 ounXdTuvz+8GrCMWOcAeMxul1rNQfbwxVIgY9PSbrtqF+HZFWFYrzDVq6zldrl5C+Qk5
 oNLsTeONzvWjT1jCmRGOzEuBu4Qg/WY/+2imT7bj9dUuc/boTdD+wv8JtcekQh2nYb8k
 4TgmprjmJZPORk9s5azwlcEwzjm0hg6Enudk6g6neEIrhSHnIWxbL8Xzukn5gIvCdswC 2g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nqma58655-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Feb 2023 11:32:40 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 31DBPKQG018306;
        Mon, 13 Feb 2023 11:32:39 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nqma58647-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Feb 2023 11:32:39 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31D8L7do000531;
        Mon, 13 Feb 2023 11:32:37 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma04fra.de.ibm.com (PPS) with ESMTPS id 3np2n69wr1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Feb 2023 11:32:37 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31DBWYSe26083890
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Feb 2023 11:32:34 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 92F5620043;
        Mon, 13 Feb 2023 11:32:34 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0F7C920040;
        Mon, 13 Feb 2023 11:32:34 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 13 Feb 2023 11:32:34 +0000 (GMT)
Received: from localhost (unknown [9.177.92.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 1835E600BA;
        Mon, 13 Feb 2023 22:32:28 +1100 (AEDT)
From:   Michael Ellerman <michaele@au1.ibm.com>
To:     Stefan Berger <stefanb@linux.ibm.com>,
        Andrew Donnellan <ajd@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-integrity@vger.kernel.org
Cc:     ruscur@russell.cc, bgray@linux.ibm.com, nayna@linux.ibm.com,
        gcwilson@linux.ibm.com, gjoyce@linux.ibm.com, brking@linux.ibm.com,
        sudhakar@linux.ibm.com, erichte@linux.ibm.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        zohar@linux.ibm.com, joel@jms.id.au, npiggin@gmail.com
Subject: Re: [PATCH v6 24/26] powerpc/pseries: Implement secvars for dynamic
 secure boot
In-Reply-To: <f35e9ba1-5fdb-4cfa-5b41-cc55307dcd45@linux.ibm.com>
References: <20230210080401.345462-1-ajd@linux.ibm.com>
 <20230210080401.345462-25-ajd@linux.ibm.com>
 <f35e9ba1-5fdb-4cfa-5b41-cc55307dcd45@linux.ibm.com>
Date:   Mon, 13 Feb 2023 22:32:24 +1100
Message-ID: <87pmadvm0n.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 1G0VJmwZxXmTG6Lis3iv0eBXRWI858R-
X-Proofpoint-GUID: P4MOPePpTtEcMWjinrbw81MbN0NDKyVG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-13_06,2023-02-13_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 mlxscore=0 bulkscore=0 malwarescore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 mlxlogscore=988 phishscore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302130104
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stefan Berger <stefanb@linux.ibm.com> writes:
> On 2/10/23 03:03, Andrew Donnellan wrote:
>> From: Russell Currey <ruscur@russell.cc>
...
>> +static int plpks_set_variable(const char *key, u64 key_len, u8 *data,
>> +			      u64 data_size)
>> +{
>> +	struct plpks_var var = {0};
>> +	int rc = 0;
>> +	u64 flags;
>> +
>> +	// Secure variables need to be prefixed with 8 bytes of flags.
>> +	// We only want to perform the write if we have at least one byte of data.
>> +	if (data_size <= sizeof(flags))
>> +		return -EINVAL;
>> +
>> +	// We subtract 1 from key_len because we don't need to include the
>> +	// null terminator at the end of the string
>> +	var.name = kcalloc(key_len - 1, sizeof(wchar_t), GFP_KERNEL);
>> +	if (!var.name)
>> +		return -ENOMEM;
>> +	rc = utf8s_to_utf16s(key, key_len - 1, UTF16_LITTLE_ENDIAN, (wchar_t *)var.name,
>> +			     key_len - 1);
>> +	if (rc < 0)
>> +		goto err;
>> +	var.namelen = rc * 2;
>> +
>> +	memcpy(&flags, data, sizeof(flags));
>
> conversion from bytestream to integer: I think in this case it would be better to use
>
> flags = cpu_to_be64p((__u64*)data);
>
> so that the flags always in hypervisor/big endian format

I don't think it's correct to byte swap the flags here. They must be in
big endian format, but that's up to the caller.

The powernv secvar backend doesn't byte swap the flags, if the pseries
one did then the final content of the variable, written either by phyp
or OPAL, would differ depending on which backend is active.

Or am I missing something?

cheers
