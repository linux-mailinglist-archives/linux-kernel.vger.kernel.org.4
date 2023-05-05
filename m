Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34F806F8859
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 20:03:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233201AbjEESD3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 14:03:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232149AbjEESD1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 14:03:27 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2043.outbound.protection.outlook.com [40.107.100.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7CC0160BD;
        Fri,  5 May 2023 11:03:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ph4O25R8WPHJqnr/kVt2G8S6VmJn/QyfQZ5UuGdIYDG0obMMA3bcccyqIulmn0yvJ1bnFTO11BbRs6BNZLadO9AzZaZZ/XqHRR1434f66lvgfcYjUSJusKYLvjzL4KroVXkYNhCt+XaPVspLYZXWs25VaRLNBYL9FAb/pKlUiJHHw6QUc+QAG6LyxJGF7bThgzgSntLRzgLoXhf7GntgSZYRLbee9x4vErmntPvUp/dGg0Br1D8Af/xwidf3akf5p91x4vtVjKy4eF9TDDAhbUbOBk+NHTNzLQHm2R31lIGv8IJ4upSssi7r2f8nu997jJdEMOqMtPMQmc8YdbzD5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=El+Q5C+5t5QvAHbFM/zFJS4UKB+CGqeczdEfGfFUiFo=;
 b=hkD77mZyXnikx7h/gUlBN1Cr69Dx8ifNl/FI142mLtZZePTd4yFcgQdA0b54ibhppdlcKE53O9/Ct3d2ELnBj4bQikEFl4gToAWsfRXPfgffINiy/3r2TWD+9okaBpH3Cld3kkkYul0D2iMWKWMkWL4FPSfniNCSm/s4tHXA7jQ2SytLGRbuwARN+Yh75k1ngKA48vyd65FtPAIVc7BW4pAN3dYD2p4QyBb93Q62QbsnvaSx4tqiSNdNJwgwIBk7GaYjdroNGzS0pT3jtzQ4HduWQpe5KtJKKwMYn+l20En5W3KjHomvLVjVDng88pWjTPtP8RQYSpdsQTCPUWYTNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=El+Q5C+5t5QvAHbFM/zFJS4UKB+CGqeczdEfGfFUiFo=;
 b=yJKMLqqyi4LkQxpfUgFWWwguENriFfL7rWfQroeUTfJ3Pnd3tZTfQT2Ka0Ty49bDfcj+yYI/IppYLnG7qGYpJC3jRS198CLTmDrcoqzFqrN+u1Mad7eL+e+bGEMeRRkRrxgayN54lGOH6qCUSdYJ3tV2WhLWn3meOeNYgg9g4YA=
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by PH7PR12MB5949.namprd12.prod.outlook.com (2603:10b6:510:1d8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.30; Fri, 5 May
 2023 18:03:20 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::216f:6f0f:4a21:5709]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::216f:6f0f:4a21:5709%5]) with mapi id 15.20.6363.026; Fri, 5 May 2023
 18:03:20 +0000
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
Subject: RE: [PATCH v4 0/7] x86/resctrl: Miscellaneous resctrl features
Thread-Topic: [PATCH v4 0/7] x86/resctrl: Miscellaneous resctrl features
Thread-Index: AQHZcYUbuzTOXhwvqk6f00fV4pAStq9KkKAAgAFZlyCAACYEAIAAAfpw
Date:   Fri, 5 May 2023 18:03:20 +0000
Message-ID: <MW3PR12MB45538C7F579298B1534406C795729@MW3PR12MB4553.namprd12.prod.outlook.com>
References: <168177435378.1758847.8317743523931859131.stgit@bmoger-ubuntu>
 <d0e72b31-1865-9e23-51c9-5c43cd71084e@intel.com>
 <MW3PR12MB455312E6A33BA29FD355745595729@MW3PR12MB4553.namprd12.prod.outlook.com>
 <5d02d54b-60a0-fc43-7340-238b910e22b4@intel.com>
