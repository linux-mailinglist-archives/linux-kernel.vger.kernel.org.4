Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCAD86E7AFC
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 15:36:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233231AbjDSNgF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 09:36:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbjDSNgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 09:36:03 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2075.outbound.protection.outlook.com [40.107.220.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D21B816DC4;
        Wed, 19 Apr 2023 06:35:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hJgrdRExyzaKjFFLhWo6n9nF0LsrXTZ8FI9koI2VJAztx5pE5Q2UZwmheDzRvsa9Ex6Yub+PMrj2XgDoCE6tftQQR11VIFMIunbK+DVmfMARwXONTOzQeJY013tzwqJ7TwqNfu3YYRxJMiDD/2zyZylu3mcobZBmOSHGU9u5xrC02fFxuzashplhhBTmidQ2ZH61z2e0nxDEOZqU8k/H9V6scr1u+qsSMS61tioUKLfstKhBNa/rJMg8M6p/iqPFEfZABX+CChJ5O9QKWFtEDXO1YLSrvus6yhaiJprBowSuMolbqNaoY9RrAddl4OOYeneDXC0WW+P3Gbw4Eeh6AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HDrvfqm99mXrPIGaxDtU1SsWpltytzk0hO7o0g/51i0=;
 b=bIsBwCy0Y/I+mN1JKRkvtE5zfb9SH1JZ2iYnyN1Jaqa7l3p+iLZhGx1TeeH0M1ASVJLT3Ga7Dbs3E6NuqlPvXVMuRZb+7LETfTmjb5n62nTS7calGCJSKBa0EQJ90OGFxi4hPiZN/lnNeNAYcgjlYdoOqOezzLwR616+1/v2AoW51rQmQz+rGIRZdGmgv5cAUTJAGdvAOFQARwuw708k1aINfq1TQ4C0lsZbr5nkRvm5hCI0HqT6BJVdfnvPLHvpmlHtTdfJkU6RHmiH1it6bInA0K0+8uxxTutQZVcTO2HcSZLf82c4pQDXejLUcgR31K9YKqGRUHNuoV6teJ/KvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HDrvfqm99mXrPIGaxDtU1SsWpltytzk0hO7o0g/51i0=;
 b=Fnh63SpmsyMdfY7mqVWGt2EkQPIsfKOjyXISHtgS3H0GnxvenaOTaZfzW4cmCbKDBihVtSTB7KJcIg5sbh9+5dS8CIakiP8MIqgZJ3gJ4FMTcQ60r6P+SX3srYLyDd8B/MSPc1nc4LeZB+g+HAoNq9HYZQS8rHFHcgsb9DHFxUA=
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DM6PR12MB4912.namprd12.prod.outlook.com (2603:10b6:5:20b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Wed, 19 Apr
 2023 13:33:45 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3f45:358e:abba:24f5]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3f45:358e:abba:24f5%3]) with mapi id 15.20.6298.045; Wed, 19 Apr 2023
 13:33:45 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     Jinpu Wang <jinpu.wang@ionos.com>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "clemens@ladisch.de" <clemens@ladisch.de>,
        Guenter Roeck <linux@roeck-us.net>
CC:     open list <linux-kernel@vger.kernel.org>
Subject: RE: k10temp show over 100 degrees temperature on EPYC Milan servers
 from DELL and SMC
Thread-Topic: k10temp show over 100 degrees temperature on EPYC Milan servers
 from DELL and SMC
