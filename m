Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 286157160F3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 15:02:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232512AbjE3NC0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 09:02:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232487AbjE3NCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 09:02:20 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2058.outbound.protection.outlook.com [40.107.244.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49481185;
        Tue, 30 May 2023 06:02:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PZmlOtW1m1Z2iVzBSTaDdegK3PufnKEn/6T2Ky0nra3dNSlQifZ6wYcQKcNCM1BFw5wmxjHXR0dtfTW2S5WGzMJIYL1tPM2oGkW0AaqGWb6FAVWOJlJHOsRZrNHYYNEnx+oWVpF+SnIuRLb3xiybYZuq2W1Pm/guIhkAL0BLBlQdCNLVpjKCdwwWhmIj1JmcK5zNy3MRLDI9pdYoG33yhDk7XJyDwG01JKPf06UjWPcjAYyR1kc6shoGIuCJXRYFIJqQZ6FHeX4eCI6pn7vpcvuPsaA5FJlHBZGPpKKfpfr1QBnUEgOCKr2iAaNX0amECSW+gcT3BjL75uX1MVpIww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9GN98fX2M5Ms6cT0ofcdye4cV72uTpRsNtj4AXIybJY=;
 b=YEoSgXUH05V837YTY57pciqoCGwrrwPDW5vdfgdG+RnHArvIMT+pVgda4tnxIjUzzPf7FbbTfaojJCQr2wwdqc/blNnVcvDYcjNBUAo9zb5BoFAuKtnZzKlhCT42CqrDGXPylS7UJirczACgXkPwUA6WF79WJBnaluYsWJAK+9b54C1rR74etsZGEdWHGPcUtyD5OGIL2/DVZDKp2gDHCGqNT6zWSWRa5mvKHYG/f5YYaBZpNEp49c6Hht/FJ0e3ntVlOuZeIpQf+lp+3Xj29nE8Lme8bmQlmpMOvxPL8+l2C7kCmV60NgtBFrcijuI9QJhA4urMAZomoiemKcdd6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9GN98fX2M5Ms6cT0ofcdye4cV72uTpRsNtj4AXIybJY=;
 b=NvWouF8GL2azaPNTvnU5TGrBTs8DYNpvuRWEomjkS+2LKUW6ENRPREF7Vh6WcfYH2C5r/biG6WRoeL3eu1jrfyQbRGAC+3CiT0p4+ws/k9rVmrp8os2v4iSCFHamGLhBS0UlewkHWTLC85/ricl7ZgwRCLMoVNsz6/bRf5h65Wfrp36BDHE7X3K+KYsrvaxj8aubCfDoP2J+ZOfJN1EkMkOkdj0knOpyd8tFrbWLNWCILK2CzOdaMp6jK4nqvc90c2XcIJBSGR5Po2X2PL7Z6i9re3TZ89c6w1VqVEOAVEacWNQBm7pPzDK91daoma0W+KV9fDPiH4gfY8/GrMG0kQ==
Received: from CH2PR12MB3895.namprd12.prod.outlook.com (2603:10b6:610:2a::13)
 by CH3PR12MB7667.namprd12.prod.outlook.com (2603:10b6:610:14f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Tue, 30 May
 2023 13:01:56 +0000
Received: from CH2PR12MB3895.namprd12.prod.outlook.com
 ([fe80::331:ede9:286d:2cdf]) by CH2PR12MB3895.namprd12.prod.outlook.com
 ([fe80::331:ede9:286d:2cdf%5]) with mapi id 15.20.6433.022; Tue, 30 May 2023
 13:01:56 +0000
From:   Asmaa Mnebhi <asmaa@nvidia.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
CC:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: RE: [PATCH v6 1/2] gpio: mlxbf3: Add gpio driver support
Thread-Topic: [PATCH v6 1/2] gpio: mlxbf3: Add gpio driver support
Thread-Index: AQHZV4g0mf0KnjGDfkCNFmKuBrQRha7+8BeAgG4Ro3CABiRSgIAAGKEg
Date:   Tue, 30 May 2023 13:01:56 +0000
Message-ID: <CH2PR12MB389563EB951D549A57E9321ED74B9@CH2PR12MB3895.namprd12.prod.outlook.com>
References: <20230315215027.30685-1-asmaa@nvidia.com>
 <20230315215027.30685-2-asmaa@nvidia.com>
 <CAHp75VfnNOsfcyLM-UP61CMAF9sLOwMbRkAe5Ljhs2p8F=4Pgw@mail.gmail.com>
 <CH2PR12MB3895BDF9D79D61420A2F2BA8D7479@CH2PR12MB3895.namprd12.prod.outlook.com>
 <CACRpkdbN3oa=chsoh8ko74xKBPXA_yh1K07MSaghnMMk5PWYYw@mail.gmail.com>
In-Reply-To: <CACRpkdbN3oa=chsoh8ko74xKBPXA_yh1K07MSaghnMMk5PWYYw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR12MB3895:EE_|CH3PR12MB7667:EE_
x-ms-office365-filtering-correlation-id: 8c53a019-0eb1-402a-1c06-08db610e0c2e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4NA2AtP6HRaJFEEYvEusu6fTthmpR6x2ouf1hThkfXYJSLReatb0f4A+f+YoiXOPvqfw99PzqwOKFYRK/CsZMKlgTDNjAz6ue7kge8g31Ga5sC3wkAigjXeBKWsMlJVWqXLZzY/fkfomBJgLxJbktS8UahajNl88YFzMl2guxqBNuJpIZLgjEBsHaXo8ezpoTxoiK84ncHO8CvmyJDrSOjatCgByWvnTELFWTBFN9uED5+o2MNBRLlmWAmrIP3Ck9sPInTX2/UMExqdJ2NTkdWEwJhWxcAFeIkZHFGvHwhnes87Dvly5DTq80IhovB7OsfhjNOqlUS0TDYQ0IHpuqV6cnQaDrTxU7M2R0+0qDLtEu6r2gcdx98xXUaNGvWvLtcLinm4GtQPb+jhlAJObeu5ELk2+Ar6huru0cYmUBOIpFQLN8ZEXcFRh0j7BWU/rpRcBK2uJfsQvgs/SqQtk04GdCrh/SKzdfwyoJdUfnjMQjam5nvx7bydq+R5s2wib51loOrtOLFvKCiReoUzntOtdlaxlSqy3BWg4kRNfBq9rU+uTQ9uK/KUBKkf2iomr5PD7I95QxKjWhRXvZtpPBx4hn8vulYtcHYXvtwauULubjqgOAkPfrT9OKa0gAzKX
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3895.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(136003)(346002)(396003)(376002)(451199021)(54906003)(478600001)(71200400001)(110136005)(8936002)(64756008)(52536014)(5660300002)(8676002)(38070700005)(2906002)(4744005)(86362001)(33656002)(66476007)(66556008)(76116006)(66946007)(66446008)(4326008)(316002)(122000001)(55016003)(38100700002)(41300700001)(186003)(53546011)(6506007)(26005)(9686003)(7696005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZTdTVjN2aW5UZm03aWcvSzExUDF2bCt2NzkvblNrRTBJNU1qNTRQNExEZFVR?=
 =?utf-8?B?dnRzbXNhWll5L05idVV0c3AzVjgwaUlUWjVYV1E4MU1WZldkNUtGQVBaK1c4?=
 =?utf-8?B?c3hZejc0OFlpaW8va2ZkbEdqWFcvZGtVN1hjTHBUOHBSRmxWUFZWcWt1RzdF?=
 =?utf-8?B?THRuOHFjWnBlbURNRjRBM3hPUE55NnE2UUplS1VINDJuKzBidjVIdFhjSWNx?=
 =?utf-8?B?dlFCNmNzZndRTUJXekMzWm9DRjlkQ3JpNWc5UEs3ay8yalJZTDV4RkZYdytJ?=
 =?utf-8?B?c2d1bEpVSk5lSkM1TURuOWUwaEMzcVZnOTQzL2RwaVh6T205NGlsSElmUXdI?=
 =?utf-8?B?cC8vNkhzM0V6SnU5ck03emdVSXp0WTVGK1MwUlhId2dnQTVGODZ6eE9MWVR0?=
 =?utf-8?B?V2hYZHEzK3pOR3gzYXdVa0ZhL3dYckZPY0swbmRJOS9ncFJUdWZIekdKT0c0?=
 =?utf-8?B?ekZCc1htUkVTWnhuTDBPdFRnR3ZleEs1Nmc1cFN5ZWE0QjZpTzJxdmxKUll4?=
 =?utf-8?B?TmdNcG1HZ21PV285QjY1dkczSzJBbmVwM2dIN1k4T2lBeFJFcVVrUjdZNllC?=
 =?utf-8?B?UGppSExLYS9BV2NDSkRIUHBPWFJwUDRXZjVlS3htWUp0d25NMm1HVWhLQXZh?=
 =?utf-8?B?eUM4Qk9yRlhlVlBuRGx3K3YrK205RURUeG1lbEpxK3NvSjFzY2dZSDliRXYy?=
 =?utf-8?B?OXRuQnVHb3BSRW9mZWhBQ21TRndpRHVWRmZTWkpuVk5sQmRJWkF3ZjF6TC9Q?=
 =?utf-8?B?c213VWxEdDRIYW91eWVsZm9FRm9zamoyT1FZRVNiQkJhQkhTc2lXYlkxaG5n?=
 =?utf-8?B?eDRKaEZwOXM1QkN5MytSRWM5M29QWUpSNDFrczZMWkM2d0NST1kvdjhvNkdB?=
 =?utf-8?B?di9rbW01YlZrTUE5S0ZMTWpKdGJDd2d6UXBSa05WRyt0bmpqU3Z5M1lvdWxW?=
 =?utf-8?B?bjZqa1FPd2xOWjdmNVgwV0dFOU84K0VORndIZTlKbjd3bkhQMjVuZCs2b3ZQ?=
 =?utf-8?B?L3dMRFVCMXFSY2hHWTR1WFlJNzllOHFLOVJQdDJQVnBoWU9wbVUySm4rR2k4?=
 =?utf-8?B?VlFLeEdsWTdFbUhRS0FsVExvdTFhOUpTQzBNNkROMXBJUGxJZURHNmUzblly?=
 =?utf-8?B?WUxEdmwxQ21TcEc5RFFjbzFONldHUWtjK0VkYTdNWEt0OGF0OE16RTBMeTVy?=
 =?utf-8?B?bVRpbE8wdVFvZm03cEVzOXhKSkt5VnYwWExZbGhTcEFhcEZWQ2tSWXAxbnJn?=
 =?utf-8?B?UzVwKzFHb1JuaFMzbFhJdEJENU9KaFdCRzBWUE1YUkx4V3RCVkJwZU42eVZC?=
 =?utf-8?B?YXRjZ2FSczRqQnNPdi96OFVId3RORGFESWx4Q0I5emFMTTE2aytnZEVoK2dX?=
 =?utf-8?B?Q1VWNDlvRDlOcE1BWkQ2MXE0WW5PdXViN25YR1QwWHM5YWpIZ25haTF0Ukp2?=
 =?utf-8?B?Q0F6ZzVqb0VaWEpGTWtlcndOcDFVeDNORU5KQUdnbmNCMzZYWTRqaWlsZUVO?=
 =?utf-8?B?eGEwNGRQNXB1RE1zVGp2a0NuWnF2b1gxaHkrMThxeDV5aFdvUmQ2dTd2aHlo?=
 =?utf-8?B?U3NGeFgrc2dEbmJscmZOemVJZXVnZWZQOGpaYlFHRU5MQWZMSXJLYnNoVGlo?=
 =?utf-8?B?NFZ3d05JN2FpNHlGN3cveU9FVGEwaTBUU280amZHb1pQVGRvenVBdk1FRSsw?=
 =?utf-8?B?am9JZDZQM3M5V05BYUpyejZ0Vkgvc2JSNVVCNUNYbVRlWjhqNjNZUTlldDRw?=
 =?utf-8?B?bm10VWk3cm5YbS9xSXhQaEhGUEhWOTZaeGhlTElGdUNRZTg2QldGbkllUUJM?=
 =?utf-8?B?RFMzaUFacHNCS2gyb0h2Zk5NTWxKalpRTVhtRzgreUdBSTM0N1I5LzdZZDJH?=
 =?utf-8?B?VERoNW1nRm9IM0crUkpKWWE1Y2grZ01ja00zNlZwbDFTQUlQRDVybW0yL2Qw?=
 =?utf-8?B?MnJEY2QycUJrUzVsWGlzb3lJb055c0xVS0x3N3JZT1FFelN3QnlqQTY2MVkx?=
 =?utf-8?B?M1RFeE41Q2FCa0k4UkxxeU1JeFdwWFZHQ3VqTnpRa0lzcDY0NWRlT256WVhY?=
 =?utf-8?B?Z2JmcElWQnlmTnFxSUx2V0UzNlVTSG94V1lDYkpYM1FsdFBsZUNRK3o3dk4x?=
 =?utf-8?Q?j4oI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3895.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c53a019-0eb1-402a-1c06-08db610e0c2e
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2023 13:01:56.4328
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KJZP5Qc324b+dFdRv07xzh3t1SSEBRWK6AHk5g15WVwxmuVpKgkhPjkS8Fou8gIGz0hBQG0fSqOsHV6BSzr2GA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7667
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhhbmtzIExpbnVzIQ0KDQo+IE9uIEZyaSwgTWF5IDI2LCAyMDIzIGF0IDM6NDnigK9QTSBBc21h
YSBNbmViaGkgPGFzbWFhQG52aWRpYS5jb20+DQo+IHdyb3RlOg0KPiANCj4gPiBIaSBBbmR5LCBI
aSBMaW51cywNCj4gPg0KPiA+IEkgc2VlIHRoYXQgdGhlIHBpbmN0bC1tbHhiZjMuYyBpcyBpbiB2
Ni40IGtlcm5lbCBidXQgSSBhbSBub3Qgc2VlaW5nDQo+ID4gZ3Bpby1tbHhiZjMuYywgbm90IGV2
ZW4gaW4gTGludXggbmV4dC4gRG8geW91IGtub3cgd2hlbiB0aGlzIGRyaXZlciB3aWxsIGJlDQo+
IGludGVncmF0ZWQ/DQo+IA0KPiBCYXJ0b3N6IGlzIGFwcGx5aW5nIEdQSU8gcGF0Y2hlcywgSSBh
bSBzdXJlIGhlIHdpbGwgZ2V0IGFyb3VuZCB0byBpdCBvbmNlIGFsbA0KPiB0aGluZ3MgYXJlIHJl
dmlld2VkLCBidXQgeW91IG5lZWQgdG8gdXNlIHRoZSByaWdodCBlbWFpbCBhZGRyZXNzIHRvIGhp
bSAoc2VlDQo+IE1BSU5UQUlORVJTKS4NCj4gDQo+IFlvdXJzLA0KPiBMaW51cyBXYWxsZWlqDQo=
