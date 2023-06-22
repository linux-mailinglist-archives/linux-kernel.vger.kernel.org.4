Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4C3F73A826
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 20:23:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbjFVSXM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 14:23:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbjFVSXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 14:23:11 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AF94C3;
        Thu, 22 Jun 2023 11:23:10 -0700 (PDT)
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35MHmocq015331;
        Thu, 22 Jun 2023 18:23:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=PFus1/D7nFqd7teR8ydCS2/lV/ZUdlOo4df9sJQYlXk=;
 b=buZWV+BV5f6p/LgEacpYKmV9x4JuuCkn8P5muOqSnYG6EU1+wYOt4PCsY3CrJS7efCks
 o79+D6BLXwoFPZBWWpWwdUi6mh552bZKsBTBOSz42H0Gmlgd251tD19LV249MwvLHcKU
 qSNYqbRixKBpMoloemZgv0yoG+/x5rMYA6dhun3PcWKqLMpxOZVEUYdKuM/uQQoaFTE3
 kCNviGcA+vlaY1EisYdLbA+MSqhdJ/wDcjLpYosqNXnzpaSOFSvLNlYWcDdO+McL/e4I
 7tSY3Bsn5AX693u0cCHD2hk9Od+RD7c9mNBcQBzv7W9sW/gYmZRNJWNBdlebtKWA3QyN Xg== 
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rcsu5ap14-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Jun 2023 18:23:03 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35MFn1C3032552;
        Thu, 22 Jun 2023 18:23:02 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma06fra.de.ibm.com (PPS) with ESMTPS id 3r943e2t2w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Jun 2023 18:23:01 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 35MIMwjO27263552
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Jun 2023 18:22:58 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6ADCB20043;
        Thu, 22 Jun 2023 18:22:58 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AB81C20040;
        Thu, 22 Jun 2023 18:22:57 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.171.59.34])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Thu, 22 Jun 2023 18:22:57 +0000 (GMT)
Date:   Thu, 22 Jun 2023 20:22:55 +0200
From:   Alexander Gordeev <agordeev@linux.ibm.com>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/79] s390: switch to new ctime accessors
Message-ID: <ZJSRf9FnEFc+dPO6@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
References: <20230621144507.55591-1-jlayton@kernel.org>
 <20230621144735.55953-1-jlayton@kernel.org>
 <20230621144735.55953-2-jlayton@kernel.org>
 <ZJSGVjryWEjbeW1U@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
 <468a895b93b83ed6369ea95519f832998a89d76f.camel@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <468a895b93b83ed6369ea95519f832998a89d76f.camel@kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: x6OV24konuBPCH-MQgSaVifwYtI2h7wt
X-Proofpoint-ORIG-GUID: x6OV24konuBPCH-MQgSaVifwYtI2h7wt
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-22_13,2023-06-22_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 mlxscore=0 lowpriorityscore=0 mlxlogscore=570 malwarescore=0
 priorityscore=1501 spamscore=0 adultscore=0 bulkscore=0 impostorscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306220154
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 22, 2023 at 01:51:33PM -0400, Jeff Layton wrote:
> On Thu, 2023-06-22 at 19:35 +0200, Alexander Gordeev wrote:
> > On Wed, Jun 21, 2023 at 10:45:16AM -0400, Jeff Layton wrote:
> > 
> > Hi Jeff,
> > > In later patches, we're going to change how the ctime.tv_nsec field is
> > > utilized. Switch to using accessor functions instead of raw accesses of
> > > inode->i_ctime.
> > > 
> > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > ---
> > >  arch/s390/hypfs/inode.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/arch/s390/hypfs/inode.c b/arch/s390/hypfs/inode.c
> > > index ee919bfc8186..30fa336ec63e 100644
> > > --- a/arch/s390/hypfs/inode.c
> > > +++ b/arch/s390/hypfs/inode.c
> > > @@ -53,7 +53,7 @@ static void hypfs_update_update(struct super_block *sb)
> > >  	struct inode *inode = d_inode(sb_info->update_file);
> > >  
> > >  	sb_info->last_update = ktime_get_seconds();
> > > -	inode->i_atime = inode->i_mtime = inode->i_ctime = current_time(inode);
> > > +	inode->i_atime = inode->i_mtime = inode_ctime_set_current(inode);
> > >  }
> > >  
> > >  /* directory tree removal functions */
> > > @@ -101,7 +101,7 @@ static struct inode *hypfs_make_inode(struct super_block *sb, umode_t mode)
> > >  		ret->i_mode = mode;
> > >  		ret->i_uid = hypfs_info->uid;
> > >  		ret->i_gid = hypfs_info->gid;
> > > -		ret->i_atime = ret->i_mtime = ret->i_ctime = current_time(ret);
> > > +		ret->i_atime = ret->i_mtime = inode_ctime_set_current(ret);
> > >  		if (S_ISDIR(mode))
> > >  			set_nlink(ret, 2);
> > >  	}
> > 
> > I guess, inode_set_ctime() called from inode_ctime_set_current()
> > updates i_ctime and is part of some other series?
> > 
> 
> No, that gets added in patch #1 of this series.
> 
> You should have gotten cc'ed on that one, though the postings to vger
> mailing lists of patches 1, 2, and 79 bounced because the mail header
> length on those was >8k.

I actually received #1, if we're talking about this one:
https://lore.kernel.org/all/20230621144507.55591-2-jlayton@kernel.org/

I see inode_set_ctime() gets called, but nowere defined.

> Jeff Layton <jlayton@kernel.org>