Thread-Index: AQHZcqTui0B9RxAxSEKscEW2rQPq+K8yoUwA
Date:   Wed, 19 Apr 2023 13:33:45 +0000
Message-ID: <MN0PR12MB6101B5E3BCCB7B3BA28B9269E2629@MN0PR12MB6101.namprd12.prod.outlook.com>
References: <CAMGffE=65we13bDe=iOkkefF4PrNBNg96qi=ebU7nCs=GA6cCw@mail.gmail.com>
In-Reply-To: <CAMGffE=65we13bDe=iOkkefF4PrNBNg96qi=ebU7nCs=GA6cCw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-04-19T13:33:43Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=1b5e74af-932c-4a8d-9f12-b478cb3836ce;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2023-04-19T13:33:43Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 915f2db0-9caa-43e1-8118-e8e83a53675a
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB6101:EE_|DM6PR12MB4912:EE_
x-ms-office365-filtering-correlation-id: 1af4cbb9-726b-4946-798e-08db40dab2f3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7BxGwt5PINJAJKPKmX6g4CgZSPvdNU97+sdUGQAoDfQz2fJa7fPkaT68r588D6AQjhQd/A5q4NbhCFhuWqf1A/iIC/YPtCNm4ueYMraUWoud0xDgOZTmYMwLxyxowlh2muWp1a/hO8+tNPDblU/YyPKjK5xvBCU8Q+Y99c1yYBbuqrANz4EHxclbgTFmcUChCXkLZ2MVo8cr8mwi4h8zu5qZTMRWro6c/KL7kg87C1+qeHhxi6vEqslb9HHvsMRMCbuBvTl6+KJ1Nw4Z7gZzCZzoKJQ6Jp/PW7P/4f+5krG3ruC2wRk1yKosv8z1z4iFfbCnVTvgrq2O73ZyzcGdxnrKKSHqqFx9A00kqY2y2bJ9XrGzlb4f2oH4sOKYjsmlMIgsmDxFyLJ78vzDCHr9L6MXPLhu3SKZQDubkvelq1NeCWai3Mmd66jdo0xuOqRz/Bdq0R2finfVkMMxUeG4AT1OYzv2e/lrt7uWrOlpSNyk1NZu8wTdCwxjdhKpxFVsv8R7gd1owgAJcXWd+KVpA9+ghUmGVCR0/LW8bHnBBFtQ+Cn6KRgJq7XKQGMB9/xHD2t2RGtyKVRP5q9oWqAuoP/MxkOhcyhxgFOJSX33D2E=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(346002)(376002)(396003)(366004)(451199021)(8936002)(38100700002)(8676002)(122000001)(38070700005)(2906002)(33656002)(86362001)(5660300002)(52536014)(55016003)(478600001)(7696005)(71200400001)(110136005)(186003)(966005)(6506007)(66946007)(9686003)(76116006)(66476007)(66446008)(316002)(83380400001)(64756008)(66556008)(41300700001)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OU1nR0xIbDVyRDRGUXAyYzI3NW43cnhZQllYWGxNczZTbUgyNXNraVpiZmRN?=
 =?utf-8?B?YkdVM0lLT0ZzRU5MeGpJSzBQQ3NScGlIRFNJUzJBSDdZY1FLeWtQS01jUGcz?=
 =?utf-8?B?SXVGV0FueHpGWm1hWFJJWm9ZMjIwQVordjZMRENYdU1CclFnV2NWaVhSQmpV?=
 =?utf-8?B?a3d1K21aTUxrOHBHQm9yaE51WWJZSWE3VERROC9xeG10QUIyVDJ1Z2lBZUV4?=
 =?utf-8?B?eGxJZUtZYlczSGV4eEZSakRlZGlVVmVqVWJHTms5Z0Yxc0N2OExQTElTdEtE?=
 =?utf-8?B?dUN3VytFbVJUZ3dvSUVMSktsSmVSZThCMFJwSnRUUDFyUzI3MHhLR25ZWjBV?=
 =?utf-8?B?VTBxUUFjN1cwWUtQNTFhSlpGc3l3NG9GN0IxTGdGRVBENkJTUVNFUVpaSGkv?=
 =?utf-8?B?RjFMTHFyK25FaWdaNDFIQjRIQlFNamtXMkpGTzUwWEdkK3F4Z01MSjdHRnQw?=
 =?utf-8?B?WjJEajJyTHpLdEdvSHYwS3h2b2xRZk9tWE5jeklqb2toc2tkRlNubGtCLy9F?=
 =?utf-8?B?TGc2THppNXYxemdsTG5YMGtZSWVPTGRGL09MdEV5cmUxODZCV2JzMlMzTTlJ?=
 =?utf-8?B?ZFczTUJjYjN0TWNJbUtFOGQwNjJyY21uUXZlQTF0b0M3VEZiQVA2akhrUTcz?=
 =?utf-8?B?ODVwRFQ5b0ZLQ1luNGlHb0xSYXRwZ1k3bjBzdjVjY2JnQzhYczRmYUJIdytI?=
 =?utf-8?B?Y2dTb0Z0WGhMenhGUjVtKzJPem11dDhuWjhRUEFGaW9Oakw2ZVdHSG5RdTdQ?=
 =?utf-8?B?d29zYktsVXlKVDdGWGMyNjlxSzJnTEdCVkhjK2FaQ2pqUGloejBjeFVwUnI5?=
 =?utf-8?B?S2E5Tk1XVG0vVm1WSnliOUltbFZlTk9LZXExVXl3MHg1bFVIY2VacnU2aHFO?=
 =?utf-8?B?VDRUazJmTytLaE5VaFAyR2ZPcHZYL0tBamNXb1YwSktORVdDTG9RU3cxU0Fo?=
 =?utf-8?B?dGMxWWZGamhmMXdGSE9EUEFTTjJJY2V2UVQxMGx2M2sxczBQNkJUekZ4WVg1?=
 =?utf-8?B?S0RpcUlNZDdGdGl4cjVWNFNwall3UVlqeHYrblNPbEtkbWxBTkdiVlJDcFFJ?=
 =?utf-8?B?M3FmUGJSUUwyS0tyYm85NUpQM1NyUURTRFdtMjFYdXZFd21STUdvMHFrVG1N?=
 =?utf-8?B?eXVFTXlNaVNiL2ZsQzJXdU9oNXM5S0lrZG9OTXRTNUJiTWROeTdpOEM5ZUFW?=
 =?utf-8?B?dWltYTllbjRuazhlR2ZsbkFjMGR2Y3ZzV1pJREg0ZTRxTG9hQWtOaU8yMnU3?=
 =?utf-8?B?dkZUTkI5ZDVLY0dRVkNvMnM0MWJJbXc2QTI1L0JxN1hYcWZEcjNpZmN1OU51?=
 =?utf-8?B?QnVjWlpBamFncmtVSU00T0EyQkthNjlncTBQVThSZnR3RTFxT3Q4cGJXaXNt?=
 =?utf-8?B?VWhodnhlZ0FncXVVMUpyL2J6TWplbDJ3TlppVnZtNUwrSjdBckltMDVvd1I1?=
 =?utf-8?B?R3Qvd1ZRdXpSZm1OSUZPbytRcS9lZFNYS1BlaXlnTCtreGdBWXpXcjZISVoy?=
 =?utf-8?B?aU1qMGlQTTQxOG5LRXpramorYzJCOVRjYWJvNzNTdmJXTndYd1g5RUp4cjR4?=
 =?utf-8?B?bTNiRGNNV1lsWTk2S3NmN0U2Qzh5cHdpWTJJR2ZGYUh4VGFTdSt5NW85VFh0?=
 =?utf-8?B?SjBrVjhqNzZmcUZvdXp6dXZ0em9TOFNPODlTS2VITkltOHhKTWE2QjVxYkti?=
 =?utf-8?B?QVdpNmoxa3pmcDdHOUlpUWsvbzhtbU8rT01vbU9aZFpmeGRJbU0rSDJLbGVX?=
 =?utf-8?B?ZjlIOWtPYU9LNi9pTUY1RkZzYkcvYk02MzlsSTZvdUhxd3ptTWpnS0E0MklT?=
 =?utf-8?B?bEpCRDV1TitHaFFLYXFzNW4wRVBnR0ZXRUxyQjJyWTdENnMyQTJLSUZiTkQ0?=
 =?utf-8?B?ZWZoVjdIV3NicitiaHFCQU8yZGRrL3J1bFh6RmFyWFdhSXZMZFp6L2FMYkVU?=
 =?utf-8?B?QWErOGhtRVd4cUVrb3NCZVVSYmg3VGVIOHVRaU1jZzIxd1NCUzZDa0NTUGNk?=
 =?utf-8?B?d25vUVB0bmV1bzh0ZmZKTFdveVJUTVpFUG56UEhrQmxRSzRzMm1yVzBlOWdL?=
 =?utf-8?B?a2dyYlN5VUpSRk80aGlQanhvNVlwZkhFREswZFp1R0cydHhPMmpmNExYSVpH?=
 =?utf-8?B?eWhzS0tOZlN0Z0FlT0ZUcXpYanNsclRGM3VVOVJlbG82dkIwREdlM0tTYUNI?=
 =?utf-8?Q?m9ake2FO3B3lC7wb+5g7Dtg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1af4cbb9-726b-4946-798e-08db40dab2f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2023 13:33:45.2260
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aiylFOlzzY70CwYSHQjx1yq2+Pg9D+rwZ+KV8w+8frjBCPWntrPfHlqXBWxUDylAvZ0e1k8L57yIITg8Gznxgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4912
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

