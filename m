Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D2476729AF
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 21:50:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbjARUu3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 15:50:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbjARUuT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 15:50:19 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2055.outbound.protection.outlook.com [40.107.93.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1DDA470A9;
        Wed, 18 Jan 2023 12:50:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n2zXoOMFoPW3+1JoeD5FMr+aS2DArYY8KWQg2F/Ed7GZr2iwHmvwvWnGDcwWe/WoHRsdlj3/X8v0oIUy8oKks1XQaPUWXmV4IX3gp2KM5Ledb/cVtlsMQ6DhMPaDApUga/J0RDgRX5crKCQgLH45XRfb7/1hgiaUMu+cpnCsJ1ZVYRBEaQhC48B5dDbd1oFmTz6kBepix5GvkvydkGBzKUXHLOyQMVcOUMCzrqvwfHJk5AwPL1MDitNtZn2aEG5cmGp56tjfkV/VuQkVNjWZO7XZ9Mv4mPiMmcL8I7s0kvFKr6uZr25aNVSkgFIw8AVWhjOokqeMmXVbpptcr1AXGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oQNnFQ12lllconEVJq5hPSvhwNyMIft39KoKnF7v3ic=;
 b=TXQtUMALEwejlZZmYOEfjcIjI4osHdQnLKpkqsytuZH24ZKS57l/bZaXBXoWePlRwa5OKYQ6950FtnhavG5eaUzJmDAg4/78P2rXNZ1MtXZ5snOrNtJUWUAmCcwvjFBR0bo2fTkj6oH7XPKcPJu1oJQ4iyS7NqaBuL9Oi/7JFbM74uezQ5jQlo9HwKUpuWA7hASOiP7aXohlwKhqEbfrvcVC3qOajqSKOcK6XX4yWEW4dEXTbWH2FoXP9GCCsZh8hX/aBEZTFpCHhmogp5rLWqAwpxvJmp0kYrBcyknvfKYNW+RXSJKbWVj6xpCeXy6o3HQ09XKO0a4QDJDcXxSrqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oQNnFQ12lllconEVJq5hPSvhwNyMIft39KoKnF7v3ic=;
 b=RtncaAlblPEgny7to2T4DeycjV+F5Rz4nYZEV/SVDjp/2TqFydMJWzDiqJlUYcC4USUeA7vBLcShBF9PmEJQpuuXWbYbeFekfs9rts71iiIHiJVo0Evy6N8VjZ121Z6n4p2AMnYAuC+bDgm6+YwZn7Wzqk9hqeVvylIWHrODnbo=
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DM4PR12MB7552.namprd12.prod.outlook.com (2603:10b6:8:10c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.24; Wed, 18 Jan
 2023 20:50:13 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::ff3c:2d37:75f3:442a]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::ff3c:2d37:75f3:442a%8]) with mapi id 15.20.5986.023; Wed, 18 Jan 2023
 20:50:13 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     Linus Walleij <linus.walleij@linaro.org>
CC:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Raul E Rangel <rrangel@chromium.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        Werner Sembach <wse@tuxedocomputers.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/2] gpiolib: acpi: Add a ignore wakeup quirk for Clevo
 NL5xRU
Thread-Topic: [PATCH 2/2] gpiolib: acpi: Add a ignore wakeup quirk for Clevo
 NL5xRU
Thread-Index: AQHZKeH3RzVh5Z9oE0y+EDxCv5Vtrq6kp5eAgAABSIA=
Date:   Wed, 18 Jan 2023 20:50:12 +0000
Message-ID: <MN0PR12MB6101BA7BD23547F8E797DB46E2C79@MN0PR12MB6101.namprd12.prod.outlook.com>
References: <20230116193702.31356-1-mario.limonciello@amd.com>
 <20230116193702.31356-3-mario.limonciello@amd.com>
 <CACRpkdaX+ZVA7zQDnADEi5KPpfd-gwsxPsKaZo5FxEmgjv4S3Q@mail.gmail.com>
