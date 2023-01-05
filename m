Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57C3565E589
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 07:21:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbjAEGVS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 01:21:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbjAEGVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 01:21:16 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2087.outbound.protection.outlook.com [40.107.244.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 455E24BD75;
        Wed,  4 Jan 2023 22:21:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OcxLAz4pMfbJrvq4zLvLpJ1k3BFNg1zQhhqtHSbTk6uk1FZzPDxpLqJVl8sCMLdf4v8w1QQWvhbjKlXzzzVbWgTemAGyWbmZ7PkGWYDepgfKhQA1m1quMC50JzwCGGpHCAXv6PfIgFaI1ws/mK+6eQh1errOd1QVwEHIeqI7KRVxCpv0VFNAohRlBfsQIDsTrtN5zLBABLWmTrkPh26mvJQP7p65deDwBw0nmib4rHfRw8aJHuyLsFs5RLjJ9nhBktiaQWptdkCDrgc9pgz5znK2YjtnSMwBC0zK+2w2bwxH9pt72ZXmKrTybh/SY09d1MTlekNaLUa2DiGHThXgXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H3HFy2KFq9oW9lA9RXKH7bKgbAICvxdUNkwAqOAU+8I=;
 b=NHWjS5uohmDcQtn35odCfBZkILtRxT4LzLPKOB+LSTrrAwFUzM4uxN9bcV23yPKx9vQ/eL4KSynNwIIWEqTagikokzHWRMTg8lerf6vLN6xV0pzQhj+erAyxth1sg0d7Ati+KtY/ZQRpKkoanF9ZUXvahBlcD/ziem0sURf9Gxi0qAU5m+xu74L53gw0yWMzTRhlGcJLDG11/tXXZLnkY34Dt/cEsQBb8WVJL/6Orod6j+DuGJoaDq4YWMBi0S810hgNxExTUBNKBQoxruUDUXv099K9JAwGNVUU0Dg67XDWYNlpiPLNtlp6WCGzWJ9lnhc2aJ3ofGEW9LplmVH+1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H3HFy2KFq9oW9lA9RXKH7bKgbAICvxdUNkwAqOAU+8I=;
 b=vv40n3RQlyIVrvzrnJCey1fFVyNKd20bkDhSvBtq4cOnjW3zRsQCtW3aTaT3vEB6ohI/B3ZiN5lqRFvaMsNoQGdR7BXzRiBol6l/YQ17YRfA/dZaeCtFmsvjW0fn7XWlvD3UKMBAzWsqToQUBRNPmSveb4SNWCtpmNj2uQmr3YY=
Received: from DM4PR12MB5278.namprd12.prod.outlook.com (2603:10b6:5:39e::17)
 by SA1PR12MB6945.namprd12.prod.outlook.com (2603:10b6:806:24c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 06:21:13 +0000
Received: from DM4PR12MB5278.namprd12.prod.outlook.com
 ([fe80::960b:6963:b27e:f9ed]) by DM4PR12MB5278.namprd12.prod.outlook.com
 ([fe80::960b:6963:b27e:f9ed%8]) with mapi id 15.20.5944.019; Thu, 5 Jan 2023
 06:21:13 +0000
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
Subject: RE: [PATCH v9 13/13] Documentation: amd-pstate: introduce new global
 sysfs attributes
Thread-Topic: [PATCH v9 13/13] Documentation: amd-pstate: introduce new global
 sysfs attributes
Thread-Index: AQHZGH8jahwf6su0BESISmZHFQ91366Nd9KAgAHyxbA=
Date:   Thu, 5 Jan 2023 06:21:13 +0000
Message-ID: <DM4PR12MB52783BFE1051AE668E360B1F9CFA9@DM4PR12MB5278.namprd12.prod.outlook.com>
References: <20221225163442.2205660-1-perry.yuan@amd.com>
 <20221225163442.2205660-14-perry.yuan@amd.com>
 <583d3642-a79e-fee0-5c90-84eac82c3812@amd.com>
In-Reply-To: <583d3642-a79e-fee0-5c90-84eac82c3812@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-01-05T06:21:10Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=256d2c61-a387-44be-ac0e-1dd38ed9f99f;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2023-01-05T06:21:10Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 7f88bb87-d6fc-4c95-9f70-2c96676bcfe5
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5278:EE_|SA1PR12MB6945:EE_
x-ms-office365-filtering-correlation-id: 08232313-3dc1-4fa3-8874-08daeee50b7a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: o0qyea6ZbV4LsKdGjrpqN3GQFTBuFqtb7+R+0ZkuPMNqaiiL7YHvi5t3tFTjEOA4WyhHt2l6HQrxlThzg4rLbRa36x76XzKtzInu4frHSkodUYn3F7HrvivCBYHVGmjjaKAKex/ksiA1yEbFc3l6Qrc/8Jyyfd8CM28eGjkVzoKooNRCxVBFSX/+LcAbEHNg/CKJFL/dyp/1cbXKuKyLUlIC902zZFaSGt/8/qNceRDlPmu5JE/MN2TSeOqrEVpDDpdPCJMTXHWlvHs+B1XRHKFH9C6B8Bwtd/KKBgTsXiDoT8LQF8cqjcYaTs71mx4nwz/s9ulR8H28C0Cao1mQSDuffcXtjqJpDZ9KERGF/t1fB8Mj4XWeWLgHXu0c+W1iOVDhlxR3SbhO88p/2nC9zdGfYHl1Kx6IosxbJCU8h5LOzfD5Gc6IARiOm8CHG/5aJuh2N4Tq2Ycl56euIo426GpjWz2VJBKtfb7H0NnQYc+NF8o3hf0332CVi5kt3MVge7GT1ljdTuUXeWU38Q4S8lkZjZmfQFyrHGMjE4qABsHEp7ByvjvKRKlAMaWC3xSejVUv6b2Uomn9ZIZ7WtZukEp9S68J1Orc/dh53TjrULvV7gcCHNHGB+iKIqhpZN2b7l2IpOPxsBu6Yh5EGk9bJF+vuq/tmcIIPZwA+mRg0bskuZeKXm3FFOkT9d6MAexFjDni9BweCKIACKv1D9qj3Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5278.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(346002)(366004)(376002)(136003)(451199015)(38070700005)(122000001)(55016003)(38100700002)(33656002)(86362001)(316002)(54906003)(53546011)(110136005)(7696005)(6506007)(478600001)(186003)(26005)(71200400001)(9686003)(5660300002)(83380400001)(2906002)(4326008)(8676002)(66556008)(66446008)(66946007)(52536014)(66476007)(8936002)(41300700001)(64756008)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?clVzVndqYXlEczlHUk5HRi81Q0gyb3I0SG04U2Nyc2tnekNBYnNscTBRS1Bw?=
 =?utf-8?B?QmVlN2U3b0dIQ0M3ajl3MVJEUnA2a2hOS1ZPSThpYlVjcEwzNHhzYytOanVy?=
 =?utf-8?B?MGljWldTM1hGQnlwRVZSZldFSW0rQXcrM2VHd0VBLzdDTUZhaTZwRWcwNHNW?=
 =?utf-8?B?bmdRZXBWSWJyL0lwVUVCaG5mNloxM09BaWN4aExRRWFmM1hjR2c5ZWMyUmhC?=
 =?utf-8?B?R1BjdjRtSnRmNFNUVjE2UUZ3c2MramcwcEhhc1BDOUhxNGlOV2RNSm5ZTThn?=
 =?utf-8?B?ZmhSdkYyNkpFOU84ckFHb0ZnWFNxWm1ielFCOEgzai9PZHVpN3BXbFdGNWtp?=
 =?utf-8?B?UlF5ZGNpTTlSWEN1ZmVONGdxUGg2QTlQbXZhdHNzSHdhZmg5dFZYdFRkMmR2?=
 =?utf-8?B?SkMvNG5kTk56dVY3VSt4MHRwand0L3pEK2dLZGJEUHBVOW9QSDB0YjE3NFgy?=
 =?utf-8?B?N2VMMFVSdllnS0FlZGVjcnZ2bHAzQitMa0x6b1lqZUdWZnpWV09YaWY2WlRi?=
 =?utf-8?B?RXJDNXI5cXVIRFFqbUk5SjVnNGorajNCYWNON1dCVkYvdSs2cmVuRkhzRlVa?=
 =?utf-8?B?K0VzMS82UG9Vbjg1UzlrMW5xTGpnczVJVktnYkR6alBHMHBHWkxoUGk0dDRG?=
 =?utf-8?B?WEJsUWR4M2pzdXJGeFpNUTMwc2ZJOEhFMHdrSFlTTGZ4LzltbkxFMEMzU1Vw?=
 =?utf-8?B?SG5NZ09QMDlyMktHeWVQZlRjVXVDTXdqcEhjVUJiM0dIZEF5SXlieGlwS3Q5?=
 =?utf-8?B?OFRXQmxLWEZlRlg1N3c3MVJZODBFZFZrRGVwdllNTXcvR3J3c0VScE1OcjAz?=
 =?utf-8?B?YktYTXc3MDBlblJxemp1YVJFKzFoQS8rUWdWc2hBVUE1M0V3ZnRXczM1S2NB?=
 =?utf-8?B?ODZOVTNJendvTitKSko1SXdyMWs4SmRwUUlJbWdsckRzRjVOQ1JxdDEzOHJs?=
 =?utf-8?B?NXZXd2dBSjN4MllEYTNNOWlETlE5NlFhODJtY2orY0tiVUxpRlk5Z1ltOC95?=
 =?utf-8?B?YW9HaVF6a3BtcmtodWhkM25HbTkzQXpkZGFyYkhWVUpRUEdSNjViS2pWSmFY?=
 =?utf-8?B?ZllKTHpURVp2TkVzK0hWSkdEL25jTTQ4UEtjOUoxaWtmRk81dENzSnYzN09P?=
 =?utf-8?B?ZW9sM2RRLzUwdU5BbDdNa1dscmN1cEJwZFdtWkpHN1pRYlplVEJnd1doQVFB?=
 =?utf-8?B?ZmxqWU9ZL2FHaEQrSVdCdGxvdDZLeWZPUXZ2Nlo0anArOWhobDFSaVF1OFhD?=
 =?utf-8?B?UG91Z1JoVDNGQndvZ1YvWStyNUp4MWYwUUpIVEx2WHkwV0w1d3dDQ0dnM1pY?=
 =?utf-8?B?V25JNkNSblhLN2ZNU0VZRlo5STJqK2RHdE85NURnaXZEMDN0cGJzWXlJMUtI?=
 =?utf-8?B?anRlUFdrQUlCVGlBN0c1T2RGMFJPZWV2QzdnQVNHU2F4M3RIdmRkcnVvcnVj?=
 =?utf-8?B?WXFLdzFhK2cvSUFOOWpNOGZ3S2xvUFJ5MFVFUEF2NkRHdVQ4U093cmluZ3Nn?=
 =?utf-8?B?KzE5UWY5YytEejdSY0dmQitNSDAyZGZEeE5jSHptL3B1U3IxMk5PeGVxU01D?=
 =?utf-8?B?aHBQUDdXUW5Td0Yya0xYNklTejc5MjhlRkZtZXN6bC91djA5TUZBUDA2NnlS?=
 =?utf-8?B?TmJDbzB3dTM1QTh4MHBzQ1pKVWVKQWhIeXFTSkd6eW1IZ3NIWHIrck1aZkI1?=
 =?utf-8?B?TjhLTmhPeVVLcFMvcDExU3dwUEZjbGg2ei92dlMrSGU2dlZldUtWSUVHVHh5?=
 =?utf-8?B?NDlORFJJbGNtblBsbUdoUExlQnczVDJWY0x6VWg3NUJGbEFMcWJ5ZzhnalA5?=
 =?utf-8?B?S1JhWXRxeVBSeExlYmo1WWpyL3A0RVpmNnpjbWNkQWhrdGQ2SXh1QW1oSXp0?=
 =?utf-8?B?cUh1MUp2N1RmbDZhZDUzaldORDd3bGE5MElES0s5RVJibXdBNk16NHQ2aS93?=
 =?utf-8?B?aTIxU0JVa1l6ZTltbm9LQVcyWDJZTmFFdVpjd1A1NU1rSm0reFpKYW5wYnVx?=
 =?utf-8?B?MVhMWDZCa0piOWhYaVBnNWFwMUNHWkVBT0d4bTZjME02bjYzSExwM3EvYmhU?=
 =?utf-8?B?NS9LMFFqNzhkcGxkVmw1ZlpvcVhseHdwcGpDK20yUEN4V1hIWWExRHpwdzBQ?=
 =?utf-8?Q?mQF2DGvQysr8hZ8mP5IUDXNoV?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5278.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08232313-3dc1-4fa3-8874-08daeee50b7a
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2023 06:21:13.3222
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q2lS9MGBe1IS4AR8MEEY+XxlcCWJKtOpcki0bDtHfRSy0AT37tEeY/TqcZIRhAIeidlNMefXjUj5Jw+0QNetpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6945
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
LkxpbW9uY2llbGxvQGFtZC5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwgSmFudWFyeSA0LCAyMDIz
IDg6MzUgQU0NCj4gVG86IFl1YW4sIFBlcnJ5IDxQZXJyeS5ZdWFuQGFtZC5jb20+OyByYWZhZWwu
ai53eXNvY2tpQGludGVsLmNvbTsgSHVhbmcsDQo+IFJheSA8UmF5Lkh1YW5nQGFtZC5jb20+OyB2
aXJlc2gua3VtYXJAbGluYXJvLm9yZw0KPiBDYzogU2hhcm1hLCBEZWVwYWsgPERlZXBhay5TaGFy
bWFAYW1kLmNvbT47IEZvbnRlbm90LCBOYXRoYW4NCj4gPE5hdGhhbi5Gb250ZW5vdEBhbWQuY29t
PjsgRGV1Y2hlciwgQWxleGFuZGVyDQo+IDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsgSHVh
bmcsIFNoaW1tZXINCj4gPFNoaW1tZXIuSHVhbmdAYW1kLmNvbT47IER1LCBYaWFvamlhbiA8WGlh
b2ppYW4uRHVAYW1kLmNvbT47IE1lbmcsDQo+IExpIChKYXNzbWluZSkgPExpLk1lbmdAYW1kLmNv
bT47IEthcm55LCBXeWVzIDxXeWVzLkthcm55QGFtZC5jb20+Ow0KPiBsaW51eC1wbUB2Z2VyLmtl
cm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQ
QVRDSCB2OSAxMy8xM10gRG9jdW1lbnRhdGlvbjogYW1kLXBzdGF0ZTogaW50cm9kdWNlIG5ldw0K
PiBnbG9iYWwgc3lzZnMgYXR0cmlidXRlcw0KPiANCj4gT24gMTIvMjUvMjAyMiAxMDozNCwgUGVy
cnkgWXVhbiB3cm90ZToNCj4gPiBUaGUgYW1kLXBzdGF0ZSBkcml2ZXIgc3VwcG9ydHMgc3dpdGNo
aW5nIHdvcmtpbmcgbW9kZXMgYXQgcnVudGltZS4NCj4gPiBVc2VycyBjYW4gdmlldyBhbmQgY2hh
bmdlIG1vZGVzIGJ5IGludGVyYWN0aW5nIHdpdGggdGhlICJzdGF0dXMiIHN5c2ZzDQo+ID4gYXR0
cmlidXRlLg0KPiA+DQo+ID4gMSkgY2hlY2sgZHJpdmVyIG1vZGU6DQo+ID4gJCBjYXQgL3N5cy9k
ZXZpY2VzL3N5c3RlbS9jcHUvYW1kLXBzdGF0ZS9zdGF0dXMNCj4gPg0KPiA+IDIpIHN3aXRjaCBt
b2RlOg0KPiA+IGAjIGVjaG8gInBhc3NpdmUiIHwgc3VkbyB0ZWUNCj4gPiAvc3lzL2RldmljZXMv
c3lzdGVtL2NwdS9hbWQtcHN0YXRlL3N0YXR1c2ANCj4gPiBvcg0KPiA+IGAjIGVjaG8gImFjdGl2
ZSIgfCBzdWRvIHRlZSAvc3lzL2RldmljZXMvc3lzdGVtL2NwdS9hbWQtcHN0YXRlL3N0YXR1c2AN
Cj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFBlcnJ5IFl1YW4gPHBlcnJ5Lnl1YW5AYW1kLmNvbT4N
Cj4gPiAtLS0NCj4gPiAgIERvY3VtZW50YXRpb24vYWRtaW4tZ3VpZGUvcG0vYW1kLXBzdGF0ZS5y
c3QgfCAyOQ0KPiArKysrKysrKysrKysrKysrKysrKysNCj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCAy
OSBpbnNlcnRpb25zKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9hZG1p
bi1ndWlkZS9wbS9hbWQtcHN0YXRlLnJzdA0KPiA+IGIvRG9jdW1lbnRhdGlvbi9hZG1pbi1ndWlk
ZS9wbS9hbWQtcHN0YXRlLnJzdA0KPiA+IGluZGV4IDYyNzQ0ZGFlM2M1Zi4uNWY2Mzc5NDc1YjMy
IDEwMDY0NA0KPiA+IC0tLSBhL0RvY3VtZW50YXRpb24vYWRtaW4tZ3VpZGUvcG0vYW1kLXBzdGF0
ZS5yc3QNCj4gPiArKysgYi9Eb2N1bWVudGF0aW9uL2FkbWluLWd1aWRlL3BtL2FtZC1wc3RhdGUu
cnN0DQo+ID4gQEAgLTMzOSw2ICszMzksMzUgQEAgcHJvY2Vzc29yIG11c3QgcHJvdmlkZSBhdCBs
ZWFzdCBub21pbmFsDQo+IHBlcmZvcm1hbmNlIHJlcXVlc3RlZCBhbmQgZ28gaGlnaGVyIGlmIGMN
Cj4gPiAgIG9wZXJhdGluZyBjb25kaXRpb25zIGFsbG93Lg0KPiA+DQo+ID4NCj4gPiArVXNlciBT
cGFjZSBJbnRlcmZhY2UgaW4gYGBzeXNmc2BgDQo+ID4gKz09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PQ0KPiA+ICsNCj4gPiArR2xvYmFsIEF0dHJpYnV0ZXMNCj4gPiArLS0tLS0tLS0t
LS0tLS0tLS0NCj4gPiArDQo+ID4gK2BgYW1kLXBzdGF0ZWBgIGV4cG9zZXMgc2V2ZXJhbCBnbG9i
YWwgYXR0cmlidXRlcyAoZmlsZXMpIGluIGBgc3lzZnNgYA0KPiA+ICt0byBjb250cm9sIGl0cyBm
dW5jdGlvbmFsaXR5IGF0IHRoZSBzeXN0ZW0gbGV2ZWwuICBUaGV5IGFyZSBsb2NhdGVkDQo+ID4g
K2luIHRoZSBgYC9zeXMvZGV2aWNlcy9zeXN0ZW0vY3B1L2FtZC1wc3RhdGUvYGAgZGlyZWN0b3J5
IGFuZCBhZmZlY3QgYWxsDQo+IENQVXMuDQo+ID4gKw0KPiA+ICtgYHN0YXR1c2BgDQo+ID4gKwlP
cGVyYXRpb24gbW9kZSBvZiB0aGUgZHJpdmVyOiAiYWN0aXZlIiwgInBhc3NpdmUiIG9yICJkaXNh
YmxlIi4NCj4gPiArDQo+ID4gKwkiYWN0aXZlIg0KPiA+ICsJCVRoZSBkcml2ZXIgaXMgZnVuY3Rp
b25hbCBhbmQgaW4gdGhlIGBgYWN0aXZlIG1vZGVgYA0KPiA+ICsNCj4gPiArCSJwYXNzaXZlIg0K
PiA+ICsJCVRoZSBkcml2ZXIgaXMgZnVuY3Rpb25hbCBhbmQgaW4gdGhlIGBgcGFzc2l2ZSBtb2Rl
YGANCj4gPiArDQo+ID4gKwkiZGlzYWJsZSINCj4gPiArCQlUaGUgZHJpdmVyIGlzIHVucmVnaXN0
ZXJlZCBhbmQgbm90IGZ1bmN0aW9uYWwgbm93Lg0KPiA+ICsNCj4gPiArICAgICAgICBUaGlzIGF0
dHJpYnV0ZSBjYW4gYmUgd3JpdHRlbiB0byBpbiBvcmRlciB0byBjaGFuZ2UgdGhlIGRyaXZlcidz
DQo+ID4gKyAgICAgICAgb3BlcmF0aW9uIG1vZGUgb3IgdG8gdW5yZWdpc3RlciBpdC4gIFRoZSBz
dHJpbmcgd3JpdHRlbiB0byBpdCBtdXN0IGJlDQo+ID4gKyAgICAgICAgb25lIG9mIHRoZSBwb3Nz
aWJsZSB2YWx1ZXMgb2YgaXQgYW5kLCBpZiBzdWNjZXNzZnVsLCB3cml0aW5nIG9uZSBvZg0KPiA+
ICsgICAgICAgIHRoZXNlIHZhbHVlcyB0byB0aGUgc3lzZnMgZmlsZSB3aWxsIGNhdXNlIHRoZSBk
cml2ZXIgdG8gY2F1c2UNCj4gPiArIHRoZSBkcml2ZXINCj4gDQo+ICJ3aWxsIGNhdXNlIHRoZSBk
cml2ZXIgdG8gY2F1c2UgdGhlIGRyaXZlciB0byI/DQo+IA0KPiBQcmVzdW1hYmx5IHlvdSBtZWFu
IGp1c3QgIndpbGwgY2F1c2UgdGhlIGRyaXZlciB0byINCj4gDQo+IFdpdGggdGhhdCBmaXhlZDoN
Cj4gDQo+IFJldmlld2VkLWJ5OiBNYXJpbyBMaW1vbmNpZWxsbyA8bWFyaW8ubGltb25jaWVsbG9A
YW1kLmNvbT4NCg0KVGhhbmtzIGZvciB0aGUgcmV2aWV3LCB3aWxsIGZpeCB0aGUgd29yZHMgYW5k
IHBpY2sgdXAgdGhlIFJCIHRhZyBpbiB2MTAuIA0KDQpQZXJyeS4NCg0KPiANCj4gPiArICAgICAg
ICB0byBzd2l0Y2ggb3ZlciB0byB0aGUgb3BlcmF0aW9uIG1vZGUgcmVwcmVzZW50ZWQgYnkgdGhh
dCBzdHJpbmcgLSBvcg0KPiB0byBiZQ0KPiA+ICsgICAgICAgIHVucmVnaXN0ZXJlZCBpbiB0aGUg
ImRpc2FibGUiIGNhc2UuDQo+ID4gKw0KPiA+ICAgYGBjcHVwb3dlcmBgIHRvb2wgc3VwcG9ydCBm
b3IgYGBhbWQtcHN0YXRlYGANCj4gPiAgID09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09DQo+ID4NCg==
