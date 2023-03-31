Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3AA46D29A4
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 22:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231425AbjCaUvQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 16:51:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbjCaUvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 16:51:11 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2075.outbound.protection.outlook.com [40.107.244.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B6572223F
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 13:51:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aVMrSiAi+Qs0lpng3565fLHv1NUIx0eyitIWm+Q9RtUsskqfUixAYISC3bN7hw52h2UgqpHpENr0Zz/MZIlN4ZE8/vOyHqNmGen1vw5PIgytMXO777gUMpd181cZ3886C8zN9sHbXEgH4txalxWovR9vHqZNjdeAwMkCQoJZLlk5ARA76hidCSM+3aYyLZKkdUWFC9d6Mhd62ZfOn6ygSlnrIBx/hGCFQWR4pfvtC323/t3jFzVWsL2/bZt4NUbYoKJC29sCyAPMGSPcgxMtwH0Oe4Z7UhsGdqzq7oZyqfU+0WYlndIysrzV3r7qmuGkYRLE31RJL9yevnnP5aK4mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KaUNO9h3jzj4L4H6P3mF1s/2H/5hCYzQ/i3ZwXTpb9g=;
 b=KbM91UmFeUnT8eRzQMG94TpBYeS+q+1WpYLpA9YbhXMtCXaFUjuJrALpXu1tRZAqd1x9fb05YvVUAmy6DHF8agxUvs+Qa2jIyk/xgoHAGJ/anjCeoZPczTf3gsDXVnBmu1ttUKIH22FzUW7nMCcHYmSUv+zh2uAbpl5/vViOw4Jn8sIV1PqLaDRUDvGcPUOEZn5WqTkKA19VhLqULL1YRdQxIGuBqNhDUjYGwIrmmrdNiPdKqIzS+ImlRv8qItZoFlnLfzUf0I9P29MF/I1kSuzty9xOrPHwwmg10M1uEmDyOJTBz3pWADun7cG+2/wMewMlwLvy8LV80puCR5VG+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KaUNO9h3jzj4L4H6P3mF1s/2H/5hCYzQ/i3ZwXTpb9g=;
 b=V3VmQQWUPjgkiA/UEaVt7uyFagtFMs+XWjuaTEQWmDa2VBjevHzkmhwzA9DjqMvDdHGitJ0k0aMxVbkxV1kPvBk5ScWtWhjLgkEmT3P6uAlmQOCYECPXE9xkXJ/SyL8biHyudQSQ0nEYf1OITncl5i6PW3zTezXGViAz7dXJObE=
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by BL0PR12MB4930.namprd12.prod.outlook.com (2603:10b6:208:1c8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.23; Fri, 31 Mar
 2023 20:51:03 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::3490:de56:de08:46f6]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::3490:de56:de08:46f6%9]) with mapi id 15.20.6254.021; Fri, 31 Mar 2023
 20:51:03 +0000
From:   "Moger, Babu" <Babu.Moger@amd.com>
To:     Peter Newman <peternewman@google.com>
CC:     "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "eranian@google.com" <eranian@google.com>,
        "fenghua.yu@intel.com" <fenghua.yu@intel.com>,
        "gupasani@google.com" <gupasani@google.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "reinette.chatre@intel.com" <reinette.chatre@intel.com>,
        "skodak@google.com" <skodak@google.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: RE: [PATCH v5 3/3] Documentation/x86: Documentation for MON group
 move feature
Thread-Topic: [PATCH v5 3/3] Documentation/x86: Documentation for MON group
 move feature
Thread-Index: AQHZYw9nytEi+CX+4ESf+eumOq4p3a8TlVeAgAD1hICAANK68A==
Date:   Fri, 31 Mar 2023 20:51:03 +0000
Message-ID: <MW3PR12MB4553A032A6E30BDD583A5466958F9@MW3PR12MB4553.namprd12.prod.outlook.com>
References: <f826dd28-0213-b7ea-494c-8c7a0ff348ce@amd.com>
 <20230331081209.3170293-1-peternewman@google.com>
