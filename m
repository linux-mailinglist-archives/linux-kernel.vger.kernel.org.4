Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE3DF6ECAE6
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 13:04:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231502AbjDXLDi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 07:03:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231642AbjDXLDc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 07:03:32 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2084.outbound.protection.outlook.com [40.107.7.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DE11B7;
        Mon, 24 Apr 2023 04:03:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g2j+O/8+82leMLI0wqHeRFdd+A5wt4eXXUSyNd0hp8L9HIeZoinMXrzNqMBTz67Cm7ZvzlZY5EUNSGkhG87u0C73ZGS84Jk6JUB1S32VPn8sidNUjaXgB6tnE8wuBEG0gKjOKxg0Au6QHLuxfJdnTwsNHQ4yacjYwg0txmiEXfGNjamnIIcrT9yftCoCWwiL7YvjbKl6swls/GHRlsjR22kEuo+9xQjwTdhk3bhSAxpjg5HSy7xk64f3NLQRryrzcuIKv7MAKp1gxD+t2zoocpTlnXSaFqTqrXxsmrZbuCTnVpCC5Ag7sBnpp530Ijf/Br200zETywsV3HCGVnSGog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ND3s5AMr8qJoHuA7xePZSVn025ZrmjDrrdg7yhDhn8Y=;
 b=Gxlr3icXwtnmM5XRuS8wuQkmCP3snQP57WdfY3pJ0G3yEAwvf8RaqOHLYM2pBB6pYX5HzxH4HWwNhi8wRFr1fNYhiDjKmXeQVReLCKKZnzyBtmLjSAprp444Em7W1T7VCRrjv00uWgosgZATRyuOMNd9Nt+mE46DXDOlHYdGCLZ0rKrHRglJ2DMKnBjFho9S9todFYdlxBEgKUhPFKXqT7zFklbLqrfwlKx7KL5sbbrM8lQic10MtJI4zCs6Z4shJNbI7Q5EFH8eRC5ARl0wJcoUsZY9VFCNG+lw4c4fPlvxGJuXj0zLRoj+9lFX+XWtZBnqZqGnMfmfkemp7swqUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ND3s5AMr8qJoHuA7xePZSVn025ZrmjDrrdg7yhDhn8Y=;
 b=ZWcNuhXT5vhCud0ZiP5rS9pWHrbmHIDNoz08VUcvpb6e8WUJJFw9W61zrVLOezcY4+Jvj3eJk/oTZ+MZIfjvRsHa2cHJ4k+6uruas6pbt6DaaCV+ozLw8d9ykd0/+cXt3++KYcGtyLFJ0HdSYesByqOxejeq3Hzczo8SY0CfvCAhZrP5A0j+mj9buiUHYDOQj4WQKJZFtJzjIMVGWo/CBQ1yJ5alr46KwZM97QIEN2P4AknLNumAgguz38LemTcZ5rQAGUjY8FQbJTX/vkXA0d+Z8piS9NM1E+8eoWV0s22kpDGtxZVpsmAlRTUC4ZbjnLnjpSUrjX5bQNHgqXXREQ==
Received: from DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:395::21)
 by DB8PR10MB3226.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:11d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.19; Mon, 24 Apr
 2023 11:03:26 +0000
Received: from DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7235:3b3e:b256:f116]) by DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7235:3b3e:b256:f116%4]) with mapi id 15.20.6340.019; Mon, 24 Apr 2023
 11:03:26 +0000
From:   "Starke, Daniel" <daniel.starke@siemens.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "jirislaby@kernel.org" <jirislaby@kernel.org>,
        "ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 1/8] tty: n_gsm: add restart parameter to DLC specific
 ioctl config
Thread-Topic: [PATCH v3 1/8] tty: n_gsm: add restart parameter to DLC specific
 ioctl config
Thread-Index: AQHZdpsxOz9D2E9lQUyuz0phgWyj0K86S5AA
Date:   Mon, 24 Apr 2023 11:03:26 +0000
Message-ID: <DB9PR10MB588138A96EE5E7CE96E28221E0679@DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM>
References: <20230424075251.5216-1-daniel.starke@siemens.com>
 <2023042438-whole-cannot-1945@gregkh>
