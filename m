Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26DDE5BB2A6
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 21:11:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbiIPTLG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 15:11:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiIPTLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 15:11:04 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2087.outbound.protection.outlook.com [40.107.223.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D05D0ADCF4;
        Fri, 16 Sep 2022 12:11:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P27wx3PlkD5HPEMTDHj4qxRpKiYsU80O5FLmRi26sf0sw2nUgjEzKqVZ/G6FZZieI9mI9SrF2l0tOZFMdyGNpbRCwzGRNSAL2P/f16Pwucsg6Z/S0GSOPR4kLomw/QAS/dsyLhv0PsPqSPhLoEQw9CErt8lRFcyp0NNxWog0SQo4++zk9Zs6+uGCp5hw8xSKnAejxOljOog3ZqsYwEmDNPdhqThBbvmZxkLCYd2Z/jk30bcccoCl1KxtUJTN/djkXOUpg0pzQKQT1amZO6pu4VAOSStWFcBkvIEQTOfhNl3ZQQJcgjef7kgZ3oPvzZcP+9HGXazjP9dxCmBtNZR+/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RnIozBMl4gd5n4SDgnKWl81ADRbm8ZrcyJb40BNcfxo=;
 b=lxPdNqlM64x5GBWPfRn1lPz32CE+KEaVedPClpQX4jkCV+ZdTGbdtEIH3Gh1kPjT79eOrSJMw4cmTYJL7gdueMeD0fe5RjRNmt6ZOXetQrpdT+fNyp4zfHqsK5TvHrj1w6HoAw1UxmmJS6f3IPFM00gunlvNUBa75YtjlP/PBpn+Lh2ZlTR0BpOxHMLQAps8vXmz7pOZMxTKo5IIiCzJ0PN8QemDyvFjTVOCP+Pr1ngKBA2dUbodfbCWpJZU0KACeFAG7BmGeDHK+CrBnzoGteNXafRCyRhXg8v4S8kYTGYhAtaRcmKTuIOXrpgbrffisO6PL8ZQ0ISoNfGEHLhYLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RnIozBMl4gd5n4SDgnKWl81ADRbm8ZrcyJb40BNcfxo=;
 b=Jae637S6bU/CugBVHpsGBU+uhFl3tjSMRKpnCNmtWNrf2MDU2y4EbEtINUaZjuUQlNOOMP9aB6fsQ2JUkd/WZaPB/KGMpA18Cw3TQEhIFs6VFokafFPE11WC+oO5IbF34/Qi7oPHpjfflevwazRyjlM2AqoFih3XiaKMSFdH4CI=
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by CY5PR12MB6300.namprd12.prod.outlook.com (2603:10b6:930:f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Fri, 16 Sep
 2022 19:11:01 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::4120:60cf:46a8:7109]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::4120:60cf:46a8:7109%7]) with mapi id 15.20.5632.016; Fri, 16 Sep 2022
 19:11:00 +0000
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
Subject: RE: [PATCH v4 04/13] x86/resctrl: Add a new resource type
 RDT_RESOURCE_SMBA
Thread-Topic: [PATCH v4 04/13] x86/resctrl: Add a new resource type
 RDT_RESOURCE_SMBA
Thread-Index: AQHYwuO5ZOlFLD+peE+LXeSVkRHIg63iQ4CAgAA2i6A=
Date:   Fri, 16 Sep 2022 19:11:00 +0000
Message-ID: <MW3PR12MB45536FBFDAA494781F21049095489@MW3PR12MB4553.namprd12.prod.outlook.com>
References: <166257348081.1043018.11227924488792315932.stgit@bmoger-ubuntu>
 <166257362752.1043018.4708265660824485482.stgit@bmoger-ubuntu>
 <d57cd2fb-05b9-2c8a-1eb2-7310b80a5136@intel.com>
