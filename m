Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADB757236C3
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 07:24:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231391AbjFFFYb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 01:24:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjFFFY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 01:24:28 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5EA818E;
        Mon,  5 Jun 2023 22:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1686029066; x=1717565066;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=vjfOAxLv4ZVwGw/YQhN7gALKjG77x26T9XrIjv7QD4U=;
  b=pxwvhi/YKB//OCq6NLkW2b/fOKYwyEzqrg1FyWnAYIOK8/h23cdXAZwr
   zD7CqMUuYqgq8PK7Rwo7xpphyDUk4Q6B5ei4zNFqUjSGh0DJzw0JndIZo
   j0fWpcggmJcQdNZ/5NAEIAQQQDZILcxANVXK4B75q7bthDUfVk9JbYiGR
   gBqY4vw5Xj04REcsd5MeWOBwhgpoIdTuU18Y6LACt0lrRWMbkrCjLovjO
   E9xpTDAt0x3iBD/o5508M+yVYTITKVm156QcvJWSVwX/grzpVKuH//eVc
   0TBRY2B8jYw6cORYf8crE7fQdUpCMvmy1FjzRAih3tghUc1b/SGQW8Ue5
   Q==;
X-IronPort-AV: E=Sophos;i="6.00,219,1681142400"; 
   d="scan'208";a="337138601"
Received: from mail-dm6nam12lp2176.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.176])
  by ob1.hgst.iphmx.com with ESMTP; 06 Jun 2023 13:24:25 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WKMLGEb88JxoONsWFbhJYe3cDAP8p8qVENKKDkMTU/MnSgcS09HH8b3WMmNZDqt30ukeJEKpFTrL805soTNeLkMfQmZt+Ys4X42k1TRV3GddT5Lm3Vuy6LpdAhP5ED/1pewEjFPbLaZtFKe8O+AieUhgm52nTzEKsHyF41d3W/9rl0UzGJJqfZFUVRKX3w4mowiNrfZPA3uAiYsSYn5uQajgqz+KRtzA52W+E/hpyhoUk4sf9+FQa80YmH6qLZ926LsHJv/tMNAbrOXVElTJLEcdGEdO2Boq6jWepgXVYh7/9yN2KB4Up0+lYB+3B1XRU1x1nmd+CxzR5D/V9Dc1AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vjfOAxLv4ZVwGw/YQhN7gALKjG77x26T9XrIjv7QD4U=;
 b=eiHvnJk5X0Cqrgpf2YLCtSG1mKwLDWzBn/gIiPReiXQicTh7H5nM6orc7+4Infj6NM2P8bx20oaWL6JHlLH+6KBp4C97MGfqhdaN9oNaF00ceh3PG0NR40xu6AOe9mhRAeSiIHF41dQsq7MfpvIfB1z7vDTl4WtHl6TBXo3b3Bzec3DKc5eFwy3lSd5IadxszUy9NNQvx8nWqp1CJx8pZNYxZQ2UMhHnYFb6D2ug4cciQo26TOktP5JbaYdCCST+nivgvdIKlE3B5+e6FBBMqs4XGtwD7BPBEIzZ2BX2pHa0rmQxPhoARY4qqndel2W7Z5WRdsaE1v9OiVLAzh8F4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vjfOAxLv4ZVwGw/YQhN7gALKjG77x26T9XrIjv7QD4U=;
 b=L0AsDdCdFzDUqS5Ynro33P8MoaGf0IzTEGFbCAxN7/ll14y0WOSto50sYEk6lW3TTKzeFmNcC5M45Y+bjwis5gPvCEIvJCbRf2QsPc2li97EveID1LFV68l9vOF6/hEGMTQz1QQwUlMcSUGqV20RKgDofIp+vKpUYs/E1AFE47g=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 BY5PR04MB6279.namprd04.prod.outlook.com (2603:10b6:a03:1f2::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.33; Tue, 6 Jun 2023 05:24:22 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::eb0e:1bef:f266:eceb]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::eb0e:1bef:f266:eceb%3]) with mapi id 15.20.6455.028; Tue, 6 Jun 2023
 05:24:22 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Daniel Wagner <dwagner@suse.de>
