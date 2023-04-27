Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D660C6F09AD
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 18:17:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243206AbjD0QRq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 12:17:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243188AbjD0QRo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 12:17:44 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72C0CE78;
        Thu, 27 Apr 2023 09:17:42 -0700 (PDT)
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33RG2Z7h020499;
        Thu, 27 Apr 2023 16:17:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : reply-to : to : cc : date : in-reply-to : references : content-type
 : mime-version : content-transfer-encoding; s=pp1;
 bh=ic+ZivNPG+tZj40FmSaG+MaMh6TbOqrGb38TLThNvJU=;
 b=mSiwimchq2M3BxiGeHGnG6P/SWh1XxY+QnrSBO59kpJvJAeay1r0v8TfJR8uYkgrvexE
 t8pA+VqoQ3T8nqtmLs0V6bNIkZfT5gxCT/9uGmqQTOyxs8bn5gJ+erzOe35GxLEnysyF
 V0IbPCMFkqgAbFA9d+b1WKsC6NBux9oWLcPNn2NKYpUN8UjfbKTjI1/7Xlef1bx1TrqH
 HCd46MeKC6QiIaCZR84M4mgTNjyAxd4rKJwFKwWMHdOHAu14g3SVQwnzveylrDofOkuh
 D5nuIciKsw2aWYBCftS6oyJyNsCn0/dByvH3DUUXgjUYZ+fznk0ilsy7RQQ63e6IpCJw EA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3q7sy6nycn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Apr 2023 16:17:01 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 33RFl9e2019857;
        Thu, 27 Apr 2023 16:17:00 GMT
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3q7sy6nybv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Apr 2023 16:16:59 +0000
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 33RDKT8R024984;
        Thu, 27 Apr 2023 16:16:58 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([9.208.130.97])
        by ppma05wdc.us.ibm.com (PPS) with ESMTPS id 3q4778k84r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Apr 2023 16:16:58 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
        by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 33RGGvfw13304462
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Apr 2023 16:16:58 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D516B58061;
        Thu, 27 Apr 2023 16:16:57 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3D09558057;
        Thu, 27 Apr 2023 16:16:53 +0000 (GMT)
Received: from lingrow.int.hansenpartnership.com (unknown [9.211.118.80])
        by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 27 Apr 2023 16:16:53 +0000 (GMT)
Message-ID: <8f212b0dfa9eb00ccc7acc5bf1483c9615277590.camel@linux.ibm.com>
Subject: Re: [PATCH] docs: security: Confidential computing intro and threat
 model
From:   James Bottomley <jejb@linux.ibm.com>
Reply-To: jejb@linux.ibm.com
To:     "Reshetova, Elena" <elena.reshetova@intel.com>,
        "Christopherson, , Sean" <seanjc@google.com>
Cc:     Carlos Bilbao <carlos.bilbao@amd.com>,
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
        "mst@redhat.com" <mst@redhat.com>, "tytso@mit.edu" <tytso@mit.edu>,
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
Date:   Thu, 27 Apr 2023 12:16:52 -0400
In-Reply-To: <DM8PR11MB57502E1C09CDE4842B7F9B30E76A9@DM8PR11MB5750.namprd11.prod.outlook.com>
References: <20230327141816.2648615-1-carlos.bilbao@amd.com>
         <ZEfrjtgGgm1lpadq@google.com>
         <DM8PR11MB575046B6DAA17B41FFED8080E7659@DM8PR11MB5750.namprd11.prod.outlook.com>
         <7502e1af0615c08167076ff452fc69ebf316c730.camel@linux.ibm.com>
         <ZElOfzn37kmesy7e@google.com>
         <DM8PR11MB57509EBCB1E2146C1768A6EEE76A9@DM8PR11MB5750.namprd11.prod.outlook.com>
         <efda0be02fb0b5bf23aec11b5398d20908a821ba.camel@linux.ibm.com>
         <DM8PR11MB57502E1C09CDE4842B7F9B30E76A9@DM8PR11MB5750.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: TO8gpNyfbwe4TNdez_mHuVKkUdg0alp_
X-Proofpoint-ORIG-GUID: TwBNvB-O2QwszmZ6GCQ-CFtxAUIsoChl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-27_07,2023-04-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 suspectscore=0 phishscore=0 mlxlogscore=999 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304270140
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-04-27 at 15:47 +0000, Reshetova, Elena wrote:
> > On Thu, 2023-04-27 at 12:43 +0000, Reshetova, Elena wrote:
> > > 
> > > > On Wed, Apr 26, 2023, James Bottomley wrote:
> > > > > On Wed, 2023-04-26 at 13:32 +0000, Reshetova, Elena wrote:
> > [...]
> > > > > > the practical deployment can differ of course. We can
> > > > > > rephrase that it "allows to exclude all the CSP's
> > > > > > infrastructure and SW out of tenant's TCB."
> > > > > 
> > > > > That's getting even more inaccurate.  To run  in a Cloud with
> > > > > CoCo you usually have to insert some provided code, like OVMF
> > > > > and, for AMD, the SVSM.  These are often customized by the
> > > > > CSP to suit the cloud infrastructure, so you're running their
> > > > > code.  The goal, I think, is to make sure you only run code
> > > > > you trust (some of which may come from the CSP) in your TCB,
> > > > > which is very different from the statement above.
> > > > 
> > > > Yes.  And taking things a step further, if we were to ask
> > > > security concious users what they would choose to have in their
> > > > TCB: (a) closed-source firmware written by a hardware vendor,
> > > > or (b) open-source software that is provided by CSPs, I am
> > > > betting the overwhelming majority would choose (b).
> > > 
> > > As I already replied in my earlier message from yesterday, yes,
> > > this is the choice that anyone has and it is free to make this
> > > choice.  No questions asked. (Btw, please note that the above
> > > statement is not 100% accurate since the source code for intel
> > > TDX module is at least public). However, if as you said the
> > > majority choose (b), why do they need to enable the Confidential
> > > cloud computing technologies like TDX or SEV-SNP? If they choose
> > > (b), then the whole threat model described in this document do
> > > not simply apply to them and they can forget about anything that
> > > we try to describe here.
> > 
> > I think the problem is that the tenor of the document is that the
> > CSP should be seen as the enemy of the tenant. 
> 
> We didn’t intend this interpretation and it can be certainly be fixed
> if  people see it this way. 
> 
> Whereas all CSP's want to be
> > seen as the partner of the tenant (admittedly so they can upsell
> > services). In particular, even if you adopt (b) there are several
> > reasons why you'd use confidential computing:
> > 
> >    1. Protection from other tenants who break containment in the
> > cloud. These tenants could exfiltrate data from Non-CoCo VMs, but
> > likely would be detected before they had time to launch an attack
> > using  vulnerabilities in the current linux device drivers.
> 
> Not sure how this "likely to be detected" is going to happen in
> practice. 

