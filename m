Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B82806F889B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 20:32:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233215AbjEEScB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 14:32:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230473AbjEESb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 14:31:57 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2073.outbound.protection.outlook.com [40.107.223.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5E3D15EE1;
        Fri,  5 May 2023 11:31:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kDBzE2bZmVxscvMHmdFQWx+D972bBAuJsNMP0KVX9n8t37AptG3qD6Eo7zeYT26gaEXISfJHRvTi3kA0zwSbSoIjnRhXtm6wxcbEO/k4UA6GJaVHnJcn6wiHPt09Rr/Qq4//xVYUdYfht0jjfN7kPwg0KQWnl1HVk/16epQqT7iXt4Ug2XL2qo/XuZUdf7MCPibvtU2yS4zDaTRssztWergRMeXw0w+cx/HVvR/j9aAWrGyi/c7Og4St9BAP0YhHewvKgU1dMLCWA6m4xwBsX1MyToNPT4+DACa+FsLcKxY2VPJR+olZlPzbXf/zNZzivmSuvxap1pKGBZqqwthJMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=snEoKA0UKav0WUwZ4a3AKtEiRXmXEV/lpkqSviHxXuY=;
 b=EH5fZh9+tTku96Iwd88oMJ/xQjnKuvykst/yLZ/u8oEsXe0yMCD/kxk/mYQIh4Z7OjJXVRc7ZPaEKUcwvacFy/8/R+QcFmCWZtM7f+QHgzn984yVuwDgapvpBPdZdcolMVeGOUk325FPpMIEcxToSC39TbAh7QVYZ8uFr87JGorh3FSJe396xSbl/boSFi4u24+Pj6CqjXWSPDx4ulczAzFlLda0v+hqS9UsQVmvPxowC/9irqdpwMgoDQOTLmXtwpN7HYBx1IEgUt6O0p+vwpMlrWq9z+8krqhuq1Ud22HMPE3+u/XK/i2feaPg8dpGFlaFaU/xxRyVN3s45y4Ycw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=snEoKA0UKav0WUwZ4a3AKtEiRXmXEV/lpkqSviHxXuY=;
 b=Lf1my2qPVMaOAcMxr8ikhHgR+pB/1nm3xCBxFyxbY3F/Ixtzulf2fRZP0KfcY9KtA1w7rWsnpkK2pkW8GwYbAS6VX7Jdvle6JGvkUTXjjXdvgfuTeZ3Z/E62/n1ftD+osdTeUWe9HgE1kAqtArTqrc6xDsBWmNoO6ysm9jG4Oxw=
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by PH8PR12MB8605.namprd12.prod.outlook.com (2603:10b6:510:1cc::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.26; Fri, 5 May
 2023 18:31:52 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::216f:6f0f:4a21:5709]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::216f:6f0f:4a21:5709%5]) with mapi id 15.20.6363.026; Fri, 5 May 2023
 18:31:51 +0000
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
Thread-Index: AQHZcYUl8U3wmpSVMk23lwE/n72X/a9Kkc8AgAGD6zA=
Date:   Fri, 5 May 2023 18:31:51 +0000
Message-ID: <MW3PR12MB4553E65A5D5DE6E27045766595729@MW3PR12MB4553.namprd12.prod.outlook.com>
References: <168177435378.1758847.8317743523931859131.stgit@bmoger-ubuntu>
 <168177445556.1758847.5029687867896978170.stgit@bmoger-ubuntu>
 <4275aa91-5834-2c03-f455-f1d3d666fec7@intel.com>
