Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2C6F68897B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 23:02:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233115AbjBBWCQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 17:02:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232842AbjBBWCE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 17:02:04 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on20600.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eae::600])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2843A885C7
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 14:01:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z5/3UsoGAUS0R7faGYflOROt4kk/FLBDsz1GvO3mBJIJ9HyYpyFKNlZKLy3s/2GmPkq97c9b7uwC6a/wyoOAtS2Vq8A+dCL+9qoKtZgZYQ5mLy2lP5//eXjlaYVtRafWJcymWD9fZPLMNJSNobLM3UoLgF1IesVShnTlL93Pl8jg2SMABJX91a/i9Excq60DOuZ1+pzqTF7B8yIwuuHp5LlOclYSe5Yy/ShZnyh9PBJ+COnrreC9FP6RlNeAiYTI/KEOGemefqg9gQsjdPsLa1r+xcwZY2SVI560BrafdKZ5QKrPg0c44ABqvR43/GYGk4tVGHTsMlENdvh3z7BBNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cUMhWpP/ZPBOWKV8zzS/V0rVb+OUm8VH8Wq5sihnzbM=;
 b=OsVnXNQQnNMcP1WBXJgvdKFogj5XLCAr12G1C0ndXsmCW6/qnFWEfziOLazslTe32gO8IfjVtnOPox12419gOOt+Ij2M1111R6qzoSl7sO3k5Urt27f0d26y99VEYRKO1RVvP3o/WvirJhVqKhQNYqvZ0Kv28vK1N9dMX6exiFHcp7Zhm5892z7MQ8XOI2kH/ptUFbahAH5mcoWTKfrB1xJtCDrH0RvOFnn6ghTNjeIDa4NbK/TmM/frge48OkvR442sCIqIHoNNHcZdHdMlse92HWwnXH/J3LuA8eDSETOfwJwYBDhH+Ske9m2dPnZgM2HJmwJEE645BqIyLAlbKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cUMhWpP/ZPBOWKV8zzS/V0rVb+OUm8VH8Wq5sihnzbM=;
 b=f+D/PRRKoaZydA03j/SVNl1Zo8FrZ4RusG78eo9cRksqMRYqvDDVj3XAPzsCQxzDMcwE8PkZfgieKEZhkJrl8BR8cst6Gu7zD11uK1oylr2zw3X2gTQEjkttGRafcS1mGV+Ifa/J/n0x5pKY0tYKVpGrGQR3Jw/ju7lfxBRQ0JSIT/fwyaxGfYGG54IF4wJ7ZKdeEes+fKWiSGOjsS+CwXt1DosGUbMBvildUUOCQPK4lTD7uHo+CiYwz5IZBbMk/jJdOJLU4R+kMI7zXZd6Y4xon3/5dS7WB2MOabBRZrwXoEDHdvgt1HQ+BYQt3CVBB8YOtEYT4xVVuUanGkD2Yw==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by DS7PR12MB5767.namprd12.prod.outlook.com (2603:10b6:8:76::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.27; Thu, 2 Feb
 2023 22:01:19 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::a891:beb7:5440:3f0]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::a891:beb7:5440:3f0%4]) with mapi id 15.20.6064.025; Thu, 2 Feb 2023
 22:01:19 +0000
From:   Parav Pandit <parav@nvidia.com>
To:     Si-Wei Liu <si-wei.liu@oracle.com>,
        "mst@redhat.com" <mst@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        Eli Cohen <elic@nvidia.com>
CC:     "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 3/7] vdpa: validate provisioned device features against
 specified attribute
Thread-Topic: [PATCH v2 3/7] vdpa: validate provisioned device features
 against specified attribute
Thread-Index: AQHZNcrul/O2ZyBovE6TfvS9k66n+q67G64QgAEbwYCAAABlkA==
Date:   Thu, 2 Feb 2023 22:01:19 +0000
Message-ID: <PH0PR12MB5481281DC132B6424BF4DAD8DCD69@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <1675207345-22328-1-git-send-email-si-wei.liu@oracle.com>
 <1675207345-22328-4-git-send-email-si-wei.liu@oracle.com>
 <PH0PR12MB5481759D5CA6EB5C9D63C517DCD69@PH0PR12MB5481.namprd12.prod.outlook.com>
 <6b27b653-1d36-0ec8-c3c7-caaf1b896381@oracle.com>
