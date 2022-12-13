Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D63D164BAAE
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 18:12:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236095AbiLMRKy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 12:10:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235954AbiLMRKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 12:10:47 -0500
Received: from esa.hc4959-67.iphmx.com (esa.hc4959-67.iphmx.com [216.71.153.94])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D419611A33;
        Tue, 13 Dec 2022 09:10:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=seagate.com; i=@seagate.com; q=dns/txt; s=stxiport;
  t=1670951445; x=1702487445;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vcwpt+aEXIkDiorQfHRcfhQOhCVHZ0HdkkwK3y2V14Q=;
  b=EUVb05mULz5sJB4lAB9KtCNRwMO8ApSSFS7g4jIdn7OyAuSmOo3HDXrd
   KlUpsaih0ULq89gSI3/iWNboQKewFcDzKSxmebxjPhkBoYgClAWaLFnLn
   nTfJPrm3BFdGfdeBZxXHdxd4fdn2Xa7lsd0BbxZD1n7Nmi4LRUMFDPbQ1
   s=;
Received: from mail-bn1nam02lp2048.outbound.protection.outlook.com (HELO NAM02-BN1-obe.outbound.protection.outlook.com) ([104.47.51.48])
  by ob1.hc4959-67.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2022 09:10:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RunS1eEN9ytWJzFC3OF+fL0UuMDhE+fIA0ySHY7I+5N6YoS7H3junWas0YdyZ90EAobYQdHMFYy7QwbPYMhku6lSQd9Rh76WlXaNYn/iDvUeWmVbt5dTHG77nmLxz/Cq/UkJ3192KTaNND5asUZW4vWt+Jq/LiTw2dbcHiZBqUTjG+SqhBtYEr/crQ18rg67XWcA/157dY1P5p6pazuG1g9SjCXsKuIQT+LIAC1duOVLjxhmVPA7u4d+FkCdg8eLhEtMDVIo9NNDOLXDEDxE2xOuWGcEH+tpiMiI6pXeYXfAx58bmyx+C7dQc4MzYIt//c2uqHzBaX3NhRqFsgGUWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GXtAx/+gtBDqcnEk1i78TgY5xB+KAAiFiGQwusQad84=;
 b=KgmELx6W++Ivrzbc7NrY1PU3OHMQQdrM5Zm6Ay808ColhWygLo2Xs6GBwQ0eLWuq+5L/1wPipkymSZdoHa/ChbQ2NRDayMwHNj1y7jZgVMVrlLGns54y8BizewT0//vcW9QHR5pMHwbrNC4YSsv2ca1EjyFMTpWVuj6FWfwnpo9nAL5xUWEH1/7cH2m8QQQ7tPKZ1jVJVtLC4OYyZpjnelptgLDLLo+R48g/JDNyvhWCQgRmX08yQM+C6LZ6xPk94zZ4KWgkXbuaZM/zV09Tnrcd8lDq4neKvWnrCvY2PRKpW7IuqMAXbGiwgy/bR5n2Z/9x+QLlscDV/1PEZ9KmOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seagate.com; dmarc=pass action=none header.from=seagate.com;
 dkim=pass header.d=seagate.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seagate.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GXtAx/+gtBDqcnEk1i78TgY5xB+KAAiFiGQwusQad84=;
 b=N2jccCUSWx8Lq2/EuND6GowIuJzqwDGpQgQt9iRP13jh8t7ZLPgdE7s6Gg2dCg23R9gmxT/gfei8Zj9C9/F773gB/pnz0y1LQkgGbv6IqZa+i9Y9wBgcufbZS0XSmYECYUQgTHOXH/Nm2OIctgH0DkDJgrGBpri0AthOJFgGanE=
