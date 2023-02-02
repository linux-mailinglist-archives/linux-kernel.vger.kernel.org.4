Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D55E6887C3
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 20:49:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232359AbjBBTtT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 14:49:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232341AbjBBTtQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 14:49:16 -0500
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98E726D064;
        Thu,  2 Feb 2023 11:49:13 -0800 (PST)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 312JOa8b002991;
        Thu, 2 Feb 2023 11:49:12 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=tEhdH4bcnfbDUunox4unFNP/qML57HKW1sCBlMsAQK8=;
 b=EXm4b37Xl1So0A1PJcOD3NRpluNNlL9FeyFcla1uETengwlJ9ce6qBGWbT2g3q3gjyLv
 YnPrCxYEZxkc6h876ljKLYZmhQ/DsWZQz6zu4KYiGA87zCQpXLcjOazzVa5E59clWVnQ
 9u1AQOI9NojJ4PbwBUn9eXJKX3Dd8EKKOFvwDFA0WrTDW5YUhec3STJrfYUvFVdGfF2l
 PK04mThKq2MWJqePWUuGtBA+zbZPgWcANQ25lDBBKYEU05wgRGzhalwS+DnJfcS2361M
 Ukg6sS9NzsXFlQ/wBYWebA/JEfFiJmAebKYXO9g0f/SodqbLZZGoWCzTFrIzGtcRlil5 /g== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2109.outbound.protection.outlook.com [104.47.58.109])
        by m0001303.ppops.net (PPS) with ESMTPS id 3nfq37umjs-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Feb 2023 11:49:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lzghbPVyTwoCl3uP71PLbxeq9sEmpfRTd7+r+vXkCY0UoOvZo8glbR2U/3Udci4PE4gSVSe+HjeE2h4KJd0wvwgyF1bnRUAQ5zJPObpYUI/jhchosygzPwPOSOd92+eugseXmzR+RxxzEu6023+HTIo2cal6vLOgguZxVJOTr4Ur10TICXtvQ6OE0c+TmLdANt1f1/6zTGXn6y1vw+l97GTLx6pRTTHZQX929awlWfNWunLOXOgKYRveIuKH34xz1cD4eNzVQpsl506JDBAXXA6hiI0Y9FpyvIi+Gr7d+Z1tKEq0xeH/25oLgAUqLj0lzzlvLQcL7uUuBTfI7+2GGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tEhdH4bcnfbDUunox4unFNP/qML57HKW1sCBlMsAQK8=;
 b=Kz3Z5sa2jyZybRl8TGSMDE0RwavI3h4nMbrmRw41OktvZxghDbSPV6vsVlV2kBm1S9u5fLKiKIHijbH2VgGeLBmt/qG0OsFA4shEyxO2C8fqNQ2YgBfzodioMBqAZjNNSdlcxhBSd56buSOR3Ey+uPHI3xO4LEmgSn8u6E9JCu3/05pEiHj9Pta7WlcIEjdHiEnDv4774tavh2YEQDUvC8rk9baI52R/N0uO0B60OVcnAgUMSo+awE17MKogqFQhiDljrTnElvRl6dfosjVFfeUwZiiQ0ZBjddDqy8jhv5jGxy1mblAAE25vyy2ZXcgj7hHKMl2tFduNEviZSShsyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by SA1PR15MB5818.namprd15.prod.outlook.com (2603:10b6:806:332::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.22; Thu, 2 Feb
 2023 19:49:10 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::7b61:8691:5b41:ecf8]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::7b61:8691:5b41:ecf8%4]) with mapi id 15.20.6064.028; Thu, 2 Feb 2023
 19:49:10 +0000
From:   Song Liu <songliubraving@meta.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
CC:     Song Liu <song@kernel.org>,
        "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hch@lst.de" <hch@lst.de>, Kernel Team <kernel-team@meta.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v8] module: replace module_layout with module_memory
