Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E17870635E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 10:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbjEQIzj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 04:55:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjEQIzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 04:55:37 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on20610.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8a::610])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B62C630E4;
        Wed, 17 May 2023 01:55:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=By4S/mIigmq7sq7VuvLSp1Fdb9nTgTIM12ewqEfMHLfOKikKvSmrxjnBTzXZ6b+NiQeqQQqykO96Th5PMVl01lOLhlwiqtOv+3h9+rEbRt47qZQ2IyaYR+A/C2tQURu9T8ozjNeXOei0jdwosUkRiDM0rNIPZEYDCUaQxloLjyxmhIU6m2eqzbmX1GyAcGYqRWQPa3ZNszjxFmF65lbTUdAiRnKgFnUqzizvN3zF9PXNxQmuiC54Ly0542tTH+Heq8/G3aHFHYy4/Y34+CKmjKewtt2Y7+qanp67AbkGN8B8DB5/apY4bg/Q2mSot7fSmak0nz3YPnsvBfprC+QOPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oj8LJd8ArN04PO1qVsHF1VBvxxV3CRREH93L/nViEv0=;
 b=ZQnFuzSHD39tPnRzMYEo12rP/tfiewnsx5+fLxTUTU6PyKRqJGY+PGb+KODPJpoNOY2lZMphB2VOMGJ46e4Bd3sMHGbBn3IIdkXJalwm/ooaMITFwTRi8Yd3+4/ePq2+iOxua4shQN59T3fqelKaHiH9+Os4ySVcpXUxKRvX+rmDpXvDkcpTZhsJkK2ZLErZKYcxt2N5zqYtKuEKeDUKNAj+ZsVM6qO1A2h/8UuzxHi4jYAk2sTOftzWxIEa1ZSPwsG4DUN78juZ98YQQD2d3rXgnadSAzUA7zIwu2hKbC1yRyb0GLZEfetGoobcAR1p4DDQfAn5aFpTcwSPWi67EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oj8LJd8ArN04PO1qVsHF1VBvxxV3CRREH93L/nViEv0=;
 b=aBNRq5xBK2SNITskCupnkdbwOwCioGPQP3Tvs/XMVD7Guq/RJww/YJnKiCLxo9yh3xhffBnIEJ6w/iDFkAvYDEUJI1gTcNnAJX62ODVF0Qkxi9KcqyTT/VL38DxROMvAi8EKVRNPYddlNy8jaeYgb8sTGwCJGWFFqWxh2Fkyx5tFu2LapC6yeD1ZGB/RIbNNBZcmIc9k5cm30WgDEBCFwEmZG1x6sYKm8hQ70uZby3gAyyb8+AihixT5cVHh+eygIzRBlzXslm2NsJ4vUOTUyJ7HABmBxMrPvAofrB0TnwHTIQjQdGuRepM0wqYLIfGDrf950kkOKEBwj+QejKsZOg==
Received: from BL0PR12MB4659.namprd12.prod.outlook.com (2603:10b6:207:1d::33)
 by CH3PR12MB8257.namprd12.prod.outlook.com (2603:10b6:610:121::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.32; Wed, 17 May
 2023 08:55:27 +0000
Received: from BL0PR12MB4659.namprd12.prod.outlook.com
 ([fe80::714c:2499:6bdb:6742]) by BL0PR12MB4659.namprd12.prod.outlook.com
 ([fe80::714c:2499:6bdb:6742%3]) with mapi id 15.20.6387.032; Wed, 17 May 2023
 08:55:27 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Pradeep P V K <quic_pragalla@quicinc.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH V1] block: Fix null pointer dereference issue on struct
 io_cq
Thread-Topic: [PATCH V1] block: Fix null pointer dereference issue on struct
 io_cq
