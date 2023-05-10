Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FE626FD61E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 07:21:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235624AbjEJFVs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 01:21:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjEJFVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 01:21:44 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86D842716;
        Tue,  9 May 2023 22:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1683696099; x=1715232099;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=YCjEIZ00O0zpTCBguK7sESmEcUkiAfMFQ6A1i/nNrfg=;
  b=SzBJU26WEl2AaBDH7OdtVfcxUfvTwWm1AllCCPgK8t7CO90yO4KLpcv2
   eW4O9Y5phiWTp7ptMviXNxc/cMhy8jrjVL9m+752SU7Iz47LY3ByDn0Qm
   Rd1/OrlCx2Wqyv8v+gvhmtKZewQ8vpv565m9jefv5vcB0+7Mp22Yqq7zt
   K0YXnsYKwdRsf+A7ncrjbzD5NmgEEwS2j/ajuypXf78040wlO//AQTSLN
   ZSoaQMJZNtyfmbXKUAI8DG2rI0Tm+EmDmRpWrq5VeH1twCqJZ2yl3hzwi
   yHlbXrZC2trMlemDtu7ldrIcxMfEp0du3O8RNLjtSDdDskI8x0Chf+7gx
   Q==;
X-IronPort-AV: E=Sophos;i="5.99,263,1677513600"; 
   d="scan'208";a="235298589"
Received: from mail-bn8nam11lp2168.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.168])
  by ob1.hgst.iphmx.com with ESMTP; 10 May 2023 13:21:37 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fezFTNn1K6DrsPUbMeI2nwizEiQgBnBZ+PmU1qBXHTnLiNAETYsly8pCGK3AiK7wfOV1RNd1kzaH4zlknvID360pTzL0CIKlk5IHXQjuQ3eX8VyJz0TSNQ9BjsihIDvFnlULJNjlg5Rf+p5wfLIAemeRxymM3ErGSU4ybgihWMyH7Lv0QrgQBWVLZFmQCG7rYf3TffvQzIBMf4jxNBXWpkjvfatJCBnGF+hTssbjK3OiG/JKTQkb3wUU6HJ58Y1Hgt3yo/4wwLLhfavW7TrVmMY+MPdRgQNnuNtaqCfrKTJ0I/gWfGHgVPiBl/vInscJh5G5MatIUOGQ8DVQRYwj+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YCjEIZ00O0zpTCBguK7sESmEcUkiAfMFQ6A1i/nNrfg=;
 b=ZUO441Rn3RJNWxFt9U4siQPQpPdRbDxH4WVAxVlF2sF4tvf9a1ScVN6JHtbVc3ED60ZPtZkaYDg8YhoWmYAwIXfupEj9PkH/SuGWwmRgfKi6sLPDKtM8T46eblEyDr9uRv6oypRbr3pfOEAfHvSiWvU0IE+0INHsGtL/yKfgAKwaJBb5F+JXZ3zC3GpaOjwcghiZaSZHZ9V5M8GP4epTQE+fM6izB0sidf1C6YxfnnKEFZCGWnKwfb19+Ti17F23AEwyxNR1/QaKtkdqMfYlCTIyULxCbfL5CtDVQQIX4u5oVqni0oidYz26lrcyYob7FTTTv42v9Djb7SQH1HlnTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YCjEIZ00O0zpTCBguK7sESmEcUkiAfMFQ6A1i/nNrfg=;
 b=fX9HDxjx4nS7gaIK6j7xAqLOjaLaVPL2dEXCuzAgJv3bEU6vuenyIApzX9AgQOpJKR1cg3xfcaPyqXHOwTAfR73t3WXoY/5UE/AEtplPyquL7nb8SVKKTcFBdZRGGuKkOanOxMlS3SNc+NsPsko+skIENhOVWWnjZNyz8GHLtyg=
