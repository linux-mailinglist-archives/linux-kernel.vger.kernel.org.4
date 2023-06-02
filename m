Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0A6C71F767
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 02:57:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231605AbjFBA5j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 20:57:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjFBA5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 20:57:37 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2083.outbound.protection.outlook.com [40.107.102.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B957E4;
        Thu,  1 Jun 2023 17:57:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VVPHU1gZye7HlF9nx1O3gTpaWm4ABV7R7OiBiq3h9hc3dKONv7Fi3QLIWp9+vtYYt14/LUdeHmFVIyVxcfQEosWcQd3zRsV3nMU4c82EamQ3zOza3jg/zNrGA7ExLabacWnzP2FYNLuOG6SouxnuMO+fPxCQpO7xEw5w5kfN7N+in/KiITIyV52LB6zHodB7BEROxdC7N/Y2NRIl9/bjbJqk+N2OVvO3dT7R+PEguzexLiJcYG4eARHoex66AvKGsBx+1ydHaakHN+G89kCAMszqjkJjOQwuQDcDacmHv5K/nu2jGWiBdMhxs0FKZHY+Ei+zNLKWajL00eF8pXdcEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=abvI9ffBaYqaCRqukxaQcLnksKxVhWv/ibuYqnaCkVM=;
 b=E6stO9438UmECu5a9bSxmZfUXlDHRKDtmR+YeupH3BT+PftBXbGnNuLJsWJA5DV5XoxpxC9MVmhvLiCalOE679sy9KCW++hPTYs7gLDcrh9A8WWC3sZWZQkF2o+v5CY/oNnIpj3+5EwxsGccPv0YW7u4EHa7Jm8yuE9By7ZlxlZLBdKF5o3gdR1+tmOhAOVhcVQGY4uBXLCxmhKqnrJ2GA5t53Q5gUd8VAspLKrCx7yJSTkPMssf7wmqfpM1sRKqPbhQ3LhvNpBEsmwL3z160PzINulGPA1pu0ks7pOGGf5S6PTUKK75vLGXZKKtqQWqqWIWxrehQgvyljar0IRUiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=abvI9ffBaYqaCRqukxaQcLnksKxVhWv/ibuYqnaCkVM=;
 b=AomH5g4MijO1zwHAuquzoAtCSski29yJJKlJFv0Kmf8EKa8jJ7OhXhe/uzfDflGFc/dkH0vDFIe+f+FhA9vN9QJeR4/DcOxONk2lgIogbLZ8wczJTwojayO/wiVcs0n9x8hZjEk8rPtFq0uUkZwL9S+LcI5mWzuxLB8yy5vKKTI=
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by BY5PR12MB4036.namprd12.prod.outlook.com (2603:10b6:a03:210::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.24; Fri, 2 Jun
 2023 00:57:32 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::a65c:3aa0:b759:8527]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::a65c:3aa0:b759:8527%5]) with mapi id 15.20.6433.022; Fri, 2 Jun 2023
 00:57:32 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     Nick Hastings <nicholaschastings@gmail.com>,
        Karol Herbst <kherbst@redhat.com>