In-Reply-To: <6b27b653-1d36-0ec8-c3c7-caaf1b896381@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|DS7PR12MB5767:EE_
x-ms-office365-filtering-correlation-id: a63aa249-bb9c-4447-ffed-08db056903ca
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6shcJUkw9eQGLEXbRqRhU1b5VQGrknA/zssDtQLWooUCVA+QGDSF9S+d869p8Mmn4aANaz2Na7O7wT6oShBzKtm1UocDj/M86xxO834THVRUB89WRZZV8oJFndqWKAl6Ru1ZBlIaIWZ9yUwQ/xFQsa4cWrZP2FjBP/kg08gQX+Cd1yrCO2a6L9VcGyFdcU5JzxI8NZN2sKQpGysj4nrh5wsTjQ/SuhFcdH/QgZWT+dwBZjCI0A55coaca+1r76IS27nTHjvk0eYA6v208celSakeeViluWqZjmD1Ewz586y7d2oxM/Za14W2davUXPAnQdc+TcNyNmGAiDf+eitHHMav7ttb2Y4r1BIvHipHjgN3JhKBqihxdy9Rn+NUzhlZATj9RU4doK7NwShuy6yaxVk0A0W5MhhYGE75x1d3VfAINJqTdfhh6KQPZ3Tc+Z2jQLBgogu6LJaM3d3iMVRvPocw3XSXWQxerCv1xFiweLTxyms1OuSXsVIN5Jw/MShhX+SFK7olcAUPcxLLn3ulhdHSGgp3rb9aof+o68goy6dbCzNc/5o+bj/K4SxXty5yQ9CBqF9AgGkwK6HDbIC1ZO+5L43CUb41BHxp/7vOYz9xyPhK33w6NH2pFGOdl9dX0dUsUWHZCvQE/xJRVEAgLAjqu1/bN8GAPAtjhyyTIlHy7U4lwjBas7HO89N8f+25bDwLzqxFIoolaGo49IIIuw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(136003)(396003)(376002)(346002)(39860400002)(451199018)(76116006)(5660300002)(33656002)(86362001)(8676002)(4326008)(38070700005)(55016003)(52536014)(41300700001)(8936002)(316002)(110136005)(54906003)(6636002)(66946007)(66476007)(66446008)(66556008)(64756008)(122000001)(38100700002)(53546011)(6506007)(478600001)(71200400001)(7696005)(9686003)(186003)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SHFVRDU1SGdIaHZZZ1dVTFU1Vk5nY0lMaTRGUWpqQVgxTEMrTG9TbDg0ZnVP?=
 =?utf-8?B?Zlk4NGFFWDE4bzVBMXdGRXZjWUM5MGFlQ1kvMFovaXExV201b2dsMzdvT2pW?=
 =?utf-8?B?d0V3ZHlXU0psTGV4SDd5SXhLV1ZXS0M3UnZhSVR0VlM3aldvUWZXLzJYRnI5?=
 =?utf-8?B?Zkl1bjdoaS9SSytIOEFGdDdrcUZkVHR2WVhKeU1sbmNzYVIvQzNDOUNJbTJ0?=
 =?utf-8?B?VVZuSlhzTytKaTRuTzFnaEtHQ0pReXBhbmkwMngvTXZHQ3hSQ3NNbVR2U2xt?=
 =?utf-8?B?eGltR1FYSHRRMUdTWUVIRU9BVytQQ2hUSWNtc2MwUUVlM3ZtOExXdm84N0Q2?=
 =?utf-8?B?NThzTlhSYVNXY05rdjJBYytjay9uTnZhODhUZjRoK2RqYnhJcW1Wd0lieVN4?=
 =?utf-8?B?WG1TeEFuVzZHVEN6dXE5cDFnT01jUFhadEx6TVcwZWUvNmdncld5SGQzSXht?=
 =?utf-8?B?c0c0ZlBVY01WRnVPOVh5SE1SQUtmZ1ZUcVJXMm1LNC9zYWJiY21oNW5PWnVN?=
 =?utf-8?B?c1Z1Q01HQ2FKY2dNOEJjTEtWT1NLV3ZjV0I4TUVma2QvSlJqbXRXQXQ1NW9h?=
 =?utf-8?B?MldHSDg0ZVVqK3hENTdMUUh2TXZDaHd6em1ybm1QZHVXYjJSWlVoMGFqMGZJ?=
 =?utf-8?B?SFVqa29ybjhXKzgwdFowOHJlazYxSzdTUEp1ellVUkVJdGNCbk5NeUNYS2Uz?=
 =?utf-8?B?UVdsbWR1eFk5ZEpqeUVtcU9mejg4L1dpMGZrYnVvWW5TQXlxVWpFY0ZKYXFR?=
 =?utf-8?B?RG9vUndIUDZDUmRRNis5aXQwRisrNlFRcmVCT1o4MWxFdU40SUxUdVB6Slhp?=
 =?utf-8?B?RmRvN3dUeUY3b2pFT0ZhcjNzSWEvb0I4RmZhMUY4UVNScnE2WUlNRTk5aTVj?=
 =?utf-8?B?QkFmcEh0MVFoWWNsSjh0UVl5Y3hkbGM2anAxaUR2cktyTXcxNXNGRFR1RnBI?=
 =?utf-8?B?czBDQTl2Zzc4WFhabU85MFVpN2RUWEU5ZjhvTnhrZkNFR3BpZzRxcXZ5dXU3?=
 =?utf-8?B?VXlLZ2t0S1V0UVgreG1vSnUyWnFzR2piL1lET21hOVM5a2s0OExBZ1FTcm5x?=
 =?utf-8?B?K01qWVJVakQyRkNxbnQzYXNoS0JlTUxIY20xQmRYZXJQOU0zVVNQWGQ1OEJi?=
 =?utf-8?B?N2xqejNyMVJvczh1d3hIMlJkSVdkckZCQVRsbGVhc0g4eSsrSjNhUUxFc0Q3?=
 =?utf-8?B?VkF0QXhOWE54cjB2TWt2OU1ydnZRVmY1dmxpYmFUZy81QzFRVW0rTVM1ZFNL?=
 =?utf-8?B?T0g0cGR4WEk5MXhqMHRiR05oaS83UEUrcHlKS1o3RkNtRXcrZFlVV2RVdGZr?=
 =?utf-8?B?MzdYNmpnWm1GWlJVT29WaGRvZHltY0w5dy9iQUZWdnozMWlYdTJTVXV6Y0JL?=
 =?utf-8?B?TGVDcUFOb2J6NmtIZEpGckJYdThWSnRCZU94TDl4UG11YTVtS3kyckxxWjdn?=
 =?utf-8?B?L21lSGNHV3dZa09xdXlUS0FXc2ZIT29SRS9kQUlOREt4a3V2Mjh5T0R4VFZ3?=
 =?utf-8?B?U0k0OWtUb3dsR0srb2hITDRQc1U5OXhEdlJsc1NjZTh2aXlYQk5JRzV3U1I4?=
 =?utf-8?B?Q2I1S0ptalZ5MEt2Nkc3amZPWlMyeHN3aFoxdHNLL2Z5emVtV0VLMnMwSzU2?=
 =?utf-8?B?NkhubndFcEtHZ2tIMURjL0Z0SXNzZUFvNmNpZ3lTZkFXdFhXZUgrYlhlUHdU?=
 =?utf-8?B?QmdYK3JqSUJYKzhZK3NHVHBlTXkxMkR0OEl6OVFpdnN2ZExSZkRpRkZ0WEJz?=
 =?utf-8?B?bkNpSDI5MXFWRFgxbE1VK1grcWdQWG1Zd0JrTWROY01kS3QyRzNtbGZYelI2?=
 =?utf-8?B?cnNqQk9QSXpNNEEzVnY3Y0M4NnNvUUlUREdId0VhUnpXbmFHQnRoUFdSWkdO?=
 =?utf-8?B?anRhUGxtTEJCbjRrK0QwVFNacmJkRklvcVc4dWE2NndlVkFiRld3Y2M5Tyt5?=
 =?utf-8?B?OXQ4cjVENHhyWmh4Qk9UdTJNc2RRR3NucUZIaER6V3MwbGZIQWozOWszR3Zt?=
 =?utf-8?B?M2duWldaeUNycXZPdEFabHJjSjV1M0hORjduYXE4MWxlNXAxYWNwT0tSRmpZ?=
 =?utf-8?B?d1BMejQxajBUYTQrMGJMNDJrdVlISGtEVllCNHBmUW9mcm1KamxsSTZ1QXdK?=
 =?utf-8?B?NG1TUGI2VGlTQ1pDRTZ1ZXFaSVB2djNRemhpdU9QdmFERURRWDY1R1J4c0VB?=
 =?utf-8?Q?FSCo7vbD75QJIaPuaMna5X0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a63aa249-bb9c-4447-ffed-08db056903ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2023 22:01:19.5772
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JEfZ+db59Swddw5QrQ0dym0GMe0KlG6UHOPIbUXp2xgz+BI4ws5PeiEuEU+Ce2WinBavvLKkH2p0Oxr1lMCxWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5767
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IEZyb206IFNpLVdlaSBMaXUgPHNpLXdlaS5saXVAb3JhY2xlLmNvbT4NCj4gU2VudDogVGh1
cnNkYXksIEZlYnJ1YXJ5IDIsIDIwMjMgNDo1OSBQTQ0KPiANCj4gT24gMi8xLzIwMjMgOTowNSBQ
TSwgUGFyYXYgUGFuZGl0IHdyb3RlOg0KPiA+DQo+ID4+IEZyb206IFNpLVdlaSBMaXUgPHNpLXdl
aS5saXVAb3JhY2xlLmNvbT4NCj4gPj4gU2VudDogVHVlc2RheSwgSmFudWFyeSAzMSwgMjAyMyA2
OjIyIFBNDQo+ID4+DQo+ID4+IFdpdGggZGV2aWNlIGZlYXR1cmUgcHJvdmlzaW9uaW5nLCB0aGVy
ZSdzIGEgY2hhbmNlIGZvcg0KPiA+PiBtaXNjb25maWd1cmF0aW9uIHRoYXQgdGhlIHZkcGEgZmVh
dHVyZSBhdHRyaWJ1dGUgc3VwcGxpZWQgaW4gJ3ZkcGENCj4gPj4gZGV2IGFkZCcgY29tbWFuZCBk
b2Vzbid0IGdldCBzZWxlY3RlZCBvbiB0aGUgZGV2aWNlX2ZlYXR1cmVzIHRvIGJlDQo+ID4+IHBy
b3Zpc2lvbmVkLiBGb3IgaW5zdGFuY2UsIHdoZW4gYSBAbWFjIGF0dHJpYnV0ZSBpcyBzcGVjaWZp
ZWQsIHRoZQ0KPiA+PiBjb3JyZXNwb25kaW5nIGZlYXR1cmUgYml0IF9GX01BQyBpbiBkZXZpY2Vf
ZmVhdHVyZXMgc2hvdWxkIGJlIHNldCBmb3INCj4gPj4gY29uc2lzdGVuY3kuIElmIHRoZXJlJ3Mg
Y29uZmxpY3Qgb24gcHJvdmlzaW9uZWQgZmVhdHVyZXMgYWdhaW5zdCB0aGUgYXR0cmlidXRlLA0K
PiBpdCBzaG91bGQgYmUgdHJlYXRlZCBhcyBhbiBlcnJvciB0byBmYWlsIHRoZSBhbWJpZ3VvdXMg
Y29tbWFuZC4NCj4gPj4gTm90ZWQgdGhlIG9wcG9zaXRlIGlzIG5vdCBuZWNlc3NhcmlseSB0cnVl
LCBmb3IgZS5nLiBpdCdzIG9rYXkgdG8NCj4gPj4gaGF2ZSBfRl9NQUMgc2V0IGluIGRldmljZV9m
ZWF0dXJlcyB3aXRob3V0IHByb3ZpZGluZyBhIGNvcnJlc3BvbmRpbmcNCj4gPj4gQG1hYyBhdHRy
aWJ1dGUsIGluIHdoaWNoIGNhc2UgdGhlIHZkcGEgdmVuZG9yIGRyaXZlciBjb3VsZCBsb2FkDQo+
ID4+IGNlcnRhaW4gZGVmYXVsdCB2YWx1ZSBmb3IgYXR0cmlidXRlIHRoYXQgaXMgbm90IGV4cGxp
Y2l0bHkgc3BlY2lmaWVkLg0KPiA+Pg0KPiA+PiBHZW5lcmFsaXplIHRoaXMgY2hlY2sgaW4gdmRw
YSBjb3JlIHNvIHRoYXQgdGhlcmUncyBubyBkdXBsaWNhdGUgY29kZQ0KPiA+PiBpbiBlYWNoIHZl
bmRvciBkcml2ZXIuDQo+ID4+DQo+ID4+IFNpZ25lZC1vZmYtYnk6IFNpLVdlaSBMaXUgPHNpLXdl
aS5saXVAb3JhY2xlLmNvbT4NCj4gPj4gLS0tDQo+ID4+ICAgZHJpdmVycy92ZHBhL3ZkcGEuYyB8
IDE4ICsrKysrKysrKysrKysrKysrKw0KPiA+PiAgIDEgZmlsZSBjaGFuZ2VkLCAxOCBpbnNlcnRp
b25zKCspDQo+ID4+DQo+ID4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZkcGEvdmRwYS5jIGIvZHJp
dmVycy92ZHBhL3ZkcGEuYyBpbmRleA0KPiA+PiAyMWM4YWEzLi4xZWJhOTc4DQo+ID4+IDEwMDY0
NA0KPiA+PiAtLS0gYS9kcml2ZXJzL3ZkcGEvdmRwYS5jDQo+ID4+ICsrKyBiL2RyaXZlcnMvdmRw
YS92ZHBhLmMNCj4gPj4gQEAgLTYwMSw4ICs2MDEsMjYgQEAgc3RhdGljIGludCB2ZHBhX25sX2Nt
ZF9kZXZfYWRkX3NldF9kb2l0KHN0cnVjdA0KPiA+PiBza19idWZmICpza2IsIHN0cnVjdCBnZW5s
X2luZm8gKmkNCj4gPj4gICAJCWNvbmZpZy5tYXNrIHw9DQo+ID4+IEJJVF9VTEwoVkRQQV9BVFRS
X0RFVl9ORVRfQ0ZHX01BWF9WUVApOw0KPiA+PiAgIAl9DQo+ID4+ICAgCWlmIChubF9hdHRyc1tW
RFBBX0FUVFJfREVWX0ZFQVRVUkVTXSkgew0KPiA+PiArCQl1NjQgbWlzc2luZyA9IDB4MFVMTDsN
Cj4gPj4gKw0KPiA+PiAgIAkJY29uZmlnLmRldmljZV9mZWF0dXJlcyA9DQo+ID4+ICAgCQkJbmxh
X2dldF91NjQobmxfYXR0cnNbVkRQQV9BVFRSX0RFVl9GRUFUVVJFU10pOw0KPiA+PiArCQlpZiAo
bmxfYXR0cnNbVkRQQV9BVFRSX0RFVl9ORVRfQ0ZHX01BQ0FERFJdICYmDQo+ID4+ICsJCSAgICAh
KGNvbmZpZy5kZXZpY2VfZmVhdHVyZXMgJiBCSVRfVUxMKFZJUlRJT19ORVRfRl9NQUMpKSkNCj4g
Pj4gKwkJCW1pc3NpbmcgfD0gQklUX1VMTChWSVJUSU9fTkVUX0ZfTUFDKTsNCj4gPj4gKwkJaWYg
KG5sX2F0dHJzW1ZEUEFfQVRUUl9ERVZfTkVUX0NGR19NVFVdICYmDQo+ID4+ICsJCSAgICAhKGNv
bmZpZy5kZXZpY2VfZmVhdHVyZXMgJiBCSVRfVUxMKFZJUlRJT19ORVRfRl9NVFUpKSkNCj4gPj4g
KwkJCW1pc3NpbmcgfD0gQklUX1VMTChWSVJUSU9fTkVUX0ZfTVRVKTsNCj4gPj4gKwkJaWYgKG5s
X2F0dHJzW1ZEUEFfQVRUUl9ERVZfTkVUX0NGR19NQVhfVlFQXSAmJg0KPiA+PiArCQkgICAgY29u
ZmlnLm5ldC5tYXhfdnFfcGFpcnMgPiAxICYmDQo+ID4+ICsJCSAgICAhKGNvbmZpZy5kZXZpY2Vf
ZmVhdHVyZXMgJiBCSVRfVUxMKFZJUlRJT19ORVRfRl9NUSkpKQ0KPiA+PiArCQkJbWlzc2luZyB8
PSBCSVRfVUxMKFZJUlRJT19ORVRfRl9NUSk7DQo+ID4+ICsJCWlmIChtaXNzaW5nKSB7DQo+ID4+
ICsJCQlOTF9TRVRfRVJSX01TR19GTVRfTU9EKGluZm8tPmV4dGFjaywNCj4gPj4gKwkJCQkJICAg
ICAgICJNaXNzaW5nIGZlYXR1cmVzIDB4JWxseCBmb3INCj4gPj4gcHJvdmlkZWQgYXR0cmlidXRl
cyIsDQo+ID4+ICsJCQkJCSAgICAgICBtaXNzaW5nKTsNCj4gPj4gKwkJCXJldHVybiAtRUlOVkFM
Ow0KPiA+PiArCQl9DQo+ID4+ICAgCQljb25maWcubWFzayB8PSBCSVRfVUxMKFZEUEFfQVRUUl9E
RVZfRkVBVFVSRVMpOw0KPiA+PiAgIAl9DQo+ID4+DQo+ID4+IC0tDQo+ID4+IDEuOC4zLjENCj4g
PiBWZHBhIHRoaXMgbGF5ZXIgY2FuIGxpa2VseSBkZXJpdmUgdGhlIGZlYXR1cmUgYml0cyBmb3Ig
dGhlIHN1cHBsaWVkIGNvbmZpZyBmaWVsZHMNCj4gc28gdGhhdCB1c2VyIGRvZXNuJ3QgbmVlZCB0
byBrZWVwIHRyYWNrIG9mIGJvdGguDQo+ID4gT25seSB0aG9zZSBmZWF0dXJlIGJpdHMgd2hpY2gg
YXJlIHVucmVsYXRlZCB0byBhbnkgY29uZmlnLCBpcyB3aGF0IHVzZXIgc2hvdWxkDQo+IGJlIHNl
dHRpbmcuDQo+IEl0J3Mgbm90IEkgY2FuJ3QgZG8gdGhpcywgYnV0IEphc29uIHdhbnRlZCB0byBo
YXZlIGNsZWFyIHNlbWFudGljcyBhcm91bmQNCj4gbWlncmF0aW9uIGNvbXBhdGliaWxpdHkgZm9y
IHRoZSBkcml2ZXIsIGFuZCBmb3IgdGhhdCB1c2VycyBoYXZlIHRvIGV4cGxpY2l0bHkNCj4gcHJv
dmlkZSBkZXZpY2VfZmVhdHVyZXMgdGhhdCB3ZSBtYXkgZGVmaW5lIG5ldyBkcml2ZXIgYmVoYXZp
b3IgKHJhdGhlciB0aGF0DQo+IGluaGVyaXRhbmNlIHdoaWNoIGlzIGltcGxpY2l0IGFuZCBub3Qg
dW5pZm9ybWx5IGRlZmluZSBhY3Jvc3MgZHJpdmVycykgZm9yDQo+IGNvbXBhdGliaWxpdHkgdXNp
bmcgdGhlIG5ldyB1QVBJLg0KTWFrZSBzZW5zZSB0byBleHBsaWNpdGx5IHRlbGwsIGp1c3QgcmVx
dWlyZXMgbW9yZSBjYXJlZnVsIHBsdW1iaW5nIG9uIHRoZSB1c2VyIHNwYWNlIHNpZGUuDQpFdmVu
dHVhbGx5IGl0IHdpbGwgZ2V0IG9yY2hlc3RyYXRlZCBieSBub24gdXNlciwgc28gaXQgc2hvdWxk
IGJlIGZpbmUgdG8gZXhwbGljaXRseSBkZWZpbmUgaXQuDQo=
