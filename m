Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BED2743C69
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 15:10:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232437AbjF3NKH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 09:10:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232421AbjF3NKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 09:10:03 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2086.outbound.protection.outlook.com [40.107.92.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A03383A90;
        Fri, 30 Jun 2023 06:10:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dfZsYPc6nua1dhqX0nU9Cz1OA6Chrw8cEpVKtLSD02es/kdtDJ/7vshNj0jqDoM402RrOl1fUAfBxs0uJuUXrkQM95jIrt+c7YigLCXdDJdu4unJr9eVJ0SLIyscydiUo6mRCuvQ/xLSZ6Z4M5R9STXG0sjqcIUatBIlrbLLc5rDznkfOsODQliD3BwAGztXatHzVMg7nlShSWg5BxWbOv8JilJ9YvPf/vQVLDYbzG0Dygi9VxWgVBS5rnPXZib+W2q++VjiB8H/8G3lmPxjsC/rSxVw9zOkR34y0XqSdero6LjraaSYxhz0FuxKLE6Sk83odM+wwAaOdnfNK9r7rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RVWwOYSL5qg+gBk57zHaKyWE9i4KydpkpBoEgp0sQNU=;
 b=QufD6ma50c7LKfgseOwmfdJh8PEGNHb+kOLlk74nv8b0s/NSV/OnyHCSYb5oM7Mib4/8qHDUQcP+pSqFsT9/dR5EEYmgzvOllG0bm+vAOO0w8+IoJ75vTi+i3F1jwh5rrTEbriKXtuGvRWC6WWFhGU37xc8smaj5L7qx2TFO0a7Wn5+aHXxxUXkFnVdD7si28cViuk7ZLOVxqzAilWdzh+SYRD0ivxXWbPR0MloO1M500hdZAMRNDrNFq279z7K7kVYaXqpSzBVcXi0weAl8SdJkZMnM+yKEvORJ/FqmVo4IhkkP1ZjAloSi7sUW2hwtEd0LbjBiaRO2DY/7LM1AHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RVWwOYSL5qg+gBk57zHaKyWE9i4KydpkpBoEgp0sQNU=;
 b=on4L4B9hP4je72oSsrUr0hbuRZyyUlx5eskR4hCYLWV9/Mziht2hyFof7Nj7EjGI3Zmopf6f4JMij8cVtY/pT9sfV5AGUG6OD8wvLbiFmuq9fZAFpdUR+DPRDCy+K4ESaShWOeUb5TetISfN7wm5Cu6b6MrxQkzqRzwhHHqs6LI=
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SA1PR12MB6845.namprd12.prod.outlook.com (2603:10b6:806:25c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Fri, 30 Jun
 2023 13:09:58 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::dfcf:f53c:c778:6f70]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::dfcf:f53c:c778:6f70%5]) with mapi id 15.20.6521.026; Fri, 30 Jun 2023
 13:09:58 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     Linux regressions mailing list <regressions@lists.linux.dev>,
        Li Chen <me@linux.beauty>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-acpi <linux-acpi@vger.kernel.org>,
        Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: RE: [PATCH] ACPI: resource: Add IRQ override for MECHREV Jiaolong17KS
Thread-Topic: [PATCH] ACPI: resource: Add IRQ override for MECHREV
 Jiaolong17KS
Thread-Index: AQHZq1OcOcnD9B9faEaVRgwDdHvlo6+jUWLg
Date:   Fri, 30 Jun 2023 13:09:58 +0000
Message-ID: <MN0PR12MB610178FBE11426B042C61A24E22AA@MN0PR12MB6101.namprd12.prod.outlook.com>
References: <1890c3fa24c.d101fdf01298845.3731868257024939195@linux.beauty>
 <fed91877-6b55-efc1-76b3-e562f4c6914d@leemhuis.info>
