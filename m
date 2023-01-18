Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7338C671E13
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 14:37:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbjARNhT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 08:37:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbjARNgz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 08:36:55 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D18A313D48;
        Wed, 18 Jan 2023 05:06:44 -0800 (PST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30IAi0rW026699;
        Wed, 18 Jan 2023 13:06:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=11F5W4kgtyrTauFVB8uYzAjdtt8KXsuDnaKPia2vpWo=;
 b=KUkYvJvX2A2pgM6goO+xyYhpvQi/4jQhFk53HCLb4HwOVUtooWKsws6iay4hMHy2Zy3V
 zuqL0Oq19URHDcaPDUUhEHzpQgJcpkiSb4elUWkUv5rmyJlvFuGXbVAhQFXfEmW6Hbqc
 ng5CNe7bm9+YcWL4qZe2Bk+u6jctE2vFS9AJ48fGF73TdSiIflZ1j3HoBaP9h8jM23HX
 Ia8ZaVcs8jU0PcJqx1KVTEA/LRZMUdDKamjEuoCmu3cGOICf5M7Dl/cKLkDFv+uX/cB5
 ryq2tPH8bqkiiEVKnl+M68hpRToXcuB9bXQXUTy+vmvyeIyga8Qo2G61A6JfKYNh+5im eg== 
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3n6f91u3p1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Jan 2023 13:06:39 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30ICGGVG009728;
        Wed, 18 Jan 2023 13:06:38 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([9.208.130.100])
        by ppma01dal.us.ibm.com (PPS) with ESMTPS id 3n3m17w5yd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Jan 2023 13:06:38 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
        by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30ID6btP61145550
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Jan 2023 13:06:37 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1921758055;
        Wed, 18 Jan 2023 13:06:37 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E35785803F;
        Wed, 18 Jan 2023 13:06:35 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 18 Jan 2023 13:06:35 +0000 (GMT)
Message-ID: <3389cf1c-e0ab-0b41-f3fc-bfe8c4054510@linux.ibm.com>
Date:   Wed, 18 Jan 2023 08:06:34 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v3 22/24] powerpc/pseries: Implement secvars for dynamic
 secure boot
Content-Language: en-US
To:     Andrew Donnellan <ajd@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-integrity@vger.kernel.org
Cc:     sudhakar@linux.ibm.com, bgray@linux.ibm.com, erichte@linux.ibm.com,
        gregkh@linuxfoundation.org, nayna@linux.ibm.com,
        linux-kernel@vger.kernel.org, zohar@linux.ibm.com,
        gjoyce@linux.ibm.com, gcwilson@linux.ibm.com
References: <20230118061049.1006141-1-ajd@linux.ibm.com>
 <20230118061049.1006141-23-ajd@linux.ibm.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20230118061049.1006141-23-ajd@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 2SW6o4YXcougiWxelxHtZ_h_v2uFSdOg
X-Proofpoint-ORIG-GUID: 2SW6o4YXcougiWxelxHtZ_h_v2uFSdOg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-18_05,2023-01-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 adultscore=0 clxscore=1011 impostorscore=0 malwarescore=0 mlxlogscore=999
 bulkscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301180113
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/18/23 01:10, Andrew Donnellan wrote:

> +
> +// PLPKS dynamic secure boot doesn't give us a format string in the same way OPAL does.
> +// Instead, report the format using the SB_VERSION variable in the keystore.
> +static ssize_t plpks_secvar_format(char *buf)

Ideally there would be a size_t accompanying this buffer...

> +{
> +	struct plpks_var var = {0};
> +	ssize_t ret;
> +
> +	var.component = NULL;
> +	// Only the signed variables have null bytes in their names, this one doesn't
> +	var.name = "SB_VERSION";
> +	var.namelen = 10;
> +	var.datalen = 1;
> +	var.data = kzalloc(1, GFP_KERNEL);

NULL pointer check?

> +
> +	// Unlike the other vars, SB_VERSION is owned by firmware instead of the OS
> +	ret = plpks_read_fw_var(&var);
> +	if (ret) {
> +		if (ret == -ENOENT) {
> +			ret = snprintf(buf, SECVAR_MAX_FORMAT_LEN, "ibm,plpks-sb-unknown");
> +		} else {
> +			pr_err("Error %ld reading SB_VERSION from firmware\n", ret);
> +			ret = -EIO;
> +		}
> +		goto err;
> +	}
> +
> +	// This string is made up by us - the hypervisor doesn't provide us
> +	// with a format string in the way that OPAL firmware does. Hypervisor
> +	// defines SB_VERSION as a "1 byte unsigned integer value".
> +	ret = snprintf(buf, SECVAR_MAX_FORMAT_LEN, "ibm,plpks-sb-v%hhu", var.data[0]);
> +
> +err:
> +	kfree(var.data);
> +	return ret;
> +}
> +
