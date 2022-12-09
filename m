Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BF80647F04
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 09:10:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbiLIIKt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 03:10:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbiLIIKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 03:10:42 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E14635E9C9;
        Fri,  9 Dec 2022 00:10:39 -0800 (PST)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B97qMti015249;
        Fri, 9 Dec 2022 08:10:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : references : date : in-reply-to : message-id : mime-version :
 content-type; s=pp1; bh=N3CyM7RoWAs+iQLaB4/0UEohYfeWGrXHD9ljZuxHYf4=;
 b=DC/o3DTkrz+zQQIJzVbo6k9N3IrxPe3BxbjFTyhKm5lFAXmMDTOxpyhDeDkSxsIyw9zu
 eqpbY2jm3XjYNDtT6dVdllkFv2qrSb2Z/Da3WblaSwpH9xukF2gi9xA3Eir3puo9JJin
 EgKxTffweWIlYVChP/MpO7MTiQebMlz7Pf5QoFCRWztsjjYjIQXT2timJHQt94YmP/0D
 iemsMIwjLyMX20+ZxQjJx+Lr0ZLSXVo+ym3FpdeaFWscLCWjqJBu4au0M4kDe5QV6gRo
 /0gqLtcBH99P8rH2rTtSQ7x3hKajOMjIy7Q+3gTltX+Gk/qFhdAzK4L5zDNjoDVmbbD1 Sw== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mc10qgcpu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Dec 2022 08:10:36 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 2B8LRswX016423;
        Fri, 9 Dec 2022 08:10:33 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3m9m5y5n55-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Dec 2022 08:10:33 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2B98AVoM35455478
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 9 Dec 2022 08:10:31 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5C26B2004F;
        Fri,  9 Dec 2022 08:10:31 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 357652004D;
        Fri,  9 Dec 2022 08:10:31 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Fri,  9 Dec 2022 08:10:31 +0000 (GMT)
From:   Sven Schnelle <svens@linux.ibm.com>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH 1/1] tty: fix out-of-bounds access in
 tty_driver_lookup_tty()
References: <20221207075236.23171-1-svens@linux.ibm.com>
        <20221207075236.23171-2-svens@linux.ibm.com>
        <6614f5d2-d99b-ea8a-f660-7a3433499a9f@kernel.org>
Date:   Fri, 09 Dec 2022 09:10:30 +0100
In-Reply-To: <6614f5d2-d99b-ea8a-f660-7a3433499a9f@kernel.org> (Jiri Slaby's
        message of "Fri, 9 Dec 2022 08:17:47 +0100")
Message-ID: <yt9dtu25vvyh.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: z4lDIhrSBh9TrSKJr_LbNcLTt7nao_jO
X-Proofpoint-ORIG-GUID: z4lDIhrSBh9TrSKJr_LbNcLTt7nao_jO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-09_04,2022-12-08_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=841 spamscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 impostorscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0
 clxscore=1015 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212090066
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jiri Slaby <jirislaby@kernel.org> writes:

> On 07. 12. 22, 8:52, Sven Schnelle wrote:
>> When specifying an invalid console= device like console=tty3270,
>> tty_driver_lookup_tty() returns the tty struct without checking
>> whether index is a valid number.
>> [..]
>
> Reviewed-by: Jiri Slaby <jirislaby@kernel.org>
>
> Yes, this makes sense as a sanity check for all drivers. But I would
> _also_ disallow registering such a console in vt:
> --- a/drivers/tty/vt/vt.c
> +++ b/drivers/tty/vt/vt.c
> @@ -3075,6 +3075,11 @@ int vt_kmsg_redirect(int new)
>   * The console must be locked when we get here.
>   */
>
> +static int vt_console_setup(struct console *co, char *options)
> +{
> +       return co->index >= MAX_NR_CONSOLES ? -EINVAL : 0;
> +}
> +
>  static void vt_console_print(struct console *co, const char *b,
>  unsigned count)
>  {
>         struct vc_data *vc = vc_cons[fg_console].d;
> @@ -3158,6 +3163,7 @@ static struct tty_driver
> *vt_console_device(struct console *c, int *index)
>
>  static struct console vt_console_driver = {
>         .name           = "tty",
> +       .setup          = vt_console_setup,
>         .write          = vt_console_print,
>         .device         = vt_console_device,
>         .unblank        = unblank_screen,
>
> That means dmesg would say:
>   Console: colour dummy device 80x25
>   printk: console [ttyS0] enabled
>
> And not:
>   Console: colour dummy device 80x25
>   printk: console [tty3270] enabled
>   printk: console [ttyS0] enabled

Makes sense. Should i add that to my patch, add a second patch, or
will you submit that?

Thanks
Sven