Thread-Index: AQHZiJvgEGjFieX/20qi43z8nCiFM69eKW6A
Date:   Wed, 17 May 2023 08:55:27 +0000
Message-ID: <49056491-9773-df08-141f-ae19fe6c3358@nvidia.com>
References: <20230517084434.18932-1-quic_pragalla@quicinc.com>
In-Reply-To: <20230517084434.18932-1-quic_pragalla@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR12MB4659:EE_|CH3PR12MB8257:EE_
x-ms-office365-filtering-correlation-id: dd18b673-51fe-4994-a221-08db56b475cd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8Jj2H5R5tlvp6LVt2Bdplnlba4cTVNXe6t794HsJ+S/uSY5p1TfRUBohiRiOx+Bpnqk6jnJYFkHJfON33GEptJ6Djemtcq1ySC6gdaF2QawRwsjvao5gwemFqKt1fEqAU8l3rwTk8qOzStBZcNco/5BZocRoT8vj6aDIFvSk/bwnrHFm71xu0gaisGQUUedx5b+tU/KFQGOfQNiJrhHEczKIK5opQOz9CJhoE7oqhLerXVGPGAT7yXxH7zQNhb4W6OBzA5A2fHam+aUK2XwWXBHAgMzLqm2j3yhszRyStVdpduV6u4Qr8hopr24QF+0vwM/vICm5jv9SDL6e2lHXf81ObUCMHzmxoo7Xj3CznWbegAStLpsJESULeiWOwcMFv1/v/4uHwixdpSJ/X49g5eoCg0NloWUIIG1DNdrlCY/Sv8kci2jNH1xSmza0praDcs3XeWrfx0DEkT6eYM/uHQMb3xtk1vcj1RgssyUBc+OGjl1H2iwS9acR5eoDLlVpZlaKBl5I8xwzgAmog+8RP2B1RENhQakrHBbVroe5H+Qb/iePcXUQpP2vOYOnnTOkGswt2/HeiUm7IRtYuzBNQ15TKHIb3vWLwPMnYSxLbo9ifPYN/IHfCIEb4B992ojVYHJ8i3ZPdo7BjVoLFZCrKowmxqwSBvXfx5w/LZPzR/5dqYPg3akNWfwUDoWhXiBV
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(346002)(39860400002)(376002)(366004)(451199021)(31696002)(5660300002)(31686004)(66556008)(76116006)(66476007)(6916009)(64756008)(91956017)(66946007)(2906002)(41300700001)(316002)(38070700005)(86362001)(4326008)(66446008)(54906003)(8676002)(8936002)(478600001)(38100700002)(122000001)(71200400001)(6486002)(186003)(36756003)(6506007)(53546011)(6512007)(2616005)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N2J1OHNpY2lqVmRZU05zVnNVMVMzbC9XRFVBUmx3SU0xdW15TGdUMWRDVHhO?=
 =?utf-8?B?d1FjN0dYVG14WS9hL2xMMk95bWxrby9YUUFsS3VIWG91YmNMUnozdG1oRktj?=
 =?utf-8?B?YU9lVm9aNGpEWGlBazZXWTVNZGI0cGc1dnRJYUtZOFNBVktBS0RMSlFpSzQy?=
 =?utf-8?B?NmVHaFphc3Ric1pvMlo2Qi9KSXMvYzkyWE12VVB5a0NsZjVybVJBUnBuUlZQ?=
 =?utf-8?B?ZkFpTXphajBqenJpM0xBN1k4bE1nQXJUU0lqRm0zOGtyNTNJc3UwMVhYZWZR?=
 =?utf-8?B?MjZOMDJ3eTllSHRCRkJyVTVJYWdxSGVtY2xTS0liTTdKbVF4eHhzZjJQU0R0?=
 =?utf-8?B?V3dMU0tIMXFVb0xlK29rWkNycGpDb1dwVFBld0JRQ3NXMjA4NWZWa05CazEx?=
 =?utf-8?B?aURhd3ZUTWcva3ZVUUZUY2dLTEtkKy9tRW5CZUZsRzV1ajRXOXVid2IxRnNj?=
 =?utf-8?B?YUdUT0N3a0V6eG8rTWdja2UvbWZ0Q0dFOXowQXdnSDQ3a04za3Fja29CNEV5?=
 =?utf-8?B?SHIvRUN0UkVWWWVNemh6QTdUTmUrR3k5Y09lY21Fd3VyTXlZK2JQMzRSaVdB?=
 =?utf-8?B?K3Vwa0x1dVJJeEVIbXZKcksrc3BHVmIzd0NUd1NPdUYwRzd2dWY4djhOV1Z3?=
 =?utf-8?B?WTFTZWR4SVRvd0VpZHUrYTBEdmZ1TFBYb0kvR0VOQzNIZjVCbjdsa08vY0Ju?=
 =?utf-8?B?QnV2SURjcE9GZXdQQnZUWFNhRHowM1N5My92OW5OZ2NDaXFUS1VJNnRPLzJq?=
 =?utf-8?B?djdmQ1pCZlVkNnk1cE5yM1hkSi84UEx6ZjFMcUIzclhVYWZyM0FUajFLTlV0?=
 =?utf-8?B?UjZ1S2w0eW5OVlJtUENDczVCZDJDNnU0K3lSb005N2g5a0Y2TUtNTFJSYkt5?=
 =?utf-8?B?Vmswb1dQVlU5MjgwRFlxWThQdEZoOGh5VmNrNFNOcmJlMGNldXZoSlFiamlU?=
 =?utf-8?B?citRMzVobmhyVGM0djNRbHc5d0JZNVZkM0kya0J6RUJyMkNkV3h6RG9Da0U1?=
 =?utf-8?B?Mk5PTTNYVC80WEw3aTIrbFp4T1ZaYnpRdG1obVJBZmR0S1dGQ0pkTnZwUnFU?=
 =?utf-8?B?cHFaaUdORGlyajdPeFpMbVVGTkc2eFJCOXhKSWkyVTNiUjlpYWJXaU1uUWs3?=
 =?utf-8?B?QTA1Z1FzV2dZTE9YT3JRSWpuZng3Qk1lSmcxTTVSdXRCWGhaLzQ4V1FzbW9L?=
 =?utf-8?B?WGtnMjBqZlpaZWlZbCs1aGJVZDB5dVdncml2WW5acFdsc3VUOFJ3MG1nd1Jp?=
 =?utf-8?B?UVhCbTYxOWJQMlRVL0tydTVXQlNTQnZ0RzRXbDd5WWdUZEl3MWdhZS9hWkFi?=
 =?utf-8?B?dGdlVTdaRTFhQ3IzMENGZDBmbVNpREFLZndtMThEUU5FNzlxeHB3eTBFT2tj?=
 =?utf-8?B?VFRuU3gxSVNMRmVzRnJCOWRhTHNRZUdXVWwxY2R0RytwMlJtYjMwcTFQd1ho?=
 =?utf-8?B?S1dpWElIMU9tY1NFR1dHbGw2UXZyWDRWdTZ5Z1o0R1V6eEl1MmpGcEg2N2Vv?=
 =?utf-8?B?WnB2WFUyMzh4c2ZoMGdVYWpySXdpRGJ4QnFPVWdIK1F3bkU2MmFoQzB0QWl4?=
 =?utf-8?B?VzBKdXlSZHF2dUY0aTdlSlNtaWZCSDlJL0M3UkRIQitrRjdQNVp5MlVadzNz?=
 =?utf-8?B?K3FPOHdGY2d5OWV5aWVac01TYWlNc0ZwTzR4VE5SaG5ETWUvS0F5eEVHZk85?=
 =?utf-8?B?TkN1RDVodDJYVE1wRktOV2k3YWlvOHQzSGRCZS80MWJWbiswdURtVUdpRlZR?=
 =?utf-8?B?c1cwSUF3TDFpQWxKK09lam9sazFmQm81QmViYm45SjlaMncyYUk5alVGNWpp?=
 =?utf-8?B?YzcxclRmVDBZb2Jhc2ZZbE16VUx6K21vellPdERiVjI0NXNJT3RDMU83MW1u?=
 =?utf-8?B?VW81bms5KzNLbW9VaDZTWnRSK253RXpnVE1QcE5tTzVkZGNhNkJQN1FFMi96?=
 =?utf-8?B?R0pEK2hDQVM3dGEvaUJHd3Q0Yld2c3lKbTdZdEkycGRBNW1oa1B6TkFnNnpC?=
 =?utf-8?B?MGpFTFUvNTVBbk9RTVRPVFE0bVdBY2UxN0FJV2FGTHRpbnArdlBUekVOVk03?=
 =?utf-8?B?ODNLQzNhRXBvMGdQeFBFU2FYMWRwUndQZHc4WDZqbHVqWnQwYlRJUEhvQlZG?=
 =?utf-8?B?YkhESURramJpLzRDOVUxYlhJajZsb0Q0T1hTamZTRE9IQUlRV1B6YjRramNX?=
 =?utf-8?Q?Jgd8LTqChPIdQekRhK0vcCLLNiqifLcBLSmJTSlr6G47?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8EB37108C191064A8DFE864B19B15A5F@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd18b673-51fe-4994-a221-08db56b475cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2023 08:55:27.3402
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y1JIbXtWXF3C+Fd6S2s+4Uoklder9zLL9XfiwQfpp655cc6oFG5t/U/dca7uAapgBz7uX3KjH7iC3+Xh/oiP2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8257
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNS8xNy8yMyAwMTo0NCwgUHJhZGVlcCBQIFYgSyB3cm90ZToNCj4gVGhlcmUgaXMgYSBwb3Rl
bnRpYWwgcmFjZSBiZXR3ZWVuIGlvY19jbGVhcl9mbigpIGFuZA0KPiBleGl0X2lvX2NvbnRleHQo
KSBhcyBzaG93biBiZWxvdywgZHVlIHRvIHdoaWNoIGJlbG93DQo+IGNyYXNoIGlzIG9ic2VydmVk
LiBJdCBjYW4gYWxzbyByZXN1bHQgaW50byB1c2UtYWZ0ZXItZnJlZQ0KPiBpc3N1ZS4NCj4NCj4g
Y29udGV4dCMxOiAgICAgICAgICAgICAgICAgICAgICAgICAgIGNvbnRleHQjMjoNCj4gaW9jX3Jl
bGVhc2VfZm4oKSAgICAgICAgICAgICAgICAgICAgIGRvX2V4aXQoKTsNCj4gLT5zcGluX2xvY2so
JmlvYy0+bG9jayk7ICAgICAgICAgICAgIC0+ZXhpdF9pb19jb250ZXh0KCk7DQo+IC0+aW9jX2Rl
c3Ryb3lfaWNxKGljcSk7ICAgICAgICAgICAgICAtPmlvY19leGl0X2ljcXMoKTsNCj4gICAtPmxp
c3RfZGVsX2luaXQoJmljcS0+cV9ub2RlKTsgICAgICAgLT5zcGluX2xvY2tfaXJxKCZpb2MtPmxv
Y2spOw0KPiAgIC0+Y2FsbF9yY3UoJmljcS0+X19yY3VfaGVhZCwNCj4gICAgICAgaWNxX2ZyZWVf
aWNxX3JjdSk7DQo+IC0+c3Bpbl91bmxvY2soJmlvYy0+bG9jayk7DQo+ICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIC0+aW9jX2V4aXRfaWNxKCk7IGdldHMgdGhlIHNhbWUg
aWNxDQo+IAkJCQkgICAgICAgLT5iZnFfZXhpdF9pY3EoKTsNCj4gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBUaGlzIHJlc3VsdHMgaW50byBiZWxvdyBjcmFzaCBhcyBiaWMNCj4g
CQkJCSAgaXMgTlVMTCBhcyBpdCBpcyBkZXJpdmVkIGZyb20gaWNxLg0KPiAJCQkJICBUaGVyZSBp
cyBhIGNoYW5jZSB0aGF0IGljcSBjb3VsZCBiZQ0KPiAJCQkJICBmcmVlJ2QgYXMgd2VsbC4NCj4N
Cj4gWzMzLjI0NTcyMl1bIFQ4NjY2XSBVbmFibGUgdG8gaGFuZGxlIGtlcm5lbCBOVUxMIHBvaW50
ZXIgZGVyZWZlcmVuY2UNCj4gYXQgdmlydHVhbCBhZGRyZXNzIDAwMDAwMDAwMDAwMDAwMTguDQo+
IC4uLg0KPiBDYWxsIHRyYWNlOg0KPiBbMzMuMzI1NzgyXVsgVDg2NjZdICBiZnFfZXhpdF9pY3Er
MHgyOC8weGE4DQo+IFszMy4zMjU3ODVdWyBUODY2Nl0gIGV4aXRfaW9fY29udGV4dCsweGNjLzB4
MTAwDQo+IFszMy4zMjU3ODZdWyBUODY2Nl0gIGRvX2V4aXQrMHg3NjQvMHhhNTgNCj4gWzMzLjMy
NTc5MV1bIFQ4NjY2XSAgZG9fZ3JvdXBfZXhpdCsweDAvMHhhMA0KPiBbMzMuMzI1NzkzXVsgVDg2
NjZdICBpbnZva2Vfc3lzY2FsbCsweDQ4LzB4MTE0DQo+IFszMy4zMjU4MDJdWyBUODY2Nl0gIGVs
MF9zdmNfY29tbW9uKzB4Y2MvMHgxMTgNCj4gWzMzLjMyNTgwNV1bIFQ4NjY2XSAgZG9fZWwwX3N2
YysweDM0LzB4ZDANCj4gWzMzLjMyNTgwN11bIFQ4NjY2XSAgZWwwX3N2YysweDM4LzB4ZDANCj4g
WzMzLjMyNTgxMl1bIFQ4NjY2XSAgZWwwdF82NF9zeW5jX2hhbmRsZXIrMHg4Yy8weGZjDQo+IFsz
My4zMjU4MTNdWyBUODY2Nl0gIGVsMHRfNjRfc3luYysweDFhMC8weDFhNA0KPg0KPiBGaXggdGhp
cyBieSBjaGVja2luZyB3aXRoIElDUV9ERVNUUk9ZRUQgZmxhZ3MgaW4gaW9jX2V4aXRfaWNxcygp
Lg0KPiBBbHNvLCBlbnN1cmUgaW9jX2V4aXRfaWNxKCkgaXMgYWNjZXNzaW5nIGljcSB3aXRoaW4g
cmN1X3JlYWRfbG9jay91bmxvY2sNCj4gc28gdGhhdCBpY3EgZG9lc24ndCBnZXQgZnJlZSdkIHVw
IHdoaWxlIGl0IGlzIHN0aWxsIHVzaW5nIGl0Lg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBQcmFkZWVw
IFAgViBLIDxxdWljX3ByYWdhbGxhQHF1aWNpbmMuY29tPg0KPiAtLS0NCg0KSXMgaXQgcG9zc2li
bGUgdG8gYWRkIGEgbnVsbF9ibGsgYmFzZWQgYmxrdGVzdHMgZm9yIHRoaXMgPw0KDQotY2sNCg0K
DQo=
