Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 556166E858B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 01:00:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233797AbjDSXAK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 19:00:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233850AbjDSW7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 18:59:54 -0400
Received: from CY4PR02CU008.outbound.protection.outlook.com (mail-westcentralusazon11012004.outbound.protection.outlook.com [40.93.200.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 662F14699
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 15:59:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hbuJfXHtF4rUrT7JC+ze+03xc4Akl+AN2J6EXCUTSFhgRllhf3ZPY1/hlTaADzLlequUBZs8KmH1ZwfB4ysJqe90R12j7bjDQxOI8+cinoswkMmvKB0ZLEJjrfDc98Srk2zynkNJK2cjxHG785m//cwSXI4D/URQqKI6yumP5wmO2/6UWKsFlRi1vU4RgbUlJ/GVSxQ8bI7tReih5XsvTVC973w4zJiKF1apTw2BeYyN8ECa/fidvD1NMnltnt4AjXbeGB7JyOfQos+kK2VOXU7Cjs6B9hMrl/c8YP62Q1c8RjKimFev76FsIvOF94j7R+U5KEJkPqKbd1icj6xPmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jc79i78fEf8MAZ0K+lxu5CSbC9iXyNWUVr0mwxA4nPA=;
 b=QesX8Bv0uH3MzOa2j0d2Rbu4qmGN+7zNgrTDv1m6pxy4bk3KlZbIYaJi36Aq/Dm3c23pBBWi84pHVz7spkyYwbLRDYemMeklAsDCgLzZwProQB0XMB6BZfPQxiq/rmEpcdBhcUGTODuPtmuLel5DUinPrDG20noUfQ1mTwKZY6uXKq4OobIA2mL34xpGj/mZpd8+B3lW7rTKbI98RnPeLXbUMmpIi4SoHMWOVrmyZSIVFYSK876woJ9f07SfOmRwYxsvl3gNigV6l7N8JHYhuwnC+LSqwMRS3rg2QeAADIKBshWMU3xZ33S/cBbNSPnnARY+mDIOb3wafm7xRxb/bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jc79i78fEf8MAZ0K+lxu5CSbC9iXyNWUVr0mwxA4nPA=;
 b=bzbtW5OGafCQWT+/GUXdATTNajSytWbbw9aIDczi5mnPq4AvKTOKn9KBaMT25yAEqRlqLQHeEFmFivsc2v94zgOSEBr87PtZTcAN5zpkrmtcXH/mTdfpzlK38F8echqzlolHxzjCD3dPkjp1Aqq8lHXKAuijxcT2cRdjR40DgSI=
Received: from BY3PR05MB8531.namprd05.prod.outlook.com (2603:10b6:a03:3ce::6)
 by MN2PR05MB6494.namprd05.prod.outlook.com (2603:10b6:208:d9::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Wed, 19 Apr
 2023 22:58:18 +0000
Received: from BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::f1bc:4933:8701:7ff0]) by BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::f1bc:4933:8701:7ff0%7]) with mapi id 15.20.6319.022; Wed, 19 Apr 2023
 22:58:18 +0000
From:   Nadav Amit <namit@vmware.com>
To:     "Huang, Ying" <ying.huang@intel.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kernel test robot <yujie.liu@intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Hugh Dickins <hughd@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH] mm,unmap: avoid flushing TLB in batch if PTE is
 inaccessible
Thread-Topic: [PATCH] mm,unmap: avoid flushing TLB in batch if PTE is
 inaccessible
Thread-Index: AQHZa4FwosvoCxZx+kWFav90J+Ui/a8k84GAgABgfg+AARGUgIAAhiWJgAD94QCACIhzfoAC28CA
Date:   Wed, 19 Apr 2023 22:58:17 +0000
Message-ID: <A7009B2B-8480-4AEB-8924-7E520A95386A@vmware.com>
References: <20230410075224.827740-1-ying.huang@intel.com>
 <402A3E9D-5136-4747-91FF-C3AA2D557784@vmware.com>
 <87zg7f19xu.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <D432368D-7E3F-47C8-8BE3-A0D11BC6EA2D@vmware.com>
 <87sfd5zx5b.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <03BCE979-33B1-486F-A969-0475A35DEBB5@vmware.com>
 <87a5z5vpy7.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87a5z5vpy7.fsf@yhuang6-desk2.ccr.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.500.231)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR05MB8531:EE_|MN2PR05MB6494:EE_