W1B1YmxpY10NCg0KSGksDQoNCj4gRGVhciBleHBlcnRzIG9uIHRoZSBsaXN0LA0KPiANCj4gV2Un
dmUgbm90aWNlZCBtYW55IG9mIG91ciBFUFlDIE1pbGFuIHNlcnZlcnMgZnJvbSBkaWZmZXJlbnQg
dmVuZG9ycw0KPiAoREVMTCAgYW5kIFNNQykgc2hvdyAxMDAgZGVncmVlcywgZWcNCj4gDQo+IHN1
ZG8gc2Vuc29ycw0KPiBrMTB0ZW1wLXBjaS0wMGMzDQo+IEFkYXB0ZXI6IFBDSSBhZGFwdGVyDQo+
IFRjdGw6ICAgICAgICArMTE3LjXCsEMNCj4gVGRpZTogICAgICAgICsxMTcuNcKwQw0KPiBUY2Nk
MTogICAgICAgICs2Ny4wwrBDDQo+IFRjY2QyOiAgICAgICAgKzY1LjLCsEMNCj4gVGNjZDM6ICAg
ICAgICArNjMuMsKwQw0KPiBUY2NkNDogICAgICAgICs2My44wrBDDQo+IFRjY2Q1OiAgICAgICAg
KzY3LjLCsEMNCj4gVGNjZDY6ICAgICAgICArNjMuNcKwQw0KPiBUY2NkNzogICAgICAgICs2NC4y
wrBDDQo+IFRjY2Q4OiAgICAgICAgKzY0LjjCsEMNCj4gDQo+ICBzdWRvIGxzY3B1DQo+IEFyY2hp
dGVjdHVyZTogICAgICAgICAgICAgICAgICAgIHg4Nl82NA0KPiBDUFUgb3AtbW9kZShzKTogICAg
ICAgICAgICAgICAgICAzMi1iaXQsIDY0LWJpdA0KPiBCeXRlIE9yZGVyOiAgICAgICAgICAgICAg
ICAgICAgICBMaXR0bGUgRW5kaWFuDQo+IEFkZHJlc3Mgc2l6ZXM6ICAgICAgICAgICAgICAgICAg
IDQ4IGJpdHMgcGh5c2ljYWwsIDQ4IGJpdHMgdmlydHVhbA0KPiBDUFUocyk6ICAgICAgICAgICAg
ICAgICAgICAgICAgICAxMjgNCj4gT24tbGluZSBDUFUocykgbGlzdDogICAgICAgICAgICAgMC0x
MjcNCj4gVGhyZWFkKHMpIHBlciBjb3JlOiAgICAgICAgICAgICAgMg0KPiBDb3JlKHMpIHBlciBz
b2NrZXQ6ICAgICAgICAgICAgICA2NA0KPiBTb2NrZXQocyk6ICAgICAgICAgICAgICAgICAgICAg
ICAxDQo+IE5VTUEgbm9kZShzKTogICAgICAgICAgICAgICAgICAgIDENCj4gVmVuZG9yIElEOiAg
ICAgICAgICAgICAgICAgICAgICAgQXV0aGVudGljQU1EDQo+IENQVSBmYW1pbHk6ICAgICAgICAg
ICAgICAgICAgICAgIDI1DQo+IE1vZGVsOiAgICAgICAgICAgICAgICAgICAgICAgICAgIDENCj4g
TW9kZWwgbmFtZTogICAgICAgICAgICAgICAgICAgICAgQU1EIEVQWUMgNzcxM1AgNjQtQ29yZSBQ
cm9jZXNzb3INCj4gU3RlcHBpbmc6ICAgICAgICAgICAgICAgICAgICAgICAgMQ0KPiBGcmVxdWVu
Y3kgYm9vc3Q6ICAgICAgICAgICAgICAgICBlbmFibGVkDQo+IENQVSBNSHo6ICAgICAgICAgICAg
ICAgICAgICAgICAgIDI0NzkuNzA1DQo+IENQVSBtYXggTUh6OiAgICAgICAgICAgICAgICAgICAg
IDM3MjAsNzAyOQ0KPiBDUFUgbWluIE1IejogICAgICAgICAgICAgICAgICAgICAxNTAwLDAwMDAN
Cj4gQm9nb01JUFM6ICAgICAgICAgICAgICAgICAgICAgICAgMzk5Mi40Mw0KPiBWaXJ0dWFsaXph
dGlvbjogICAgICAgICAgICAgICAgICBBTUQtVg0KPiBMMWQgY2FjaGU6ICAgICAgICAgICAgICAg
ICAgICAgICAyIE1pQg0KPiBMMWkgY2FjaGU6ICAgICAgICAgICAgICAgICAgICAgICAyIE1pQg0K
PiBMMiBjYWNoZTogICAgICAgICAgICAgICAgICAgICAgICAzMiBNaUINCj4gTDMgY2FjaGU6ICAg
ICAgICAgICAgICAgICAgICAgICAgMjU2IE1pQg0KPiBOVU1BIG5vZGUwIENQVShzKTogICAgICAg
ICAgICAgICAwLTEyNw0KPiANCj4gV2UndmUgc2VlbiBzdWNoIGhpZ2ggdGVtcGVyYXR1cmVzIGV2
ZW4gb24gIGlkbGUgc2VydmVycy4NCj4gDQo+IFdlIGFyZSBydW5uaW5nIExUUyBrZXJuZWwgNS4x
MC4xMzYsIGJ1dCBjaGVja2luZyB0aGUgZ2l0IGhpc3RvcnkgZm9yDQo+IGsxMHRlbXAgZHJpdmVy
LCBJIGRvbid0IGZpbmQgYW55IG1pc3NpbmcgZml4Lg0KPiBNeSBxdWVzdGlvbnMgYXJlOg0KPiAx
LiBJcyBpdCBub3JtYWwgdG8gaGF2ZSBzdWNoIGhpZ2ggdGVtcGVyYXR1cmVzIGZvciB0Y3RsPyAg
Y2FuIHdlIHRydXN0DQo+IHRoZSB2YWx1ZT8NCj4gMiAgRG8gd2UgbmVlZCB0byB3b3JyeSBhYm91
dCBzdWNoIGhpZ2ggdGVtcGVyYXR1cmVzPw0KPiANCj4gVGh4IQ0KPiBKaW5wdSBXYW5nIEAgSU9O
T1MgQ2xvdWQuDQoNCkl0J3MgZml4ZWQgYnkgdGhpcyBwYXRjaCB0aGF0IHdpbGwgYmUgZ29pbmcg
aW50byA2LjQuDQpodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dp
dC9ncm9lY2svbGludXgtc3RhZ2luZy5naXQvY29tbWl0Lz9oPWh3bW9uLW5leHQmaWQ9MWRjOGUw
OTc5NjdiNjlhNTY1MzFjOWNjYjcwYjg1NDc3MTMxMGU4NQ0KDQpHdWVudGVyLA0KDQpJZiB5b3Ug
ZGlkbid0IGFscmVhZHkgc2VuZCB5b3VyIDYuNCBQUiwgY2FuIHlvdSBwbGVhc2UgYWRkDQpDYzog
c3RhYmxlQHZnZXIua2VybmVsLm9yZyB0byB0aGUgcGF0Y2ggaW4geW91ciB0cmVlPw0KDQpUaGFu
a3MsDQo=
