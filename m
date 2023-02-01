Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85C33682136
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 02:04:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbjAaBEI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 20:04:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjAaBEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 20:04:06 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F36852FCE7;
        Mon, 30 Jan 2023 17:04:03 -0800 (PST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30UNtdLr012160;
        Tue, 31 Jan 2023 01:03:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=Z/WVbO8gN4wPG1dnX9SSO/A5Ayug/qmMRUvrltJ14kI=;
 b=aW4+wnNbgFF4xvepgnWYWtHo+yCBWEcomolmCmETQjTeceUvINz7y+KvhXULPBGtWRY0
 UokC4HcGwRo1rOfdEBDrsCPYxaRvcU/uew3z/rqBZ/5wEyJChLM4v93w3xGpC3Mpwv21
 0UccGchtz5xD5EqYyvPQ0r6tnDNz6AIvbXrJlS1Y2N4xhRdGX43duZ4n+m67f63JpkSN
 NzIPX+Id4vlCkenV/sq3tHHi0RfYqfALHhPmJSLk0LpF5mfHfGxb9ErdCrrWQ4WOk+Vu
 PLIx7lnSwQWHf7hsNGzlHkd2ziRqC3OQhg218c2geH35q41recriDTaEsdNO5pruJ1J4 uw== 
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3nen9cnksq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Jan 2023 01:03:51 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30U9ZAGl031351;
        Tue, 31 Jan 2023 01:03:50 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma02fra.de.ibm.com (PPS) with ESMTPS id 3ncvv6a1tf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Jan 2023 01:03:50 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30V13lNH43516286
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Jan 2023 01:03:47 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B695D2004B;
        Tue, 31 Jan 2023 01:03:47 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3866720040;
        Tue, 31 Jan 2023 01:03:47 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 31 Jan 2023 01:03:47 +0000 (GMT)
Received: from [10.61.2.128] (haven.au.ibm.com [9.192.254.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 8AF3F60425;
        Tue, 31 Jan 2023 12:03:44 +1100 (AEDT)
Message-ID: <a2dd2067cf4eee3362a02e76ec335710e8bb04b8.camel@linux.ibm.com>
Subject: Re: [PATCH v4 24/24] integrity/powerpc: Support loading keys from
 pseries secvar
From:   Andrew Donnellan <ajd@linux.ibm.com>
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Russell Currey <ruscur@russell.cc>,
        linuxppc-dev@lists.ozlabs.org, linux-integrity@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, gcwilson@linux.ibm.com,
        linux-kernel@vger.kernel.org, nayna@linux.ibm.com,
        mpe@ellerman.id.au, gjoyce@linux.ibm.com, sudhakar@linux.ibm.com,
        bgray@linux.ibm.com, erichte@linux.ibm.com, joel@jms.id.au
Date:   Tue, 31 Jan 2023 12:03:44 +1100
In-Reply-To: <adbb8d2f438f01f32d9e09b508cde31b3efdc3a4.camel@linux.ibm.com>
References: <20230120074306.1326298-1-ajd@linux.ibm.com>
         <20230120074306.1326298-25-ajd@linux.ibm.com>
         <57dca1ea3ef66bc0935bdd1dab4536f1151f4004.camel@linux.ibm.com>
         <71b48934e26a991eaf62c9869a8dfee769e0799d.camel@russell.cc>
         <adbb8d2f438f01f32d9e09b508cde31b3efdc3a4.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: EEMhfqoPOJmHQ3bm8UrBtAwhoYFSu34E
X-Proofpoint-GUID: EEMhfqoPOJmHQ3bm8UrBtAwhoYFSu34E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-30_19,2023-01-30_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 mlxscore=0 phishscore=0 malwarescore=0 adultscore=0 clxscore=1015
 mlxlogscore=999 priorityscore=1501 spamscore=0 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301310008
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-01-24 at 21:47 -0500, Mimi Zohar wrote:
> Agreed.=C2=A0 Thank you for the explanation.=C2=A0 To simplify review, I
> suggest
> either adding this explanation in the patch description or stage the
> change by replacing the existing "ibm,edk2-compat-v1" usage first.

Will clarify in the commit message of the next revision.

--=20
Andrew Donnellan    OzLabs, ADL Canberra
ajd@linux.ibm.com   IBM Australia Limited