In-Reply-To: <20230331081209.3170293-1-peternewman@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-03-31T20:51:01Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=63c34778-d951-43c8-965f-086412277f37;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2023-03-31T20:51:01Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: aecc38f2-99f6-4429-a5fe-85c3d7c207a8
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW3PR12MB4553:EE_|BL0PR12MB4930:EE_
x-ms-office365-filtering-correlation-id: 9991b765-b6de-4c9f-f6dc-08db3229a43a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4IAfNk69Nn59cmktuG37NIfLU7aagbeherU0gWN02CL4hGwXIUfJyTU6sPs5FmGpWkXw1k1ySZ4sqUIHvfrYfWGNSOKvUC0LsiymcjsYND071cJSIuq0guSt/+qnc59tRhqGaqHlxd+04aw3slf1lviciFHv/VPnoEGMkAMNgX4y/3Xzjb9IVXqhT92SBGsn++gfkNx4SU+RFp8uLKW/wf9gBQUNjuPD6aK99OLVNknz0p2NCA9WhdO0OKwY/eSb3EqfVpXa4zWpOmes10NLMnKMpdbK5xwipyb3wVbebLZlQsam0JNJ0yCXNhREZr4IjSqLRmASuLA//3YLkDczSP9JbKbtFV3/IzWoF4eN8mYA3YiVdCJbO/Zz88kCWvL0uL3E5BWeSSsplmmxOUlju5DBFiyIQrTJtEMD09WUNspwGz/AfuXBEi5dZTY7WPWYNxRU8A6c/GStsy0TlIXH81No4Djjd8RdD0uIhulZhTdi34e9cU4H+tCxJPHNuVlJ3aV1ILpfkkJ5tVOkc532uQJxalOR/1LS0qiDdfteX9aHc4Sk8Xss4JkLkJ24FFFwry1cuhMtwxIWopV39D8goIXYCsMM0rR7PXIhaht+ZcOMaXIVsqKcEmDWL/y2CPTb
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(366004)(136003)(39860400002)(396003)(451199021)(55016003)(6506007)(186003)(53546011)(8936002)(9686003)(5660300002)(86362001)(7416002)(38070700005)(66476007)(76116006)(66946007)(54906003)(316002)(478600001)(52536014)(26005)(83380400001)(41300700001)(66556008)(2906002)(33656002)(122000001)(4326008)(7696005)(66446008)(64756008)(38100700002)(71200400001)(6916009)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NTNhSXo1RXlQRG13bVJsQnltM0JyS0RGZHZDTGY0THFsbmtOTlBQcElybUov?=
 =?utf-8?B?dnRnQlN0aUZGbUVwWWJTTGd5MUFkSngzRkhKYWZOWG51dXErdFBqMlAyVE9p?=
 =?utf-8?B?Tnl5ZFg0b1hFK21Bc2hJU3VEdis2b1NVbGxmRmVuYUxDcXlJOEUvcmM0WmxB?=
 =?utf-8?B?cStsOWtVS1hxT0lJakFIOEl6blR1bCtpQlJLQW04dnM5UHhqQ2dUT24zWGtH?=
 =?utf-8?B?QXk2QS9BdzJpSnZJMUJuRHNhaHJNR1Fjc1JvT0ZhczhXVEY1b1dmWWJtMmY3?=
 =?utf-8?B?c2lSNjk4eUlZY0toRm5UbmFTTzRFZ1N2alZEWlhQTXlKanBHVHZpelg3SXFm?=
 =?utf-8?B?VGViSDFub25EMXBiZ0xYYklyQWd3NnR0bHZFYWJLVWFPci9mWjdBRFl1YWFm?=
 =?utf-8?B?MGJTbXlzR1dDb0laQitYcWVZS1ZBUUhtb0RKT1l0d0lvZVdleTNHdDF0MG0r?=
 =?utf-8?B?M3YyLzJ5aVk3U01GL1BxU3ZhUFRoTU9Qcm1KTEhHUlM5aFJQRks1UDJwcW5i?=
 =?utf-8?B?c0VGQXNWTHlHbGVlMklyWTdSNVVOcDcrZWNQTFJ6SjJITE5FZUJyUktSYyta?=
 =?utf-8?B?SHVPMkZ2Mng3T2dZWTQ3U2xIekY1dzRBODZtenVJbFI2VEJ2bVN4ZUZ5blZq?=
 =?utf-8?B?L0lrMHpENTNYOHNzVXNzdG9QVFY1UXA0NnhHMnMrQlBLSzJnK053VWo0Ym9z?=
 =?utf-8?B?c3ZBT2ZvQ2JPMnFqbGdYUDVjRW5YUHFjcDN0SzYwUDhrRm4xbkhLaUFtbFFC?=
 =?utf-8?B?Ykxlc1lyU0NtYjk1a0VDTTFoV2FCS1BkaVBkSDFiS05MMEd5VHl5THVyUW9t?=
 =?utf-8?B?SGJPbm9zZWpvQnQ5UlNUd0JTRjVpaUZqRVRWN3M5ckg1QTJiQzl1RldRMGh6?=
 =?utf-8?B?Rm5sTkMwQ0tYYnNUc1V0dGRHblVoUjNmbEk5eUVRcUhJZTZwNVFzRk5uYjRZ?=
 =?utf-8?B?R20wT3dyU1hPSkh5czZaZXFqQ1JDbDRsOERRRFBoeCs5VG1ESjlpM0dsNEhu?=
 =?utf-8?B?dDRhYXJINDZWMVg3a0JZZERnT3dwTE9BRVpCcWtNa3lSNXZKb0xxc3RPdUxw?=
 =?utf-8?B?endyYWV2UHZZNW5qT01RK2ZRbGNjcys5elRvQWN5MUxDTmRIQUhjdHlrKzMx?=
 =?utf-8?B?c1lDRGk4b3V2UGtYUkRjRHF4VDJTMXBic0xOZW1VVVhheHZ2bWFsM2tzUDY2?=
 =?utf-8?B?bGpwZy94RDFlWTB1K0lOaWhZL1ZNams2cnRMRWVPWkdqUFVGVkN4V3JBQ2ND?=
 =?utf-8?B?L0o3ZDVCak55eGNDc1BvK0tid0xMMUpKN2JVaHNlMUF5bXhmNmVrVUloOUlC?=
 =?utf-8?B?YmRLTHZKd1Z0VlpyclZOSzZRTm1wcEd4TXBmRm0vUENIT1Z2dGptT20yeTVm?=
 =?utf-8?B?MzVsUWlLdDNMdGhpdDFtbWhYdHFLdmZ5SW5sZEJTL3dOM0tNWHY4Um9HMUw0?=
 =?utf-8?B?VmVRMVplU21SZE9uMlpsQ1g1Nk5ub05aUmE4eERRcjJuYnJnMmFmSW5yNEZ6?=
 =?utf-8?B?SUVHTWgyTmZBSnRzUURQVVVGM21YRERKb1M1dlNqamg0QTZ6b0lld1YyNWM3?=
 =?utf-8?B?aWg5RStra0tjUDl6V2ZvblpCS3pjWUdMSFFjTzRLWkplT1BQZC80emZJTkdt?=
 =?utf-8?B?M2hlRE14eXQyd1JPam82SVh5dFM4VmgvZHRBZmhSNjhpWmlmeTBvbnZFN0hR?=
 =?utf-8?B?UEJNMFFZRjdEa1NVZ0RuZFZoY1Q4WGU4SFZYV1Z0eURNek96VUpqMG8wL1pL?=
 =?utf-8?B?QlNPZWgvV3NGRzgyZVlPOXo4NUMraldRUUx2ZEFnNTBKSDkrWUdrV1JReTl3?=
 =?utf-8?B?NXdtYWRFeTNvVkxrcGJ3TnJrOE1LMnlEVnFMaWZIQlFmcGhWT3FjQlNBWmZk?=
 =?utf-8?B?S08zTFdqNDhUSytkUldWVFNsTUZ1RzFGWFNSZm0zTy80T2ZEb0xJQkxJL3F0?=
 =?utf-8?B?dXl3aU9rajc1UkRKbTJGOWg3SGE1OHc3aWtkQk9CSlhwLzZZL0Z2MGRCUkZK?=
 =?utf-8?B?Mk05TElQNFFOVy81VEk5UXVrczB5cjJucWJYcGxGaTRsR2JOZnFxcytoSmpS?=
 =?utf-8?B?TjUwUVh6aEVhUGN3NXI5TElQMmtSVHV5SU1CbWUwZnVNUTltdHJHUDMxcnZR?=
 =?utf-8?Q?IxGs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9991b765-b6de-4c9f-f6dc-08db3229a43a
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2023 20:51:03.3304
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m7BzeK0s6XI7c5ybuX6JokZoF5s684PIf1w8bsF9AHBkbDmKV2gyM2vokF01gwpW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4930
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCkhpIFBldGVyLA0KDQo+IC0tLS0t
T3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFBldGVyIE5ld21hbiA8cGV0ZXJuZXdtYW5A
Z29vZ2xlLmNvbT4NCj4gU2VudDogRnJpZGF5LCBNYXJjaCAzMSwgMjAyMyAzOjEyIEFNDQo+IFRv
OiBNb2dlciwgQmFidSA8QmFidS5Nb2dlckBhbWQuY29tPg0KPiBDYzogYnBAYWxpZW44LmRlOyBk
YXZlLmhhbnNlbkBsaW51eC5pbnRlbC5jb207IGVyYW5pYW5AZ29vZ2xlLmNvbTsNCj4gZmVuZ2h1
YS55dUBpbnRlbC5jb207IGd1cGFzYW5pQGdvb2dsZS5jb207IGhwYUB6eXRvci5jb207DQo+IGph
bWVzLm1vcnNlQGFybS5jb207IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IG1pbmdvQHJl
ZGhhdC5jb207DQo+IHBldGVybmV3bWFuQGdvb2dsZS5jb207IHJlaW5ldHRlLmNoYXRyZUBpbnRl
bC5jb207IHNrb2Rha0Bnb29nbGUuY29tOw0KPiB0Z2x4QGxpbnV0cm9uaXguZGU7IHRvbnkubHVj
a0BpbnRlbC5jb207IHg4NkBrZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjUgMy8z
XSBEb2N1bWVudGF0aW9uL3g4NjogRG9jdW1lbnRhdGlvbiBmb3IgTU9ODQo+IGdyb3VwIG1vdmUg
ZmVhdHVyZQ0KPiANCj4gSGkgQmFidSwNCj4gDQo+IE9uIFRodSwgTWFyIDMwLCAyMDIzIGF0IDc6
MzPigK9QTSBNb2dlciwgQmFidSA8YmFidS5tb2dlckBhbWQuY29tPg0KPiB3cm90ZToNCj4gPiBP
biAzLzMwLzIzIDA4OjU1LCBQZXRlciBOZXdtYW4gd3JvdGU6DQo+ID4gPiBEZXNjcmliZSBuZXcg
c3VwcG9ydCBmb3IgbW92aW5nIE1PTiBncm91cHMgdG8gYSBuZXcgcGFyZW50IENUUkxfTU9ODQo+
ID4gPiBncm91cCBhbmQgaXRzIHJlc3RyaWN0aW9ucy4NCj4gPg0KPiA+IFNvcnJ5IGZvciBjb21p
bmcgaW4gbGF0ZSBoZXJlLiBJIGFtIHBsYW5uaW5nIHRvIHRlc3QgdGhlc2UgcGF0Y2hlcy4gSXQN
Cj4gPiB3b3VsZCBiZSBoZWxwZnVsIHRvIGdpdmUgYSBzaW1wbGUgZXhhbXBsZSB0byB0ZXN0IHRo
aXMgZmVhdHVyZS4NCj4gDQo+IERvIHlvdSBtZWFuIGlubGluZSBpbiB0aGUgZG9jdW1lbnRhdGlv
bj8NCg0KWWVzLiBJdCB3b3VsZCBiZSBoZWxwZnVsLiAgSSB1c2VkIHRoZXNlIHNpbXBsZSBzdGVw
cyBmcm9tIHlvdXIgc2NyaXB0Lg0KIyBtb3VudCAgLXQgcmVzY3RybCByZXNjdHJsIC9zeXMvZnMv
cmVzY3RybC8NCiMgY2QgL3N5cy9mcy9yZXNjdHJsLw0KIyBta2RpciBfdGVzdF9jMQ0KIyBta2Rp
ciBfdGVzdF9jMg0KbCMgbWtkaXIgbW9uX2dyb3Vwcy9fdGVzdF9tMQ0KIyBlY2hvIDEgPiBtb25f
Z3JvdXBzL190ZXN0X20xL2NwdXMNCiMgbWtkaXIgX3Rlc3RfYzEvbW9uX2dyb3Vwcy9fdGVzdF9j
MV9tMQ0KbCMgIGVjaG8gJCQgPiBfdGVzdF9jMS90YXNrcw0KbCMgIGVjaG8gJCQgPiBfdGVzdF9j
MS9tb25fZ3JvdXBzL190ZXN0X2MxX20xL3Rhc2tzDQpsIyAgbXYgX3Rlc3RfYzEvbW9uX2dyb3Vw
cy9fdGVzdF9jMV9tMS8gX3Rlc3RfYzIvbW9uX2dyb3Vwcy8NCiMgY2F0IGluZm8vbGFzdF9jbWRf
c3RhdHVzDQpvaw0KbCMgIG12IG1vbl9ncm91cHMvX3Rlc3RfbTEgX3Rlc3RfYzEvbW9uX2dyb3Vw
cy8NCm12OiBjYW5ub3QgbW92ZSAnbW9uX2dyb3Vwcy9fdGVzdF9tMScgdG8gJ190ZXN0X2MxL21v
bl9ncm91cHMvX3Rlc3RfbTEnOiBPcGVyYXRpb24gbm90IHBlcm1pdHRlZA0KIyBjYXQgaW5mby9s
YXN0X2NtZF9zdGF0dXMNCkNhbm5vdCBtb3ZlIGEgTU9OIGdyb3VwIHRoYXQgbW9uaXRvcnMgQ1BV
cw0KDQo+IA0KPiBGb3Igbm93LCB5b3UgY2FuIGFsc28gdHJ5IHRoZSBwYXRjaCBiZWxvdy4gVGhl
c2UgYXJlIHRoZSB0ZXN0Y2FzZXMgSSB1c2VkLg0KPiANCj4gSSdtIHBsYW5uaW5nIHRvIGNvbnZl
cnQgbWFueSBvZiBvdXIgaW50ZXJuYWwsIHNoZWxsIHNjcmlwdC1iYXNlZCB0ZXN0IGNhc2VzIGlu
dG8NCj4ga2VybmVsIHNlbGZ0ZXN0cyBzbyBJIGNhbiB0cnkgdG8gdXBzdHJlYW0gdGhlbS4NCg0K
WWVzLiBUaGF0IHdpbGwgYmUgZ3JlYXQuDQpUaGFua3MNCkJhYnUNCg0KDQo+IA0KPiBUaGFua3Mh
DQo+IC1QZXRlcg0KPiANCj4gDQo+IC0tLTg8LS0tLS0tLQ0KPiBGcm9tIGY2ZDIxNWU5MGRiM2M0
MTZiZDM5ODg5YjlmYTExNDNkNzk4MjQ1ZTAgTW9uIFNlcCAxNyAwMDowMDowMA0KPiAyMDAxDQo+
IEZyb206IFBldGVyIE5ld21hbiA8cGV0ZXJuZXdtYW5AZ29vZ2xlLmNvbT4NCj4gRGF0ZTogVHVl
LCA3IE1hciAyMDIzIDExOjU3OjAzICswMTAwDQo+IFN1YmplY3Q6IFtQQVRDSF0gc2VsZnRlc3Rz
L3Jlc2N0cmw6IFRlc3QgZm9yIE1PTiBncm91cCByZW5hbWluZw0KPiANCj4gU2lnbmVkLW9mZi1i
eTogUGV0ZXIgTmV3bWFuIDxwZXRlcm5ld21hbkBnb29nbGUuY29tPg0KPiAtLS0NCj4gIHRvb2xz
L3Rlc3Rpbmcvc2VsZnRlc3RzL3Jlc2N0cmwvTWFrZWZpbGUgICAgICB8ICAgMiArDQo+ICAuLi4v
c2VsZnRlc3RzL3Jlc2N0cmwvdGVzdF9tb25ncnBfbW92ZS5zaCAgICAgfCAxMjAgKysrKysrKysr
KysrKysrKysrDQo+ICAyIGZpbGVzIGNoYW5nZWQsIDEyMiBpbnNlcnRpb25zKCspDQo+ICBjcmVh
dGUgbW9kZSAxMDA3NTUgdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvcmVzY3RybC90ZXN0X21vbmdy
cF9tb3ZlLnNoDQo+IA0KPiBkaWZmIC0tZ2l0IGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvcmVz
Y3RybC9NYWtlZmlsZQ0KPiBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3Jlc2N0cmwvTWFrZWZp
bGUNCj4gaW5kZXggNzNkNTMyNTdkZjQyLi4wYjY5NmU3Y2YxOWIgMTAwNjQ0DQo+IC0tLSBhL3Rv
b2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3Jlc2N0cmwvTWFrZWZpbGUNCj4gKysrIGIvdG9vbHMvdGVz
dGluZy9zZWxmdGVzdHMvcmVzY3RybC9NYWtlZmlsZQ0KPiBAQCAtNSw2ICs1LDggQEAgQ0ZMQUdT
ICs9ICQoS0hEUl9JTkNMVURFUykNCj4gDQo+ICBURVNUX0dFTl9QUk9HUyA6PSByZXNjdHJsX3Rl
c3RzDQo+IA0KPiArVEVTVF9QUk9HUyA6PSB0ZXN0X21vbmdycF9tb3ZlLnNoDQo+ICsNCj4gIGlu
Y2x1ZGUgLi4vbGliLm1rDQo+IA0KPiAgJChPVVRQVVQpL3Jlc2N0cmxfdGVzdHM6ICQod2lsZGNh
cmQgKi5jKSBkaWZmIC0tZ2l0DQo+IGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvcmVzY3RybC90
ZXN0X21vbmdycF9tb3ZlLnNoDQo+IGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvcmVzY3RybC90
ZXN0X21vbmdycF9tb3ZlLnNoDQo+IG5ldyBmaWxlIG1vZGUgMTAwNzU1DQo+IGluZGV4IDAwMDAw
MDAwMDAwMC4uNmQ5YmZjNGUwYzhkDQo+IC0tLSAvZGV2L251bGwNCj4gKysrIGIvdG9vbHMvdGVz
dGluZy9zZWxmdGVzdHMvcmVzY3RybC90ZXN0X21vbmdycF9tb3ZlLnNoDQo+IEBAIC0wLDAgKzEs
MTIwIEBADQo+ICsjIS9iaW4vc2gNCj4gKw0KPiArc2V0IC1lDQo+ICsNCj4gK3JjPTANCj4gKw0K
PiArY2xlYW51cCgpDQo+ICt7DQo+ICsJcm1kaXIgX3Rlc3RfKg0KPiArCXJtZGlyIG1vbl9ncm91
cHMvX3Rlc3RfKg0KPiArfQ0KPiArDQo+ICtza2lwX2FsbCgpDQo+ICt7DQo+ICsJZWNobyBCYWls
IG91dCEgJDENCj4gKw0KPiArCWNsZWFudXANCj4gKw0KPiArCSMgU0tJUCBjb2RlIGlzIDQuDQo+
ICsJZXhpdCA0DQo+ICt9DQo+ICsNCj4gK2V4cGVjdF9zdWNjZXNzKCkNCj4gK3sNCj4gKwlpZiBb
ICIkMSIgLWVxIDAgXTsgdGhlbg0KPiArCQllY2hvIG9rICQyDQo+ICsJZWxzZQ0KPiArCQllY2hv
IG5vdCBvayAkMg0KPiArCQlyYz0xDQo+ICsJZmkNCj4gK30NCj4gKw0KPiArZXhwZWN0X2ZhaWwo
KQ0KPiArew0KPiArCWlmIFsgIiQxIiAtZXEgMCBdOyB0aGVuDQo+ICsJCWVjaG8gbm90IG9rICQy
DQo+ICsJCXJjPTENCj4gKwllbHNlDQo+ICsJCWVjaG8gb2sgJDINCj4gKwlmaQ0KPiArfQ0KPiAr
DQo+ICtpZiBbICIkKGlkIC11KSIgIT0gMCBdOyB0aGVuDQo+ICsJc2tpcF9hbGwgIm11c3QgYmUg
cnVuIGFzIHJvb3QiDQo+ICtmaQ0KPiArDQo+ICtpZiBbICEgLWQgL3N5cy9mcy9yZXNjdHJsL2lu
Zm8gXTsgdGhlbg0KPiArCW1vdW50IC10IHJlc2N0cmwgcmVzY3RybCAvc3lzL2ZzL3Jlc2N0cmwg
fHwgc2tpcF9hbGwgIm5vIHJlc2N0cmxmcyINCj4gK2ZpDQo+ICsNCj4gK2NkIC9zeXMvZnMvcmVz
Y3RybA0KPiArDQo+ICtpZiBbICEgLWYgaW5mby9MM19NT04vbW9uX2ZlYXR1cmVzIF07IHRoZW4N
Cj4gKwlza2lwX2FsbCAibm8gbW9uaXRvcmluZyBzdXBwb3J0Ig0KPiArZmkNCj4gKw0KPiAraWYg
WyAhIC1mIHNjaGVtYXRhIF07IHRoZW4NCj4gKwlza2lwX2FsbCAibm8gYWxsb2NhdGlvbiBzdXBw
b3J0Ig0KPiArZmkNCj4gKw0KPiArZWNobyAiMS4uMTEiDQo+ICsNCj4gK2lmIFsgLWQgX3Rlc3Rf
YzEgXSB8fCBbIC1kIF90ZXN0X2MyIF0gfHwgWyAtZCBtb25fZ3JvdXBzL190ZXN0X20xIF07IHRo
ZW4NCj4gKwlza2lwX2FsbCAidGVzdCBkaXJlY3RvcmllcyBhbHJlYWR5IGV4aXN0Ig0KPiArZmkN
Cj4gKw0KPiArbWtkaXIgX3Rlc3RfYzENCj4gK21rZGlyIF90ZXN0X2MyDQo+ICtta2RpciBfdGVz
dF9jMw0KPiArDQo+ICtta2RpciBtb25fZ3JvdXBzL190ZXN0X20xDQo+ICtlY2hvIDEgPiBtb25f
Z3JvdXBzL190ZXN0X20xL2NwdXMNCj4gKw0KPiArbWtkaXIgX3Rlc3RfYzEvbW9uX2dyb3Vwcy9f
dGVzdF9tMQ0KPiArZWNobyAkJCA+IF90ZXN0X2MxL3Rhc2tzDQo+ICtlY2hvICQkID4gX3Rlc3Rf
YzEvbW9uX2dyb3Vwcy9fdGVzdF9tMS90YXNrcw0KPiArDQo+ICtpZiBtdiBfdGVzdF9jMS9tb25f
Z3JvdXBzL190ZXN0X20xIF90ZXN0X2MyL21vbl9ncm91cHM7IHRoZW4NCj4gKwllY2hvICJvayAx
ICMgTU9OIGdyb3VwIG1vdmUgdG8gbmV3IHBhcmVudCBzdWNjZWVkZWQiDQo+ICtlbHNlDQo+ICsJ
ZWNobyAiMS4uMCAjIHNraXAgYmVjYXVzZSBNT04gZ3JvdXAgbW92ZSB0byBuZXcgcGFyZW50IG5v
dA0KPiBzdXBwb3J0ZWQiDQo+ICsJY2xlYW51cA0KPiArCWV4aXQgNA0KPiArZmkNCj4gKw0KPiAr
c2V0ICtlDQo+ICsNCj4gK2dyZXAgLXEgJCQgX3Rlc3RfYzIvdGFza3MNCj4gK2V4cGVjdF9zdWNj
ZXNzICQ/ICIyICMgUElEIGluIG5ldyBDVFJMX01PTiBncm91cCINCj4gKw0KPiArZ3JlcCAtcSAk
JCBfdGVzdF9jMi9tb25fZ3JvdXBzL190ZXN0X20xL3Rhc2tzDQo+ICtleHBlY3Rfc3VjY2VzcyAk
PyAiMyAjIFBJRCByZW1haW5zIGluIE1PTiBncm91cCBhZnRlciBtb3ZlIg0KPiArDQo+ICtncmVw
IC1xICQkIF90ZXN0X2MxL3Rhc2tzDQo+ICtleHBlY3RfZmFpbCAkPyAiNCAjIFBJRCBubyBsb25n
ZXIgaW4gcHJldmlvdXMgQ1RSTF9NT04gZ3JvdXAiDQo+ICsNCj4gK212IF90ZXN0X2MyL21vbl9n
cm91cHMvX3Rlc3RfbTEvY3B1cyBtb25fZ3JvdXBzIGV4cGVjdF9mYWlsICQ/ICI1ICMNCj4gK21v
dmluZyBmaWxlcyBub3QgYWxsb3dlZCINCj4gKw0KPiArbXYgX3Rlc3RfYzIvbW9uX2dyb3Vwcy9f
dGVzdF9tMSBfdGVzdF9jMi9tb25fZ3JvdXBzL190ZXN0X20yDQo+ICtleHBlY3Rfc3VjY2VzcyAk
PyAiNiAjIHNpbXBsZSBNT04gZGlyZWN0b3J5IHJlbmFtZSINCj4gKw0KPiArbXYgX3Rlc3RfYzIv
bW9uX2dyb3Vwcy9fdGVzdF9tMiBpbmZvDQo+ICtleHBlY3RfZmFpbCAkPyAiNyAjIG1vdmUgdG8g
aW5mbyBub3QgYWxsb3dlZCINCj4gKw0KPiArbXYgX3Rlc3RfYzIvbW9uX2dyb3Vwcy9fdGVzdF9t
MiBfdGVzdF9jMi9tb25fZ3JvdXBzL21vbl9ncm91cHMNCj4gK2V4cGVjdF9mYWlsICQ/ICI4ICMg
cmVuYW1lIHRvIG1vbl9ncm91cHMgbm90IGFsbG93ZWQiDQo+ICsNCj4gK212IG1vbl9ncm91cHMv
X3Rlc3RfbTEgX3Rlc3RfYzEvbW9uX2dyb3VwcyBleHBlY3RfZmFpbCAkPyAiOSAjIGNhbm5vdA0K
PiArbW92ZSBncm91cHMgbW9uaXRvcmluZyBDUFVzIg0KPiArDQo+ICttdiBtb25fZ3JvdXBzL190
ZXN0X20xIG1vbl9ncm91cHMvX3Rlc3RfbTIgZXhwZWN0X3N1Y2Nlc3MgJD8gIjEwICMNCj4gK2dy
b3VwcyBtb25pdG9yaW5nIENQVXMgY2FuIGJlIHJlbmFtZWQiDQo+ICsNCj4gK212IG1vbl9ncm91
cHMvX3Rlc3RfbTIvbW9uX2RhdGEgX3Rlc3RfYzEvbW9uX2dyb3VwcyBleHBlY3RfZmFpbCAkPyAi
MTENCj4gKyMgY2Fubm90IG1vdmUgc3ViZGlyZWN0b3JpZXMgb2YgYSBtb25fZ3JvdXAiDQo+ICsN
Cj4gK2NsZWFudXANCj4gKw0KPiArZXhpdCAkcmMNCj4gLS0NCj4gMi40MC4wLjQyMy5nZDZjNDAy
YTc3Yi1nb29nDQo=
