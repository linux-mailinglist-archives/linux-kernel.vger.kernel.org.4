Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E904C6BAFEB
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 13:08:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231143AbjCOMIW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 08:08:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbjCOMIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 08:08:17 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73A83222C3;
        Wed, 15 Mar 2023 05:07:35 -0700 (PDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32FBSuMY029989;
        Wed, 15 Mar 2023 12:07:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : reply-to : to : cc : date : in-reply-to : references : content-type
 : mime-version : content-transfer-encoding; s=pp1;
 bh=5gFL/nxSnjkVO4MBThs2A5kD6yMxkINEPE6ry3QkYlg=;
 b=szDok60mVjzc0H5jH7aKLBf9kciQHVb4JYVU4OR8YLTUXoYQh3zb2NijRNeMAYF+Z+c6
 nv+veyUMghHcNES5d7QfFB/Hpj/wOjqKYSbJJUCtf2j/LxY4EhjSyAbBYVzs3v/B6HtL
 OrHBI1DFZjazYoXDdZOoGWY5yVJacPKZnEXV1TQkyL7BxmBorqs53iAEn3jbxSGPyLvN
 uLlyeb6ChJjJWZJ9AP+O5IZV01jj14wzc+MUD36XPwSislNPCdXHZd08swOxtiCA9fBH
 1+4oLIeoNMl29OGx04IGp96dcOUiCG1G/zLKyLTNmntnz1s01/FfKMorNopDBF+CPb2Y TA== 
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3pbbmyuby5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Mar 2023 12:07:12 +0000
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 32FAN7VQ026430;
        Wed, 15 Mar 2023 12:07:12 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([9.208.130.97])
        by ppma02wdc.us.ibm.com (PPS) with ESMTPS id 3pb29ru1w1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Mar 2023 12:07:12 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
        by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 32FC7BTe34800234
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Mar 2023 12:07:11 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B1B6358552;
        Wed, 15 Mar 2023 11:49:00 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D3D9B5854C;
        Wed, 15 Mar 2023 11:48:59 +0000 (GMT)
Received: from lingrow.int.hansenpartnership.com (unknown [9.211.76.184])
        by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 15 Mar 2023 11:48:59 +0000 (GMT)
Message-ID: <0be9002bbc7feea0bfd0dc8ad2dccc52bbf34834.camel@linux.ibm.com>
Subject: Re: [PATCH for-next] scsi: Implement host state statistics
From:   James Bottomley <jejb@linux.ibm.com>
Reply-To: jejb@linux.ibm.com
To:     Greg KH <gregkh@linuxfoundation.org>,
        "Seymour, Shane M" <shane.seymour@hpe.com>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
Date:   Wed, 15 Mar 2023 07:48:58 -0400
In-Reply-To: <ZBFnYwtr+2bfjvcY@kroah.com>
References: <DM4PR84MB1373DCD07EABD28D88129C50FDBF9@DM4PR84MB1373.NAMPRD84.PROD.OUTLOOK.COM>
         <ZBFnYwtr+2bfjvcY@kroah.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: m5IiWuspWVXFrK3jAlNjAPRD88u9mn-W
X-Proofpoint-ORIG-GUID: m5IiWuspWVXFrK3jAlNjAPRD88u9mn-W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-15_06,2023-03-15_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 spamscore=0 suspectscore=0 adultscore=0 impostorscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=895 clxscore=1011 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2302240000 definitions=main-2303150104
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-03-15 at 07:36 +0100, Greg KH wrote:
> On Wed, Mar 15, 2023 at 06:08:19AM +0000, Seymour, Shane M wrote:
> > The following patch implements host state statistics via sysfs. The
> > intent is to allow user space to see the state changes and be able
> > to report when a host changes state. The files do not separate out
> > the time spent into each state but only into three:
> 
> Why does userspace care about these things at all?

This is the most important question: Why are times spent in various
states and transition counts important?  Is this some kind of
predictive failure system, or is it simply logging? If it's logging,
wouldn't you get better information if we output state changes as they
occur then they'd appear as timestamped entries in the syslog from
which all these statistics could be deduced?

>   What tool needs them and what can userspace do with the
> information?
> > 
[...]
> > A (GPLv2) program called hostmond will be released in a few months
> > that will monitor these interfaces and report (local host only via
> > syslog(3C)) when hosts change state.
> 
> We kind of need to see this before the kernel changes can be accepted
> for obvious reasons, what is preventing that from happening now?

I don't think that's a requirement.  The whole point of sysfs is it's
user readable, so we don't need a tool to make use of its entries.  On
the other hand if this tool can help elucidate the use case for these
statistics, then publishing it now would be useful to help everyone
else understand why this is useful.

James