In-Reply-To: <4275aa91-5834-2c03-f455-f1d3d666fec7@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-05-05T18:31:50Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=bbcce4c0-d4e5-451d-9225-c2374b6a81bf;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2023-05-05T18:31:50Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 983bb8bf-d715-4d87-a4dd-f2ca014fcf48
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW3PR12MB4553:EE_|PH8PR12MB8605:EE_
x-ms-office365-filtering-correlation-id: 6daf6cb3-b4b5-416e-9c85-08db4d96fec2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: en2Mn1XqfD6jzgZIjjY/EPsLBM3nTAwtJnzeX+Xlhx+9J5eqAXjW4UWJ0R9Li2Zil2mZxkstJJ+3Z5oT0NvfI9ntBn4C4gqtEJemIvPfDAhktBFfemGmUcHsI09wuttTOd7PAtvfH+mbetGNh5DzZvr94LTfrvWBIupIFxr/fsB1PGUkwWWdAsFIQdM4qS1Xymb1Ic75bAfEVHE7qWUWcIibGmsv3upp6PlMOdQgbeodz+MvCxj8Ds1Db3YmnjV1BiqXNtLHJJQbwkml2/0Gh79I0QSrJN7jyOqh6xVUnGKVcVWQIRGkysBZGSRUQJWsrJW7mhuMCbpblRgH/UQyBbxO+1K9CcDVYhdhgJAmxMwxkfVMomKfc1LZcmjcY2SZ0nI+/IR0GqQB1e0YhsMUckO7TtXGNX7oRmGDZto6locl7/YLRvdm57+y9nRALX6R3sWswk+tFOXUOkPTV/SkWwJb51dBAlaCSZJxSZidP7Q1gCHcf/85w7BaRPkb3kCNK4+OuescELnzGRIn42AIS8+qZiwbo4XRDto8w+wGDQMdx4rZ8duxkdB54AllT8hAZkU6L8VVHj+n1Vs3WiMelLCW9BnLSfp9m7bVVwez0MY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(366004)(346002)(39860400002)(396003)(451199021)(76116006)(83380400001)(186003)(110136005)(54906003)(478600001)(71200400001)(7696005)(6506007)(26005)(9686003)(53546011)(7406005)(52536014)(7416002)(33656002)(2906002)(55016003)(5660300002)(122000001)(38100700002)(8676002)(66446008)(64756008)(41300700001)(66476007)(4326008)(66946007)(8936002)(316002)(38070700005)(66556008)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?djZ4eWZBd2hLbEFSMTRORXdrL0NuekZ1QnlvTFBSS1hWQkh5Uyt1dUlRbEk0?=
 =?utf-8?B?N3pnZDhCTE5TZUhmMW90YWR3WjY3dEZpbFJYaWdLaUdSOEJTKzErZlRtUGkz?=
 =?utf-8?B?c0x4ZFdBRFZPL0pVaFJrUW9QRmhHRXhTa0I2NlMyeGYrbUdSZ2ZlMHNUMTM0?=
 =?utf-8?B?SW05ZmkxcTAwVVp5UDQ1RnFDQUYveU1oS3dmRmd1UFNJZTV0a1JpcjlKT3FS?=
 =?utf-8?B?eEl2V3ovRFBONUJ5NWhSU1RSTEpBRUJra0ZBeXQ5RUU2MVpDVWhzd2dqd0pq?=
 =?utf-8?B?OERKYk1tZ3IySGI3NFR2R2h0NENXNjQweDN6dVlQZFNPVUxiSE1UejMvTDhl?=
 =?utf-8?B?V1plb0svV25lS25SQ2dLVDhzcmFRelZQb2lwb1JNWHlWQkl2cmhTSG9aZmdn?=
 =?utf-8?B?NWV6M0g0U0hkT05sVXl1bVZkVG45Nm5PWXlNQWY0UmNrWmVLSkI3RmhWVTN3?=
 =?utf-8?B?WmNNTklqdm51ZUJPQllkUGFkQUE3Zm9hdmZYQk9KRzdhRHZhVlhXaDQ5dHNT?=
 =?utf-8?B?K1VSL1VuTGk0d0xTSVRFaUM3ZDFldFlpcTZ5S2dEM0xrVmxmbjhZMW9JbThm?=
 =?utf-8?B?ZWk1UDJvbmNQM1JIZEE4T1hEdmFpSDYvbWN1d0FtYklzNEs3TlJHUDlqNGdE?=
 =?utf-8?B?OFBMNXVBNExtb2VQcU84bm5INUlrQ2JEM0N3b1hJdnd1eDIxYlpVbnNCemt0?=
 =?utf-8?B?NEhLTG4raEU0dS90OGhSTXMvRG04MlU5S3Rqc2d6b1JxSk9LMzMxR1h6THZJ?=
 =?utf-8?B?Ukc4bWhibW93MDFiWnNKd2VCZXEwdFFtRGhCSHRVQzd5dnpFc3ptbjluaFBU?=
 =?utf-8?B?ZUEvdCtMdXNHQTBuVzNKRUNLdnREcGppU2tsa053eUl3bVFGVjAvYjZ6MTRS?=
 =?utf-8?B?bmI0by9lbFluRkJaanVBNW0rWTFJSVY1M0h3STFkczgxampSRGRiWWxVbmdB?=
 =?utf-8?B?ZlRjeTIzanRGZjZjbEhGWFcyZTFqalR2Yzltb2l2d1ZnWFFJRGI0cWhCRkVJ?=
 =?utf-8?B?Mi9manRkVFVoS2wwTFN5T1ZlV3Fpc0JrNkRxMUZobFowbzQ1MWpWUDdxNHZq?=
 =?utf-8?B?SEFuQWhWZDQ5ODFrMHkxeFVvYUVobWE5bW5NZU84N0NSeDJ5ZnVMMmZpN2Zx?=
 =?utf-8?B?R25ybTdWK2JQWE5ZMHpsYk40aG1MQmxSN09VbVhZbURFV0p0VUpIUWppb1gx?=
 =?utf-8?B?SFdkUVNIU2ttb0lKVFdIcHpweEp3dG95d2J6QVZOZHcvb3RCdjFya2Z5NFV0?=
 =?utf-8?B?ZDdNdXhNS3BYb3ZlVkoyN3pyMWZENTJVazlVajdFcXFRcVFqemhLbFlPbTRZ?=
 =?utf-8?B?WWw4SVdkUnQvZHY0cVZLZ2pwWGhzMnlHeUppRjM5T0U5TER2MHc5TUxOMEJE?=
 =?utf-8?B?UjI2UGtyZ3R0Q0NKdkh5aU51VzJzRUpwRFpSMXREcUJ3WmVmeTRDeEViWko1?=
 =?utf-8?B?alB3SUhMM2V2TXlnQWd3N05yTUtEVXptalpuM0RBeXcxcnFrVUpLcFQrd1BL?=
 =?utf-8?B?aWFheEVUQ2RwRDFwUi93M003Q0pTVE5jUGIrK0JWK1g4ZllzUkRaL0lJL3lv?=
 =?utf-8?B?ekNTZ0ZwZDUwUzd6dG41QWdhMGhYeUVFaFh2OGZvZmNFR0VTVWhGWlNYaWIy?=
 =?utf-8?B?amVjMzdxT2VsT3J0cUp1dm9EYkNVcmdlNjRaRzBYRkhFME1IOUFrLzByYk9C?=
 =?utf-8?B?eThySFRrK3cyT2FOK0JpQ21Tc1Z5c0lESzIrMXFVcU9nV05yb09ieGs1VDBH?=
 =?utf-8?B?S2FTRUVZN21zVUJSVWh6eGxOWENxN1c5czI4ZmVzUXVNWnFYeU0wNzM5Vzda?=
 =?utf-8?B?dFVWR3pnV3Q2MStnQlVuNCtkbG90UC92N1FmQ0U1NnZSS0txK3ByM3dXRXlm?=
 =?utf-8?B?M0E2ZTF1RkRiV1MzdXNVRUU1WUd1bXNxeEMrQ2JOdHkrckhUM0lyb1p0UU9D?=
 =?utf-8?B?blo2S1ptdTlQSHFKWTZZKzdlM3FRNkxHaTdKTWFHWVZyRVdyZmMrMW9pZkRZ?=
 =?utf-8?B?Titva0hQNjB0elRDL3Q0anNhMjJjOWdjbnJMSW9RWjEyZzBWUmVnbk1SMzRv?=
 =?utf-8?B?aXk2TmI1STBHK1JJSGw2TFRaWFdFTjZKTGxMVjhsMU4wRXo1bm1UT1NUc25j?=
 =?utf-8?Q?KqtI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6daf6cb3-b4b5-416e-9c85-08db4d96fec2
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2023 18:31:51.7105
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N7E/KIpP0T1v9K4Cnm9uFFzO7o/3DmhQ6TwCb2OJhc3d/5fMTS2txfUg1wX8/Jcp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB8605
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
dGUuY2hhdHJlQGludGVsLmNvbT4NCj4gU2VudDogVGh1cnNkYXksIE1heSA0LCAyMDIzIDE6NTkg
UE0NCj4gVG86IE1vZ2VyLCBCYWJ1IDxCYWJ1Lk1vZ2VyQGFtZC5jb20+OyBjb3JiZXRAbHduLm5l
dDsNCj4gdGdseEBsaW51dHJvbml4LmRlOyBtaW5nb0ByZWRoYXQuY29tOyBicEBhbGllbjguZGUN
Cj4gQ2M6IGZlbmdodWEueXVAaW50ZWwuY29tOyBkYXZlLmhhbnNlbkBsaW51eC5pbnRlbC5jb207
IHg4NkBrZXJuZWwub3JnOw0KPiBocGFAenl0b3IuY29tOyBwYXVsbWNrQGtlcm5lbC5vcmc7IGFr
cG1AbGludXgtZm91bmRhdGlvbi5vcmc7DQo+IHF1aWNfbmVlcmFqdUBxdWljaW5jLmNvbTsgcmR1
bmxhcEBpbmZyYWRlYWQub3JnOw0KPiBkYW1pZW4ubGVtb2FsQG9wZW5zb3VyY2Uud2RjLmNvbTsg
c29uZ211Y2h1bkBieXRlZGFuY2UuY29tOw0KPiBwZXRlcnpAaW5mcmFkZWFkLm9yZzsganBvaW1i
b2VAa2VybmVsLm9yZzsgcGJvbnppbmlAcmVkaGF0LmNvbTsNCj4gY2hhbmcuc2Vvay5iYWVAaW50
ZWwuY29tOyBwYXdhbi5rdW1hci5ndXB0YUBsaW51eC5pbnRlbC5jb207DQo+IGptYXR0c29uQGdv
b2dsZS5jb207IGRhbmllbC5zbmVkZG9uQGxpbnV4LmludGVsLmNvbTsgRGFzMSwgU2FuZGlwYW4N
Cj4gPFNhbmRpcGFuLkRhc0BhbWQuY29tPjsgdG9ueS5sdWNrQGludGVsLmNvbTsgamFtZXMubW9y
c2VAYXJtLmNvbTsNCj4gbGludXgtZG9jQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZn
ZXIua2VybmVsLm9yZzsNCj4gYmFnYXNkb3RtZUBnbWFpbC5jb207IGVyYW5pYW5AZ29vZ2xlLmNv
bTsgY2hyaXN0b3BoZS5sZXJveUBjc2dyb3VwLmV1Ow0KPiBqYXJra29Aa2VybmVsLm9yZzsgYWRy
aWFuLmh1bnRlckBpbnRlbC5jb207IHF1aWNfamlsZXNAcXVpY2luYy5jb207DQo+IHBldGVybmV3
bWFuQGdvb2dsZS5jb20NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NCAyLzddIHg4Ni9yZXNjdHJs
OiBSZW1vdmUgdW5uZWNlc3NhcnkgcmZ0eXBlIGZsYWdzDQo+IA0KPiBIaSBCYWJ1LA0KPiANCj4g
T24gNC8xNy8yMDIzIDQ6MzQgUE0sIEJhYnUgTW9nZXIgd3JvdGU6DQo+ID4gUmVtb3ZlIHVubmVj
ZXNzYXJ5IHJmdHlwZSBmbGFncyB0byBhdm9pZCBtdWx0aXBsZSBpbmRpcmVjdGlvbi4NCj4gDQo+
IENvdWxkIHlvdSBwbGVhc2UgZWxhYm9yYXRlIHdoYXQgbWFrZXMgdGhlc2UgZmxhZ3MgdW5uZWNl
c3Nhcnk/DQoNClllYS4gUHJvYmFibHkgc2hvdWxkIG5vdCBzYXkgdW5uZWNlc3NhcnkuDQpIb3cg
YWJvdXQgdGhpcyA/DQoicmZ0eXBlIGZsYWdzIGhhdmUgdHdvIHByZWZpeGVzLCBSRlRZUEVfIGFu
ZCBSRl8uIFJlbW92ZSB0aGUgZmxhZyBuYW1lcyB3aXRoIHN1ZmZpeCBSRl8gYW5kIGF2b2lkIGlu
ZGlyZWN0aW9uLiINCg0KVGhhbmtzDQpCYWJ1DQo=