Received: from PH7PR20MB5058.namprd20.prod.outlook.com (2603:10b6:510:1f2::10)
 by BL0PR20MB3603.namprd20.prod.outlook.com (2603:10b6:208:1cc::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.11; Tue, 13 Dec
 2022 17:10:42 +0000
Received: from PH7PR20MB5058.namprd20.prod.outlook.com
 ([fe80::b614:acb4:3163:f8df]) by PH7PR20MB5058.namprd20.prod.outlook.com
 ([fe80::b614:acb4:3163:f8df%7]) with mapi id 15.20.5880.019; Tue, 13 Dec 2022
 17:10:42 +0000
From:   Arie van der Hoeven <arie.vanderhoeven@seagate.com>
To:     Jens Axboe <axboe@kernel.dk>,
        Paolo Valente <paolo.valente@linaro.org>
CC:     linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Rory Chen <rory.c.chen@seagate.com>,
        Glen Valante <glen.valante@linaro.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: Re: [PATCH V10 0/8] block, bfq: extend bfq to support multi-actuator
 drives
Thread-Topic: [PATCH V10 0/8] block, bfq: extend bfq to support multi-actuator
 drives
Thread-Index: AQHZC7Ll9c4dryol/kaVsAs1ypPtW65r+u+AgAAA3oCAABb5pA==
Date:   Tue, 13 Dec 2022 17:10:42 +0000
Message-ID: <PH7PR20MB50589A941F3F5A50C872E264F1E39@PH7PR20MB5058.namprd20.prod.outlook.com>
References: <20221209094442.36896-1-paolo.valente@linaro.org>
 <A0328388-7C6B-46A4-A05E-DCD6D91334AE@linaro.org>
 <0bcf7776-59d7-53ef-bfd0-449940a05161@kernel.dk>
In-Reply-To: <0bcf7776-59d7-53ef-bfd0-449940a05161@kernel.dk>
Accept-Language: en-US, en-001
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_56e366eb-86f1-4645-85a7-f29555b26fee_Enabled=True;MSIP_Label_56e366eb-86f1-4645-85a7-f29555b26fee_SiteId=d466216a-c643-434a-9c2e-057448c17cbe;MSIP_Label_56e366eb-86f1-4645-85a7-f29555b26fee_SetDate=2022-12-13T17:10:42.106Z;MSIP_Label_56e366eb-86f1-4645-85a7-f29555b26fee_Name=Seagate
 Internal;MSIP_Label_56e366eb-86f1-4645-85a7-f29555b26fee_ContentBits=0;MSIP_Label_56e366eb-86f1-4645-85a7-f29555b26fee_Method=Standard;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seagate.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR20MB5058:EE_|BL0PR20MB3603:EE_
x-ms-office365-filtering-correlation-id: f4e6792e-0712-433c-1725-08dadd2cf77e
stx-hosted-ironport-oubound: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4k5k32c/8/tg+QxTw9h0CPBjxALKKFScnjx2QXz0PB1GWEiwXQ35WBGLK7CFn3KvxKcHYmtQSB9V/EqlQPBIbqz04e+Oil5rnzG8uuovPxyuIc28I8cd+8z9vv8LuuUiZKCMf/TXHP0lspSluCslxbxnZV2pQYvh9I84wBO3OeDUNFUcUmJJ0/kCU3m0UUqqQwMWFEmSAXcbMG/rNnxbqCf0HufZtOOMDOLytDlc0aopOJGvBqF8raGXY83TErMHaz3tCZ0x/u6QfpWUCuoRwiPE6/0SyRGUNZ2fI+LaiWQezEQ49K6B3KXs/azWwEkniw+t2DOEof5UAjnx4e+LSs8Rya0/ad1ZBtWjiAUnMnA6Qni/icQG2uUjHrTs8tZ9cBJTmNXedv27UHV+sJ+95v+DsQBSvS5JOrna9LnwVwUg6u/tU0+u8GrG8/DGhpTNebXL+2MO15taUlJN7lAYarD9tI7W060K0r6SoRT2C0Ch8lDJ0tvqpC7jXHQIhrjl9yItRJpaAcG0jRnhckrq2M5YLVFkdsBWFF+Yck/HYMWj7Fqxe3rROOGWwBoS/R1mEstNAvzmK4RgdWWGcXaxbGbD+ShIDkTK7nUTtW+BJlpbNhHiHNwEdWN3ayBFEQunU8s5GlKXXbHG0g7RIbnWWjRUGXUn9SdBXTXpKG/cb67rTofWUBzyZAAsLbXn1PX6NVMHPfLSkYGgwEhp4fk7og==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR20MB5058.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(346002)(396003)(136003)(366004)(39850400004)(451199015)(55016003)(38100700002)(33656002)(122000001)(38070700005)(86362001)(54906003)(316002)(110136005)(478600001)(6506007)(7696005)(71200400001)(26005)(9686003)(53546011)(2906002)(5660300002)(83380400001)(66556008)(52536014)(186003)(91956017)(41300700001)(66946007)(76116006)(66446008)(4326008)(66476007)(8676002)(64756008)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?mF5Z3K4kq/XRHRARhkiS7yPtJPfPs1TBic06a/oC6eKBi9EpFL49J/9z3S?=
 =?iso-8859-1?Q?TjxkCc1PuphOePRrnv58EgGWutq3rA67Y50m6wYJa+IvqCSdNQTwyFVLoz?=
 =?iso-8859-1?Q?yI8P6MoXGmMBLAo75KiusmAvdQFZ/MhDgagvBaSg+PKo4T0BM9glnuS4hC?=
 =?iso-8859-1?Q?3FkgKTGHQxsRjxYzIPK5tUiwJsLkZduCsB76LTpsnQzeFZhpP64TDln4Wp?=
 =?iso-8859-1?Q?x8BJ0gyMnrokHVD01kMIuPV3k7+GzgDKmYcbjxf610/bpMWtfTyA4qmfP8?=
 =?iso-8859-1?Q?fWGlpAVw0uJ7gHpa+A3K6K1B+DLs4jNUAju0RYzWvVoagCwUteeKXrAm89?=
 =?iso-8859-1?Q?rWFK0GgzEhiUSPEHVKtgLa/2TS4Ta6jHPrsfhMmSAGgIwQUJiRE+i9lGwd?=
 =?iso-8859-1?Q?fr73mKPdYA2lmyIYpx0EnaYXsdH8iRm3X7+C57D4uclmtRZSj8KI4ZO4D8?=
 =?iso-8859-1?Q?BxKoTLpBWjcNu/l4PpIsGj5kJZA3YZnjFc5uLQPGwhwEGSYM+5OHnsEjMN?=
 =?iso-8859-1?Q?1fCEPjUY+XlcgGpdy8qI4Kw4ehHkUe8QT/mC+HahzYYtBaAESxzh9A0cJs?=
 =?iso-8859-1?Q?8jy/DG8GGI8bHHM65XbpASQFHsr7zxk/Vj99Wa4jczFgCRqTGvUSalykE6?=
 =?iso-8859-1?Q?WWirTb0I1J1q+KcD3eXrI5lhCQgoXDLBqHnJryNq8NnaXOZNu6aa8V0nwD?=
 =?iso-8859-1?Q?oegFYcudFX8i5Dc4MN/dttPEkdckVv767xzQI/GjjhxUk8UssXHnLj0SGc?=
 =?iso-8859-1?Q?GPgc0xQcr5C9xYigmhsacGdI/tAElRl0aIqmhjfWYch/wjf5eH9cnO54Ad?=
 =?iso-8859-1?Q?vSgouq2GRKM+VXpz49cHqz31Q5ZPZvelr3NdW60d25t3+0wMQqIbj8s0AN?=
 =?iso-8859-1?Q?MhTWxk6pcyxTYnrLEzA0IpnRZJpNdL+WtYpQVGsduvGiNzsTPxOZqB68JL?=
 =?iso-8859-1?Q?DHtADPF3mOjxtJO+8FTUD4LiPdnLy8m5iaEWKnTYuII0hY6fbMQkPUQ37g?=
 =?iso-8859-1?Q?NQ3aAtbx6RpzgMdDM+9hs9xBoA6q6JNGLVsuhG47/ZW+9uAR7BZGcXFsVJ?=
 =?iso-8859-1?Q?YZ4kDeyOOg0maJ6vjlTKUOhMVZEwTUN4E/rAkX34MpkkBjsKsNyMVUp8Nm?=
 =?iso-8859-1?Q?Z3R5LwRuctH7x47iYO1iAaUv4cI0RnOxY19176FKqIp8A7qNeFEwpc+yGi?=
 =?iso-8859-1?Q?gvwV62M1Iq3IUXA8TxfK+8r0SJmAbcai/XSBgUhFNqQZY3nb621Wz/ve+d?=
 =?iso-8859-1?Q?ucnzj9U7Po/hIAz9wRf4ZB/AmVKrCEM0RmSsD35jr7kwCvR2Lc2uZ6xbek?=
 =?iso-8859-1?Q?OOgVXyvlUpMN7/0x3AdfvuPUsYUeEQcvsKbmLtji06IKXSJ/Fjv1sUROBx?=
 =?iso-8859-1?Q?e1Fys0GlIxN7L7Gsmvjko4+nhKC2hZi1W4FeUITwOE1gyx+B7Gnm00dOJ/?=
 =?iso-8859-1?Q?HkSz4HTGuYtR02Sboj4Oqf29HIy+9zMyZRfuZ2XoGkThVMLP3xzIrSTp4n?=
 =?iso-8859-1?Q?KGnlSYJ7jDz4WOPbVaquB3AOp4D5STHsxEV9oXSLjz3hmYE8+ABeDNJCAW?=
 =?iso-8859-1?Q?phOB0Z+3DPEbaaDmzwdFU6ARztGwuh14kZJsAQgUQO+JvlBav7Wk+d0mBk?=
 =?iso-8859-1?Q?ExWwqkP+OwKh0rHUJtoInbZnL1hfjMQVu0zdWnTV70v2/w2sW+jKCBtw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: seagate.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR20MB5058.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4e6792e-0712-433c-1725-08dadd2cf77e
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2022 17:10:42.6243
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d466216a-c643-434a-9c2e-057448c17cbe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hDVuGHH7aj8TNcFCNBpwmmAuTuQerRwiS4Pd74Fs9ZIc9e6ZI/AtxRFszBGiXWaolfdKU0UAGf5T1wvMANBTCwBANq7Brbc3WjyVyoljj9o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR20MB3603
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We understand being conservative but the code paths only impact on a produc=
t that is not yet in market.  This is version 10 spanning months with many =
gaps waiting on review.  It's an interesting case study.

-- Arie van der Hoeven


From: Jens Axboe <axboe@kernel.dk>
Sent: Tuesday, December 13, 2022 7:43 AM
To: Paolo Valente <paolo.valente@linaro.org>
Cc: linux-block <linux-block@vger.kernel.org>; linux-kernel <linux-kernel@v=
ger.kernel.org>; Arie van der Hoeven <arie.vanderhoeven@seagate.com>; Rory =
Chen <rory.c.chen@seagate.com>; Glen Valante <glen.valante@linaro.org>; Dam=
ien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: Re: [PATCH V10 0/8] block, bfq: extend bfq to support multi-actuat=
or drives


This message has originated from an External Source. Please use proper judg=
ment and caution when opening attachments, clicking links, or responding to=
 this email.


On 12/13/22 8:40?AM, Paolo Valente wrote:
> Hi Jens, Damien,
> can we consider this for 6.2?

No, it's too late to queue up for 6.2, even when it was posted on
Friday. Bigger changes like that should be in my tree at least a week
before the merge window opens, preferably two (or somewhere in between).

I already tagged the main 6.2 block changes on Friday, and the pull
request has been sent out.

--
Jens Axboe

Seagate Internal