In-Reply-To: <5d02d54b-60a0-fc43-7340-238b910e22b4@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-05-05T18:03:19Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=0c3d76ad-4de7-4f19-954f-c438d08c26a8;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2023-05-05T18:03:19Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: fe075feb-cba7-487c-afe1-fb75211b7dda
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW3PR12MB4553:EE_|PH7PR12MB5949:EE_
x-ms-office365-filtering-correlation-id: cfec3c93-a774-475a-c9a8-08db4d9302af
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nFxBVDBS/ldzkBlVoS/pyvRkIcY365PanMpo4174irrINySTccL+cB+iDzSShGmV0z7Y42irISKYK6bIzQPJ3nSRT3w4YG6080Buz7MdoyC8y40Bvo98IgoPimPN6ttwLG7gzMiQSpcDFHB0AGbeMjCT3WfnyYQQJCmLNJZoTQmFQxbWIUYay4utxGhviCrRNeAMZKDKWS/1Fyc1wntXia0cr6Xza/6u9qKfsToHZGXGHmwvdL79hKut/K8MC+LEuMahJnbbAuCsXziu0h6Zhad3AeRdpV/ywxQo3c+wZLjv15vkAbHbeiFcT8tkQ2mIVdAW4MvtNBjGSKHdKb+DuJ2nSIxYJcQPfYQL35SP1muqi32a+IR1Lzt5eNlYQOWviYbQ/Bv7DtcYncFkZdlmRzSaP7vPERZweOkXq8Gc192lg2ygNdamsgx4hQYfQGzFJ4JzX7PJqfIVkZuZrakZaknB2BRH6HoSGTV/You0PdYWKxL4+GIlp+VwfR0qi0vvWAFo7qbV8Ky8ucD+bDn3JiEyOqegseWLbd47vgEsDywccm4mgdh3LVus3u0w5heyTWhwcujL8d/VgUVU4ZA0spNcrguv0smLdP+ilCf7UvdoSsK28ThX9lBkGJFhBGvHB3hKfhu58U43K+s9zLslzA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(396003)(366004)(376002)(39860400002)(451199021)(7696005)(86362001)(966005)(53546011)(26005)(71200400001)(6506007)(9686003)(186003)(55016003)(5660300002)(38100700002)(33656002)(52536014)(83380400001)(8936002)(8676002)(7416002)(2906002)(66946007)(478600001)(66556008)(7406005)(66446008)(64756008)(66476007)(76116006)(110136005)(54906003)(41300700001)(122000001)(4326008)(316002)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MFk5QXBiWDl3Sm53UUpHeUtLVkx3NVM3TXBFMVV0RHhGMWhTUWpJaS9TS0lT?=
 =?utf-8?B?ZzBYSDJvRnUxWXJYTjJsVzNyV1lpcWRYcTUrSXhQUmp1OVNBWElKVDFJRmFx?=
 =?utf-8?B?Z3NCUUFNRW03R3VPd0VmWDNOdmNmVlp5c2pWYkxILzh5VWN3M1piaHlKRjFY?=
 =?utf-8?B?NWZVVDRxaG13bXloVXhscGIvQWxxOWlaa3VSelN4cGZqU25RRDdER1V6RlR5?=
 =?utf-8?B?aHM2Z3U0c3pLVXFleERPS2J5ME5odHY0cU5NNmthbG9LeTQzZUhWblZKTmpu?=
 =?utf-8?B?bDUzWlc1eDJyTjYzR1BOWkdLYkVMeklVNkMvSUhNYjZNMTFMdDNJa2FzalNY?=
 =?utf-8?B?WElpelpOYnM1VFVGbDAyL2J0SVNIVGpmaVdmeWpNaGp2TjVpOEZaT0VYdG9t?=
 =?utf-8?B?d3JaMXVVanVxckdERWkrajRPVWNHV3A4bUFSeU9qbTlXQVQybVFpU0t1R01X?=
 =?utf-8?B?WWRRRXZRWXIycDZ2VFdGajZ5WXN0R0V3MFpwL0pHdkM3dG5tVlVjNURtRlVv?=
 =?utf-8?B?cEIxSFVHNmRWWXBDaHlpa05MaVh3QVZFZE0xdDdPWWZhc1hVRkFUY3RVVlUw?=
 =?utf-8?B?K0NtZFZWNG0yWFp6c1BIUlFIS3drbkNSMUlmRkpWdFZPODZveTQ1VUFGdHJU?=
 =?utf-8?B?U0NVc0I0K3Qzd3Q3UXRyLzNZQzgrRFl2MURGc0JRaG84NStJTjA3dG9uRGdB?=
 =?utf-8?B?VXgrVDIwSWFMMlVNTkhwUTROdEpML1hPeTZ0bnV1RWhRSDE0aXJ2TEFiMTE4?=
 =?utf-8?B?ZWVIUHFRQW5DOERkVGJJbzJUenRUOHNRMkVLMlE2WDFVOXFKcHNNY0t2WmhM?=
 =?utf-8?B?aXFMR0wyc1EzOWRjUTBEL1FqNTl4eGpPRnRBZ1FNeHJpbDRsamtmeVlYZFBI?=
 =?utf-8?B?WVRLWW42V2lCNC9DZEdEWFB2aEFCMHV0OEtkdEVtU09ma2o4UXFscGF5M1Ni?=
 =?utf-8?B?ZlpFdWdFN280cUEzU3VwaWZ6MkJqS0IzRGRVa1Z5VWZoTklyTTFUZlZEbU5P?=
 =?utf-8?B?R1NtQUI3NitSaUlmK05OT1pubk5HRko4MkM0OHMyZnZDK0gwU3pwa2d1cC9J?=
 =?utf-8?B?SUpjaGNQNjZOOExmZVJEcGVxb015ZXlSQ0tHaGFGODZLdlZSSTJkMFFsYWQ3?=
 =?utf-8?B?RGNoLzlnSXVuZU5MZGsyakx5NHgybFZkWDRKZE04ejhVOUhIVHEyd3gwTTBD?=
 =?utf-8?B?WHBqQVNCTTRjVHJVemE5YnpaQnpDcEg1ZExjMUxGdFd2Q2FXbkJVY1BNUGxl?=
 =?utf-8?B?OVpqYlcyczBuaFdLaVNxZERDM1lZeERjQzhueGN3SGh1RkR1enlnOHNSMmRl?=
 =?utf-8?B?ZW9iSW40RUZSWkhhYWlIQ2s5NUVIK2V2RWNKR3RTQ2g5VlZxYnpFUTliWWJR?=
 =?utf-8?B?cUc4cmUvcEhzYW5QV2FXSW9sVnREY2lPb05CbzFSUXgvejhtY1dYU210MnF1?=
 =?utf-8?B?a3ZqbWdXT1FzUUd3cnI2RlNtRW5YZ2xCQ25uTkpKSVhoT0tmNk4zL3RxSUZn?=
 =?utf-8?B?SFMrQ0ZEY3ZvSkF5WktPWWFkVnJxaFM2K2VteTNtbnRqTy9yK3FWUWdDN00r?=
 =?utf-8?B?c0JTTGVuOFRoUnViNjAyQWw4TU5Ua2k0d0YvcUxZMzJPcVRWb1cvaUx6eTBy?=
 =?utf-8?B?M2JTaHNJd1RFakVHQjBHS1lXNkhtQW5LNkpRMHl0aFZCU1NqUGkzZDdEYWJT?=
 =?utf-8?B?SFJSZzFYdTFRbU9nT2VXc09qYXZwYkYvV1VzaHZtSW1xQmppd1dyYkFYcFdl?=
 =?utf-8?B?blZCNUJBK2Q1eEhxdURxblN0U3hWckJuQTJMVloxdlNXVHpPQzFLSnRaTThi?=
 =?utf-8?B?YjluY0xwQTFyL2E1RXNvQmJ1OGRNVVZueVVXSzZvRVZVNlExamdBNW5kdktz?=
 =?utf-8?B?S3J3a0dYdkxBWjI4V2RrMlNnZFo5MVcwWE9mVDcwK1AvT1ZGK0xQd3hzMWlN?=
 =?utf-8?B?TTVDME52ajBuc0JRSnRicDlkVldiSjEzeVRuZ1FJczZNVjQyK0M4STJGbjFB?=
 =?utf-8?B?Y2pWc3BwcDZpYnpXak40YkZqT0w2d1VxVThobWhqZUs2dkQrcnBGRktsUndG?=
 =?utf-8?B?K0NkQ0hNNlV0N2xkbjI5V2tsQ2d4SnF2NGxObUpJTzczOGJVZE5jVW9xUHps?=
 =?utf-8?Q?5hSE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfec3c93-a774-475a-c9a8-08db4d9302af
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2023 18:03:20.3374
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wf0HUNcCgQ04Z9eNZwUT1jZP5qfdaA1uLa8irejZpEnIQl03aTvXsDDCTmqMb75x
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5949
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
dGUuY2hhdHJlQGludGVsLmNvbT4NCj4gU2VudDogRnJpZGF5LCBNYXkgNSwgMjAyMyAxMjo0NyBQ
TQ0KPiBUbzogTW9nZXIsIEJhYnUgPEJhYnUuTW9nZXJAYW1kLmNvbT47IGNvcmJldEBsd24ubmV0
Ow0KPiB0Z2x4QGxpbnV0cm9uaXguZGU7IG1pbmdvQHJlZGhhdC5jb207IGJwQGFsaWVuOC5kZQ0K
PiBDYzogZmVuZ2h1YS55dUBpbnRlbC5jb207IGRhdmUuaGFuc2VuQGxpbnV4LmludGVsLmNvbTsg
eDg2QGtlcm5lbC5vcmc7DQo+IGhwYUB6eXRvci5jb207IHBhdWxtY2tAa2VybmVsLm9yZzsgYWtw
bUBsaW51eC1mb3VuZGF0aW9uLm9yZzsNCj4gcXVpY19uZWVyYWp1QHF1aWNpbmMuY29tOyByZHVu
bGFwQGluZnJhZGVhZC5vcmc7DQo+IGRhbWllbi5sZW1vYWxAb3BlbnNvdXJjZS53ZGMuY29tOyBz
b25nbXVjaHVuQGJ5dGVkYW5jZS5jb207DQo+IHBldGVyekBpbmZyYWRlYWQub3JnOyBqcG9pbWJv
ZUBrZXJuZWwub3JnOyBwYm9uemluaUByZWRoYXQuY29tOw0KPiBjaGFuZy5zZW9rLmJhZUBpbnRl
bC5jb207IHBhd2FuLmt1bWFyLmd1cHRhQGxpbnV4LmludGVsLmNvbTsNCj4gam1hdHRzb25AZ29v
Z2xlLmNvbTsgZGFuaWVsLnNuZWRkb25AbGludXguaW50ZWwuY29tOyBEYXMxLCBTYW5kaXBhbg0K
PiA8U2FuZGlwYW4uRGFzQGFtZC5jb20+OyB0b255Lmx1Y2tAaW50ZWwuY29tOyBqYW1lcy5tb3Jz
ZUBhcm0uY29tOw0KPiBsaW51eC1kb2NAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdl
ci5rZXJuZWwub3JnOw0KPiBiYWdhc2RvdG1lQGdtYWlsLmNvbTsgZXJhbmlhbkBnb29nbGUuY29t
OyBjaHJpc3RvcGhlLmxlcm95QGNzZ3JvdXAuZXU7DQo+IGphcmtrb0BrZXJuZWwub3JnOyBhZHJp
YW4uaHVudGVyQGludGVsLmNvbTsgcXVpY19qaWxlc0BxdWljaW5jLmNvbTsNCj4gcGV0ZXJuZXdt
YW5AZ29vZ2xlLmNvbQ0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY0IDAvN10geDg2L3Jlc2N0cmw6
IE1pc2NlbGxhbmVvdXMgcmVzY3RybCBmZWF0dXJlcw0KPiANCj4gSGkgQmFidSwNCj4gDQo+IE9u
IDUvNS8yMDIzIDg6NDMgQU0sIE1vZ2VyLCBCYWJ1IHdyb3RlOg0KPiA+IFtBTUQgT2ZmaWNpYWwg
VXNlIE9ubHkgLSBHZW5lcmFsXQ0KPiA+DQo+ID4gSGkgUmVpbmV0dGUsDQo+ID4NCj4gPj4gLS0t
LS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPj4gRnJvbTogUmVpbmV0dGUgQ2hhdHJlIDxyZWlu
ZXR0ZS5jaGF0cmVAaW50ZWwuY29tPg0KPiA+PiBTZW50OiBUaHVyc2RheSwgTWF5IDQsIDIwMjMg
MTo1NCBQTQ0KPiA+PiBUbzogTW9nZXIsIEJhYnUgPEJhYnUuTW9nZXJAYW1kLmNvbT47IGNvcmJl
dEBsd24ubmV0Ow0KPiA+PiB0Z2x4QGxpbnV0cm9uaXguZGU7IG1pbmdvQHJlZGhhdC5jb207IGJw
QGFsaWVuOC5kZQ0KPiA+PiBDYzogZmVuZ2h1YS55dUBpbnRlbC5jb207IGRhdmUuaGFuc2VuQGxp
bnV4LmludGVsLmNvbTsNCj4gPj4geDg2QGtlcm5lbC5vcmc7IGhwYUB6eXRvci5jb207IHBhdWxt
Y2tAa2VybmVsLm9yZzsNCj4gPj4gYWtwbUBsaW51eC1mb3VuZGF0aW9uLm9yZzsgcXVpY19uZWVy
YWp1QHF1aWNpbmMuY29tOw0KPiA+PiByZHVubGFwQGluZnJhZGVhZC5vcmc7IGRhbWllbi5sZW1v
YWxAb3BlbnNvdXJjZS53ZGMuY29tOw0KPiA+PiBzb25nbXVjaHVuQGJ5dGVkYW5jZS5jb207IHBl
dGVyekBpbmZyYWRlYWQub3JnOw0KPiBqcG9pbWJvZUBrZXJuZWwub3JnOw0KPiA+PiBwYm9uemlu
aUByZWRoYXQuY29tOyBjaGFuZy5zZW9rLmJhZUBpbnRlbC5jb207DQo+ID4+IHBhd2FuLmt1bWFy
Lmd1cHRhQGxpbnV4LmludGVsLmNvbTsNCj4gPj4gam1hdHRzb25AZ29vZ2xlLmNvbTsgZGFuaWVs
LnNuZWRkb25AbGludXguaW50ZWwuY29tOyBEYXMxLCBTYW5kaXBhbg0KPiA+PiA8U2FuZGlwYW4u
RGFzQGFtZC5jb20+OyB0b255Lmx1Y2tAaW50ZWwuY29tOyBqYW1lcy5tb3JzZUBhcm0uY29tOw0K
PiA+PiBsaW51eC1kb2NAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwu
b3JnOw0KPiA+PiBiYWdhc2RvdG1lQGdtYWlsLmNvbTsgZXJhbmlhbkBnb29nbGUuY29tOw0KPiA+
PiBjaHJpc3RvcGhlLmxlcm95QGNzZ3JvdXAuZXU7IGphcmtrb0BrZXJuZWwub3JnOw0KPiA+PiBh
ZHJpYW4uaHVudGVyQGludGVsLmNvbTsgcXVpY19qaWxlc0BxdWljaW5jLmNvbTsNCj4gPj4gcGV0
ZXJuZXdtYW5AZ29vZ2xlLmNvbQ0KPiA+PiBTdWJqZWN0OiBSZTogW1BBVENIIHY0IDAvN10geDg2
L3Jlc2N0cmw6IE1pc2NlbGxhbmVvdXMgcmVzY3RybA0KPiA+PiBmZWF0dXJlcw0KPiA+Pg0KPiAN
Cj4gLi4uDQo+IA0KPiA+Pj4gICAgIFRyaWVkIHRvIGFkZHJlc3MgUmVpbmV0dGUncyBjb21tZW50
IG9uIHBhdGNoIDcuIEJ1dCBkdWUgdG8NCj4gPj4+IGN1cnJlbnQgY29kZQ0KPiA+PiBkZXNpZ24N
Cj4gPj4+ICAgICBJIGNvdWxkIG5vdCBkbyBpdCBleGFjdCB3YXkuIEJ1dCBjaGFuZ2VkIGl0IGxp
dHRsZSBiaXQgdG8gbWFrZSBpdCBlYXN5IGRlYnVnDQo+ID4+PiAgICAgZmlsZSBhZGRpdGlvbnMg
aW4gdGhlIGZ1dHVyZS4NCj4gPj4NCj4gPj4gQ291bGQgeW91IHBsZWFzZSBlbGFib3JhdGU/IEl0
IGFjdHVhbGx5IGxvb2tzIGxpa2UgeW91IG1heSBiZSBoZWFkZWQNCj4gPj4gdGhlcmUgbmV4dCBh
Y2NvcmRpbmcgdG86DQo+ID4+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvOTMzZDhhZTIt
ZDhiNy03NDM2LTU5MTgtDQo+ID4+IGY2Mzk0MDVjOWVjYkBhbWQuY29tLw0KPiA+DQo+ID4gU29y
cnksIEkgd2FzIHRhbGtpbmcgYWJvdXQgdGhpcyBjb21tZW50Lg0KPiA+IGh0dHBzOi8vbG9yZS5r
ZXJuZWwub3JnL2xrbWwvZmVmMTJjOWUtN2Q2Zi1iY2Q0LWY5MmUtZTc3NmViOWU2NzNiQGludGUN
Cj4gPiBsLmNvbS8NCj4gPg0KPiA+IEkgdHJpZWQgdG8gYWRkcmVzcyBpdCBoZXJlLg0KPiA+IGh0
dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvMTY4MTc3NDUxMDEwLjE3NTg4NDcuNTY4MjE4NDkx
NTI4Mjk3NDUxLnMNCj4gPiB0Z2l0QGJtb2dlci11YnVudHUvDQo+ID4NCj4gPiBUaGlzIG1heSBu
b3QgYmUgdGhlIGV4YWN0IHdheSB5b3UgbWVudGlvbmVkLiAgUmVhc29uIGlzLCBhZGRpbmcgdGhl
DQo+ID4gZmxhZ3MgYmVmb3JlIHJkdGdyb3VwX2FkZF9maWxlcyBjYW5ub3QgYmUgZG9uZS4gSXQg
ZG9lcyBub3QgdXBkYXRlIHRoZQ0KPiA+IHJlc2N0cmwgcm9vdCBmaWxlc3lzdGVtLiBUaGVzZSBm
aWxlcyBoYXZlIHRvIGFkZGVkIGJ5IGNhbGxpbmcNCj4gPiByZHRncm91cF9hZGRfZmlsZSBhbmQg
a2VybmZzX2FjdGl2YXRlIGluIHJkdF9lbmFibGVfY3R4Lg0KPiBJIHRoaW5rIHdoYXQgeW91IGFy
ZSByZWZlcnJpbmcgdG8gaXMgZmlsZXMgbm90IGFwcGVhcmluZyBpbiB0aGUgZGVmYXVsdCByZXNv
dXJjZQ0KPiBncm91cD8gRnJvbSB3aGF0IEkgY2FuIHRlbGwgdGhlIGZpbGVzIHNob3VsZCBhcHBl
YXIgd2hlbiBuZXcgcmVzb3VyY2UgZ3JvdXBzDQo+IGFyZSBjcmVhdGVkLiBDb3VsZCB0aGUgZGVm
YXVsdCByZXNvdXJjZSBncm91cCdzIGZpbGVzIG5vdCBhbHNvIGJlIGFkZGVkIG9uDQo+IHJlc2N0
cmwgbW91bnQgKG1vdmVkIGZyb20gcmR0Z3JvdXBfc2V0dXBfcm9vdCgpIHRvIHJkdF9nZXRfdHJl
ZSgpKT8NCg0KWWVzLiBJIGNhbiB0cnkgdGhhdC4NCg0KPiBJIGRvIG5vdCBzZWUgd2h5IHRoZSBm
aWxlcyBiZWxvbmdpbmcgdG8gdGhlIGRlZmF1bHQgZ3JvdXAgYXJlIHJlcXVpcmVkIHRvIGJlDQo+
IGFkZGVkIGJlZm9yZSByZXNjdHJsIG1vdW50IGFuZCB3aXRoIHRoZSBtb3ZlIHRoZSByZXNjdHJs
X2RlYnVnIGZsYWcgY2FuDQo+IGNvbnRpbnVlIHRvIGJlIHNldCBpbiByZHRfZW5hYmxlX2N0eCgp
IGFuZCBhdmFpbGFibGUgdG8gcmR0Z3JvdXBfYWRkX2ZpbGVzKCkNCj4gd2hlbiBhZGRpbmcgdGhl
IGRlZmF1bHQgcmVzb3VyY2UgZ3JvdXAncyBmaWxlcy4NCj4gDQo+IFRvIG1lIHRoaXMgc291bmRz
IHNpbXBsZXIgc2luY2UgdGhlcmUgaXMgbm8gZHVwbGljYXRlIGZpbGUgYWRkL3JlbW92ZSBjb2Rl
LCBhbmQNCj4gdGhlIGRlYnVnIGZpbGVzIGFyZSBqdXN0IGFub3RoZXIgZmlsZSB0eXBlLg0KDQpZ
ZXMuIElmIGl0IHdvcmtzIHRoZW4gSXQgd2lsbCBtYWtlIGNvZGUgc2ltcGxlLiBXaWxsIHRyeSBh
bmQgbGV0IHlvdSBrbm93Lg0KVGhhbmtzDQpCYWJ1DQo=
