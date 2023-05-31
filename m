Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DE7B718565
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 16:57:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233058AbjEaO5a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 10:57:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232329AbjEaO52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 10:57:28 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12C0E11D;
        Wed, 31 May 2023 07:57:25 -0700 (PDT)
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34VEg85R030847;
        Wed, 31 May 2023 14:56:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : reply-to : to : cc : date : in-reply-to : references : content-type
 : mime-version : content-transfer-encoding; s=pp1;
 bh=OBYjAsiQnYeqsncNk244KPMIAGvoR7IKEXAV3+x3XmY=;
 b=VK4s0Z0LU5Q0JFwRrBWPdUE/BmlwNhytMGNfJyO7BjpGyJ+zdvyQjfXKbUn1TOITDfTH
 bjNTrNWoxSidiPbdO/teq2cNU8Qk8ADaDKTbai7AV+z8XLe/ZBQCM2YaVUPalIxEKYvW
 xOLFBvHQ/FpgspQC+jXzaZp2WG2C08Po4Ld0Bfbm/SFrKCJs4Odtzu2yJplCzqTC/D+W
 2vy4jvGbtp385jyzAUmTgfgKkS43xFfBmJ0WhbA49qvViVzepsFheod9YgMRB9pkdiD7
 Lns0jelZ7KLOh7kDWOmoKufI5P/48rcUaYjESkzGqoGzOQzaQPtY0cm5qiav0r/ljDRH lA== 
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qx87s0fnv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 31 May 2023 14:56:56 +0000
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 34VBZs0T008110;
        Wed, 31 May 2023 14:56:54 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([9.208.129.117])
        by ppma02wdc.us.ibm.com (PPS) with ESMTPS id 3qu9g8c5pf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 31 May 2023 14:56:54 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
        by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 34VEureu4784708
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 May 2023 14:56:53 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7584A58057;
        Wed, 31 May 2023 14:56:52 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7298558059;
        Wed, 31 May 2023 14:56:51 +0000 (GMT)
Received: from lingrow.int.hansenpartnership.com (unknown [9.61.55.64])
        by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 31 May 2023 14:56:51 +0000 (GMT)
Message-ID: <25ef15e7601e1b4510cbbd40c6d1ab7c64213863.camel@linux.ibm.com>
Subject: Re: [PATCH][next] scsi: lpfc: Avoid -Wstringop-overflow warning
From:   James Bottomley <jejb@linux.ibm.com>
Reply-To: jejb@linux.ibm.com
To:     Kees Cook <keescook@chromium.org>
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        James Smart <james.smart@broadcom.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Date:   Wed, 31 May 2023 10:56:50 -0400
In-Reply-To: <202305301529.1EEA11B@keescook>
References: <ZHZq7AV9Q2WG1xRB@work>
         <fe0739cbe279cf9db2ebff1146e7ae540cc1ad6c.camel@linux.ibm.com>
         <202305301529.1EEA11B@keescook>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: WBQatvEGQiKAHXw7oHidJWHURI-cBAD_
X-Proofpoint-GUID: WBQatvEGQiKAHXw7oHidJWHURI-cBAD_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-31_08,2023-05-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 bulkscore=0 lowpriorityscore=0 clxscore=1011 priorityscore=1501
 suspectscore=0 spamscore=0 impostorscore=0 mlxlogscore=999 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305310124
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-05-30 at 15:44 -0700, Kees Cook wrote:
> On Tue, May 30, 2023 at 05:36:06PM -0400, James Bottomley wrote:
> > On Tue, 2023-05-30 at 15:30 -0600, Gustavo A. R. Silva wrote:
> > > Avoid confusing the compiler about possible negative sizes.
> > > Use size_t instead of int for variables size and copied.
> > > 
> > > Address the following warning found with GCC-13:
> > > In function ‘lpfc_debugfs_ras_log_data’,
> > >     inlined from ‘lpfc_debugfs_ras_log_open’ at
> > > drivers/scsi/lpfc/lpfc_debugfs.c:2271:15:
> > > drivers/scsi/lpfc/lpfc_debugfs.c:2210:25: warning: ‘memcpy’
> > > specified
> > > bound between 18446744071562067968 and 18446744073709551615
> > > exceeds
> > > maximum object size 9223372036854775807 [-Wstringop-overflow=]
> > >  2210 |                         memcpy(buffer + copied, dmabuf-
> > > >virt,
> > >       |                        
> > > ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > >  2211 |                                size - copied - 1);
> > >       |                                ~~~~~~~~~~~~~~~~~~
> > > 
> > 
> > This looks like a compiler bug to me and your workaround would have
> > us using unsigned types everywhere for sizes, which seems wrong. 
> > There are calls which return size or error for which we have
> > ssize_t and that type has to be usable in things like memcpy, so
> > the compiler must be fixed or the warning disabled.
> 
> The compiler is (correctly) noticing that the calculation involving
> "size" (from which "copied" is set) could go negative.

It can?  But if it can, then changing size and copied to unsigned
doesn't fix it, does it?

> The "unsigned types everywhere" is a slippery slope argument that
> doesn't apply: this is fixing a specific case of a helper taking a
> size that is never expected to go negative in multiple places
> (open-coded multiplication, vmalloc, lpfc_debugfs_ras_log_data, etc).
> It should be bounds checked at the least...

So your claim is the compiler only gets it wrong in this one case and
if we just change this one case it will never get it wrong again?  I
think I prefer the idea that there's a problem in the bounds checking
code which should be susceptible to fixing if we file a compiler bug
(either it should get it right or ignore the case if it can't decide).

> struct lpfc_hba {
>         ...
>         uint32_t cfg_ras_fwlog_buffsize;
>         ...
> };
> 
> lpfc_debugfs_ras_log_open():
>         ...
>         struct lpfc_hba *phba = inode->i_private;
>         int size;
>         ...
>         size = LPFC_RAS_MIN_BUFF_POST_SIZE * phba-
> >cfg_ras_fwlog_buffsize;
>         debug->buffer = vmalloc(size);
>         ...
>         debug->len = lpfc_debugfs_ras_log_data(phba, debug->buffer,
> size);
>         ...
> 
> lpfc_debugfs_ras_log_data():
>         ...
>                 if ((copied + LPFC_RAS_MAX_ENTRY_SIZE) >= (size - 1))
> {
>                         memcpy(buffer + copied, dmabuf->virt,
>                                size - copied - 1);
> 
> Honestly, the "if" above is the weirdest part, and perhaps that
> should
> just be adjusted instead:
> 
>         if (size <= LPFC_RAS_MAX_ENTRY_SIZE)
>                 return -ENOMEM;
>         ...
>                 if (size - copied <= LPFC_RAS_MAX_ENTRY_SIZE) {
>                         memcpy(..., size - copied - 1);
>                         copied += size - copied - 1;
>                         break;
>                 }
>                 ...
>         }
>         return copied;

No one said you couldn't improve the code.  It was claiming a fix by
changing a signed variable to unsigned that got my attention because
it's a classic indicator of compiler problems.  I didn't say anything
about all the strlcpy replacements where the source is guaranteed to be
zero terminated so the problem alluded to in the changelog doesn't
exist.  But since it all becomes about the inefficiency of the ignored
strlen it did strike me that the most common pattern in sysfs code is
strlcpy followed by strim or strstrip, which could be done slightly
more efficiently as a single operation, if someone wanted actually to
improve our sysfs use cases ...

James


