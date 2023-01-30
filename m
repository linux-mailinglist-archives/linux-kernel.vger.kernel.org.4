Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F57D680DF3
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 13:42:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235451AbjA3MmV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 07:42:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230291AbjA3MmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 07:42:18 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD5D45B97
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 04:42:17 -0800 (PST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30UC9b6d016462;
        Mon, 30 Jan 2023 12:41:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : reply-to : to : cc : date : in-reply-to : references : content-type
 : content-transfer-encoding : mime-version; s=pp1;
 bh=SmLzzuerEoq5t9Gzjsx9QeubJiRT4pgArGq5OrlmHf0=;
 b=DHN6SLq/v1laThhBazkHeqiPESPsxOUzaWU1bQuWApwnIHNzb8aj0M+COFKeuaxj+2Th
 Bk0hV1IsbSJmLZi+PG9W3YVo0vTLg+v1HcYMTOSS9/P4CAay1NGUXNvyMrni9X0LxVWT
 4sM4hUTv+WMUzitTrRjBi+6eHCHagh4ln/gOvLjdXOLNG2cd/mJ+tGMzJWDthmGs83Ez
 9NS/OshMfRKwSVOfohm53gfD2kimNYGuQlMcyot/dZK2GhYScFFlfMesW66Mwnnw0dP4
 7NJonTPMHu5SC/xGBFB201GfQ25tYEusR7MMmHFSgnDbZoCGhfdf2X0jf3Av9dOXIap/ iA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nebxeu3es-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Jan 2023 12:41:26 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30UCAHxE021192;
        Mon, 30 Jan 2023 12:41:26 GMT
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nebxeu3ea-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Jan 2023 12:41:25 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30UBnhSr025436;
        Mon, 30 Jan 2023 12:41:24 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([9.208.130.102])
        by ppma03dal.us.ibm.com (PPS) with ESMTPS id 3ncvtrdb8b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Jan 2023 12:41:24 +0000
Received: from b03ledav001.gho.boulder.ibm.com ([9.17.130.232])
        by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30UCfNhq8258214
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Jan 2023 12:41:23 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 673BB6E050;
        Mon, 30 Jan 2023 12:43:28 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7F6F66E04E;
        Mon, 30 Jan 2023 12:43:24 +0000 (GMT)
Received: from lingrow.int.hansenpartnership.com (unknown [9.211.110.248])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon, 30 Jan 2023 12:43:24 +0000 (GMT)
Message-ID: <220b0be95a8c733f0a6eeddc08e37977ee21d518.camel@linux.ibm.com>
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
Date:   Mon, 30 Jan 2023 07:40:47 -0500
In-Reply-To: <DM8PR11MB5750F939C0B70939AD3CBC37E7D39@DM8PR11MB5750.namprd11.prod.outlook.com>
References: <DM8PR11MB57505481B2FE79C3D56C9201E7CE9@DM8PR11MB5750.namprd11.prod.outlook.com>
         <Y9EkCvAfNXnJ+ATo@kroah.com>
         <DM8PR11MB5750FA4849C3224F597C101AE7CE9@DM8PR11MB5750.namprd11.prod.outlook.com>
         <Y9Jh2x9XJE1KEUg6@unreal>
         <DM8PR11MB5750414F6638169C7097E365E7CF9@DM8PR11MB5750.namprd11.prod.outlook.com>
         <Y9JyW5bUqV7gWmU8@unreal>
         <DM8PR11MB57507D9C941D77E148EE9E87E7CF9@DM8PR11MB5750.namprd11.prod.outlook.com>
         <702f22df28e628d41babcf670c909f1fa1bb3c0c.camel@linux.ibm.com>
         <DM8PR11MB5750F939C0B70939AD3CBC37E7D39@DM8PR11MB5750.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: TrOy0LamtMjgCzcx9x7_zhBWtk8LM61g
X-Proofpoint-ORIG-GUID: IWo7cP949gYF6c-daYAgZ_ZxUF3I4s-s
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-30_10,2023-01-30_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 phishscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 spamscore=0 impostorscore=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301300121
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-01-30 at 07:42 +0000, Reshetova, Elena wrote:
[...]
> > The big threat from most devices (including the thunderbolt
> > classes) is that they can DMA all over memory.  However, this isn't
> > really a threat in CC (well until PCI becomes able to do encrypted
> > DMA) because the device has specific unencrypted buffers set aside
> > for the expected DMA. If it writes outside that CC integrity will
> > detect it and if it reads outside that it gets unintelligible
> > ciphertext.  So we're left with the device trying to trick secrets
> > out of us by returning unexpected data.
> 
> Yes, by supplying the input that hasn’t been expected. This is
> exactly the case we were trying to fix here for example:
> https://lore.kernel.org/all/20230119170633.40944-2-alexander.shishkin@linux.intel.com/
> I do agree that this case is less severe when others where memory
> corruption/buffer overrun can happen, like here:
> https://lore.kernel.org/all/20230119135721.83345-6-alexander.shishkin@linux.intel.com/
> But we are trying to fix all issues we see now (prioritizing the
> second ones though). 

I don't see how MSI table sizing is a bug in the category we've
defined.  The very text of the changelog says "resulting in a kernel
page fault in pci_write_msg_msix()."  which is a crash, which I thought
we were agreeing was out of scope for CC attacks?

> > 
> > If I set this as the problem, verifying device correct operation is
> > a possible solution (albeit hugely expensive) but there are likely
> > many other cheaper ways to defeat or detect a device trying to
> > trick us into revealing something.
> 
> What do you have in mind here for the actual devices we need to
> enable for CC cases?

Well, the most dangerous devices seem to be the virtio set a CC system
will rely on to boot up.  After that, there are other ways (like SPDM)
to verify a real PCI device is on the other end of the transaction.

> We have been using here a combination of extensive fuzzing and static
> code analysis.

by fuzzing, I assume you mean fuzzing from the PCI configuration space?
Firstly I'm not so sure how useful a tool fuzzing is if we take Oopses
off the table because fuzzing primarily triggers those so its hard to
see what else it could detect given the signal will be smothered by
oopses and secondly I think the PCI interface is likely the wrong place
to begin and you should probably begin on the virtio bus and the
hypervisor generated configuration space.

James

