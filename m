Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8C3E5BB36F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 22:22:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbiIPUWY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 16:22:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230244AbiIPUWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 16:22:06 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2085.outbound.protection.outlook.com [40.107.95.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D4F7BA143;
        Fri, 16 Sep 2022 13:22:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KiwG2ptVgdlTj5F2hbvf3762WmgPtf4Q+yz+5Vy8DYB6MuAL6PKJ9sjgZs+enmc45YEPh5KReRd/imJT+TpL+UbugxyPy+/A1tkj9jNIl+rLXL05VGgxmkxE+/a6tSDgtG8AabqULyQzizNAO0NP6HxFh+SOImweNp88HqGwMopIpMIOIuQGExVB3LX4U+7DMDBUUTfBu2oguIY5LnDfVpgYKC/rAgbKrfLNum6JcL7VEQoGkzydeWkSBe+bx7DS3jx0vKmxBLF4036boSIyR65z9oSsS3SB91+sZaJd8NXbrkHfLeXm/YM1vSzzZjJERMQg3wjhsCfw1oovyNspcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mq3LZtst0hVcKVi5gz2Is+rdszcCdIiVcMWjyxIdd74=;
 b=ZPGRTxpSsECfypitggeddw5rxQedIQpwFqLyXtzFCR3pe0EjN5cewWAAqWJhQoiZi/TWmwos6yyuI16rA7NPWSQ6RD8oxLfZT8uu8Ln1m8SLeoLHa1aoAtkfHCpXh7Ph2pdrC/uSqdwo+RathMRsKTFSGY9Z/yKRafqyQtRj7jdoSMqM/7n8FPtv0eqaXmbO4bVTWtsTnu/mwd+JZjKvk4eGkthfqDlsqP/8hQyWsiHYg3lSbp9YJCsTDEdLfLFcpp1QP2C82bcYKSSvu8ZI3vTCbp6nVxnFxIUFbCOzb24gLkHjYt8XVjOmN55C5S+2Kove9QjEWPtG75YJW+iorA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mq3LZtst0hVcKVi5gz2Is+rdszcCdIiVcMWjyxIdd74=;
 b=XrJvWgZeknPF1nduQD4ZrWaJrQoeD7kMr7iGKm0v4PPxuLOTk6JwaXNJDI0/9lrrAcxhAHSBoKMMgWIcJZZoAy808DhscOtB5GcFZNIQPNCAyEjCxmmmxAeu4itvgJ3z5xyFQI0dAaP7aiw7Rmk1Y4E6C6exSBvkqq0NEwjy7S4=
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by BL1PR12MB5224.namprd12.prod.outlook.com (2603:10b6:208:319::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.16; Fri, 16 Sep
 2022 20:22:03 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::4120:60cf:46a8:7109]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::4120:60cf:46a8:7109%7]) with mapi id 15.20.5632.016; Fri, 16 Sep 2022
 20:22:03 +0000
From:   "Moger, Babu" <Babu.Moger@amd.com>
To:     Reinette Chatre <reinette.chatre@intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>
CC:     "fenghua.yu@intel.com" <fenghua.yu@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "paulmck@kernel.org" <paulmck@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "quic_neeraju@quicinc.com" <quic_neeraju@quicinc.com>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "damien.lemoal@opensource.wdc.com" <damien.lemoal@opensource.wdc.com>,
        "songmuchun@bytedance.com" <songmuchun@bytedance.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "jpoimboe@kernel.org" <jpoimboe@kernel.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "chang.seok.bae@intel.com" <chang.seok.bae@intel.com>,
        "pawan.kumar.gupta@linux.intel.com" 
        <pawan.kumar.gupta@linux.intel.com>,
        "jmattson@google.com" <jmattson@google.com>,
        "daniel.sneddon@linux.intel.com" <daniel.sneddon@linux.intel.com>,
        "Das1, Sandipan" <Sandipan.Das@amd.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bagasdotme@gmail.com" <bagasdotme@gmail.com>,
        "eranian@google.com" <eranian@google.com>
Subject: RE: [PATCH v4 06/13] x86/resctrl: Include new features in command
 line options
Thread-Topic: [PATCH v4 06/13] x86/resctrl: Include new features in command
 line options
Thread-Index: AQHYyeTKbmTIeM3ggUmjTZyA8NIsYq3igBbA
Date:   Fri, 16 Sep 2022 20:22:02 +0000
Message-ID: <MW3PR12MB4553766785ED10985A0446F595489@MW3PR12MB4553.namprd12.prod.outlook.com>
References: <166257348081.1043018.11227924488792315932.stgit@bmoger-ubuntu>
 <166257364128.1043018.12636485490608845145.stgit@bmoger-ubuntu>
 <fcb18ac6-ba84-5054-8663-fb1bb8902b9e@intel.com>
