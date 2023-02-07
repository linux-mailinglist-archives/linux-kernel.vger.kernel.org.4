Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C054268E11C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 20:25:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbjBGTZf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 14:25:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbjBGTZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 14:25:32 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4434239295;
        Tue,  7 Feb 2023 11:25:22 -0800 (PST)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 317JGasM006605;
        Tue, 7 Feb 2023 19:25:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : reply-to : to : cc : date : in-reply-to : references : content-type
 : mime-version : content-transfer-encoding; s=pp1;
 bh=tqfqfPZ+3SXtUvlt271AVvVdM7OC1tOz3fAp9g1Zs7g=;
 b=b5SOspP7fg7gJIqGmsLh7NJ0iZ2A1STE5ZoEDrMcu1vg+LiVWHd5yd49teydoJG0meF9
 2J+hT+W0YUoE8RwMc1rrkkjsQ7HPx10ajELXwj/t1OC8HCv0eGwI0Q+a1aycpDYAhIKn
 C5XeBPIFwu6xe2mhLboQzb/25ailWHSMt3NfS/g3OFe5JW4oJfzawRYD0XEIjDr+8d3P
 w8vN6qwuv6p4XlSP5R3xEV3KzSSFAQbLxuNEc45OzukaLCRlhpwh0To+5GRyBbzp+5F3
 t1ko+KC453XSu5DAww8q7p0f4JnqSzQsd3N0oOKX7piLRsnenKFS3VPHzWdBruv8LAOQ Zg== 
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nkvnmr6p6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Feb 2023 19:25:16 +0000
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 317Ff9Qi003947;
        Tue, 7 Feb 2023 19:25:15 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([9.208.129.118])
        by ppma05wdc.us.ibm.com (PPS) with ESMTPS id 3nhf079h7r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Feb 2023 19:25:15 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
        by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 317JPE5558524064
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 7 Feb 2023 19:25:14 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1927858062;
        Tue,  7 Feb 2023 19:25:14 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 011AE58057;
        Tue,  7 Feb 2023 19:25:12 +0000 (GMT)
Received: from [172.20.7.120] (unknown [9.211.110.248])
        by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Tue,  7 Feb 2023 19:25:11 +0000 (GMT)
Message-ID: <05eed3d8321d0f355bf3dc59ffea3d6ab08135fa.camel@linux.ibm.com>
Subject: Re: [PATCH] scsi: FlashPoint: Replace arithmetic addition by
 bitwise OR
From:   James Bottomley <jejb@linux.ibm.com>
Reply-To: jejb@linux.ibm.com
To:     Deepak R Varma <drv@mailo.com>
Cc:     Khalid Aziz <khalid@gonehiking.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>
Date:   Tue, 07 Feb 2023 22:25:09 +0300
In-Reply-To: <Y+KOeP0OOiem3lR5@ubun2204.myguest.virtualbox.org>
References: <Y+I0HXsHezZRtFOM@ubun2204.myguest.virtualbox.org>
         <9a78cdd254d5d962450242d2e01c3a0f702a63a0.camel@linux.ibm.com>
         <Y+KOeP0OOiem3lR5@ubun2204.myguest.virtualbox.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Zop1i2iHus6d-QhWg2DPFN52aWKUgS1W
X-Proofpoint-ORIG-GUID: Zop1i2iHus6d-QhWg2DPFN52aWKUgS1W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-07_11,2023-02-06_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 adultscore=0 suspectscore=0 priorityscore=1501 clxscore=1015 bulkscore=0
 impostorscore=0 mlxlogscore=817 lowpriorityscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302070170
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-02-07 at 23:16 +0530, Deepak R Varma wrote:
[...]
> James, there are a few other patch submissions for the scsi subsystem
> that I submitted in last few weeks. I sent couple of reminder request
> for comments on those submission, but still waiting. Could you please
> also review those and share your feedback?

The problem is basically that they don't fix a bug or introduce an
enhancement.  Review bandwidth in SCSI is the main limiting factor for
any new patch, so we tend to concentrate on these two types.  The main
problem with code replacement patches is that they do tend to introduce
inadvertent bugs in old drivers, which is why people are afraid to
review them.  You can reduce the overhead of review by demonstrating
that the binary produced is unchanged (obviously this works for some
but not all of your patches), so a maintainer need only decide if they
like the change rather than worrying about it introducing a regression.

Regards,

James

