Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B48B4671C22
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 13:34:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbjARMeG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 07:34:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230166AbjARMdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 07:33:13 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E0253B0C1;
        Wed, 18 Jan 2023 03:52:39 -0800 (PST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30I9Bdeq029182;
        Wed, 18 Jan 2023 11:52:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=V1F3Ue8OxZyP08vqhMsXhFETkCUMA4VX+uW8o6Oo+Os=;
 b=cy9daLjb2nMGUJLBFxouIFFC+XPx34J5wPNtjRepjMR0pj0VefM4IBrvdH4oTLBV4AUt
 7vGpvROMarNJSsnJIv0fExTZpQWVRpN465YkSF/Gzl9cKXjd5ld2asE80B0AEal22ybo
 YOXrJqwtIr0Kyw1dyg7n59eSbDz58Oo2EI20kLeTbyG2b6Af0tk7XrbXu1MPhGrjTcqQ
 ShFKlRnaURRZvGIy3FrR0eQ53LpJ7W8Uiqe5ZoYSMQdwMMYJl2xbhKTvnii2XoDOStj0
 0so6+EGC8sd2U4sZcysqiFpthH/XCVT4jVPbX9vRQF+gWKyES+EXfgZg8c/03TlZKo1C lg== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3n6dwvbkbk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Jan 2023 11:52:34 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30HMbF6d023703;
        Wed, 18 Jan 2023 11:52:31 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3n3m16n77t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Jan 2023 11:52:31 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30IBqTHT25363164
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Jan 2023 11:52:29 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3637A20040;
        Wed, 18 Jan 2023 11:52:29 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B0A232004B;
        Wed, 18 Jan 2023 11:52:28 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 18 Jan 2023 11:52:28 +0000 (GMT)
Received: from [9.43.167.221] (unknown [9.43.167.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 8502460126;
        Wed, 18 Jan 2023 22:52:20 +1100 (AEDT)
Message-ID: <d688f4d4875bc869fcff5006ace71524d130eb1c.camel@linux.ibm.com>
Subject: Re: [PATCH v3 21/24] powerpc/pseries: Pass PLPKS password on kexec
From:   Andrew Donnellan <ajd@linux.ibm.com>
To:     linuxppc-dev@lists.ozlabs.org, linux-integrity@vger.kernel.org
Cc:     sudhakar@linux.ibm.com, bgray@linux.ibm.com, erichte@linux.ibm.com,
        gregkh@linuxfoundation.org, nayna@linux.ibm.com,
        linux-kernel@vger.kernel.org, zohar@linux.ibm.com,
        gjoyce@linux.ibm.com, gcwilson@linux.ibm.com
Date:   Wed, 18 Jan 2023 22:52:17 +1100
In-Reply-To: <20230118061049.1006141-22-ajd@linux.ibm.com>
References: <20230118061049.1006141-1-ajd@linux.ibm.com>
         <20230118061049.1006141-22-ajd@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Fh2ArycF94ERuDFsP2VmPJ4NKnKjXtdn
X-Proofpoint-GUID: Fh2ArycF94ERuDFsP2VmPJ4NKnKjXtdn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-18_05,2023-01-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 spamscore=0 impostorscore=0 bulkscore=0 phishscore=0
 mlxlogscore=690 adultscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301180096
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIzLTAxLTE4IGF0IDE3OjEwICsxMTAwLCBBbmRyZXcgRG9ubmVsbGFuIHdyb3Rl
Ogo+IAo+IMKgc3RydWN0IHVtZW1faW5mbyB7Cj4gwqDCoMKgwqDCoMKgwqDCoHU2NCAqYnVmO8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoC8qIGRhdGEgYnVmZmVyIGZvciB1c2FibGUtbWVt
b3J5Cj4gcHJvcGVydHkgKi8KPiBAQCAtMTE1NSw3ICsxMTU2LDcgQEAgaW50IHNldHVwX25ld19m
ZHRfcHBjNjQoY29uc3Qgc3RydWN0IGtpbWFnZQo+ICppbWFnZSwgdm9pZCAqZmR0LAo+IMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHVuc2lnbmVkIGxvbmcg
aW5pdHJkX2xlbiwgY29uc3QgY2hhcgo+ICpjbWRsaW5lKQo+IMKgewo+IMKgwqDCoMKgwqDCoMKg
wqBzdHJ1Y3QgY3Jhc2hfbWVtICp1bWVtID0gTlVMTCwgKnJtZW0gPSBOVUxMOwo+IC3CoMKgwqDC
oMKgwqDCoGludCBpLCBucl9yYW5nZXMsIHJldDsKPiArwqDCoMKgwqDCoMKgwqBpbnQgaSwgbnJf
cmFuZ2VzLCByZXQsIGNob3Nlbl9ub2RlOwoKcmlwLCB3ZSBicm9rZSB0aGUgYnVpbGQgd2hlbiBD
T05GSUdfUFNFUklFU19QTFBLUz1uLgoKdjQgaW5jb21pbmcgc2hvcnRseSwgYWZ0ZXIgd2Ugd2Fp
dCBhIGxpdHRsZSB3aGlsZSBsb25nZXIgZm9yIGNvbW1lbnRzLgoKLS0gCkFuZHJldyBEb25uZWxs
YW4gICAgT3pMYWJzLCBBREwgQ2FuYmVycmEKYWpkQGxpbnV4LmlibS5jb20gICBJQk0gQXVzdHJh
bGlhIExpbWl0ZWQK

