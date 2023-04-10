Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33DD46DC662
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 13:45:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbjDJLpQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 07:45:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjDJLpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 07:45:14 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2127.outbound.protection.outlook.com [40.107.102.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3C8149ED;
        Mon, 10 Apr 2023 04:45:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aANyxU5irA2hiB2kckB4z9eMdln65HFohvlIvNEXIk2tZL2cLJ6FdGhLkbv4L4dMB7DBwffb91O8zAI46ewBdlckf/r9xVfHmBvKyt0cAP7EA6HIpIttf/3nTYlNYvncYFOr2/kMrIzf+1xQt49NYCTEnDb3/rOP5giuhrDjm97TRfHP0CnGD/k6nQ/mWNDRzaVYcnG97vYsZs6CV+Lx/Bppve/23WojgQbUb6PHhYqTrZ+X6LoWDZKqFcnwDgZmVyTB/cZ8xO6RciETH09d/jl6xcf/tQ8hk+3H4IFDsCoYtqRQhJbYni6fR/pO883wrj++AMO8mqvt6O1oyIwBWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YU3n9yMc70UhhQijN64NLuYqMtTTnwXZ3CjNr4QXmjM=;
 b=a/1EW6uB6a5set1PrmtxgIoiDq3HOW5ZbxPIEWsU8+8Ml8l4u+zD/AZY1BxqX2nJZGmh1Qaza2I5tUyJLWIl62WFAFACzqDJUBF0DvhgT+FZwFLUp1oqLEV0XZN8mC2WQ+tO0uQaWOA6RdzAwPvBsM/tiDBW2IVwz1X6M8H/GDCC4PJGsg5Jjn+MErBqtz8IWuRWXFO/sCCEMOiz1R5uJ35BXV5UJCaTYrJVy8AMuvke2ITpWIczGB/n7OQFMPQkmF9G7nYgbUlqsY4USM0glkRl0iUI1JFTEqtC3ApxCDPpTWLyQnVVEkhiEba2vM3WXDjXZ/yYZSSokHPld3NwZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=chelsio.com; dmarc=pass action=none header.from=chelsio.com;
 dkim=pass header.d=chelsio.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chelsio.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YU3n9yMc70UhhQijN64NLuYqMtTTnwXZ3CjNr4QXmjM=;
 b=bDB2HPaNxbLI+oTDMmIS5vjwZZgCaSnGu6X/AE4qQE/RUwxKn6Lm15hB73U0mrGxNrNdIZmGqDOt84vY/kCmSXU4OmOtkFdS+56ghxpz0LrlSDf6Rj331fv574/5elHAXmkiZzVzM8xoKI4emNgKPia/jaAoN7n7I0sm7bxSyBQ=
Received: from BN9PR12MB5324.namprd12.prod.outlook.com (2603:10b6:408:105::15)
 by DM4PR12MB5796.namprd12.prod.outlook.com (2603:10b6:8:63::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.35; Mon, 10 Apr
 2023 11:45:10 +0000
Received: from BN9PR12MB5324.namprd12.prod.outlook.com
 ([fe80::6d75:bbae:8cf6:2c08]) by BN9PR12MB5324.namprd12.prod.outlook.com
 ([fe80::6d75:bbae:8cf6:2c08%6]) with mapi id 15.20.6277.031; Mon, 10 Apr 2023
 11:45:10 +0000
From:   Varun Prakash <varun@chelsio.com>
To:     Denis Plotnikov <den-plotnikov@yandex-team.ru>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "target-devel@vger.kernel.org" <target-devel@vger.kernel.org>,
        "nab@linux-iscsi.org" <nab@linux-iscsi.org>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>
Subject: RE: [PATCH] scsi: target: cxgbit: check skb dequeue result
Thread-Topic: [PATCH] scsi: target: cxgbit: check skb dequeue result
Thread-Index: AQHZaJkXUpuhrJHEekWu8DA0apgLca8kcWfw
Date:   Mon, 10 Apr 2023 11:45:10 +0000
Message-ID: <BN9PR12MB532475CDE58B1E570B37DC60BC959@BN9PR12MB5324.namprd12.prod.outlook.com>
References: <20230406150405.300909-1-den-plotnikov@yandex-team.ru>
In-Reply-To: <20230406150405.300909-1-den-plotnikov@yandex-team.ru>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=chelsio.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5324:EE_|DM4PR12MB5796:EE_
x-ms-office365-filtering-correlation-id: ef2ca03b-3f31-4e25-5890-08db39b90a17
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CtAqOlQp0It5PmD9I98caCN6DHg4ThZUtX9GAO1eEvbNURixon/t16uHJql+stX6Mp0yM5K0iICuZZ/zZlKbuQIwKNLoAft8CzILyp53UTTqUsQt8t9mZnXqhANLEdCn3eWC6IaoKwujPgEePDpsztbZsjmnJauoU4KLVCPic3tO8MXq00KxAYkPp/rR0PPcjdy/TFPBLQaxbLZTEF92tRxp6X1HtKIml4CrZp2V00GurfRx7+mos0Ytha4SamgU4GHaHOT+ZpSZVWHL90V+VCjGlG4a3k0tuXcbSgpokB/4X9GnbVjKihh+pzLGIrxHTWaMPNSi05ZZi5nYw3R3cGVbnlLauBlyWdfR3bRvVzBy9wlhP9WfFxjbp00rlTDLmraPiGxdEgiAWULwg1uBJTQ43pAx+ktKhICbfhe09bnSIgG732MegL6vbiXDZpEVjKnllRlK0CfnVrSh5eaQehXYEeLCTXPpoe6vEAgZja66W97UT0XbV3dGRIxUcQrTJZ5TzgFnW7sESJnINP54DAgKXRezOfQ41G36HEi1wphdGmURz/01aUdGU3Rso3MOLlj2b/kJElERemynyDfOR9/g/4GCQYvZODriqjSGJtnyGypRrIqThJGIOj002j2J
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5324.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(376002)(366004)(39830400003)(346002)(451199021)(71200400001)(7696005)(478600001)(86362001)(55016003)(33656002)(38070700005)(38100700002)(122000001)(4744005)(2906002)(54906003)(110136005)(316002)(6506007)(186003)(26005)(9686003)(64756008)(66446008)(8936002)(4326008)(5660300002)(52536014)(8676002)(41300700001)(66476007)(66556008)(76116006)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DO0ToD/Giux2aTzcPdhZFyEphAdawa4szKwj6ohtQKebDdKPQwQswnfBM0yH?=
 =?us-ascii?Q?Tri9oIvY2qFt8h1ZRQRsczDSyYsmEh9i1x0fN6ggcWt8eEcdhO0vFCx2kb0J?=
 =?us-ascii?Q?bx9G4y7PzM6um7+/7B8LKjIg0oJ7D+jJdN4oVE1pZQ/2s6A0g8f+8lBszNDF?=
 =?us-ascii?Q?MpS6N0Qw7KKE8rIA3xpe9DyImnVbuEXazR7eD2uRWfmDLq85Y+/b+gA5622H?=
 =?us-ascii?Q?SDsEs5WHvaSZk7DGauF55pakb+1umgvbsCm+nsj9hflLG1CLipCVkZqbtjuG?=
 =?us-ascii?Q?cjklK+C5N4NG6F9AggjKZ2JcTGDRmTjauEu4bZp6uTeauWXcUKMNIQ0+uWOo?=
 =?us-ascii?Q?/yRe3Fy8RLRr7rj96zACLwSQ94gPgFlApoRjn6l+a/nDCgroK8pWqCvUSiLD?=
 =?us-ascii?Q?ZNQaNweVccKK822NrC68OscZmuod5CXJYx9BpOoqor2PEt3oCreYJW2Taaz0?=
 =?us-ascii?Q?Os07792RWrUZMpRJXfgqU+c0k/49ygJCZGPEXZ4/0xMiHcI9VKxguVyX+DOp?=
 =?us-ascii?Q?1NR+4Yw3AuGC4USBYBr1G4pPyRWYBjByjq8f2J+slFLzOkcdAvT3Lj9tWdPW?=
 =?us-ascii?Q?QI0u+6JoosUohDNiIiddt0psXXGbZvVyFpmdBBBBT/3ixzf1iRNtDmkPkHSc?=
 =?us-ascii?Q?hddWIJ8YXO2FOwlQeYXL+5KksHa/ULpWG1vWj7DHL/W/HK20kNFjebHp/KNH?=
 =?us-ascii?Q?Vo8iS07Z+MJv45vaR0OEKI3ZUghwCvY2waO4S5PJ74J6FFsLTw/xZn50sPrY?=
 =?us-ascii?Q?2qPxcs1Rej1nMS9HscRwii6mIBXA6U1dZaDQvJ5Pj/YTLEv89OuoUSI/rAgy?=
 =?us-ascii?Q?wxV55pYbiVftCkDemFJvehNQZGtDigRCph4KdRmMMWydijMsMq3P73LdPtsJ?=
 =?us-ascii?Q?YPG/Wu55+2+bo/JgyVJQS+cK82klnYGvZrGM4JEwPe/onHp+e2ySA1L6dRC7?=
 =?us-ascii?Q?JHq5LADw+1AQC2UcYbqiLv2N4zcPqtEpXWvgCLf8E5csgzchXb/OeFRNbM+Q?=
 =?us-ascii?Q?zV8TNmCLdDinvOEh8enrE9sRja/b6UXhx5Yz1I6S1oFrxZBF1TkGj6qzb0+0?=
 =?us-ascii?Q?ri0+zpKi58EW0ZwqqHtZ+Tyv2lX1L3eOaDb4uV8MV4c4/lsvE4tDaEinmHgi?=
 =?us-ascii?Q?qAsMY4RwpUkFps5GApKLq4uTFAgVU2vB2RjtO6nA2UIZIKueuHqYU6yD0DV4?=
 =?us-ascii?Q?LrNA+OHLObIj8kyaB/yXo7Th6FdaHuLXtlzegz5DyBP33vJT6t8KezYs5cMQ?=
 =?us-ascii?Q?WQen2oNU3RNyPpKRwJ5gIXEVoRCWGofiXzNa5+0KdyBnxW5gilsWrcMbpT7z?=
 =?us-ascii?Q?hyzYbU0ryfbW6BllZ0dYh8kgmpATUG2VnNd8HYaFVuaHM7eao4L/OIewl1EP?=
 =?us-ascii?Q?RXmkZH8+98fVCSHZdzBZUB8vXRyZyl6dpb7KhgbYJ04OFFAqCZuvydBIIv43?=
 =?us-ascii?Q?u6lbiCclAtKVyUq8wzXoFvH8RpOX8euKHX0kYMaKvYipIbXU3jOq8CDWTAdx?=
 =?us-ascii?Q?CdmqJ+ft8y0YeWOfrbLcd/JoqxaN3q5Yc2EczjFjI3blep0SwCaDRFL6msl4?=
 =?us-ascii?Q?/xEl7FGCobssoMvHgWu0CFRJHL//mr3ArOfLBFyo?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: chelsio.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5324.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef2ca03b-3f31-4e25-5890-08db39b90a17
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2023 11:45:10.3801
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 065db76d-a7ae-4c60-b78a-501e8fc17095
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6BvadhFmsc02NuuTm/6RQFxpTFfWGN5/OyGDrFT/1gGAUCW+4MbHVg2K9qziG32c/nJ7AVrcNbNizZMXBLskgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5796
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>On a couple of abort packet paths skb dequeuing may end up with
>returning NULL, which, in turn, may end up with further null
>pointer dereference.
>
>Fix it by checking the return value of skb dequeuing.

skbs in csk->skbq are preallocated for critical events in cxgbit_alloc_csk_=
skb(),
so there is no need to check for NULL.