In-Reply-To: <fed91877-6b55-efc1-76b3-e562f4c6914d@leemhuis.info>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=2ed9cbf0-7c84-4c65-85b8-b0dd81962fef;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-06-30T13:08:58Z;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB6101:EE_|SA1PR12MB6845:EE_
x-ms-office365-filtering-correlation-id: 979d8650-c871-4b7c-068d-08db796b4e60
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KuRu9nIkSIf0LmqFRYG3tFOYOEVLjf3UzuNFeQjCAffqr+vCVVNI5mFKlBvDfGj36ORGpNmyYtrIqYSqHIKL7v6wwFPSE7tNdj78kzg79z7YjaVKEe75Ufu2rdIPJwoEYl66OmNT7EWRt5HGMX+jDdrrnnsjKdaUfB8Go3K1k88+YGUGr/BQHDVtD013cDiyXFvjSvn1Sv1zcBikeJGKjdnxsNnxJg8hZ81z5eCiZNJlOR4Dk3UK50/XZ/oVpbU1s9Kx5aXgAzDljtWdGqGg5n7Iq4sRFGPRgr6BGvYLXiNa6MPAmllhbnoEvcB1FTRilt8uEb/am6H6KKRwJRLjB6o0I+w6/4H0uvrk9/88U8Xfu5ochVAthzVu36RK1BUjtvEiBI1RZSVdygTOIn38r+IxiOc5ghNboFBEFWLFOptxJ9hP0sYGFqPA1uiLzK1w4gg33T4r+25r+auKqaJNT9crYQJcp5hC3k8YrVDVngPzmg77SAQaTGY2eR/6v9zgkOqDSkmXblqcuiSAE/XYNLtM8gQqBpp6tq1E129gXH8/qoYu+t9KAoQ/SJPqKrfvb7+A56Ny8dfwYpp+RzBXyece0RQu7zmkO5/LdPOoPQA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(396003)(136003)(366004)(376002)(451199021)(53546011)(122000001)(66946007)(33656002)(5660300002)(86362001)(41300700001)(38100700002)(66476007)(8936002)(64756008)(66446008)(8676002)(316002)(38070700005)(66556008)(55016003)(76116006)(110136005)(966005)(478600001)(52536014)(9686003)(71200400001)(186003)(2906002)(6506007)(7696005)(83380400001)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MW5DdE1TbmdJbUM5SFREL1JCWExzRGdHbXY4MmdVTTRpNXV2UXA3V2VwazVZ?=
 =?utf-8?B?NkV6dWVrM1RhbkNOb2pTWDdjZ1RvM1d1T3lsT2dwMUhjNGw1UHBXVG9qS0ZS?=
 =?utf-8?B?VFd3MHM2MGR1MkNBR2tuS1hxWnc4Z3RnYkxadHFCWHB3Myt4RkFUOVNPOFM2?=
 =?utf-8?B?bXdBaVZhYnlPSjlKSGhhZFFhMVJMakZGWnpiclJoZ2FNa2FJTFArQk5WOXoz?=
 =?utf-8?B?SlZZYnc5RUE2VTV0L0REYTBBcCtNU1lqL2dmb3NjSTZrZEdBUk1jT3AwUmNU?=
 =?utf-8?B?MVJUaEtZMWk3VDY1YnVNQzl3Z3dTaUkyU29MRlZsSW8vWkNIdTlacmRkM3pB?=
 =?utf-8?B?Zm9qb0trQUJMNk9za0xLQjhmckVPN1JwSDY1QnJrMFVNNFNIYm1oR053djNv?=
 =?utf-8?B?c0pGUE5NYjBpZEk4MjVTbER3NCtNazZNeXc2dDVrK3FidFZhK1M3Y3R1RndY?=
 =?utf-8?B?MFkydGo5MThraTd5SzdXQTBDcjZzenFRNVNWcVlsNlFyVFMxSzJONkVzaUVZ?=
 =?utf-8?B?bEZ0YmxNYm9Ld2pGR2tnMC85TUREWXNsblUzOE5FS215Wm9TZVIxdzNRai93?=
 =?utf-8?B?bC9QUjNrckt2TUlmdjRGOWxXc2QwNzdmM3B0ZUluRGhkdGlFbW5yUjFNNVA3?=
 =?utf-8?B?MGxaalY2ZHNLWHRCRGxaREljNGNMd0duTUc4UzU5VGlXOEdQSmk5cEJ0d1VF?=
 =?utf-8?B?cFU4Z0tFd0FiZEVCb2IrUG1nVTF5aUF1Y0MyLzk0THdTYkROdldaVjlzNG5G?=
 =?utf-8?B?TFJrWHBJSVFHNVBhVEI4T3dzOVpCL1VyWTE2YmhUMktVcWczUkp6cThjNTdu?=
 =?utf-8?B?SnBhOG16L3YyOEloeGlNb2YzM25pa0xBTW0vY0NGeE9QYTlBdDVEbkEweW5N?=
 =?utf-8?B?Q3VZNEZjaXV5Nk9CcGplNFlZT0d6RUp3SjRjWFlManRBUUhQT2hER3B5cW95?=
 =?utf-8?B?UzFpclFsRSthV0Z1MFBJUGNtSlhUNUVhMTNRZTFCYUU0NUJkVnB1Vyt3TWx3?=
 =?utf-8?B?Y2p6RE56bVBGZ2Q4dHRUVjg2R1Y2WDFxTEtJVFBTN0QwSlpoc0VHUzB2elRZ?=
 =?utf-8?B?MlVoUDJYcElaN0Nmc05hYjcvMGhydTR4TUxxeWV2akZWclZtL09sV3lydlpw?=
 =?utf-8?B?U0pQQTJZZzBUeWluWGd4MHhJMzVxcHJCaXlUWjRoMGVVTHN3UTZKUGU5c3Jx?=
 =?utf-8?B?STBDTFNxVUt1WWtEelloQVpTY0lsNVJkcVM5U3Q1YnZiT3RSQkh6WS9SY0Vo?=
 =?utf-8?B?Qys5MHFBUTdTaFNxaXNsZnd3U0JoNFlBUnZnVXR5d0NRb1BwaXpiWXBOKzZD?=
 =?utf-8?B?d2ppMlNJNFQ0RkMzb21RaGhQcFRJejVCd0t6MEdhU0RFT1IxSHBwZzIzT2s4?=
 =?utf-8?B?dUlGS3BFT3NKS3ZReE1nTHZxUGpZclpLM1NoWWx2OE5BaTB6K20reHYrMmQ4?=
 =?utf-8?B?MWlSU2tnRkpUWEN2L2Vnalh4SE1SemJBMUhwZC9QcU9kS2ZCcElTRm1nbGkx?=
 =?utf-8?B?UHBidXROVFhhQ3JJK1BUbWk0c2ViMXhRVFQvRkNibWl5aG5STHAySGV3dmhY?=
 =?utf-8?B?MDhudTd1cXRORFB5enJNU2g3TWdxczFkZ1RmTUxEeUs5dGJTTzVKLzNDb0tM?=
 =?utf-8?B?ZGYyVGt1emV4c3ZLdS9SS05RdW82MW9Hb21XSHNKS0cxTlcrejJvd3l4cnly?=
 =?utf-8?B?QmM0cnh6ckE4bC9VRjBFVGg0SXV2cnB2dklvVi9lM0pSYWlETzVJRkQ3bVIz?=
 =?utf-8?B?WkZaRjNGeGV3WUNmWjV1YytGYlBwY3FPdVBJb21nRkUvSW9XbDdHVko2MGZH?=
 =?utf-8?B?cFdpM3JkQ0p5STNzV3VSQWpmOFpLNDBNd2NOQUhncGpXK1VyOFhLd1hpSHNu?=
 =?utf-8?B?VHRsRkhLbnhZbWVHd3ptN3dDZ0JoRTkyYVNWbVhoMllNSE9rUUgyQjI4M3dy?=
 =?utf-8?B?T09ER1JldEVIYWhrQ0x4OGJXYTNqLzRhNmxtQ1NOdjNzZVJzSzEwOFdyMTM1?=
 =?utf-8?B?RWtHNno3T1lxRHZ2aGRTK0VVTHZZM3ZiMFNpb21zQm1TbE5nd3ppbUFweUN3?=
 =?utf-8?B?cE5TeFZ4VUd1SXlXbEZ2YTVWWTNialhwRlZMbXh5NnhyeHBSQjlaby9wOG5j?=
 =?utf-8?Q?G0HE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 979d8650-c871-4b7c-068d-08db796b4e60
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2023 13:09:58.6443
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 87HIJunmjfhLsaY6HvLnJjoOW6sVDoXC1mxPBc65IPoLNUDc2jHZFmtzd+mcCouAfktJ7Cfps+07z2ZdR+Uehw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6845
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

