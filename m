Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F18866CD2DF
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 09:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbjC2HXt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 03:23:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbjC2HXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 03:23:39 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2060.outbound.protection.outlook.com [40.107.223.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 373C33C32
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 00:23:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S+kDgn0xqsPCrbNgOtfQTvgH2VBQiMsjjbxAI6w1uHA4Z8FMd2iyycsrmk6Llyegwm/t8KfaTlu5bJaN7BMtYH2gLzxJprpbRIhHvLy9soxdMZA/pQ79nfeEUCwUtJ5P6Mqr5TfFqRr5xZZbn9zhSe10Z2lrJXI4sa0AzvxXixglotvyHdR427kXiVRgfrJtvUrjRadQ5rkt3aeNWTufOPGPvu6Kfep7E6qdDm1N4FVzTGabnVLS1w6SgKQwjHn4s93xd4AVlf6W9XzdtUZ9NFNqlBAvIvKGU70YwZC8n4Bl9Y8bBRso1ZxH+Fl3DZrFqChKLXD6OWhF5/3dyNpUWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wpXR4q7quq8TmpS5/Cf0tdhC/3X/2DjSAKBVYg6H2hc=;
 b=lUNKfyW+ETfXahH6FVcKtGOPf9wtNQ9/umJo4BZDHycrinnyJPmNGwAIHLBmErM51K1Bv0OycN/19a9xATVgEku/+cr8Wc0Z9QdXE+lf6WJETbKCUeJEZImIiWAeLHCBEwIrwf+V//1JHSbSoVWX79+VAq6WP0YCdq3jYEw5uQZp0SdqQ0ePWr7uVPendeE0Rhl1VfFYNs1abgYSPIeCWfhDi9wDi1f6cV2Y73jvZh1rM7MU6UVuWc5P4jtGIEVBeorW3hZLfS5J+7D6P2TLzGWcXANh4N8+ECzks30/tPWBP995fPPPdCu9km5IvyOVA1fPKynLR/ATzFr6Lfr8Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wpXR4q7quq8TmpS5/Cf0tdhC/3X/2DjSAKBVYg6H2hc=;
 b=D42Xhq6jY+wFaqFHCmG3nDyNK7ONQ8uU4zLAtTiSyU8XX4JOlkhKwYiFK0OUotxzZZkbyYsthWcuXpKwpNzoNjUT7QiltyqLlYqJ8zC0YJb0/DfP4asbrgpBrCW2+K6MdL68dlIud54b8xrjJ7D6iQK0QQLGvZmR2GHL48JD5ZA=
Received: from BYAPR12MB3527.namprd12.prod.outlook.com (2603:10b6:a03:13c::12)
 by IA0PR12MB8975.namprd12.prod.outlook.com (2603:10b6:208:48f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Wed, 29 Mar
 2023 07:23:30 +0000
Received: from BYAPR12MB3527.namprd12.prod.outlook.com
 ([fe80::1cfe:18af:21d3:923a]) by BYAPR12MB3527.namprd12.prod.outlook.com
 ([fe80::1cfe:18af:21d3:923a%7]) with mapi id 15.20.6178.038; Wed, 29 Mar 2023
 07:23:29 +0000
From:   "Yang, WenYou" <WenYou.Yang@amd.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        "Quan, Evan" <Evan.Quan@amd.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "bp@suse.de" <bp@suse.de>,
        "jpoimboe@kernel.org" <jpoimboe@kernel.org>,
        "Phillips, Kim" <kim.phillips@amd.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "Yuan, Perry" <Perry.Yuan@amd.com>,
        "Liang, Richard qi" <Richardqi.Liang@amd.com>,
        "Li, Ying" <YING.LI@amd.com>, "Liu, Kun" <Kun.Liu2@amd.com>,
        "gpiccoli@igalia.com" <gpiccoli@igalia.com>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 1/2] cpu/smt: add a notifier to notify the SMT changes
Thread-Topic: [PATCH v3 1/2] cpu/smt: add a notifier to notify the SMT changes
Thread-Index: AQHZYeESu1Z/BgjKTUGFWIVG6kMXya8RV0EAgAAB2QA=
Date:   Wed, 29 Mar 2023 07:23:29 +0000
Message-ID: <BYAPR12MB352749E2864A87C3C32B7D0FFD899@BYAPR12MB3527.namprd12.prod.outlook.com>
References: <20230329015149.870132-1-WenYou.Yang@amd.com>
 <20230329015149.870132-2-WenYou.Yang@amd.com>
 <20230329071014.GC7701@hirez.programming.kicks-ass.net>
In-Reply-To: <20230329071014.GC7701@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-03-29T07:23:25Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=7a527b93-5dc7-46bd-93f4-3ec83c984a16;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB3527:EE_|IA0PR12MB8975:EE_
x-ms-office365-filtering-correlation-id: 372c7e14-0a60-4cb7-8dd9-08db30267e9f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Hx7Cz8NCZl+J2Uj32o7siu/Z7gRSgv/IuMXoxrhVOTv0TaDk4SPbAiys/IrOm/+45LmIktWJ7i9f765YcncGZNOSvCWPZnV7uAlVm/0BzDbVBdzu+yVWcnpmZ2AP0MNQUddHV+z6v9oo/zUvVyUTLbHArEe1CyUuU9uHX8FVn10EwxDyne5UEGX5zrQTxXRqlP0JSjb8hnDkhUyzj2VEPQixIPYBw3DVWa7zNmjJTBhv1B1I/AJgMgzdwNjfYaoM1sSE10GB8c22oLdt6xDW7/wMKsUNQTlLs4ZWJ150ZNzC4zIDzGRUGHqCyCVfUCF48+uTRM7DZRfeS6lwSkPIaZzmgGFZLDjISR3rO+ISA0ubb1SAhC+9PG7d80GTIpMn7K/No2zL1oJBg5lkPCqBYeHJ96MdCYncr1dBJ8wwW+iqGr6a9ak7xe3GBqGBJ+pDdgfzreYO4lzCD1x0xQNKawHS6vjtRtiaRk9MS5D4CbNy5oloiJJsGmDC1X8yRCNq+UmgifGzITkY2TJqJk+widhWg6/vVTQB40B2m0HIhwZF/eMzO3rSP2tmtcMKM97l5VR1H3+FrH5YooWql9ZaC/XvoUQoZn4Smb7IxAGTff/lSqXoOS6KB/H2sB2zcDW7
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3527.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(366004)(346002)(396003)(39860400002)(451199021)(71200400001)(478600001)(33656002)(83380400001)(186003)(53546011)(9686003)(55016003)(38100700002)(38070700005)(86362001)(122000001)(7696005)(26005)(6506007)(8676002)(76116006)(66446008)(66556008)(64756008)(6916009)(4326008)(66946007)(66476007)(8936002)(52536014)(2906002)(41300700001)(54906003)(316002)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WKSbHHQOTz43VF9noUcUyhFyV+ApeDs1m1xL+teHsyFofzCs0Cch4ET6wVNI?=
 =?us-ascii?Q?lyycfv0ofc0RwnwBDKIOj6nB4bV7Oqwj+K8isDL2Mh3N48hVyy1GK3ynYm8G?=
 =?us-ascii?Q?cF8BMUwHFP8leMeiFpxsKHHJP83DxDLndbtveffgX8y2TmZ93w20hjtftHsb?=
 =?us-ascii?Q?oTxTZ/59fWWYt/SutbLLRydFNauHfLdjbazdXC2t8s9E2/OfHWeVwWTH2X1A?=
 =?us-ascii?Q?0As6QC11WYZ/httqsCKPhwi5vex7jTqRrxU9GWDSa0Fw20UGJ/G/MGTEBc71?=
 =?us-ascii?Q?cXk5+iTtWEbn37ajfB14VKyhjBBBXFe8JHTI6QfrUj8y3srMkdGb6Dey4UfD?=
 =?us-ascii?Q?FlXIlmzNYZqKqisaIETlHzedCcB2qwLX9ZwJ3oj/bOpq8kGIpXr9z3WXt7hB?=
 =?us-ascii?Q?YQQ17SO6EdgS83pDJXOVwSkntWsHyOKGE605YeOp3gFe/VlrJHg7LLxVwTnB?=
 =?us-ascii?Q?SQeagLzmAZcDGuSVgkpSXN4zlmFsHCL1Sm1OuhB431SVQBRB5QU1vLdiJXGK?=
 =?us-ascii?Q?c07YseGnjtSNscuc+sKNlZErfQjQuP1nQGzssap9rhnhQ9zG1dzIkY+kzUas?=
 =?us-ascii?Q?GtoFhxYooy/z9HHSIV5yL+DYzGcMsW5x7RLx24ZeafDvWI4nefQZ+bi+sebU?=
 =?us-ascii?Q?DDKYJSbAcncfBwZyq4ROrA+6uj3MK2GxVXp5zlVX7hhEphSM9xqcxAsJFLDu?=
 =?us-ascii?Q?BYUhPPG3p3eYwAaDPkcsbz0eOVzv1g4V/mLLPhruQBoZrt5pFZINxu94z8d0?=
 =?us-ascii?Q?V9SzlrXnnFjriQ8DkY0wQ21gtYb/Jq7bKlVgyfyI+yRnBJrCAiSKa1MsjeTO?=
 =?us-ascii?Q?j1v7UvrYcmvB835iaBQGbpQ9n9pw2BgZDcQbKez8qp1KxQFT5O6bhkoCZe2x?=
 =?us-ascii?Q?710ay9aiCak2Bqx5YrTsrtL3NXWORr+lGkab7O8OURdx1Hn3YEawuWcidr3b?=
 =?us-ascii?Q?ePAPHTsJhAVvqWWaSTQ2T5hpTJMt1471V0qBQcCsVoAtu6cUwfcCZiVACgZs?=
 =?us-ascii?Q?z36jXH4mqVfhZoPRaDWGV6z+3o6X9bpmqajfFfp8840ymiTK50WIqY94HYcl?=
 =?us-ascii?Q?ZfOOr4McNqk+A7nNYHB5zz5pvKC/tFAdPQa93Eg8b6qGTlyU/RROKtILSDwR?=
 =?us-ascii?Q?4sMwXgo/JdyjJ6wrqYLAlFZVRfUTyB0pUKVhlu3eKISl4eNd/koewwelDYUK?=
 =?us-ascii?Q?8XKlMIQkYmAijZrqSaKfhE4Zb1VCTnFYqhIC0ALz9frAJ0IwlF4xwVlpJjST?=
 =?us-ascii?Q?BX8l/2xcW/2SCCC7J5c3WK3WuiMmZ17qnKrt+UxQFgk06Hn6Ykq49n80BG5A?=
 =?us-ascii?Q?XNw5bbNB2fdO/16GRPt0V2USWy0K6/cfhf+W3ijhv9w6K3Ri06HknPevX6Iy?=
 =?us-ascii?Q?vEg4C8YbttLrKA7ZhlT4RNDoQC9+pnobV6dTIclCWDRt5pPaiWGhXL5votp9?=
 =?us-ascii?Q?HMBTt+PCl9gn0Iy0rtfJGO8GsPuKlhXJv2IrZ1aNqeTcKlgmfkGpeatesKls?=
 =?us-ascii?Q?xFfos74Gf2v2/Ff5OlLpzd+DM9VSGhmwHNjvLo0PqdHoyCIpOH5ne3ACzAIy?=
 =?us-ascii?Q?seQkzGyyeOOrCYnBzwY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3527.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 372c7e14-0a60-4cb7-8dd9-08db30267e9f
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2023 07:23:29.3708
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BQKBWgxU4ATkMtJRMLmZ+eh5Wb9DRtyVJRsug49P5wFGwS4oBPVuXu5N0WDO4uG2jNvAs+xO0LAYDtpPwcYJ4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8975
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[AMD Official Use Only - General]

Hi Peter,

Thank you for your review.

The purpose of the patch set is to improve the performance when playing gam=
e for some AMD APUs with SMT enabled/disabled.

When change the SMT state on the fly through " echo on/off > /sys/devices/s=
ystem/cpu/smt/control", the kernel needs to send a message to notify PMFW t=
o adjust a variable's value, which impacts the performance.

Best Regards,
Wenyou

> -----Original Message-----
> From: Peter Zijlstra <peterz@infradead.org>
> Sent: Wednesday, March 29, 2023 3:10 PM
> To: Yang, WenYou <WenYou.Yang@amd.com>
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Pan, Xinhui <Xinhui.Pan@amd.com>; Quan, Evan
> <Evan.Quan@amd.com>; Limonciello, Mario <Mario.Limonciello@amd.com>;
> bp@suse.de; jpoimboe@kernel.org; Phillips, Kim <kim.phillips@amd.com>;
> tglx@linutronix.de; Yuan, Perry <Perry.Yuan@amd.com>; Liang, Richard qi
> <Richardqi.Liang@amd.com>; Li, Ying <YING.LI@amd.com>; Liu, Kun
> <Kun.Liu2@amd.com>; gpiccoli@igalia.com; amd-gfx@lists.freedesktop.org;
> linux-kernel@vger.kernel.org
> Subject: Re: [PATCH v3 1/2] cpu/smt: add a notifier to notify the SMT cha=
nges
>=20
> Caution: This message originated from an External Source. Use proper caut=
ion
> when opening attachments, clicking links, or responding.
>=20
>=20
> On Wed, Mar 29, 2023 at 09:51:48AM +0800, Wenyou Yang wrote:
> > Add the notifier chain to notify the cpu SMT status changes
> >
>=20
> Why!?!? What's the purpose of all this? IIRC this doesn't trigger if you =
manually
> disable all the siblings. And because you didn't tell us why you need thi=
s I can't
> tell you if that matters or not :/