In-Reply-To: <2023042438-whole-cannot-1945@gregkh>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2023-04-24T11:03:24Z;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Privileged;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=b129bda1-af69-47b3-b8da-18dc687d9c98;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0
document_confidentiality: Restricted
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR10MB5881:EE_|DB8PR10MB3226:EE_
x-ms-office365-filtering-correlation-id: eb7cd085-5c34-48da-1266-08db44b38792
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wDEphkP3yhJkua+hJKgFWFmiUBNEHpFT8V9DZ7asULscoUiX/CRRXxNaaAMt7yP/nA6S6FKW6ONARJjvlncFeYdLIOzBiHdqOhvlz/L07fthV5gHxKSC1qiGZwB2do2m9+wfXhlwXWqUV3+u9do5df+AwmC/V1mB9bjZRwwnyWl1G+UAnlVaMbgmSravdp2z1Vw1MyDC1n4Z1H+gkM8JpHsgqCIry+zlzjZc0HE+sIjr4PcdhPVZjANax67+tybjqJIKpp7YhwvD9Z14X9Jvb058K6UQNwmrBTy3yc6Yg6djCI86YnTKr1Q29ETaHyfJxHIYIl7DFxryF7BWAgDn7CoPL9IWXuSIPCHVhBVGKQm8sVvKs2/WM5huN5eRUvnxUhY8aTn93e6R5upylG2ad18T5B0SxpyMS8YOBfboGqVKrRgGZRr67PDKgE6tRfmKjoQN/SjS9y8UPlnlaSy7gxQPW9vdK9ED/ygBw1XXlrtwtqi3QVQGXyKazT/rKRTyQPo+71rIjJOYZxvb+yNmDEymxOqvDmNtU3SZmYo31kvQV8xQ29F7yoCUEUizbIoH0EuP2Bq8u7501dZesDqWNG+bmBpxQt3MKnG0pKNn3nM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(346002)(39860400002)(136003)(396003)(451199021)(82960400001)(54906003)(966005)(7696005)(33656002)(83380400001)(55016003)(6506007)(26005)(9686003)(186003)(71200400001)(478600001)(8936002)(8676002)(41300700001)(38070700005)(6916009)(66946007)(66476007)(64756008)(66446008)(66556008)(76116006)(4326008)(316002)(2906002)(86362001)(52536014)(5660300002)(38100700002)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?uEnaEOjEluH4M/A+K0qq7Nk+7NeX0LUoJkFgs5oKZjtiuL9Kc+UPjOH8iIWP?=
 =?us-ascii?Q?/ItoazhSTWXokDNHbNp2eDhYlUrS5EOQOVD8YmFuwUM3V7Ys0EcEscFFCStn?=
 =?us-ascii?Q?3pM/zDxURaUB+EkjzE97lUC9kFIdfDQIe5wzmuWUcMV3OSYy1uTqmE0UPFpz?=
 =?us-ascii?Q?vTSq+H+eiqKaJWrsdj1TpZQLOpPxaOnJv7WiAW70N+R8TeLpp9IoZk6PA3g9?=
 =?us-ascii?Q?QNM/Q03lymHKWp9PtKhLhcBhpFdVdVz8cSaZfXC4+pSG+8R3NbKAySmkROq0?=
 =?us-ascii?Q?P0mSHBKVeO6zlR8igw61omph1cBLdjiopla4Q+InYluFG/FFo1yML+saYhfQ?=
 =?us-ascii?Q?2gFwnk6KPScD4vXFG4oAcqhkHoHnV8jQvbJg6moiB9uo/8cHig1uErFaeRup?=
 =?us-ascii?Q?+/Agozt3HahBb2PoiWzGXUzdSMAaLHj1OzZwiGjxOVxDEXTez/9P9ZcEYs2C?=
 =?us-ascii?Q?LRMSryZNM6IMsTYuMPCbJ24Kcfi5JNQN+aB3BT6V3V3TM4aDH3j05W27NWYm?=
 =?us-ascii?Q?Lnw9T/3HpaRtpEQVPy5G9qZxghVsNrvUij9dbiD9RORbt73jOC1GSwFs1sP/?=
 =?us-ascii?Q?zxYcGe7z3oU+gASaLhtvM9oXI9Qt1p7cPTzK259WdxY3nHkkcaTYS8Xe2Avc?=
 =?us-ascii?Q?mAHOkfMUbRxoVwjVKde0oz2Sfh88uig9RBm0Uo4Xbo9jRQPYPJN/k5EhHfNf?=
 =?us-ascii?Q?ZquOkJdcnwuCNebKgJMgS7Jwo2n+1zXNCEua0991wJVh6njq1yiVBGt+njKi?=
 =?us-ascii?Q?gD63uLd/TG7m2i1Eyd3cqsgCVtsPx0MCPFNGvQCbw4p5Xeidsrz/xzDJIiDA?=
 =?us-ascii?Q?9xrLSlqkbfPohMjOJNAtDFIRSO4Qky573Rx+r6xeyaXz5ptDUDFV8mnRRUXy?=
 =?us-ascii?Q?Vx8Cy/sllHJHVCxC7cHERkAlPOUG5AF1vOtE229sb8WljAYWYfd+KTc73vlS?=
 =?us-ascii?Q?SEFes05zjDC5i/yNT0gt8G8/Dl5cuiPxtRhZsb6Yw3zzh7LMF//xLmr6ZlVX?=
 =?us-ascii?Q?5l7Um/XNNWkoLfRncTWf7ERN/d0vZCF+dk6Emca65Lr+CDqJN7JDnH0wWryX?=
 =?us-ascii?Q?AJCQJv/f8ch1kiz7/9wrC4SX80V3Uh/mJsjazyHtmBQfmI6I+dE0Sg55BMZo?=
 =?us-ascii?Q?wUFf2S6zsUGFJTJYt6PhOiK4/kNlWzg+c1aGEHkIb0bRR3u/F3P0LJNFlOq0?=
 =?us-ascii?Q?Vnlg5TzQwI5YAGgZmrwkGpseqlzmwyp7z6wdLPsFg/JkxB7SAeYfM0ncCTT8?=
 =?us-ascii?Q?Ko2eSVAPEVkjd4AbqyDbhdYJZYcm2jHNO6vcX4JSnW82bKU4pkDhQWp89nJL?=
 =?us-ascii?Q?U2S8EbIxcS3DHDvek929bx8lW98pqwCb3c2Gc3bWwtXX5wI2yqJ1KrUoV9Ij?=
 =?us-ascii?Q?uAcEY+g31bGs7hmjWI3mvb0xu2OzdbOkoq45/z+c65icEN6+NLxTu+fPUUW1?=
 =?us-ascii?Q?oU1vTlbX0h/zHM5aH21bh7BK/IVnN34y8bT6MphiZos5ub9AeNCoZa/zJZyB?=
 =?us-ascii?Q?70o44A21+5brR+nApsRYaTV/r+xOWPN5saf3CWKOfiT59AK8fTDDpPbk/Nqr?=
 =?us-ascii?Q?x60d+ITf1Cw4KEWx4d5XyOYovgWbrufcAT0jouwhVHeUys0+HxfOeeja5PU2?=
 =?us-ascii?Q?IQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: eb7cd085-5c34-48da-1266-08db44b38792
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2023 11:03:26.6780
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rrZdQFz3NXfo881AU9cIuCWa6oYGRrKTwwUwlh0zd9CYgeUgRqCMOnDRerBZykhxqCfx788ADxzVWqMmYYU/LwuE4BGM9TVqzIlG9kJvRtg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3226
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > --- a/include/uapi/linux/gsmmux.h
> > +++ b/include/uapi/linux/gsmmux.h
> > @@ -58,7 +58,8 @@ struct gsm_dlci_config {
> >  	__u32 priority;		/* Priority (0 for default value) */
> >  	__u32 i;		/* Frame type (1 =3D UIH, 2 =3D UI) */
> >  	__u32 k;		/* Window size (0 for default value) */
> > -	__u32 reserved[8];	/* For future use, must be initialized to zero */
> > +	__u32 restart;		/* Force DLCI channel reset? */
>=20
> Why are you using a full 32 bits for just 1 bit of data here?  Why not
> use a bitfield?

The ioctrl guide states:
  Bitfields and enums generally work as one would expect them to,
  but some properties of them are implementation-defined, so it is better
  to avoid them completely in ioctl interfaces.

Therefore, I tried to avoid them here.

> And what happened to the request to turn the documentation for this
> structure into proper kerneldoc format?

That applied to patch 2/8 and is unrelated to this patch. Another patch
will need to fix this.

Link: https://lore.kernel.org/all/20230424075251.5216-2-daniel.starke@sieme=
ns.com/

Best regards,
Daniel Starke