Received: from BL0PR04MB6564.namprd04.prod.outlook.com (2603:10b6:208:17d::11)
 by SN7PR04MB8768.namprd04.prod.outlook.com (2603:10b6:806:2e4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Wed, 10 May
 2023 05:21:35 +0000
Received: from BL0PR04MB6564.namprd04.prod.outlook.com
 ([fe80::d80a:f0c:f3ed:a5a7]) by BL0PR04MB6564.namprd04.prod.outlook.com
 ([fe80::d80a:f0c:f3ed:a5a7%3]) with mapi id 15.20.6363.033; Wed, 10 May 2023
 05:21:35 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>,
        Ed Tsai <ed.tsai@mediatek.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "stanley.chu@mediatek.com" <stanley.chu@mediatek.com>,
        "peter.wang@mediatek.com" <peter.wang@mediatek.com>,
        "chun-hung.wu@mediatek.com" <chun-hung.wu@mediatek.com>,
        "alice.chao@mediatek.com" <alice.chao@mediatek.com>,
        "powen.kao@mediatek.com" <powen.kao@mediatek.com>,
        "naomi.chu@mediatek.com" <naomi.chu@mediatek.com>,
        "wsd_upstream@mediatek.com" <wsd_upstream@mediatek.com>
Subject: RE: [PATCH 2/2] ufs: don't use the fair tag sharings
Thread-Topic: [PATCH 2/2] ufs: don't use the fair tag sharings
Thread-Index: AQHZgkMMEfz/mkmxPE2tTXnep9Miz69RlGFwgABlVACAACPsMIAABRyAgADUEGA=
Date:   Wed, 10 May 2023 05:21:35 +0000
Message-ID: <BL0PR04MB6564242D93EE6826CF1F6747FC779@BL0PR04MB6564.namprd04.prod.outlook.com>
References: <20230509065230.32552-1-ed.tsai@mediatek.com>
 <20230509065230.32552-3-ed.tsai@mediatek.com>
 <DM6PR04MB6575753742F933DE192E7325FC769@DM6PR04MB6575.namprd04.prod.outlook.com>
 <dcfae203-005f-928b-37d6-7ee5bb4e2971@acm.org>
 <DM6PR04MB6575F344EF2D962103888A56FC769@DM6PR04MB6575.namprd04.prod.outlook.com>
 <6192fa07-ec6f-0464-deb6-c3e9f69f6ebf@acm.org>
In-Reply-To: <6192fa07-ec6f-0464-deb6-c3e9f69f6ebf@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR04MB6564:EE_|SN7PR04MB8768:EE_
x-ms-office365-filtering-correlation-id: 62435ed2-0292-4e47-7edf-08db51166c5a
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: l6ngE7wA6OzkSSvOnL70j9ASfE4eaX41WokI08v6TlRx11AVij2xXHOKB5LnMWtCJ8EqBM/mK8K1fji+E8/8Jx21EjkY5fLzqbBCCdwh6OG2iQ//3GjZOQnIKGDYl6h/faljALG7gZMro5RCxyF2UI4iP/yXdSS03Tyqj82Jui0CgTQOQKlI9/d20kBxI5HD/SbijFPO10zSutASq4pWWTMstU9L3pyT7YjnD4k8KiKNg9aVFrd5E7Wta/9yKBgwTF4lZDm6fCTfnt8ceZftOzrfSgWp7/QtAJJoXgpk1aAG2LRX0OnxcCofsIMs7lRNu/F6/K5fTjfAQm4Hn4uXU/Rj9IasnuZ18qEfjplI0z9NcpMKLmD51ghf1FGJnlmW35QAgHvUl2BSenicNaDu2EYGBLQ/nsD2tBavoC0muIhn7d45+JjHLynCpi+TC2AZOkIOzrAwqlP1dsPhVpBsFRdfZhw3cbu3xx3Zu9S8WFpVBCMwiHfbeKQs9mHS7yAoDBEDD8Puwp2mScVeTBcExfkrsETZJsW+65OZphZEoa9cFLN4tJvsJNTRZfLQ23l2A+Tl6ZUp78NNY3/aKuR6jg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR04MB6564.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(396003)(39860400002)(376002)(366004)(451199021)(82960400001)(55016003)(122000001)(38100700002)(54906003)(33656002)(86362001)(38070700005)(7696005)(8936002)(52536014)(110136005)(8676002)(4326008)(76116006)(7416002)(966005)(5660300002)(66946007)(2906002)(9686003)(6506007)(53546011)(186003)(83380400001)(26005)(64756008)(316002)(66476007)(66446008)(41300700001)(66556008)(71200400001)(478600001)(4744005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Wmp0SmtSTkgyZzBxUjkrOEQ0NW1LLzVSamlTbUlGVE9vK085RThJUW9xc1Ez?=
 =?utf-8?B?ZTE0UUpSejdGRDhRYWxDc3Q3MkM4emtjQzZtTXM5TDJVcXMwNWczRnhLa0pH?=
 =?utf-8?B?MjU4d0lwamtJTk8zQUVtVXhTTXRERzl5cjFFREhOajllc3JVQWdUMTJhZXdo?=
 =?utf-8?B?MHppV3FZYmNMK3FsdXYxQXNWMDhZc3A5VXZFRkxpa1orRGl0L3F5Zmc1SUNT?=
 =?utf-8?B?V2lOQWV5bVNpMFoxZ1RIWU95RFVxOExNUmVWbGN2OExnMlgyN0JxN2pWZm9B?=
 =?utf-8?B?L1EyaUlkcFBIVUhlVEdQZnNvQy9HUjZIb0Nhb09vb2Jhd1pIOW5NYU80emVz?=
 =?utf-8?B?VElvTzJZOFNEYklSZVhoQzFhd1N1NmJFYzluVzd5Yi9zNWxIQWpCekhyTlVl?=
 =?utf-8?B?Qi9rVnVJSU1vcGdwcE5BNWZKaHYzTTN5ZEtJMktiYW9MUVNHOU1rVmI3NTV5?=
 =?utf-8?B?V3hwVnFDNGRneHp2QUNwNTQwR2I4Y2o3cW5xRzhVQXg2dGJKejFTYld3eHpF?=
 =?utf-8?B?Y3JDbDVLQUpNQ0VwQ0tFYWpPNXVKNWd0ZThFOFVrMjRFbUhYMFRlWVlXZzY3?=
 =?utf-8?B?NDJBdStZM3QwWG13ejBkUFZ5SHQxNHBmNmx0RGFUMkZoQzhoUEtpTk9ZaVI4?=
 =?utf-8?B?UWoxNnAvSTYwclI2MDFaMkNyeUx3cWlrdGFlZCs0eSttUml2M3JSV3ZzSk1v?=
 =?utf-8?B?cWF1RG5Nbm9jZGo0VlNhOWlGQm5kN0E5Q2psSkdsMGJKaHJBS3kyeXRzNEVI?=
 =?utf-8?B?Um45cFFKc3p0MlVEWHpTOHlOQ3BOQnZnWmVHc3MyQ3VkcysyZGNyMGdEMEpT?=
 =?utf-8?B?N0hjTlQ3K1B1amNHT293RUhwOUJOTnQ1STlWQkdlYVVlNjl1OU13YktSQW9V?=
 =?utf-8?B?OWdtWGloSS9ZeEJ1NkJxSVRCaDlyN2h4c1lnaEY1U2t4aC9EQWdIOGJYamUx?=
 =?utf-8?B?ZHJsajN5OXNXNmVkOCtOZ245T2JyMldCc1pBM1lDSHhMSFM2N25aV1hweEx4?=
 =?utf-8?B?cWJBbytJZGpXelRUZ2FyUmxlcWtEUEVTMkU2ZDFtYzdvbVdQSW5hR1REQi9Q?=
 =?utf-8?B?Z3FwTTFtOFhJS3Azd1lhRDRoWHk4UUFTOThDRTA3Z1RQa0NaUUZiOXFCS2gv?=
 =?utf-8?B?NisyaXNiWDgvbjZnaHc0RldKT0lldWlNSSt1a3ZTZ0tueE5QYkxmUHpHZHNT?=
 =?utf-8?B?RUpIeXZrOTEzbWZoaktjQWlwb2ZIUFpod201VjdBZlZOS0pvblNkWkQ1Tmxt?=
 =?utf-8?B?V0JaNFpWbS9SUGNpdzBHZjhXSkFnQ2dUS2I3a243djJ4aHVORndVRDFJdEpu?=
 =?utf-8?B?TXU2bWo3S2QrSjVOeTJ6bHRhNzRWWFlEMlJUTjgwSGVWR2tNeVYwVXhHakRK?=
 =?utf-8?B?L1pkc0hUWUYzNDF1VlczeEtpQTZqVy9uT21uRGp5R2JsM3N4L0hFSThPaDBx?=
 =?utf-8?B?Z2x1aklXZ1F0aHF2NHYyYWhzQ2dSWkV6M2w0MnhWY3cxWDNDWUlldlNBVWlN?=
 =?utf-8?B?eEpnMlVUWVpRSkhza3pROHZQNWpyZE5JOUZvUVlqT2hnZC82SEhYQVJpK0tP?=
 =?utf-8?B?MHRlSFgwNDRwYkwzSjdCd1VLKzAvbUtmVzRuNTBtc2pGR2Z1cUxVaktRNmYw?=
 =?utf-8?B?Wkl2RDRmR3o5U3RDaW1xYUI2MFVzaGVkaU5ubFRqZ2VYMitiR1pzUHJCVm04?=
 =?utf-8?B?L0JaVWNlZUk1TDVSOG53STc3dTNQdjlKUHNqTEl6d1ZkY3NGT1BqMFp3b2ZX?=
 =?utf-8?B?RDZYWFc3T1U1Lzl6ZnZEZ1Ribys5alJ4SU9xN0xLWlAzMk52UTIyQXNhdURD?=
 =?utf-8?B?RWNUdEs2U3lTRDNBbHl6UXk4K3Mvb3E2T0o0L3N6bkRySWIvTGNqZXI1TEpY?=
 =?utf-8?B?cXl2UTJhRGZtSFJLalpZNk56OG1nV3RRYWdLRzRoVVVlZE9KcGx0UEd3SGZ2?=
 =?utf-8?B?K1NDd0pjdVNvVm1TZzJUV0hvRGE4Uk5WYlF3SmVXY3U2bkczcVZERWdXL1pv?=
 =?utf-8?B?MU16U09qd2t4MFBaK3JlOEFWVTIxdS9qN0gyN1ZwVEwzZ3krWEw2ckM5ZEF0?=
 =?utf-8?B?SHV3MDRBZHVWZ3N2NjFRMTgwS2FQbDc4L3M1OVVoYVZIclpwY0h1ZHE3ajZn?=
 =?utf-8?Q?RppFa/NuSIHEBUrU1xPiwcKh8?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: JKCYqTF9zzFf3eo3b4j7yTI4kL27A/FoI+asHneTLxD48c4JoIfI+dL/ZXskJSB16xnilwW5BYUYKuSgu7sCVSBcjV2Ov0eAHP7XhWO292LP6TuahTWrvCRuCZ0vMjvfbYp4r0Xh/C5gwNmtU7JQn7yUo/tiCuniD9VxcZhoPp75DbBwLr2BO0c8wbSPceLb0RZGPrzIsVdkrGd5Ur++Vt/AJfzdX92FR2nBx06qFpj4k/JqL7gG/2Sxy5zCRT2OC/6V6K3g5VevDWJX2lF3dlyjuWssnwNkOtQbtv+qA2GiZCZdlCXOxMN9FQGeFSARp/s/Jvj3h4Nh4NOHeJ2bx2ELBG+pyGreAOH1zByGPOuCo1Cop2CcGXTYbYVvdJmzz/F9kZiuqS+dYVAdx4K9zTzGcP9dhwKBkxvPRHxFU/mIno417GE49MFxRk5rg6QfGbZycWfaeEv+4ibSz47ToogbRr5M59LvVm5eCsDbF30mq8RO7NfWr6+EcOQJZ1aAmH4pJcejRFWO50kfPWD+ZdtZgHC0CCgloAAJukA6i2+pEl8WQ0G2WWOxqHgdl/ax5y61cn1XA+WUG/YECIHKIDirG+CWksiweyTwovRnvYbkKN3iLKQbRclCX8pZXCij2lQCRp3UiK08cfTQi2INMfSz4UuC2RGG8SPAobGh7TmZdnK58dMfr4O7Pwru08HcYW1ZLN8wxIatAbzenRBK0+Z6G2dFx9JroqBczzGoxOmvyxH0pAlXOR5xrSj6+VWJXuA+my4zGYhCX75uA8btgCH5S8h8VfG5j/XJCfmAMIJvcXzfRh17EIEhA2K6sdTTMoO55bG0IIYWyJabK+k5qVzCpsUSRKQtqmPfi1ux1mZD3wJVR2eKXPKZsN9Gdr5WhgrIq3KM4+ArkL2W9h98+g==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB6564.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62435ed2-0292-4e47-7edf-08db51166c5a
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2023 05:21:35.2019
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w3ZSgQzQBOXDSLi2wbzj1QQPHEyiJDopY2PuIuMKnGtBnUCeb+2oTcPYjvz+QTomM1Rm4vbF/BCcDnDLH8wTFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR04MB8768
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiANCj4gT24gNS85LzIzIDA5OjE5LCBBdnJpIEFsdG1hbiB3cm90ZToNCj4gPiBGb2xsb3dpbmcg
eW91ciBhcmd1bWVudCwgdGhlbiB3aHkgZmFpciBhbGxvY2F0aW9uIGV4aXN0cyBpbiB0aGUgZmly
c3QgcGxhY2U/DQo+IA0KPiBEb2VzIHRoaXMgcGF0Y2ggYW5zd2VyIHlvdXIgcXVlc3Rpb24/DQo+
IA0KPiBbUEFUQ0ggdjJdIGJsb2NrOiBJbXByb3ZlIHNoYXJlZCB0YWcgc2V0IHBlcmZvcm1hbmNl
DQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LWJsb2NrLzIwMjMwMTAzMTk1MzM3LjE1
ODYyNS0xLQ0KPiBidmFuYXNzY2hlQGFjbS5vcmcvDQpPSy4NCg0KV2h5IGl0IHdhcyBuZWVkZWQg
dG8gaW52ZW50IGEgbmV3IGZsYWcgaW5zdGVhZCBvZiAganVzdCBjbGVhciBCTEtfTVFfRl9UQUdf
UVVFVUVfU0hBUkVEPw0KDQpUaGFua3MsDQpBdnJpDQoNCj4gDQo+IFRoYW5rcywNCj4gDQo+IEJh
cnQuDQoNCg==
