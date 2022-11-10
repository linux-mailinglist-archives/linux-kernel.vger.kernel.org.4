Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E0C7623EC9
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 10:39:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229495AbiKJJjL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 04:39:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiKJJjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 04:39:07 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EC4B261C;
        Thu, 10 Nov 2022 01:39:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1668073145; x=1699609145;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=lOcCbMRWAREah/KLbX+du82hMqVpjrIGFLm3gi2ztY0=;
  b=hdTVLACZ9AjPZhcAeYgH5ttt0Ms8H5lKck3y8pcpiEr+CynI53fSSoxp
   xqhujTno+qZQEvngrux0wsYwpDKSWJDNBZ6Vc75D3NBcKhWcyuCOtoH0Y
   XmHa7F9MvI2y/cPtQ5i595qR0N5H0oVQMBIx1eabDdJBCs2NKeY0Oojzv
   RVllayvnAkUjuGu4kuSpK1HI+ISQosh6PR7B+6HUBgYzZlFBVBb+dco30
   D/jhj6CmVbmklC7L06UnamDnkot6wDufetkKhUxREsqRJkp1fdxhCrdzG
   P659KG6VRTys/89Q0iAQRllGLq0IraqW9WmZISPh4NinblPtaKrJ/3OxX
   A==;
X-IronPort-AV: E=Sophos;i="5.96,153,1665471600"; 
   d="scan'208";a="186294333"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 10 Nov 2022 02:39:04 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Thu, 10 Nov 2022 02:39:02 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Thu, 10 Nov 2022 02:39:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TfyIIlMomH9lQ4CBvmR1xJb8SFQ0hBjxyI51TyW7zfU9orHVuqmYS8LRalRbEG4Lfq12NXFBD/+yGw09UK9I33YWNsyZ86ON0bBnY7mbBKYbEMfQwyM3OAU1sGFmMju3iJ+Y6LEVqCQhZAsmaVKW6l1aY9DoksaCWQfpZ50hUW9Rjq6u8W09CQw+EpOQJKa+Gx6aMP9+ien3WMKWuANIxK6ohv75xih/FGIFZrz8asXuT46GpbY6k7B1OjYjSN+HSguvMzVG2gQdP23qSqLEM6qrSR7qT2YvbAk6g7eRtg4raer1wvcQmY5ANhkTu+LuMI7iOwhbvvhvkzoHJi5bww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lOcCbMRWAREah/KLbX+du82hMqVpjrIGFLm3gi2ztY0=;
 b=AtDvl9LNfqQHK5+l9TcQsBcKYHQN3vrgEUKLcU46+NPxIs0jiv0douK3NjVrz+IBNqQ9FT9x8wj7qtTcySRVGB/HirCXWZr7BSVaPokdqmyyD8F83Vi7c9ELRuPFlt61RmFVEUtuiMg4822d/eWBxgZ+vPcDixpG6YSlgtCFZz0YR5p/9yk1BjZIj+Ag5HDI8l5JIsy+x27O32nr15h4gKf0OlepH3JzxfqlQTfeZO4/9mCblyndcAoyHxpCrSIMdALjGKzkWb1EuGGbX1aQ2OQnlhEqfAvatyw6AO3EtVoPMrHgcoINQtKQKnNuAQMbby3S3Shbew/8ObMOzcoHcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lOcCbMRWAREah/KLbX+du82hMqVpjrIGFLm3gi2ztY0=;
 b=pvIuVvFrKW0NelO/j5fvIddoKtC0Ny3IkWW5x2fhZs1j67okUQN9IVHCSo+i8/pH7lEErIT216dNkidnUIU4gNnvbsYyRDUeqsaBa7LjouVqsLW2grjWZvB09/UTFnHm1QPG8fz4mZqCDEXkZ3Vu+TORV7kjAtD7O22EhGSIZ7A=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by PH7PR11MB7052.namprd11.prod.outlook.com (2603:10b6:510:20f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Thu, 10 Nov
 2022 09:38:57 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::6a0a:e787:bf0d:83cf]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::6a0a:e787:bf0d:83cf%7]) with mapi id 15.20.5813.013; Thu, 10 Nov 2022
 09:38:57 +0000