How do you arrive at that conclusion?  Detecting malicious tenant
behaviour is bread and butter for clouds ... especially as a nasty
cloud break out is a potentially business destroying event.

> If you have a known vulnerability against a CoCo VM (let say in a
> device driver interface it exposes), is it so much more difficult for
> an attacker to break into CoCo VM vs non-CoCo VM before it is
> detected? 

It's a question of practicality.  Given that a tenant has broken
containment and potentially escalated to root, what, in addition, would
they have to do to exfiltrate data from a CoCo VM.  The more they have
to do to launch the attack, the greater the chance of their being
detected.

> >    2. Legal data security.  There's a lot of value in a CSP being
> > able to make the legal statement that it does not have access to a
> > customer data because of CoCo.
> 
> Let's leave legal out of technical discussion, not my area. 

It *is* a technical argument.  This is about compliance and Data
Sovereignty, which are both services most clouds are interested in
providing because they're a potentially huge and fast growing market.

> >    3. Insider threats (bribe a CSP admin employee).  This one might
> > get as far as trying to launch an attack on a CoCo VM, but having 
> > checks at the CSP to detect and defeat this would work
> > instead of every insider threat having to be defeated inside the
> > VM.
> 
> Ok, this angle might be valid from CSP point of view, i.e. noticing
> such insider attacks might be easier I guess with CoCo VMs. 
> 
> > 
> > In all of those cases (which are not exhaustive) you can regard the
> > CSP as a partner of the tenant when it comes to preventing and
> > detecting threats to the CoCo VM, so extreme device driver
> > hardening becomes far less relevant to these fairly considerable
> > use cases.
> 
> I think the first case still holds, as well as one case that you have
> not listed: a remote attacker attacking CSP stack using some
> discovered and not yet fixed vulnerability (stack is big, bugs
> happen), getting control of CSP stack and then going after the CoCo
> VMs to see what it can get there. 

Well, that's not really any different from a containment break.  Most
cloud security analysis is performed by outside entities who start with
"an attacker has gained root on your compute platform, what can they
do?".  So they skip the how and move straight to what is the threat
potential.

> What you are saying is that you (as CSP) maintain the good first
> level defense to prevent attacker to get control of your/CSP stack to
> begin with.  What we try to do is the next level of defense (very
> typical in any security):  we assume that first line of defense has
> been broken for some reason and now there is a second one placed to
> actually protect customers end data. 

Well, that's where cloud security analyses also start.  However, what
you've missed is that the cloud detecting the attack and usually
shutting down the node is a valid response.  Clouds actually invest
significantly in intrusion detection and remediation systems for this
reason.

> > > Now from the pure security point of view the choice between (a)
> > > and (b) is not so easily done imo. Usually we take into account
> > > many factors that affect the risk/chances that certain piece of
> > > SW has a higher risk of having vulnerabilities. This includes the
> > > size of the codebase, its complexity, its attack surface exposure
> > > towards external interfaces, level of testing, whenever the code
> > > is public, code dependency chains, etc. Smaller codebase with no
> > > dependencies and small set of exposed interfaces is usually
> > > easier to review from security point of view given that the code
> > > is public.
> > 
> > This reads like an argument that, from a security point of view,
> > smaller proprietary code is better than larger, open source, code.
> > I really don't think we want to open this can of worms. 
> 
> I don’t think I have made this statement: the code *has to be public*
> for anyone to review and I did explicitly list this in the statement
> above as "given that the code is public".

Public but not open source is still a problem.  The federal government
has walked into several cloud accounts demanding a source code security
review, which means the code was made public to them but not generally.
Without all customers or some third party being able to build the code
and verify it (or ideally supply it ... think something like Red Hat
built the OVMF code this cloud is using and you can prove it using
their build signatures) how do you know the source you're given
corresponds to the binary the signature verifies.

>   Only thing I meant is that it is not not so easy to make a call
> between (a) and (b) in all cases from a pure security point of view. 

Proper governance is usually listed as a requirement for security. 
Public but not Open Source usually exists because of governance or
control issues, which can be cited as a security risk.  After all,
whoever does this must have some reason for not running an open source
project in a security critical area.

James

