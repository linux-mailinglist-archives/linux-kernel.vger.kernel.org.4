Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A53867EE21
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 20:26:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234241AbjA0T03 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 14:26:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231274AbjA0T00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 14:26:26 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17E157E6E9
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 11:26:25 -0800 (PST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30RIQbev032099;
        Fri, 27 Jan 2023 19:25:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : reply-to : to : cc : date : in-reply-to : references : content-type
 : content-transfer-encoding : mime-version; s=pp1;
 bh=ToKcaXCGHVtx/OUYQA1NFnUlgdSr2VZlO3XcPE9guYE=;
 b=kX22gYODagjRJSs9N7MCO9mQRlzRUEPEYIkWZYSgicuqPorcHV+7Eyg+YW2LfiKr4OwI
 pcak1j+0vLhvgDyebqDoWTC5+cs+NugDYldlhvN3Y2dYW00mMCwO5p1SwNGibvd6iS3I
 K8lmSFqEfJseIoLiPnLg8JaCZQr3UBtQqq0Wnaovbv7j/yEpvwvDFLR8vVDcgJtZdyzT
 ocxz+l8TP5RTMt6ek+fA2Zc4dl9o5Udi9cDN4OsIiAJWPycEPyV3II/u0H9BpiJOVrJN
 QYoj6uO7pgVwEkWpFTOKRDpY606MoOECXb3SnV5IHNsVbc4uxdMqGRHYz+ZxaGV6jz99 LQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3nckw6h99v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Jan 2023 19:25:34 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30RISwHi010820;
        Fri, 27 Jan 2023 19:25:33 GMT
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3nckw6h99k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Jan 2023 19:25:33 +0000
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30RHRLtI012695;
        Fri, 27 Jan 2023 19:25:32 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([9.208.129.119])
        by ppma02wdc.us.ibm.com (PPS) with ESMTPS id 3n87p8402u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Jan 2023 19:25:32 +0000
Received: from b03ledav001.gho.boulder.ibm.com ([9.17.130.232])
        by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30RJPUlR38273624
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Jan 2023 19:25:31 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8EE416E050;
        Fri, 27 Jan 2023 19:27:31 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A16DC6E04E;
        Fri, 27 Jan 2023 19:27:27 +0000 (GMT)
Received: from lingrow.int.hansenpartnership.com (unknown [9.163.35.100])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri, 27 Jan 2023 19:27:27 +0000 (GMT)
Message-ID: <702f22df28e628d41babcf670c909f1fa1bb3c0c.camel@linux.ibm.com>
Subject: Re: Linux guest kernel threat model for Confidential Computing
From:   James Bottomley <jejb@linux.ibm.com>
Reply-To: jejb@linux.ibm.com
To:     "Reshetova, Elena" <elena.reshetova@intel.com>,
        Leon Romanovsky <leon@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Shishkin, Alexander" <alexander.shishkin@intel.com>,
        "Shutemov, Kirill" <kirill.shutemov@intel.com>,
        "Kuppuswamy, Sathyanarayanan" <sathyanarayanan.kuppuswamy@intel.com>,
        "Kleen, Andi" <andi.kleen@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Wunner, Lukas" <lukas.wunner@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "Poimboe, Josh" <jpoimboe@redhat.com>,
        "aarcange@redhat.com" <aarcange@redhat.com>,
        Cfir Cohen <cfir@google.com>, Marc Orr <marcorr@google.com>,
        "jbachmann@google.com" <jbachmann@google.com>,
        "pgonda@google.com" <pgonda@google.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        James Morris <jmorris@namei.org>,
        Michael Kelley <mikelley@microsoft.com>,
        "Lange, Jon" <jlange@microsoft.com>,
        "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>
Date:   Fri, 27 Jan 2023 14:24:55 -0500
In-Reply-To: <DM8PR11MB57507D9C941D77E148EE9E87E7CF9@DM8PR11MB5750.namprd11.prod.outlook.com>
References: <DM8PR11MB57505481B2FE79C3D56C9201E7CE9@DM8PR11MB5750.namprd11.prod.outlook.com>
         <Y9EkCvAfNXnJ+ATo@kroah.com>
         <DM8PR11MB5750FA4849C3224F597C101AE7CE9@DM8PR11MB5750.namprd11.prod.outlook.com>
         <Y9Jh2x9XJE1KEUg6@unreal>
         <DM8PR11MB5750414F6638169C7097E365E7CF9@DM8PR11MB5750.namprd11.prod.outlook.com>
         <Y9JyW5bUqV7gWmU8@unreal>
         <DM8PR11MB57507D9C941D77E148EE9E87E7CF9@DM8PR11MB5750.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: kBLf3s8wiJECaATpwbnqac63pWuxSv8m
X-Proofpoint-ORIG-GUID: c_7tvaSFCnlC7B6dmBcHilT0GExG_s8M
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-27_12,2023-01-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 lowpriorityscore=0 spamscore=0 malwarescore=0 mlxlogscore=999
 clxscore=1011 mlxscore=0 impostorscore=0 adultscore=0 priorityscore=1501
 bulkscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301270176
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-01-26 at 13:28 +0000, Reshetova, Elena wrote:
> > On Thu, Jan 26, 2023 at 11:29:20AM +0000, Reshetova, Elena wrote:
> > > > On Wed, Jan 25, 2023 at 03:29:07PM +0000, Reshetova, Elena
> > > > wrote:
> > > > > Replying only to the not-so-far addressed points.
> > > > > 
> > > > > > On Wed, Jan 25, 2023 at 12:28:13PM +0000, Reshetova, Elena
> > > > > > wrote:
> > > > > > > Hi Greg,
> > > > 
> > > > <...>
> > > > 
> > > > > > > 3) All the tools are open-source and everyone can start
> > > > > > > using them right away even without any special HW (readme
> > > > > > > has description of what is needed).
> > > > > > > Tools and documentation is here:
> > > > > > > https://github.com/intel/ccc-linux-guest-hardening
> > > > > > 
> > > > > > Again, as our documentation states, when you submit patches
> > > > > > based on these tools, you HAVE TO document that.  Otherwise
> > > > > > we think you all are crazy and will get your patches
> > > > > > rejected.  You all know this, why ignore it?
> > > > > 
> > > > > Sorry, I didn’t know that for every bug that is found in
> > > > > linux kernel when we are submitting a fix that we have to
> > > > > list the way how it has been found. We will fix this in the
> > > > > future submissions, but some bugs we have are found by
> > > > > plain code audit, so 'human' is the tool. 
> > > > My problem with that statement is that by applying different
> > > > threat model you "invent" bugs which didn't exist in a first
> > > > place.
> > > > 
> > > > For example, in this [1] latest submission, authors labeled
> > > > correct behaviour as "bug".
> > > > 
> > > > [1] https://lore.kernel.org/all/20230119170633.40944-1-
> > > > alexander.shishkin@linux.intel.com/
> > > 
> > > Hm.. Does everyone think that when kernel dies with unhandled
> > > page fault (such as in that case) or detection of a KASAN out of
> > > bounds violation (as it is in some other cases we already have
> > > fixes or investigating) it represents a correct behavior even if
> > > you expect that all your pci HW devices are trusted?
> > 
> > This is exactly what I said. You presented me the cases which exist
> > in your invented world. Mentioned unhandled page fault doesn't
> > exist in real world. If PCI device doesn't work, it needs to be
> > replaced/blocked and not left to be operable and accessible from
> > the kernel/user.
> 
> Can we really assure correct operation of *all* pci devices out
> there? How would such an audit be performed given a huge set of them
> available? Isnt it better instead to make a small fix in the kernel
> behavior that would guard us from such potentially not correctly
> operating devices? 

I think this is really the wrong question from the confidential
computing (CC) point of view.  The question shouldn't be about assuring
that the PCI device is operating completely correctly all the time (for
some value of correct).  It's if it were programmed to be malicious
what could it do to us?  If we take all DoS and Crash outcomes off the
table (annoying but harmless if they don't reveal the confidential
contents), we're left with it trying to extract secrets from the
confidential environment.

The big threat from most devices (including the thunderbolt classes) is
that they can DMA all over memory.  However, this isn't really a threat
in CC (well until PCI becomes able to do encrypted DMA) because the
device has specific unencrypted buffers set aside for the expected DMA.
If it writes outside that CC integrity will detect it and if it reads
outside that it gets unintelligible ciphertext.  So we're left with the
device trying to trick secrets out of us by returning unexpected data.

If I set this as the problem, verifying device correct operation is a
possible solution (albeit hugely expensive), but there are likely many
other cheaper ways to defeat or detect a device trying to trick us into
revealing something.

James

