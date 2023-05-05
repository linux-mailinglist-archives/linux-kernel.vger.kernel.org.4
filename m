Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B3C76F8942
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 21:04:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233343AbjEETEQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 15:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231676AbjEETEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 15:04:14 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2078.outbound.protection.outlook.com [40.107.243.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0E63A245;
        Fri,  5 May 2023 12:04:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=it8y91QG/gZnd0N+pEFxe+yOHRlUjr2jSEADp9Aqe6u6dLFrSUU7QdQipwhQWQllG5lN3k9rcL5dO9whZcHeUPsT4jRQ4KqH7cQffLeMKhtnURl+KLLIo3mS5MdOyd8DXExq7D9ZWM5sQP4ZEI1iXMQCrKpQHkl81GCxsMxZ7K2UiBe/CnliboONXjz1+jLUoshJvuz0kx91caYVct/jWPD/4LSQfSYXXtp6uQLyGxQqH1U2xDlKMWCd060qaWchAnlE4lXGNy/sw2EMTjtieKNbHG0sXwJS8O4eQJmsetStmSZoDfpl9tjLShoTMkA+6dDlL8HbcbBViuBSNIEcaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W0ppnxDcYzbdKzumfjiwu4brVj+8AyOiQwmyfjSvyOk=;
 b=h2+j3/HtGkgpHxJCexO9NZ1PGOzrpHJHT0GPT7XaooBfl6pN4kLNSs0r/6nuRXTeOftPDJ/UQqCI6K+sAJJUmWST9Xukf7WnCZO5qZ0qZOUfHS87lOT/bHot9RM/60uJ2x/wBRLVkmHfq2gHBLIHbApCQ9GaGd1z+r4MGw9VPg3wSdlaSYsSNxYh19fMJxycFpfHgBukwfv39RPCMIkRA1xQ507LQB7TCq59ELWenlN7HmK/Y0Shy51wsQ4v51ZCedJ/M5uXDwu6EyXAAtTMFDKmZrpFPOkUT476ONLLQgBOtD/w3bsQEWWT2qJFXUHpTzPFSxD9AMA94aCR95O3rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W0ppnxDcYzbdKzumfjiwu4brVj+8AyOiQwmyfjSvyOk=;
 b=4EkAUiJI5aYZf4lbirHIkaelFDS0mx1/h09NYDEnK+TbzlgpK1Xk8vB3KIrFU+ancG3E0l8rGys4yppQPgAgesl/72XJEq334n8+QbZ6piyTiDDiQCDWlwKzjMMGlIEXQDVr08gPU6U3nKCr5I5hBttYUq8+dB44CDhVxD96X2I=
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by DS7PR12MB5791.namprd12.prod.outlook.com (2603:10b6:8:76::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.27; Fri, 5 May
 2023 19:04:10 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::216f:6f0f:4a21:5709]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::216f:6f0f:4a21:5709%5]) with mapi id 15.20.6363.026; Fri, 5 May 2023
 19:04:10 +0000
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
Subject: RE: [PATCH v4 2/7] x86/resctrl: Remove unnecessary rftype flags
Thread-Topic: [PATCH v4 2/7] x86/resctrl: Remove unnecessary rftype flags
Thread-Index: AQHZcYUl8U3wmpSVMk23lwE/n72X/a9Kkc8AgAGD6zCAAA0qAIAAASKg
Date:   Fri, 5 May 2023 19:04:09 +0000
Message-ID: <MW3PR12MB4553C5EF3818F6C54B8BF5B695729@MW3PR12MB4553.namprd12.prod.outlook.com>
References: <168177435378.1758847.8317743523931859131.stgit@bmoger-ubuntu>
 <168177445556.1758847.5029687867896978170.stgit@bmoger-ubuntu>
 <4275aa91-5834-2c03-f455-f1d3d666fec7@intel.com>
 <MW3PR12MB4553E65A5D5DE6E27045766595729@MW3PR12MB4553.namprd12.prod.outlook.com>
 <efd45c71-2241-e0b8-e1c0-6fcc1e95b321@intel.com>
