Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB5C472B9DB
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 10:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbjFLIK1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 04:10:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234295AbjFLIKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 04:10:17 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on20604.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5b::604])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7352C99
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 01:10:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KQRfMmqvLnIRXOgSLJqdLDpiPCtjoD1ItwJKav96KJnWWHZtW1dBwkMSNkP36sWwzrW6wWZ3zhQUR8xSg4ivN0AjGhX0G0VWZW18w9wC9/a8jJzkiserkEcFb+wKyx3t4iw+TiXkQ+S0tGcP/ePuenRkQ5qmK8B4zjAEgHudTmxxx+/mbQfJ2+hYFNPQajU+NBEeW96qs/6QMoX7VqHq2ERD/U4I8lqg2MtYVqZCGcZgVMV5AuTo2blhDfLCZFWqbw2VTb7Xm+3yrv6ZFqPezVbnbifIqiTEGj35SxtP/l3RTp8PMtzP6KZtCOnc6+D/NnmUUGSgHXbAMZa1btocQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Obe7v0ThxHG567d7IKmBuw1hdue+vbNtd6NUXMLkdNA=;
 b=hLsyliLcPbX78RRo1bREXqUyB2QZEawqOPuiLl5AhzcxrS8RJ364cY24dx2IYhsZcZPvLih/YCodAU9R2ZnNnPsEWu47zHQdg7G+iBXNovjH09UmxKb3w2waAkfwng6EIVBx/4dYUt5SbSwNZrPVBgdJ/NlWUKtZdMtKe++YwqZOsxb2rBer4UaMaTPsPlHG7Qi3PH2XTGWDhnBq/u4JVP82TG16zPhcawU3Fkr4Bi/0xhvnq9AHn8ePoY4K11rDcgFUUHnxSJZKtm4wHfbZL3BYAxlv7h9tmLqeOuQrooewJVMIamXc8kD9vU//n3PubuZuTu496KF/ZOGbjKs0XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Obe7v0ThxHG567d7IKmBuw1hdue+vbNtd6NUXMLkdNA=;
 b=IVdFxVPc84m/97cqenhXDcYMir1y5XZmtQURmLcDTtkr/FH48/Px5okuMY20hpA0rEmxejC3cQU5HQURlefqeXASul48yamD0hAkJHAYqKXb+k07JAe5p9w1lp65I/0H+7KDBHIvm/vAkkORz8/r7K1YMTvvW+Tz5WaCkpw9ILU=