From:   <Conor.Dooley@microchip.com>
To:     <thierry.reding@gmail.com>, <u.kleine-koenig@pengutronix.de>
CC:     <Daire.McNamara@microchip.com>, <linux-kernel@vger.kernel.org>,
        <linux-pwm@vger.kernel.org>, <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH v12 0/2] Hey Uwe, all,
Thread-Topic: [PATCH v12 0/2] Hey Uwe, all,
Thread-Index: AQHY9OfkFWUJg6/zjUeAFym2Fz0Qaa435qGA
Date:   Thu, 10 Nov 2022 09:38:57 +0000
Message-ID: <054e6972-e6b6-7075-5f20-9d005ef81020@microchip.com>
References: <20221110093512.333881-1-conor.dooley@microchip.com>
In-Reply-To: <20221110093512.333881-1-conor.dooley@microchip.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB5154:EE_|PH7PR11MB7052:EE_
x-ms-office365-filtering-correlation-id: e6aa856c-86aa-4c2a-c76d-08dac2ff63fe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aMk57QgcWp5BZAERESv+o226fgR6GzvS/DzgA4DvuSbZa7bQz20sI40gRwB3fqrzH5BWLFKmy+/aac2oeC9U5bpI8AWp7uqjl4fdaBmLY+iecTtXnosiwOzHur3s9zxcxvqykqZ6PmsGH8tOvXt3+Qvr6Q34g7/dBE9/IToT94hZvaLq+cUERYt/eQefISmdoSTl9b7/k3vfvvwokskHQII9ZgET4kaJ9Ux+sfXJZte06PsmFbqIn0G6V5DBDIlQMlUxixtOop0eiVY18thXKO9C5PhfFGFgKllLDtjZUjC6YVHeJqo/NQDJrWIvIJUCwjligHf4h8C3R4DKcpPW18O63ieYk90aYmmWMHURLk6uhPCje6uT4sEfOviYMboUDKW/DlxSiCs/hkYzpiR1uHdFWhF+3vmNAokYyXDNcS0OImgEXuHASMhtLDCfKIWA/wggaLcGAv4/6OwmeJaTg6HOcW8w9WAZ7PxVpMyAka5FJQIYNJi1KKTZluDm9hO2XrkdTHNULv7Xnprrv8D4XV0awyx0iEc2feOs9SDUmQjDdcYCeSKX47RyWqA1J9Gsu4frFwyQszcOWavbVy75FoVDEDzA/UnLBQRANpppWEi+l5uq8V4yrGOJ7cszVKeeKuPJkJlSBnIzTIbZjVReeo12PJBE5NHrE1z+QCI2hSr3XDBmyUIKweonmSivcub1I43h8R6sv3kXNsPbYBmpu3HMnVauqwmsqGt/jlxWFnhlGp7WGc5KStXlpeCJzjbYJsN7qpOwlZ0hktd7jFat+eOv3t4p7ej6E5D6x0i4e559xJn8a3zjBs9IA8JCUgj4+QTbAL1Fa7kwkDWnQ8T2/Zl/keKR0GT72ytzSUaUr6LP1D6wVLigD9gfXksChSJF+cxCMXJsqs98eFR2989dCg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(396003)(346002)(39860400002)(376002)(136003)(451199015)(6512007)(41300700001)(26005)(66476007)(76116006)(6506007)(8936002)(64756008)(8676002)(66446008)(91956017)(66946007)(66556008)(36756003)(53546011)(4326008)(2616005)(38070700005)(122000001)(38100700002)(83380400001)(2906002)(5660300002)(86362001)(186003)(31696002)(71200400001)(31686004)(6486002)(966005)(478600001)(54906003)(316002)(110136005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dzYvcUIydTkwV1FIWUg5c1BWc2s2MGNhaU1pTkR6YlBxTm4wU0N2bzJKWEpQ?=
 =?utf-8?B?WHV5SzZJYXU3cFpsa0Z5SE9yalRCYkFDdG1aRFhhMmkrdHBPdGlFYzhaOXNW?=
 =?utf-8?B?QlFGc0diQnBHaXBwQWVRcmxXRjZoNkpPdHZOa255US9XemtiNUJiWDc1WTkr?=
 =?utf-8?B?OGV1WEpncUtuRzNDVnhrWW9ZVjNLL3JxOENDL0lMMERMSUdIUk9sWThSVEIv?=
 =?utf-8?B?Tk9Kd3BSNFkyZGpWUG9kOGZIWUc0dDBLOUw5eHNBVys1TVpJVEZvN3haZm5E?=
 =?utf-8?B?YVlmSUN0eUFhWkxQcTlOZHZ3VUcyczVSYWZoeFlJVWw3K2ttNkdmOWJENFFL?=
 =?utf-8?B?a1V6Vm1md0JtUzMrVHpINTNjNkhkUVVjbU5OYkthbWZIQ1YxWGVpZjEwdkVS?=
 =?utf-8?B?SVZNZU1YdVk1ZXJzL0kwczBEV2VnR29oZFZPT2oyZjcydHJUQ3o0a3h1K1Er?=
 =?utf-8?B?NkpiWWIwWWQxZ1kvRmt1blNWaGFSOGRvTEM3bHUvMVVpRnZmdStDTjR0bFZn?=
 =?utf-8?B?M0trU1ZvYlhHRGI5YlRoNExlb05lRmRlMzd0VmNrRVI3cDNPMFdGYzZlYkc0?=
 =?utf-8?B?M290ZE9sUGFxWkkzM2ljc01EVWpTd21pb215UzNsRzFRZFdWYzB3RGhrKzBj?=
 =?utf-8?B?dDhNTnR3eHh5NWhBeXArbzB2c1F0Qnl2dWNWVHN0NmpBN1V4NkdNaktxNzNa?=
 =?utf-8?B?aWZpcmd1dkk4VEkrbURYU1p3Z0tka0ptaitFWHNhdnRIMVhEVExUMVdXeGNF?=
 =?utf-8?B?T3J2Y0ZKWllQdlB3OUprdHA4RGVpbGhZeUc0a2NoNS81V3pWWmxkSkNTQ241?=
 =?utf-8?B?OExTejRnelU1TlA0SVJzN3ZuWEc5SVNtdHBsclhaL2U4WFVnNVVqWnBRVHRm?=
 =?utf-8?B?OTM3d0RjQW1UOFhBdHFSempSNjJLK1BscWh4M3oxSWZOcVFMem5hQVM2V001?=
 =?utf-8?B?SEpHaW01TS83a2FqVGljeDhLWHViQmhOUDlSb3BBODdEYmFzYmpsSG1WaHVl?=
 =?utf-8?B?NmUrdVBYMDhzRzVhQ0ZhbmxhNVdMY0EzeDRGblNRSlBpYUxSOWlrYmZQZ3dE?=
 =?utf-8?B?aTI2WHc0VmhCQzUwNzNTUXlTcHpiYlFvSk9PWFlSczB1YXlYeUZ6eGNVaHlU?=
 =?utf-8?B?RERzWksyNHJkWlM0WHRIM0JTKzhMUEUzZG8yRmVSeEMxTXZMWWZ4ekQrQWRS?=
 =?utf-8?B?SXRReHZaS2p0YjZCMnljbE8vWWxLRGVQZldzN2QzbURNbUp0RGppL1hxaHZi?=
 =?utf-8?B?V0pDdVplY0tkTjZlV1paNWtoVEdINTJ0WFZBSEcvdlZERTE0ZnJBZzJ2MVZi?=
 =?utf-8?B?SGZad1MrcWxqZVUxd2M1RGYwRVFXOUo2YWM2cVpKM1NLV1RFK3R4YzlrVmlN?=
 =?utf-8?B?MnhUV0hrMFNCcFZzdkdZL2ZUOGpKaEtLTGY5N0dXL1ExWW5yeTVCcE9PaTdQ?=
 =?utf-8?B?ZzRCblFhcHA0NHA2clhKRzRlSEZ5dEV6Wnl3d3NLWHlQSzNjYmlMQlU0S3lF?=
 =?utf-8?B?WW03UWNwR0V5NnBlaUFXbXNqMkwyZWNKTUNNektOZUJaU1RWSE5nOWZmZHhD?=
 =?utf-8?B?UjdybUY3eTNEZTNZeHhEQk9IYW03NUgxckZDMzhscDIyTlVDSXJTa09FSnkv?=
 =?utf-8?B?WUJDM2liTFNwK2VLQnFySGdodEgzSEpIaElmR21vNjZyd21ENE9QSG9URk11?=
 =?utf-8?B?VFlyUTQ1RGorb3RUL2VWTENHWEtTTk9jaWtGRmVrSXpsd3dwcG1WVFgwakdC?=
 =?utf-8?B?NTJhd2w5WlZtNWl1VXBIdk5uYk9BZC9nZW4vS1EyZkJrcUpBZ1NNZ0N0Vjhz?=
 =?utf-8?B?V2VmSDV0OG5PUkYyZVhVQ2d2YWRuTGh2SnJjT0x3SURIam8zM3dmV2VuSThh?=
 =?utf-8?B?bkpYWHFyeXdXRWpoUWNVaVQ1V3A2RWIzaVRyMzFrbkgwVlhlWmRGWWpoSk1k?=
 =?utf-8?B?bkU3NzU0UVNCK3lrSVFwN3lRcnhGS3l1TTlSTzZwNUtFa3dxTHMraVRqa3M5?=
 =?utf-8?B?bmxCcERBeEF3K2ZZa3ZmeDJRQlVRczB3NDdXOUdTSDZFdVhKYnBWN0hnc1Vo?=
 =?utf-8?B?akQrdzJSNUc5WW5LRFU4UnJhbDBPSlMzS0lTYjJGclUzT1JyamtYMXJlK05M?=
 =?utf-8?Q?JY+5MSoUezVAUvAeXVwV2keF/?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E5EB253482D4B14CAC3320EA1D3C5E51@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6aa856c-86aa-4c2a-c76d-08dac2ff63fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2022 09:38:57.5968
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IlK0eKYsARfYwfYpuwP8PkC9D5YgQa6p5qoicuE9SEYZWJQZzVzdX3s+6bt3f7FfM+MRqSfep20phjG4Z1TCbQ5dP4Ycr85Zy1la0nymFrc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7052
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTAvMTEvMjAyMiAwOTozNSwgQ29ub3IgRG9vbGV5IHdyb3RlOg0KPlJlOiBbUEFUQ0ggdjEy
IDAvMl0gSGV5IFV3ZSwgYWxsLA0KDQotLWNvdmVyLWZyb20tZGVzY3JpcHRpb249YXV0byBtaXN0
YWtlLCBhcG9sb2dpZXMuDQoNCkNvcnJlY3Qgc3ViamVjdCBzaG91bGQgaGF2ZSBiZWVuOiAiTWlj
cm9jaGlwIHNvZnQgaXAgY29yZVBXTSBkcml2ZXIiLg0KDQoNCj4gSSd2ZSBkcm9wcGVkIHRoZSBm
aXJzdCB0d28gcGF0Y2hlcywgYXMgSSBhcHBsaWVkIHRoZW0gbGFzdCBuaWdodCB0byBteQ0KPiB0
cmVlLCBzbyBqdXN0IHRoZSBkcml2ZXIgJiBtYWludGFpbmVycyBjaGFuZ2UgaGVyZSBub3cuDQo+
IA0KPiBUaGUgcHJlIDYuMC1yYzEgY292ZXIgbGV0dGVyL3NlcmllcyBpcyBoZXJlOg0KPiBodHRw
czovL2xvcmUua2VybmVsLm9yZy9saW51eC1wd20vMjAyMjA3MjExNzIxMDkuOTQxOTAwLTEtbWFp
bEBjb25jaHVvZC5pZQ0KPiANCj4gVGhhbmtzLA0KPiBDb25vci4NCj4gDQo+IENoYW5nZXMgc2lu
Y2UgdjExOg0KPiAtIHN3YXAgYSAiYmFyZSIgbXVsdGlwbHkgJiBkaXZpZGUgZm9yIHRoZSBjb3Jy
ZXNwb25kaW5nIGhlbHBlciB0bw0KPiAgICBwcmV2ZW50IG92ZXJmbG93DQo+IC0gZmFjdG9yIG91
dCBkdXBsaWNhdGUgY2xrIHJhdGUgYWNxdWlzaXRpb24gJiBwZXJpb2QgY2FsY3VsYXRpb24NCj4g
LSBtYWtlIHRoZSBwZXJpb2QgY2FsY3VsYXRpb24gcmV0dXJuIHZvaWQgYnkgY2hlY2tpbmcgdGhl
IHZhbGlkaXR5IG9mDQo+ICAgIHRoZSBjbG9jayByYXRlIGluIHRoZSBjYWxsZXINCj4gDQo+IENo
YW5nZXMgc2luY2UgdjEwOg0KPiAtIHJld29yZCBzb21lIGNvbW1lbnRzDQo+IC0gdHJ5IHRvIGFz
c2lnbiB0aGUgcGVyaW9kIGlmIGEgZGlzYWJsZSBpcyByZXF1ZXN0ZWQNCj4gLSBkcm9wIGEgY2Fz
dCBhcm91bmQgYSB1OCAtPiB1MTYgY29udmVyc2lvbg0KPiAtIGZpeCBhIGNoZWNrIG9uIHBlcmlv
ZF9zdGVwcyB0aGF0IHNob3VsZCBiZSBvbiB0aGUgaHdfIHZhcmlhbnQNCj4gLSBzcGxpdCB1cCB0
aGUgcGVyaW9kIGNhbGN1bGF0aW9uIGluIGdldF9zdGF0ZSgpIHRvIGZpeCB0aGUgcmVzdWx0IG9u
DQo+ICAgIDMyIGJpdA0KPiAtIGFkZCBhIHJhdGUgdmFyaWFibGUgaW4gZ2V0X3N0YXRlKCkgdG8g
b25seSBjYWxsIGdldF9yYXRlKCkgb25jZQ0KPiAtIHJlZG8gdGhlIGxvY2tpbmcgYXMgc3VnZ2Vz
dGVkIHRvIG1ha2UgaXQgbW9yZSBzdHJhaWdodGZvcndhcmQuDQo+IC0gc3RvcCBjaGVja2luZyBm
b3IgZW5hYmxlbWVudCBpbiBnZXRfc3RhdGUoKSB0aGF0IHdhcyB3b3JraW5nIGFyb3VuZA0KPiAg
IGludGVuZGVkIGJlaGF2aW91ciBvZiB0aGUgc3lzZnMgaW50ZXJmYWNlDQo+IA0KPiBDaGFuZ2Vz
IHNpbmNlIHY5Og0KPiAtIGZpeGVkIHRoZSBtaXNzaW5nIHVubG9jayB0aGF0IERhbiByZXBvcnRl
ZA0KPiANCj4gQ2hhbmdlcyBzaW5jZSB2ODoNCj4gLSBmaXhlZCBhKG5vdGhlcikgcmF3IDY0IGJp
dCBkaXZpc2lvbiAoJiBidWlsdCBpdCBmb3IgcmlzY3YzMiEpDQo+IC0gYWRkZWQgYSBjaGVjayB0
byBtYWtlIHN1cmUgd2UgZG9uJ3QgdHJ5IHRvIHNsZWVwIGZvciAwIHVzDQo+IA0KPiBDaGFuZ2Vz
IHNpbmNlIHY3Og0KPiAtIHJlYmFzZWQgb24gNi4wLXJjMQ0KPiAtIHJld29yZGVkIGNvbW1lbnRz
IHlvdSBoaWdobGlnaHRlZCBpbiB2Nw0KPiAtIGZpeGVkIHRoZSBvdmVya2lsbCBzbGVlcGluZw0K
PiAtIHJlbW92ZWQgdGhlIHVudXNlZCB2YXJpYWJsZXMgaW4gY2FsY19kdXR5DQo+IC0gYWRkZWQg
c29tZSBleHRyYSBjb21tZW50cyB0byBleHBsYWluIGJlaGF2aW91cnMgeW91IHF1ZXN0aW9uZWQg
aW4gdjcNCj4gLSBtYWtlIHRoZSBtdXRleGVzIHVuLWludGVycnVwdGlibGUNCj4gLSBmaXhlZCBh
ZGRlZCB0aGUgMXMgeW91IHN1Z2dlc3RlZCBmb3IgdGhlIGlmKHBlcmlvZF9sb2NrZWQpIGxvZ2lj
DQo+IC0gYWRkZWQgc2V0dXAgb2YgdGhlIGNoYW5uZWxfZW5hYmxlZCBzaGFkb3dpbmcNCj4gLSBm
aXhlZCB0aGUgcGVyaW9kIHJlcG9ydGluZyBmb3IgdGhlIG5lZ2VkZ2UgPT0gcG9zZWRnZSBjYXNl
IGluDQo+ICAgIGdldF9zdGF0ZSgpIEkgaGFkIHRvIGFkZCB0aGUgZW5hYmxlZCBjaGVjaywgYXMg
b3RoZXJ3aXNlIGl0IGJyb2tlDQo+ICAgIHNldHRpbmcgdGhlIHBlcmlvZCBmb3IgdGhlIGZpcnN0
IHRpbWUgb3V0IG9mIHJlc2V0Lg0KPiAtIGFkZGVkIGEgdGVzdCBmb3IgaW52YWxpZCBQRVJJT0Rf
U1RFUFMgdmFsdWVzLCBpbiB3aGljaCBjYXNlIHdlIGFib3J0DQo+ICAgIGlmIHdlIGNhbm5vdCBm
aXggdGhlIHBlcmlvZA0KPiANCj4gQ2hhbmdlcyBmcm9tIHY2Og0KPiAtIERyb3BwZWQgYW4gdW51
c2VkIHZhcmlhYmxlIHRoYXQgSSdkIG1pc3NlZA0KPiAtIEFjdHVhbGx5IGNoZWNrIHRoZSByZXR1
cm4gdmFsdWVzIG9mIHRoZSBtdXRleCBsb2NrKClzDQo+IC0gUmUtcmViYXNlZCBvbiAtbmV4dCBm
b3IgdGhlIE1BSU5UQUlORVJTIHBhdGNoIChhZ2Fpbi4uLikNCj4gDQo+IENoYW5nZXMgZnJvbSB2
NToNCj4gLSBzd2l0Y2hlZCB0byBhIG11dGV4IGIvYyB3ZSBtdXN0IHNsZWVwIHdpdGggdGhlIGxv
Y2sgdGFrZW4NCj4gLSBzaW1wbGlmaWVkIHRoZSBsb2NraW5nIGluIGFwcGx5KCkgYW5kIGFkZGVk
IGxvY2tpbmcgdG8gZ2V0X3N0YXRlKCkNCj4gLSByZXdvcmtlZCBhcHBseSgpIGFzIHJlcXVlc3Rl
ZA0KPiAtIHJlbW92ZWQgdGhlIGxvb3AgaW4gdGhlIHBlcmlvZCBjYWxjdWxhdGlvbiAodGhhbmtz
IFV3ZSEpDQo+IC0gYWRkIGEgY29weSBvZiB0aGUgZW5hYmxlIHJlZ2lzdGVycyBpbiB0aGUgZHJp
dmVyIHRvIHNhdmUgb24gcmVhZHMuDQo+IC0gcmVtb3ZlIHRoZSBzZWNvbmQgKHVzZWxlc3MpIHdy
aXRlIHRvIHN5bmNfdXBkYXRlDQo+IC0gYWRkZWQgc29tZSBtaXNzaW5nIHJvdW5kaW5nIGluIGdl
dF9zdGF0ZSgpDQo+IC0gY291cGxlIG90aGVyIG1pbm9yIGNsZWFudXBzIGFzIHJlcXVlc3RlZCBp
bjoNCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtcmlzY3YvMjAyMjA3MDkxNjAyMDYu
Y3c1bHVvN2t4ZHNob2l1YUBwZW5ndXRyb25peC5kZS8NCj4gDQo+IENoYW5nZXMgZnJvbSB2NDoN
Cj4gLSBkcm9wcGVkIHNvbWUgYWNjaWRlbnRhbGx5IGFkZGVkIGZpbGVzDQo+IA0KPiBDb25vciBE
b29sZXkgKDIpOg0KPiAgICBwd206IGFkZCBtaWNyb2NoaXAgc29mdCBpcCBjb3JlUFdNIGRyaXZl
cg0KPiAgICBNQUlOVEFJTkVSUzogYWRkIHB3bSB0byBQb2xhckZpcmUgU29DIGVudHJ5DQo+IA0K
PiAgIE1BSU5UQUlORVJTICAgICAgICAgICAgICAgICAgICAgIHwgICAxICsNCj4gICBkcml2ZXJz
L3B3bS9LY29uZmlnICAgICAgICAgICAgICB8ICAxMCArDQo+ICAgZHJpdmVycy9wd20vTWFrZWZp
bGUgICAgICAgICAgICAgfCAgIDEgKw0KPiAgIGRyaXZlcnMvcHdtL3B3bS1taWNyb2NoaXAtY29y
ZS5jIHwgMzg5ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gICA0IGZpbGVzIGNo
YW5nZWQsIDQwMSBpbnNlcnRpb25zKCspDQo+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMv
cHdtL3B3bS1taWNyb2NoaXAtY29yZS5jDQo+IA0KDQo=
