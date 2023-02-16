Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E856B698F43
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 10:05:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbjBPJFk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 04:05:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbjBPJFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 04:05:39 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B25C21A2D;
        Thu, 16 Feb 2023 01:05:38 -0800 (PST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31G80oHF023410;
        Thu, 16 Feb 2023 09:05:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=bxNkA3ggBvcUfThISmViaKYT+iTgOdvYOa+mzjEjusc=;
 b=tQkEnewXmy4rlU2m1yZ0q5/L9rgjdzXx3Wp9oMP+64jMA5XpgLjYgckdphD3XOLjraZG
 k1VQESWluUvdbia4Djq+jOV4AsKdB/G3w+ZcG66CU39251HR1XMaeNTKQs5AkToWuJjd
 cbde/9r3mQF4AmM7d+YzU+T1V37BMThvIeqp8Oa2O7qdVe4wA1qW9/AZrrBOnEbHRmWB
 5b5Tt1RtFQ8rs1KuChUi6X9uaRi8rnbY4Hp12bWM03tc52o5FnggUNPq2VTGzlnMGB6g
 gWPUq2r3PyYcSFO28/RcMOTmsIi9Fm70Sl0wIr+tjAgFqNRh1U8rTOHeAy2/PXwYevj1 qw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3nsg20j7bv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Feb 2023 09:05:20 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 31G8mJNw015743;
        Thu, 16 Feb 2023 09:05:20 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3nsg20j7b8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Feb 2023 09:05:20 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31G62fbW011341;
        Thu, 16 Feb 2023 09:05:18 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3np2n6xe3j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Feb 2023 09:05:18 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31G95Gw423855446
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Feb 2023 09:05:16 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 04E3E2004D;
        Thu, 16 Feb 2023 09:05:16 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5D6A320043;
        Thu, 16 Feb 2023 09:05:15 +0000 (GMT)
Received: from [9.179.9.244] (unknown [9.179.9.244])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 16 Feb 2023 09:05:15 +0000 (GMT)
Message-ID: <4f98164406cfd6da084f9ef617a6668dc4e8d44b.camel@linux.ibm.com>
Subject: Re: [PATCH 1/2] pcmcia : make PCMCIA depend on HAS_IOMEM
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-s390@vger.kernel.org,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Date:   Thu, 16 Feb 2023 10:05:15 +0100
In-Reply-To: <20230216073403.451455-1-bhe@redhat.com>
References: <20230216073403.451455-1-bhe@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: zhEkrqVDtqoRkhJPFlbizQg060DzzFf6
X-Proofpoint-ORIG-GUID: 3rSsY-_OSPADG3bu-7TtAPa3U2UmSgrI
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-16_06,2023-02-15_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 suspectscore=0 mlxscore=0 priorityscore=1501
 mlxlogscore=999 spamscore=0 bulkscore=0 adultscore=0 clxscore=1011
 phishscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2302160075
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-02-16 at 15:34 +0800, Baoquan He wrote:
> On s390 systems (aka mainframes), it has classic channel devices for
> networking and permanent storage that are currently even more common
> than PCI devices. Hence it could have a fully functional s390 kernel
> with CONFIG_PCI=3Dn, then the relevant iomem mapping functions
> [including ioremap(), devm_ioremap(), etc.] are not available.
>=20
> Here let depend PCMCIA on HAS_IOMEM so that it won't be built to
> cause below compiling error if PCI is unset.
>=20
> -------------------------------------------------------
> ld: drivers/pcmcia/cistpl.o: in function `set_cis_map':
> cistpl.c:(.text+0x1202): undefined reference to `ioremap'
> ld: cistpl.c:(.text+0x13b0): undefined reference to `iounmap'
> ld: cistpl.c:(.text+0x14a6): undefined reference to `iounmap'
> ld: cistpl.c:(.text+0x1544): undefined reference to `ioremap'
> ld: drivers/pcmcia/cistpl.o: in function `release_cis_mem':
> cistpl.c:(.text+0x3f14): undefined reference to `iounmap'
>=20
> Link: https://lore.kernel.org/all/Y0TcaZD4nB1w+mAQ@MiWiFi-R3L-srv/T/#u
> Signed-off-by: Baoquan He <bhe@redhat.com>
> Cc: Dominik Brodowski <linux@dominikbrodowski.net>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> ---
>  drivers/pcmcia/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/pcmcia/Kconfig b/drivers/pcmcia/Kconfig
> index 1525023e49b6..7c412bbe8bbe 100644
> --- a/drivers/pcmcia/Kconfig
> +++ b/drivers/pcmcia/Kconfig
> @@ -20,6 +20,7 @@ if PCCARD
>=20=20
>  config PCMCIA
>  	tristate "16-bit PCMCIA support"
> +	depends on HAS_IOMEM
>  	select CRC32
>  	default y
>  	help

Not sure how many PCMCIA drivers only use I/O memory but not I/O ports
the latter of which are badly stubbed out on s390, though at leat they
compile. I have a series on that part that I intend to send a new
version for soon=E2=84=A2. That said yes this does solve the compilation is=
sue
and there could be drivers which rely only on I/O memory and are not
broken in principle.

Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