In-Reply-To: <CACRpkdaX+ZVA7zQDnADEi5KPpfd-gwsxPsKaZo5FxEmgjv4S3Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-01-18T20:50:11Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=5a78fd7e-e0bc-4281-a628-6d56696b712d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2023-01-18T20:50:11Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 1328c5c1-3aa6-48c4-8d34-4bf604a9176e
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB6101:EE_|DM4PR12MB7552:EE_
x-ms-office365-filtering-correlation-id: ce49b608-1d68-4171-0dfa-08daf995987d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZdtCbdjHPSqdjmDbU6Wptp4hJAPFDaDpQNptpQ4haftJX4jQOnyO4HueY4SckMyouP+mUncTje/7NUkkBqsxKA2zP+Cw9u944tFL6ESEOUUDrpxcHA9bZdl1dN/c7JXonpCkvkCyJCJCeU+8unQ1oxRaKKNwRhvLoDT+T/QfJRC59aIW4INSg5GVr6CoYgO4t4VUE9rctqOycdp329aXH6btXM6CRA19aH1mXsQS6pis8UFk39sufv/ViiQSydW0DgAvJ1ADMo+QwV6bDXwDkt11zsEu1INk6Xm9CH2kkTtFQyYQdgC+WBoEq9sVk7Chs/zndfJ8oXd0nhD1QuqR+ZBvTt06i1617bTFD5PDfOCjkFZKuS+vOVgZQKOwp+SxstPhQdugmiDxW2GGr1R3fKQiDppxnex9rTCsgiH7AS/lLHUY+iKKLBTOhtMIK+lNygtwZmBknTl6p0yoC60Z0blpROFmpyQyCIxF1jcjZHQAjUOvI3c9gZIM33g9/Kl8Q6zLazyfTwON1ZMLg5AiSNYptBrIjFJKdDr+fL42KU2Ezps/KBPfPSaKMVM1aRatFUtSVjnA66JMhp3bTYBiQZdoTQR1JRUhxExuebcaLGCRMWZkjR/55TBWEEhz+J5ZFN5oJwPgw5lWtI/S8RctR3JQAUM3evpQdu8NsPP93MXHV7pKO4xFWmXjSNdLXKrEKluMail8H8lvW16vMB8Psa7VsKBORgOuiXVz6eCP+Wk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(39860400002)(136003)(376002)(346002)(451199015)(316002)(76116006)(122000001)(38100700002)(86362001)(38070700005)(33656002)(5660300002)(66476007)(2906002)(8936002)(52536014)(7416002)(66946007)(55016003)(66556008)(66446008)(64756008)(4326008)(8676002)(41300700001)(6916009)(186003)(83380400001)(9686003)(7696005)(53546011)(71200400001)(54906003)(478600001)(6506007)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SzdkUlV6MHN6SHRkelpTemRqZlNDV3oxenJyQVc4RDFtMVYvbS8yZW85cEIv?=
 =?utf-8?B?RWJQMXFhUUtXdHVqWFRCS0plSXFRaEszTTl3S2dhQm1iMnFnaXFQSWhYaVRQ?=
 =?utf-8?B?dGJid2VlaWFKc1kza0R4cWsyWnpuMFVjMTFEbWhYYnJhalc3TGVVZnNjVWtn?=
 =?utf-8?B?Tm8xak9RekNhZ1Q0a2gvbTlZN3dIenhPSWRHVDBNb0o0bWFCeCsrVlNReFBh?=
 =?utf-8?B?TXRDZy9ZOVl4QVR4NzRBaEQxNWZRL281K2xaNTI1Rm5BTHYweHNhUi93V2xN?=
 =?utf-8?B?blo5QVJzUXdkRWZoOHVsY054WDNzUXpDNURUeXQrTlhWamtkVFF2NUR5eUJV?=
 =?utf-8?B?T2EwbUUxeGx3NVJsTVhsancycUdWd2V1L2w3cU05V0dBMzhPdnZsVjYrTnpH?=
 =?utf-8?B?bmpsSll5WXVpR1FoUUhETUxNeEdJNVVZZGovQkVwbkkwMlJuTi9QaXBDdU9u?=
 =?utf-8?B?aWlGd054dmZZRCtrN0FCZkZRV0d1U1p4STE1L3pVSkdwRFRNSDRyaHZMdzFC?=
 =?utf-8?B?TjROOWpJV3NpR0NycU82N0JPY2wyQlp0dHl0cVpmSzNQSW0yMDVRYWZubkUv?=
 =?utf-8?B?alpRSVJUUkt5WjM4c2t4bHZrU2Rja2xodks5bUNTMG12cXlLMklLMGpzMWZX?=
 =?utf-8?B?UWlFejJVckFMSk5aZ3dEY2ZyQVh4TEx3elRNNzR1NXQwV3J3aDZQNjE2cXFT?=
 =?utf-8?B?YVFOcExKRkFsVURCeTBydU9RVy9JbGpZdjA5bWExWVphMmlFSXBzbkVycnlH?=
 =?utf-8?B?RURoZVAyNExqN1gzam82OGNzMW5TaEFOZXVTQlJMdTJDaXZxUXdLcnphTVlG?=
 =?utf-8?B?SitaODNLeHVxSFl3aXd6b3c2d1krMlpPN0hVN2pzWUl3c2ZtSDVwZEF6VGEy?=
 =?utf-8?B?T1hDZk1LZHVTMmdia1l6SlJCbSthaDZ2QmFvMWxWbDduVUpMZ3E3UGVMa1Fr?=
 =?utf-8?B?RHFTK3VoUURMdUJpWWZTOTlGYjRhMXUyektveGpWak9aTHN1cmRVaXhiTTRK?=
 =?utf-8?B?ZnczdnFOMHNaeUhmczYwN0VldUd3SFhES1BESlRHeEd6RDRNVDlmR2FWOTVw?=
 =?utf-8?B?QkVvL01UdGVuK2xiamVKNnNsdlJMUFc3TWpJVzI4K1E3ai9KK2JmbWtSK2ZW?=
 =?utf-8?B?NC9XeVZmYTRpcEZmZ0tKOUM1dlFXUjZWMmUrUGR6bWtrZjJNcXQ5b0RMaU9C?=
 =?utf-8?B?SG53ajlxK2l1YTQya1pzTEkwUWdQcGdWR0k4dnA4WFNJM2Flb0NMc01hMW9t?=
 =?utf-8?B?aFNNemZGQkJJa01Fblhud2IvVnVnOEhwMVpZVVNhVHJxQ0t3cDlkY1FFMy9O?=
 =?utf-8?B?VU0yc1NFajBkazYvY29iMlB4Nkp1VmFHWEZkN1JRZEZTMVZNQjduK2ZBZFBD?=
 =?utf-8?B?aVl3OU95elp1ZUZUOGZhUGhqelE3R1AraG1HbGlKVmxNMHlRaWFWaUpNY2RY?=
 =?utf-8?B?YUlrd1ZkdHhlc2puQTJ1T3dKcTZmUW5zTkpXVnFteHhjOFFOK1psaVA1azVF?=
 =?utf-8?B?bUZmK3VRbGVjZUZEM1N6SWNDc0FUajBaTW5LOXhMeU5HNzJjalY1dzJlbFdz?=
 =?utf-8?B?VjVYbURuV0h3Y0N5UGhXNmJ2OGpKVStacFlKUFI0Znc3ZGtncytiUThsR24r?=
 =?utf-8?B?cWFmMkhYZGowZi9lZ3BhMk1kTHdMdG9TUG5hWXBqa0UzREc5cVFyVUVZcHRk?=
 =?utf-8?B?Z0FUQ3lITWdnM2lwYy9WcGdPSWc1VEQrTDVzNzVkYnZlRHhuNzY4QXNjbWJa?=
 =?utf-8?B?QjFraXpQb0dCNnV5Zi9wbExMWlhOVFBna3ZscG83WG41RWxtTTh1R1BLdi9V?=
 =?utf-8?B?Nnp2V2RtSnc3R21TTjd3NGQvKytISTluTDVTS0tGRW03QmlPRUxGK0k5QXRG?=
 =?utf-8?B?QXNLd1RWMXA4ZkNvcFBPUlJDOU5RZVk3V3FUNWhud1JWM0NMU1lCVkNuWW1i?=
 =?utf-8?B?N3MreitrdlNzL0dMZG1rRks2SkFGcmtYdjZHR3F2dE82b2E2c01Pend3WU0v?=
 =?utf-8?B?VDRSZHFPd0sxeURvM0hVREI0WmdzSzVFQjl0TGFSOTI3SzdReVplMG42Q2lw?=
 =?utf-8?B?K1hkMlNndDdVTWtSSC9TVXdNNWFHSzdKTDhQdUNETlhyTDdjcHVyZmJlcnFi?=
 =?utf-8?B?L2lCWjhxWHNZQjZjUWtxR2JZKzI1aFB4QWJtRUc3bEdmSnl4c2Q5QnIvQ2N2?=
 =?utf-8?Q?+cgM9BiEcmTs1yBl+W0V7fD1GcLOQIJXsqUiyz3DdspP?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce49b608-1d68-4171-0dfa-08daf995987d
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2023 20:50:12.9966
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q8e+q3pAKyv/HEGbFNuub84XJo2ENkCcfZ35Jgkl0hXOKavLDpaYPI/6Ufs3eq4nLYgZsA2XQ5lS4YkfeArSwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7552
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