Thread-Topic: [PATCH v8] module: replace module_layout with module_memory
Thread-Index: AQHZNo0jQ4G0IQtJoUqMmWovp5j+4K67QVkAgADQVYA=
Date:   Thu, 2 Feb 2023 19:49:10 +0000
Message-ID: <9904D980-B5F6-4DA6-8313-693E0CD8463C@fb.com>
References: <20230201223219.355006-1-song@kernel.org>
 <1559bd58-0cc7-e643-ff0f-7be5e39992f1@csgroup.eu>
In-Reply-To: <1559bd58-0cc7-e643-ff0f-7be5e39992f1@csgroup.eu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.300.101.1.3)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5109:EE_|SA1PR15MB5818:EE_
x-ms-office365-filtering-correlation-id: 80e6e1bd-2787-4bf7-e5d1-08db05568d89
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tEFxKRLWSvXIIYYsSdRkg1QZycHsop642I7HJbT85vRNRSdaVwLWw9EjpNDwAvG2IVY/zRr55qn0Wv7drBf7ZBnb++cunXxUacmJ7YwHyq5OdwbQJW+M/BYomBaCT2RRBuLQuAgiQ5f2H2fwjFJp7/DZZNWxCPrZD0FtKF7LpZwMhWt7BSoEUGt4fozvndgrd+8PNxYdvGvH74V7n/7pIoH2WrmKASJG0+N4s5uysx8Hc44MRCivtZ0pDEv0LzfC2z9+JBOU5/3zt/fymQ1j3DIz2KEL4uhXjx4qtFBFZr1pQ+2BLfyxF1llDO07+rcJ9xIDB2ZrtcDqCLr7EbA3s6BRqPfMN61wNGptKUkxTWH8LlJCmioLvAEmbA8tC/bUcsFqsD8K4nTzB+rrhpxWg9AS5AE4/Q4QWXCep66OIngC0/fMaAbLplQqWLWnkUbu3k8HCg4jAqRHRDAEG6qtri6qrEbtqzqSO0OFDKZ4ksHlAogg+LYWyA5QjDRFv00cads+u+9TqN8uNK9DgaEC8dw23WVqrrYoWdaoWEdBoE4EIgHOTtpjWxHIj3zxSyM1JH0DH4zAwiJO8kH/5iEThu4yqR2b4dUY43guGJikP2iOmRO4F/T8+GTCCo+gqXb1hZKdEXHuLAd3uCfxWAiY6GU+D3YxwkLJprObceIrYnXyH4dLcrtBajJ0aZy//HCJfKrJbzml686DEhvPuHs7ig==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(366004)(39860400002)(136003)(396003)(346002)(451199018)(53546011)(33656002)(6506007)(83380400001)(38070700005)(86362001)(36756003)(6916009)(6512007)(122000001)(186003)(71200400001)(9686003)(316002)(54906003)(91956017)(4326008)(8936002)(41300700001)(76116006)(66476007)(478600001)(64756008)(5660300002)(8676002)(6486002)(66946007)(66446008)(38100700002)(66556008)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VlFhclhFV2tXbndxSHgvTk5OSXhxNW1YZytBdWJEMFllcFVXWDV5UVlPWWxN?=
 =?utf-8?B?TlpOU3JWc2s4Qm03TzVMQnBUOWJ1Z2VaeXRtYk4xd2ZCRWptVExHWDRKcTJX?=
 =?utf-8?B?Y2N1a0NMZlc0YTFGcjAxYVB6MVVzTm1vMnpXeDV4UjVMbmYxTThvS3BsN0Zv?=
 =?utf-8?B?TEVZTVVKMnlabk9iaDgwVzVsSFRKSGhkZnF6d3FGcnlEaUUvYnpHV1VFS2ta?=
 =?utf-8?B?bStvRWR1bFFpb0plSEoyaDRqM1p5UTI1LzRIaEZVMlpjS2xxdTc4Z1JxVUl4?=
 =?utf-8?B?ckJ4K2xXeE5qaS9kakVwbG1GcjJSRXBFYnZrRjB6SWVheThKb0pZc1R4WUs2?=
 =?utf-8?B?R3BXYjY0OFZmWHJ2K1prZndVMkpIQzBCREc4RGxjcVhjU012Q1B3eThjdFlV?=
 =?utf-8?B?SDdJOHozMjNzL2lxNnlxaFMycVBBTmVLTHhZdm5jZEpJdklFZzZZTkFubHVt?=
 =?utf-8?B?ZmNyYXE4bEZST1U5RklmZjZXaGtuSkpEOCtFaVh6V2NQK3hDbThPZXF1YUlx?=
 =?utf-8?B?SmtaQTkzeGdITnVEbG10eHJpVkFoUTNXS3BLRkxnWlB0UHozY3pJUmh3OGhE?=
 =?utf-8?B?NHZSaVF3dDcwb01UZ3RUUzdpbDR6QVFRcXNqejY2QUNmdzEyMEZPdnoyU1Fp?=
 =?utf-8?B?QkdVY2tVVHkwZDUvQjZCTGVLWHJZSlNyN09HTitXZUhGV0hYVW1tUlpuVGtw?=
 =?utf-8?B?SEJKV1ZqV0VyREFvMmtJZ1oyVlMxZjVMSG1YcTFISGJWRDEvMnVuVmdSQm9H?=
 =?utf-8?B?WGtTK1Fnam1xQ08zT05IVlF2ZGhiYk8zTmUyeTdDNTJSZFN1c1RNMXNySUpC?=
 =?utf-8?B?dDF3TnVMdE5WOHMzbnVneXFYQjl3OWcxdkp6WERja2VmVHBHMU5oUEZKZEVP?=
 =?utf-8?B?emFEcVdoVUZBaElLWmUzdnBNN0FBdzBYWExMWmR0MlB6aTQ0WnVLSUhNRE5T?=
 =?utf-8?B?THBIQmhJU2lVZzYwNlNGL3prQ1AzelhhZFVIQnB4U3gzUitmZ2p6N2lpWXBh?=
 =?utf-8?B?RFZHUFhuczJzaVhwbDR3Qml6YjFxYjNuYTJyQ3lNU0ttakNCQUNwWDc5Q0wx?=
 =?utf-8?B?SFpRVEhkM1d5dUJmK0R4NzdMUW93c1hFa2hCZ2N1SEIxcHZ1eEF1UERnUUd5?=
 =?utf-8?B?ZzlUTmdlUXZsUmY4SCt4VThNcWFaQlRuRFNETGFwMDlNczl0Z2E5REJqbWFZ?=
 =?utf-8?B?M3k0SmFvQ3VOTStDZlM2OG9lWjhHcWp5SXBwZHBkVWNoUnZvNlhibElDK2Mx?=
 =?utf-8?B?RDVzRHpnU05lTnVjZG9GaTM0OStwa0JnUjY3VlhVUzZPWGVnYkttcXQ1cmVC?=
 =?utf-8?B?bm5qU1RpdmNzM3ZGRDhEWXlGQkFDbXd5RXhmZ2NyOFVSaGdhRDdqdFB4MDhz?=
 =?utf-8?B?SzlBRFBSMUxzZkxhSGY2M0V2MjBmaXIxWnNseHFDYy9Mbm81djgrTTNCamZ4?=
 =?utf-8?B?TzFvRnVGTVRkcmNLeGc5ang0OFdaWGg1eWMyaGo1elhGaVNLL3dhSG9Ob0Qz?=
 =?utf-8?B?bU52ZEJQdEhsZk5oVFBIV3llMG1KRE9WbmNRSFFJOVE5RlNsLzNNWEJoZVQx?=
 =?utf-8?B?YTBQb0pzTkltV1l6aW1VWW1ROVp1QWN5QzdnUUIzYUdFQ1kvMCt5a0JtMnls?=
 =?utf-8?B?czZHTXdsNy9XTmtuYmZwRFRqM3JjaWVIa056MENCblFZckozRWhEemNoUjRq?=
 =?utf-8?B?OUliZ3EyNEhmdFJrNXFjSkE1clU1cVl6dXdKZ05zWmxkVzIxeDM4RU5IeTdP?=
 =?utf-8?B?aWNHd1RRZlc3Ukd1a0VPUXphRnJSd2oxVEFuaElOZGJ4WHhrUUExbldyN1FF?=
 =?utf-8?B?VmdndVVVSUpLOFUrNDM5R1JaaHo3WnRtZFdHKzljOENtYVJsV0VmRzQyZVBs?=
 =?utf-8?B?OUFZbUZUc1ZiOTZmdUwvQTdxc0NUcURsTjE0S2owU1kycERpb2diSVNqbVZY?=
 =?utf-8?B?RVlQc0VkM2pES3o5WU9qMzBaNXhTTVhXUDRQWHRXYk9MKzRMRDdBL0JPcFl1?=
 =?utf-8?B?Z1BnbU9sUHIyZC91UnJQR20yNFgxUjhESGRLeGhpUm5lRVh4dXlSRlZxKzJH?=
 =?utf-8?B?SXBPQk9seGd0SnJIalkxbjRkZ2tobWovNUhlbDdGaFNRQVViVTFxYTVxTk5U?=
 =?utf-8?B?azdRTGJJNjFrVTk1eEZPUldPUE83eDJPVCtlSEM1QUIvSkpWRkxWeEtTZE1Z?=
 =?utf-8?Q?FGch/48WaM8sAF1zFnjaEHA+1YXi26M2Fc1zO7jb8aAN?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F40C916FAA99EA46BB965C8A8A53CB10@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80e6e1bd-2787-4bf7-e5d1-08db05568d89
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2023 19:49:10.2851
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rLXOvG4kxZlEW72Qna3+TE45q5OzqqgtkjQFKSg9YVgdjk8DXXtZES1E9Y4UFE2C9k8Ah5Q0P4PtMpiuyshipA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB5818
X-Proofpoint-GUID: P-jPn2KWeeGYF7vjoGXq5ao-ZEBJMPGZ
X-Proofpoint-ORIG-GUID: P-jPn2KWeeGYF7vjoGXq5ao-ZEBJMPGZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-02_14,2023-02-02_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gT24gRmViIDEsIDIwMjMsIGF0IDExOjIzIFBNLCBDaHJpc3RvcGhlIExlcm95IDxjaHJp
c3RvcGhlLmxlcm95QGNzZ3JvdXAuZXU+IHdyb3RlOg0KPiANCj4gDQo+IA0KPiBMZSAwMS8wMi8y
MDIzIMOgIDIzOjMyLCBTb25nIExpdSBhIMOpY3JpdCA6DQo+PiBtb2R1bGVfbGF5b3V0IG1hbmFn
ZXMgZGlmZmVyZW50IHR5cGVzIG9mIG1lbW9yeSAodGV4dCwgZGF0YSwgcm9kYXRhLCBldGMuKQ0K
Pj4gaW4gb25lIGFsbG9jYXRpb24sIHdoaWNoIGlzIHByb2JsZW1hdGljIGZvciBzb21lIHJlYXNv
bnM6DQo+PiANCj4+IDEuIEl0IGlzIGhhcmQgdG8gZW5hYmxlIENPTkZJR19TVFJJQ1RfTU9EVUxF
X1JXWC4NCj4+IDIuIEl0IGlzIGhhcmQgdG8gdXNlIGh1Z2UgcGFnZXMgaW4gbW9kdWxlcyAoYW5k
IG5vdCBicmVhayBzdHJpY3Qgcnd4KS4NCj4+IDMuIE1hbnkgYXJjaHMgdXNlcyBtb2R1bGVfbGF5
b3V0IGZvciBhcmNoLXNwZWNpZmljIGRhdGEsIGJ1dCBpdCBpcyBub3QNCj4+ICAgIG9idmlvdXMg
aG93IHRoZXNlIGRhdGEgYXJlIHVzZWQgKGFyZSB0aGV5IFJPLCBSWCwgb3IgUlc/KQ0KPj4gDQo+
PiBJbXByb3ZlIHRoZSBzY2VuYXJpbyBieSByZXBsYWNpbmcgMiAob3IgMykgbW9kdWxlX2xheW91
dCBwZXIgbW9kdWxlIHdpdGgNCj4+IHVwIHRvIDcgbW9kdWxlX21lbW9yeSBwZXIgbW9kdWxlOg0K
Pj4gDQo+PiAgICAgICAgIE1PRF9URVhULA0KPj4gICAgICAgICBNT0RfREFUQSwNCj4+ICAgICAg
ICAgTU9EX1JPREFUQSwNCj4+ICAgICAgICAgTU9EX1JPX0FGVEVSX0lOSVQsDQo+PiAgICAgICAg
IE1PRF9JTklUX1RFWFQsDQo+PiAgICAgICAgIE1PRF9JTklUX0RBVEEsDQo+PiAgICAgICAgIE1P
RF9JTklUX1JPREFUQSwNCj4+IA0KPj4gYW5kIGFsbG9jYXRpbmcgdGhlbSBzZXBhcmF0ZWx5LiBU
aGlzIGFkZHMgc2xpZ2h0bHkgbW9yZSBlbnRyaWVzIHRvDQo+PiBtb2RfdHJlZSAoZnJvbSB1cCB0
byAzIGVudHJpZXMgcGVyIG1vZHVsZSwgdG8gdXAgdG8gNyBlbnRyaWVzIHBlcg0KPj4gbW9kdWxl
KS4gSG93ZXZlciwgdGhpcyBhdCBtb3N0IGFkZHMgYSBzbWFsbCBjb25zdGFudCBvdmVyaGVhZCB0
bw0KPj4gX19tb2R1bGVfYWRkcmVzcygpLCB3aGljaCBpcyBleHBlY3RlZCB0byBiZSBmYXN0Lg0K
Pj4gDQo+PiBWYXJpb3VzIGFyY2hzIHVzZSBtb2R1bGVfbGF5b3V0IGZvciBkaWZmZXJlbnQgZGF0
YS4gVGhlc2UgZGF0YSBhcmUgcHV0DQo+PiBpbnRvIGRpZmZlcmVudCBtb2R1bGVfbWVtb3J5IGJh
c2VkIG9uIHRoZWlyIGxvY2F0aW9uIGluIG1vZHVsZV9sYXlvdXQuDQo+PiBJT1csIGRhdGEgdGhh
dCB1c2VkIHRvIGdvIHdpdGggdGV4dCBpcyBhbGxvY2F0ZWQgd2l0aCBNT0RfTUVNX1RZUEVfVEVY
VDsNCj4+IGRhdGEgdGhhdCB1c2VkIHRvIGdvIHdpdGggZGF0YSBpcyBhbGxvY2F0ZWQgd2l0aCBN
T0RfTUVNX1RZUEVfREFUQSwgZXRjLg0KPj4gDQo+PiBtb2R1bGVfbWVtb3J5IHNpbXBsaWZpZXMg
cXVpdGUgc29tZSBvZiB0aGUgbW9kdWxlIGNvZGUuIEZvciBleGFtcGxlLA0KPj4gQVJDSF9XQU5U
U19NT0RVTEVTX0RBVEFfSU5fVk1BTExPQyBpcyBhIGxvdCBjbGVhbmVyLCBhcyBpdCBqdXN0IHVz
ZXMgYQ0KPj4gZGlmZmVyZW50IGFsbG9jYXRvciBmb3IgdGhlIGRhdGEuIGtlcm5lbC9tb2R1bGUv
c3RyaWN0X3J3eC5jIGlzIGFsc28NCj4+IG11Y2ggY2xlYW5lciB3aXRoIG1vZHVsZV9tZW1vcnku
DQo+PiANCj4+IFNpZ25lZC1vZmYtYnk6IFNvbmcgTGl1IDxzb25nQGtlcm5lbC5vcmc+DQo+PiBD
YzogTHVpcyBDaGFtYmVybGFpbiA8bWNncm9mQGtlcm5lbC5vcmc+DQo+PiBDYzogVGhvbWFzIEds
ZWl4bmVyIDx0Z2x4QGxpbnV0cm9uaXguZGU+DQo+PiBDYzogUGV0ZXIgWmlqbHN0cmEgPHBldGVy
ekBpbmZyYWRlYWQub3JnPg0KPj4gQ2M6IEd1ZW50ZXIgUm9lY2sgPGxpbnV4QHJvZWNrLXVzLm5l
dD4NCj4+IENjOiBDaHJpc3RvcGhlIExlcm95IDxjaHJpc3RvcGhlLmxlcm95QGNzZ3JvdXAuZXU+
DQo+PiANCj4gDQo+ICAgQ0FMTCAgICBzY3JpcHRzL2NoZWNrc3lzY2FsbHMuc2gNCj4gICBDQyAg
ICAgIGtlcm5lbC9tb2R1bGUvbWFpbi5vDQo+IGtlcm5lbC9tb2R1bGUvbWFpbi5jOiBJbiBmdW5j
dGlvbiAnbW9kX21lbV91c2Vfdm1hbGxvYyc6DQo+IGtlcm5lbC9tb2R1bGUvbWFpbi5jOjExNzU6
MTY6IGVycm9yOiBpbXBsaWNpdCBkZWNsYXJhdGlvbiBvZiBmdW5jdGlvbiANCj4gJ21vZF9tZW1f
aXNfY29yZV9kYXRhJzsgZGlkIHlvdSBtZWFuICdtb2RfbWVtX3R5cGVfaXNfY29yZV9kYXRhJz8g
DQo+IFstV2Vycm9yPWltcGxpY2l0LWZ1bmN0aW9uLWRlY2xhcmF0aW9uXQ0KPiAgMTE3NSB8ICAg
ICAgICAgcmV0dXJuIG1vZF9tZW1faXNfY29yZV9kYXRhKHR5cGUpOw0KPiAgICAgICB8ICAgICAg
ICAgICAgICAgIF5+fn5+fn5+fn5+fn5+fn5+fn5+DQo+ICAgICAgIHwgICAgICAgICAgICAgICAg
bW9kX21lbV90eXBlX2lzX2NvcmVfZGF0YQ0KPiBjYzE6IHNvbWUgd2FybmluZ3MgYmVpbmcgdHJl
YXRlZCBhcyBlcnJvcnMNCj4gbWFrZVszXTogKioqIFtzY3JpcHRzL01ha2VmaWxlLmJ1aWxkOjI1
Mjoga2VybmVsL21vZHVsZS9tYWluLm9dIEVycm9yIDENCj4gbWFrZVsyXTogKioqIFtzY3JpcHRz
L01ha2VmaWxlLmJ1aWxkOjUwNDoga2VybmVsL21vZHVsZV0gRXJyb3IgMg0KPiBtYWtlWzFdOiAq
KiogW3NjcmlwdHMvTWFrZWZpbGUuYnVpbGQ6NTA0OiBrZXJuZWxdIEVycm9yIDINCj4gbWFrZTog
KioqIFtNYWtlZmlsZToyMDI0OiAuXSBFcnJvciAyDQoNCk9vcHMuLiAgDQoNCkxldCBtZSBnZXQg
dGhpcyB0aHJvdWdoIGJ1aWxkIHRlc3RzIGJ5IGtlcm5lbCB0ZXN0IGJvdC4NCg0KVGhhbmtzLA0K
U29uZw0KDQo=
