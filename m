Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96334649819
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 03:59:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230525AbiLLC74 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Dec 2022 21:59:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbiLLC7x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Dec 2022 21:59:53 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2067.outbound.protection.outlook.com [40.107.102.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70795B7FA;
        Sun, 11 Dec 2022 18:59:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mq9TdetO4hxORFIo+GL07KtVOBhXA+QpfDz4A0QHsXomyEdFA2lGIKPd2WIYRCEkuoPbMJwk2KPWD/bVbiGtewUNnOxtxGvp71wfe1HcdyctS5X0gj7UZPSmhzW5/XTc1wy2xcG+hjwGcFI8Vtjair32T5UKBQnbytCkZoENpQGx0TQgVpLIHFAOsA1J3k2QBWhH7dS91RN1/yGdmqq06FinOklvDsfIEsXJ9CMCcjKqh7PjJCOjdL2diWWBTlBMn4t6H3rUbs4OMtNYWXKHZZ8wctlirGW15P8l97UxE4UCJirGg2mz6jLke+NifvIDVZej88h6BXqz86P2gb0Uqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=utsd+n2B2vshO6PPVOAtO2L24elepQwkDK0OtzrQZHA=;
 b=SbJvWhUYfd2HF52EFjR00+D/5LyrB6rGO+uEENTNQcYT7t+WV6rX9t7F+aFqmzCSc1Ibq3tKsiK4lp0YCxpyFNbwb84/484BiJpSCAovk7Yf7jdE8SJac2O5pW4dvG1+xhcBPa6wFx+9xiKG3ds88arFM2ZAVe6+0kafRVjvl+t1INK5vC4tZ+g2gw53qpZuv38+R48MmJXzloZuGVVkM49CB6O6LPUXfs8hAiv4XzZIH9oi8kLLMq60y4vHX2Lnv+2HJu0Drlp/YOSJhxTEPxzmagto2dJUhmtKtymcIAjzhyLBjXXy1+cCTD8pefjBnTkZaF6wsaXImfpVdQJ1SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=utsd+n2B2vshO6PPVOAtO2L24elepQwkDK0OtzrQZHA=;
 b=Z8WopxyKy+pSZ99jKTKj5lrJ9K+edNjKtISfgXVfockZO+Q+qizzsc5g6G5uo0/d6RCA2G/Qo7vosoqRT7RP24pR2yVKc5AnRVID6IFidOzLJ+px3JfNRNTLRDSVmwpftrRdXXg03SvAm9nG1Qpu8QPrOGjRtIGWk+bHuNGFfAc=
Received: from DM4PR12MB5278.namprd12.prod.outlook.com (2603:10b6:5:39e::17)
 by IA1PR12MB6354.namprd12.prod.outlook.com (2603:10b6:208:3e2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Mon, 12 Dec
 2022 02:59:49 +0000
Received: from DM4PR12MB5278.namprd12.prod.outlook.com
 ([fe80::960b:6963:b27e:f9ed]) by DM4PR12MB5278.namprd12.prod.outlook.com
 ([fe80::960b:6963:b27e:f9ed%8]) with mapi id 15.20.5880.019; Mon, 12 Dec 2022
 02:59:49 +0000
From:   "Yuan, Perry" <Perry.Yuan@amd.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
CC:     "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "Huang, Ray" <Ray.Huang@amd.com>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "Sharma, Deepak" <Deepak.Sharma@amd.com>,
        "Fontenot, Nathan" <Nathan.Fontenot@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Huang, Shimmer" <Shimmer.Huang@amd.com>,
        "Du, Xiaojian" <Xiaojian.Du@amd.com>,
        "Meng, Li (Jassmine)" <Li.Meng@amd.com>,
        "Karny, Wyes" <Wyes.Karny@amd.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v7 00/13] Implement AMD Pstate EPP Driver
Thread-Topic: [PATCH v7 00/13] Implement AMD Pstate EPP Driver
Thread-Index: AQHZCvbsP+Va64qP+0+OeRaJ0sOkjq5j3KuAgAW3xAA=
Date:   Mon, 12 Dec 2022 02:59:49 +0000
Message-ID: <DM4PR12MB52783E998600CDD52E5A94889CE29@DM4PR12MB5278.namprd12.prod.outlook.com>
References: <20221208111852.386731-1-perry.yuan@amd.com>
 <CAJZ5v0grDdCtWdKHEybb9kX_JWHsb_4x-7eA6mmiRbBaTmDSxg@mail.gmail.com>
In-Reply-To: <CAJZ5v0grDdCtWdKHEybb9kX_JWHsb_4x-7eA6mmiRbBaTmDSxg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-12-12T02:59:47Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=7af52485-326c-4179-988b-12cfe2d1e446;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-12-12T02:59:47Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 7bd55b15-1475-4671-8c98-6f2f3645cdb1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5278:EE_|IA1PR12MB6354:EE_
x-ms-office365-filtering-correlation-id: 605943ef-5fce-4645-ce2a-08dadbecef2d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0otwnbn1gvFgbrpcqDUdE6l26aDZLWngQthJVG6qIfZ+KmENBynnhZtlqykfgzBfOSSJ+FejImL+w3vjC9wPs8pWvikAM11x1nA6QVr3FKXL4scoWfbgxp0FSOXpz4uWbP7SfdmSd9aSb6O1ZZXmHREJQFRebteRTTPqoq9vyzhPoERk6ymmNWaYxP5SMcbR9X/7oZt8LVhuLNdSLp2Dxfpqktu19AE1iWEP4pZnIIjLA5/cdEP2+TlyzdsLg1ROdyMfIE22yhMSWzu3PHuBavilZxs+hnL1VYN+he6Aad5VHKDA2fXQ8DsV4KWgCuBjD3J6r2lIZzLiX6yZxzhuGnfj5v9gkZq9tVTNrm+AAq1vMbmR5QsXmU22Q5DrYyTV+5A3JZ+QMLRzzIOf943FINXikYmyG86f+qF7SccbhhRUnFPjTawPjGOb+yB5eXEyRVbs3SvvTih6KaeV0oJxjm7FutR2tZE7aZJF8kZoHL0iWZtOkH3A5s/mclitXv/2tYBB+AYHxlpetBwsQZePF+rfRbxqZbqfe198RHMXeOrG9BI6PJbPG6Yv+BfvFkXMPAEqCMcha1BcQAY1TUxLEf34cYh9mpC2AS3K8BbIWsQPTHVsX2oph83Rj4HgtvoYhNf0xR9bE4LqbAl8H3B2gc0BqFVLIxjYLW+jIArEBtqbzFGFQfmAysjNt3X0RnVhI9qnLzhVijj7MCEvnMSQlw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5278.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(39860400002)(346002)(396003)(366004)(451199015)(33656002)(2906002)(122000001)(54906003)(8936002)(55016003)(38100700002)(52536014)(86362001)(41300700001)(5660300002)(38070700005)(83380400001)(316002)(6916009)(186003)(478600001)(71200400001)(66946007)(66476007)(64756008)(76116006)(8676002)(66446008)(66556008)(4326008)(26005)(6506007)(9686003)(53546011)(7696005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bHJPN24xbS83L3Z1bVk1SGs5TDVvUE5CMlBYUzlHQmJac0JzTFdzZTBwY2hy?=
 =?utf-8?B?V2VxakQ1NmhiSHBHRTVQUjQ2T1NOallrcTd5T2JYa1BMdy96cFZRTzFRR1VL?=
 =?utf-8?B?Tkx6clorUk5xL1JWUUFvZ1lHUWpUT0w1bjFKa1FWY0g1S0xTaVJxTExubC8v?=
 =?utf-8?B?WDZxSU5ST1NsQXpEdW9PTldaR2hCSUtIWEJtY00zdzQxTmprdzFUMm1Qakc5?=
 =?utf-8?B?RGN6Zkd2a24rZFlzOGxmZGltUit5OGFMUlg4OTF0a1FEcGZ6ZXN6bSszc2lJ?=
 =?utf-8?B?aEtKdFByb1NPOGlIeWN5NDZkMXFpWTY3VHJBQ1NSUVlzN1dGMld1dno1WVhR?=
 =?utf-8?B?NDlkbEJxb3NJZ3pVeGFnZTh4VGNmQys5V0wyeVpBcUVaTGlsYXp2eC9NV3Jj?=
 =?utf-8?B?OHAwRGFLTXhrNmh0YndEcEVGUkpvUk94b1VNa1hHYkJKbTNicHVrZFhPZStS?=
 =?utf-8?B?ODErempYSktVOVBkWnRtR05zRlFkRXhMUTBNaUdnQWFnWXJOd25ZeGM5ajVQ?=
 =?utf-8?B?akhuUy9SVjVwbElwa3k1ZnNicDBvcnNxZzFhd1ljUEJveXlSaGNhUkNWTUtG?=
 =?utf-8?B?YkllbTdSZUw3OEhNeTVJMlU0dzVIbSt3eGZSa2IrRmNlUjA5QWVpUkQ0RHJQ?=
 =?utf-8?B?U29meGNYN0NGekN3MTgzcVdoeDJ6TnhOd01rRW9BQ1JhUDgvdzd4WkNwNjFB?=
 =?utf-8?B?SDRBeXk4MlFDVTFNeGhEdVVHRXBpYllBYXpEeWtWd3E5NUJseTFuc2E5aCtQ?=
 =?utf-8?B?TkJzMlNwZjlrZG8vN2Izc0Vpd2FwSllmeWFtbWlFRWJhRXA4L0k3Z2J2a0Vj?=
 =?utf-8?B?V055RjBISkI0TEdZdHRMdnRQR3ZwM3ZKN0xobmdnU3NDZG05ZXBwRVF5dFk2?=
 =?utf-8?B?MVIvNzlaT0FDM3NQa2l3bXFoa2h1dWZTVzhiR2hlNnJUTDgwRUZmL3VSaDND?=
 =?utf-8?B?M29DamRoc2RnQVBrajFBVXh3RmNYUFcrZ3E5NDJGZXNZdFNOdVNUT2hFeUFD?=
 =?utf-8?B?QjJNZ1ZtZzFod3lyS3RiVEFkLzRDYzVOL0Y0VmRsMWZoamNrdjZ6Z2Y4UEJB?=
 =?utf-8?B?dS9lRFBnb1A5NDVTblh2bFRhaUtyeDNLT1NCR1BmOWsyenA1Zm9OZHkvMk52?=
 =?utf-8?B?ZFc4MU55RXFVU2VrMTRvcnA1RFhNS1FzQzI0c0s5N1RxdE5Ub0o4ZTByaEtI?=
 =?utf-8?B?QXF5SjFiSUluVTl4UXN1YU1zMURtbGVHTzQwSWRMVE9uQ1FxanhWZGRrR0kz?=
 =?utf-8?B?QVFBMzZlSXp6R2JUQlRzbWVoRTh1ZFRiQ3pyZjVoWng1bGFlMUlSQXJwVGFw?=
 =?utf-8?B?RWxySi9BK0pzWEdIVG8xekJYdnppUFZ4YkhuV2R5L1ZxT3RCRndRaFBYVWdU?=
 =?utf-8?B?d2orQ0RwY2F3bnJCU1F2VGpvWkYyNk5uL1BDNlVlUmYrNk9ScEp5M0R4Q3Vp?=
 =?utf-8?B?b2F5bnIwS2xLdDZyZzJZc0JIRUJ1cFlBMEFlN2ZybURuRVMwWUcwZ2lsdjVU?=
 =?utf-8?B?S0JON3B6TloxRSs3L0poYnVrckpMK055RGtZdFN1WXJFaGJXMzRuNzJ4YW5C?=
 =?utf-8?B?bDdjY0FuRmpHVzRBT0xudWZXcmRwWk5rWHhvcEpPZzBwRnE2STh0Z1AwNC94?=
 =?utf-8?B?M0h5RWxDOCszWTVLRXRiQ1JkU1BWWEhkc3gzM0VueDFHQVhadVlvKzZqbDk5?=
 =?utf-8?B?d0ZnTkdoa0R1VWo3TlRWMGVEY29xNHlndS85dXNXNzRkQ2R3aEo2UkVaN1RZ?=
 =?utf-8?B?TytGS3dzVWh4NzRFK05ySUlmTmFkdk9PbDQwNElMUnRRSERVTXhENkZGOFcr?=
 =?utf-8?B?cmZzMXQ0WXdIOVpiTnErMUc1eERQVkRweXdoUHY2OE9oTXVHTXJwWmdwaGtW?=
 =?utf-8?B?cnU3Q2t5TEphK096VGRLRU9vSk1iSUVqZG1lRjZ6L2krWXcrc1VkTGRTVjIz?=
 =?utf-8?B?MllQMmZrbXViWlh3bFlPR0s1UTRnc2hwYU5oQ01vT3lveVhXZVA4Zkd1eUxm?=
 =?utf-8?B?QVA3dVM1RFppM0Jnam1NSHpKbVBqbmFabjl5NExkZUJPNG4rNDdJSSt2MXJa?=
 =?utf-8?B?T3I3RThhN1BZSnV5ZTNlc290V3pleWR0TThmZVhOK3k0TDdQK2hkRS9yZVZM?=
 =?utf-8?Q?qYZxIqCQ5hHDTS8NrKvKjICvz?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5278.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 605943ef-5fce-4645-ce2a-08dadbecef2d
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2022 02:59:49.7712
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tPolIKwtl8dooX9JRPvwTAA84KyJAUQAnkngpUYO64q+pfizRa9c2uxmdFS6YgGwMpSf+w/XVGab21Cpfv/YWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6354
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCkhpIFJhZmFlbC4gDQoNCj4gLS0t
LS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUmFmYWVsIEouIFd5c29ja2kgPHJhZmFl
bEBrZXJuZWwub3JnPg0KPiBTZW50OiBUaHVyc2RheSwgRGVjZW1iZXIgOCwgMjAyMiA3OjM2IFBN
DQo+IFRvOiBZdWFuLCBQZXJyeSA8UGVycnkuWXVhbkBhbWQuY29tPg0KPiBDYzogcmFmYWVsLmou
d3lzb2NraUBpbnRlbC5jb207IExpbW9uY2llbGxvLCBNYXJpbw0KPiA8TWFyaW8uTGltb25jaWVs
bG9AYW1kLmNvbT47IEh1YW5nLCBSYXkgPFJheS5IdWFuZ0BhbWQuY29tPjsNCj4gdmlyZXNoLmt1
bWFyQGxpbmFyby5vcmc7IFNoYXJtYSwgRGVlcGFrIDxEZWVwYWsuU2hhcm1hQGFtZC5jb20+Ow0K
PiBGb250ZW5vdCwgTmF0aGFuIDxOYXRoYW4uRm9udGVub3RAYW1kLmNvbT47IERldWNoZXIsIEFs
ZXhhbmRlcg0KPiA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IEh1YW5nLCBTaGltbWVyDQo+
IDxTaGltbWVyLkh1YW5nQGFtZC5jb20+OyBEdSwgWGlhb2ppYW4gPFhpYW9qaWFuLkR1QGFtZC5j
b20+OyBNZW5nLA0KPiBMaSAoSmFzc21pbmUpIDxMaS5NZW5nQGFtZC5jb20+OyBLYXJueSwgV3ll
cyA8V3llcy5LYXJueUBhbWQuY29tPjsNCj4gbGludXgtcG1Admdlci5rZXJuZWwub3JnOyBsaW51
eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjcgMDAvMTNd
IEltcGxlbWVudCBBTUQgUHN0YXRlIEVQUCBEcml2ZXINCj4gDQo+IEhpLA0KPiANCj4gT24gVGh1
LCBEZWMgOCwgMjAyMiBhdCAxMjoxOSBQTSBQZXJyeSBZdWFuIDxwZXJyeS55dWFuQGFtZC5jb20+
IHdyb3RlOg0KPiA+DQo+ID4gSGkgYWxsLA0KPiA+DQo+ID4gVGhpcyBwYXRjaHNldCBpbXBsZW1l
bnRzIG9uZSBuZXcgQU1EIENQVSBmcmVxdWVuY3kgZHJpdmVyDQo+ID4gYGFtZC1wc3RhdGUtZXBw
YCBpbnN0YW5jZSBmb3IgYmV0dGVyIHBlcmZvcm1hbmNlIGFuZCBwb3dlciBjb250cm9sLg0KPiA+
IENQUEMgaGFzIGEgcGFyYW1ldGVyIGNhbGxlZCBlbmVyZ3kgcHJlZmVyZW5jZSBwZXJmb3JtYW5j
ZSAoRVBQKS4NCj4gPiBUaGUgRVBQIGlzIHVzZWQgaW4gdGhlIENDTEsgRFBNIGNvbnRyb2xsZXIg
dG8gZHJpdmUgdGhlIGZyZXF1ZW5jeSB0aGF0DQo+ID4gYSBjb3JlIGlzIGdvaW5nIHRvIG9wZXJh
dGUgZHVyaW5nIHNob3J0IHBlcmlvZHMgb2YgYWN0aXZpdHkuDQo+ID4gRVBQIHZhbHVlcyB3aWxs
IGJlIHV0aWxpemVkIGZvciBkaWZmZXJlbnQgT1MgcHJvZmlsZXMgKGJhbGFuY2VkLCBwZXJmb3Jt
YW5jZSwNCj4gcG93ZXIgc2F2aW5ncykuDQo+IA0KPiBJIGhvbmVzdGx5IGRvbid0IHRoaW5rIHRo
YXQgdGhpcyB3b3JrIGlzIHJlYWR5IGZvciA2LjIuDQo+IA0KPiBUaGUgbnVtYmVyIG9mIHBhdGNo
ZXMgaW4gdGhlIHNlcmllcyBzZWVtcyB0byBjaGFuZ2UgZnJlcXVlbnRseSBhbmQgdGhlcmUNCj4g
YXJlIGFjdGl2ZSBkaXNjdXNzaW9ucyBhcm91bmQgc3BlY2lmaWMgcGF0Y2hlcy4NCj4gDQo+IEFj
Y29yZGluZ2x5LCBJIHdpbGwgbm90IGNvbnNpZGVyIGFwcGx5aW5nIGl0IHVudGlsIDYuMi1yYzEg
aXMgb3V0Lg0KPiANCj4gVGhhbmtzIQ0KDQpUaGFua3MgZm9yIHlvdXIgZmVlZGJhY2sgb24gdGhp
cy4gIEkgYWRkIHNvbWUgaXNzdWUgZml4ICBhbmQgc29tZSBkb2N1bWVudHMgcGF0Y2hlcyB0byB0
aGUgc2VyaWVzIHdoaWNoIGNoYW5nZXMgdGhlIHBhdGNoZXMgbnVtYmVycy4gIA0KSSB3aWxsIGRy
aXZlIHRoZSBmZWVkYmFjayBhbmQgd2lsbCBnZXQgcmV2aWV3IGFuZCBhY2sgZmxhZ3MgYmVmb3Jl
IHlvdSBoZWxwIHRvIG1lcmdlIGl0LiANCg0KUGVycnkuIA0K