CC:     Lyude Paul <lyude@redhat.com>, Lukas Wunner <lukas@wunner.de>,
        Salvatore Bonaccorso <carnil@debian.org>,
        "1036530@bugs.debian.org" <1036530@bugs.debian.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Subject: RE: Regression from "ACPI: OSI: Remove Linux-Dell-Video _OSI string"?
 (was: Re: Bug#1036530: linux-signed-amd64: Hard lock up of system)
Thread-Topic: Regression from "ACPI: OSI: Remove Linux-Dell-Video _OSI
 string"? (was: Re: Bug#1036530: linux-signed-amd64: Hard lock up of system)
Thread-Index: AQHZkTCTXT9qiOm+i06x7G4cHp2/pq9vocuAgADMgQCAAAUmAIAAK9qAgAFBYoCAAFNkgIAAMowAgAKppoCAARahAIAABDeAgAAETGCAAAh3AIAAAELwgAAOKwCAAGIgAIAADrYA
Date:   Fri, 2 Jun 2023 00:57:32 +0000
Message-ID: <MN0PR12MB610181D29933EE4787DE9BC8E24EA@MN0PR12MB6101.namprd12.prod.outlook.com>
References: <ZHUt9xQKCwCflvVC@xps>
 <8537d965-ddf4-7f45-6459-d5acf520376e@amd.com> <ZHWfMBeAONerAJmd@xps>
 <ZHfa/wQlaVCeUC22@xps> <fe0ab1fa-6ed6-dc64-8165-8fc70669317b@amd.com>
 <CACO55tsuO1kQUFfPdPFUHm4WEQseCR2tQSDhFRzR+8wOECZCyA@mail.gmail.com>
 <MN0PR12MB61017541F5AC55485A490BCDE2499@MN0PR12MB6101.namprd12.prod.outlook.com>
 <CACO55tudULtvt_Hcdg+uqXeYkSAR_NZ1oD=R_KhuE_THSRe88g@mail.gmail.com>
 <MN0PR12MB6101DE067CF85E59AF187763E2499@MN0PR12MB6101.namprd12.prod.outlook.com>
 <CACO55tuqAH5Zt+X9pjLFZ-RcFgxpgjpqmrAHPvm4=fb_DMBHyw@mail.gmail.com>
 <ZHkxYo/a+/uInkLG@xps>
In-Reply-To: <ZHkxYo/a+/uInkLG@xps>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=d80b3f6b-67b2-4d5c-998f-af4db9ec3992;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-06-02T00:54:16Z;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB6101:EE_|BY5PR12MB4036:EE_
x-ms-office365-filtering-correlation-id: ce57f5b7-d7e5-4e21-16bd-08db630458ea
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: l4xggor2Ge7BGbi0GW8vP1Q2Yv14ZFaKRMsr6XQ8o0hxUo4kjnOkg+jgvkNhzly1TjXKp49ST3RZIZAFuccJ8E+lfYVxAffexvNKvrx9LGCmcXihNMBieUY9bGphV8F0404bX1vfY/QDB9pT+TpphI5vu2dzLDVLwbZlkGd000FgWuuc42U9klHo6OeeR0gvosHyHNkfrrbonEvI7YWicoBEC3X93K4yj2b0pdBNEeBgOXvGJQRBYoEXHYuM5hDWKJteIEHruG/jgYa4CodwplU3X5VoRA76eMgnyNUtXbMYiKiIDYn37frS83aGRhjMvJatK0Q8+14BaTE//SrCbGoqXBjoj3NTR/2NxSzDXKn39gq6kg31roIqhOdr5Y2tctPALLca+IvrIXhd5epUxOfRZM4Mi3LrqgGqnN5RXOOnDkIXLum4Eo74K2f4eEkCl8+2/4xgwV7MGuv/O/5T+eFZufgk9P09sKtFiDGzveR5J7/L8ZWN5adyRPjtacIex3RA6tFz7tUGxj53S9FOa1VbdQ79/YuIpMCYVukFMEvHoBuD3vFtnZ69JXHQMmlAFVLqWg7/cRF/jBPU5nAi8tbpod+oj0glaW0hlT/LPAti7+1QxbKpkkJnkNZPp48OvrzKpiZkUU6XUIVD8ZspGw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(376002)(396003)(136003)(366004)(451199021)(55016003)(110136005)(54906003)(478600001)(66446008)(64756008)(8936002)(8676002)(122000001)(41300700001)(66556008)(66476007)(76116006)(4326008)(38100700002)(66946007)(316002)(186003)(83380400001)(966005)(71200400001)(7696005)(6506007)(26005)(53546011)(9686003)(33656002)(86362001)(38070700005)(5660300002)(7416002)(52536014)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K25NTytreFQwWkZPd2lSQ3dUaTlRT3RESEh6L0duWUx6R2Y4dC84RUdwbWtW?=
 =?utf-8?B?cXFVSi9WQ0FDK2dpQ3ZsTElyM1IrWGFxVTVuT3FZakxnVnB4cjU1d0xhK2NN?=
 =?utf-8?B?UmY4TmNvOFo5NEc1ampsU0VyKzNlckRkQVYwdWRGL3BNVVNYUEJDNGsyWHk5?=
 =?utf-8?B?dE5DR01uZDNWTU5kQzlsZUJGSWd6Z3RUdmh1dEx1Nzk1ekc1aW9tRkxSajNC?=
 =?utf-8?B?R1NqMUUxZTQvcjNPSDd2NEdyclpKY0hFOUxkSzdLdEppWlJ4bm1wQkFEbWdm?=
 =?utf-8?B?YzdzMU5HdytEckw0NXVKdURYY0U1UmZMWWs3WjhJbGR6VXBJTEpXdDRjaytB?=
 =?utf-8?B?cFo2eXZ2ZjBnS0gyUXlJREtkcnJGaWJpelFWZUZRL2dmeklzSlM4THNaOTRG?=
 =?utf-8?B?Ny82RjBhN2VSNkVTdE1IL0crRTl0QTBOTkJLR3JYYWJkWDZkM1lMTW1LRWZm?=
 =?utf-8?B?elliWjk4Q3B0d2QxMys4clBXWXhIa3dzKzRpVGRVMXpqM1dwbEdhUzREemVl?=
 =?utf-8?B?STA3NXo4dTMrbDZqNUppTm9tOXJkYnl3S01aOGk4TTc4OUFFNTlFakVaVWJy?=
 =?utf-8?B?NWwxb2RYN3JvUzF0Q0RaY2gvbkNGcDYwb3lYZC9zbW81aU94emhkMWF5T3dB?=
 =?utf-8?B?M3NxS203MlN1T1BjWmJtbnhwcFJ1d051Y0huNzdwNXBNRFUxN0ZuRzlkM2RO?=
 =?utf-8?B?SnM5bGFQYWQ1SEVhZ3F0SE5SemV3bkp3cUt5MmdOeFlXbXkvRjNmSDN5NzZE?=
 =?utf-8?B?OE51TVBlRXl3OUV3SzdmSUFYVnNmbTNOVlQ1WUt6cHpKOWRwNjNqU21hWE04?=
 =?utf-8?B?eitzRVdzZ1dOeWJCanQ1S2FjZFVKN2plZ2JCQWZpL3FyN0NrMnZ2RHZlOW5V?=
 =?utf-8?B?cXBlQWdKZEZkaVhQcmJBZ1VoL3lSbGVzb2VQRkMvNDlYSG95dDU5UmFOMFY1?=
 =?utf-8?B?bFlBR0ErQWhUS3BscG5tdlJ0ME9JdkRVTDZCaktyOUx3WlZNclpBWXlGQWxS?=
 =?utf-8?B?MVVnNTRnN3IzU25iTXlZZjdLNk8rMmhLVndOWXNZV3VJUXYya3V1anIydE9X?=
 =?utf-8?B?ZnRmMEhacFRPUG1JVy9BQ1ZhUklnQk9CM0M5aHpoL0FQSElqT3oxcUd1U3R2?=
 =?utf-8?B?eHNUZHhnU1ZqTW9wQkdPazdqMWpsaC8vNWtBME9ra2dMOTVDRXhGQ0J6NEFx?=
 =?utf-8?B?RWlaOTVLL2tReExIcWVIbGxaeTVQRnhjNEJjN3dlZFQ1dTNuOHpaaGFqckhN?=
 =?utf-8?B?c3BTMGlQZ2gzMGJuUXhUam5pYk9LeTMzeXFSdUVxdGhZbGxrbDNVdUxLenFN?=
 =?utf-8?B?NXBOU2c3bGx2a1poR3NRTy9BSXVZMXc3RDZIV0s0ajV1MDY4eXlUTG9Bbm9Y?=
 =?utf-8?B?Q1BCcmdhbEhVZ1NoNWZkU01VcWlCTzR5VGM5YWphejNwYUF0QTE2anBOaEdl?=
 =?utf-8?B?Slo4a0tRTmw2c1lsbnFSUzQzVWlJSkpHaDBpNDlLcE9OYlExVkNDV21waFI0?=
 =?utf-8?B?NW54VWJIakdVT2IxQ20vb3RIdnhPSDNkdFpyM1Y3ejNCeWozMGh0dDZVNDFB?=
 =?utf-8?B?R1B6NHVPY21Tdnc2dEIrcGN3NWZTVlVVYVg5czNLYVQzc0N2OFJvQmxpb2RJ?=
 =?utf-8?B?SjIvM05CcjFVc2RvaU0veXg4eFE5WnNQa2tBRGFPZmtkemlBUzluQkdoT1Yz?=
 =?utf-8?B?aHY4dDZaY3NEK2grYzExY2FGU2oxTFYxZFp2KzVLMWh6SXJqTSs0RENFZW9P?=
 =?utf-8?B?SjVzNlRTdlp0TU9OVlkxZlowM25XYnlTMDFVcE9TQ0xWYTh5VUg1MVI2S3Nr?=
 =?utf-8?B?NTNycUZUeWtHUUFQU0EyZGhCY21VcVZtdE5hVjI3YTdOTWpFR1kwVWZCV25j?=
 =?utf-8?B?c2c0d056SjlXbER2ZFZXV2RKWmRuMWpQcTl4WmRRWEJxWkxHREt0TzBXK21G?=
 =?utf-8?B?WTJ6YWl5ZnJMb0FZSVB3UEYrWStYSVJFVFE4ZE9TNjNaZVJoaVpBMTJHczAz?=
 =?utf-8?B?WTYvVkNZVEoxeXNrYTgrM2hqc0xPVzNhVThGVGE0enIzTTB6MFNUaHZNSjho?=
 =?utf-8?B?cmVzNFNaOEZNcE1ZbE5iZHNkQy9td3Bhd3VCdE9kNkk2S0hzOFBlZGJlL0o0?=
 =?utf-8?Q?y3Fk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce57f5b7-d7e5-4e21-16bd-08db630458ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2023 00:57:32.5475
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5wVQqPD3caL8iKpK+ArtQbpbpHu0No48TPq6mrbugZDYRsXNuqONSkonCJpvwMEoVES8VGpHzJeXGiSYFqjfig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4036
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNz
YWdlLS0tLS0NCj4gRnJvbTogTmljayBIYXN0aW5ncyA8bmljaG9sYXNjaGFzdGluZ3NAZ21haWwu
Y29tPg0KPiBTZW50OiBUaHVyc2RheSwgSnVuZSAxLCAyMDIzIDc6MDIgUE0NCj4gVG86IEthcm9s
IEhlcmJzdCA8a2hlcmJzdEByZWRoYXQuY29tPg0KPiBDYzogTGltb25jaWVsbG8sIE1hcmlvIDxN
YXJpby5MaW1vbmNpZWxsb0BhbWQuY29tPjsgTHl1ZGUgUGF1bA0KPiA8bHl1ZGVAcmVkaGF0LmNv
bT47IEx1a2FzIFd1bm5lciA8bHVrYXNAd3VubmVyLmRlPjsgU2FsdmF0b3JlDQo+IEJvbmFjY29y
c28gPGNhcm5pbEBkZWJpYW4ub3JnPjsgMTAzNjUzMEBidWdzLmRlYmlhbi5vcmc7IFJhZmFlbCBK
Lg0KPiBXeXNvY2tpIDxyYWZhZWxAa2VybmVsLm9yZz47IExlbiBCcm93biA8bGVuYkBrZXJuZWwu
b3JnPjsgbGludXgtDQo+IGFjcGlAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5r
ZXJuZWwub3JnOw0KPiByZWdyZXNzaW9uc0BsaXN0cy5saW51eC5kZXYNCj4gU3ViamVjdDogUmU6
IFJlZ3Jlc3Npb24gZnJvbSAiQUNQSTogT1NJOiBSZW1vdmUgTGludXgtRGVsbC1WaWRlbyBfT1NJ
DQo+IHN0cmluZyI/ICh3YXM6IFJlOiBCdWcjMTAzNjUzMDogbGludXgtc2lnbmVkLWFtZDY0OiBI
YXJkIGxvY2sgdXAgb2Ygc3lzdGVtKQ0KPg0KPiBIaSwNCj4NCj4gKiBLYXJvbCBIZXJic3QgPGto
ZXJic3RAcmVkaGF0LmNvbT4gWzIzMDYwMiAwMzoxMF06DQo+ID4gT24gVGh1LCBKdW4gMSwgMjAy
MyBhdCA3OjIx4oCvUE0gTGltb25jaWVsbG8sIE1hcmlvDQo+ID4gPE1hcmlvLkxpbW9uY2llbGxv
QGFtZC5jb20+IHdyb3RlOg0KPiA+ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+
ID4gPiBGcm9tOiBLYXJvbCBIZXJic3QgPGtoZXJic3RAcmVkaGF0LmNvbT4NCj4gPiA+ID4gU2Vu
dDogVGh1cnNkYXksIEp1bmUgMSwgMjAyMyAxMjoxOSBQTQ0KPiA+ID4gPiBUbzogTGltb25jaWVs
bG8sIE1hcmlvIDxNYXJpby5MaW1vbmNpZWxsb0BhbWQuY29tPg0KPiA+ID4gPiBDYzogTmljayBI
YXN0aW5ncyA8bmljaG9sYXNjaGFzdGluZ3NAZ21haWwuY29tPjsgTHl1ZGUgUGF1bA0KPiA+ID4g
PiA8bHl1ZGVAcmVkaGF0LmNvbT47IEx1a2FzIFd1bm5lciA8bHVrYXNAd3VubmVyLmRlPjsgU2Fs
dmF0b3JlDQo+ID4gPiA+IEJvbmFjY29yc28gPGNhcm5pbEBkZWJpYW4ub3JnPjsgMTAzNjUzMEBi
dWdzLmRlYmlhbi5vcmc7IFJhZmFlbCBKLg0KPiA+ID4gPiBXeXNvY2tpIDxyYWZhZWxAa2VybmVs
Lm9yZz47IExlbiBCcm93biA8bGVuYkBrZXJuZWwub3JnPjsgbGludXgtDQo+ID4gPiA+IGFjcGlA
dmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiA+ID4gPiBy
ZWdyZXNzaW9uc0BsaXN0cy5saW51eC5kZXYNCj4gPiA+ID4gU3ViamVjdDogUmU6IFJlZ3Jlc3Np
b24gZnJvbSAiQUNQSTogT1NJOiBSZW1vdmUgTGludXgtRGVsbC1WaWRlbyBfT1NJDQo+ID4gPiA+
IHN0cmluZyI/ICh3YXM6IFJlOiBCdWcjMTAzNjUzMDogbGludXgtc2lnbmVkLWFtZDY0OiBIYXJk
IGxvY2sgdXAgb2YNCj4gc3lzdGVtKQ0KPiA+ID4gPg0KPiA+ID4gPiBPbiBUaHUsIEp1biAxLCAy
MDIzIGF0IDY6NTTigK9QTSBMaW1vbmNpZWxsbywgTWFyaW8NCj4gPiA+ID4gPE1hcmlvLkxpbW9u
Y2llbGxvQGFtZC5jb20+IHdyb3RlOg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gW0FNRCBPZmZpY2lh
bCBVc2UgT25seSAtIEdlbmVyYWxdDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiA+IC0tLS0tT3JpZ2lu
YWwgTWVzc2FnZS0tLS0tDQo+ID4gPiA+ID4gPiBGcm9tOiBLYXJvbCBIZXJic3QgPGtoZXJic3RA
cmVkaGF0LmNvbT4NCj4gPiA+ID4gPiA+IFNlbnQ6IFRodXJzZGF5LCBKdW5lIDEsIDIwMjMgMTE6
MzMgQU0NCj4gPiA+ID4gPiA+IFRvOiBMaW1vbmNpZWxsbywgTWFyaW8gPE1hcmlvLkxpbW9uY2ll
bGxvQGFtZC5jb20+DQo+ID4gPiA+ID4gPiBDYzogTmljayBIYXN0aW5ncyA8bmljaG9sYXNjaGFz
dGluZ3NAZ21haWwuY29tPjsgTHl1ZGUgUGF1bA0KPiA+ID4gPiA+ID4gPGx5dWRlQHJlZGhhdC5j
b20+OyBMdWthcyBXdW5uZXIgPGx1a2FzQHd1bm5lci5kZT47IFNhbHZhdG9yZQ0KPiA+ID4gPiA+
ID4gQm9uYWNjb3JzbyA8Y2FybmlsQGRlYmlhbi5vcmc+OyAxMDM2NTMwQGJ1Z3MuZGViaWFuLm9y
ZzsgUmFmYWVsDQo+IEouDQo+ID4gPiA+ID4gPiBXeXNvY2tpIDxyYWZhZWxAa2VybmVsLm9yZz47
IExlbiBCcm93biA8bGVuYkBrZXJuZWwub3JnPjsgbGludXgtDQo+ID4gPiA+ID4gPiBhY3BpQHZn
ZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsNCj4gPiA+ID4gPiA+
IHJlZ3Jlc3Npb25zQGxpc3RzLmxpbnV4LmRldg0KPiA+ID4gPiA+ID4gU3ViamVjdDogUmU6IFJl
Z3Jlc3Npb24gZnJvbSAiQUNQSTogT1NJOiBSZW1vdmUgTGludXgtRGVsbC1WaWRlbw0KPiBfT1NJ
DQo+ID4gPiA+ID4gPiBzdHJpbmciPyAod2FzOiBSZTogQnVnIzEwMzY1MzA6IGxpbnV4LXNpZ25l
ZC1hbWQ2NDogSGFyZCBsb2NrIHVwIG9mDQo+ID4gPiA+IHN5c3RlbSkNCj4gPiA+ID4gPiA+DQo+
ID4gPiA+ID4gPiBPbiBUaHUsIEp1biAxLCAyMDIzIGF0IDY6MTjigK9QTSBMaW1vbmNpZWxsbywg
TWFyaW8NCj4gPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+ID4gTHl1ZGUsIEx1a2FzLCBLYXJvbA0K
PiA+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gPiBUaGlzIHRocmVhZCBpcyBpbiByZWxhdGlvbiB0
byB0aGlzIGNvbW1pdDoNCj4gPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+ID4gMjQ4Njc1MTZmMDZk
ICgiQUNQSTogT1NJOiBSZW1vdmUgTGludXgtRGVsbC1WaWRlbyBfT1NJIHN0cmluZyIpDQo+ID4g
PiA+ID4gPiA+DQo+ID4gPiA+ID4gPiA+IE5pY2sgaGFzIGZvdW5kIHRoYXQgcnVudGltZSBQTSBp
cyAqbm90KiB3b3JraW5nIGZvciBub3V2ZWF1Lg0KPiA+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4N
Cj4gPiA+ID4gPiA+IGtlZXAgaW4gbWluZCB3ZSBoYXZlIGEgbGlzdCBvZiBQQ0llIGNvbnRyb2xs
ZXJzIHdoZXJlIHdlIGFwcGx5IGENCj4gPiA+ID4gPiA+IHdvcmthcm91bmQ6DQo+ID4gPiA+ID4g
Pg0KPiA+ID4gPg0KPiBodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVs
L2dpdC90b3J2YWxkcy9saW51eC5naXQvdHJlZS9kcml2ZXJzDQo+ID4gPiA+ID4gPiAvZ3B1L2Ry
bS9ub3V2ZWF1L25vdXZlYXVfZHJtLmM/aD12Ni40LXJjNCNuNjgyDQo+ID4gPiA+ID4gPg0KPiA+
ID4gPiA+ID4gQW5kIEkgc3VzcGVjdCB0aGVyZSBtaWdodCBiZSBvbmUgb3IgdHdvIG1vcmUgSURz
IHdlJ2xsIGhhdmUgdG8gYWRkDQo+ID4gPiA+ID4gPiB0aGVyZS4gRG8gd2UgaGF2ZSBhbnkgbG9n
cz8NCj4gPiA+ID4gPg0KPiA+ID4gPiA+IFRoZXJlJ3Mgc29tZSBhcmNoaXZlZCBvbnRvIHRoZSBk
aXN0cm8gYnVnLiAgU2VhcmNoIHRoaXMgcGFnZSBmb3INCj4gPiA+ID4gImpvdXJuYWxjdGwubG9n
Lmd6Ig0KPiA+ID4gPiA+IGh0dHBzOi8vYnVncy5kZWJpYW4ub3JnL2NnaS1iaW4vYnVncmVwb3J0
LmNnaT9idWc9MTAzNjUzMA0KPiA+ID4gPiA+DQo+ID4gPiA+DQo+ID4gPiA+IGludGVyZXN0aW5n
Li4gSXQgc2VlbXMgdG8gYmUgdGhlIHNhbWUgY29udHJvbGxlciB1c2VkIGhlcmUuIEkgd29uZGVy
DQo+ID4gPiA+IGlmIHRoZSBwY2kgdG9wb2xvZ3kgaXMgZGlmZmVyZW50IG9yIGlmIHRoZSB3b3Jr
YXJvdW5kIGlzIGFwcGxpZWQgYXQNCj4gPiA+ID4gYWxsLg0KPiA+ID4NCj4gPiA+IEkgZGlkbid0
IHNlZSB0aGUgbWVzc2FnZSBpbiB0aGUgbG9nIGFib3V0IHRoZSB3b3JrYXJvdW5kIGJlaW5nIGFw
cGxpZWQNCj4gPiA+IGluIHRoYXQgbG9nLCBzbyBJIGd1ZXNzIFBDSSB0b3BvbG9neSBkaWZmZXJl
bmNlIGlzIGEgbGlrZWx5IHN1c3BlY3QuDQo+ID4gPg0KPiA+DQo+ID4geWVhaCwgYnV0IEkgYWxz
byBjb3VsZG4ndCBzZWUgYSBsb2cgd2l0aCB0aGUgdXN1YWwgbm91dmVhdSBtZXNzYWdlcywNCj4g
PiBzbyBpdCdzIGtpbmRhIHdlaXJkLg0KPiA+DQo+ID4gQW55d2F5LCB0aGUgb3V0cHV0IG9mIGBs
c3BjaSAtdHZubmAgd291bGQgaGVscA0KPg0KPiAlIGxzcGNpIC10dm5uDQo+IC1bMDAwMDowMF0t
Ky0wMC4wICBJbnRlbCBDb3Jwb3JhdGlvbiBEZXZpY2UgWzgwODY6M2UyMF0NCj4gICAgICAgICAg
ICArLTAxLjAtWzAxXS0tLS0wMC4wICBOVklESUEgQ29ycG9yYXRpb24gVFUxMTdNIFtHZUZvcmNl
IEdUWCAxNjUwDQo+IE1vYmlsZSAvIE1heC1RXSBbMTBkZToxZjkxXQ0KDQpTbyB0aGUgYnJpZGdl
IGl0J3MgY29ubmVjdGVkIHRvIGlzIHRoZSBzYW1lIHRoYXQgdGhlIHF1aXJrICpzaG91bGQgaGF2
ZSBiZWVuKiB0cmlnZ2VyaW5nLg0KDQpNYXkgMjkgMTU6MDI6NDIgeHBzIGtlcm5lbDogcGNpIDAw
MDA6MDA6MDEuMDogWzgwODY6MTkwMV0gdHlwZSAwMSBjbGFzcyAweDA2MDQwMA0KDQpTaW5jZSB0
aGUgcXVpcmsgaXNuJ3Qgd29ya2luZyBhbmQgdGhpcyBpcyBzdGlsbCBhIHByb2JsZW0gaW4gNi40
LXJjNCBJIHN1Z2dlc3Qgb3BlbmluZyBhDQpOb3V2ZWF1IGRybSBidWcgdG8gZmlndXJlIG91dCB3
aHkuDQoNCj4gICAgICAgICAgICArLTAyLjAgIEludGVsIENvcnBvcmF0aW9uIENvZmZlZUxha2Ut
SCBHVDIgW1VIRCBHcmFwaGljcyA2MzBdDQo+IFs4MDg2OjNlOWJdDQo+ICAgICAgICAgICAgKy0w
NC4wICBJbnRlbCBDb3Jwb3JhdGlvbiBYZW9uIEUzLTEyMDAgdjUvRTMtMTUwMCB2NS82dGggR2Vu
IENvcmUNCj4gUHJvY2Vzc29yIFRoZXJtYWwgU3Vic3lzdGVtIFs4MDg2OjE5MDNdDQo+ICAgICAg
ICAgICAgKy0wOC4wICBJbnRlbCBDb3Jwb3JhdGlvbiBYZW9uIEUzLTEyMDAgdjUvdjYgLyBFMy0x
NTAwIHY1IC8NCj4gNnRoLzd0aC84dGggR2VuIENvcmUgUHJvY2Vzc29yIEdhdXNzaWFuIE1peHR1
cmUgTW9kZWwgWzgwODY6MTkxMV0NCj4gICAgICAgICAgICArLTEyLjAgIEludGVsIENvcnBvcmF0
aW9uIENhbm5vbiBMYWtlIFBDSCBUaGVybWFsIENvbnRyb2xsZXINCj4gWzgwODY6YTM3OV0NCj4g
ICAgICAgICAgICArLTE0LjAgIEludGVsIENvcnBvcmF0aW9uIENhbm5vbiBMYWtlIFBDSCBVU0Ig
My4xIHhIQ0kgSG9zdCBDb250cm9sbGVyDQo+IFs4MDg2OmEzNmRdDQo+ICAgICAgICAgICAgKy0x
NC4yICBJbnRlbCBDb3Jwb3JhdGlvbiBDYW5ub24gTGFrZSBQQ0ggU2hhcmVkIFNSQU0gWzgwODY6
YTM2Zl0NCj4gICAgICAgICAgICArLTE1LjAgIEludGVsIENvcnBvcmF0aW9uIENhbm5vbiBMYWtl
IFBDSCBTZXJpYWwgSU8gSTJDIENvbnRyb2xsZXIgIzANCj4gWzgwODY6YTM2OF0NCj4gICAgICAg
ICAgICArLTE1LjEgIEludGVsIENvcnBvcmF0aW9uIENhbm5vbiBMYWtlIFBDSCBTZXJpYWwgSU8g
STJDIENvbnRyb2xsZXIgIzENCj4gWzgwODY6YTM2OV0NCj4gICAgICAgICAgICArLTE2LjAgIElu
dGVsIENvcnBvcmF0aW9uIENhbm5vbiBMYWtlIFBDSCBIRUNJIENvbnRyb2xsZXIgWzgwODY6YTM2
MF0NCj4gICAgICAgICAgICArLTE3LjAgIEludGVsIENvcnBvcmF0aW9uIENhbm5vbiBMYWtlIE1v
YmlsZSBQQ0ggU0FUQSBBSENJIENvbnRyb2xsZXINCj4gWzgwODY6YTM1M10NCj4gICAgICAgICAg
ICArLTFiLjAtWzAyLTNhXS0tLS0wMC4wLVswMy0zYV0tLSstMDAuMC1bMDRdLS0tLTAwLjAgIElu
dGVsIENvcnBvcmF0aW9uDQo+IEpITDYzNDAgVGh1bmRlcmJvbHQgMyBOSEkgKEMgc3RlcCkgW0Fs
cGluZSBSaWRnZSAyQyAyMDE2XSBbODA4NjoxNWQ5XQ0KPiAgICAgICAgICAgIHwgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgKy0wMS4wLVswNS0zOV0tLQ0KPiAgICAgICAgICAgIHwgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgXC0wMi4wLVszYV0tLS0tMDAuMCAgSW50ZWwgQ29y
cG9yYXRpb24gSkhMNjM0MA0KPiBUaHVuZGVyYm9sdCAzIFVTQiAzLjEgQ29udHJvbGxlciAoQyBz
dGVwKSBbQWxwaW5lIFJpZGdlIDJDIDIwMTZdDQo+IFs4MDg2OjE1ZGJdDQo+ICAgICAgICAgICAg
Ky0xYy4wLVszYl0tLS0tMDAuMCAgSW50ZWwgQ29ycG9yYXRpb24gV2ktRmkgNiBBWDIwMCBbODA4
NjoyNzIzXQ0KPiAgICAgICAgICAgICstMWMuNC1bM2NdLS0tLTAwLjAgIFJlYWx0ZWsgU2VtaWNv
bmR1Y3RvciBDby4sIEx0ZC4gUlRTNTI1QSBQQ0kNCj4gRXhwcmVzcyBDYXJkIFJlYWRlciBbMTBl
Yzo1MjVhXQ0KPiAgICAgICAgICAgICstMWQuMC1bM2RdLS0tLTAwLjAgIFNhbXN1bmcgRWxlY3Ry
b25pY3MgQ28gTHRkIE5WTWUgU1NEIENvbnRyb2xsZXINCj4gU005ODEvUE05ODEvUE05ODMgWzE0
NGQ6YTgwOF0NCj4gICAgICAgICAgICArLTFmLjAgIEludGVsIENvcnBvcmF0aW9uIENhbm5vbiBM
YWtlIExQQyBDb250cm9sbGVyIFs4MDg2OmEzMGVdDQo+ICAgICAgICAgICAgKy0xZi4zICBJbnRl
bCBDb3Jwb3JhdGlvbiBDYW5ub24gTGFrZSBQQ0ggY0FWUyBbODA4NjphMzQ4XQ0KPiAgICAgICAg
ICAgICstMWYuNCAgSW50ZWwgQ29ycG9yYXRpb24gQ2Fubm9uIExha2UgUENIIFNNQnVzIENvbnRy
b2xsZXINCj4gWzgwODY6YTMyM10NCj4gICAgICAgICAgICBcLTFmLjUgIEludGVsIENvcnBvcmF0
aW9uIENhbm5vbiBMYWtlIFBDSCBTUEkgQ29udHJvbGxlcg0KPiAgICAgICAgICAgIFs4MDg2OmEz
MjRdDQo+DQo+DQo+IFJlZ2FyZHMsDQo+DQo+IE5pY2suDQoNCg==
