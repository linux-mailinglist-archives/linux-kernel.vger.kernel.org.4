Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9C5D5FBB39
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 21:18:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbiJKTR6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 15:17:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbiJKTRz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 15:17:55 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2045.outbound.protection.outlook.com [40.107.94.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE53E7B2B3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 12:17:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jJzmfpSrwejbY2v7r1HTbOfxzO9sTiF4I0FtOwDPAUJwlEdl4lzM+5Pto5QRu/KPGARL/ejahK6X4avq5vVOWlYzD7YS2qPwtZT3AHgIgkft2ayhZTKYxP9UYwpUz/2cgV/zhnREp92Zlv8Wi+BTqMC/crAHUnJ36deYtSEfdWYw2Kcvb++ERH0O3hBgbYHAGrNzDt3g3YCVF6/VTohAtpJVpCG1Sthjix3YGCDYbMuNNAKLSy0XYqr/so+kCM5YVbIQM7Ef4x7kpCNZLwEynPT0o4JWdy2zd+3GnvacHeAHHlu5P9wFbLKUjUqBabmgRfW5wtPLXRw4uuY5Y+bMeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m8q3CAUZAZ/J0vQVxuYFLp6znGcqFWUrds/nSWhMXLY=;
 b=N3NYtngOHNEW6DQXGdF4Ng2XUE9kjBLdcN/zt7w4mWWPXf+HjC/+1TT/ks+xx6bTfsUQT5Xe7E2PCFNo0qurhTvPPVS2uMaQv7RMOB+8KgoyXn1lkd8XkAjHfkhkgXtNVqXbfzFjduPE7KdQuvzUYhTlqYivFhzJ0R8/bdIXbnr7xTGqSo/8Mj5LFZgtHJwLBGrG/fBEg0yL/QJpUd2+JIm/StPUYLtTXbgfo6IWbCj01WsxwRO5zvlh8PSBtgPbO0HXWQyGJdsjI9u7E9YN+vlbDnFVC52odwzEC+JZRrJW1CiGNorhvcU3+a2ow/mysj7Yi2+ELMvVgBkTlEo6Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m8q3CAUZAZ/J0vQVxuYFLp6znGcqFWUrds/nSWhMXLY=;
 b=anVv9vNinzsaSOoPO4EV2/wQAvGTWeZoHguj16w9HRTmmCAgQgYpg26C9PDDInoCDNjotKkFWqdUCtGy2DDLAzi536TF/7ONNVjzEw6cNfJjsnV9rK5p3PiNR3c31m0R0wo9ReD4WgTWe7Ss0EHv0lTbyrKpCzHlnezYvM9gsPA=
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SJ1PR12MB6171.namprd12.prod.outlook.com (2603:10b6:a03:45a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.31; Tue, 11 Oct
 2022 19:17:52 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::76ec:6acf:dd4d:76a3]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::76ec:6acf:dd4d:76a3%9]) with mapi id 15.20.5676.030; Tue, 11 Oct 2022
 19:17:51 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     Mark Pearson <markpearson@lenovo.com>,
        "xazrael@hotmail.com" <xazrael@hotmail.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "perex@perex.cz" <perex@perex.cz>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "Saba Kareem, Syed" <Syed.SabaKareem@amd.com>,
        "Mukunda, Vijendar" <Vijendar.Mukunda@amd.com>,
        "Pananchikkal, Renjith" <Renjith.Pananchikkal@amd.com>
CC:     "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: RE: Fw: [External] RE: [PATCH -next] ASoC: amd: yc: Adding Lenovo
 ThinkBook 14 Gen 4+ ARA and Lenovo ThinkBook 16 Gen 4+ ARA to the Quirks List
Thread-Topic: Fw: [External] RE: [PATCH -next] ASoC: amd: yc: Adding Lenovo
 ThinkBook 14 Gen 4+ ARA and Lenovo ThinkBook 16 Gen 4+ ARA to the Quirks List
