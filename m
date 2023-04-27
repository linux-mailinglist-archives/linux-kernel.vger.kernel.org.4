Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F282A6F0BE5
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 20:28:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244481AbjD0S23 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 14:28:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244474AbjD0S2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 14:28:24 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3564240C4;
        Thu, 27 Apr 2023 11:28:23 -0700 (PDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33RIHeNt021995;
        Thu, 27 Apr 2023 18:27:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : reply-to : to : cc : date : in-reply-to : references : content-type
 : mime-version : content-transfer-encoding; s=pp1;
 bh=H9oV7UVH6rhl2KPZ3jEazQ9sDtabu4NrupuCgtU9Zn4=;
 b=ah8nPyPQcD8F00xX8RiV6xjKsaYhPYsSJzPqbsmlD4LN/Oagy/2b76oFPREm26DkfqcJ
 Y/d79GKgBTRWy7YacY6DJovD+GSPypTr1vyX024CycjtPSXP/o9Wg40U3IZ9gIwjEp/L
 rKZJftyfQgmPtocBbRie258J7f+nHTeg8394Dgxo8UenEliPcpX/UKmo6Fv552NzP8XH
 TCOY8y2AJQ+psQ+8LjWpvpMzhix36+g3WTvNmNIYmHIAP2XT9k8ejQZC2DFPiUgVvohn
 o7QIfRY+ybe+hySIfSZY0boUSjhQF7Av3Zp+6MwHKI/mv3Wy1+0h6EA36OQ2kLzJfv4D PA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3q7uq8w34m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Apr 2023 18:27:50 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 33RIRnoG025080;
        Thu, 27 Apr 2023 18:27:49 GMT
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3q7uq8w343-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Apr 2023 18:27:49 +0000
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 33RHHmhC024941;
        Thu, 27 Apr 2023 18:27:48 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([9.208.130.102])
        by ppma05wdc.us.ibm.com (PPS) with ESMTPS id 3q4778kqkk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Apr 2023 18:27:48 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
        by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 33RIRlb012059294
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Apr 2023 18:27:47 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9D39658063;
        Thu, 27 Apr 2023 18:27:47 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D443E5805D;
        Thu, 27 Apr 2023 18:27:42 +0000 (GMT)
Received: from lingrow.int.hansenpartnership.com (unknown [9.211.118.80])
        by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 27 Apr 2023 18:27:42 +0000 (GMT)
Message-ID: <a8379b813d5c5118420c3b7a7e0de69d0166d033.camel@linux.ibm.com>
Subject: Re: [PATCH] docs: security: Confidential computing intro and threat
 model
From:   James Bottomley <jejb@linux.ibm.com>
Reply-To: jejb@linux.ibm.com
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     "Reshetova, Elena" <elena.reshetova@intel.com>,
        "Christopherson, , Sean" <seanjc@google.com>,
        Carlos Bilbao <carlos.bilbao@amd.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ardb@kernel.org" <ardb@kernel.org>,
        "kraxel@redhat.com" <kraxel@redhat.com>,
        "dovmurik@linux.ibm.com" <dovmurik@linux.ibm.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "Dhaval.Giani@amd.com" <Dhaval.Giani@amd.com>,
        "michael.day@amd.com" <michael.day@amd.com>,
        "pavankumar.paluri@amd.com" <pavankumar.paluri@amd.com>,
        "David.Kaplan@amd.com" <David.Kaplan@amd.com>,
        "Reshma.Lal@amd.com" <Reshma.Lal@amd.com>,
        "Jeremy.Powell@amd.com" <Jeremy.Powell@amd.com>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "dgilbert@redhat.com" <dgilbert@redhat.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "dinechin@redhat.com" <dinechin@redhat.com>,
        "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
        "berrange@redhat.com" <berrange@redhat.com>,
        "tytso@mit.edu" <tytso@mit.edu>,
        "jikos@kernel.org" <jikos@kernel.org>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "leon@kernel.org" <leon@kernel.org>,
        "richard.weinberger@gmail.com" <richard.weinberger@gmail.com>,
        "lukas@wunner.de" <lukas@wunner.de>,
        "cdupontd@redhat.com" <cdupontd@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "sameo@rivosinc.com" <sameo@rivosinc.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "security@kernel.org" <security@kernel.org>,
        Andrew Bresticker <abrestic@rivosinc.com>,
        Rajnesh Kanwal <rkanwal@rivosinc.com>,
        Dylan Reid <dylan@rivosinc.com>,
        Ravi Sahita <ravi@rivosinc.com>
Date:   Thu, 27 Apr 2023 14:27:41 -0400
In-Reply-To: <20230427131542-mutt-send-email-mst@kernel.org>
References: <20230327141816.2648615-1-carlos.bilbao@amd.com>
         <ZEfrjtgGgm1lpadq@google.com>
         <DM8PR11MB575046B6DAA17B41FFED8080E7659@DM8PR11MB5750.namprd11.prod.outlook.com>
         <7502e1af0615c08167076ff452fc69ebf316c730.camel@linux.ibm.com>
         <ZElOfzn37kmesy7e@google.com>
         <DM8PR11MB57509EBCB1E2146C1768A6EEE76A9@DM8PR11MB5750.namprd11.prod.outlook.com>
         <efda0be02fb0b5bf23aec11b5398d20908a821ba.camel@linux.ibm.com>
         <20230427131542-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 9XtbHcBZSboFEHBt3fm2quRRKGplcWca
X-Proofpoint-GUID: o40wtKUwYkFN8HQQX3bVLzxWbKZo63JG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-27_08,2023-04-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 adultscore=0 malwarescore=0
 impostorscore=0 mlxscore=0 spamscore=0 mlxlogscore=999 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304270158
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-04-27 at 13:19 -0400, Michael S. Tsirkin wrote:
> On Thu, Apr 27, 2023 at 09:18:08AM -0400, James Bottomley wrote:
> > I think the problem is that the tenor of the document is that the
> > CSP should be seen as the enemy of the tenant. Whereas all CSP's
> > want to be seen as the partner of the tenant (admittedly so they
> > can upsell services). In particular, even if you adopt (b) there
> > are several reasons why you'd use confidential computing:
> > 
> >    1. Protection from other tenants who break containment in the
> > cloud. These tenants could exfiltrate data from Non-CoCo VMs, but
> > likely would be detected before they had time to launch an attack
> > using vulnerabilities in the current linux device drivers.
> >    2. Legal data security.  There's a lot of value in a CSP being
> > able to make the legal statement that it does not have access to a
> > customer data because of CoCo.
> >    3. Insider threats (bribe a CSP admin employee).  This one might
> > get as far as trying to launch an attack on a CoCo VM, but having 
> > checks at the CSP to detect and defeat this would work instead of
> > every insider threat having to be defeated inside the VM.
> 
> And generally, all these are instances of adopting a zero trust
> architecture, right? Many CSPs have no need to access VM memory
> so they would rather not have the ability.

Yes, and no: Zero trust is more an architectural end point statement. 
I was aiming for minimizing trust contact points.  In the limit they're
definitely the same thing, but there's still lots of security value to
minimizing trust even before you get to zero.

James