In-Reply-To: <fcb18ac6-ba84-5054-8663-fb1bb8902b9e@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-09-16T20:21:44Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=7cbb8430-44e8-4d89-885f-41f3eb4c7e68;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-09-16T20:22:01Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 98de9500-9c07-49c6-af6c-0cd8984e7428
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW3PR12MB4553:EE_|BL1PR12MB5224:EE_
x-ms-office365-filtering-correlation-id: 17e938d3-b103-4a4b-330a-08da98211dea
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BKQaAxoVPD1Ajd6sYKguRYfqsTUhJnHtCIpSUqX32IDbhmQTfXCyLYX+JwPNix3wVjs9qzFHjApUDmBBByv5VE3GIRa0pmzRNDLaWAHUzqzOWB7NSwHrelsQrnwTpp3GI49uNQg6K6/HvVF22amdKM8B0sXv+vPNUwmDzc0kLIuuUX+P3PYRyTwjNNMsPmIeZO5Ma5dWilWUGZcBb5MOZlEtLua7u7pSlhPDhLvlY5RxAD+DC2nOmrDRwVu5OyLRMGRGjnz5MTxcVgUhAA1vfjCBwKfbUOHYnTIV3Mn7O6rlEmAbImmrT7UDFlo/6jazK6OB7tyGwWr0bgLfu+LA0vxN9ZeRO3S/jIT89M5Tjiw4HyXykqTWHagCIedoMP3F99Mu0mSGOyXvdPgzkt99+fabDwp5j7WMi9pNZ5IdnF3GNsFx8h4Rzes7q2SguxOcB2xVhN2zK4hltk4qUxYDkqJqHS9IYDhugIPeMMz2qaNjgAA6FQxFTZ1XVAVUKrT3y4pPCNvoQ1rPxbNhuX7zBfLHDbJzVboJczKbgCDMOUmSHce08kadDIbSWzXSF8cQYcV7/+tP4pcffAwSWeXDxW7E02NnPbWXaORWDKJ9s8gvTd2fzTldCrW+vwRvE9v2rX09rgYlYkXiTnpX6R4anjxM6XkTB8siubLkyX7Fr69cl+0tky9VHYDYpDhYCpVEiwlYhFwyalEUJBisGUDFPFKwcUTKqydGpgDsBXaRVgXXPt123k29Pv0BaRUFQicVjFRFGY30KGI7xEMjkON62g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(366004)(39860400002)(346002)(136003)(451199015)(55016003)(2906002)(66476007)(122000001)(76116006)(38100700002)(7416002)(5660300002)(52536014)(33656002)(8676002)(8936002)(316002)(66556008)(4326008)(66446008)(66946007)(110136005)(86362001)(54906003)(186003)(478600001)(26005)(38070700005)(64756008)(9686003)(83380400001)(71200400001)(6506007)(53546011)(7696005)(41300700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YnR5SUVSc1gycloxQUlTVytIdFNoL0xEcThTUzBCZVZKQXF3YlNiSDRqWW9J?=
 =?utf-8?B?OEd4RkkyV21ybWlscXVSdU5Fd2RwZ0ZLTGwxQzVDTzZEbWN5OEwxRml0ekNh?=
 =?utf-8?B?VGNUVGxPc25qUlU5VE90bUNGU2JEUk90RnhFUVA5ZjlIcWpaWlo0ZS96eUl0?=
 =?utf-8?B?bG5BRWNJSElTVDhhNFZDd3I3bHB1S2J6S1hieU1LN1NBaXpZcjh0R3FhUFJq?=
 =?utf-8?B?cktIS1VaSTdQb0dJTnlic2JWR1hUY0x2b0FxcStZNmt1U05tUFh0YkRnU0Zr?=
 =?utf-8?B?UndSRHhvZ0lkSW9MeXcyQi84S09ibEVQSStPS0MxanJEbzBzS0czRWswU3l1?=
 =?utf-8?B?RDRVckVFTXkrZEIxN25HMDVhdGxuQ0MvM2Jid01RT0dQNmk3TlRmM1VZRGJR?=
 =?utf-8?B?elBSejl1c09tYmRsZjZpUldCVzFWNTRZWjBmS1ppcEF6Zk9CVlV5Mlg3OE90?=
 =?utf-8?B?dkxIZ2pxMzNFMC9wTThSMkFJdlBwSTlLR1kvZDBrUUxsTG8xUk5Lelp6bCs0?=
 =?utf-8?B?ZzdyU3dPNWpQVDB5di9TRXN0SnVvRlU1ZEtpYkQ4ZEdYUHRlL3dIbUdyQklT?=
 =?utf-8?B?VEFqSlliQ2VaUWxFdVMveVd6d0hKQUdoRXJlZlRoVzBjWlJPUVNmN3hMV2g1?=
 =?utf-8?B?TVFKbTh5OHQxcnA5K1dDcGhkRVRtTWV5UWFZeVdIZ3g0M0tiUXJPRzVBVWNn?=
 =?utf-8?B?V09HUzNEMS9ieTBpZGlHTXd5NGNwOGxxdnVzOUFnSVc1d1laUXVOSEk4Mmdx?=
 =?utf-8?B?cEM0VWxMMVorY0pQekQ5MWtNdWJZdUVXcENiY1VjSEtUOHI5WFExM1dYSkw2?=
 =?utf-8?B?NjFiVFJJZU9EdWxuU242enBZNkQrYWhTVEpyNjVHWDFKeXdNTm5kTHBmTWVq?=
 =?utf-8?B?WDRrcmtjVDJsOGxnOFk3NUhia2dEN3MxbGR6aS9CZ1hoamJOZFB4VnVOUXNi?=
 =?utf-8?B?QVVZTHFUOGpBRnhqbnRSRFpWYm54RVRzRURjVm5GSHFNdXhEOCtVSW5FWjc1?=
 =?utf-8?B?ZnZJZVFIcGNBQTFnb0lLODhmcm5lYUxRdmlPYStxVnRYMWdKdjZjbDU0RjRo?=
 =?utf-8?B?R1dzTUIyRVpWdXFUaXhHL3A1WU1NWnRqR0NMWC95MEZOQWNVNng4RExGSXVL?=
 =?utf-8?B?cEJwVUNuM3pwYXFZTkJCdmhqMURGU0JJZnJ3OUtyVGZkY3pDbEphOE1pc0Fj?=
 =?utf-8?B?dXVBMytzZmE4WUQ1YkNYTi94NFNpeGRiOFFpZjFnbk1ydFVXVFBJY0Vzc0dB?=
 =?utf-8?B?K0JBRi9XQlZRTStDZVFqb0hqc284SVc3eWNqUkRlUE91bGNFZnQxQnBkcjJ5?=
 =?utf-8?B?d3ZBWGJHU2NCZnN1M0ZZM1NQUGFFSTZCZFlEd0FIbFp0SU1NZUd1YzZUbzlx?=
 =?utf-8?B?Zm9PQytXWllYT01na2d6YVJDSkJ3MmU5M2J1ZnJJTnBYeSt0WW5vUWp1eUJU?=
 =?utf-8?B?Y0o5d1pjbTZNNUJKSU5DaklhdlRXcjVHNTRUQnlEZHEvMW1NWmJzN1JGRXU4?=
 =?utf-8?B?YlIyRms1Y3Nja3c3T1Nud2VySzNKOVlwVHJKcXRaRm5NVG9CVFowMlVOZzdR?=
 =?utf-8?B?d2JraG5ic084SEpOc3ZRTmwwNWZvOXRvQWpHZVdJenVSdDBaNmV0Qk9NWUp2?=
 =?utf-8?B?K0hSNHZXcGxmaDhhdWQ4Wnl2V1ZoRFNvdjZhenoxcVNtM0IyT0dya3ZFa0Qz?=
 =?utf-8?B?c01sWHAvWnNqOG1pdGwyYk5XMEJLK3RJV1J2V0xjREcyNWhxcXFJVFUvSXE0?=
 =?utf-8?B?LzEraGpmb2F3QmpFU1oxc1p2VERzZllqdXhxWWFmeWtOTWFVYjRXbTFISkZ5?=
 =?utf-8?B?Uy9TU0VzTEtpSDd0dTlsSC9Cdk1CcEZ2ckpNaXUzYlVhS25tOHNnZXVGNk9p?=
 =?utf-8?B?MzlvNlNoa1RzRjBuKzNQL0JyTSs3Y2VZUW9HcEZ5c1Uvc0VlbXFWRWpKSFdS?=
 =?utf-8?B?bVZNMlBoSm9PcU4yMjdXOWpxeUY5Z0RxT3Z4aVdpTnN5aVB6Uy91RG1DQWJm?=
 =?utf-8?B?bk5YN1ZHTEt3Z0g5T2lFWEtHNG0xQWJ0VDRUMDBnSVE0YXFaWTZpVk1EclRF?=
 =?utf-8?B?NjZsY3ZEd082OEl5SEJxSlp3d1lpVlR5YmVVM1pUa2NWb29CZHo2RGFqUXE5?=
 =?utf-8?Q?/vBk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17e938d3-b103-4a4b-330a-08da98211dea
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2022 20:22:02.9108
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uYdXhnhKDTowx8jjxIwKaOr2EvoodZyRUxlesorICc3V47H5J3wPtmItWJgG2UBF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5224
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
TWVzc2FnZS0tLS0tDQo+IEZyb206IFJlaW5ldHRlIENoYXRyZSA8cmVpbmV0dGUuY2hhdHJlQGlu
dGVsLmNvbT4NCj4gU2VudDogRnJpZGF5LCBTZXB0ZW1iZXIgMTYsIDIwMjIgMTA6NTUgQU0NCj4g
VG86IE1vZ2VyLCBCYWJ1IDxCYWJ1Lk1vZ2VyQGFtZC5jb20+OyBjb3JiZXRAbHduLm5ldDsNCj4g
dGdseEBsaW51dHJvbml4LmRlOyBtaW5nb0ByZWRoYXQuY29tOyBicEBhbGllbjguZGUNCj4gQ2M6
IGZlbmdodWEueXVAaW50ZWwuY29tOyBkYXZlLmhhbnNlbkBsaW51eC5pbnRlbC5jb207IHg4NkBr
ZXJuZWwub3JnOw0KPiBocGFAenl0b3IuY29tOyBwYXVsbWNrQGtlcm5lbC5vcmc7IGFrcG1AbGlu
dXgtZm91bmRhdGlvbi5vcmc7DQo+IHF1aWNfbmVlcmFqdUBxdWljaW5jLmNvbTsgcmR1bmxhcEBp
bmZyYWRlYWQub3JnOw0KPiBkYW1pZW4ubGVtb2FsQG9wZW5zb3VyY2Uud2RjLmNvbTsgc29uZ211
Y2h1bkBieXRlZGFuY2UuY29tOw0KPiBwZXRlcnpAaW5mcmFkZWFkLm9yZzsganBvaW1ib2VAa2Vy
bmVsLm9yZzsgcGJvbnppbmlAcmVkaGF0LmNvbTsNCj4gY2hhbmcuc2Vvay5iYWVAaW50ZWwuY29t
OyBwYXdhbi5rdW1hci5ndXB0YUBsaW51eC5pbnRlbC5jb207DQo+IGptYXR0c29uQGdvb2dsZS5j
b207IGRhbmllbC5zbmVkZG9uQGxpbnV4LmludGVsLmNvbTsgRGFzMSwgU2FuZGlwYW4NCj4gPFNh
bmRpcGFuLkRhc0BhbWQuY29tPjsgdG9ueS5sdWNrQGludGVsLmNvbTsgamFtZXMubW9yc2VAYXJt
LmNvbTsNCj4gbGludXgtZG9jQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2Vy
bmVsLm9yZzsNCj4gYmFnYXNkb3RtZUBnbWFpbC5jb207IGVyYW5pYW5AZ29vZ2xlLmNvbQ0KPiBT
dWJqZWN0OiBSZTogW1BBVENIIHY0IDA2LzEzXSB4ODYvcmVzY3RybDogSW5jbHVkZSBuZXcgZmVh
dHVyZXMgaW4gY29tbWFuZA0KPiBsaW5lIG9wdGlvbnMNCj4gDQo+IEhpIEJhYnUsDQo+IA0KPiBP
biA5LzcvMjAyMiAxMTowMCBBTSwgQmFidSBNb2dlciB3cm90ZToNCj4gPiBBZGQgdGhlIGNvbW1h
bmQgbGluZSBvcHRpb25zIHRvIGRpc2FibGUgdGhlIG5ldyBmZWF0dXJlcy4NCj4gPiBzbWJhIDog
U2xvdyBNZW1vcnkgQmFuZHdpZHRoIEFsbG9jYXRpb24gbWJlYyA6IEJhbmR3aWR0aCBNb25pdG9y
IEV2ZW50DQo+ID4gQ29uZmlndXJhdGlvbi4NCj4gDQo+IG1iZWMgLT4gYm1lYyA/DQoNClllcy4g
VGhhbmtzDQpCYWJ1DQo=