Thread-Index: AQHY3Rx3XmXuvIkdpUquzaol1aqkEa4JbJGggAAYXCiAAAx80A==
Date:   Tue, 11 Oct 2022 19:17:51 +0000
Message-ID: <MN0PR12MB61019B21DB6A525C063A9D80E2239@MN0PR12MB6101.namprd12.prod.outlook.com>
References: <MEYPR01MB8397A3C27DE6206FA3EF834DB6239@MEYPR01MB8397.ausprd01.prod.outlook.com>
 <MN0PR12MB61013CCC5DD10347C3FA3EECE2239@MN0PR12MB6101.namprd12.prod.outlook.com>
 <TYZPR03MB5994C7FD8582F831A69055DEBD239@TYZPR03MB5994.apcprd03.prod.outlook.com>
 <8c7cb257-3e88-e299-5e92-a44cea06d771@lenovo.com>
In-Reply-To: <8c7cb257-3e88-e299-5e92-a44cea06d771@lenovo.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-10-11T19:15:28Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=2fedd256-652d-45cc-a278-ea1d16904dcd;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-10-11T19:17:49Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: e8eb4e24-2e46-4c94-a0d3-43d9b2f57d8d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB6101:EE_|SJ1PR12MB6171:EE_
x-ms-office365-filtering-correlation-id: 6cfa2bb8-a526-4e0a-a8d9-08daabbd4aae
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2gA2T1yirZWaWcPv7uAkzU8UwXv7rFcuzuDIFlVCndh5PEVTzJ41mwZ9Vxis59Sg03kDouC1wycUn/gPN6TBBpkd3GzG/Wykm3z9AQ7c6is0dC9JM+cvBiwKHxW45uUUYzfCAct0zPFZW7LI3S7E7uj0kR4lSlhILvgpHoPCz58e2uzWT5VG+UxN7gZYhKQRz26IJrvUno0mMAUD8u2D92owG532i3e9nCmLd9xzJqf+wX2cPyhHvsCr9+CaeQed8nDTwrA/SV6sWJ+T+eIiNWfaglQgvb6XX7ndtJIDmL95nWz+jKPdxoxlsdTAV660GFIHNjMHN8lVmscuve4O9k9VfiooAdj9mBGYR2l4wHx49Zd5N/RTvgRqBNziKae1TmClm0TSW17Glc2vlRSKS1DFUlXYT5x0QbhZ+3enI34TNvcOLhgJIbv7HAqQRNMFjF0J1JC4zcEUXZRgr6cD4+Jtz2f03SWidqlNhJc7bWwboqpl1od6tMW1yb7GtbbweHOL+BjPNMoOulRt1UwggjRxf7/WrMqFRPSjZ8/mUpJfTvuhdhqgNGuTZmYlurzukUfAb7tKe/SEUyzsOXog0J7H3xiiq5IEJLNC9/DaLxX4ACQGj8YLl6fgUG0WCcgGg3cp+br9fr5XE8O81hMMpKRxKdnz942tjCRFg/ByBYvTd1gqMSNfHJM8poO2sZbB/WNUF3wAtdKGCGy4sQzp/YWLwg0r9EnqM7N44uReYaHatmDp57Os8FFiQWfprH4f3ORPJTnYav4Z+/ZmJjgms0gtEEDNsyQWm1DVFVUwFns=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(346002)(136003)(39860400002)(366004)(451199015)(316002)(186003)(2906002)(921005)(4001150100001)(71200400001)(478600001)(54906003)(110136005)(66946007)(122000001)(33656002)(41300700001)(64756008)(66476007)(66556008)(7696005)(76116006)(66446008)(4326008)(8676002)(6636002)(86362001)(83380400001)(55016003)(9686003)(5660300002)(53546011)(8936002)(38070700005)(52536014)(38100700002)(26005)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eFNBdU9pWlJ5ZWU5VWxmL0tveW9vdWdsTkhVTDl4Y09GNTZLbkRGdU5MMEVz?=
 =?utf-8?B?OWtKNndWc2IvR0JIV0NGUGdBWDlBODdWUzFGVEorOTk0R3k4ZGNoVUtONXVT?=
 =?utf-8?B?aDJ2bEJOZlFlYmpMd0JyOHNxMjZMYXI4RnUwTk8vaU1qcHUveGNlRTFmUng2?=
 =?utf-8?B?Y1Q5NVE3eGwzTStJZkdvYzZSVW5md203dmRWVHBjK0ZKNnJZUkFmU3M2KzBp?=
 =?utf-8?B?S2c4ZGhISy9oeFV4eGVNQ1YrT0EzV1hLbm0zNzc1SXNlRVJWV3BjVVIrcVhD?=
 =?utf-8?B?Q1pic3dGS3NBNVNQOGJtMmpTVHVaa1dDUlJyckRNcHBGeUVWS2dvRWE1L3dZ?=
 =?utf-8?B?ajB6K0xvekRGUERCalRIM0ZRR0FhMW9LNjJvTjd6NmczV3ZZcHc1NEw2Z0h4?=
 =?utf-8?B?VTBkRDBaRTd6QmdPbVhwaEhzS2NVbnhhdGFjVjREMmZya3M2WTBHRjU0cWtO?=
 =?utf-8?B?YWUzbER5MWxjWFlGQzdrUmZnMzI0RXQwaU9rWERtZk11MmRsT0pJajhxdno2?=
 =?utf-8?B?c1BQdHlIQUhnVEtWakVvbTZZRkEyTFE2aU01RlVaaWdIV2Y5aGZQeTNJWnk2?=
 =?utf-8?B?MmgvalB1NUV5Njk2QTd4VE9xTFJwRHJrOE9ML0MzdkhtblR5ZzdVV3RxVHc4?=
 =?utf-8?B?NnJWZFJWY1JaT2xrZ2c4dXd6Y0hYYVh1YXBQMWllSVpaRCtubUVHM1JVVzNq?=
 =?utf-8?B?UXFabFYxVDZWQ0lhRlFEUzJwSGJhb0w2UTBlK1BQU0lGUU1uYWk5VDVVeHEv?=
 =?utf-8?B?T3o5UFliVkx4VHJMTWtoNURab2dSWElmbkVrbWN5RUhtV0lXaWV0R3pSZytk?=
 =?utf-8?B?RU1Ob05kc3NQZnVvcks5SHltMHpmR1VaRXFTM2Y2UnYvc21ZS04zaW5XM0tV?=
 =?utf-8?B?MEhpTWEwYXNPTFdEd2dDdXAvTmxnd3M2U3BEYmlKbWl2cGIrSm5kMjhJVTlq?=
 =?utf-8?B?V21sMFhSVVFQV2U1OHBYNWR5cElXR2EzOWorL3ZmL0VlOGJlbllyZWNsbzQx?=
 =?utf-8?B?ZmEzY1FlWHdsR1lybU5Sc0FZSEFQQUlPK3hVMnZ4UzhXUWJKRCtEcEh2MDF3?=
 =?utf-8?B?bktqRTFHSWxDNDJEdThBblhCWk9GMFdybGo0Tm9OWHQ3ejNoUDNKSHQzUnhO?=
 =?utf-8?B?c21QbGJ0eEEyMWJKVTF2bFZlOC9nUXJBNjJHaWsxdXNzZy81OUY1VEdDY1NN?=
 =?utf-8?B?Smo1YjQzTjhTTUFOS1JvSGNNMGdUY0JhQnkzd0MxQkdCeC90VlhGQVV6amNV?=
 =?utf-8?B?eHg1c1M0VmVoRDlTQUN3RXlpcUloSHFKZ1BqZklsaGRYMkthQjJ2enpnbGEz?=
 =?utf-8?B?dkhUbUFVOVNUeGkxeEJuZC9wWjhCeEtsdWlEcHlBQnZvN1FXUllnVnVmMXEw?=
 =?utf-8?B?OUprcDhDVnVGR0NYNit3NEQ0VGdDNzhrcEFrZlNlVUZicWRzMkVRajVnWXpS?=
 =?utf-8?B?emNOSWpxZndHaHpRN0c4c09FZ1dmRXB5eEdLV1B0SXBKVWpnd21jcmxydjVW?=
 =?utf-8?B?N2IyZFArdjZ0U2hiampEdHR0MkRmMmRrd1VQdVhZeXdJMm1seXNEeFNHUk5K?=
 =?utf-8?B?emMrSTlHOE9ZdmFqcVh0RzdwaHZrQlBSV1pySW56UkFCcnMvUmNYMWtQeXY0?=
 =?utf-8?B?dGxuMlpmcmVyNzQ2WTNNdmM5RDdWRlBmNngzQXlTK1FoTk85cklBa3lIQU5R?=
 =?utf-8?B?bkNXYncvODJIK3FleFgzQWtXbFUzWlBVTUUveUo2Z0daNlpadUNYa3o5SXN2?=
 =?utf-8?B?UnNjc3FyS3RMVFZ1RTBpRXcxcjcxTFp5OVVBZVlyRmE4Zk9hQ0xkU0lOaVhK?=
 =?utf-8?B?TkMvNkhtdUh4VkFNaWFDS20rN0xFcEFRaHNoWkg1UzZIZTJ2MEFXNTREU3lm?=
 =?utf-8?B?V01peGhsY2RRc2FHUU1XZzdHdmI1NnZWTTFuTWNMWEw1T1NsMXpxc3RzUU41?=
 =?utf-8?B?d2NpdyswOVRuWlZ5b21MckNIdjJhVDMyU1BRdU05TmQrRW4zR0RFSmMrYUVl?=
 =?utf-8?B?YUo3WlNLU0VYVG8xVWl0QWFTM2NmYVNWSWRJdHJHV1lwYnF3c080YjJ1cjIr?=
 =?utf-8?B?UHlVTnJwSVo2OXVCbVR2YjhITC8rdEFUZUFxbzR4YkFianY0Rzh1T0g3V0dV?=
 =?utf-8?Q?XYbk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cfa2bb8-a526-4e0a-a8d9-08daabbd4aae
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2022 19:17:51.6319
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1qnNOQu/hfd0NdiIb/0Xu3Xxmoc0px7mTCe4t5jID/gQECJShgRrDc0yLihQx3pMZTstY/QXHrIrUmYOzM0ugA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6171
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

