Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 855725F7BCF
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 18:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbiJGQt1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 12:49:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbiJGQtX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 12:49:23 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2075.outbound.protection.outlook.com [40.107.220.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 747D9ABD6B;
        Fri,  7 Oct 2022 09:49:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=by3ev7dCndCrm3YjuYqjIRkpcFtfEzj/ugrnybbHO3z9KIOrsvCpU7Q2KiKar7GV+6p3j3tllmxskqW9r0Ov6OCOBTi9Ed/0lCsZl+JHABgJUDNeXpY5eWpMK2lsUM/wf0CnFOC4hxW38A3FVApekc5BAnsA1zDQ811QU1Kt8zAHWDbgr/C6ayTY1g0mQvqAEgXtx6sMwJKO2nzRS0k5t/RpKmln3N6pl1sdnJxMcrcGkWJ5CZJKjzaevzYjKjmjBwsFjY8p8YnasGj0hiVC/IKBtn6rBc4opofIDrMJsC6poKFQNm77X1Jo2TFkbzidZ9sIdObcBlTm81zeU8Ey7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UI3maRFCDGtvjbvghjS4nqCX3RfN0IUjfhwN5bCb1CU=;
 b=U66U59K/YgsvhgyoLn+rMBFo2DW4GtkPdwRJeYYJBZvp27oO42tikQ8e+Ca17D3XWe6tW6dpOyVFH1Drh1S/p+ElEG0+DBWF7r5ON5xul4NKb9pAPg+NVyElP1v6xBWCupQdcg/+o8Jn/WxVaD64ozixPLQ7OcvDeCSoRs4hHq5Wb9UMZ0JjmwoG72wWZzAzN1CHpjU4JpLTgPx6ZMFPzdJkXiGP8UZDfHrN10m7RKOY8iP4fg3crYNDA4k0rDwCaDCdGldUCES5u6r8msSAJ399UygoHnfK595tFVuKohUiYs9yvzpgrfIFW5tfZ7DpYhaFN18vnBlR6JG5CEgfmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UI3maRFCDGtvjbvghjS4nqCX3RfN0IUjfhwN5bCb1CU=;
 b=nIZ1Ig6UnoU7ssBdrht2rN1GHlo3lvw/D/+ZtIFDEjkuYpUNuqPwBjga5fYzqXerWpsOMFsqujJrKsJFTW45rHSnTQo+soYa0YuYP9Dk70be48krUldxIIUZA5p2CI3Vn6tai5QnOU9okzaEHDm71s2WTcyi4P8+fdpZqteJ1eVmJauWvTMiYVq3128+VlvwoNdKFoiCsxPC9lallUEBR3IwjfybThBLpARTGwgVvfC0sF+2cU00SnhIWimUWU8FfkmQnFe7TwFNEXKiOfsknX+hcTuG3KP0Ed62YhslA7denLI/pUJL++D00iLFg9od8n1y3f56gCgU7nvtVJChrw==
Received: from SJ0PR12MB5676.namprd12.prod.outlook.com (2603:10b6:a03:42e::8)
 by SJ0PR12MB7066.namprd12.prod.outlook.com (2603:10b6:a03:4ae::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.26; Fri, 7 Oct
 2022 16:49:20 +0000
Received: from SJ0PR12MB5676.namprd12.prod.outlook.com
 ([fe80::3c98:4af6:e849:aa5]) by SJ0PR12MB5676.namprd12.prod.outlook.com
 ([fe80::3c98:4af6:e849:aa5%4]) with mapi id 15.20.5676.031; Fri, 7 Oct 2022
 16:49:20 +0000
From:   Besar Wicaksono <bwicaksono@nvidia.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>
CC:     "lenb@kernel.org" <lenb@kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "guohanjun@huawei.com" <guohanjun@huawei.com>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        Thierry Reding <treding@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Vikram Sethi <vsethi@nvidia.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v2] ACPI: ARM Performance Monitoring Unit Table (APMT)
 initial support
Thread-Topic: [PATCH v2] ACPI: ARM Performance Monitoring Unit Table (APMT)
 initial support
Thread-Index: AQHY05p5Zh4pJFmZEk6UwzpU+Lc4ma34QdUAgArvWTA=
Date:   Fri, 7 Oct 2022 16:49:20 +0000
Message-ID: <SJ0PR12MB5676564A23D3E66E258AA4A2A05F9@SJ0PR12MB5676.namprd12.prod.outlook.com>
References: <20220929002834.32664-1-bwicaksono@nvidia.com>
 <CAJZ5v0iBZRZmV_oU+VurqxnVMbFN_ttqrL=cLh0sUH+=u0PYsw@mail.gmail.com>
In-Reply-To: <CAJZ5v0iBZRZmV_oU+VurqxnVMbFN_ttqrL=cLh0sUH+=u0PYsw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR12MB5676:EE_|SJ0PR12MB7066:EE_
x-ms-office365-filtering-correlation-id: 9c280229-e99a-4b9f-342d-08daa883e1a0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2st28ZeT0r1Z3xo5Z2vjCNwNuIyBZ1I5p8CDCo8NjlaYinsE0zc/49T3z6kAaxg/Gq5pQ3mZ1jmCDamSGTg8dLDqO4FJVkXKjj6WiaIFjBNb3vb+cz82IMekVbQfJ7lObNf/nUzC/1pBMJmxdBpuYngcq0AxQvsuQDFKegJ2X92FUYPwtLUAFubv4HeBaK4vBZRbNdO0dzf0msQgDWtXzD6RkszgXHlmESiPixcJfdaLQ+Tp2F0kIwzZKCNwYG033+4/8kgeFEzK2+Hq5LYaiPHJPrtvLSsuxml6taVjMtpmLGqXdoFOxMeHdce+CQR60W7dOkA5Zuq9yFeOGYsKlMX5M6Oy/c1FhDX/3k2DZDTsoFBOxCEE41xJV0kzh7e0unbMD/xd/40c5xS/MV9FYDkv9Z2bUYZIwiQX+F667wMXPCMbq1JuTit0aiP1ynv4+qB/Mfq1ZAHs8ACJzbmQ8CaN7CfsofKREz0hdLjcmRs4ywYvLnj2yBxO6AQUGfK1vG70J12v1EQ508EVX+o50Jkwn32UWKBJvIEk7XVTcldpzdjdaFAwaFwetzmbwk0mvBqBGyIP0qmGvw6gQhtspXJ1CWob201iTN1g3jQut6uYFEqajEimbvOe38NsWuCfV0KK9AN8geXC5PLOfFhdESrpypA9VL44h9pHIiU+3DfW3lKGqEogiH+C8DroNsxzA7y29rGby5JlBKK3fZJjJCE7ioKbpFjp7x4DmslqV7g+UcXkQR7lcPImXoTYlI3Q/b5fmdBWZBHKi21NUKyKbg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR12MB5676.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(39860400002)(366004)(136003)(376002)(451199015)(122000001)(110136005)(71200400001)(7416002)(5660300002)(52536014)(66946007)(8936002)(4744005)(76116006)(2906002)(33656002)(9686003)(66556008)(66476007)(6506007)(316002)(41300700001)(26005)(66446008)(64756008)(38070700005)(4326008)(83380400001)(7696005)(86362001)(8676002)(38100700002)(186003)(478600001)(54906003)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VGJkV0NJa3piek9Tb0l1STRwVXR6Q3dGWDRXZThodmdrUzlxWlc0dnBBZUxj?=
 =?utf-8?B?WXRKRFlMNENpa1FkUXZUTHkra3NJOWUvbkxSSUU3QkozdzBEMW9Fcit1c1lL?=
 =?utf-8?B?TEhVck1ua3lhS3hCc1pid3RJV1lvRWljS0hWa3g5RGUvS05EVmlwaEJ6NE95?=
 =?utf-8?B?eml1WU00bDUxTHdZbkFUbmNwTlhRZ3pKYkRKdVY0blhYeklMbHBOZFB3N3ZN?=
 =?utf-8?B?S2dYaUdTVWhzUVJZUkNOeTZIdmpXaHh6cDVBRjhiNUZMdmI5VlZJYUdBVlNG?=
 =?utf-8?B?aEZUYzFqR1BxditWeEM5bjJmY1dFL09ZL1JCRHhqNXF5NkVyMjUxWEthMGFs?=
 =?utf-8?B?UGJReXFrWUhBYUJMNGNMcElpNDFGdGNMZ3Z3WTBwK1BBUUVsbE5zRXZrcXJU?=
 =?utf-8?B?Q29FWkwxb2V6YU9iWFUxdnM3MFU5c3VLQWFTVWlUcHZmN2RIWkp3VFZoYmlY?=
 =?utf-8?B?OHJXNFZybmR5c05UY1ZsZHlXVk42ek9rVk9lWXhEY3BMODlxa2RpRkNYakUy?=
 =?utf-8?B?UVhKalIvNVhoSmx2UVZRWWplUVgxay9US2ZVVDcwOEp6WXZkUk1EOVRBNzMw?=
 =?utf-8?B?bERpSzVpZXB1OUlLUWh6cEs5bEd0cjZXQk1PZDFNM0tnQzlmMGtiSkwzeUxh?=
 =?utf-8?B?ZSt2ZDFmL2lRLzU3dXR5UW5ZMy8rZlkxOUNBdXFxd0RqR1FpNGRVaExWRklS?=
 =?utf-8?B?NDFSRWl4QXhyajhpUGVaSlp2SnpIN3FQMVRFeXJvRGdoQmZ1a1ZLdlFqQ284?=
 =?utf-8?B?OXJFRWh6SEhleTU0T1dzQmNqczRuNUpHM21vVVJ5dTFJMSt1WTdxZ2creStU?=
 =?utf-8?B?ZzZ6U3hUMkJDanY2alZmbk03eFplWklOak1vYWVXYXhvOUV4dlFESE5ncDhG?=
 =?utf-8?B?SFNBTk1tVkd2MEhNeTR3ZzAxQ0hzYWxtR0RpcExDM2kzY2oyKzZ1K0loYVp2?=
 =?utf-8?B?RkovN3lMTzRhL0dkTDFJZ1dEbnhxUEwzREFQR3REcUNqaEZvZ1hEM1preFMx?=
 =?utf-8?B?VmphbTNnSHJodWVUdXMzNjJjQmZpam9vd3ZBN2lwcEdwckpMS1I3NjBCWDJ6?=
 =?utf-8?B?SU0xbXVIdHNXRzhHREtQZm5IaVlTQXBIMUs5bkQxMHdnRmNJcFRnc21iWHFK?=
 =?utf-8?B?d0NkdWc1M1BwSGpTVGVHTzQxdjh5QThObTI0d1ZCcExQemZYV3BaQ1lpNGx1?=
 =?utf-8?B?RXlmQmE2MzRDZVhBL1JxQ0VrUS84bGRLNFRtR1FTZDY2OStuaVBIRCs5TzRm?=
 =?utf-8?B?Y0dTUTNDVXhSeFlMNU1lOUlzYmI0T1BISTU5amQzVnhjM1JHMzZFai9yR1Bp?=
 =?utf-8?B?TVFoOXpiK0ZXRWdDTFJwTnFBOGU0eHdURGZ3YUJrS1ZrRkhSVnprcHU0a1Jm?=
 =?utf-8?B?YzV3OVV2MTZjdXM4blZZNEgyelo5SnVEWnhpcEhMZ2JuMFJuVGFySWhlTkxW?=
 =?utf-8?B?YnY0L0ZrYWtzdmh0cW1QYXcxR3F6ZVlMZ1FndlNsdWQ5WU9aOVcrR1hTbm41?=
 =?utf-8?B?QVNNZ3VMeFlSenRUbUNJeUgwRUZ2UlFIWFI5WERlazhlNDdmRHBLZWJjckhi?=
 =?utf-8?B?TUtyYVJva1pscy8rV1dSNTBnZ0N2SVZ4OXNXblFEamNQN3hQaG4wU2NNQk9z?=
 =?utf-8?B?akY3U01oVnRzSTRDQ0Q4STd3bkI4THduUFlDaDFKTEVzMThYZ3dJV2tsa1RB?=
 =?utf-8?B?OVgraVJMKzBjVVdZQVVmTUZCb0hLRXFJZVBEaWl5ellWd2lCN25FWHQxZ0FB?=
 =?utf-8?B?NG9JSHdWNERETjBVbTZFdDdRTnNnUGtZaHZFZ2VpS3pDWFVSUlA4OHZ3cHRF?=
 =?utf-8?B?UXNvL09YQkt3ODgwWitNRkVUWDhyQjRTNUQ3eklxdFZZeE4zZWk0RkVka3VB?=
 =?utf-8?B?RThER1ZnRkp3MU44ZUNKdTltN3dwS3NJc2pDZmx5U3VUalNnSVFRZkMrZnhs?=
 =?utf-8?B?Rkw2eWVUdzFMZjVNc3h5enJhWDhwWlQwdWpQUlRHVU5GbXI3R3B3VWpjV3Va?=
 =?utf-8?B?Qzd0SS8vekZBbERJTmhqa25CeElxY1ZBZW5XRzhualIxLy9nZ3paNlNtT0NX?=
 =?utf-8?B?akxEd0ZOcTR0bHJpZVg0T0lueXFkK1h2OU0rWDFVS0NHd0tQeGl0aDhrY282?=
 =?utf-8?Q?eOJVFCX1YDUtXW13f5CymJB0T?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5676.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c280229-e99a-4b9f-342d-08daa883e1a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2022 16:49:20.5276
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YZYENOeBquR1aGnXQxJtXtRxWxzbGWesG3XBN2k01M3tmoG9ZliFkuHF5OG92zhkFxsyw1YP/KUTDGnniUaUhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7066
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Li4uDQo+ID4gVGhlIGluaXRpYWwgc3VwcG9ydCBhZGRzIHRoZSBkZXRlY3Rpb24gb2YgQVBNVCB0
YWJsZSBhbmQgZ2VuZXJpYw0KPiA+IGluZnJhc3RydWN0dXJlIHRvIGNyZWF0ZSBwbGF0Zm9ybSBk
ZXZpY2VzIGZvciBBUk0gQ29yZVNpZ2h0IFBNVXMuDQo+ID4gU2ltaWxhciB0byBJT1JUIHRoZSBy
b290IHBvaW50ZXIgb2YgQVBNVCBpcyBwcmVzZXJ2ZWQgZHVyaW5nIHJ1bnRpbWUNCj4gPiBhbmQg
ZWFjaCBQTVUgcGxhdGZvcm0gZGV2aWNlIGlzIGdpdmVuIGEgcG9pbnRlciB0byB0aGUgY29ycmVz
cG9uZGluZw0KPiA+IEFQTVQgbm9kZS4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEJlc2FyIFdp
Y2Frc29ubyA8YndpY2Frc29ub0BudmlkaWEuY29tPg0KPiANCj4gQWNrZWQtYnk6IFJhZmFlbCBK
LiBXeXNvY2tpIDxyYWZhZWwuai53eXNvY2tpQGludGVsLmNvbT4NCg0KVGhhbmtzIFJhZmFlbCEN
Cg0KPiANCj4gZm9yIHRoZSBjaGFuZ2UgaW4gYnVzLmMsIGJ1dCBhcyBhIHNpZGUgbm90ZSwgaXQg
d291bGQgYmUgZ29vZCB0byBtb3ZlDQo+IGFsbCBvZiB0aGUgQVJNLXNwZWNpZmljIGluaXRpYWxp
emF0aW9uIGludG8gb25lIHBsYWNlLCBzbyBpdCBpcyBub3QNCj4gbmVjZXNzYXJ5IHRvIHRvdWNo
IGJ1cy5jIGV2ZXJ5IHRpbWUgYSBuZXcgcGllY2Ugb2YgaXQgaXMgYWRkZWQuDQo+IA0KDQpTdWRl
ZXAsIGRvIHlvdSBoYXZlIGZ1cnRoZXIgY29tbWVudHMgPw0KDQpUaGFua3MsDQpCZXNhcg0K