x-ms-office365-filtering-correlation-id: a00064ae-db07-47af-ea21-08db412990a5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3uDfhT6tlsF9ZNTX3cIzEGMpolstSVmuuePu/9uRrU5GluKdLaRMEQEL76xUdvgs221gAO2uRaCHiv1zsT9tiZHWwOzAJQj/zYGQjwWOWmQ57oOyTPPFGDac+KgmIeIctKHoEvIx3GNyd/V/QwrkBtjbFP4EPQcX22UtLyTFh7Hhgy+FVU1b9xLhHMRVDW1fiLj0CoCeXnl39KvGCE5ujl9bJxe9eCBdqReLxuNmiJuDyvnklMh3cTd+8PQEuy31PKFZCIF2HJmDZcAzyX3rOtr53/VNJhtHGdiHYz4+rl57WGs9GEhzVmqqLUq94V6/Bd6w2/LxipDKwyC5BeF1raVtcATuRf2qu8EJAu7FRz1EGUw2eq4NdVPiJztkgThnpb++QVx11wSxgucQfmX6NTG3vmvDaT7u0RNUVQ50rgzXh5c27lXS+9S+fQj67djO2ZI0BcqkKAz1UQrvziHruDRUDOc5Xbhp2y3NTbnhQT4vZ8lSpiLoFFbr77h9AosxWkO844pjuVVCgVtYLAY1UMaAnqKMtcJC2qkr85XVQAXNimErJq0B0nfM/QpyHmb2qYjNit0XAmWedXYXjiYc1fPv7kZLru/di6FmELF3OuWIWYQzZvu+W1ljXbtxWFOdnsjktN3TnGtsbZ1WbslnkQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR05MB8531.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(346002)(376002)(136003)(39860400002)(451199021)(2616005)(6512007)(6506007)(26005)(478600001)(86362001)(54906003)(66946007)(66556008)(316002)(66446008)(66476007)(64756008)(4326008)(6916009)(186003)(6486002)(71200400001)(53546011)(76116006)(122000001)(41300700001)(38100700002)(5660300002)(2906002)(4744005)(8936002)(8676002)(38070700005)(36756003)(33656002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OUhjUS8wbXVIc2JIWmRuVXNJSkdiN1BYSXhVWDVmbmZMcmlicFROTlhwMkx1?=
 =?utf-8?B?UlFUMHRRbGVDSU1qWWpPeGNqNFYyTTdrK05jUjREdmhyVW1DQjUraDhvKzNG?=
 =?utf-8?B?azUrM21Rekd4cVhkbE9sT1dSUmE4SDdpT1I5SE41K3d1LzJqRVVmbFNjTnND?=
 =?utf-8?B?Uzk4dXkyczZpRkFXc2pRVXhZd2dZekdyQjFzeGUrM2toaDBsb1o5VUtTcndE?=
 =?utf-8?B?YTNmK1EvN0RrR2t6bkFRSFp3RXllSUdLV1hEbk9SamVkem5oTkxjY0J5RkRk?=
 =?utf-8?B?YllCSXEvcDg5cWxibmJvNk9BOG5Bc0dQWTJhdjJBeWdpdjdNUkxNdWlLOG41?=
 =?utf-8?B?djRIckhtaTM5blpvSmI2clBMMlp4MWRTVnpwcWFxVWxiTUliTnptNVV4MjVs?=
 =?utf-8?B?UmZNOEtPS1o1V3R5WkFXNTl3SlFURVJxUkdlM0taVzNQckY2bTh3MHdJalY5?=
 =?utf-8?B?Y0x0NlE4WFQ5UDE1UWo1TVBPNE10Tlp1T2ZoTFdDaGMyeS9MV0kreUxmc1V2?=
 =?utf-8?B?VERQY05pMTR1emU1M3VzdksrL3JnNEJFdTM4TWY5dUtEZ3Z5MkJQRmVnRVQy?=
 =?utf-8?B?Rkl4cTAxSU9BeCtiMGVVNFY4cmZTN1lWcFJqL1ZyWFFRd3YzNldkNGxzamxr?=
 =?utf-8?B?ek9MZmhBREw2RjNZUGxjQytyNjYrZWRMYWkxTm5NYmlGWHhvaXBvUWNlcGdW?=
 =?utf-8?B?ZVdVRzA2d1VTdlo3czlNcElyb2ZhTlFUS1dhQzFNRDJQL0U0NlRiZDNZVFpm?=
 =?utf-8?B?S1MySFZWT1JYNlcvZzdtSEc4WGFSVGJOcklsaEhhNllpSTM1MTF3dzdqZFpL?=
 =?utf-8?B?VTVEK0ptMkYzV1A1NzRhNkp3K2N4b2VweFBxSjNHRU40RlZNZWYvV2FMaDBX?=
 =?utf-8?B?d1l0ZU1USFhrQzh1Z0NtbDl1Y1R6U1RGRjJobC9hMStDdC9aVGVXbU1BUG9p?=
 =?utf-8?B?VWdYR2hGeEFUVTdFbkYrNVV2V3JlZWJPYVJGV3VVNjhKcE1nNE5YMjk0TEdo?=
 =?utf-8?B?YS9FOWxoZTJNcXFScFE3RzhnNmV5NGE0Y0dJYzVJS3craFVxUzBPME85UmNY?=
 =?utf-8?B?VkhsM0ttR0VQTGpxQmVWKzczZEdQT0pKTE1zb09CVitLcmcxZjBjTm45QUtz?=
 =?utf-8?B?YWFxc2Z4REpHRFZ6OE9MemkwMitoRW9vd045WEZmeWlyNWhNWmZmK1NySUc5?=
 =?utf-8?B?R0Q2MU9SdVRSYU5YYitjZVlkTy9mdXpkSXVJODVQejNVK0s4MFNlMFJhTmds?=
 =?utf-8?B?NUY2SkJwaExIa3c2anlrV3Mwb05VNHJ6SDJ3WldyY0RJSThvTGNDZ24ySk5V?=
 =?utf-8?B?U0dRT2owNGVrcXRpbU1RemF4S1VMR2djN0I0MnZFbWVKOVBuS2xBaTVPcFJ3?=
 =?utf-8?B?bE5zM2NWWXZpcnFicm5hUTZvZU1HeEJpVVcrVExDMENpSTkxdFhHMWRTVWtF?=
 =?utf-8?B?c1o5RlBLSnd5R1p1WDhsNlo4TVZkb1hCV0x0TGl3UXFNMGhwdWNJbUwyelcw?=
 =?utf-8?B?TFRZVnNWdzJPS0VEMThjMitJUTBvRDVZNmFoNXFGNlBZa3lHK0RqdE8rTm42?=
 =?utf-8?B?M3MvNTYzODVhRlZIRXF0UEdOMHFGbUpEYzI4YTE1d2dEak5sWk9IY1hKZFpx?=
 =?utf-8?B?Zml2d28wUnhpdFJjZkRFMUFoanpRZTBBZVBIWEFBZHV2OGpXdlJGN051NCtI?=
 =?utf-8?B?U1VHUzJteDZSUDBlTU14S0QzQzV3OXNaRkVHKzJKN0dvK1pzWFZFRDltNml2?=
 =?utf-8?B?bHA0NnFiSTZvTU5kdXh3L05tR0I1OVVramYvOCtmQngyZUtsalQzQnlyeVI1?=
 =?utf-8?B?TG80RERsOFRwaVltbEM2T3BPNGpTU3FHek8wWGczRHRhSU1DVUJFajZwdG5x?=
 =?utf-8?B?Nk9NWjJjbDVjek1XRDRjL0lSSWd2eVlJc1VpcnNTaGtkR2lKQ3IvK1dTanQ5?=
 =?utf-8?B?MnRzRzlucVJ0Q1lQcnpKWlZmM3lxQzFBWEViZzhtNDJ0cTA0Mkczem85RVYv?=
 =?utf-8?B?cXc4U05sd0F5R1lOZUt2MnZFSkthQ2RFaGN3ZFFOaGdVNlBNVmVoQ3czNHNL?=
 =?utf-8?B?QjhZZ0wrOFdHeTJKVE96ZVh1MVFMYWVvcWJTSm5lTC83Q1pwYldkVkpqRFdz?=
 =?utf-8?Q?fIsiJIKDw3aypCRTLKd65IXpS?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C27B42A43B4CA34C8BE7B0855E187060@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR05MB8531.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a00064ae-db07-47af-ea21-08db412990a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2023 22:58:17.9119
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aCie5j8DC+qCrH+tbPl7ARISe1K8+6ZOSzKnSgvRKMuaD56FvU4nbHmwrDcjjj2i6MBQlNJufr1AAhj1OSACPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR05MB6494
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gT24gQXByIDE3LCAyMDIzLCBhdCA4OjE3IFBNLCBIdWFuZywgWWluZyA8eWluZy5odWFu
Z0BpbnRlbC5jb20+IHdyb3RlOg0KPiANCj4gISEgRXh0ZXJuYWwgRW1haWwNCj4gDQo+IE5hZGF2
IEFtaXQgPG5hbWl0QHZtd2FyZS5jb20+IHdyaXRlczoNCj4+IA0KPj4gWW91IGRpZG7igJl0IG1p
c3MgYW55dGhpbmcuIEkgd2VudCBvdmVyIHRoZSBjb21tZW50IG9uDQo+PiBpbmNfdGxiX2ZsdXNo
X3BlbmRpbmcoKSBhbmQgeW91IGZvbGxvdyB0aGUgc2NoZW1lLg0KPiANCj4gVGhhbmtzISAgQ2Fu
IEkgZ2V0IHlvdXIgYWNrZWQtYnkgb3IgcmV2aWV3ZWQtYnkgZm9yIHRoaXMgcGF0Y2g/DQoNClJl
dmlld2VkLWJ5OiBOYWRhdiBBbWl0IDxuYW1pdEB2bXdhcmUuY29tPg0KDQpUaGFua3MsDQpOYWRh
dg==