W1B1YmxpY10NCg0KDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTGlu
dXMgV2FsbGVpaiA8bGludXMud2FsbGVpakBsaW5hcm8ub3JnPg0KPiBTZW50OiBXZWRuZXNkYXks
IEphbnVhcnkgMTgsIDIwMjMgMTQ6NDUNCj4gVG86IExpbW9uY2llbGxvLCBNYXJpbyA8TWFyaW8u
TGltb25jaWVsbG9AYW1kLmNvbT4NCj4gQ2M6IE1pa2EgV2VzdGVyYmVyZyA8bWlrYS53ZXN0ZXJi
ZXJnQGxpbnV4LmludGVsLmNvbT47IEFuZHkgU2hldmNoZW5rbw0KPiA8YW5kcml5LnNoZXZjaGVu
a29AbGludXguaW50ZWwuY29tPjsgQmFydG9zeiBHb2xhc3pld3NraQ0KPiA8YnJnbEBiZ2Rldi5w
bD47IERtaXRyeSBUb3Jva2hvdiA8ZG1pdHJ5LnRvcm9raG92QGdtYWlsLmNvbT47IFJhdWwgRQ0K
PiBSYW5nZWwgPHJyYW5nZWxAY2hyb21pdW0ub3JnPjsgQmVuamFtaW4gVGlzc29pcmVzDQo+IDxi
ZW5qYW1pbi50aXNzb2lyZXNAcmVkaGF0LmNvbT47IHJlZ3Jlc3Npb25zQGxpc3RzLmxpbnV4LmRl
djsgV2VybmVyDQo+IFNlbWJhY2ggPHdzZUB0dXhlZG9jb21wdXRlcnMuY29tPjsgbGludXgtZ3Bp
b0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LQ0KPiBhY3BpQHZnZXIua2VybmVsLm9yZzsgbGludXgt
a2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDIvMl0gZ3Bpb2xp
YjogYWNwaTogQWRkIGEgaWdub3JlIHdha2V1cCBxdWlyayBmb3IgQ2xldm8NCj4gTkw1eFJVDQo+
IA0KPiBPbiBNb24sIEphbiAxNiwgMjAyMyBhdCA4OjM3IFBNIE1hcmlvIExpbW9uY2llbGxvDQo+
IDxtYXJpby5saW1vbmNpZWxsb0BhbWQuY29tPiB3cm90ZToNCj4gDQo+ID4gSG93ZXZlciBvbiBD
bGV2byBOTDV4UlUgdGhlcmUgaXMgYSBtaXN0YWtlIGluIHRoZSBBQ1BJIHRhYmxlcyB0aGF0IHRo
ZQ0KPiA+IFRQX0FUVE4jIHNpZ25hbCBjb25uZWN0ZWQgdG8gR1BJTyA5IGlzIGNvbmZpZ3VyZWQg
YXMgQWN0aXZlTG93IGFuZCBsZXZlbA0KPiA+IHRyaWdnZXJlZCBidXQgY29ubmVjdGVkIHRvIGEg
cHVsbCB1cC4gQXMgc29vbiBhcyB0aGUgc3lzdGVtIHN1c3BlbmRzIHRoZQ0KPiA+IHRvdWNocGFk
IGxvc2VzIHBvd2VyIGFuZCB0aGVuIHRoZSBzeXN0ZW0gd2FrZXMgdXAuDQo+IA0KPiBOb3cgdGhh
dCBpcyB3aGF0IEkgY2FsbCBwcm9wZXIgcm9vdCBjYXVzZSBhbmFseXNpcy4gSGF0cyBvZmYgZm9y
IHRoaXMgcGF0Y2ghDQo+IFJldmlld2VkLWJ5OiBMaW51cyBXYWxsZWlqIDxsaW51cy53YWxsZWlq
QGxpbmFyby5vcmc+DQoNClJhdWwgc2hvdWxkIGdldCBzb21lIGNyZWRpdCB0b28gaGVyZSBpbiB0
aGUgY29uZmlybWF0aW9uIG9uIHRoYXQgcm9vdCBjYXVzZS4NCg0KSXQgY2VydGFpbmx5IHJlYWxs
eSBoZWxwcyB0aGF0IHRoZSBzY2hlbWF0aWNzIGZvciB0aGlzIHN5c3RlbSB3ZXJlIHJlYWRpbHkg
YXZhaWxhYmxlDQpvbiB0aGUgd2ViIHRvIGNvbmZpcm0gdGhlIGh5cG90aGVzaXMuDQo=
