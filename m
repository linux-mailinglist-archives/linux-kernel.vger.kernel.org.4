Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 919DC64E318
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 22:30:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbiLOVap (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 16:30:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbiLOVak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 16:30:40 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2070.outbound.protection.outlook.com [40.107.102.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BBF527B22;
        Thu, 15 Dec 2022 13:30:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j+a+Oql8uahIh0K9gv68KXtH51AiwDEkym3TMADrQEA6uj+xAg/EmPNQo03I+dyN8nPjK56WTfL8CgQwEwPckafCOsVMVEGjEU+yBkPkjcYWiTp7WgJnGOAvQwdUG4TLhZsyaEuTy5BXIHslO2MX+hYkQB2hMK3EU1W/9odQ9QGg37dbQylWVUbu54ZBNSIGGGFam3Nr7hzL25rAB2DdCBtrG2CZzOkxgrQ0KRVjP5GIEVa+n0W8psQ5sBNMkeXSrwPC0lJqMG18eRu6TGoRAPIvF+hqMqtSNlhuyjUrgp1zuRvWTTBV7r4hSmTrgG8iW5rnI5IXOsXp+nQ0vIG/MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zSaS2W9fFvQ50T/ypw2OhOWw7axCihpYQbSx+0WikUE=;
 b=e3mtTuJO64QrESAacXIlMs2rHVQlqRA4FxFKGClc6p7CJZg3qpoLUWe68/wV2QsihGolzkd77NXGyf5tTXM0UT2TY76SDzYO+JbvYVrPqB1QPKt5C0wb3eUsFOwLiAtOp6PSX6soQtXWQCUSJ/yMAUfDVa4aElyaaOMsXBAvvbDBVjONj1nGhKQVZEG9+tqoKql0bzt6C6xiKTiyrMOmcmml39xX17k3COG4NdCHsdoYR4L+AlTKAuYULNI/V1NNQq4NgoIV5sPPDvf7bLrrd8ejIlAvOCEJJ/R8jG0u2vn3fPsYYk6DPmnwAk0rCDyeM1ULItgl8677h2Xbzn1Q4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zSaS2W9fFvQ50T/ypw2OhOWw7axCihpYQbSx+0WikUE=;
 b=rVBnQshqpz4JZsak2OhGux/aweK1GFffhSFVXyrXgY2G7PoclSns+faVdTymFIQ3JQsVJkoqbcHDFcriIlMfYtRA9gsnLgEQu1hKX/WUYAe9TUV7Bme4JwoseyIBK//su6nGTCGxjpFwCx4NrQeOihANy74FaP09dBYV/FDuEiU=
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by IA0PR12MB8208.namprd12.prod.outlook.com (2603:10b6:208:409::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Thu, 15 Dec
 2022 21:30:32 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::790c:da77:2d05:6098]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::790c:da77:2d05:6098%5]) with mapi id 15.20.5880.019; Thu, 15 Dec 2022
 21:30:32 +0000
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
Subject: RE: [PATCH v9 02/13] x86/resctrl: Add a new resource type
 RDT_RESOURCE_SMBA
Thread-Topic: [PATCH v9 02/13] x86/resctrl: Add a new resource type
 RDT_RESOURCE_SMBA
Thread-Index: AQHZBZqmzUO0XRzvQkuExWTPHmmsBq5vRRCAgABIc4A=
Date:   Thu, 15 Dec 2022 21:30:32 +0000
Message-ID: <MW3PR12MB45538C89FE8FA980FC5DBC4295E19@MW3PR12MB4553.namprd12.prod.outlook.com>
References: <166990882621.17806.16780480657453071426.stgit@bmoger-ubuntu>
 <166990896761.17806.7084760980218047026.stgit@bmoger-ubuntu>
 <68c1fbfb-a448-671b-2030-7ba8f059efc3@intel.com>