In-Reply-To: <d57cd2fb-05b9-2c8a-1eb2-7310b80a5136@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-09-16T19:09:58Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=3fcc2d98-767a-465c-8611-7d9e8f5d4d61;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-09-16T19:10:59Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 4e430ffc-85f7-4ffb-b215-eb1f01b496d1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW3PR12MB4553:EE_|CY5PR12MB6300:EE_
x-ms-office365-filtering-correlation-id: cd14c4e7-f129-4b26-9851-08da98173183
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: d6F/gDz0CQC5EDAqO8RFnWjy2Zv7VHpyTQGXwV55jwiH7PUupNPtXfTJS+jMqkBcT9Qt94iaTkPmshjyVXhjsaxsDmKZDpHhC/L3GiIj1Ga/3QoojJR0SiSC7xUYWvIcr7I0yvnmg83X3AmFppyRoGuZmSLHtDFJk+7yxy3JM7Td247aHgQzHQ5coV2uRy+H9KlJthJwcAgv0GijF5iHBFVPpktIzDWuSBxLWgSSEpP5PuugeVfDYeNPITU2N139C68Wifk3pIT3iTVs1VQUThMhVrtxVUVkyLCOHL9nZmaUROdjTg3B8xj+NhXGPjr8jT3VOp7QAmN2lOR1PpnSlBKvO1tu4EQIsTo7avcIPTMe3BtsRQYKecw+1WcDb4dtzDoKJKrbrkOkqHWNNshn0Spj6sm8w8/WhZJoS4gEvdYCa7+sr8JZMtMFDetUJb8Gg2/OlxtSF22Ty6SL6UttBHUqrt0kb8h8LFN1XGXxYfPijzLAsaqfV74e/ez/5M/81bH/IlDuPknaq6vG/NRkskx8K/lhA8NO3wS+jOJsu7WX9DvqAqmrzVRAw1gXwqCuHEAAgI2iG9KE8aqIGsuSCf1GV8ihQrBgCu3HH3nUmEKXZJGTckTG8JHQkjnNL3FSUw6b5ylDHCWYl2h236T6XIIXrIs4icd9g365Qsuyviyu/Sz4sjgFA8RbVIMPFLhfP5u/qOMakt34/EBYE24UztfhGOScm8fi1cWjoQDvOKGCVjYFIT55NlvTlY5mql/+qxl/UKi8/iSUt7oQ/76txg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(396003)(39860400002)(376002)(366004)(451199015)(110136005)(66476007)(122000001)(71200400001)(41300700001)(4326008)(5660300002)(6506007)(55016003)(53546011)(38070700005)(64756008)(38100700002)(66556008)(86362001)(52536014)(76116006)(66446008)(83380400001)(8676002)(186003)(478600001)(66946007)(26005)(54906003)(8936002)(33656002)(316002)(7696005)(9686003)(7416002)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Ym5xSVJlNk5RVGxFUmIyV2xVMUc0ZElOM0tJU0hTYlhyRy9aQUYyRkp4NG1t?=
 =?utf-8?B?M1AzZGRaNnNQU1pFQzFWVThWK1lZanlzaGx1QjNvdzhSenIvTG9GSnRKUUFN?=
 =?utf-8?B?SmZYVnRDVEVtSzQwUE8wVXhpMUpuajdlQmNqZG9yNk5pM2k1SlcrQ0pyT0s3?=
 =?utf-8?B?QytnUXAzL1A3SVZHcG9VUGhMWjJLQWR6WmZHY2kwelhHZCtXSk02U0d6RHVW?=
 =?utf-8?B?UjgzRDczUlhhMS9UanBuU3RJVUI3ckJmOXZIcXREaWg0MGFxd1NVTDJsWlYy?=
 =?utf-8?B?bGY1T2JpL1JlalROMldEeDRmYU1JV0JqQzBIblE0L3FnWEtBSm9DQlRyNFF6?=
 =?utf-8?B?RnFSY2o0MXl5N0dzT3U2YXJxSkhhQ003ZXNqeXJMQ0tHd3BDaG9zMlFyRlU2?=
 =?utf-8?B?OUdFWElLZDVIUU11eGFYLytKeTFVNUVhOW9TaytKTTVhUkdxeWsrLytlVndM?=
 =?utf-8?B?L2xGV2h2U3BqTjN3a0tBVmtzVnAzRUFHVCtXL2gyMjZ3aTlsb1dkWUsybzZW?=
 =?utf-8?B?ckIrMmZGRnNhaExNVHhWbmtMVHd6eUt0T1JrRVRoQmVJVUUydUd6U3lBSkxS?=
 =?utf-8?B?VTdINU9iYmtwSiszV3ZFZUtPRGM4WndnbzBreXhlZlZmZ3BZdmdBWWhvV1Iz?=
 =?utf-8?B?SGhHQ1ZIVDdjaUUyaXMwaWtIS1pEcnh6VW5LQ1ZwOU5TWTlCeXpUeEhFNUdn?=
 =?utf-8?B?RE93LzZzdTNvQk1CWXgvcnNUTktOZnIwQ3lBaitxN05QaXRkTEtYYjN4d2NT?=
 =?utf-8?B?TGF2RTVhc2Q1azZKVHZJWWZheDZ4dnBMUTNJMGtOU24vZy9mWVdJUGhUdEVx?=
 =?utf-8?B?dGxxVjlSVks5V1NKcVMwZENiRWhsUnBDOVFuNlJScDZoZVVnKzU5V0dtVWgw?=
 =?utf-8?B?dkR3YU9vUCs3VDZLenFySURPY3dmQlArSCtnNCtxa3lNL3k1SnNKbmV1Q2p3?=
 =?utf-8?B?MTIzYlNKdGVGNG1uOE8ySmw3aXh5NEF5NzZmcTY4RmRybFlLUjJrTTFPaThK?=
 =?utf-8?B?QnE1bGNVUlJqZWI5RFpOcnEzcEJWcytTeDNaTEZLMjhQb0hCV3BxMjZiUHBv?=
 =?utf-8?B?b1cybkVDRTIreHU3ZGl3SmRRL1BaSUpDS3R0eThSYmJtbEJ4SHBlWW9PK2p4?=
 =?utf-8?B?TGtibUpSSmdSNXZ6YzVWRGtiNUs2dEFqUDNXeXRyQk5oQWs1d2pzMjA1N3E4?=
 =?utf-8?B?OS9HUHcwZmhZZ2UzNjhaNHM1ZjAwZFdOYmN0YWd5ais1bzRraHR1aDhIa25D?=
 =?utf-8?B?V3NUWnNJYjN5T0htaU43MDZMV01SeUw2SU85MllvWUZSVzJQYlBxN2U0UUow?=
 =?utf-8?B?Szk2SlNDVk9pNDM3bm5IdzhxcU9ZTlVhVm1iUmRFOFAwSmFJaE1hTXEwK3Rl?=
 =?utf-8?B?SEtIejVhSk5lcHJHbDFVOW5xb2MrM3dNeTZWcFpQUUZQQjQ4a0UyOWpxU3d2?=
 =?utf-8?B?amw3U01xVVUybms1K1U2Qkh3RTA5S3ZuN3ZCSVh4Uk5XWUY1WU16NXJ1YUJO?=
 =?utf-8?B?b3VGRkN0YXNOSGU1M2kzZTFrMElMZ0o2cTdabzRpUk9QaTU5RFRHOSttcFZN?=
 =?utf-8?B?QXZkQ0l4cWloZ1FxQ1JhRngxYzdyOTVMMS9NR0dKdXRnSENxN2pJOWVhWTlS?=
 =?utf-8?B?WkQ2bzRNNWJmNHpKc3Q3LzRxa2ZlRlhBWTR6MW90b1VjWHV2eml3N0Q1Q0p1?=
 =?utf-8?B?azFhMkt0TTZEQU9BNFo2L1g0U0hFcXRjRmcxb3RHSm9pZVRHd1RYOEFFK3FI?=
 =?utf-8?B?eGYzNm16T3ZSNzIva2tmNndTeTZITWk1Nkw5Y3dyWlZ0NVZZQ2p1Rm8xRlM3?=
 =?utf-8?B?d3Z0akQvL3BrVCtGSGgzSXdoQ0twMm1rOHMwdWV1MkVuN2pMT21uLzFsVk9C?=
 =?utf-8?B?aHdhNXVDR1dpTERGTFlZSkw5RXg1MFNYSEpTYVdyL3VGR1VNR1RYc20yUWRY?=
 =?utf-8?B?RzNIUnhKTUdFNDA1V3BXS3FIS1RhMDR5OFpZM09jWFFSc085R3pDQnJsaHc4?=
 =?utf-8?B?ekZxUFdxVEpXNGpCVXlXMHU0TnNycnROWGJCRURYV2hiMzNLemhSdElBOU9Y?=
 =?utf-8?B?TEhmTWRFalRWVW9KbXJuUG05ZUVSMWFKRFpnRG1MUkVyc1UyRi9WS3FqRXdo?=
 =?utf-8?Q?vDfA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd14c4e7-f129-4b26-9851-08da98173183
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2022 19:11:00.8099
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vJxKgCwVBC+0qJlfLRtX9V3JTY97J+JUAQaE7a5TRXG51AC2zSMLsafZETmkaVmd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6300
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
dWJqZWN0OiBSZTogW1BBVENIIHY0IDA0LzEzXSB4ODYvcmVzY3RybDogQWRkIGEgbmV3IHJlc291
cmNlIHR5cGUNCj4gUkRUX1JFU09VUkNFX1NNQkENCj4gDQo+IEhpIEJhYnUsDQo+IA0KPiBPbiA5
LzcvMjAyMiAxMTowMCBBTSwgQmFidSBNb2dlciB3cm90ZToNCj4gPiBBZGRzIGEgbmV3IHJlc291
cmNlIHR5cGUgUkRUX1JFU09VUkNFX1NNQkEgdG8gaGFuZGxlIHRoZSBRb1MNCj4gDQo+IChuaXRw
aWNrKSBBZGRzIC0+IEFkZA0KPiANCj4gPiBlbmZvcmNlbWVudCBwb2xpY2llcyBvbiB0aGUgZXh0
ZXJuYWwgc2xvdyBtZW1vcnkuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBCYWJ1IE1vZ2VyIDxi
YWJ1Lm1vZ2VyQGFtZC5jb20+DQo+ID4gLS0tDQo+IA0KPiBBcGFydCBmcm9tIG5pdHBpY2sgdGhp
cyBsb29rcyBnb29kLg0KDQpUaGFuayB5b3UNCkJhYnUgTW9nZXINCg==