In-Reply-To: <efd45c71-2241-e0b8-e1c0-6fcc1e95b321@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-05-05T19:04:08Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=be069462-fb4f-4c1d-b216-d8c511109c2a;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2023-05-05T19:04:08Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 21cedc1f-3416-4290-9372-bcc7b8be18b9
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW3PR12MB4553:EE_|DS7PR12MB5791:EE_
x-ms-office365-filtering-correlation-id: 8d799e97-7d3c-4eaf-b9a1-08db4d9b81ff
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PuBm2kejsBok/WzRH3bthfQRHmEADYyGjxDI7c+pk2HVaIFb7fxG69c+syXrJqWAddbWS6yfkRUVej72L2eoj3VKV0pDWcZcG7jwncNfrwpKWOC2TxzDCj+hoBs06vtNfqOqbV9KFbtiLeHUVD2BSbbLieGtuqQ2pC11Ehmvqwbl50GiLGPKOKZvkNldjZ7MhzCz6pHNjDbGhzSSuIIIlrpCOdyUzHDBQ8QXanMETlkiwYYSwJ5Hx39nkJnZiTaVtkNv6RfqOeLhQABubxTIUa6OG2jPKhDcbcAyCF2+TX3xmY5flCySoQfdlPgvObWNJ2ysuoleJOrz7c7wd4sMWnVtf/wEWaylqymMyW7H2rISo4X4xB1uUzoA5Xg9XTbRAs0QO1PX5LCFDbqSjgThzl0PY4hhdMygXVXNCgBnWdHP2Lfl64qr6aUnLQ4dEmi0LrmYHCe3KeIxxoC5XpzqRuAGv6zCu3CMYWVUvqiGY5q2/0qcJDz4RL1uxhLPGl+0bJCkVMb+IO09IGVlPAIvu+ue1p1xcUrYx/SJmmgutF5J+ZjtPGgVKFwJyGzhwyTwSY2tB91+Sx4K/f4lL/xRu4ZByM76cjUr25bt6156sJnfTZkeNa0dyf//VBC4SbB8
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(346002)(39860400002)(396003)(366004)(451199021)(86362001)(33656002)(478600001)(110136005)(54906003)(316002)(76116006)(66946007)(66556008)(66446008)(64756008)(66476007)(4326008)(7696005)(71200400001)(7416002)(55016003)(52536014)(8676002)(8936002)(5660300002)(2906002)(7406005)(41300700001)(186003)(38070700005)(38100700002)(122000001)(6506007)(53546011)(9686003)(26005)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y3JybWQyOWY2N2RxSWQyTmtsNHlPdWlWbW92ZWVkWmJtVTg1Nk9WS291RkpN?=
 =?utf-8?B?eXhvUThMMjhLMFlaWTl3WnAxS1dWakdTZ2x3SEdDa05ucCtCclZPeGZIdGJ5?=
 =?utf-8?B?ZmZ5SlRSdlN6bElRbHd4Ny96SnVQN245eUFhWERWNzVkU1paYmsySXRsT2Zw?=
 =?utf-8?B?ZlltSU0rdytZZnFTUjlqWEZqOU9kcys5YWlFU3Z5aC82YmVhaUhaeWp5U2Fx?=
 =?utf-8?B?UUQ5UzRickRtMXExNWMveVFzZUYxQXNrUmx4N1l5MDJTbEs2S1NsR2o1Ti9B?=
 =?utf-8?B?VXFxdEljZ09NSldTWmQ5a2lqZjZERmJ2M2hWOGh4dnovelR5WFA5disvQXdB?=
 =?utf-8?B?Vi9lc0FRZVZrZzJGUUcvMDc3c3djaEE4dkowYThOc0tkSnlBQjJQTkdqYTU2?=
 =?utf-8?B?VUdNNTdMMzZPdkVCS3piWWdpb1pQSVp2UGkzKzlSTVpKQTRwYU05ZVp0NXRz?=
 =?utf-8?B?NmFEdmUrOGlOSGhKV3ZCMnlKbWJqZDJab1NmTUdVVkhVdGhucERrMUxpUXdq?=
 =?utf-8?B?dkxSZGNEbkxPTTZZaDQ1bmRkUXJZanRPZjdBeWZ2cWY2ampyRjBWbTdnRi9z?=
 =?utf-8?B?WmZNeWhObHdGTVk0NnpZeSs4WXVYcVVMdEVyQmU3NWV5dGtEeEN1N1d6aGFK?=
 =?utf-8?B?RC9rSXBpOXJYbU9nUDlvcFROMDg5dXBVb2d4bllBaTRreEkyamQ0VXE3dzdR?=
 =?utf-8?B?SURvMTltdHN2UVFTUXMvV0Z6TWE3OFNScnNuTW5RRUxZQ0JGR2haZFVaV296?=
 =?utf-8?B?bHcwVjhIbnJXNmxSWnF1ZEZtbm0yTUhOZlM4ZmFkZzE5VXh1Nk15aFgzd2dh?=
 =?utf-8?B?SnNhYnlzSThZcklrR2dSQVRraVRXUWlzeXFOV3ZlZzBJTU1PbE45RUlJQS9z?=
 =?utf-8?B?ZGFBL0N1QnlsMXJBbkF2djdBL0U2SjFTYVRvbzhZdzJkbXFaSmtKbWpSbjZD?=
 =?utf-8?B?N0ovY0NIeU1ETUF5Ykt4K29EaGNKUFljbWJNdXhFeEQ3TWI1aUpyaC9zbVdU?=
 =?utf-8?B?QU5McXh5U3ZyUlo4NlVQY2lvS254TXRLUEp0cndvaFFXMjMySXNDMUdkcmRj?=
 =?utf-8?B?UFVDWDRPRDZ1MzNTY2crY0dCdlNXczAyY3FUU2tRSGpVK3lFWDIxR0x6cnEw?=
 =?utf-8?B?ckFoLzg1RU5aejVUN2JDMUFmRWpnZmNEaTI4UDFLdXZ6MXdPbkEvNndub3Vv?=
 =?utf-8?B?MUVRRkdpV0h3bzFyam83WnBOeUtNcEliUFR1akpUc3VGRUpHOS96RVEvN1JV?=
 =?utf-8?B?ZHpFY1FGS3FHVEY0MWJMZnhIMEhUWUh5RkNqS29UcnRzL0JGL0ljUVQ4cmpr?=
 =?utf-8?B?MDMyRFJYVmhESXAxa2FJUHEzOVFYQzZ6N1FUZDdSa0tINGJ4ZUtMOWZOVkRy?=
 =?utf-8?B?b3hvakI4T0dhR0ZZTFRvNG91TFdUdXVhazR4anIzWityNDB1ZkphbXBqYUlF?=
 =?utf-8?B?QTBScjJXZnNncWtEQmtrWFVSZXNwN1NFNUQxbGxjMEdQVUYweFhPcDhmenVV?=
 =?utf-8?B?YjZTVTNzWG5wa2dFUDBOTGFtOFhQWC9XL1hqaUFYUlBjVVdTbzdYSGFTNUNv?=
 =?utf-8?B?WkhNb3JKUlo2YmtwdXhDMHF5QzI1MjNQSHFnKzJaRnZrRHU5V1lNcWg4RCtv?=
 =?utf-8?B?TDNpTHBrcTlKREFsVHZCZ1A4M0FzWWZPOTI5SWdQSU45bXMzcDc5SkJRTlZY?=
 =?utf-8?B?Y2NMOVRzWTdadHBGYkJsQi9mMlFuNG9VQ2NRaDFCa3F6SG1wZmtIdjY0WUtQ?=
 =?utf-8?B?NHNET2E1SzFEeFYxTDJGRnpoeE91OVJSZ2JXV2JQMjU1SmdjYk9aeEFoUWJF?=
 =?utf-8?B?cHJvZ3dNS2luNW1nSUYzd1A5VjRZb1YwY1l2V1hkaHByNnMwTy9hb2dQWmhX?=
 =?utf-8?B?dnFaWlRFMlovZG9wREphckdFeGtwUjRKQ0xEb1RzbXpLUVFOUmk2UDBVa051?=
 =?utf-8?B?cG92YmhSQ3dPM2N4MHRMaGJGTkNSWHdDVU92c0pzaTVFRXY3bE1vb2N2NXBF?=
 =?utf-8?B?U1VLdWVXSzdHeU5lNmRZQVBpdjFLZXh0SlVZWENkaFdBL3ZpcmRWbEgyTmNo?=
 =?utf-8?B?L3kvV1hxZWUxYzBXNGczUXpVdlZMKzFjL3ZwODU1dkRuT2VPRk9zVEpGU2w3?=
 =?utf-8?Q?7O94=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d799e97-7d3c-4eaf-b9a1-08db4d9b81ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2023 19:04:09.8902
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Bpv8OFxypFRDy+ZiH3a3ievYfSkgn0uWqMWPrPZ9JeQWkzgiBfERTaw6/FvoGqbk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5791
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCkhpIFJlaW5ldHRlLA0KDQo+IC0t
LS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFJlaW5ldHRlIENoYXRyZSA8cmVpbmV0
dGUuY2hhdHJlQGludGVsLmNvbT4NCj4gU2VudDogRnJpZGF5LCBNYXkgNSwgMjAyMyAxOjU0IFBN
DQo+IFRvOiBNb2dlciwgQmFidSA8QmFidS5Nb2dlckBhbWQuY29tPjsgY29yYmV0QGx3bi5uZXQ7
DQo+IHRnbHhAbGludXRyb25peC5kZTsgbWluZ29AcmVkaGF0LmNvbTsgYnBAYWxpZW44LmRlDQo+
IENjOiBmZW5naHVhLnl1QGludGVsLmNvbTsgZGF2ZS5oYW5zZW5AbGludXguaW50ZWwuY29tOyB4
ODZAa2VybmVsLm9yZzsNCj4gaHBhQHp5dG9yLmNvbTsgcGF1bG1ja0BrZXJuZWwub3JnOyBha3Bt
QGxpbnV4LWZvdW5kYXRpb24ub3JnOw0KPiBxdWljX25lZXJhanVAcXVpY2luYy5jb207IHJkdW5s
YXBAaW5mcmFkZWFkLm9yZzsNCj4gZGFtaWVuLmxlbW9hbEBvcGVuc291cmNlLndkYy5jb207IHNv
bmdtdWNodW5AYnl0ZWRhbmNlLmNvbTsNCj4gcGV0ZXJ6QGluZnJhZGVhZC5vcmc7IGpwb2ltYm9l
QGtlcm5lbC5vcmc7IHBib256aW5pQHJlZGhhdC5jb207DQo+IGNoYW5nLnNlb2suYmFlQGludGVs
LmNvbTsgcGF3YW4ua3VtYXIuZ3VwdGFAbGludXguaW50ZWwuY29tOw0KPiBqbWF0dHNvbkBnb29n
bGUuY29tOyBkYW5pZWwuc25lZGRvbkBsaW51eC5pbnRlbC5jb207IERhczEsIFNhbmRpcGFuDQo+
IDxTYW5kaXBhbi5EYXNAYW1kLmNvbT47IHRvbnkubHVja0BpbnRlbC5jb207IGphbWVzLm1vcnNl
QGFybS5jb207DQo+IGxpbnV4LWRvY0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2Vy
Lmtlcm5lbC5vcmc7DQo+IGJhZ2FzZG90bWVAZ21haWwuY29tOyBlcmFuaWFuQGdvb2dsZS5jb207
IGNocmlzdG9waGUubGVyb3lAY3Nncm91cC5ldTsNCj4gamFya2tvQGtlcm5lbC5vcmc7IGFkcmlh
bi5odW50ZXJAaW50ZWwuY29tOyBxdWljX2ppbGVzQHF1aWNpbmMuY29tOw0KPiBwZXRlcm5ld21h
bkBnb29nbGUuY29tDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjQgMi83XSB4ODYvcmVzY3RybDog
UmVtb3ZlIHVubmVjZXNzYXJ5IHJmdHlwZSBmbGFncw0KPiANCj4gSGkgQmFidSwNCj4gDQo+IE9u
IDUvNS8yMDIzIDExOjMxIEFNLCBNb2dlciwgQmFidSB3cm90ZToNCj4gPiBbQU1EIE9mZmljaWFs
IFVzZSBPbmx5IC0gR2VuZXJhbF0NCj4gPg0KPiA+IEhpIFJlaW5ldHRlLA0KPiA+DQo+ID4+IC0t
LS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4+IEZyb206IFJlaW5ldHRlIENoYXRyZSA8cmVp
bmV0dGUuY2hhdHJlQGludGVsLmNvbT4NCj4gPj4gU2VudDogVGh1cnNkYXksIE1heSA0LCAyMDIz
IDE6NTkgUE0NCj4gPj4gVG86IE1vZ2VyLCBCYWJ1IDxCYWJ1Lk1vZ2VyQGFtZC5jb20+OyBjb3Ji
ZXRAbHduLm5ldDsNCj4gPj4gdGdseEBsaW51dHJvbml4LmRlOyBtaW5nb0ByZWRoYXQuY29tOyBi
cEBhbGllbjguZGUNCj4gPj4gQ2M6IGZlbmdodWEueXVAaW50ZWwuY29tOyBkYXZlLmhhbnNlbkBs
aW51eC5pbnRlbC5jb207DQo+ID4+IHg4NkBrZXJuZWwub3JnOyBocGFAenl0b3IuY29tOyBwYXVs
bWNrQGtlcm5lbC5vcmc7DQo+ID4+IGFrcG1AbGludXgtZm91bmRhdGlvbi5vcmc7IHF1aWNfbmVl
cmFqdUBxdWljaW5jLmNvbTsNCj4gPj4gcmR1bmxhcEBpbmZyYWRlYWQub3JnOyBkYW1pZW4ubGVt
b2FsQG9wZW5zb3VyY2Uud2RjLmNvbTsNCj4gPj4gc29uZ211Y2h1bkBieXRlZGFuY2UuY29tOyBw
ZXRlcnpAaW5mcmFkZWFkLm9yZzsNCj4ganBvaW1ib2VAa2VybmVsLm9yZzsNCj4gPj4gcGJvbnpp
bmlAcmVkaGF0LmNvbTsgY2hhbmcuc2Vvay5iYWVAaW50ZWwuY29tOw0KPiA+PiBwYXdhbi5rdW1h
ci5ndXB0YUBsaW51eC5pbnRlbC5jb207DQo+ID4+IGptYXR0c29uQGdvb2dsZS5jb207IGRhbmll
bC5zbmVkZG9uQGxpbnV4LmludGVsLmNvbTsgRGFzMSwgU2FuZGlwYW4NCj4gPj4gPFNhbmRpcGFu
LkRhc0BhbWQuY29tPjsgdG9ueS5sdWNrQGludGVsLmNvbTsgamFtZXMubW9yc2VAYXJtLmNvbTsN
Cj4gPj4gbGludXgtZG9jQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVs
Lm9yZzsNCj4gPj4gYmFnYXNkb3RtZUBnbWFpbC5jb207IGVyYW5pYW5AZ29vZ2xlLmNvbTsNCj4g
Pj4gY2hyaXN0b3BoZS5sZXJveUBjc2dyb3VwLmV1OyBqYXJra29Aa2VybmVsLm9yZzsNCj4gPj4g
YWRyaWFuLmh1bnRlckBpbnRlbC5jb207IHF1aWNfamlsZXNAcXVpY2luYy5jb207DQo+ID4+IHBl
dGVybmV3bWFuQGdvb2dsZS5jb20NCj4gPj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NCAyLzddIHg4
Ni9yZXNjdHJsOiBSZW1vdmUgdW5uZWNlc3NhcnkgcmZ0eXBlDQo+ID4+IGZsYWdzDQo+ID4+DQo+
ID4+IEhpIEJhYnUsDQo+ID4+DQo+ID4+IE9uIDQvMTcvMjAyMyA0OjM0IFBNLCBCYWJ1IE1vZ2Vy
IHdyb3RlOg0KPiA+Pj4gUmVtb3ZlIHVubmVjZXNzYXJ5IHJmdHlwZSBmbGFncyB0byBhdm9pZCBt
dWx0aXBsZSBpbmRpcmVjdGlvbi4NCj4gPj4NCj4gPj4gQ291bGQgeW91IHBsZWFzZSBlbGFib3Jh
dGUgd2hhdCBtYWtlcyB0aGVzZSBmbGFncyB1bm5lY2Vzc2FyeT8NCj4gPg0KPiA+IFllYS4gUHJv
YmFibHkgc2hvdWxkIG5vdCBzYXkgdW5uZWNlc3NhcnkuDQo+ID4gSG93IGFib3V0IHRoaXMgPw0K
PiA+ICJyZnR5cGUgZmxhZ3MgaGF2ZSB0d28gcHJlZml4ZXMsIFJGVFlQRV8gYW5kIFJGXy4gUmVt
b3ZlIHRoZSBmbGFnIG5hbWVzDQo+IHdpdGggc3VmZml4IFJGXyBhbmQgYXZvaWQgaW5kaXJlY3Rp
b24uIg0KPiANCj4gSSBkbyBub3QgdGhpbmsgdGhhdCBoYXZpbmcgYSBkaWZmZXJlbnQgcHJlZml4
IGlzIGEgbW90aXZhdGlvbiBmb3IgYSBmbGFnIHRvIGJlDQo+IHJlbW92ZWQuIEhhdmluZyBhIGRp
ZmZlcmVudCBwcmVmaXggY291bGQgcmF0aGVyIGJlIGEgbW90aXZhdGlvbiBmb3IgYSBmbGFnIHRv
IGJlDQo+IHJlbmFtZWQgdG8gYSBjb25zaXN0ZW50IG5hbWUuDQo+IA0KPiBDb3VsZCB5b3UgcGxl
YXNlIGRlc2NyaWJlIHRoZSBwcm9ibGVtIGJlaW5nIHNvbHZlZD8NCg0KTW90aXZhdGlvbiBmb3Ig
dGhlc2UgY2hhbmdlcy4NCjEuIFJlbW92ZSB0aGUgbmFtaW5nIGluY29uc2lzdGVuY3kNCjIuIFJl
bW92ZSB0aGUgaW5kaXJlY3Rpb24NCjMuIE1ha2UgaXQgZWFzaWVyIGZvciBhZGRpbmcgbmV3IGZs
YWdzDQoNClRoYW5rcw0KQmFidQ0KIA0KPiBUaGF0IHdpbGwgaGVscCB0byBjbGFyaWZ5IGlmIHRo
aXMgcGF0Y2ggaXMgcmVhbGx5IG5lZWRlZC4NCj4gDQo+IFJlaW5ldHRlDQo=
