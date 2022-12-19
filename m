Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6316E650EAD
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 16:34:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232206AbiLSPeC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 10:34:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231821AbiLSPd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 10:33:59 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 127C4E31;
        Mon, 19 Dec 2022 07:33:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LCw1Yo5v+dqP0XQB7DxtswwqYZaNfjlb3VQBRAiCt7M5xRO3YHc1I/5qysV3b3JGSi/AJLOBH4W+r310+HT6ytCtpB9h2IxoZ/HCbOwcRnOPf1EfQ6NBGPeMVBtwikK5geB9TEXDzT9hmIdSR2G/QG9d6AC8JVyNQbHH/5AYdNBctTIUer51R6rvadUOQLg0/cH19yK2H5cvLWDRmHRTDDYk2rkNMcWMcPlmvv5sPxyt3e0OMF/tFvWWeqkm5fyLLhmlT/AHa7MuQupQV5CMN5l4N5Ehk322yxCb1rfdvyYyqB/Q/jtiC97VNcY7J0/mke95a8Fix0uoaHMN4GqoCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/45wNCAdUdi0oNM4ddwA6NTd+E1goVioE29KHhDvxxk=;
 b=jmW3jq9jLc6n4ZTrNqg8t7d77jbMOTdMgC+aBbrJ7Rsj+U9BiPUu8Pj7P2FYVRXGG8MyGzqsVcZ5f1kw+veog5gEs6YlHM+x/fRh9Yi5UX6rKS8qMFnErZPLx4sdBKug7yoNfLsh2ThJtBkgq0toyHLwCZB/3bDVXtxOO4eLbdwpKKS1vvMbJU4cLkdfNEWnAn65OTRIPTUAhNz5CxfadVOcQCDnp5xaYFf5lKXGIHV08F30dqaIMVKXL68fGGRnTsQoHObMKFQChvKlJpkN0XMK9A3ldcgOUOjY5qAh80Jh0PzdE4sqkMZmxICLln1fmSS5xAbMv36nex1EDjnH7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/45wNCAdUdi0oNM4ddwA6NTd+E1goVioE29KHhDvxxk=;
 b=kqhOSVmis+mpbFhwSD0GasNCklew3yDmgKDbK2Q6XFTtTymjF6RVNPZx6A9DQ6vNK3bvJYeg974aRbMPKwqumYxKjynzU3WrMxuWDlJCtjWe14g/HUiSkaDDrAv8JmdhnOIwQj4d0GJl6/jtZ9dV8J0qqE0UiIO9Cad/zSYsBus=
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by MW4PR12MB7310.namprd12.prod.outlook.com (2603:10b6:303:22c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Mon, 19 Dec
 2022 15:33:55 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::790c:da77:2d05:6098]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::790c:da77:2d05:6098%5]) with mapi id 15.20.5924.016; Mon, 19 Dec 2022
 15:33:55 +0000
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
        "eranian@google.com" <eranian@google.com>,
        "christophe.leroy@csgroup.eu" <christophe.leroy@csgroup.eu>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "quic_jiles@quicinc.com" <quic_jiles@quicinc.com>,
        "peternewman@google.com" <peternewman@google.com>
Subject: RE: [PATCH v9 04/13] x86/resctrl: Include new features in command
 line options
Thread-Topic: [PATCH v9 04/13] x86/resctrl: Include new features in command
 line options
Thread-Index: AQHZBZqwYlAJwlND90mLEub92dqckK5vRXwAgAYt2BA=
Date:   Mon, 19 Dec 2022 15:33:55 +0000
Message-ID: <MW3PR12MB4553FCF16F01F5F7C3D97C6B95E59@MW3PR12MB4553.namprd12.prod.outlook.com>
References: <166990882621.17806.16780480657453071426.stgit@bmoger-ubuntu>
 <166990898682.17806.2447018872734886554.stgit@bmoger-ubuntu>
 <171f3c50-17e7-de78-17fc-47f91f83d395@intel.com>
