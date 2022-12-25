Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58A44655DCB
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Dec 2022 17:43:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231445AbiLYQnH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Dec 2022 11:43:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231447AbiLYQms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Dec 2022 11:42:48 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2049.outbound.protection.outlook.com [40.107.94.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF1441170;
        Sun, 25 Dec 2022 08:42:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BmPjzuTaSbULjXDm0xZ7iA5I8iVJpAlEz52GqcG/9dENR0Qs8+z/Cw/uYuU0pSoTvmBr4+m5ajNOeA3hEdtrUdLpYyLeOjDiuyTZV0nsEXvukL9kj4BbkIKLJx8xzE5N9svEKQzCPjjBTMyWbCZ+6badiUeOtTZzZAW3EUi+IrBUMXt8Z7oPY9eDAdi09mn0FejD3/qTewSqJbvFtuWlCBwIrf9HzcTbsZvG0wJRODQySbEyxtMVC3Vlguh9xtFVnc78BITwea0HverGhmeHvCt67+BnTnIxHysJ74yOjgWwq0GG4GWjoABmREGHylf719La0r1tQi9SCCr073Ix/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BeqiwvKUaP0qCjb2t2YGzRRr4998CEcqqdrg2iFnsHk=;
 b=TS6/NWgpHSzJ7/eFBNkNN6r2c7H2BVvxLSB/1RAzUt57rDD2ttNH+tEgLQPyCTikvnCUt7+2FnLvEHL4fxIR5fQtoT67TdEkDlfKUHbCsCY23u4QPKg+mtCXptSWAVCNgfW5tQad+CgVJ4YbpOhVT0/j1gAS9XYG8jUuSAKJGPnnMpluajr+hhoOT4+Cza9QtRFnlwZE+81nPMITnsfRmrSE3wMTcHk0aY2cfkqhMpNKyZImqaISvu1g9uAkVbxvigEWQpS0noQ/eEhrxt0upGCtDjGuCJ9v6GmoaJXE0QEnJqpT4bi7V/kqyDUK1MO/Ryvs0LjviM3wD8CUfU0rrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BeqiwvKUaP0qCjb2t2YGzRRr4998CEcqqdrg2iFnsHk=;
 b=vj57Z9KIPgXpwJmqUrdlLVr/uo/Px1DIXCVB0baGvE6bIKzqisQPsDXWcH1hahaRlJHZ5JEplhmJ0hIyKM4oUxKhc4Ndh19Wiv3ymtUqw9HjYXRsWljaFse8jJ0FryG9pxo60Jb5poIWqW+YKd0iDDpnD59hdyjxArpAPFHS6Bs=
Received: from DM4PR12MB5278.namprd12.prod.outlook.com (2603:10b6:5:39e::17)
 by CH2PR12MB4860.namprd12.prod.outlook.com (2603:10b6:610:6c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.14; Sun, 25 Dec
 2022 16:42:35 +0000
Received: from DM4PR12MB5278.namprd12.prod.outlook.com
 ([fe80::960b:6963:b27e:f9ed]) by DM4PR12MB5278.namprd12.prod.outlook.com
 ([fe80::960b:6963:b27e:f9ed%9]) with mapi id 15.20.5944.015; Sun, 25 Dec 2022
 16:42:35 +0000
From:   "Yuan, Perry" <Perry.Yuan@amd.com>
To:     "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
        "Huang, Ray" <Ray.Huang@amd.com>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>
CC:     "Sharma, Deepak" <Deepak.Sharma@amd.com>,
        "Fontenot, Nathan" <Nathan.Fontenot@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Huang, Shimmer" <Shimmer.Huang@amd.com>,
        "Du, Xiaojian" <Xiaojian.Du@amd.com>,
        "Meng, Li (Jassmine)" <Li.Meng@amd.com>,
        "Karny, Wyes" <Wyes.Karny@amd.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v8 12/13] cpufreq: amd-pstate: convert sprintf with
 sysfs_emit()
Thread-Topic: [PATCH v8 12/13] cpufreq: amd-pstate: convert sprintf with
 sysfs_emit()
Thread-Index: AQHZE3VHg8qHcncn4EmrFFaIS5ukQq513QMAgAj66mA=
Date:   Sun, 25 Dec 2022 16:42:35 +0000
Message-ID: <DM4PR12MB5278DDD511B2708BEB3DB92B9CEF9@DM4PR12MB5278.namprd12.prod.outlook.com>
References: <20221219064042.661122-1-perry.yuan@amd.com>
 <20221219064042.661122-13-perry.yuan@amd.com>
 <8c6d4a0a-065d-cd01-7799-5f6603c0ebb8@amd.com>
In-Reply-To: <8c6d4a0a-065d-cd01-7799-5f6603c0ebb8@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-12-25T16:42:32Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=507cdbf2-d5b8-4c70-b563-2365638ea2b3;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-12-25T16:42:32Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 4d5f67ca-e483-4668-9896-986259fb03b6
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5278:EE_|CH2PR12MB4860:EE_
x-ms-office365-filtering-correlation-id: d264a56f-31ee-4f2b-21ec-08dae69706b2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RgSTWAWOi6uacBu0Q7lObfYspyUcVYTLUcParZcQ7MmuSEkC9jOUVHSiuEfYZ34D5DedW9zVFKULmAWBWh0KNuTSMtgc1zX27GA7x2sAIGWCXn7xxjRG0FJQX4ZGKIYw5/HML023c0nf9q8Gn/BjXgsR6JCpWDhN8DbP0mLhlt2Wqr677SM6Sd5ldf2jEItppoPZbtj54POemTqepW6zTna7QFLVZTuDdChFjSl6Pr/f6yQGGSCK1X3ppMhoEHQ6YVy1Ifd711HIHbK99pDO3n2M5NENRAqRmzNiyQiZ4+hbFGeRnNzbwCRLdcBirZoKg2fE7VhGR4Zy558b5JTMPtFTESj80Blb4Fhfncv51fxAZmM5KCwR0Ob9AxISGQns0u6ANWhXvbPMrRkMYIqoaxa0e3tfQgihEel2Qv1xyNS5n/YxQJdcn1Zi3pKZB+WOykG2ewlaYJERVZ3ZMOotN1IEluA7SJLu7TVu/czMq+zzGhT1U++dTUeDF2TcF7Hky+rHeQAl5X8/CjTrdjbI4zk3SgTpcoApYNJmofopykjsEd4lByHqA/975KQZPitMiRhqMGaR2WA3/lmOBhJZNk8SMKhzYjjt89vs2V6BoUKGoqpTQj3ftL4TpHaGEgC7CbxgKHuaeF2akApxvJkPS/SMAHvxsTPJ+7lvogH95qWo117Lq/2MhRvnkRHHLuTH3kvzdRW5Hyy4FPL6mSuvIA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5278.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(366004)(396003)(39860400002)(376002)(451199015)(83380400001)(2906002)(54906003)(33656002)(110136005)(316002)(38070700005)(26005)(478600001)(9686003)(186003)(53546011)(122000001)(38100700002)(7696005)(6506007)(71200400001)(86362001)(55016003)(4326008)(66476007)(8676002)(66556008)(64756008)(52536014)(66446008)(8936002)(41300700001)(76116006)(66946007)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dFA3VjV4UDNNRmNUaFc2ZnIvVDVDVExhd3A5SFlBMnhKMHFGSUMybDlKeXg5?=
 =?utf-8?B?UnlkbFRzR0xzNkhsNDI4QUtPOEdaTWx0K0NHQUI3SlE5bkJFaG40NmRaNWsy?=
 =?utf-8?B?eXdHN1UybWRrQW9qM0NtbGdjdXQvL2tuWTA0TGd2NWxadXFIaElzOFhwUWtW?=
 =?utf-8?B?NGZ1ZUhWNG9pYU91M3pSdUx4Ukk0N2RERHFiVGZXWCs4a1J3WkphbC9uUjRr?=
 =?utf-8?B?aUN6SWhtalNPeUJCSWRPcU45eVZITGJqTVdnR0NFeDE3NVN5ZElLbUtuS1lm?=
 =?utf-8?B?QzFZSTNyeE1qZ0Y4WC9OUkZSWXdLQzRlUVIzbFQ5bEVpNVE1S0pNYTNyby9S?=
 =?utf-8?B?NmYxSUxIZDMxaUlKcERLbDJhZ3R5ZXJtKzZZSkVTbkJwNnVjT09NZlpTTFFk?=
 =?utf-8?B?MmFmUnA0S2NCRXRoTEE3T1d6NDBPa2Y5RHdKcUR5Ly9qeGhSdnN2NFFYTlFJ?=
 =?utf-8?B?UGJuVkRjWjJIajVqVXdXaDdIKzg3RTJEcHRMREU1czdBZlJDdlExSG9Tam0r?=
 =?utf-8?B?M1I3b1I1NkxMclhMODRpeTd6ZTNmQ0RKaHEvOTFqWmF5WnRrRmRpQlpkVEVp?=
 =?utf-8?B?WUhhMXRYNDl5ZGdSMUY3cElDS0x5QUlJNDc2Snp6Njl6MmtHOWp6N3FjUHRq?=
 =?utf-8?B?cTdMRU1oNXVvci8zNDJQZGtVM1JBQjR0YTRTVFlGQUJwa3VNOGxMTWFOK2E5?=
 =?utf-8?B?TDJoUkROTkdydnFjUE1md0NCRW84S0V4VGN1QkZLeFhQK3hkREtDbjFrRWQ4?=
 =?utf-8?B?YmtxWWg4TDZRcFMyakpJOUUxUTdmTG1mQXJZYVpFRGpmUlNJaWR3RTFGNWNz?=
 =?utf-8?B?SjhWaXJxdnFSU045ZHpuTEZNRWdGNW5qTmZSVzZtc1d2QmxFSFBGTHpORkxO?=
 =?utf-8?B?RHJ6amYwM0piYzRwcnFXR1owWlBRQkZuSEdrSDBvem1BU1IrVUduVGhGOUhz?=
 =?utf-8?B?Y3dGOHd2T1E3dEUwVk9SaHo1Ti9CTTY0bG9KOGFVL0htdkEvcUVtNjNrN2dl?=
 =?utf-8?B?OTFQRERrczFpYUdRMndTZ2o3R0tvZUdlaFVCYUI5cFdUcHJxRlhUV1lNcFZR?=
 =?utf-8?B?RmxMZ3hHVmVEQ0orYkJ0US9SVStObmdUMTRGejVsNnQ3ZmV4dEdmRnFGTXBz?=
 =?utf-8?B?WWMyR0JCSGtVeHFNOG9jZkdqUjdLaHdtZld6dDMvNUQ3Ry9KVnFpZ0NjbnJw?=
 =?utf-8?B?UU9jV1BVeUlUdi9DNnZLZXZBRkhnNHdWWkI1bjVzclp4a0RnNFMveTcveDJx?=
 =?utf-8?B?TlU4cTBjYm82YlltbnBic3dYdzl2V21HT3BaYW4ycjRSKzYzUUFydnBaZHZ5?=
 =?utf-8?B?clUrMHBESFRicG9zaDRVNU83MEdydFl5R3IvVkJBVXNDejk4cy82Y01ENU5G?=
 =?utf-8?B?Rm1YekFzYVR2L0sxUDJRdVdZMjZQNVZvMXlKaDY2NGJMbUdSclBESHNIYmVE?=
 =?utf-8?B?cEJ5d0JkdUpWQjZNSzFHT1FieTQrK0RPN2JxM2QwNU5kd0F4MGFzZTdyZFo4?=
 =?utf-8?B?Tm0zeEppTzYzdVk2R253SWR6UjNTRXA5UlJhVVhqbWZOWWVNQTVoQ056QUZk?=
 =?utf-8?B?ZXNnM3VVNnNRQjh1RHNBMHZiejV5Y0lrS2x1aXJ2LzNPaGkrbWZVRTNyM1hh?=
 =?utf-8?B?UHZZdHErbXQ2R0VMMzFML0JzTUpSN09QR1p0YjFZRUZBSVhGY0Z0ckdjOTd1?=
 =?utf-8?B?Nm1OeVVaWkpRbzJNellhcm5jeFdLb0x5YWxlcC9KMnMrRVd0S3EzVE1wRk5x?=
 =?utf-8?B?SVNsTGtNQXhXWUpkQU1Hc0xZQWRxV1htdkFtNTJsM2J6WDRsWFAzTVZYajcx?=
 =?utf-8?B?MHhnOHlhbDRELzEwcjBDRkNyZ2JaVUNBVjN0SlBEU1VmQ1BwUjMweEw4cUp5?=
 =?utf-8?B?S1NGUFhlbnJHZ0NFMlVldUVPL2c4RWhTT1hVL291T2ljZnZseVMrUi9FL0pE?=
 =?utf-8?B?WUdLVGxCR0UrUmZ4d0E5VlBTWTZlVUtVL1ZtcmttVmJDK2ZLaGR3cTk3UGRy?=
 =?utf-8?B?RmNkK2J6ek9jMVRSMDdCTUZuZ3I1bzdBWG5PNWdweGpEc0NzQ1FDOVpyaFkr?=
 =?utf-8?B?djVaMWMzTUR5WUpIRGU0d3ljRURFK3pQSi8vQWJJa1p3RlBlaHJjV0xvbzBs?=
 =?utf-8?Q?IT5dnRvtS8a4eqNPBeEaOqhL2?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5278.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d264a56f-31ee-4f2b-21ec-08dae69706b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Dec 2022 16:42:35.2665
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4a/P25v45ZQAk2D5orz7WzwawTY3aIJZpSjXBlWisiS6HpH9dOMK9ou+PXi8uMQCYRm+QNkCNAj/i0kYZr04/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4860
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCkhpIE1hcmlvLiANCg0KPiAtLS0t
LU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMaW1vbmNpZWxsbywgTWFyaW8gPE1hcmlv
LkxpbW9uY2llbGxvQGFtZC5jb20+DQo+IFNlbnQ6IFR1ZXNkYXksIERlY2VtYmVyIDIwLCAyMDIy
IDc6MzEgQU0NCj4gVG86IFl1YW4sIFBlcnJ5IDxQZXJyeS5ZdWFuQGFtZC5jb20+OyByYWZhZWwu
ai53eXNvY2tpQGludGVsLmNvbTsgSHVhbmcsDQo+IFJheSA8UmF5Lkh1YW5nQGFtZC5jb20+OyB2
aXJlc2gua3VtYXJAbGluYXJvLm9yZw0KPiBDYzogU2hhcm1hLCBEZWVwYWsgPERlZXBhay5TaGFy
bWFAYW1kLmNvbT47IEZvbnRlbm90LCBOYXRoYW4NCj4gPE5hdGhhbi5Gb250ZW5vdEBhbWQuY29t
PjsgRGV1Y2hlciwgQWxleGFuZGVyDQo+IDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsgSHVh
bmcsIFNoaW1tZXINCj4gPFNoaW1tZXIuSHVhbmdAYW1kLmNvbT47IER1LCBYaWFvamlhbiA8WGlh
b2ppYW4uRHVAYW1kLmNvbT47IE1lbmcsDQo+IExpIChKYXNzbWluZSkgPExpLk1lbmdAYW1kLmNv
bT47IEthcm55LCBXeWVzIDxXeWVzLkthcm55QGFtZC5jb20+Ow0KPiBsaW51eC1wbUB2Z2VyLmtl
cm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQ
QVRDSCB2OCAxMi8xM10gY3B1ZnJlcTogYW1kLXBzdGF0ZTogY29udmVydCBzcHJpbnRmIHdpdGgN
Cj4gc3lzZnNfZW1pdCgpDQo+IA0KPiBPbiAxMi8xOS8yMDIyIDAwOjQwLCBQZXJyeSBZdWFuIHdy
b3RlOg0KPiA+IHJlcGxhY2UgdGhlIHNwcmludGYgd2l0aCBhIG1vcmUgZ2VuZXJpYyBzeXNmc19l
bWl0IGZ1bmN0aW9uDQo+ID4NCj4gPiBObyBwb3RlbnRpYWwgZnVuY3Rpb24gaW1wYWN0DQo+IA0K
PiBBbnl0aGluZyBpcyBwb3NzaWJsZSEgICJObyBpbnRlbmRlZCBmdW5jdGlvbmFsIGltcGFjdC4i
IEkgYmVsaWV2ZSBpcyB3aGF0IHlvdQ0KPiBtZWFudCA9KQ0KPiANCj4gPg0KPiA+IFNpZ25lZC1v
ZmYtYnk6IFBlcnJ5IFl1YW4gPHBlcnJ5Lnl1YW5AYW1kLmNvbT4NCj4gDQo+IFdpdGggY29tbWl0
IG1lc3NhZ2UgZml4ZWQ6DQo+IA0KPiBSZXZpZXdlZC1ieTogTWFyaW8gTGltb25jaWVsbG8gPG1h
cmlvLmxpbW9uY2llbGxvQGFtZC5jb20+DQoNClRoYW5rcyBmb3IgeW91ciByZXZpZXcgLCBhbGwg
dGhlIFItQiBmbGFncyBoYXZlIGJlZW4gcGlja2VkIHVwIGluIHY5IC4NCkFuZCBvdGhlciBmZWVk
YmFja3MgZnJvbSB5b3UgaGF2ZSBiZWVuIGNoYW5nZWQgaW4gdjkgYXMgd2VsbC4NCiANCg0KUGVy
cnkuDQoNCj4gDQo+ID4gLS0tDQo+ID4gICBkcml2ZXJzL2NwdWZyZXEvYW1kLXBzdGF0ZS5jIHwg
NiArKystLS0NCj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDMgZGVsZXRp
b25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9jcHVmcmVxL2FtZC1wc3RhdGUu
Yw0KPiA+IGIvZHJpdmVycy9jcHVmcmVxL2FtZC1wc3RhdGUuYyBpbmRleCBlODk5NmU5MzdlNjMu
LmQ4YjE4MjYxNGMxOA0KPiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2NwdWZyZXEvYW1kLXBz
dGF0ZS5jDQo+ID4gKysrIGIvZHJpdmVycy9jcHVmcmVxL2FtZC1wc3RhdGUuYw0KPiA+IEBAIC03
MDksNyArNzA5LDcgQEAgc3RhdGljIHNzaXplX3Qgc2hvd19hbWRfcHN0YXRlX21heF9mcmVxKHN0
cnVjdA0KPiBjcHVmcmVxX3BvbGljeSAqcG9saWN5LA0KPiA+ICAgCWlmIChtYXhfZnJlcSA8IDAp
DQo+ID4gICAJCXJldHVybiBtYXhfZnJlcTsNCj4gPg0KPiA+IC0JcmV0dXJuIHNwcmludGYoJmJ1
ZlswXSwgIiV1XG4iLCBtYXhfZnJlcSk7DQo+ID4gKwlyZXR1cm4gc3lzZnNfZW1pdChidWYsICIl
dVxuIiwgbWF4X2ZyZXEpOw0KPiA+ICAgfQ0KPiA+DQo+ID4gICBzdGF0aWMgc3NpemVfdCBzaG93
X2FtZF9wc3RhdGVfbG93ZXN0X25vbmxpbmVhcl9mcmVxKHN0cnVjdA0KPiA+IGNwdWZyZXFfcG9s
aWN5ICpwb2xpY3ksIEBAIC03MjIsNyArNzIyLDcgQEAgc3RhdGljIHNzaXplX3QNCj4gc2hvd19h
bWRfcHN0YXRlX2xvd2VzdF9ub25saW5lYXJfZnJlcShzdHJ1Y3QgY3B1ZnJlcV9wb2xpY3kgKnBv
bGkNCj4gPiAgIAlpZiAoZnJlcSA8IDApDQo+ID4gICAJCXJldHVybiBmcmVxOw0KPiA+DQo+ID4g
LQlyZXR1cm4gc3ByaW50ZigmYnVmWzBdLCAiJXVcbiIsIGZyZXEpOw0KPiA+ICsJcmV0dXJuIHN5
c2ZzX2VtaXQoYnVmLCAiJXVcbiIsIGZyZXEpOw0KPiA+ICAgfQ0KPiA+DQo+ID4gICAvKg0KPiA+
IEBAIC03MzcsNyArNzM3LDcgQEAgc3RhdGljIHNzaXplX3QNCj4gc2hvd19hbWRfcHN0YXRlX2hp
Z2hlc3RfcGVyZihzdHJ1Y3QNCj4gPiBjcHVmcmVxX3BvbGljeSAqcG9saWN5LA0KPiA+DQo+ID4g
ICAJcGVyZiA9IFJFQURfT05DRShjcHVkYXRhLT5oaWdoZXN0X3BlcmYpOw0KPiA+DQo+ID4gLQly
ZXR1cm4gc3ByaW50ZigmYnVmWzBdLCAiJXVcbiIsIHBlcmYpOw0KPiA+ICsJcmV0dXJuIHN5c2Zz
X2VtaXQoYnVmLCAiJXVcbiIsIHBlcmYpOw0KPiA+ICAgfQ0KPiA+DQo+ID4gICBzdGF0aWMgc3Np
emVfdCBzaG93X2VuZXJneV9wZXJmb3JtYW5jZV9hdmFpbGFibGVfcHJlZmVyZW5jZXMoDQo=
