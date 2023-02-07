Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B5A768D6A8
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 13:27:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231482AbjBGM1P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 07:27:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjBGM1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 07:27:12 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BE2A40E9;
        Tue,  7 Feb 2023 04:27:11 -0800 (PST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 317CN8oo007026;
        Tue, 7 Feb 2023 12:26:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : reply-to : to : cc : date : in-reply-to : references : content-type
 : mime-version : content-transfer-encoding; s=pp1;
 bh=f6fEWe4OAE4fM+i//dFKCN7ccGyAzf3rmrGevLiN1u8=;
 b=Ij41e0KlX4WWnZ4LxmzjhP/tlvBW44t6r4KUaqTDfXNt1RRq/MWZZtEK6Iu9qWaQFhqZ
 xd50TzoLKJbtcpLfevfEGzanR6dvNhDXJSj77k4Ou7esl/rttFccWCHTnYIAyWmSkRNc
 3IFfZkDZ9/dB/6/8sE3HTliguT3aW+NXHN7vdJ46QDRimsu4NWaf1C+gY7hU+ICQrFST
 KYbnfD6+N6jGCLQynRrFipyXaO1j/Pq5z6gAPwhnBpswNQxnAUA0TevlybGM4TIcBQiY
 sMmsEwQf2XrCXnhDIM22hOQQEiU9qL+HpiXRolgtF/r8+t1/lU2FqoRG3/K7s2VO37FF Qg== 
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3nkpktg2mh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Feb 2023 12:26:55 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 317BCEAI001916;
        Tue, 7 Feb 2023 12:26:54 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([9.208.130.97])
        by ppma02dal.us.ibm.com (PPS) with ESMTPS id 3nhf07bse0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Feb 2023 12:26:54 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
        by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 317CQrm138142514
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 7 Feb 2023 12:26:53 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 60EA758058;
        Tue,  7 Feb 2023 12:26:53 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 40E1058057;
        Tue,  7 Feb 2023 12:26:51 +0000 (GMT)
Received: from [172.20.7.120] (unknown [9.211.110.248])
        by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Tue,  7 Feb 2023 12:26:50 +0000 (GMT)
Message-ID: <9a78cdd254d5d962450242d2e01c3a0f702a63a0.camel@linux.ibm.com>
Subject: Re: [PATCH] scsi: FlashPoint: Replace arithmetic addition by
 bitwise OR
From:   James Bottomley <jejb@linux.ibm.com>
Reply-To: jejb@linux.ibm.com
To:     Deepak R Varma <drv@mailo.com>,
        Khalid Aziz <khalid@gonehiking.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>
Date:   Tue, 07 Feb 2023 15:26:48 +0300
In-Reply-To: <Y+I0HXsHezZRtFOM@ubun2204.myguest.virtualbox.org>
References: <Y+I0HXsHezZRtFOM@ubun2204.myguest.virtualbox.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: IAHIiI2-jd_foMGK-OtMw21XjGlX_uEi
X-Proofpoint-GUID: IAHIiI2-jd_foMGK-OtMw21XjGlX_uEi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-07_03,2023-02-06_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=315
 priorityscore=1501 suspectscore=0 adultscore=0 spamscore=0 impostorscore=0
 mlxscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0 bulkscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302070108
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-02-07 at 16:51 +0530, Deepak R Varma wrote:
> When adding two bit-field mask values, an OR operation offers higher
> performance over an arithmetic operation. So, convert such additions
> to an OR based expressions. Issue identified using orplus.cocci
> semantic patch script.

No it doesn't, at least not for constants, which is the entirety of
this patch: the compiler can find the value at compile time, so the
whole lot becomes a load immediate of a single value.  Whether the
compiler sees OR or + is immaterial to the compile time computation. 
Perhaps Coccinelle should be fixed not to complain about this case?

James

