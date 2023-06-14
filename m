Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B81F672F48C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 08:15:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242194AbjFNGPS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 02:15:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232453AbjFNGPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 02:15:14 -0400
Received: from mx0a-0014ca01.pphosted.com (mx0a-0014ca01.pphosted.com [208.84.65.235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A225C1739;
        Tue, 13 Jun 2023 23:15:13 -0700 (PDT)
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35E4pjou015553;
        Tue, 13 Jun 2023 23:15:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=DkppJlLSFvHUiS/C9yHkgpVb8RpI7IfL6UPhztb7Boc=;
 b=EAsgEmAiVHtRSIXS4Uu/bkjebflbC+p5G3uj3lDGrt0jVIAVRbfbr4dcWZc/NpcUQdML
 MflcU88e54576lRYJS79GsRIFSZkcJapzBDUo3HAKnbtbAz0NclhW3bnENzQJHqgUBFW
 VDJMcbfTWyxYjBjQLFyNHP4K9qsjdJ107kpKu/RWolSLrR3zITppUy5eFOi9tmP9uO9g
 a/iJvc/9nrgr7gldsj3bWfR/zxZSAHW5lhMIPYkqYjrJqfNKVq7+85wLK2QgTT042mOu
 +cBohyBHndItU71UUQDv4qWtlvDNNAKwknY0TjhQXwMN/ftBxvFHD5qOPRWnN6UP9pVq sA== 
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2175.outbound.protection.outlook.com [104.47.73.175])
        by mx0a-0014ca01.pphosted.com (PPS) with ESMTPS id 3r4nqvpfb0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Jun 2023 23:15:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kLrthbLjlm/8IClRI2X4FikjZCQgytfUeUlpwUJylnsu2i/RZex/hU8fB3py2NZ7fnoxVd3HEnTbw59WR2NykirqAHGqWBhVqJGFk7nR8EInWe1ewcxTBGAzHjOhziRKPKV4EBHXz7oHi+JRJVDmI2Ve5y5uUPWvEG7PsU39U4W9o+6WciXhgT/2LR81c7QBpTBYMbfd1F8zNRli4V3U6iB5+6bVyzvMkVhfCycAevTFzvi4/RhTRKjk5KAnvCQXY0d3LDx9896R1VauOX7aNuRdW6crNYgfS28HvDOXVPol14fwBtjcfjE0/iWB/huNjq2ypxfpvBbq2W7TX4hfUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DkppJlLSFvHUiS/C9yHkgpVb8RpI7IfL6UPhztb7Boc=;
 b=LgWznHRRvRDOiQzstyQKtdDkd+28s6v7uXuF1BXB2jN1OFRdro5DPSXhZbrfy73p24Ra9Z5yeeERdygx5Lw3i4h4fK1Vtfx/T7z67gfC1SKkVSH/kXBikeQGM583R33kT1VJ2m9DyIZnq7GBXwg8GE2q5TL8XtWlvW1Al6XPQ4PwfSNsC5JOKPW+/x1PkeELsTBd6TVvi56Jc25ZqAa0SAskj0McJst4i2J0LSGWWaUjIAjyPoXzUgKK4EYSIZMxJaxpRkkhmgyjTN7FW2Yp3AVmRH2rZZiAHY4WgWFURzvuzbrw7z9xMRL/RjQDLomwQRapZKDThdSvXqtv2FjUaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DkppJlLSFvHUiS/C9yHkgpVb8RpI7IfL6UPhztb7Boc=;
 b=bwulZrO6e1oOuOZ9NqRsiC2RmapZ+X2uyPSf6HJeej4z94KXFweuShMkbcT6AMzGHEYvD/LtGg5qumaD0CiBmhHNOufbXbsXWI+uAtiMykT03uOHtlCZQ3AsqjG2F9kMsJ9R6fsAG7daKZh8oiqn63FXm20qAVMPAVwWdBhW9fE=
Received: from BYAPR07MB5381.namprd07.prod.outlook.com (2603:10b6:a03:6d::24)
 by DS7PR07MB7509.namprd07.prod.outlook.com (2603:10b6:5:2c1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.38; Wed, 14 Jun
 2023 06:14:57 +0000
Received: from BYAPR07MB5381.namprd07.prod.outlook.com
 ([fe80::44e:1359:ff02:2482]) by BYAPR07MB5381.namprd07.prod.outlook.com
 ([fe80::44e:1359:ff02:2482%4]) with mapi id 15.20.6455.045; Wed, 14 Jun 2023
 06:14:56 +0000
From:   Pawel Laszczak <pawell@cadence.com>
To:     Xiaolei Wang <xiaolei.wang@windriver.com>,
        "peter.chen@kernel.org" <peter.chen@kernel.org>,
        "rogerq@kernel.org" <rogerq@kernel.org>,
        "a-govindraju@ti.com" <a-govindraju@ti.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/1] usb: cdns3: Put the cdns set active part outside the
 spin lock
Thread-Topic: [PATCH 1/1] usb: cdns3: Put the cdns set active part outside the
 spin lock
Thread-Index: AQHZfoqjce/v2z9+t0mXr8I66E1D0a+KERjg
Date:   Wed, 14 Jun 2023 06:14:56 +0000
Message-ID: <BYAPR07MB53814C647FA59B26D176E150DD5AA@BYAPR07MB5381.namprd07.prod.outlook.com>
References: <20230504131602.3273835-1-xiaolei.wang@windriver.com>
In-Reply-To: <20230504131602.3273835-1-xiaolei.wang@windriver.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctYzcwODJmYWEtMGE3YS0xMWVlLWE4NmItNjBhNWUyNWI5NmEzXGFtZS10ZXN0XGM3MDgyZmFjLTBhN2EtMTFlZS1hODZiLTYwYTVlMjViOTZhM2JvZHkudHh0IiBzej0iNDQ4MCIgdD0iMTMzMzExOTY4OTQ2NzA5ODk5IiBoPSI2N1ovcjZmRWNGT0tENU9BbWxKOEFEZkdsM0U9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR07MB5381:EE_|DS7PR07MB7509:EE_
x-ms-office365-filtering-correlation-id: 6119f892-5923-4e0c-5a03-08db6c9eace9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FlGy3/ZS7DFEOEdV0vdZbXWyAqAxXDiPnN7rko2krFmjM0iUDI2slMxDU5CQalZ+wrJgMRIrtxJ53wfNVPsS5N88iqGc9Z0wkCzxHOFmo+tpjVIgPMFkqTzuulRJTLU+xjaOc2roEDtF7YFdFsne1/o9GfuqeYRrpMtyD9/UoYyrnEclIUtKrtbGsbuJYCIRmiCoRULbkI4+tKyS1ZeyPq+KWC0JRBKK6zTGVSbLWEIc6vGUW9GVt8qOjSyr2NvT6ocr1tBfiNdLaYLPz0nOQFYm4xemylNX38+rt5U4ZOTycNr87ERnyj6w+zNiT+bAF8AqnSU3FArS9wABg30rjqC2EAVMcDmMwJEexgL9B+mBDD80tA+awrH9/jdSNyKLAq3S2jtxPQ+vixIrbhwk+Q3VABTnJK3K6maBRMxtL0iXPfngRSPfRT9QNzdic+5Y0YHDnoEpetfjZ8HjxsJLtd/7JlCI7dGNTkcSp81NlzWDqZA5XXCuNBluq5dqOsVtx0XycsjSro0MaLOTjAxZjtPKb39m4GX45No2FZZHEzUspw+mN5pQxaQfY1z0WBJQ8HmzF0iSjHgsZ/n9cDxXJvgnxYXubBxQqF9nIV1zMU3VUbJgRGrCHwnhCtheGGmz
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR07MB5381.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(39860400002)(396003)(376002)(136003)(36092001)(451199021)(55016003)(110136005)(54906003)(122000001)(478600001)(71200400001)(41300700001)(8936002)(8676002)(4326008)(76116006)(66946007)(66556008)(66476007)(66446008)(64756008)(316002)(38100700002)(186003)(83380400001)(7696005)(9686003)(6506007)(26005)(5660300002)(86362001)(33656002)(52536014)(38070700005)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vYkBDuy4gzodw+O2cOuQJsHKGr3cWv5CfXPqrIpavraj4REjwD0RyNldHtEl?=
 =?us-ascii?Q?SwxySjv7f8tTQ+mC4G+W++c9UPmko2Od3swLu2nvl0fiF85+hSV/LAjdBV9A?=
 =?us-ascii?Q?7HaCZGnOvQ5tUJhqjRsBXA20PGxallMFDlpi7/NCrYRpmRiYj8IU6gcOPY/w?=
 =?us-ascii?Q?Cpq2y6tAWgZ2fiCGQmeHLBwibRjWrq+LLrMCYuKoMxobKUfSaNF5wxYfLid8?=
 =?us-ascii?Q?jUfO9R/wLd8cyUUfzllm0PgBUGC4GzSdD/M/e4MjDwhte0VBrZgjnqmECYZS?=
 =?us-ascii?Q?i3Uz3m5MFKLqDLwY5NwCoy1KQr+/ACYUIBUG/0KmeN/Z9tM1RjfJ+7KkcNZ1?=
 =?us-ascii?Q?Gual4meZCTU5/bMPHWCv2RL3H/NjLjTIVXLvSNvpna91/4XMO1ckR6wwm7Zz?=
 =?us-ascii?Q?iuWTOl5mKgwPcuVjGc5zd7xwz6PHx4CD/vIgS8nqaJy2a4s5ndJwBG64xJQI?=
 =?us-ascii?Q?Kv+Ez202CfTdoSsRpr+2CjRs6BynNgD1P1BAoTTMLXyek398RMWE83OdXDsN?=
 =?us-ascii?Q?72JAQpbcUImlOKznKx6ykmKCvjHXLgtFsGbsIjFer0Ry7RmRj9Ve4gZpNBTQ?=
 =?us-ascii?Q?lNa2fVPwFFIVH6YVQXCkGZwdEf7bFv9KSnymmdsNijUoUqpIZuZqdGvmIlGZ?=
 =?us-ascii?Q?TPFlxyHMcE33KcUJNenzyb7Ezh58oEnFIjVy1kyJ1oSVSduG05L4rejU+PRX?=
 =?us-ascii?Q?klGoB+QIt2gwd6FHYJHfFXsIRXpQveRz0/qgkG9t/tRtCB4sPUcaMqnDeVrk?=
 =?us-ascii?Q?gN7c4CEcKN66IDFXYj9uHJcFxh7XYQXvHfJeo4Pl+OnyRzu+7xOeRueTH+uz?=
 =?us-ascii?Q?eZGMoJTePoFwZ7pno29I0PPdliQWf9FLYI4EtjK7n63c8IH9vQHRBeEIxvmj?=
 =?us-ascii?Q?ePsejInl+GQ7gctllAqkVuLjrDkXEO7j9FR9r3HCH1HN7hPQZDWtYoZ8YdnW?=
 =?us-ascii?Q?kaEjXnG1BTGsEuE64q/dssOpldcsZE9x2QL0VB3YWeILkKHllwv6HNqIT5cx?=
 =?us-ascii?Q?Sml5tvQZ77py4y2CCEP39LKjy+uNmMjwpYVV7tNTsjHIlcsIJRaf9qEeqgt6?=
 =?us-ascii?Q?HV5UV9S+xcVbdd35Lq92MlHmjDcp+7ImJaiGE+vTqijsCE/8F5pp6d+hpcga?=
 =?us-ascii?Q?XjdNEl6N0YJzrb83NSXH1leNz7IH4DUe6im/31pldEzRUGHnMCbNoETmleRw?=
 =?us-ascii?Q?/K4Prw9cE/IJ1sYrjx78xMhPsoZ4AIu4HI7t35sdVqRKtC6Kk6zkhFH9afn8?=
 =?us-ascii?Q?Su6QEuTYbwvZTjzFw7W6Y0zsnPnT7F7oBJljU28NPo9a7K29c4N0B2rNJywk?=
 =?us-ascii?Q?5NENbvo6esR5DAiKjMhUy17y5XMRuu2Ew9yO6+nEnUNmATbs9GKP5YYGouLK?=
 =?us-ascii?Q?CVehNCVQJr7C/ZX4NVdR6XcgsqOmXoUHb9jMlHjYUNwbfRSPgJ0GarZvNb3+?=
 =?us-ascii?Q?f6y07O/xPXSXiKhy0QaDTGKUkm1flxK0IvTfPBP/7D5O7AkxJYMKJHTR3llV?=
 =?us-ascii?Q?2SRpiwLhSKRW7GlCw1f9FMq39haDNK/sKY7JK8SiHGMq+AjNxNRgPUuQN321?=
 =?us-ascii?Q?wc7PybevTb0hzmtTJtlHkxpJlT+zEnHB1WMfMpLm?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR07MB5381.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6119f892-5923-4e0c-5a03-08db6c9eace9
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2023 06:14:56.4615
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xeasKQCee6ssWvqxN2pan1kJ3LgJBFMb7IKoSnHyx8JlxuU6c2J72YzsWPZzi+R08ecBwwKJUlpgoTNMt1+7RmRm2eYRPJQyQujGi/SCWE4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR07MB7509
X-Proofpoint-ORIG-GUID: VjV147AXlSaFQetfdN8HP3jyjN0NT7h6
X-Proofpoint-GUID: VjV147AXlSaFQetfdN8HP3jyjN0NT7h6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-14_03,2023-06-12_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 malwarescore=0
 mlxlogscore=999 lowpriorityscore=0 suspectscore=0 phishscore=0
 impostorscore=0 bulkscore=0 adultscore=0 priorityscore=1501 mlxscore=0
 clxscore=1011 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306140053
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>The device may be scheduled during the resume process, so this cannot
>appear in atomic operations. Since pm_runtime_set_active will resume
>suppliers, put set active outside the spin lock, which is only used to pro=
tect the
>struct cdns data structure, otherwise the kernel will report the following
>warning:
>
>  BUG: sleeping function called from invalid context at
>drivers/base/power/runtime.c:1163
>  in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 651, name: sh
>  preempt_count: 1, expected: 0
>  RCU nest depth: 0, expected: 0
>  CPU: 0 PID: 651 Comm: sh Tainted: G        WC         6.1.20 #1
>  Hardware name: Freescale i.MX8QM MEK (DT)
>  Call trace:
>    dump_backtrace.part.0+0xe0/0xf0
>    show_stack+0x18/0x30
>    dump_stack_lvl+0x64/0x80
>    dump_stack+0x1c/0x38
>    __might_resched+0x1fc/0x240
>    __might_sleep+0x68/0xc0
>    __pm_runtime_resume+0x9c/0xe0
>    rpm_get_suppliers+0x68/0x1b0
>    __pm_runtime_set_status+0x298/0x560
>    cdns_resume+0xb0/0x1c0
>    cdns3_controller_resume.isra.0+0x1e0/0x250
>    cdns3_plat_resume+0x28/0x40
>
>Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>

Reviewed-by: Pawel Laszczak <pawell@cadence.com>

>---
> drivers/usb/cdns3/cdns3-plat.c |  3 ++-  drivers/usb/cdns3/cdnsp-pci.c  |=
  3
>++-
> drivers/usb/cdns3/core.c       | 14 +++++++++++---
> drivers/usb/cdns3/core.h       |  3 ++-
> 4 files changed, 17 insertions(+), 6 deletions(-)
>
>diff --git a/drivers/usb/cdns3/cdns3-plat.c b/drivers/usb/cdns3/cdns3-plat=
.c
>index 2bc5d094548b..726b2e4f67e4 100644
>--- a/drivers/usb/cdns3/cdns3-plat.c
>+++ b/drivers/usb/cdns3/cdns3-plat.c
>@@ -256,9 +256,10 @@ static int cdns3_controller_resume(struct device
>*dev, pm_message_t msg)
> 	cdns3_set_platform_suspend(cdns->dev, false, false);
>
> 	spin_lock_irqsave(&cdns->lock, flags);
>-	cdns_resume(cdns, !PMSG_IS_AUTO(msg));
>+	cdns_resume(cdns);
> 	cdns->in_lpm =3D false;
> 	spin_unlock_irqrestore(&cdns->lock, flags);
>+	cdns_set_active(cdns, !PMSG_IS_AUTO(msg));
> 	if (cdns->wakeup_pending) {
> 		cdns->wakeup_pending =3D false;
> 		enable_irq(cdns->wakeup_irq);
>diff --git a/drivers/usb/cdns3/cdnsp-pci.c b/drivers/usb/cdns3/cdnsp-pci.c
>index 7b151f5af3cc..0725668ffea4 100644
>--- a/drivers/usb/cdns3/cdnsp-pci.c
>+++ b/drivers/usb/cdns3/cdnsp-pci.c
>@@ -208,8 +208,9 @@ static int __maybe_unused cdnsp_pci_resume(struct
>device *dev)
> 	int ret;
>
> 	spin_lock_irqsave(&cdns->lock, flags);
>-	ret =3D cdns_resume(cdns, 1);
>+	ret =3D cdns_resume(cdns);
> 	spin_unlock_irqrestore(&cdns->lock, flags);
>+	cdns_set_active(cdns, 1);
>
> 	return ret;
> }
>diff --git a/drivers/usb/cdns3/core.c b/drivers/usb/cdns3/core.c index
>dbcdf3b24b47..661d5597fb68 100644
>--- a/drivers/usb/cdns3/core.c
>+++ b/drivers/usb/cdns3/core.c
>@@ -522,7 +522,7 @@ int cdns_suspend(struct cdns *cdns)  }
>EXPORT_SYMBOL_GPL(cdns_suspend);
>
>-int cdns_resume(struct cdns *cdns, u8 set_active)
>+int cdns_resume(struct cdns *cdns)
> {
> 	struct device *dev =3D cdns->dev;
> 	enum usb_role real_role;
>@@ -556,15 +556,23 @@ int cdns_resume(struct cdns *cdns, u8 set_active)
> 	if (cdns->roles[cdns->role]->resume)
> 		cdns->roles[cdns->role]->resume(cdns,
>cdns_power_is_lost(cdns));
>
>+	return 0;
>+}
>+EXPORT_SYMBOL_GPL(cdns_resume);
>+
>+void cdns_set_active(struct cdns *cdns, u8 set_active) {
>+	struct device *dev =3D cdns->dev;
>+
> 	if (set_active) {
> 		pm_runtime_disable(dev);
> 		pm_runtime_set_active(dev);
> 		pm_runtime_enable(dev);
> 	}
>
>-	return 0;
>+	return;
> }
>-EXPORT_SYMBOL_GPL(cdns_resume);
>+EXPORT_SYMBOL_GPL(cdns_set_active);
> #endif /* CONFIG_PM_SLEEP */
>
> MODULE_AUTHOR("Peter Chen <peter.chen@nxp.com>"); diff --git
>a/drivers/usb/cdns3/core.h b/drivers/usb/cdns3/core.h index
>2d332a788871..0f429042f997 100644
>--- a/drivers/usb/cdns3/core.h
>+++ b/drivers/usb/cdns3/core.h
>@@ -125,8 +125,9 @@ int cdns_init(struct cdns *cdns);  int
>cdns_remove(struct cdns *cdns);
>
> #ifdef CONFIG_PM_SLEEP
>-int cdns_resume(struct cdns *cdns, u8 set_active);
>+int cdns_resume(struct cdns *cdns);
> int cdns_suspend(struct cdns *cdns);
>+void cdns_set_active(struct cdns *cdns, u8 set_active);
> #else /* CONFIG_PM_SLEEP */
> static inline int cdns_resume(struct cdns *cdns, u8 set_active)  { return=
 0; }
>--
>2.25.1

