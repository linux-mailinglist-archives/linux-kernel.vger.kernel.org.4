Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 064A9727AF3
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 11:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233227AbjFHJOi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 05:14:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235352AbjFHJO3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 05:14:29 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A9B218F;
        Thu,  8 Jun 2023 02:14:28 -0700 (PDT)
Received: from pps.filterd (m0134422.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35821x8e023393;
        Thu, 8 Jun 2023 09:14:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=pps0720;
 bh=onVTjRJCYCSDzFZM+pfgJr404kEm5Qga4A98QFVvKsU=;
 b=DFR2/rQ5zdYVCJTcRVbcIU0cctHTQelTo3pGGbiqF9289+7zaDEoNV8EVkFQcWheacOm
 FnGD4v6O5epzPdhAGr0Yo6Pn+gEIrXpKrOBjVw2+8iLs7hr4WDXJUxATwIMk0Sv5QFO1
 B5oQ+RldJIfV26J6gsG6dLm82iHyV2mmtZLfwpQ2SB2ALXSbDpYYFWOzmjVDRGqwZS+F
 09adNL1r8aK643UPsIFjLsSWG/6OcPKOq3UTO1zXJr3ckX7AwfcDEl/BaEqy2USUTm5Y
 C/YZe3HGpagPPzEsF5Cc/Xkceyp7T39VmAA3NJVJVbO3RTdsJYzD5Z0W2oefc9c3fE3G tA== 
Received: from p1lg14881.it.hpe.com (p1lg14881.it.hpe.com [16.230.97.202])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3r2tw485du-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Jun 2023 09:14:22 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14881.it.hpe.com (Postfix) with ESMTPS id 19EA5804DDA;
        Thu,  8 Jun 2023 09:14:22 +0000 (UTC)
Received: from ILEIUN5Z4B.asiapacific.hpqcorp.net (unknown [16.231.227.36])
        by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id 911B5800206;
        Thu,  8 Jun 2023 09:14:16 +0000 (UTC)
Date:   Thu, 8 Jun 2023 17:14:06 +0800
From:   James Liu <james.liu@hpe.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     mlangsdo@redhat.com, james.liu@hpe.com, craig.lamparter@hpe.com
Subject: Re: [PATCH v1] ACPI: reboot: Increase the delay to avoid racing
 after writing to ACPI RESET_REG on AMD Milan platforms.
Message-ID: <ZIGbBF+GxHAlTqGk@ILEIUN5Z4B.asiapacific.hpqcorp.net>
References: <20230607034403.2885-1-james.liu@hpe.com>
 <CAJZ5v0hTsEzFKvRf-MHpUxyJdFDUqc2ZL63s6BkyJyFtEzxvhw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0hTsEzFKvRf-MHpUxyJdFDUqc2ZL63s6BkyJyFtEzxvhw@mail.gmail.com>
X-Proofpoint-GUID: hHLjEAqgzhKG_VZOU66ffptl9bgbCYRL
X-Proofpoint-ORIG-GUID: hHLjEAqgzhKG_VZOU66ffptl9bgbCYRL
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-08_05,2023-06-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1011
 malwarescore=0 mlxscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 bulkscore=0 mlxlogscore=999 priorityscore=1501 impostorscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306080078
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 07, 2023 at 01:19:42PM +0200, Rafael J. Wysocki wrote:
> On Wed, Jun 7, 2023 at 5:44 AM James Liu <james.liu@hpe.com> wrote:
> >
> > For AMD Milan platforms, the delay of 15ms is insufficient to avoid racing
> > of reboot mechanisms. That said, the AMD Milan processors don't reboot
> > in 15ms after invoking acpi_reset().
> >
> > The proposed 50ms delay can effectively work around this issue.
> > This extended delay aligns better with ACPI v6.4 (i.e., sec. 4.8.4.6),
> > which indicates that ideally OSPM should execute spin loops on the CPUs
> > in the system following a write to this register.
> >
> > Signed-off-by: James Liu <james.liu@hpe.com>
> 
> Why do you want to affect everyone (including guest kernels running in
> virtual machines AFAICS) in order to address a problem specific to one
> platform?

I hoped to address this issue for any platform requiring a longer delay to
complete ACPI reset in time for any (maybe silicon-level) reasons. Some AMD Milan
platforms were the cases that we've found so far.

Except that, since ACPI spec indicates there should be a spin loop (long enough)
after the write instruction to Reset Register, I thought it should be no harms to
the other systems which well consider this spin loop when they claim to support
ACPI reboot.

Btw, I am just curious, why is the virtual machine mentioned here?

is the 50ms delay in acpi_reboot() for a guest OS on VM so long that some
unexpected behavior might happen?

> Wouldn't it be better to quirk that platform and document the quirk properly?

Yeah, it could be. Actually we considered this, and we will consider it again.

> > ---
> >  drivers/acpi/reboot.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/acpi/reboot.c b/drivers/acpi/reboot.c
> > index b79b7c99c237..002f7c7814a1 100644
> > --- a/drivers/acpi/reboot.c
> > +++ b/drivers/acpi/reboot.c
> > @@ -78,5 +78,5 @@ void acpi_reboot(void)
> >          * The 15ms delay has been found to be long enough for the system
> >          * to reboot on the affected platforms.
> >          */
> > -       mdelay(15);
> > +       mdelay(50);
> >  }
> > --
> > 2.40.1
> >