In-Reply-To: <68c1fbfb-a448-671b-2030-7ba8f059efc3@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-12-15T21:29:49Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=95c3066c-c721-421b-a1d8-9e6f45d41af1;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-12-15T21:30:30Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: e89713fd-e92f-4658-8645-af102b3c76a2
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW3PR12MB4553:EE_|IA0PR12MB8208:EE_
x-ms-office365-filtering-correlation-id: 9f4f7c02-c10b-4972-4e40-08dadee39882
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nVPs+ZaJCYp+fr2dpEHyCfrg3hb9rTFFOjMIrI4xG/xYyo/HP8NawROX8McyF+JgXhfMFdlHMk3MIKK83lEUlo7JKvmqCe12OSn5xzaYCdmIiXLNWfj+aSbpHkEHhi8uyF4OXNbrbi4YldqcgxvJKM9nvj0N2H+e9KD0TD9vC+09Fu61srpwe+bMqnfTI5fqsiZqZVFkf/QY0Jbvltnward9fgMMYGpIAdZFue8Kl4Rn1NAyFgz0ivLHipv1TB34ZMMnrAr50oS3Jfj9dZ7cbUxoNLuGB2W8SvIPW7qRjogv8Jgf8n+ZtxnCIcD3OrXku5CzdZDfAbKkW2yTZSjJwdpEa6xu0zRDoYsmTrMUCpk7BZK5+WuQW9g+I0H1NXbyPkHn/E/Ow4KESQCKbW2k4UxOz+yhlWzAN9fTvAQvKD/07O+SFFPW1IKuix4jv5RCuF4YVgfue9AI1jyM9zqkj2TXmZjflU66x3grRVYaMEV+wnE0u7gT6E71P26JxaNIVapH+FhBFYtgfcDD7sxGVcQbdnXBNW+aTQMEZrbtaC1RkHSAM+qnHVaX+UN8mgCBgvbfxjgBgFSrEUFfvZfaH4sUM5JF6WfcFAsl1ZIhjvpjMCxTd9Jb63HfRp503RIR3VK7QXSswLDqdEbLjJBvVHTe10Cx/MGfKpXxVIpjpwqql1UHx/ez3MQTASU6XZLZ4jn7SxsUD/jI9Ug7W67ayw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(366004)(396003)(376002)(136003)(451199015)(55016003)(66556008)(38100700002)(64756008)(122000001)(76116006)(66446008)(66946007)(4326008)(66476007)(8676002)(33656002)(478600001)(186003)(7696005)(71200400001)(110136005)(54906003)(86362001)(9686003)(26005)(53546011)(6506007)(316002)(41300700001)(7416002)(38070700005)(7406005)(8936002)(83380400001)(52536014)(5660300002)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VFIvbWpEc3F5SFhwOE9CYVJPSHpwbmo4NGtPVGRualdsQ1pSeS9WUkQ4cHpD?=
 =?utf-8?B?UEpoQWZzaDNPcU9tdk81OEdLNDZ2dUVEd29NWjUrdmhlcWdZR0dDSTZaNnlG?=
 =?utf-8?B?S0s5M2RJSmZWak5nRHB4ZXA4RGhJb08zb3RGSk9GaTRFL296anJjOVFiOURy?=
 =?utf-8?B?OUUzMmNpemJ4NGR2MWlFS2l4ZjF1WUJEUHQvZWhVQ3BZanlFbXU0bHNLRW5t?=
 =?utf-8?B?TTQvTHZYdjU5M2s3VkxtOTFYMXZWM0F4NkpIcHhhbFdJUElyVXhXZnAxVG42?=
 =?utf-8?B?djFacFhlb2cxTUh4aURVSkZQYnNCN0g3RzZzbi81NDByUzhxM3RhSXhYdm5B?=
 =?utf-8?B?djNJSTVpRWRXN3J5WFhPTnd4Tkt0elMrV28wTVZiMzFJVTA1eFRESWhxWTI2?=
 =?utf-8?B?N2RMa1hHWHNVZytzRTlLYjQxQlZPQmdtNHd6dzVSL29nSzh5WTJPQis1anQ3?=
 =?utf-8?B?N3JMelNERWFQeDBVUE5IUitOaWlzWnBMNzROZmlVN1RWV0FFV3VVRXpJUzRi?=
 =?utf-8?B?T3NFa3d2b3ZuK0VUc3lPOXVNTXREUmJteU9tZ0ZBWmRvSVJPdzA4cjl6c3RR?=
 =?utf-8?B?aStHSkpDUDREaU1XRlZIcnkvK0J6NGppSUR5K2JyVTRNVUtRaU1BdWpNeGdz?=
 =?utf-8?B?S0lYSmlweGlGL3dpQ1lrcHBLSUhpQkVKTG9sZ08rb2tmK3ZIeHlTZmNhdGFE?=
 =?utf-8?B?RjVVYzdpK24wK2RrWjV5VGcvQ0hrSTYxK3lVaW5hWVVrMUkzZitGYXd2K0l1?=
 =?utf-8?B?L0JaVU44SW94cE0wb3RkWHFzV3l1VHozTkxJT0JGMGpnT2NSdkxiL0tWbXFu?=
 =?utf-8?B?bDNEaW8rRGRNV1hQeWJtNmFXOFMzZlNZQWNNUElMVm9za2hyOFFCRnd4bTJT?=
 =?utf-8?B?ZkJEN1J1QjQwR1BvYjdRTE42OEw0Yyt2RytaT0NzVldPZ3A5WXJ0MTBaalZT?=
 =?utf-8?B?UGpBeEhSeVhsUmxZSnVERHdaT3hReG9rb0F3MzRNNHZ1Sng1cUFXYzg0cnhy?=
 =?utf-8?B?V1Q5RDQrVnUyUWZCbmhPaWczUm53RExnWHh0ZDZwaFFtelFNdmpGSUFDdCtj?=
 =?utf-8?B?UVRCM292SEVBYTBLVUpsc0IzcWU3SDBGYUN2TXoxdUh1KzlXUjZOMnVZaXNt?=
 =?utf-8?B?U2lFN21GZmxwVGFXdlBWWE8zZ1NHaEVrcEoyZmQwbUlxY3dGblhVQUluQ08r?=
 =?utf-8?B?b2FtTGdmN3FSaW5SUTllV3hOSW1hcUhqdXhWNm9MZ25PbURwQjZNMzlBaWdl?=
 =?utf-8?B?MmpJNmZHT1oxWTV0OW04R1l3Ui9HcVgyR2Iwbk9HSmhBN2hnVVdvNHZ6Q0Fn?=
 =?utf-8?B?TVdaWWpZdDl0N0hqbXV4RUJIb3B1WDNrT3RkNSt2eVNNQUdKdjZnZmF2TU9B?=
 =?utf-8?B?dXI2a3ExdHNlZXBVVTBkVzRLeld5RVVyN2JaZmd6WTJtL0lHU0RyaGVDM1di?=
 =?utf-8?B?dkJPR3cwTjlCVWpzdlZSb3JmN3V4WGtFRmNTQi9iS1NnbU4zdmo2M04rbmp2?=
 =?utf-8?B?eXZWSzFKWlU1bVFnbUx5em1vMnNzWmVGZVFQR21idGRmWU9TMWI0bERpY29E?=
 =?utf-8?B?UHZvU05LZWIzdTJrcFJPdC9wTnM1VGJpOHpBbGdjbTRGRDNRZHhZaDVBSEY5?=
 =?utf-8?B?SHA4TkRua21MNzBZUU5VMXE4dmZPRjNLRVEvWC9aNGFXeWh5UGQrTUQzVXVi?=
 =?utf-8?B?NnJrbnFPVFBxdEhSdjlKYU04eno3SFlzczBFUGJxVDZtU2czQWxicmpkZnFi?=
 =?utf-8?B?OXlteG44c1k1MUxiVnJqelR0VGxQUGhDRmZESkV2M1VXaHFSZzZMOUpDYisx?=
 =?utf-8?B?QmNKa2RKZXE5azIyNkJHYnhFMUc4RDE0SlpkdTRteVlOZzlvczBJeVFuYnN4?=
 =?utf-8?B?enpsZHdsN0hoSkkvU2ZHOTFhTXoxdm8vODRQVWFsam4wdWluY2VLanVGeHRY?=
 =?utf-8?B?ZkNreCt5WGNzcDFNckhoRDQxRGFObVAvd0hETUdEc0gwS0R2dndpZzFwK3pH?=
 =?utf-8?B?WTI0ckZVRVg1YVdzYmJwRHVUZmF6NnpuYlRHbWV6LzBjbXNqS0RBemxLcE5Z?=
 =?utf-8?B?Z2dSWkJmWDBMNDhvcmRVYjFtblUwdjVYREZweDJIa1hOTndrem1mRVNvbjlp?=
 =?utf-8?Q?535g=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f4f7c02-c10b-4972-4e40-08dadee39882
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Dec 2022 21:30:32.3653
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 23EGEzowZvQhOtBSzIzO3ZP6+PF6jgBpu1XynOTNlYkMt05bn43MdGNARshajyVQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8208
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCkhpIFJlaW5ldHRlLA0KDQo+IC0t
LS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFJlaW5ldHRlIENoYXRyZSA8cmVpbmV0
dGUuY2hhdHJlQGludGVsLmNvbT4NCj4gU2VudDogVGh1cnNkYXksIERlY2VtYmVyIDE1LCAyMDIy
IDExOjExIEFNDQo+IFRvOiBNb2dlciwgQmFidSA8QmFidS5Nb2dlckBhbWQuY29tPjsgY29yYmV0
QGx3bi5uZXQ7DQo+IHRnbHhAbGludXRyb25peC5kZTsgbWluZ29AcmVkaGF0LmNvbTsgYnBAYWxp
ZW44LmRlDQo+IENjOiBmZW5naHVhLnl1QGludGVsLmNvbTsgZGF2ZS5oYW5zZW5AbGludXguaW50
ZWwuY29tOyB4ODZAa2VybmVsLm9yZzsNCj4gaHBhQHp5dG9yLmNvbTsgcGF1bG1ja0BrZXJuZWwu
b3JnOyBha3BtQGxpbnV4LWZvdW5kYXRpb24ub3JnOw0KPiBxdWljX25lZXJhanVAcXVpY2luYy5j
b207IHJkdW5sYXBAaW5mcmFkZWFkLm9yZzsNCj4gZGFtaWVuLmxlbW9hbEBvcGVuc291cmNlLndk
Yy5jb207IHNvbmdtdWNodW5AYnl0ZWRhbmNlLmNvbTsNCj4gcGV0ZXJ6QGluZnJhZGVhZC5vcmc7
IGpwb2ltYm9lQGtlcm5lbC5vcmc7IHBib256aW5pQHJlZGhhdC5jb207DQo+IGNoYW5nLnNlb2su
YmFlQGludGVsLmNvbTsgcGF3YW4ua3VtYXIuZ3VwdGFAbGludXguaW50ZWwuY29tOw0KPiBqbWF0
dHNvbkBnb29nbGUuY29tOyBkYW5pZWwuc25lZGRvbkBsaW51eC5pbnRlbC5jb207IERhczEsIFNh
bmRpcGFuDQo+IDxTYW5kaXBhbi5EYXNAYW1kLmNvbT47IHRvbnkubHVja0BpbnRlbC5jb207IGph
bWVzLm1vcnNlQGFybS5jb207DQo+IGxpbnV4LWRvY0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtl
cm5lbEB2Z2VyLmtlcm5lbC5vcmc7DQo+IGJhZ2FzZG90bWVAZ21haWwuY29tOyBlcmFuaWFuQGdv
b2dsZS5jb207IGNocmlzdG9waGUubGVyb3lAY3Nncm91cC5ldTsNCj4gamFya2tvQGtlcm5lbC5v
cmc7IGFkcmlhbi5odW50ZXJAaW50ZWwuY29tOyBxdWljX2ppbGVzQHF1aWNpbmMuY29tOw0KPiBw
ZXRlcm5ld21hbkBnb29nbGUuY29tDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjkgMDIvMTNdIHg4
Ni9yZXNjdHJsOiBBZGQgYSBuZXcgcmVzb3VyY2UgdHlwZQ0KPiBSRFRfUkVTT1VSQ0VfU01CQQ0K
PiANCj4gSGkgQmFidSwNCj4gDQo+IE9uIDEyLzEvMjAyMiA3OjM2IEFNLCBCYWJ1IE1vZ2VyIHdy
b3RlOg0KPiA+IEFkZCBhIG5ldyByZXNvdXJjZSB0eXBlIFJEVF9SRVNPVVJDRV9TTUJBIHRvIGhh
bmRsZSB0aGUgUW9TDQo+ID4gZW5mb3JjZW1lbnQgcG9saWNpZXMgb24gdGhlIGV4dGVybmFsIHNs
b3cgbWVtb3J5Lg0KPiA+DQo+IA0KPiBJIHRoaW5rIGEgc25pcHBldCBsaWtlIGJlbG93IG1heSBo
ZWxwIHRvIHNldCByZXZpZXdlcidzIG1pbmQgYXQgZWFzZSBhYm91dCB0aGUNCj4gY29uc2VxdWVu
Y2VzIG9mIHZhbHVlcyBjaG9zZW46DQo+IA0KPiAiTW9zdGx5IGluaXRpYWxpemF0aW9uIG9mIHRo
ZSBlc3NlbnRpYWxzLiBTZXR0aW5nIGZmbGFncyB0byBSRlRZUEVfUkVTX01CDQo+IGNvbmZpZ3Vy
ZXMgdGhlIFNNQkEgcmVzb3VyY2UgdG8gaGF2ZSB0aGUgc2FtZSByZXNjdHJsIGZpbGVzIGFzIHRo
ZSBleGlzdGluZw0KPiBNQkEgcmVzb3VyY2UuIFRoZSBTTUJBIHJlc291cmNlIGhhcyBpZGVudGlj
YWwgcHJvcGVydGllcyB0byB0aGUgZXhpc3RpbmcgTUJBDQo+IHJlc291cmNlLiBUaGVzZSBwcm9w
ZXJ0aWVzIHdpbGwgYmUgZW51bWVyYXRlZCBpbiBhbiB1cGNvbWluZyBjaGFuZ2UgYW5kDQo+IGV4
cG9zZWQgdmlhIHJlc2N0cmwgYmVjYXVzZSBvZiB0aGlzIGZsYWcuIg0KDQpTdXJlLiBXaWxsIGFk
ZCBpdC4NCj4gDQo+ID4gU2lnbmVkLW9mZi1ieTogQmFidSBNb2dlciA8YmFidS5tb2dlckBhbWQu
Y29tPg0KPiA+IC0tLQ0KPiA+ICBhcmNoL3g4Ni9rZXJuZWwvY3B1L3Jlc2N0cmwvY29yZS5jICAg
ICB8ICAgMTIgKysrKysrKysrKysrDQo+ID4gIGFyY2gveDg2L2tlcm5lbC9jcHUvcmVzY3RybC9p
bnRlcm5hbC5oIHwgICAgMSArDQo+ID4gIDIgZmlsZXMgY2hhbmdlZCwgMTMgaW5zZXJ0aW9ucygr
KQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L2tlcm5lbC9jcHUvcmVzY3RybC9jb3Jl
LmMNCj4gPiBiL2FyY2gveDg2L2tlcm5lbC9jcHUvcmVzY3RybC9jb3JlLmMNCj4gPiBpbmRleCBj
OThlNTJmZjVmMjAuLmY2YWYzYWMxZWYyMCAxMDA2NDQNCj4gPiAtLS0gYS9hcmNoL3g4Ni9rZXJu
ZWwvY3B1L3Jlc2N0cmwvY29yZS5jDQo+ID4gKysrIGIvYXJjaC94ODYva2VybmVsL2NwdS9yZXNj
dHJsL2NvcmUuYw0KPiA+IEBAIC0xMDAsNiArMTAwLDE4IEBAIHN0cnVjdCByZHRfaHdfcmVzb3Vy
Y2UgcmR0X3Jlc291cmNlc19hbGxbXSA9IHsNCj4gPiAgCQkJLmZmbGFncwkJCT0gUkZUWVBFX1JF
U19NQiwNCj4gPiAgCQl9LA0KPiA+ICAJfSwNCj4gPiArCVtSRFRfUkVTT1VSQ0VfU01CQV0gPQ0K
PiA+ICsJew0KPiA+ICsJCS5yX3Jlc2N0cmwgPSB7DQo+ID4gKwkJCS5yaWQJCQk9IFJEVF9SRVNP
VVJDRV9TTUJBLA0KPiA+ICsJCQkubmFtZQkJCT0gIlNNQkEiLA0KPiA+ICsJCQkuY2FjaGVfbGV2
ZWwJCT0gMywNCj4gPiArCQkJLmRvbWFpbnMJCT0NCj4gZG9tYWluX2luaXQoUkRUX1JFU09VUkNF
X1NNQkEpLA0KPiA+ICsJCQkucGFyc2VfY3RybHZhbAkJPSBwYXJzZV9idywNCj4gPiArCQkJLmZv
cm1hdF9zdHIJCT0gIiVkPSUqdSIsDQo+ID4gKwkJCS5mZmxhZ3MJCQk9IFJGVFlQRV9SRVNfTUIs
DQo+ID4gKwkJfSwNCj4gPiArCX0sDQo+ID4gIH07DQo+ID4NCj4gPiAgLyoNCj4gPiBkaWZmIC0t
Z2l0IGEvYXJjaC94ODYva2VybmVsL2NwdS9yZXNjdHJsL2ludGVybmFsLmgNCj4gPiBiL2FyY2gv
eDg2L2tlcm5lbC9jcHUvcmVzY3RybC9pbnRlcm5hbC5oDQo+ID4gaW5kZXggNWViZDI4ZTZhYTBj
Li5mZGJiZjY2MzEyZWMgMTAwNjQ0DQo+ID4gLS0tIGEvYXJjaC94ODYva2VybmVsL2NwdS9yZXNj
dHJsL2ludGVybmFsLmgNCj4gPiArKysgYi9hcmNoL3g4Ni9rZXJuZWwvY3B1L3Jlc2N0cmwvaW50
ZXJuYWwuaA0KPiA+IEBAIC00MDksNiArNDA5LDcgQEAgZW51bSByZXNjdHJsX3Jlc19sZXZlbCB7
DQo+ID4gIAlSRFRfUkVTT1VSQ0VfTDMsDQo+ID4gIAlSRFRfUkVTT1VSQ0VfTDIsDQo+ID4gIAlS
RFRfUkVTT1VSQ0VfTUJBLA0KPiA+ICsJUkRUX1JFU09VUkNFX1NNQkEsDQo+ID4NCj4gPiAgCS8q
IE11c3QgYmUgdGhlIGxhc3QgKi8NCj4gPiAgCVJEVF9OVU1fUkVTT1VSQ0VTLA0KPiA+DQo+ID4N
Cj4gDQo+IFJldmlld2VkLWJ5OiBSZWluZXR0ZSBDaGF0cmUgPHJlaW5ldHRlLmNoYXRyZUBpbnRl
bC5jb20+DQoNClRoYW5rcw0KQmFidQ0KPiANCj4gUmVpbmV0dGUNCg==