CC:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro@fastmail.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH blktests v3 0/2] nvme_trtype=fc fixes
Thread-Topic: [PATCH blktests v3 0/2] nvme_trtype=fc fixes
Thread-Index: AQHZmDclG37kKHjwrE6X3QUWhYKsSQ==
Date:   Tue, 6 Jun 2023 05:24:22 +0000
Message-ID: <ffazxcr66mlu2wecsr2tdsd2fugz425gqplu66cczbchub4kwa@j4ug5w37aefz>
References: <20230503083816.18792-1-dwagner@suse.de>
 <ydocewz6ls4bjow726voiqlk3hi3nziss7ppmao6a7c5v4yv6s@t24bkmsjcm6a>
In-Reply-To: <ydocewz6ls4bjow726voiqlk3hi3nziss7ppmao6a7c5v4yv6s@t24bkmsjcm6a>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|BY5PR04MB6279:EE_
x-ms-office365-filtering-correlation-id: 14bafdfd-b44e-4229-7dba-08db664e493a
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4Iq3ikC2ntdsJl+dJKMVBZ1U3rFpvwDOXmPLUp8XEj+pYS11FU0+KK/bXmd5jDe3X/F8o7gUT5GUCtmwsaAhMwftE2qh7vBpkkabyS+JeAMHYTnBtpaYFdtBUcMPRRp4BtzAI1VzoKO8ZauypJQdSnBxDHKqimihsb2/zINExiImjknOgqM6R22xyoh5KG5zC0hFBTLMFwoZLvG4lXAN0ue/ql3PRp30SM/ZDRLRYyh//yqyyFBjCxHMtbCUD1Ys23XHk4b3TjL7rwH1ncNpNFIhlmT0r/tywMJzFwXHeNTzprVX9IcjWJcIcWVDzvnzQgD1IprosMXwfPBSTGT5qrnI9nJ2F+9clP70NUaV7kKiP1FbpTWS4GlUdFB+8egGTm7Tny+3zQkpkl+HKfXKRAhpd/zA5aWdE+M43CfWfgdBZl3bg6laBqr9uwLemUs5jFk7SWUStCj7dgsz4QLA9kqOgYI37NFIX9AtZuEzkQQEZJ4qOKXewxlQAdxrr/i21nLxDpxDIAmYSf2qITTdoYFheBBQlwRZKVDeeChk9ty5F02lh23T4N2taVWzPd9vBPH5bzrW2Fz/IFkK26RcZKFPTBClOQO25wsjJhvxZ8DQx1zyBXSfLazVuBaJJmwx
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(7916004)(39860400002)(376002)(366004)(346002)(136003)(396003)(451199021)(44832011)(6506007)(26005)(6512007)(9686003)(122000001)(86362001)(33716001)(4744005)(2906002)(186003)(5660300002)(82960400001)(316002)(8936002)(38070700005)(8676002)(41300700001)(64756008)(91956017)(6916009)(76116006)(66446008)(38100700002)(66556008)(66946007)(66476007)(54906003)(4326008)(71200400001)(478600001)(6486002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1xiJdcyO+bzwRJgA+zWOHf1xRhJFW7qHTqE4tUNBFfsZ7hv5X1czIJi1lcMl?=
 =?us-ascii?Q?dl4kkSNb4UvtsAbsiLFaSflTxDy3lC6SBCoOreOjKUHygFEKCo/fhmq3qexX?=
 =?us-ascii?Q?/IBrOegv0gvsrZ9nqxDDz526yeJhMEHhHU8qz+8cgIQ/Ac6wwUEfJo64vyds?=
 =?us-ascii?Q?xN/JpiY3Vyw4p+l48qf0aHMTnJhDVq7Zk98uie0FTp7cqTy5ognuoLkAI8mD?=
 =?us-ascii?Q?ARTb9l4wzh4EdhXxS7jOWIhoerXTsi2QipurLf5V8qrqGGs9FYyVkcMdLLI9?=
 =?us-ascii?Q?lCGBAAt+UihdeXt6ZcQ3CrC/Ox+Olwq2l9KmKqkYZBay/eA1ekDXEwdPMMl3?=
 =?us-ascii?Q?VpRUP3IVUq2lwRHD73vr75CeQgcvFk4uQMpGxOXq0i6TNlm3B7B5XF9nnNKc?=
 =?us-ascii?Q?neER9LOmGk99eiFP9WlC5s3s98NPCmtMsLKuXwxk2GirO51jKB4t8tjHMEai?=
 =?us-ascii?Q?1OtzF5jbSqM6wbcVp8WlhQ5ib4b/aqJwv0XaPAHFMGCmWyVOEb2Kat5ms9Dz?=
 =?us-ascii?Q?CTKJ3G6Ug67eZluwYlDpqMxlWTpWEInvHMuuyaHiBsEP2Xivi3EAZu2HA5s5?=
 =?us-ascii?Q?A2HNLneP89PriiXQewbgbEfly1yH0NPWA7OiPGnn4jZnY4BxEVKoWfoKRkEV?=
 =?us-ascii?Q?SMNAMGZMK5gIDAfW6OIoCc7FKq5XJj3WvK8yt9/W4lhnIbkpTKv9tnOQIQde?=
 =?us-ascii?Q?XHXnFSCUwlCSueOG2P1T/UyPOePWlg+YACuWYFyh+9MoTr/UYLqurkxRX1SG?=
 =?us-ascii?Q?9VB2iMUHoA1/5Wsx0KSF8QquyXJ7ilGYveyydujJ/TDDmGuUetcdPpyPZcxV?=
 =?us-ascii?Q?M+lX7f+9yu8IlIF4GgcJypixttGHCwA34uxKEZv/Kr8nQo2+tKOppy0DFub+?=
 =?us-ascii?Q?G5o2WHlcC5elzTyMW3sDm9xh8UhX6hIbABYJxIRQwrz9xF7GDelCxgv05WDv?=
 =?us-ascii?Q?PigaGyXGbBTS33wa1xBLt/visSpCB6gcllLtSsRJ/1TKBLIOmirIsQGqRKCe?=
 =?us-ascii?Q?l5RrWtRHiOWEQfmCTD6YjzS61NYQ/mg6D8vES8srwPcwiIj117DaAuQVBzxi?=
 =?us-ascii?Q?F7v1CS68pqJLVk583esWqPBWSwCZEa5NSPmuZi+WcYheb3n+iGVFTexfbeZk?=
 =?us-ascii?Q?Q1ndc1JZghKMX7LSTsSH5pAkCQLUf82DtqrjCPj0LIe4uhF/NRvPad/pn3Vx?=
 =?us-ascii?Q?01MHfX5cpPZQ7fpn4DQGH8Q29lbpmQ3UaxHR3mWh0aRwnbQtwGoXU+8RGtxp?=
 =?us-ascii?Q?WryL60/X2E1SDPn5K1LavdNxQWM+xBeitKgur0i9Z3A9EwW6FSR10BikRyIN?=
 =?us-ascii?Q?ceRslV7/PR4aSrklugid3o8QZXUUGk9Xr+sL4rXZbbt0wAXKGAzGY9u+1w1H?=
 =?us-ascii?Q?soSVm0/SRjB68vImqz3cyLcCEGDBSzESkfXvwdfZBbdzbbb5VdHWxg6SYZcV?=
 =?us-ascii?Q?S6tApUCCv4lL3huQN5darNyVBIueKzqlBXXGW09CVbu0+MBvKRquuxIgozP9?=
 =?us-ascii?Q?X80vL8qQ8x+5pdNO1sX8Rz237vs37SL4Io8CAI23cxxOyNM/SGgh95Qp7QiA?=
 =?us-ascii?Q?RWL78dzMsGlzTK88JnVh4OxwsTpBq2jBT8MkThTs/Lq5JYM9JwRkZpIm2x6d?=
 =?us-ascii?Q?qvc0y70jarGlLRRNmhPv6sU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <18B5DA186D51FD40BBB7B5DE63808793@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?Te7RJxnoR6r5layxDh3fA2MZwTeHU8EvL4EFnsQ2fpuJcenPnC3yFsYCxCPf?=
 =?us-ascii?Q?q97jCAindyvVHYz7MRAUHKstvf9DorXxHPcVxq9ck7dOC+CuRBrbcb+8AikT?=
 =?us-ascii?Q?noVKsrUsyNDZKZeZIJMdmIQc8Gg5/1fc2KeJqfOIluWTnSpVAaEVezRMmOzJ?=
 =?us-ascii?Q?8zuka2vllHDSVPcv+1rzbbbD6cfAGnk+qn1Sorq656FM/vj96wMzQHuVY34C?=
 =?us-ascii?Q?V0ks3swOb0ilbyThGPMkuN1FxYRRoUcHzi7/MIj4xQez7bOMbLjWL5kZJMJl?=
 =?us-ascii?Q?q8hkRkKaptxcPaKqNEVTLhHBnDuCOupn4DLVoem/CJXU1+6zykCqLWtRMGoQ?=
 =?us-ascii?Q?kAZ3joM3JrS2/vZyoYJANkqB4cTiu2WD3P1BAQ6b97dL9rqlbc8FPz5Hlv78?=
 =?us-ascii?Q?y5nDto/FYZRbTHlK1fZ5wdF9DYkg9g54l+kN64yy097A+COh/fytImFtUvQh?=
 =?us-ascii?Q?BfDx0LJQD+hB7Oega08gEhGeEsdrqmd3HsRsn0LfrJoTob61gmcyIETtDXxR?=
 =?us-ascii?Q?tThTLmE3yDTx7yIuQny1V8oasLdu0t+GeFG+QA3DKOgnJZRplBFZHMvnebpU?=
 =?us-ascii?Q?9AQocS6fPu4aKCKSo6NUzlLHO6l2NPNha9IYW6POiIJXBaO6jpDTi5eBkhix?=
 =?us-ascii?Q?wmYoMoXAZx9WuAQXPC02Rsl2SZnWyGmsmU+y/tEIi6ZbUiBKH1TYCtw4UTBF?=
 =?us-ascii?Q?k1od3JSYz58rreIFOXQYGo3kLqi5/B06/SXvBAlXOIJxeWWG22E6kacdrrav?=
 =?us-ascii?Q?MpBsPei0d/oMqbHaVS4VyMMDgZEHl8SLz4Mr3V06/tkgEH4jIVcO81AGykLe?=
 =?us-ascii?Q?KJsL+7fIKDJWPvdxge/GqGjRulQesPHgOxhaGNmrw+KgI/BO/yvZ7tQGE5rF?=
 =?us-ascii?Q?zow7/Z7gQX9SlGReBczPFbt8/GSKJA0Og9KMIHu21/ZBgLKkf3Wm2NGXIpqM?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14bafdfd-b44e-4229-7dba-08db664e493a
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2023 05:24:22.5094
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p4eFUAi6X5LJDbNyYs5UL+LvFDO++YMnILovg39hjxkuD4M5PwvDFPIT+U2dqMYSZpt86zA5odxts027nd3HIG3zjGGGNO1vkVqzj5k9jeo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6279
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 01, 2023 / 11:01, Daniel Wagner wrote:
> These patches are necessary to get to get the FC transport off the ground=
. At
> least with those applied, blktests should be in shape and only the kernel=
 part
> needs to be addressed from then one.

Sorry, I missed this v3 post. I've just applied them. Thanks!
