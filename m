Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD94B66ABFA
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 15:56:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbjANO4E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Jan 2023 09:56:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjANO4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jan 2023 09:56:01 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E9045B90;
        Sat, 14 Jan 2023 06:56:00 -0800 (PST)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30EEnjfA036430;
        Sat, 14 Jan 2023 14:55:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : reply-to : to : cc : date : in-reply-to : references : content-type
 : mime-version : content-transfer-encoding; s=pp1;
 bh=/eEIt6uONz5oYUR/8WO2Z24zjl5rUQMp3wsIkeQoA30=;
 b=A0TCl/NLFs4T8PGaxCNwv85gR8OuIJyMDVdlpX0P6ZR0+odkpVak4M2F/VR+9GzLqwB9
 UJ3a1t0Fy0WKDVmEU3XXuYj5kAjc5BgC5Mv87Ehf+c8IriDc6/UjNt3qOlzHCIH19pPW
 X+PtwD89eVP744hGdk+I2AvmyIXlkjBqS2+C4eMnN0ipgx6+TP+7NG0IHUmL6O9mJT5h
 8ERF7b1o8XQp3e+N1XaZL/a0DbEyEqjFEB8qz9l4DuZDLnyxvsFxH0caYaYoqFzY8WiC
 HZSqYVCrQ9tNlpnEDqxEI7YVW3tprLFz1icJ4N5CTk+/Wc/ZYRyo5swKZ31lFrSujiCx Ow== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3n3xgfr1tg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 14 Jan 2023 14:55:45 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30EEtiMQ011786;
        Sat, 14 Jan 2023 14:55:45 GMT
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3n3xgfr1t1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 14 Jan 2023 14:55:44 +0000
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30EE3rdW013729;
        Sat, 14 Jan 2023 14:55:43 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([9.208.130.102])
        by ppma01wdc.us.ibm.com (PPS) with ESMTPS id 3n3m16aur8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 14 Jan 2023 14:55:43 +0000
Received: from b03ledav004.gho.boulder.ibm.com ([9.17.130.235])
        by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30EEtgoC10748434
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 14 Jan 2023 14:55:42 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6D5F27805C;
        Sat, 14 Jan 2023 16:35:38 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 535227805E;
        Sat, 14 Jan 2023 16:35:35 +0000 (GMT)
Received: from lingrow.int.hansenpartnership.com (unknown [9.211.128.24])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Sat, 14 Jan 2023 16:35:34 +0000 (GMT)
Message-ID: <08302ed1c056da86a71aa2e6ca19111075383e75.camel@linux.ibm.com>
Subject: Re: [PATCH v5 03/11] tpm: Allow PCR 23 to be restricted to
 kernel-only use
From:   James Bottomley <jejb@linux.ibm.com>
Reply-To: jejb@linux.ibm.com
To:     Matthew Garrett <mgarrett@aurora.tech>,
        William Roberts <bill.c.roberts@gmail.com>
Cc:     Evan Green <evgreen@chromium.org>, linux-kernel@vger.kernel.org,
        corbet@lwn.net, linux-integrity@vger.kernel.org,
        Eric Biggers <ebiggers@kernel.org>, gwendal@chromium.org,
        dianders@chromium.org, apronin@chromium.org,
        Pavel Machek <pavel@ucw.cz>, Ben Boeckel <me@benboeckel.net>,
        rjw@rjwysocki.net, Kees Cook <keescook@chromium.org>,
        dlunev@google.com, zohar@linux.ibm.com, jarkko@kernel.org,
        linux-pm@vger.kernel.org, Matthew Garrett <mjg59@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Peter Huewe <peterhuewe@gmx.de>
Date:   Sat, 14 Jan 2023 09:55:37 -0500
In-Reply-To: <CAHSSk04asd_ac8KLJYNRyR1Z+fD+iUb+UxjUu0U=HbT1-2R7Ag@mail.gmail.com>
References: <20221111231636.3748636-1-evgreen@chromium.org>
         <20221111151451.v5.3.I9ded8c8caad27403e9284dfc78ad6cbd845bc98d@changeid>
         <8ae56656a461d7b957b93778d716c6161070383a.camel@linux.ibm.com>
         <CAHSSk06sH6Ck11R7k8Pk_30KbzLzZVdBdj5MpsNfY-R_1kt_dA@mail.gmail.com>
         <CAFftDdqUOiysgrAC4wPUXRaEWz4j9V6na3u4bm29AfxE8TAyXw@mail.gmail.com>
         <CAHSSk04asd_ac8KLJYNRyR1Z+fD+iUb+UxjUu0U=HbT1-2R7Ag@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 277n0nMbYGZUipQKyfCWVpRCVkh2WHrB
X-Proofpoint-GUID: pvhMIe67CAK_42BghCCWCa4tq4PwMGbB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-14_05,2023-01-13_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 adultscore=0 malwarescore=0 lowpriorityscore=0 bulkscore=0 clxscore=1011
 spamscore=0 priorityscore=1501 phishscore=0 impostorscore=0
 mlxlogscore=768 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301140104
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-01-03 at 13:10 -0800, Matthew Garrett wrote:
> On Tue, Jan 3, 2023 at 1:05 PM William Roberts
> <bill.c.roberts@gmail.com> wrote:
> 
> > What's the use case of using the creation data and ticket in this
> > context? Who gets the creationData and the ticket?
> > Could a user supplied outsideInfo work? IIRC I saw some patches
> > flying around where the sessions will get encrypted and presumably
> > correctly as well. This would allow the transfer of that
> > outsideInfo, like the NV Index PCR value to be included and
> > integrity protected by the session HMAC.
> 
> The goal is to ensure that the key was generated by the kernel. In
> the absence of the creation data, an attacker could generate a
> hibernation image using their own key and trick the kernel into
> resuming arbitrary code. We don't have any way to pass secret data
> from the hibernate kernel to the resume kernel, so I don't think
> there's any easy way to do it with outsideinfo.

Can we go back again to why you can't use locality?  It's exactly
designed for this since locality is part of creation data.  Currently
everything only uses locality 0, so it's impossible for anyone on Linux
to produce a key with anything other than 0 in the creation data for
locality.  However, the dynamic launch people are proposing that the
Kernel should use Locality 2 for all its operations, which would allow
you to distinguish a key created by the kernel from one created by a
user by locality.

I think the previous objection was that not all TPMs implement
locality, but then not all laptops have TPMs either, so if you ever
come across one which has a TPM but no locality, it's in a very similar
security boat to one which has no TPM.

James

