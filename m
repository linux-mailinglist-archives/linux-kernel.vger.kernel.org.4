Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FC2667B47E
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 15:31:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235086AbjAYObu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 09:31:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjAYObs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 09:31:48 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E9B7C14C
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 06:31:48 -0800 (PST)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30PE0Z7S022044;
        Wed, 25 Jan 2023 14:31:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : reply-to : to : cc : date : in-reply-to : references : content-type
 : content-transfer-encoding : mime-version; s=pp1;
 bh=iBRpH/NB+SrErDq4uzMmJyketcpurnh2O3gDv+jUTEE=;
 b=k+rnC2kcf+hlqRe7sqHo79ll++DTH7Oj/Z8EHFU1vrPpWPA7yJfddZ9ERcgKV/C5ZZir
 t4SJoeHFkRqMNX8ON/tX4RRlD5ZUkh3XfmtgbWE+PAjXYaSzpLQMbK+P+btGNmiJI4j5
 KWYA8LG8orsdzCAIeNbLlK01Udwo/dzCQP6tac7U+DBOcBJORMNgNkzTeVUFPx8j2tK4
 eF3EkZh3BkESP3tDaIEvHFaFrNDdD12+L8U+EUFywToupE9J0+P22hkRXooMVUIK3f5o
 FjMWOb5q+NoFi1+iwU82J89MhTITBK0h6yA83B2hGN2dXMJrr2pQfngz9nUtC9vosLN9 6A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3naad41f8a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Jan 2023 14:31:15 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30PEKLuF023201;
        Wed, 25 Jan 2023 14:31:14 GMT
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3naad41f6q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Jan 2023 14:31:14 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30PEJ1i7026121;
        Wed, 25 Jan 2023 14:31:12 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([9.208.129.119])
        by ppma02dal.us.ibm.com (PPS) with ESMTPS id 3n87p7pafa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Jan 2023 14:31:12 +0000
Received: from b03ledav001.gho.boulder.ibm.com ([9.17.130.232])
        by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30PEVAAu21365436
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Jan 2023 14:31:11 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CC1A36E052;
        Wed, 25 Jan 2023 14:33:07 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 37BE76E04E;
        Wed, 25 Jan 2023 14:33:04 +0000 (GMT)
Received: from [IPv6:2601:5c4:4302:c21::a774] (unknown [9.163.35.100])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed, 25 Jan 2023 14:33:03 +0000 (GMT)
Message-ID: <aa1ac4230dc8827a2f6bccceca8fd46a540c3f35.camel@linux.ibm.com>
Subject: Re: Linux guest kernel threat model for Confidential Computing
From:   James Bottomley <jejb@linux.ibm.com>
Reply-To: jejb@linux.ibm.com
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc:     "Reshetova, Elena" <elena.reshetova@intel.com>,
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
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Wed, 25 Jan 2023 09:30:34 -0500
In-Reply-To: <Y9E7PNmSTP5w2zuw@kroah.com>
References: <DM8PR11MB57505481B2FE79C3D56C9201E7CE9@DM8PR11MB5750.namprd11.prod.outlook.com>
         <Y9EkCvAfNXnJ+ATo@kroah.com> <Y9Ex3ZUIFxwOBg1n@work-vm>
         <Y9E7PNmSTP5w2zuw@kroah.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: XwJUWRmVqhqsUZ6Vq5VTDexpq9VfMdYM
X-Proofpoint-GUID: NNaN89_Oz-mLlo5-gl6DtODm4eJpQi3O
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-25_08,2023-01-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 priorityscore=1501 malwarescore=0 clxscore=1011 mlxscore=0
 bulkscore=0 adultscore=0 phishscore=0 mlxlogscore=999 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301250129
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-01-25 at 15:22 +0100, Greg Kroah-Hartman wrote:
> On Wed, Jan 25, 2023 at 01:42:53PM +0000, Dr. David Alan Gilbert
> wrote:
> > * Greg Kroah-Hartman (gregkh@linuxfoundation.org) wrote:
> > > On Wed, Jan 25, 2023 at 12:28:13PM +0000, Reshetova, Elena wrote:
> > > > Hi Greg, 
> > > > 
> > > > You mentioned couple of times (last time in this recent thread:
> > > > https://lore.kernel.org/all/Y80WtujnO7kfduAZ@kroah.com/) that
> > > > we ought to start
> > > > discussing the updated threat model for kernel, so this email
> > > > is a start in this direction. 
> > > 
> > > Any specific reason you didn't cc: the linux-hardening mailing
> > > list? This seems to be in their area as well, right?
> > > 
> > > > As we have shared before in various lkml threads/conference
> > > > presentations ([1], [2], [3] and many others), for the
> > > > Confidential Computing guest kernel, we have a change in the
> > > > threat model where guest kernel doesn’t anymore trust the
> > > > hypervisor. 
> > > 
> > > That is, frankly, a very funny threat model.  How realistic is it
> > > really given all of the other ways that a hypervisor can mess
> > > with a guest?
> > 
> > It's what a lot of people would like; in the early attempts it was
> > easy to defeat, but in TDX and SEV-SNP the hypervisor has a lot
> > less that it can mess with - remember that not just the memory is
> > encrypted, so is the register state, and the guest gets to see
> > changes to mapping and a lot of control over interrupt injection
> > etc.
> 
> And due to the fact that SEV and TDX really do not work, how is
> anyone expecting any of this to work?  As one heckler on IRC recently
> put it, if you squint hard enough, you can kind of ignore the real-
> world issues here, so perhaps this should all be called "squint-
> puting" in order to feel like you have a "confidential" system?  :)

There's a difference between no trust, which requires defeating all
attacks as they occur and limited trust, which merely means you want to
detect an attack from the limited trust entity to show that trust was
violated.  Trying to achieve the former with CC is a good academic
exercise, but not required for the technology to be useful.  Most cloud
providers are working towards the latter ... we know there are holes,
but as long as the guest can always detect interference they can be
confident in their trust in the CSP not to attack them via various
hypervisor mechanisms.

James