Received: from DM4PR12MB7765.namprd12.prod.outlook.com (2603:10b6:8:102::7) by
 BY5PR12MB4917.namprd12.prod.outlook.com (2603:10b6:a03:1d1::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6477.29; Mon, 12 Jun 2023 08:10:09 +0000
Received: from DM4PR12MB7765.namprd12.prod.outlook.com
 ([fe80::8fcb:fbd0:82c9:c923]) by DM4PR12MB7765.namprd12.prod.outlook.com
 ([fe80::8fcb:fbd0:82c9:c923%4]) with mapi id 15.20.6455.037; Mon, 12 Jun 2023
 08:10:09 +0000
From:   "Gangurde, Abhijit" <abhijit.gangurde@amd.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "Agarwal, Nikhil" <nikhil.agarwal@amd.com>,
        "Gupta, Nipun" <Nipun.Gupta@amd.com>,
        "geert@linux-m68k.org" <geert@linux-m68k.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "git (AMD-Xilinx)" <git@amd.com>,
        "Simek, Michal" <michal.simek@amd.com>
Subject: RE: [PATCH v3] cdx: Rename MCDI_LOGGING to CDX_MCDI_LOGGING
Thread-Topic: [PATCH v3] cdx: Rename MCDI_LOGGING to CDX_MCDI_LOGGING
Thread-Index: AQHZmH94p7cLnjB7q0Wjf3wzncSj5q9/HQqAgAe7LZA=
Date:   Mon, 12 Jun 2023 08:10:09 +0000
Message-ID: <DM4PR12MB7765FB53636A9036F64364168F54A@DM4PR12MB7765.namprd12.prod.outlook.com>
References: <20230606140137.1216731-1-abhijit.gangurde@amd.com>
 <2023060735-unwoven-sip-df79@gregkh>
In-Reply-To: <2023060735-unwoven-sip-df79@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=765db1a6-22f5-4f75-afec-c22ab5e933d3;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-06-12T08:05:09Z;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB7765:EE_|BY5PR12MB4917:EE_
x-ms-office365-filtering-correlation-id: 56b9edc1-1c5f-4fc7-3c28-08db6b1c709d
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +5yFPxKO5WyiEBW4Wa2nxXsL1GJlX4dxbghOzmedteHX+cgKPlSF3VS1t9HCfSEP96eOE8RDMDOW58jJAiGsc+HSiq8a3FmQmeuX7iJkhU8G4wYo6erzUX+R1pCRgnmG62LwWh7KCxiL54pwU8S6zvsbb06oC5k1RVbz6aJYwdr0Ou1JR7ne9gY1aNhlEG43JI5WSgNlhQQe5mRahASlBhqPXwBNN6ihhNxBv8DbowP9FZhrFB/ksCpHHP4JLYIMFA/BPJAJEsmKVIO+1TIB4bIOgoFRR4sRpUeYU3Zj5aCGRiDnjo4UH5nT6rReDyymroXphWr1rd3NzM/IyN4bxlnF2ThXm5X7y4Zvc6nawbdmSjZPLF3hKQxpwCMZLclpIx3jtx1pxaulRYXYYsUYe40aIDFsBhtZWUvHFo7saBgfeQ3ohNzcnnYcB/9SKPSrNEGa4ZFwSYNEI4ZO522VIL8pagLfs68yJg+GSqAGi2aBpVIaWvQOUpd5Si5+hOJdkm61sU7kUocNHMQ3+ep28MsnRVWdTJ/Q0rXJ+dNRITebILIBcWRWbfLE9SBsn3mLUwYwKELKQP+WxnxQZcImq00L3dxjp//ThXSSind9FVU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB7765.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(39850400004)(366004)(396003)(136003)(451199021)(86362001)(7696005)(316002)(8676002)(966005)(41300700001)(83380400001)(5660300002)(55016003)(38100700002)(9686003)(6506007)(52536014)(33656002)(71200400001)(122000001)(8936002)(38070700005)(66446008)(66476007)(66556008)(64756008)(4326008)(76116006)(66946007)(6916009)(478600001)(186003)(4744005)(2906002)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?IWOcZWu+ylBOOTTjDdNUMEl3kKJU4SQ2xfGwiDD56eOKkzj0ahar+pRuxe2J?=
 =?us-ascii?Q?CCyAySkRUhjtnDxTH1cIzcI3jKpL/yAsuxVpXe+SBJwnsESwyTzkqBUgYrdH?=
 =?us-ascii?Q?qcWsROyGFzSbUMrl5xm4lKqwUF3dbWVF/Wvef+6T+jpbXtAho3Fga0kYu14V?=
 =?us-ascii?Q?8YfHVZWLlfuWyMEcJqdphXi4FR7f5xdLQoGAdQ/ryLBTF0NemE7hbS0Et6Y8?=
 =?us-ascii?Q?EewQWvOE1BioW4a50AtHk3ROye9ub/+8FXaAI42fKqN/imVaDwC/ELtmc/SH?=
 =?us-ascii?Q?ZWULvhGAUwGj2tH3tqqp7f2Pq6gwGWqV3KdE5otpXcscTJ4kdotQf6m9Y8am?=
 =?us-ascii?Q?x50fcHCQOg+3mTylMk7pbv/icKaXRLdXFKuwxOyEHELx1ZyQUZYtvXlCoXf9?=
 =?us-ascii?Q?CGOainhd+MvzsvPxne7rAoGStk/bTYEORvI4o6m2FFEg0vYc3lfojbo3x/ek?=
 =?us-ascii?Q?uq/uOcw44u2ylqhW/MKV3j6RpBqUlloyfQAbKKUHWthzPwPvOoEJUDxExKrl?=
 =?us-ascii?Q?3kxragSp3qHi1rwYDIUePpDP8Xlt+y4fshVwS251FMmcqzlyKEJ90rly/H4Y?=
 =?us-ascii?Q?2DyQ58MYDe992SBxCfzy3NGmZnevQ6Di0BDZuk9jbtTCTRMvqPm8C7cx7Qfj?=
 =?us-ascii?Q?9T9IaeNUNmDuUDklMXmAi5IgbaTGaqO1F5qezYSbGynd/n6xP5ai3z09co02?=
 =?us-ascii?Q?Yw3idc6dvu+4OyNe4jG1jrgi35AxyleBHodn6IMyZXpYBLvWjkPs2s7HPPhc?=
 =?us-ascii?Q?wdYwn7+kCye9pleLKet1yceUocYv5QNNr2+CNsN3pR5EjdvMogwo4tpuK04R?=
 =?us-ascii?Q?wcygo+P0rO3ngmveiZnJKgoVTjQBqH7aGk40AJpV6kScy++2OtrDqHG1V7bG?=
 =?us-ascii?Q?9o05FvzMQd8MWmWcPJ8elvGccAulsvDUnkcOlYHxyaGCS4dqIYc0g7VIhM/Y?=
 =?us-ascii?Q?RSdax5HupWOoHH5xXgHeLHK0lqmm0ticUbIaQERvWi5/5OljdU7TB6IwoVCR?=
 =?us-ascii?Q?9hLGPTtws5cTdewWmRuig+/o43dg8yeLaBChlAZKSCNpZTrMpPWqLiJZLDNR?=
 =?us-ascii?Q?hLqNE6DeirGhIFAF+KtnrHHO5dQVDVm75pk8x3/I3Z0k2u2RNewAN3AlWvND?=
 =?us-ascii?Q?NrJerU+qGkgCyyPQ52CjAFxpLOGDZRGCPaL1SHGprzkGP5KAxZ1Trgtl6K7H?=
 =?us-ascii?Q?dc3Sg1A68g+GGx8O777YdbCcM1uj2lL2A/mtIq2W9Asa37Ip2+ytpOiIOSv5?=
 =?us-ascii?Q?l0jzW1BV2djsH6a4gqrWOpldKLDHXFCsjpQ67sMg2+ZX0QlpEn9NYsOKaYAW?=
 =?us-ascii?Q?YLgAowM7WcNkSyo/A3bRlwjWxbJpr6tQCbWW8jqW8fSeAX19lSECVoxp65lO?=
 =?us-ascii?Q?ZhnZHBXoJ4pOQjzbSHUtGG8omtsfyn4kCep1MXfyz9UlE6r9STNUfoKfuDyd?=
 =?us-ascii?Q?ekZffJGgqsoWq+WhAVu/aT6tqHmUk6GX+BODXWysmu9fjNpzbTZKzP1xqCE0?=
 =?us-ascii?Q?BrRWRYg1YArD7ntpG/YXoAJB1QzAxD3UjbxiMSf/Eh+2fkO3mdQPfSjXpwv4?=
 =?us-ascii?Q?8YYukwbOx97vaiO+e0cfegmnq1F5pQ5laqyAud9sg5vGI+TypesbKZCXMYjS?=
 =?us-ascii?Q?vV5XIHtMvH0DObbeB5Fp+Po=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB7765.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56b9edc1-1c5f-4fc7-3c28-08db6b1c709d
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2023 08:10:09.5233
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uljw8YdgTMax1ggx/2tKEKPDMEFS+xv3287k8s6snPQ763xamQdVgZD+Z4SmwTHt/tt+qf82HqYl7TdWDrk0DQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4917
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[AMD Official Use Only - General]

> On Tue, Jun 06, 2023 at 07:31:37PM +0530, Abhijit Gangurde wrote:
> > MCDI_LOGGING is too generic considering other MCDI users
> > SFC_MCDI_LOGGING and SFC_SIENA_MCDI_LOGGING. Rename it to
> > CDX_MCDI_LOGGING makes it more domain specific.
> >
> > Also, move CONFIG_CDX_MCDI_LOGGING to header file.
> >
> > Fixes: eb96b740192b ("cdx: add MCDI protocol interface for firmware
> interaction")
> > Signed-off-by: Abhijit Gangurde <abhijit.gangurde@amd.com>
> > Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > Closes:
> https://lore.kernel.org/lkml/CAMuHMdWTCdQagFFANygMgA8D0sWaoGxWv
> 2AjibC3vwSd0UxuRw@mail.gmail.com/
> > ---
> >  Changes v2->v3:
> >  - Dropped sysfs entry changes from v2
>
> Where is patch 2/2 in this series that moves to use dynamic debugging
> instead of this custom mess?
>
> This shouln't be a config option at all, as no one will be able to
> enable it on a real system.
>

Will send v4 with completely removing custom logging and use the dynamic de=
bugging.

Thanks,
Abhijit

