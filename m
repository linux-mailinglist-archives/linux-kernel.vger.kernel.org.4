Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98BDA6CA0D8
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 12:08:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233270AbjC0KIQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 06:08:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbjC0KIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 06:08:13 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B52B46B4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 03:08:12 -0700 (PDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32R8gC7S024202;
        Mon, 27 Mar 2023 10:08:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=OUcHWzZk7/CnjV+4EJJGzetbRbCxsDJgpLoAcIBVMyQ=;
 b=KRhQpCBGfCBItnOphDTouAQflWUCpWaKfW9GRoyChRSSLs6hYo0UfYXmj69HD1JZraAU
 kxruhP8LVrv0rYmU9aAw5rVlFGponZzMOWNkPzecnWbm7eAZWQAM97X1DauK/P5C9ffW
 iR0uJSqUFElWKSxrAH5geQDnfg0sizVcGY4UwfV6jf7VzX6ul2iosdz3XRDFS+zlrBno
 Pm2mETLrI5WqjXE8Ym50jcQWwFsrTDc+Dwa8XuYoTM9+FIzy66QNTwmHInnpKqW7RJya
 JLdmY9aaTkTLFKLAGafksx0gqKr6eNlbLbAXQEO2WlwMvO8V6uBDW/UEw95tbzkSOD7U Ng== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pjat7kyf9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Mar 2023 10:08:02 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32R8BWtw016209;
        Mon, 27 Mar 2023 10:08:02 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pjat7kyen-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Mar 2023 10:08:02 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 32QGYBNp011375;
        Mon, 27 Mar 2023 10:08:00 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma04fra.de.ibm.com (PPS) with ESMTPS id 3phrk6a98c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Mar 2023 10:08:00 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 32RA7ure30081298
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Mar 2023 10:07:56 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 848712007D;
        Mon, 27 Mar 2023 10:07:56 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 130FE20079;
        Mon, 27 Mar 2023 10:07:53 +0000 (GMT)
Received: from li-a450e7cc-27df-11b2-a85c-b5a9ac31e8ef.ibm.com (unknown [9.43.40.181])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Mon, 27 Mar 2023 10:07:52 +0000 (GMT)
Date:   Mon, 27 Mar 2023 15:37:49 +0530
From:   Kautuk Consul <kconsul@linux.vnet.ibm.com>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Fabiano Rosas <farosas@linux.ibm.com>,
        Sathvika Vasireddy <sv@linux.ibm.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] arch/powerpc/kvm: kvmppc_hv_entry: remove .global
 scope
Message-ID: <ZCFq9etrP20TbdUT@li-a450e7cc-27df-11b2-a85c-b5a9ac31e8ef.ibm.com>
References: <20230316051025.1424093-1-kconsul@linux.vnet.ibm.com>
 <20230316051025.1424093-2-kconsul@linux.vnet.ibm.com>
 <CRH1YM72SK4L.QU56WGVQQ2GE@bobo>
 <ZCFhnNPrMr3D5+rZ@li-a450e7cc-27df-11b2-a85c-b5a9ac31e8ef.ibm.com>
 <ZCFjJ1sMuLMUkBWc@li-a450e7cc-27df-11b2-a85c-b5a9ac31e8ef.ibm.com>
 <CRH2N2UNMLQW.1W51OVV9ZES7L@bobo>
 <ZCFoBqReJekPd7GI@li-a450e7cc-27df-11b2-a85c-b5a9ac31e8ef.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZCFoBqReJekPd7GI@li-a450e7cc-27df-11b2-a85c-b5a9ac31e8ef.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: vs3EiCx8L3GSPd53MiBbMo95qQTi6ulJ
X-Proofpoint-GUID: wM47j7a6jv9aIX5SUefqjPZeSB2yKj45
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_11,2023-03-24_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 phishscore=0 suspectscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 bulkscore=0 clxscore=1015 impostorscore=0
 lowpriorityscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2303200000 definitions=main-2303270078
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-03-27 15:25:24, Kautuk Consul wrote:
> On 2023-03-27 19:51:34, Nicholas Piggin wrote:
> > On Mon Mar 27, 2023 at 7:34 PM AEST, Kautuk Consul wrote:
> > > On 2023-03-27 14:58:03, Kautuk Consul wrote:
> > > > On 2023-03-27 19:19:37, Nicholas Piggin wrote:
> > > > > On Thu Mar 16, 2023 at 3:10 PM AEST, Kautuk Consul wrote:
> > > > > > kvmppc_hv_entry isn't called from anywhere other than
> > > > > > book3s_hv_rmhandlers.S itself. Removing .global scope for
> > > > > > this function and annotating it with SYM_INNER_LABEL.
> > > > > >
> > > > > > Signed-off-by: Kautuk Consul <kconsul@linux.vnet.ibm.com>
> > > > > > ---
> > > > > >  arch/powerpc/kvm/book3s_hv_rmhandlers.S | 3 +--
> > > > > >  1 file changed, 1 insertion(+), 2 deletions(-)
> > > > > >
> > > > > > diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
> > > > > > index acf80915f406..b81ba4ee0521 100644
> > > > > > --- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
> > > > > > +++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
> > > > > > @@ -502,8 +502,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_ARCH_207S)
> > > > > >   *                                                                            *
> > > > > >   *****************************************************************************/
> > > > > >  
> > > > > > -.global kvmppc_hv_entry
> > > > > 
> > > > > I think this is okay.
> > > > > 
> > > > > > -kvmppc_hv_entry:
> > > > > > +SYM_INNER_LABEL(kvmppc_hv_entry, SYM_L_LOCAL)
> > > > > 
> > > > > The documentation for SYM_INNER_LABEL says it for labels inside a SYM
> > > > > function block, is that a problem? This is a function but doesn't have
> > > > > C calling convention, so asm annotation docs say that it should use
> > > > > SYM_CODE_START_LOCAL?
> > > > That is correct. Will create a v4 patch for this and send it.
> > > But using SYM_CODE_START_LOCAL again causes a warning in the build
> > > (which we were trying to avoid):
> > > arch/powerpc/kvm/book3s_hv_rmhandlers.o: warning: objtool: .text+0x48: unannotated intra-function call
> > 
> > Are you using SYM_FUNC_END as well? Looks like you need that to
> > annotate the type properly. It should be the same as SYM_INNER_LABEL
> > in the end AFAIKS.
> 
> What about SYM_CODE_START_LOCAL and SYM_CODE_END ?
> This seems to work fine for me without any build warnings from objtool.
Sent a v4 with this fix. Thanks.
> > 
> > > > > 
> > > > > BTW. why don't our _GLOBAL() macros use these SYM annotations? I haven't
> > > > > really looked into them.
> > > > Not sure. Was mostly just concentrating on the kvmppc_hv_entry code.
> > 
> > Looks like it's because we have a .type @function annotation in those
> > already. Not sure if we should end up converting all that over to use
> > the SYM annotations or if it's okay to leave it as is.
> > 
> > Thanks,
> > Nick