In-Reply-To: <171f3c50-17e7-de78-17fc-47f91f83d395@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-12-19T15:33:40Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=022edcdc-096b-403c-9cb7-39b0fb56761e;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-12-19T15:33:54Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 81aa2160-f50d-4004-a787-8785c503af3a
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW3PR12MB4553:EE_|MW4PR12MB7310:EE_
x-ms-office365-filtering-correlation-id: 450a6602-34f8-4583-85ce-08dae1d670bb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: w3DuUvSr0V6RRjyJnHnchcKFhV2gjK4PfH8HqAOK42G9KVSsCxmebZ0NRgCOyQVXgEa9W21oibEazIjBseKPn/LSsly4S9r5LKJLy30b+NpOV4rkMPKZmZ+FPu0KkXbLZKcwbTIAJpLMHg3+UUDO1n5O/XGbUCxVxjETFBllsfV4kJq0dN7F4b7wsP/qeawBNpkmYeHsb30+vJV/4ALqO6NKUjwZ2joswnlY2Gi2jhnm2/+/Zi4KMlqVkh/S+jSw3xNWDucK/AV/ZnRQ6wj/ROWM4DMHfuHYFQoz539Bo+w05174OsTCh2IGrzTbjITh0prw9dtiezvU2vPim3HI7Q9aMJtJYG52p12qsmfGT34h+4eSdrfNiHij7VHD9zZAOozle0Y/Ru+wyT5fdrRvy1N5k+lEOmab3icjLUM8xuBKGCR+UeTSfbQfvOevwLfZoyZqAoNJzgBLEFB/X1yVvuB2HpTn5QNeRSEn7zrVEZ6OTFK19nFBhCbte7AjZOg+4QuyrdeMTkmB7+cPW4tZe+yAr+0hBbGgvUcGG/PJYBRDlynxsvb7VncPST206tzaP9/W2oZZRyNpQYIq1U7ufdBwEPSwdDsImryXIYhNP2Pqouz5xBp/eiegkrqiQjdwJwnXkxdAHVPH15S6tHyudwPYeBEYV3b97AAWxs7SonpCKpOi4ToatezTyfnCkWC+cIo0THqtKaK9i6IdtB8KSA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(346002)(376002)(366004)(136003)(451199015)(55016003)(33656002)(7416002)(66946007)(4326008)(64756008)(66446008)(66556008)(76116006)(7406005)(83380400001)(8676002)(5660300002)(66476007)(52536014)(8936002)(7696005)(53546011)(6506007)(71200400001)(478600001)(110136005)(54906003)(316002)(9686003)(186003)(26005)(41300700001)(86362001)(38070700005)(2906002)(122000001)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Rm5PV3Iwc1RTWW1aSlV3R09DQ0J0Q3dTakZFRFBiK2NVVlFIRnV3MkFBRHN0?=
 =?utf-8?B?am9BMWJmZURKbWxsMEMwYlBZTThmOVJXTjNTR1FqVnhoODl4b1A1c0F1U2hL?=
 =?utf-8?B?dCs2QmdtQkV2dzdMdVkwQmRRNS9KSkkxUEhRSk03TGVkWlhGNE12TkVlazNO?=
 =?utf-8?B?VWRvMVRmZkxqUzB0Q0pqSVBRV1FGY20wdjB5VGgrQ0Y3V2MxRHM5a0dyMEVk?=
 =?utf-8?B?MXk1UDU4Njd0b0VITjAvYjJCaGNGZEtlTi9sOXZlTmtGUVhCV3I3eldRZGlW?=
 =?utf-8?B?YmUxQXBvRTlSVjUxd0h4amIxR0dMKzFibFVkVjUyY3hwYzlLQklQU0wyNm5M?=
 =?utf-8?B?bFBoVEhtZ0g5SnVjaHhRUFo5S2NIM3BDRXp3S1FmdzcrQkVGQWhKMjZqY3l0?=
 =?utf-8?B?bVI4ZEtHNFhyZzNiREpTa3hLcG9XeTdta2g5RmthalVSZlYxMTk5cXVuQlkz?=
 =?utf-8?B?MUxpRGhYWlRDdm5TMW9xWjdCbnVadlA3QkNNWG1uUFVPV2k2TElQakx4ODh4?=
 =?utf-8?B?L0x1RERQMDVjb1ljdXBvWkpsendOdnVIU1pqcU1HeExHWTRRckVDUFlaSUNj?=
 =?utf-8?B?eVFSMlY5Y3hXbEdLN2lQcXMzTSs0N200eXc0THRMQXV3YWNHaUlNZTJPaWFJ?=
 =?utf-8?B?R2tCM0x3RXRkYjNwNzZmczJWV2JOYWV3NlhyOGRyMi9JWlFZYmxacXFiOXhB?=
 =?utf-8?B?Q2NaSzkwSW5uTXA0VWQydit1RjRLdjJqWVZVRklwZnhYYTJ6ejBSc241bFlS?=
 =?utf-8?B?VDhSNGFIZzNiQ1pFMDhReVZIWkU2SThqUjRQeDVpSTl4VmxvSXJlOUgwUlk4?=
 =?utf-8?B?eWJ4UEN5bjErUTJnTGM0dFdVYjRBMlh1SjVLR3FrRjlPUXdOaEoxY1RaR2Fp?=
 =?utf-8?B?NFlRK3cyUDVnSUl1c245MjVYekFPSFFzSlhzOG1jQ09vZUJ1ZTdsbFNhM1VT?=
 =?utf-8?B?NCsxRlpFM3doWHdnd1RhQnBYUkVKQWdNUnVCV013cVZUNWU3eFJxelBLazRn?=
 =?utf-8?B?QjV6SWRxZWhCMlZJbTNZeFhsSjlRdWQ4MjdBU0tRRXpZd1lNblZpSFEwRWFT?=
 =?utf-8?B?WSt1UXBkSVdhcU8zZi9ZWDNUMXBGS0luSnl4MHh3cDU0ZzhaVWpSbDdVLzQw?=
 =?utf-8?B?WEdmZ3ZCUU5xOWFDMXJHak1hdkFDZEk2aDBVOW9xbmdpQnpaTllRa05GSUVk?=
 =?utf-8?B?blQzU1B6SndDNSs5b016SW5hOS82VXJuc2M5VDJSdjBQeU5LY1VBQjh4enAy?=
 =?utf-8?B?eFNVMThaYkczT2JGNlBReVArZ1Q1U3E2VnZibWhUOFlZTzBzZGZXRVU0akVw?=
 =?utf-8?B?dlNiTkh4K3BwRmFZc3orME5rdFIva29Uczc0dWNwV0Noano1RGhQQ1ZkOVFq?=
 =?utf-8?B?dGJoQ0NqNGQ0cHo5Z3d2Z2M1WU0zSWNWL0Rqb0ZOVFNYT0xOM0FLVG10bDdM?=
 =?utf-8?B?bzl5dXZMbVRMOUpFREZseTY5UFhSeDNTUnpJT0hiTW0zTk9lOWo1c0psdUcr?=
 =?utf-8?B?cG5GSjUvQUFCWklxVVVZTkRuRVVFQWRlWkszdFN6bXo0QVMxcVFlWlIrSExZ?=
 =?utf-8?B?TS9uTFBJelUwWmIyS0JZeUErbXYzNk1uVUhHRFdveDBlLzQ0c1VqbG1nTk9n?=
 =?utf-8?B?OTBlbHZWbjVJL0loVlVxUlI0d05kVUtGZlJXYW1HWEVVMjdvR3hiaWRQT1Ix?=
 =?utf-8?B?STVRbzh2RzI5ZUg1LyszVDVlcmR4M3NCbkR5eDBqKzc1akhWMDFMNmhuUnJ5?=
 =?utf-8?B?YTNvYkNiYVJQamxHZklia3hnVDNmRlA4N3pQY09xRExTK2lyYnF4T3A3VnM3?=
 =?utf-8?B?NjF0YzdpWlZOYXJpcGNWQnZmdmcrYUdTMzJWMVZJc0g3OXZDWnZyVml4ZzNJ?=
 =?utf-8?B?b3Q2UDh1cllSQU1WUWtDL01sTiszOWx1WDcydlJHVGlaRUQweFgzTUpQQkRs?=
 =?utf-8?B?bzZJc2RjOTNzYzFtTzREdnZkU1BXS1NMSWEwczcrWFoyN2FqUW1pTy9IRElG?=
 =?utf-8?B?aXYvRXR0SmV0a1BvWkNpV3hIbVFUeWNqdURiSkV3ZlRabVRWQU1ReFp6V3lt?=
 =?utf-8?B?T2VMNkExTHhQeTZ5RTFsamtoOG5zeHRseTRUNTdNM2hrU040MWFOQ0E5NUJH?=
 =?utf-8?Q?S00M=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 450a6602-34f8-4583-85ce-08dae1d670bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2022 15:33:55.6623
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bTm0cPsTjZKWYi06ntEkVIH1z6WuSunXsFIzLzRoHX1hDjEEmP/ogrY7Wskp5NYa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7310
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
dGVsLmNvbT4NCj4gU2VudDogVGh1cnNkYXksIERlY2VtYmVyIDE1LCAyMDIyIDExOjEyIEFNDQo+
IFRvOiBNb2dlciwgQmFidSA8QmFidS5Nb2dlckBhbWQuY29tPjsgY29yYmV0QGx3bi5uZXQ7DQo+
IHRnbHhAbGludXRyb25peC5kZTsgbWluZ29AcmVkaGF0LmNvbTsgYnBAYWxpZW44LmRlDQo+IENj
OiBmZW5naHVhLnl1QGludGVsLmNvbTsgZGF2ZS5oYW5zZW5AbGludXguaW50ZWwuY29tOyB4ODZA
a2VybmVsLm9yZzsNCj4gaHBhQHp5dG9yLmNvbTsgcGF1bG1ja0BrZXJuZWwub3JnOyBha3BtQGxp
bnV4LWZvdW5kYXRpb24ub3JnOw0KPiBxdWljX25lZXJhanVAcXVpY2luYy5jb207IHJkdW5sYXBA
aW5mcmFkZWFkLm9yZzsNCj4gZGFtaWVuLmxlbW9hbEBvcGVuc291cmNlLndkYy5jb207IHNvbmdt
dWNodW5AYnl0ZWRhbmNlLmNvbTsNCj4gcGV0ZXJ6QGluZnJhZGVhZC5vcmc7IGpwb2ltYm9lQGtl
cm5lbC5vcmc7IHBib256aW5pQHJlZGhhdC5jb207DQo+IGNoYW5nLnNlb2suYmFlQGludGVsLmNv
bTsgcGF3YW4ua3VtYXIuZ3VwdGFAbGludXguaW50ZWwuY29tOw0KPiBqbWF0dHNvbkBnb29nbGUu
Y29tOyBkYW5pZWwuc25lZGRvbkBsaW51eC5pbnRlbC5jb207IERhczEsIFNhbmRpcGFuDQo+IDxT
YW5kaXBhbi5EYXNAYW1kLmNvbT47IHRvbnkubHVja0BpbnRlbC5jb207IGphbWVzLm1vcnNlQGFy
bS5jb207DQo+IGxpbnV4LWRvY0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtl
cm5lbC5vcmc7DQo+IGJhZ2FzZG90bWVAZ21haWwuY29tOyBlcmFuaWFuQGdvb2dsZS5jb207IGNo
cmlzdG9waGUubGVyb3lAY3Nncm91cC5ldTsNCj4gamFya2tvQGtlcm5lbC5vcmc7IGFkcmlhbi5o
dW50ZXJAaW50ZWwuY29tOyBxdWljX2ppbGVzQHF1aWNpbmMuY29tOw0KPiBwZXRlcm5ld21hbkBn
b29nbGUuY29tDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjkgMDQvMTNdIHg4Ni9yZXNjdHJsOiBJ
bmNsdWRlIG5ldyBmZWF0dXJlcyBpbiBjb21tYW5kDQo+IGxpbmUgb3B0aW9ucw0KPiANCj4gSGkg
QmFidSwNCj4gDQo+IE9uIDEyLzEvMjAyMiA3OjM2IEFNLCBCYWJ1IE1vZ2VyIHdyb3RlOg0KPiA+
IEFkZCB0aGUgY29tbWFuZCBsaW5lIG9wdGlvbnMgdG8gZW5hYmxlIG9yIGRpc2FibGUgdGhlIG5l
dyByZXNjdHJsIGZlYXR1cmVzLg0KPiA+IHNtYmEgOiBTbG93IE1lbW9yeSBCYW5kd2lkdGggQWxs
b2NhdGlvbiBibWVjIDogQmFuZHdpZHRoIE1vbml0b3IgRXZlbnQNCj4gPiBDb25maWd1cmF0aW9u
Lg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogQmFidSBNb2dlciA8YmFidS5tb2dlckBhbWQuY29t
Pg0KPiA+IC0tLQ0KPiA+ICBEb2N1bWVudGF0aW9uL2FkbWluLWd1aWRlL2tlcm5lbC1wYXJhbWV0
ZXJzLnR4dCB8ICAgIDIgKy0NCj4gPiAgYXJjaC94ODYva2VybmVsL2NwdS9yZXNjdHJsL2NvcmUu
YyAgICAgICAgICAgICAgfCAgICA0ICsrKysNCj4gPiAgMiBmaWxlcyBjaGFuZ2VkLCA1IGluc2Vy
dGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0
aW9uL2FkbWluLWd1aWRlL2tlcm5lbC1wYXJhbWV0ZXJzLnR4dA0KPiA+IGIvRG9jdW1lbnRhdGlv
bi9hZG1pbi1ndWlkZS9rZXJuZWwtcGFyYW1ldGVycy50eHQNCj4gPiBpbmRleCA0MmFmOWNhMDEy
N2UuLmE3YjY2MzRmNDQyNiAxMDA2NDQNCj4gPiAtLS0gYS9Eb2N1bWVudGF0aW9uL2FkbWluLWd1
aWRlL2tlcm5lbC1wYXJhbWV0ZXJzLnR4dA0KPiA+ICsrKyBiL0RvY3VtZW50YXRpb24vYWRtaW4t
Z3VpZGUva2VybmVsLXBhcmFtZXRlcnMudHh0DQo+ID4gQEAgLTUxOTAsNyArNTE5MCw3IEBADQo+
ID4gIAlyZHQ9CQlbSFcsWDg2LFJEVF0NCj4gPiAgCQkJVHVybiBvbi9vZmYgaW5kaXZpZHVhbCBS
RFQgZmVhdHVyZXMuIExpc3QgaXM6DQo+ID4gIAkJCWNtdCwgbWJtdG90YWwsIG1ibWxvY2FsLCBs
M2NhdCwgbDNjZHAsIGwyY2F0LCBsMmNkcCwNCj4gPiAtCQkJbWJhLg0KPiA+ICsJCQltYmEsIHNt
YmEsIGJtZWMuDQo+ID4gIAkJCUUuZy4gdG8gdHVybiBvbiBjbXQgYW5kIHR1cm4gb2ZmIG1iYSB1
c2U6DQo+ID4gIAkJCQlyZHQ9Y210LCFtYmENCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9hcmNoL3g4
Ni9rZXJuZWwvY3B1L3Jlc2N0cmwvY29yZS5jDQo+ID4gYi9hcmNoL3g4Ni9rZXJuZWwvY3B1L3Jl
c2N0cmwvY29yZS5jDQo+ID4gaW5kZXggZjZhZjNhYzFlZjIwLi4xMGE4YzlkOTZmMzIgMTAwNjQ0
DQo+ID4gLS0tIGEvYXJjaC94ODYva2VybmVsL2NwdS9yZXNjdHJsL2NvcmUuYw0KPiA+ICsrKyBi
L2FyY2gveDg2L2tlcm5lbC9jcHUvcmVzY3RybC9jb3JlLmMNCj4gPiBAQCAtNjU5LDYgKzY1OSw4
IEBAIGVudW0gew0KPiA+ICAJUkRUX0ZMQUdfTDJfQ0FULA0KPiA+ICAJUkRUX0ZMQUdfTDJfQ0RQ
LA0KPiA+ICAJUkRUX0ZMQUdfTUJBLA0KPiA+ICsJUkRUX0ZMQUdfU01CQSwNCj4gPiArCVJEVF9G
TEFHX0JNRUMsDQo+ID4gIH07DQo+ID4NCj4gPiAgI2RlZmluZSBSRFRfT1BUKGlkeCwgbiwgZikJ
XA0KPiA+IEBAIC02ODIsNiArNjg0LDggQEAgc3RhdGljIHN0cnVjdCByZHRfb3B0aW9ucyByZHRf
b3B0aW9uc1tdICBfX2luaXRkYXRhID0gew0KPiA+ICAJUkRUX09QVChSRFRfRkxBR19MMl9DQVQs
ICAgICJsMmNhdCIsCVg4Nl9GRUFUVVJFX0NBVF9MMiksDQo+ID4gIAlSRFRfT1BUKFJEVF9GTEFH
X0wyX0NEUCwgICAgImwyY2RwIiwNCj4gCVg4Nl9GRUFUVVJFX0NEUF9MMiksDQo+ID4gIAlSRFRf
T1BUKFJEVF9GTEFHX01CQSwJICAgICJtYmEiLAlYODZfRkVBVFVSRV9NQkEpLA0KPiA+ICsJUkRU
X09QVChSRFRfRkxBR19TTUJBLAkgICAgInNtYmEiLAlYODZfRkVBVFVSRV9TTUJBKSwNCj4gPiAr
CVJEVF9PUFQoUkRUX0ZMQUdfQk1FQywJICAgICJibWVjIiwJWDg2X0ZFQVRVUkVfQk1FQyksDQo+
ID4gIH07DQo+ID4gICNkZWZpbmUgTlVNX1JEVF9PUFRJT05TIEFSUkFZX1NJWkUocmR0X29wdGlv
bnMpDQo+ID4NCj4gPg0KPiA+DQo+IA0KPiBSZXZpZXdlZC1ieTogUmVpbmV0dGUgQ2hhdHJlIDxy
ZWluZXR0ZS5jaGF0cmVAaW50ZWwuY29tPg0KDQpUaGFua3MgDQpCYWJ1DQo+IA0KPiBSZWluZXR0
ZQ0K