W1B1YmxpY10NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMaW51eCBy
ZWdyZXNzaW9uIHRyYWNraW5nIChUaG9yc3RlbiBMZWVtaHVpcykNCj4gPHJlZ3Jlc3Npb25zQGxl
ZW1odWlzLmluZm8+DQo+IFNlbnQ6IEZyaWRheSwgSnVuZSAzMCwgMjAyMyA4OjA2IEFNDQo+IFRv
OiBMaSBDaGVuIDxtZUBsaW51eC5iZWF1dHk+OyBsaW51eC1rZXJuZWwgPGxpbnV4LWtlcm5lbEB2
Z2VyLmtlcm5lbC5vcmc+Ow0KPiBsaW51eC1hY3BpIDxsaW51eC1hY3BpQHZnZXIua2VybmVsLm9y
Zz47IExlbiBCcm93biA8bGVuYkBrZXJuZWwub3JnPjsgUmFmYWVsDQo+IEouIFd5c29ja2kgPHJh
ZmFlbEBrZXJuZWwub3JnPjsgTGltb25jaWVsbG8sIE1hcmlvDQo+IDxNYXJpby5MaW1vbmNpZWxs
b0BhbWQuY29tPg0KPiBDYzogTGludXgga2VybmVsIHJlZ3Jlc3Npb25zIGxpc3QgPHJlZ3Jlc3Np
b25zQGxpc3RzLmxpbnV4LmRldj4NCj4gU3ViamVjdDogUmU6IFtQQVRDSF0gQUNQSTogcmVzb3Vy
Y2U6IEFkZCBJUlEgb3ZlcnJpZGUgZm9yIE1FQ0hSRVYNCj4gSmlhb2xvbmcxN0tTDQo+DQo+IFtD
Q2luZyBtYXJpbyBhbmQgdGhlIHJlZ3Jlc3Npb25zIGxpc3RdDQo+DQo+IE9uIDMwLjA2LjIzIDE0
OjIwLCBMaSBDaGVuIHdyb3RlOg0KPiA+IEZpeCBhIHJlZ3Jlc3Npb24gaW50cm9kdWNlZCBieSBj
b21taXQgOTk0NmUzOWZlOGQwICgiQUNQSTogcmVzb3VyY2U6IHNraXANCj4gPiBJUlEgb3ZlcnJp
ZGUgb24gQU1EIFplbiBwbGF0Zm9ybXMiKSBvbiBNRUNIUkVWIEppYW9sb25nMTdLUywgd2hpY2gN
Cj4gPiBjYXVzZXMgdGhlIGJ1aWx0LWluIGtleWJvYXJkIHRvIG5vdCB3b3JrLiBUaGlzIHJlc3Rv
cmVzIHRoZSBmdW5jdGlvbmFsaXR5DQo+ID4gYnkgYWRkaW5nIGFuIElSUSBvdmVycmlkZS4NCj4g
Pg0KPiA+IEkgaGF2ZSBwZXJzb25hbGx5IHRlc3RlZCB0aGlzIG9uIHRoZSAxNyIgbW9kZWwgYnV0
IEknbSBub3Qgc3VyZSBpZiB0aGlzDQo+ID4gaXNzdWUgaXMgcHJlc2VudCBvbiB0aGUgMTYgbW9k
ZWwuDQo+ID4NCj4gPiBGaXhlczogOTk0NmUzOWZlOGQwICgiQUNQSTogcmVzb3VyY2U6IHNraXAg
SVJRIG92ZXJyaWRlIG9uIEFNRCBaZW4NCj4gcGxhdGZvcm1zIikNCj4gPiBTaWduZWQtb2ZmLWJ5
OiBMaSBDaGVuIDxtZUBsaW51eC5iZWF1dHk+DQo+DQo+IE5vdCBteSBhcmVhIG9mIGV4cGVydGlz
ZSAoc28gdGFrZSB0aGlzIHdpdGggYSBnYWluIG9mIHNhbHQpLCBidXQgSSdtDQo+IGF3YXJlIG9m
IHNvbWV0aGluZyB0aGF0IGFmYWljcyBjb25jZXJucyB0aGlzOg0KPg0KPiBBIGZldyBkYXlzIGFn
byBhIHBhdGNoIHdhcyBtZXJnZWQgdG8gbWFpbmxpbmUgdGhhdCBhZmFpY3MgaG9wZWZ1bGx5DQo+
IG1pZ2h0IG1ha2UgYSBjaGFuZ2UgbGlrZSB5b3VyIHVubmVjZXNzYXJ5LiAgU2VlIGE5YzRhOTEy
YjdkICgiQUNQSToNCj4gcmVzb3VyY2U6IFJlbW92ZSAiWmVuIiBzcGVjaWZpYyBtYXRjaCBhbmQg
cXVpcmtzIikgaW4gbWFpbmxpbmUgb3IgaGVyZToNCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcv
YWxsLzIwMjMwNjAxMjIxMTUxLjY3MC0xLQ0KPiBtYXJpby5saW1vbmNpZWxsb0BhbWQuY29tLw0K
Pg0KPiBNaWdodCBiZSB3b3J0aCBnaXZpbmcgYSB0cnkuDQo+DQo+IFRoZXJlIGlzIGEgcm91Z2gg
cGxhbiB0byBiYWNrcG9ydCB0aGlzIHRvIHN0YWJsZSBrZXJuZWxzLCB1bmxlc3MNCj4gcHJvYmxl
bXMgc2hvdyB1cC4NCg0KQ29ycmVjdC4NCg==
