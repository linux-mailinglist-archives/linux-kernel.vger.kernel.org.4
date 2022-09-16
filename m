Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDEA85BB295
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 21:00:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbiIPTA2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 15:00:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiIPTAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 15:00:23 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2078.outbound.protection.outlook.com [40.107.223.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 752A42A422;
        Fri, 16 Sep 2022 12:00:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aVaR0wqzLmD0Law6VJbu81PZBajZ6hT+wKyoDOxphZS1jsPxasb4ha8j3ZpUyLGJBNZ6GEiLtOU1rShW9AEdWvanDfXCnqEC3OQ6vcxZR5kGCgj/z0c4FqCKd5j88mqc5kqWIiXkSfro0LrVkUthIvpvaNn6csbWStA7eU8hOqOBJ5auax+v6YQkvVpXYTQQbTgDoox62H7q7wkP9Szv5+RjeZxa32Ci6Bs4WZ3HmmgEYfASLEirF7bvjBIeZ8FQKGTpjECfzoXvkG720M/yZRACvv2x8C5uqGDBe//VKK6m6ezl2NCX1thB8weIeNI5jbu72albiPL07OXfkQDOcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y+ndTJs8Zmrn50hzjgrZueaxbYCFIsrynrYNXhEL7wQ=;
 b=GbA1NWtvMALYwGSaocRJfOeAZIm6uGqj8h6D8BYmroBGO2IY0VlSIzIoh9xxwCDMr1qVtWue5rOj+RCOWwImhTrmND2rQSWyGYenDpqUmm+nhw+EB9OmAPOMoGrMNYbwtbJZR01amr6BzYP1Nx6kvHD6A1VEJORjpwt50oeA6uUyy8NsyDNETBPbTzUawQs3y/EBcaxAtj+6XSxM5Zms+327JZ7TOZiEwM2B3TNX6Nnc8Zm6eVMn+2Q5n3QPhDq00KToSFWua0GN92kT/gPXsGWconuaRwi9X4llyseV3g0Ry5oAvLeChyWMs3VwqWQek3wU1UunHDX9PXJ9uLueHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y+ndTJs8Zmrn50hzjgrZueaxbYCFIsrynrYNXhEL7wQ=;
 b=XMMDgXHeKAmRBEJ5ng5KufHAcvcEDUHgwJt+JFc8OlBp7LGpOSqBYj2Xr/eKDjNQRiqQlt3xmp8QFqxcmi9K6+jcHw/V1US6ttf3E11wQaXINBMdq6Nz6zYb7/FQoo5sReb3oX31C4QkulugjRDzsqP3casmBTaZ05RYhISW0J4=
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by DM4PR12MB6253.namprd12.prod.outlook.com (2603:10b6:8:a6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Fri, 16 Sep
 2022 19:00:19 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::4120:60cf:46a8:7109]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::4120:60cf:46a8:7109%7]) with mapi id 15.20.5632.016; Fri, 16 Sep 2022
 19:00:19 +0000
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
Subject: RE: [PATCH v4 02/13] x86/resctrl: Remove arch_has_empty_bitmaps
Thread-Topic: [PATCH v4 02/13] x86/resctrl: Remove arch_has_empty_bitmaps
Thread-Index: AQHYwuO1w+tLkqVyJkqdomRHxrsyfa3iQy4AgAA0CXA=
Date:   Fri, 16 Sep 2022 19:00:19 +0000
Message-ID: <MW3PR12MB455342442B9A72C9D555855895489@MW3PR12MB4553.namprd12.prod.outlook.com>
References: <166257348081.1043018.11227924488792315932.stgit@bmoger-ubuntu>
 <166257360370.1043018.10126722515228365580.stgit@bmoger-ubuntu>
 <4d79d134-c6e9-3e98-e670-5870eff44153@intel.com>
