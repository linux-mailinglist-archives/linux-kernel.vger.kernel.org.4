Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EB21671AE4
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 12:42:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbjARLmj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 06:42:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbjARLmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 06:42:20 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2088.outbound.protection.outlook.com [40.107.244.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E54369210;
        Wed, 18 Jan 2023 02:59:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Myrzoed//iXfwjuFdyHb8/PJVwUS0EZSQtQCAeTSFCiTN5+xU1WEAfJA/XiuOeaE9ZHITBqhLJ4x65u62eA/MF6u95izfJY9CkA9wQBsIod76RLvs6D34dTnR2gV+d6+2BeaqXKefkrsDX63l23AZO0TLW5CmjcVuAdflvsYgLkm2CObzVswtXbIOfRwRHN3RfKxerXxPmw/WSxPVob5BqCFrNCmLJagSJsxPACX87XJBNVZyMKjogpQo/ZqVK++MZt17QTMOUEAbkAS5bpedv40N2OHZjM3+EUpGZI6iNHGBZzqE7GY3eDnO94NmXwePs7tEbQh5pJb2cdJPo43Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=092fPPITQBS+gpK+5eWwhRK/V3i98jn774D+cn2KHBU=;
 b=gfyeHg5xASH5wpMDgJBYK69GWRCe6fBgSwxCmNUgxF1KI0ZnuYnX8owTLBFTMGYZqqPvVeZHIynbDl3YwR5sB4+aOfIvLjayKiEYejSWho6pO/eOdb78/7TAGawzjZnBKHgnKekX/E0fCnz0Qzwckx0KG3SBsRJ27gaCDkOUzc2HZ16k/WEQ3ouhZcEZ3+eWY1YYbcUHvf0tO48oRIoyYKiPXWcOFj2sS6yXMdrhlDVIbNtYk+d424oQ+IRhXhNBwoS07XnTWmTsKswZdO7ByR56CF6TLZIoZAldpYHxB+6zRo0yolkxhHkcadYns3MhuN6Q13kVfJFo2NTMtLn7hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=092fPPITQBS+gpK+5eWwhRK/V3i98jn774D+cn2KHBU=;
 b=OPY7Wa7Spq5fuRIL1ByRW0XrGAXB5gjkedoK1bAjxDh46eTKc75xGCPahbLpmFAUk6SVtDK0mui0UE32NAzIKGdnkThjaFICH6NBnARJYldvza7C0G/Sp4+HJdQFvrfrYFTVJ+PGuR0xMQ418bFTrWVbpm5XppG29vts/Pq+R+8=
Received: from DM6PR12MB3082.namprd12.prod.outlook.com (2603:10b6:5:11b::12)
 by PH7PR12MB7161.namprd12.prod.outlook.com (2603:10b6:510:200::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Wed, 18 Jan
 2023 10:59:15 +0000
Received: from DM6PR12MB3082.namprd12.prod.outlook.com
 ([fe80::12bb:9697:46d5:c65d]) by DM6PR12MB3082.namprd12.prod.outlook.com
 ([fe80::12bb:9697:46d5:c65d%6]) with mapi id 15.20.6002.024; Wed, 18 Jan 2023
 10:59:15 +0000
From:   "Gupta, Nipun" <Nipun.Gupta@amd.com>
To:     Randy Dunlap <rdunlap@infradead.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "cohuck@redhat.com" <cohuck@redhat.com>,
        "song.bao.hua@hisilicon.com" <song.bao.hua@hisilicon.com>,
        "mchehab+huawei@kernel.org" <mchehab+huawei@kernel.org>,
        "maz@kernel.org" <maz@kernel.org>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "jeffrey.l.hugo@gmail.com" <jeffrey.l.hugo@gmail.com>,
        "saravanak@google.com" <saravanak@google.com>,
        "Michael.Srba@seznam.cz" <Michael.Srba@seznam.cz>,
        "mani@kernel.org" <mani@kernel.org>,
        "yishaih@nvidia.com" <yishaih@nvidia.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "jgg@nvidia.com" <jgg@nvidia.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "masahiroy@kernel.org" <masahiroy@kernel.org>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kbuild@vger.kernel.org" <linux-kbuild@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC:     "okaya@kernel.org" <okaya@kernel.org>,
        "Anand, Harpreet" <harpreet.anand@amd.com>,
        "Agarwal, Nikhil" <nikhil.agarwal@amd.com>,
        "Simek, Michal" <michal.simek@amd.com>,
        "git (AMD-Xilinx)" <git@amd.com>
Subject: RE: [PATCH 01/19] bus/cdx: add the cdx bus driver
Thread-Topic: [PATCH 01/19] bus/cdx: add the cdx bus driver
Thread-Index: AQHZKnmCjxCOIOBZ9k2Vsnzl39LOTq6i22kAgADaArA=
Date:   Wed, 18 Jan 2023 10:59:15 +0000
Message-ID: <DM6PR12MB3082C8D0CC6AFFDA28F12E79E8C79@DM6PR12MB3082.namprd12.prod.outlook.com>
References: <20230117134139.1298-1-nipun.gupta@amd.com>
 <20230117134139.1298-2-nipun.gupta@amd.com>
 <cc20a76f-6de5-b850-2c54-1e2a535feca6@infradead.org>
In-Reply-To: <cc20a76f-6de5-b850-2c54-1e2a535feca6@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-01-18T10:59:13Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=d673ec7c-4a1a-4e90-853e-10fa79fcba3a;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB3082:EE_|PH7PR12MB7161:EE_
x-ms-office365-filtering-correlation-id: c6fb0730-9a69-47a9-86ee-08daf94309f9
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: q4/d/VQGl90KE1zbuVzGCkEtxTNuXoFRrWgo5m14nFI/WjgH4oBhiVfGjYzYKOylcLCH+df1cFpcbf+6hw/0G+sEoke4oGV8vDE6ZMh6WuYo2iyFmvT378P6t+Du5ZvvKBF3lr3/IhM+ObmP5jN//L5PQSAV/LYOAdWMDzuleUcsPnfopEF9QrY++gX0PYqL///QoG7JDOv/hVBAryz1vTuTN2Ej4pihwsBt6ACyOyexjrrpGsG+1I+BLc0t9TLmyvnWDrKqOhJQSwTeroMF99wv1TFsUe5MjpHBXwXF0pw1sIsvBhg7DmMkpBy3VbRXPBjmsS4a5DlM4tTn73KQYRW3wVoT0w4NdAd43PMHSEy/c+X+rsaiBkcQapjXx92Ld496CQnOLvT5XvDvQ0VgEuuJUHazjKtEsXK+qhNtp2GjCrFRuIpQtt+Oq8sj+RZueYHvzW9orFIvqyjOoG+uRMW9iPizlixf9U2kwk9IcJitWP77Rjnc3aj2FKcxEFRS5mX3Azk5C0036V3g3Ps5xQoaG4I+3ukqgj8FAewIwQokHPIB0YvbkG3NoiyvQVGUh589UOM9SYlCWuRLMG2Bjl2gRDvmadnDHrOFy3khjVookHXEkOOxerRrhJsR63+a7zZJ+JF4oOrS5gH4laCbxU6e0/BG6jnFtXLhI67B5Pb++9f92ckeylpTYUAkMpXqoWwqkpliOPw3cjIestGGZMBGB6VbeW33t95+9JYhycc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3082.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(346002)(136003)(39860400002)(376002)(451199015)(8936002)(8676002)(921005)(55016003)(38070700005)(86362001)(66446008)(52536014)(66556008)(64756008)(66946007)(76116006)(5660300002)(2906002)(7406005)(4326008)(7416002)(38100700002)(83380400001)(66476007)(122000001)(33656002)(478600001)(316002)(71200400001)(7696005)(110136005)(54906003)(41300700001)(6506007)(53546011)(26005)(9686003)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eUw1VDNrQS9lSUlLMnZRTWF3M1hjN0ZGdHJDblpkbzhOckxEZ1RzcWFYTGZn?=
 =?utf-8?B?VTh3MExOaXp6S3lJTEljZVN5KzFtV0FuTkxXZEVTVEFPK2M5MTIzbVd1V2pj?=
 =?utf-8?B?NHhEdjdmaWxHMks0bmJaeUVpTTNrVVUxOVNIeVZLblp4TUw3a2lWY1JmN1pn?=
 =?utf-8?B?N1pHZmgzdTJmUGRQd2xaSU9LOGkyWjFmSjZza244MFR0ZmJLVit3aktoVkVX?=
 =?utf-8?B?am9XWWx0NnJ4TmFFQzlLNEJMcWxXQmtHK3RhUTRiYjA1c0haQ0tlZmZzMC9m?=
 =?utf-8?B?dHBwd1pleVk5RDNpN3VESktDRHY5VXpiTU8rYS9iT0l5aWVNLy8xTVJKa0ZN?=
 =?utf-8?B?WXdrd0o5bnJEUWFCbUhZbzY2WkVMVXY2bnpYN2VwVU1iU2lROGRmS1NiYkJr?=
 =?utf-8?B?UnErZzN3cVNFRlRUcStHMXdrMjU0b0JNZVN0b1JCZGp6RVA2eVFYZjNEVU9I?=
 =?utf-8?B?RWM5NnlwendFZkNXMnZDOTArYTRSbXJMOHp6MnJSL0tCNlFzZDI5b2U5MTV4?=
 =?utf-8?B?T0dUd1VZQXFhSmtzL043VXd0aUxNWWRaVWRSc2I0eEpWaVZsM2FTUFlzQ3My?=
 =?utf-8?B?NTdJZzJnMFNUMUdXQlRxUUtjandNYWI2VlVmQjNEVU5TZmdZdVlrMitpc3Jl?=
 =?utf-8?B?V1BEaG5VbmJjVjVhaE9YZlRWbHBSMnlkNTVhdGVlcnBJU1dXMEduVzN6SXNP?=
 =?utf-8?B?ZW94UGdaS0NhNjFFd0RiUm9hY3o0eDlJSVc0UkI1V2dEZFJTUEQ0dC9oOS95?=
 =?utf-8?B?Mi94enN2V3JvbHdEdE1mY210UjA0UjFYWDlHb2c5ZktGMkdlRnVkVVM0RlpB?=
 =?utf-8?B?MThJK0Q5M3JYYjdJek1yeTM2OFFpeUsvTENRa2hTV3B5eE5VYVVmZUtZZ3M3?=
 =?utf-8?B?YTBjQkFUMFpWT0ZQcW4zaWNEVjdqTEtNOWFPc0k5NEdUVDExL1Fhb2VWVUEx?=
 =?utf-8?B?cnNldmxyRTdEZkVldVlGQjRENU9wVkZERlBqa0s0R3VsdzdsV29leXZ6dUc4?=
 =?utf-8?B?Sy9ObS9tUjU1ellPNFUxNEszUHRoMllBd0JkdEF3VERPbUhRV2VOVFJ5aC9G?=
 =?utf-8?B?SnQ1cHNTK080TkYrcFlVTHhoR1dHdXZ6RmM0YVN5a3JURHQvN1NNbkk0aVBN?=
 =?utf-8?B?L3JEc0dKQU9FbndWZUxJQXp1K2trM1JtM2NuK0VoWld3SFhXYitPRlJKMDlJ?=
 =?utf-8?B?ZDlkcFJpVkdJNUIweWY2R2hCWnQraTF3Q1dCeHVndkZXR202TktaVHBWczlZ?=
 =?utf-8?B?bll0MGZSUDBrUml0U2Z5ZFpHSjcxWFZIdjlMSmlNQnZtenRSWEx1Wm9IUGdX?=
 =?utf-8?B?eHY3M2djdlVHUkNlaWQ0WmR3NFAvOHFOTU1DZ045WnNoYld1ZGF6ZHYvOW1L?=
 =?utf-8?B?WiszQkROR09rZmo2UGNMTHJxWWQzcG5RZ1ZMSUszNUxpMlFHLzNWbVNNblcz?=
 =?utf-8?B?bWpweUpHUXdxdXhQVmlEeDY5OHdEcUEwQ0Uxd2xRd0l3dXZNYm9PS3N3MmJH?=
 =?utf-8?B?d1NCZndYa3ZJZzNGNTYxWVZQNTJxelhWZE5UaHRWQzltb2x4R09OdzlTRVI5?=
 =?utf-8?B?czZkUVJaZ2ExVURmTFpWOGdqYkVHdnVBTVEvS2lxR2EzL2dnbDQ3aktTN0dq?=
 =?utf-8?B?YUUydXpUQnN6NGE0c0QvdkRaMUJMU2RBYVJHbURNbUpiMHQ1cHhwdkM2eWZP?=
 =?utf-8?B?S0dEdE1oNnJLZFdLTnJXZFBsQTdHdGsrNlArck1MbWM3bWFrRVpRVXhWSUpS?=
 =?utf-8?B?bEZJWWF2SHI3VllPMmVsaGQ1MnV6emZKbzNkOStYN2h4YjF0T0Nva1BFQkxX?=
 =?utf-8?B?b0htNHVNY0VSSHdMTXJSdDk3NUtSb0NGWURSWjBqUmhKMU9FMURFVHZ2SlB4?=
 =?utf-8?B?K2lYSjJONlFYMitKcFpOREhEcHVNQnVLZTl2by9acnpadEN3ZFF1K0tudmNu?=
 =?utf-8?B?S05qRHNMUFVIV3FZbVordzdBUXF3TWdpTjM4S0dxa3lRbmZqZDhqa1hRZXVz?=
 =?utf-8?B?SHpPY2ZoTkFvLytOZG9pM2xZcURlVkpaTnJEbWNqWU9KODZTM2JUZHM1TzZt?=
 =?utf-8?B?WWNYZ00ybW9GemxxRzB4YWtTN0o0czFta3J4YUZTYkRvY0paaS9SUjE4UVlO?=
 =?utf-8?Q?Y8Pg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3082.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6fb0730-9a69-47a9-86ee-08daf94309f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2023 10:59:15.1507
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mxrsSeRjCYF7VlL+Ip27UQqDsTKQvD4odgzSH/hrUwZ4w3gnGkWvRGac3jztNtTj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7161
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCg0KDQo+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+IEZyb206IFJhbmR5IER1bmxhcCA8cmR1bmxhcEBpbmZyYWRlYWQub3Jn
Pg0KPiBTZW50OiBUdWVzZGF5LCBKYW51YXJ5IDE3LCAyMDIzIDEwOjUyIFBNDQo+IFRvOiBHdXB0
YSwgTmlwdW4gPE5pcHVuLkd1cHRhQGFtZC5jb20+OyByb2JoK2R0QGtlcm5lbC5vcmc7DQo+IGty
enlzenRvZi5rb3psb3dza2krZHRAbGluYXJvLm9yZzsgZ3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5v
cmc7DQo+IHJhZmFlbEBrZXJuZWwub3JnOyBlcmljLmF1Z2VyQHJlZGhhdC5jb207IGFsZXgud2ls
bGlhbXNvbkByZWRoYXQuY29tOw0KPiBjb2h1Y2tAcmVkaGF0LmNvbTsgc29uZy5iYW8uaHVhQGhp
c2lsaWNvbi5jb207DQo+IG1jaGVoYWIraHVhd2VpQGtlcm5lbC5vcmc7IG1hekBrZXJuZWwub3Jn
OyBmLmZhaW5lbGxpQGdtYWlsLmNvbTsNCj4gamVmZnJleS5sLmh1Z29AZ21haWwuY29tOyBzYXJh
dmFuYWtAZ29vZ2xlLmNvbTsgTWljaGFlbC5TcmJhQHNlem5hbS5jejsNCj4gbWFuaUBrZXJuZWwu
b3JnOyB5aXNoYWloQG52aWRpYS5jb207IGpnZ0B6aWVwZS5jYTsgamdnQG52aWRpYS5jb207DQo+
IHJvYmluLm11cnBoeUBhcm0uY29tOyB3aWxsQGtlcm5lbC5vcmc7IGpvcm9AOGJ5dGVzLm9yZzsN
Cj4gbWFzYWhpcm95QGtlcm5lbC5vcmc7IG5kZXNhdWxuaWVyc0Bnb29nbGUuY29tOyBsaW51eC1h
cm0tDQo+IGtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eC1rYnVpbGRAdmdlci5rZXJu
ZWwub3JnOyBsaW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVsLm9yZzsgZGV2aWNldHJlZUB2Z2Vy
Lmtlcm5lbC5vcmcNCj4gQ2M6IG9rYXlhQGtlcm5lbC5vcmc7IEFuYW5kLCBIYXJwcmVldCA8aGFy
cHJlZXQuYW5hbmRAYW1kLmNvbT47IEFnYXJ3YWwsDQo+IE5pa2hpbCA8bmlraGlsLmFnYXJ3YWxA
YW1kLmNvbT47IFNpbWVrLCBNaWNoYWwgPG1pY2hhbC5zaW1la0BhbWQuY29tPjsNCj4gZ2l0IChB
TUQtWGlsaW54KSA8Z2l0QGFtZC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMDEvMTldIGJ1
cy9jZHg6IGFkZCB0aGUgY2R4IGJ1cyBkcml2ZXINCj4gDQo+IENhdXRpb246IFRoaXMgbWVzc2Fn
ZSBvcmlnaW5hdGVkIGZyb20gYW4gRXh0ZXJuYWwgU291cmNlLiBVc2UgcHJvcGVyIGNhdXRpb24N
Cj4gd2hlbiBvcGVuaW5nIGF0dGFjaG1lbnRzLCBjbGlja2luZyBsaW5rcywgb3IgcmVzcG9uZGlu
Zy4NCj4gDQo+IA0KPiBIaS0tDQo+IA0KPiBPbiAxLzE3LzIzIDA1OjQxLCBOaXB1biBHdXB0YSB3
cm90ZToNCj4gPiBJbnRyb2R1Y2UgQU1EIENEWCBidXMsIHdoaWNoIHByb3ZpZGVzIGEgbWVjaGFu
aXNtIGZvciBzY2FubmluZw0KPiA+IGFuZCBwcm9iaW5nIENEWCBkZXZpY2VzLiBUaGVzZSBkZXZp
Y2VzIGFyZSBtZW1vcnkgbWFwcGVkIG9uDQo+ID4gc3lzdGVtIGJ1cyBmb3IgQXBwbGljYXRpb24g
UHJvY2Vzc29ycyhBUFVzKS4NCj4gPg0KPiA+IENEWCBkZXZpY2VzIGNhbiBiZSBjaGFuZ2VkIGR5
bmFtaWNhbGx5IGluIHRoZSBGYWJyaWMgYW5kIENEWA0KPiA+IGJ1cyBpbnRlcmFjdHMgd2l0aCBD
RFggY29udHJvbGxlciB0byByZXNjYW4gdGhlIGJ1cyBhbmQNCj4gPiByZWRpc2NvdmVyIHRoZSBk
ZXZpY2VzLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogTmlwdW4gR3VwdGEgPG5pcHVuLmd1cHRh
QGFtZC5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogVGFyYWsgUmVkZHkgPHRhcmFrLnJlZGR5QGFt
ZC5jb20+DQo+ID4gLS0tDQo+ID4gIERvY3VtZW50YXRpb24vQUJJL3Rlc3Rpbmcvc3lzZnMtYnVz
LWNkeCB8ICAxMiArDQo+ID4gIE1BSU5UQUlORVJTICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICB8ICAgNyArDQo+ID4gIGRyaXZlcnMvYnVzL0tjb25maWcgICAgICAgICAgICAgICAgICAgICB8
ICAgMSArDQo+ID4gIGRyaXZlcnMvYnVzL01ha2VmaWxlICAgICAgICAgICAgICAgICAgICB8ICAg
MiArDQo+ID4gIGRyaXZlcnMvYnVzL2NkeC9LY29uZmlnICAgICAgICAgICAgICAgICB8ICAxNCAr
DQo+ID4gIGRyaXZlcnMvYnVzL2NkeC9NYWtlZmlsZSAgICAgICAgICAgICAgICB8ICAgOCArDQo+
ID4gIGRyaXZlcnMvYnVzL2NkeC9jZHguYyAgICAgICAgICAgICAgICAgICB8IDQzMyArKysrKysr
KysrKysrKysrKysrKysrKysNCj4gPiAgZHJpdmVycy9idXMvY2R4L2NkeC5oICAgICAgICAgICAg
ICAgICAgIHwgIDYyICsrKysNCj4gPiAgaW5jbHVkZS9saW51eC9jZHgvY2R4X2J1cy5oICAgICAg
ICAgICAgIHwgMTUzICsrKysrKysrKw0KPiA+ICBpbmNsdWRlL2xpbnV4L21vZF9kZXZpY2V0YWJs
ZS5oICAgICAgICAgfCAgMTUgKw0KPiA+ICBzY3JpcHRzL21vZC9kZXZpY2V0YWJsZS1vZmZzZXRz
LmMgICAgICAgfCAgIDQgKw0KPiA+ICBzY3JpcHRzL21vZC9maWxlMmFsaWFzLmMgICAgICAgICAg
ICAgICAgfCAgMTIgKw0KPiA+ICAxMiBmaWxlcyBjaGFuZ2VkLCA3MjMgaW5zZXJ0aW9ucygrKQ0K
PiA+ICBjcmVhdGUgbW9kZSAxMDA2NDQgRG9jdW1lbnRhdGlvbi9BQkkvdGVzdGluZy9zeXNmcy1i
dXMtY2R4DQo+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL2J1cy9jZHgvS2NvbmZpZw0K
PiA+ICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9idXMvY2R4L01ha2VmaWxlDQo+ID4gIGNy
ZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL2J1cy9jZHgvY2R4LmMNCj4gPiAgY3JlYXRlIG1vZGUg
MTAwNjQ0IGRyaXZlcnMvYnVzL2NkeC9jZHguaA0KPiA+ICBjcmVhdGUgbW9kZSAxMDA2NDQgaW5j
bHVkZS9saW51eC9jZHgvY2R4X2J1cy5oDQo+ID4NCj4gDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvYnVzL2NkeC9LY29uZmlnIGIvZHJpdmVycy9idXMvY2R4L0tjb25maWcNCj4gPiBuZXcgZmls
ZSBtb2RlIDEwMDY0NA0KPiA+IGluZGV4IDAwMDAwMDAwMDAwMC4uNTRlMDYyM2ViY2ZmDQo+ID4g
LS0tIC9kZXYvbnVsbA0KPiA+ICsrKyBiL2RyaXZlcnMvYnVzL2NkeC9LY29uZmlnDQo+ID4gQEAg
LTAsMCArMSwxNCBAQA0KPiA+ICsjIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wDQo+
ID4gKyMNCj4gPiArIyBDRFggYnVzIGNvbmZpZ3VyYXRpb24NCj4gPiArIw0KPiA+ICsjIENvcHly
aWdodCAoQykgMjAyMi0yMDIzLCBBZHZhbmNlZCBNaWNybyBEZXZpY2VzLCBJbmMuDQo+ID4gKyMN
Cj4gPiArDQo+ID4gK2NvbmZpZyBDRFhfQlVTDQo+ID4gKyAgICAgYm9vbCAiQ0RYIEJ1cyBkcml2
ZXIiDQo+ID4gKyAgICAgaGVscA0KPiA+ICsgICAgICAgRHJpdmVyIHRvIGVuYWJsZSBDRFggQnVz
LiBDRFggYnVzIHByb3ZpZGVzIGEgbWVjaGFuaXNtIGZvcg0KPiA+ICsgICAgICAgc2Nhbm5pbmcg
YW5kIHByb2Jpbmcgb2YgQ0RYIGRldmljZXMuIENEWCBkZXZpY2VzIGFyZSBtZW1vcnkNCj4gPiAr
ICAgICAgIG1hcHBlZCBvbiBzeXN0ZW0gYnVzIGZvciBlbWJlZGRlZCBDUFVzLiBDRFggYnVzIHVz
ZXMgQ0RYDQo+ID4gKyAgICAgICBjb250cm9sbGVyIGFuZCBmaXJtd2FyZSB0byBzY2FuIHRoZSBD
RFggZGV2aWNlcy4NCj4gDQo+IFdvdWxkIHlvdSBtaW5kIHRlbGxpbmcgcGVvcGxlIHdobyB1c2Ug
J21ha2UgKmNvbmZpZycgd2hhdCBDRFggbWVhbnMsDQo+IGVpdGhlciBpbiB0aGUgYm9vbCBwcm9t
cHQgc3RyaW5nIG9yIGluIHRoZSBoZWxwIHRleHQ/DQoNClN1cmUuIFdpbGwgdXBkYXRlIHRoZSBo
ZWxwIHNlY3Rpb24gZm9yIHRoaXMuDQoNCj4gDQo+IA0KPiA+ICsvKioNCj4gPiArICogY2R4X3Vu
cmVnaXN0ZXJfZGV2aWNlIC0gVW5yZWdpc3RlciBhIENEWCBkZXZpY2UNCj4gPiArICogQGRldjog
Q0RYIGRldmljZQ0KPiA+ICsgKiBAZGF0YTogVGhpcyBpcyBhbHdheXMgcGFzc2VkIGFzIE5VTEws
IGFuZCBpcyBub3QgdXNlZCBpbiB0aGlzIEFQSSwNCj4gPiArICogICAgIGJ1dCBpcyByZXF1aXJl
ZCBoZXJlIGFzIHRoZSBidXNfZm9yX2VhY2hfZGV2KCkgQVBJIGV4cGVjdHMNCj4gPiArICogICAg
IHRoZSBwYXNzZWQgZnVuY3Rpb24gKGNkeF91bnJlZ2lzdGVyX2RldmljZSkgdG8gaGF2ZSB0aGlz
DQo+ID4gKyAqICAgICBhcyBhbiBhcmd1bWVudC4NCj4gPiArICoNCj4gPiArICogQHJldHVybjog
LWVycm5vIG9uIGZhaWx1cmUsIDAgb24gc3VjY2Vzcy4NCj4gDQo+IFRoZSBzeW50YXggKG9yIHNw
ZWxsaW5nKSBmb3IgYSBmdW5jdGlvbidzIHJldHVybiB2YWx1ZSBpbiBrZXJuZWwtZG9jIGlzIGp1
c3Q6DQo+ICAqIFJldHVybjogLWVycm5vIG9uIGZhaWx1cmUsIDAgb24gc3VjY2Vzcy4NCj4gDQo+
IFRoYXQgc2hvdWxkIGJlIGNoYW5nZWQgaW4gbWFueSBwbGFjZXMgdGhyb3VnaG91dC4NCg0KQWdy
ZWUuIFdpbGwgdXBkYXRlIGF0IGFsbCBwbGFjZXMuDQoNClRoYW5rcywNCk5pcHVuDQoNCj4gDQo+
IFRoYW5rcy4NCj4gDQo+IC0tDQo+IH5SYW5keQ0K