W1B1YmxpY10NCg0KDQo+IDxtb3ZlZCB0byBteSBtb3JlIG9wZW4tc291cmNlIGZyaWVuZGx5IGVt
YWlsIGFjY291bnQ+DQoNCldob29wcyBzb3JyeTsgSSBtaXggdGhlbSB1cCBjb25zdGFudGx5Lg0K
DQo+IA0KPiBUaGFua3MgTWFyaW8NCj4gDQo+IE9uIDIwMjItMTAtMTEgMTM6MTQsIE1hcmsgUGVh
cnNvbiB3cm90ZToNCj4gPg0KPiA+IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+ID4gKkZyb206
KiBMaW1vbmNpZWxsbywgTWFyaW8gPE1hcmlvLkxpbW9uY2llbGxvQGFtZC5jb20+DQo+ID4gKlNl
bnQ6KiBPY3RvYmVyIDExLCAyMDIyIDEzOjA4DQo+ID4gKlN1YmplY3Q6KiBbRXh0ZXJuYWxdIFJF
OiBbUEFUQ0ggLW5leHRdIEFTb0M6IGFtZDogeWM6IEFkZGluZyBMZW5vdm8NCj4gVGhpbmtCb29r
DQo+ID4gMTQgR2VuIDQrIEFSQSBhbmQgTGVub3ZvIFRoaW5rQm9vayAxNiBHZW4gNCsgQVJBIHRv
IHRoZSBRdWlya3MgTGlzdA0KPiA+IFtQdWJsaWNdDQo+ID4NCj4gPiBDYzoNCj4gPiBNYXJrIFBl
YXJzb24NCj4gPiBWaWplbmRhcg0KPiA+IFN5ZWQNCj4gPiBSZW5qaXRoDQo+ID4NCj4gPj4gLS0t
LS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPj4gRnJvbTogbGlua3QgPHhhenJhZWxAaG90bWFp
bC5jb20+DQo+ID4+IFNlbnQ6IE1vbmRheSwgT2N0b2JlciAxMCwgMjAyMiAyMTo1Mg0KPiA+PiBU
bzogbGdpcmR3b29kQGdtYWlsLmNvbTsgYnJvb25pZUBrZXJuZWwub3JnOyBwZXJleEBwZXJleC5j
ejsNCj4gPj4gdGl3YWlAc3VzZS5jb207IExpbW9uY2llbGxvLCBNYXJpbyA8TWFyaW8uTGltb25j
aWVsbG9AYW1kLmNvbT4NCj4gPj4gQ2M6IGFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZzsgbGlu
dXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGlua3QNCj4gPj4gPHhhenJhZWxAaG90bWFpbC5j
b20+DQo+ID4+IFN1YmplY3Q6IFtQQVRDSCAtbmV4dF0gQVNvQzogYW1kOiB5YzogQWRkaW5nIExl
bm92byBUaGlua0Jvb2sgMTQgR2VuDQo+IDQrDQo+ID4+IEFSQSBhbmQgTGVub3ZvIFRoaW5rQm9v
ayAxNiBHZW4gNCsgQVJBIHRvIHRoZSBRdWlya3MgTGlzdA0KPiA+Pg0KPiA+PiBMZW5vdm8gVGhp
bmtCb29rIDE0IEdlbiA0KyBBUkEgYW5kIFRoaW5rQm9vayAxNiBHZW4gNCsgQVJBDQo+ID4+IG5l
ZWQgdG8gYmUgYWRkZWQgdG8gdGhlIGxpc3Qgb2YgcXVpcmtzIGZvciB0aGUgbWljcm9waG9uZSB0
byB3b3JrDQo+IHByb3Blcmx5Lg0KPiA+Pg0KPiA+PiBTaWduZWQtb2ZmLWJ5OiBsaW5rdCA8eGF6
cmFlbEBob3RtYWlsLmNvbT4NCj4gPg0KPiA+IFRoaXMgcGF0Y2ggYWxvbmUgbWFrZXMgc2Vuc2Ug
dG8gbWUuDQo+ID4NCj4gPiBDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZw0KPiA+IFJldmlld2Vk
LWJ5OiBNYXJpbyBMaW1vbmNpZWxsbyA8bWFyaW8ubGltb25jaWVsbG9AYW1kLmNvbT4NCj4gPg0K
PiA+IEkgdGhpbmsgaXQgc2hvdWxkIGdvIGluIGFzIGlzLCBidXQgaXQgcHJvbXB0cyBhbm90aGVy
IGlkZWEgdG8gbWUgSSB3YW50IHRvIHJ1bg0KPiBieQ0KPiA+IE1hcmsgc3BlY2lmaWNhbGx5Li4N
Cj4gPg0KPiA+IFNob3VsZCB3ZSBqdXN0IGRyb3AgdGhpcyB3aG9sZSBmaWxlIGRvd24gdG8gYSBt
dWNoIHNpbXBsZXIgRE1JIG1hdGNoDQo+IHByZWZpeCBsaWtlDQo+ID4gdGhpczoNCj4gPg0KPiA+
PiArICAgICB7DQo+ID4+ICsgICAgICAgICAgICAgLmRyaXZlcl9kYXRhID0gJmFjcDZ4X2NhcmQs
DQo+ID4+ICsgICAgICAgICAgICAgLm1hdGNoZXMgPSB7DQo+ID4+ICsgICAgICAgICAgICAgICAg
ICAgICBETUlfTUFUQ0goRE1JX0JPQVJEX1ZFTkRPUiwgIkxFTk9WTyIpLA0KPiA+PiArICAgICAg
ICAgICAgICAgICAgICAgRE1JX01BVENIKERNSV9QUk9EVUNUX05BTUUsICIyMSIpLA0KPiA+PiAr
ICAgICAgICAgICAgIH0NCj4gPj4gKyAgICAgfSwNCj4gPg0KPiA+IFRoYXQgd291bGQgYWxsb3cg
aXQgdG8gbWF0Y2ggYWxsIHRoZSBMZW5vdm8gUmVtYnJhbmR0IHN5c3RlbXMgcHJlc3VtYWJseQ0K
PiBhbmQNCj4gPiBjYW4gc3RvcCB0b3VjaGluZyB0aGUgZmlsZS4gIFRoaXMgb25seSBtYWtlcyBz
ZW5zZSBpZiBldmVyeSBzaW5nbGUgTGVub3ZvDQo+ID4gUmVtYnJhbmR0IGRlc2lnbg0KPiA+IHVz
ZXMgYSBETUlDIGZyb20gQUNQLiAgSSBkb24ndCBrbm93IGlmIHRoYXQncyBhIHZhbGlkIGFzc3Vt
cHRpb24gYW5kIEkgdGhpbmsNCj4gd2UNCj4gPiBuZWVkIE1hcmsNCj4gPiB0byBjb25maXJtIGl0
Lg0KPiA+DQo+ID4gVGhlIERNSSBtYXRjaCAidGVjaG5pY2FsbHkiIHdvdWxkIG1hdGNoIHNvbWUg
b2YgdGhlIEludGVsIHN5c3RlbXMgZnJvbQ0KPiB0aGlzDQo+ID4gZ2VuZXJhdGlvbg0KPiA+IGJ1
dCB0aGlzIGRyaXZlciBpcyBvbmx5ICJsb2FkZWQiIG9uIEFNRCBSZW1icmFuZHQgc3lzdGVtcywg
c28gSSBkb24ndCB0aGluaw0KPiBpdCdzDQo+ID4gYSBwcm9ibGVtLg0KPiA+DQo+IA0KPiBJIGxv
dmUgdGhlIGlkZWEgYnV0IEknbSBhIGxpdHRsZSBoZXNpdGFudCBhcyBJIGRvbid0IGtub3cgaWYg
SSdsbCBiZQ0KPiBhYmxlIHRvIGNvbmZpcm0gaXQgYXV0aG9yaXRhdGl2ZWx5IC0gSSBkb24ndCBo
YXZlIHBhcnRpY3VsYXJseSBncmVhdA0KPiBsZXZlcnMgdG8gcHVsbCBvbiBmb3IgcGxhdGZvcm1z
IG91dHNpZGUgdGhlIExpbnV4IHByb2dyYW0uIEknbGwgdHJ5IC0NCj4gYnV0IEkgdGhpbmsgY2hh
bmNlcyBvZiBiZWluZyBhYmxlIHRvIHJlcGx5IHllcyBvciBubyB3aXRoIGNvbmZpZGVuY2UgYXJl
DQo+IGxpbWl0ZWQuDQo+IA0KPiBJIHRoaW5rIGl0J3MgcmVsYXRpdmVseSBsb3cgcmlzayBmb3Ig
YnJlYWtpbmcgYW55dGhpbmcgb24gdGhpcyB5ZWFycw0KPiBwbGF0Zm9ybXMgLSBidXQgbWF5IGdl
dCBtb3JlIGludGVyZXN0aW5nIGZvciBuZXh0IHllYXJzLiBJZiBuZWVkZWQgY2FuDQo+IHdlIHRo
ZW4ganVzdCBxdWlyayBhbnkgcGxhdGZvcm1zIHRoYXQgY29tZSB1cCB0aGF0IG5lZWQgdGhlIGxv
Z2ljDQo+IHJldmVyc2luZyBvciBkb2VzIHRoYXQgZ2V0IHJlYWxseSBtZXNzeS4NCj4gDQo+IEkg
Y2FuIGNvbmZpcm0gdGhlICIyMSIgbWF0Y2ggaXMgZ29pbmcgdG8gYmUgbWF0Y2ggYSB0b24gb2Yg
SW50ZWwNCj4gcGxhdGZvcm1zLiBGb3IgdGhlIEFNRCBwbGF0Zm9ybXMgLSB3aWxsIHRoaXMgYmUg
bGltaXRlZCB0byBSZW1icmFuZHQNCj4gb25seSBvciB3aWxsIGl0IGFmZmVjdCBhbnkgcGFzdC9m
dXR1cmUgZ2VuZXJhdGlvbnM/DQoNClRoaXMgZHJpdmVyIG9ubHkgbG9hZHMgb24gWWVsbG93IENh
cnAgKFJlbWJyYW5kdCkuICBJdCBpcyBub3QgdXNlZCBmb3INCmFueSBvdGhlciBnZW5lcmF0aW9u
cy4NCg0KTXkgaG9wZSBpcyB0aGF0IHdpdGggdGhlIF9EU0Qgc3VwcG9ydGVkIGluIGZ1dHVyZSBw
cm9ncmFtcyB0aGF0DQpsZXNzIG9mIHRoZXNlIHF1aXJrcyBhcmUgbmVlZGVkIHRvbyBldmVuIGZv
ciBwbGF0Zm9ybXMgbm93IGluIHlvdXINCkxpbnV4IHByb2dyYW0uDQoNCj4gDQo+IFNob3J0IGFu
c3dlciAtIEknbGwgc2VlIHdoYXQgSSBjYW4gZmluZC4uLmJ1dCBubyBwcm9taXNlcw0KPiANCg0K
T0ssIHRoYW5rcy4NCg==