In-Reply-To: <4d79d134-c6e9-3e98-e670-5870eff44153@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-09-16T18:59:50Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=7d1d7efc-ef22-439e-85b3-f4776eb0351f;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-09-16T19:00:17Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 9f62e7d8-8579-4a4a-9a49-38d521d3a2ab
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW3PR12MB4553:EE_|DM4PR12MB6253:EE_
x-ms-office365-filtering-correlation-id: 761c06bf-534a-4d2e-d8af-08da9815b31c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: J638LWbYk7dtVml51kKdXyPvJ9wUrzvkslIUeRTdFdndThLgoyw7xZJ6eu00dB+f2fzPjqk1LWzdRx7xiwbU+tgu9+sBv10XJfDFd70kMHP4ZxdHXJhu8JgLgZVlLYjgWLoHyaVfU/AJlse0TMEq8F7df1rLWJAXDHEROWyvX+UCbTivV7h6GB+IINFwzbPDZC0WinZzewjTrJfvrrCBjYoQFRDakOhkIonLMaCKfpAPoXTnzOeQOTTNQyrM8qrzty7So7oxPlRZRx/e+OK2OzEVxRlD9baa3xfYFKF/8LjanV3GdIUKoCi57RXXoJcticieNczkqg0unDMOe2o0TGzcrer2YRxV744e8UnAF4hQEUtpk5Bg2s6xsJWopU3/yNYQSnGpxrtmOkrRhAQZDAFWqcn71ajPoJrTeMgKjRCqmUzsP4TGFCQaYLE0pdNV9AnsmLhuE6CQ83FKFyZV8JaSfxZ6H1kqCmQb2yQgUYD22/zOj9saXMlwo/SChvZ9w7I5tnN1O9uh28I3Zt0Ax1HsFpL7JMV8wptlN6dDmcKUwIHpKbVP9N2d8qm6ACvPXqpET1WiEElKyT7VykTUaqgEWVkjQtirNtqzGrtXam9HI3pT2PDFkIwV1pRCIl/lSfroyT6ysVFD3Hq0nJaP9q8qtOWXB/7djQ2hEMP5VwqjZjyR7u/kaAOuH9F84+lk8++WfVRqm1snk7gfq8OxracmlGaR6grvDd7HDK0c6WAfCTIFwAWBbgRJjt2nl/8SRdiCBFzUc0sWSKwTYxa+IQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(346002)(396003)(39860400002)(366004)(451199015)(38100700002)(5660300002)(110136005)(64756008)(66446008)(38070700005)(71200400001)(8676002)(54906003)(86362001)(7416002)(33656002)(66556008)(8936002)(83380400001)(122000001)(9686003)(66476007)(316002)(186003)(55016003)(41300700001)(26005)(76116006)(52536014)(6506007)(53546011)(7696005)(2906002)(4326008)(66946007)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Qytta04rYjVvdk5yWHV4eFNGVzFpaU54RnpzOHN4amR2WFYzSEJ1d1NsWjhK?=
 =?utf-8?B?QlpqUVI3OXgrVTlZSXJMMnY4aUExZ0E3SGFLM3dSaVlLMlZYQTdIYVNsWVpC?=
 =?utf-8?B?VFg2Y0EvNUs0V0NCVUFVak5ucWtqY1hBck5Dc1dEbWtLclNoRldWZUs0ZkFn?=
 =?utf-8?B?TVMrTEtwWGJlbm9HL0toc3lMSXMxRzRKWUROM1ZZMkt0U0JwMmc2Y05kQUx4?=
 =?utf-8?B?azJrdGtrbDFNb2o1WmdPVUNtYkRPait5OE50bzVyc3JTMHhUKzJFdmlZZ2Na?=
 =?utf-8?B?eXZWMGJmL3RXaXBVeGVmRFVtVjdzT0U4WkJ1Ym5kRmxxTmZDZzYyZVBrd0NI?=
 =?utf-8?B?ejFHR28yYnd1ZFk2NmMrMEIrNk1UWFRUZkUwblRiUHZtY3I0OWFoMk90WnZ1?=
 =?utf-8?B?L1RsU1FWRDBscGNkV01uUm9DdXJRZnpRYmlYTGFkN1FFbW9NdHZyTCtzSkpQ?=
 =?utf-8?B?UFF3ZENDUFZQWWpYY2txaGRNVm1XN1docUdPNEtML1RGU2VKSDNYR2ljYTZ6?=
 =?utf-8?B?ckFuYS8vT1pucldPQVpPUlBjczZNYytPamVWQUt2VitleXFGaEhNRmFmb3Ri?=
 =?utf-8?B?NC8yMElSU1paTFJKbG54NTVsS1g2amxnZy9XWkFhNlhTekZhc0ZpRy9kL2lj?=
 =?utf-8?B?WkRhaGdmVGZEYU94Q1hIM2FrTzQrQTVibUxoL2lJMVEycW93eHZuRmFkREl5?=
 =?utf-8?B?QWhRaEYxeTN1SG9Ydy91NEd5U0o4RzR1MktYMGRDZmhyVURNVkM0NFdXUGty?=
 =?utf-8?B?QUJpT1FhakpsZXlEUURCVWVlNGhlK1dwellOcGczTDhsMm4yajJnK3YvTEg2?=
 =?utf-8?B?NnVxTHc2SUNRZkVTb0JjSEVsTHdEVmZTTDBua0dkOTZkU3hzQnU2WStXSjV5?=
 =?utf-8?B?OGFIOWJrTjFDNXRqYUd1czJEWWEzTDc5M2MzWm4yZ1Rrc20yTUNTWEtoOXJM?=
 =?utf-8?B?ckpYOHNPUjFCOGFQWVhla2NnRnZlTE1hU1UrSzJNYWViMWRiTktXNTFpSEgv?=
 =?utf-8?B?QWpwSE9MQUk1SXJ5QU5xWDJ6cUhna3Y0cG5ObzU5QnFYc0N6NVBqektha0Y1?=
 =?utf-8?B?SnJaNlFySkRTc0FZTXAxQkNYOFNabFRET0dKeTNJN1ZjRTNlYlgvYllnb0dO?=
 =?utf-8?B?T2F4TXNZTk9XR0RyVE1CSzc0ekdyREJMVnlGb295ckE1S2FxdmQ4T0tPSXI2?=
 =?utf-8?B?cWxGVDU3VTFDeU8ydFVyb3E2MWRwM2FHRjYzZWYycjhJZFBlUFQ0WHh5VHUr?=
 =?utf-8?B?ZXVUUXNOZUlzbnM4bGtIajdyZlhDK0QrOHhwVnRPSGt1aU1IL3BWVUdhS1VN?=
 =?utf-8?B?R21sZXVNcTl5RytRamU2ZVVXRjRRbU9hOG9LVkFCQUh0WlV5TmtSYllJbGVp?=
 =?utf-8?B?ODljQnpjWE1WbkIvUjcySHNSTDhGVmt0SDBvZm00VXFzK3NpWHN2NkRwYjNj?=
 =?utf-8?B?cVJLb2QxMm5pQksxSzJNcEFhMFJuRWdPaEZXcW5acTViRGpwMTNXdi9UOStD?=
 =?utf-8?B?RVZGa1NPWEdKRDRieDZmbk53SjZBbUpEOHFiZC9kc1EwWEVXYWFKRnZTMTAy?=
 =?utf-8?B?RmJZTVBhVHpVYlNBYUJXU2sxd2t4NDRYRkNiMDRyMzBOVFZ0Z3kwU3JXeFR1?=
 =?utf-8?B?VXRXaDFqbGxxZm13MmZWd2o1ZWdydTFxUDZNNXNneGliRGhieWdhTXhyVVRS?=
 =?utf-8?B?MDBQVnloRGZHTjhkc1JyeWZwVlV5bnRUa2MvNUVCLzUzcFlETUhTTCtCM21L?=
 =?utf-8?B?d1lFd0pnNi9vaDNOL250TmczZmMzbzQrY2h6eXhHYjJpUzNYNTBsZDBXVXJH?=
 =?utf-8?B?SDNWcUE2T0krUXpqYnNqZTRFQ0FHMVVSMU55cExWb3RCbXZTV05Pc2ppbkFP?=
 =?utf-8?B?OVlQZ3g4Z29YQVJGdnBBVHlPeHpMcmVQc1NmUDNCNFJmeTdZZTNCRU9sVUNr?=
 =?utf-8?B?aTZ2ZVFDR3l1QUQwZVJhSTlHQjQ1a25OTis2YU1WOVFQUXBHencralhTWElh?=
 =?utf-8?B?UjczT2l5Zm43RkVPblF1b1JJanMrV0Z4dmNtd0RiWmd3cWxyRTFET3hoKzBl?=
 =?utf-8?B?WHV2SDNXVGR0emZGejNMdUZDTmU5WWVDMUd5SElmb3N0enJlMHlDNDFwUmUr?=
 =?utf-8?Q?A+to=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 761c06bf-534a-4d2e-d8af-08da9815b31c
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2022 19:00:19.2781
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3D4Zlpy/QZyeyBWHwYnI5DnZET1Mf4gUQatqU14zvwu8Br1Ra6mo2eJ4IQU/S85K
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6253
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
dGVsLmNvbT4NCj4gU2VudDogRnJpZGF5LCBTZXB0ZW1iZXIgMTYsIDIwMjIgMTA6NTQgQU0NCj4g
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
dWJqZWN0OiBSZTogW1BBVENIIHY0IDAyLzEzXSB4ODYvcmVzY3RybDogUmVtb3ZlIGFyY2hfaGFz
X2VtcHR5X2JpdG1hcHMNCj4gDQo+IEhpIEJhYnUsDQo+IA0KPiBPbiA5LzcvMjAyMiAxMTowMCBB
TSwgQmFidSBNb2dlciB3cm90ZToNCj4gPiBUaGUgZmllbGQgYXJjaF9oYXNfZW1wdHlfYml0bWFw
cyBpcyBub3QgcmVxdWlyZWQgYW55bW9yZS4gVGhlIGZpZWxkDQo+ID4gbWluX2NibV9iaXRzIGlz
IGVub3VnaCB0byB2YWxpZGF0ZSB0aGUgQ0JNIChjYXBhY2l0eSBiaXQgbWFzaykgaWYgdGhlDQo+
ID4gYXJjaGl0ZWN0dXJlIGNhbiBzdXBwb3J0IHRoZSB6ZXJvIENCTSBvciBub3QuDQo+ID4NCj4g
PiBTdWdnZXN0ZWQtYnk6IFJlaW5ldHRlIENoYXRyZSA8cmVpbmV0dGUuY2hhdHJlQGludGVsLmNv
bT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBCYWJ1IE1vZ2VyIDxiYWJ1Lm1vZ2VyQGFtZC5jb20+DQo+
ID4gLS0tDQo+IA0KPiBUaGFuayB5b3UuDQo+IA0KPiBSZXZpZXdlZC1ieTogUmVpbmV0dGUgQ2hh
dHJlIDxyZWluZXR0ZS5jaGF0cmVAaW50ZWwuY29tPg0KDQpUaGFuayBZb3UuDQpCYWJ1IE1vZ2Vy
DQo=
