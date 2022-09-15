Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A00D5B9859
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 11:56:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbiIOJ4R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 05:56:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230130AbiIOJzc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 05:55:32 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BB7E9A6B6;
        Thu, 15 Sep 2022 02:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1663235492; x=1694771492;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=KWIqOBubqceGstwZlJxRVP7H7POTIP1FuL0LXSCVc90=;
  b=qhfxt0QlAXXQsk6CVIrCmNqk06JZjlaCKQeGCmjyd/IFvCegsCMn2gCK
   hoBdn8xJIjJFARC8NuuP0w/dnZ26BOV1+vWapNI8h0X4/K9S4ktVKViAv
   vw2qU2eSxFStxmR9URGw5xkayUdQBbDilwE7JF989furc0kvmNzjoL7Fa
   TMkeoVmqf3MJiZwYiOzRvrScLy+WlKzPdiyquBYJrLi6xfsCc2J2oatX7
   R3d2JivjcEBGn6os5o5OSzXDboD+AB4AjiWF4pabjbVPpf3pAajDfj/ec
   1PFH1/aChb5CAvCwOEDFiEWeS38YTzt8GSZ2/uwc3F9fNJsT5JriuEp0E
   A==;
X-IronPort-AV: E=Sophos;i="5.93,317,1654585200"; 
   d="scan'208";a="177280104"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Sep 2022 02:51:06 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Thu, 15 Sep 2022 02:51:05 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Thu, 15 Sep 2022 02:51:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U+54b2Vs5JvfiBvEs2cJGKGGE0lkhx3bwKfkomVSMilrxUL+F6+IIkLIsaC0ZBkCSq1djyRQFaqbviwO9CMdg1L6v8+pqqo0AH/QnT1oG9MOZNitn+WCCxd0Ip4qzz6wEpkZxd2X1yoMesfFTaPeXNvxZf09FsqQodSvZquWs+ZOPt1G8yQtlluq3rW0JZVcq+Hbo/Rv7RdgRQk+S/6SrT1qhQgEaRB3DNE1FI55on6AzEzOAr2sVoi6XrysaGsIwuambRdQW84hfCTpSivUfrpt/Gt9KLEa1XzMkdA0bLSJhB7ogHzRQ5K2YOVdPk6KwZyfD5f7gxXnD1K/2lDJpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KWIqOBubqceGstwZlJxRVP7H7POTIP1FuL0LXSCVc90=;
 b=WXmCwvU75UYtTzeJ6htqUwnFsVdYq1k0EEwTvA/KpNBHzffLGGJgQ30SeFzdlsXrwSeQLRE1zd1DY5OyhZYfEqrroPT6X2FzvE/+Wzpil4eIHcTSJ6EpBA66XjYVnyMSLYNq0/Kg9Z/HFzjzXD1WrZ5i5xkNP9vkW/iQ4FBqabcQGDU13XPXEoOjHj/MiErD4uqiGFlt1CD3Ozi9Tjfea/+kWOjqQbx+mqJuzTk+xMLZqer+NX+dh1LIeRpNGpBDp3hNdo5MIy6LsFI/P/rEdcshmAQtQwbhp4N0wWRVp09RRdXpyyUBjDOobHWtq/8MnHHGBwlmOv+u2WGIvr7gmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KWIqOBubqceGstwZlJxRVP7H7POTIP1FuL0LXSCVc90=;
 b=GnI1klX86efNmmKoFSjJPYgjn8mXso1odD0y1TcxYwLaCSBe3CRfg86+kPW+ocTdglT0cwYoVNstCeCfb2RUW6wP8fKYyi8Tu6djXY6jMnQCsCy6Y3fuJMyREY00OjPg6IxG3mGmJOW0dzUKngMcdVB6VyNQqaW5R2y2QRLK5cg=
Received: from BN8PR11MB3668.namprd11.prod.outlook.com (2603:10b6:408:81::24)
 by PH7PR11MB5887.namprd11.prod.outlook.com (2603:10b6:510:136::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Thu, 15 Sep
 2022 09:50:55 +0000
Received: from BN8PR11MB3668.namprd11.prod.outlook.com
 ([fe80::3198:2077:56c7:1780]) by BN8PR11MB3668.namprd11.prod.outlook.com
 ([fe80::3198:2077:56c7:1780%4]) with mapi id 15.20.5632.015; Thu, 15 Sep 2022
 09:50:55 +0000
From:   <Kumaravel.Thiagarajan@microchip.com>
To:     <bagasdotme@gmail.com>, <linux-kernel@vger.kernel.org>,
        <sudipm.mukherjee@gmail.com>, <arnd@arndb.de>,
        <linux-gpio@vger.kernel.org>, <linux-next@vger.kernel.org>,
        <gregkh@linuxfoundation.org>
Subject: RE: [PATCH char-misc-next] misc: microchip: pci1xxxx: use
 DEFINE_SIMPLE_DEV_PM_OPS() in place of the SIMPLE_DEV_PM_OPS() in pci1xxxx's
 gpio driver
Thread-Topic: [PATCH char-misc-next] misc: microchip: pci1xxxx: use
 DEFINE_SIMPLE_DEV_PM_OPS() in place of the SIMPLE_DEV_PM_OPS() in pci1xxxx's
 gpio driver
Thread-Index: AQHYx3cSrZWs5EQIsUK6bl0sIi5laq3do4GQgACI1YCAAhUxQA==
Date:   Thu, 15 Sep 2022 09:50:54 +0000
Message-ID: <BN8PR11MB366868F22CBC68BB885E5911E9499@BN8PR11MB3668.namprd11.prod.outlook.com>
References: <20220912113634.167820-1-kumaravel.thiagarajan@microchip.com>
 <d34d9264-1f0b-d465-bc1d-75f8c736a35b@gmail.com>
 <BN8PR11MB3668C9D5BD38AECBE160D013E9479@BN8PR11MB3668.namprd11.prod.outlook.com>
 <db2fdc22-44b8-1e81-ace2-c83c143ac20e@gmail.com>
In-Reply-To: <db2fdc22-44b8-1e81-ace2-c83c143ac20e@gmail.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN8PR11MB3668:EE_|PH7PR11MB5887:EE_
x-ms-office365-filtering-correlation-id: 44f77a7c-567e-4742-725a-08da96ffc87f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WW6/jb/ECdjXSUH80bpX9LduENv7R707fkqhL/mQCHTe2Zyo6b0knNUPcMVO5/FvEY0zCgX2+1Irk0kh1X2ZwnDJajCq5yF4SIBZHYIvg6U9cdAEgu0+8nH4kdUvg/dCQ8Lz1lSMb24jcVM5Sx8TscZVw2qBnnA/fGVqpJwLDMdnL3PuDZ6UPRWhIEsG5dNvlcnNRRVdNEvlVYEhZD0WF4yZmgK4kVOMwO4q4XddF15L+fAQyPfNWB9hraiVWYrV+iKnH+nHUvf+sMal7tWS9lq8vj+JIFURwj+8sftGY3msMWPVfTRyBgA8cCweAyh3qn049Qe3aHqzHTtLVG2FWZU7KkKStI4H8Rk61tEGsVEzbgB1h4NdPFNhBio/WZ6ZWfUhMGMl2mU4G2QYEGpz7DAS2WtcUFSpZAzjM05iBLUBd4Jjz5lASc69vLnFbb6pVVyvwL3312ygpnLIP5uDQwpaETv+JhLYs2If67eXBRaHKujX8iYt56AyKjZQj6ItMm0jMclN/vL/1ELpm715Rxpf1Z5zjtSVvrlQ3GmGOg9oiKjwTIPGBZ0nJzIEZPHIPelQZHszd1YLxM/DIn3N/6NLTjsJpVvBNn4qV3qeUzUBkRheYYCJ0NBNhK4zuk0CYEFtvzbHvbWw32wKE8xq6IDg+kpeBnUxKycSN32AQq0Y/bpSkTnVsQYv3rHjiPCJFU+ubDQvl7R/nMkeiQGC6iAtJu8KJdM/AJ4MMhe+NTC0Zht1zxIpNMWmy9+CXlj+ctjzxi1vK9RJKekFkwQYHx8w+rBP2vhA6tTlcNSoLOAsaZcD7yz4K+bZnROAhLQM+dp0WpVCDBVZ6BgQMvM25K0wMo5pvUtKBtFbZap6Rjc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR11MB3668.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(376002)(366004)(346002)(396003)(136003)(451199015)(52536014)(122000001)(66946007)(33656002)(186003)(66446008)(8676002)(66476007)(64756008)(478600001)(5660300002)(7696005)(55016003)(38100700002)(38070700005)(66556008)(8936002)(110136005)(41300700001)(86362001)(2906002)(6506007)(53546011)(71200400001)(26005)(83380400001)(316002)(76116006)(9686003)(32563001)(414714003)(473944003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ekl6TlNOdDZMb1lHZE1HbG1ORklRN2lrMFlKS2x6WlVDOFJGb3A0NWpkOFBF?=
 =?utf-8?B?QytkQllvT3RGWmFISklZR1lUa1VBWEVROFcwVkxYUDIwZFZySU91ZmZ0cGM4?=
 =?utf-8?B?SWNXUGtLZGwxcjcrdkhnbVErcHJnVnJmNXMxRUYyMU9uRG53ZzR6Z1cxNDN6?=
 =?utf-8?B?R2R4QUNBNWU4eEtYYjVDZTlWQU5yLzJqNzJrWExKRnhDTllnR0lId3A1Smhm?=
 =?utf-8?B?K09oTUtVY0xvODJ4SFF6MGdRNndNRUdPVW13OEpoQ0NOK3BlTHdQSnRZbHZq?=
 =?utf-8?B?OVcrSlFQMUdjbXE0T21jUEpNaGhnRzl1NFZ5T25OQlJLR3JPS3BVbVdiRTJK?=
 =?utf-8?B?TG1lbWc5TWQ1ZzRzdVZSck5zV0U4aW9IZmZGNUdUbnhRTk1EcGh5cUs1VHBY?=
 =?utf-8?B?eTgyR09UUXZGVkJ4d2cyVjRwZ2c5R3lnR1hUNk1MMlBtVm9sRS9RQnRTVVFX?=
 =?utf-8?B?VEU2aDQ3UG5LanFNSzBQM05peitqOU9kOUVMRmpGa0FJYmlUTmVnNUM2eFZz?=
 =?utf-8?B?ZVhMUUI3UzlBYWJwakZKWCt4Wm5aM1N6N3FBUU9ETW5VZzU1OEhzUC9DcW5P?=
 =?utf-8?B?VTFPY1Nvb245VGNEZDhVWGZKRWh2eWxLb2lJVlZVb0lQNjlTbXFka3hvVC8v?=
 =?utf-8?B?dlhPOWtuK0pONzJyK1JuOUJkalg4RFRQblpvenRmVlZxL1ZZNlFsN0J3Mnhz?=
 =?utf-8?B?U1IyUlYwNTNjYWduUXBkUzdRbU10RExEWVovN1ZVUGs2MTJ6d2FXVkd4Szl0?=
 =?utf-8?B?dXVVcmFndUNyOHp5MEFyUFgzQVRqdHhuNXZ5WXVBQWF5TTZBV3pTWndTMjAr?=
 =?utf-8?B?M1k5L2xMdUdXV0FNbEFxZCtLTEVwL21IcjNzRk95UDA3dzFMOTlLVHgyUXhi?=
 =?utf-8?B?Mnlsek0zRHMxWitPK3cvYTc4WFY1eHRzb1dnMXZjZ2J4dEZKSDlaaHFXdEsy?=
 =?utf-8?B?SUI3alBVdUEwUnovTC9icHhtRm9wc1dLQXozUjhIalBZNlBDemRPYUpnOVZE?=
 =?utf-8?B?ZzBOZEFJemE3VHp6OFZLSnlrcEkvWUEveFh5R1RuU2swOTh6RmFiREtNNWlF?=
 =?utf-8?B?cktjSW5jaHQxUUY3cVRoQXdqYzNsOFlSSi9Ja2xSN3oxQWdSRTBJQ3hMVUs3?=
 =?utf-8?B?UmlDdWhaZkJUbVlKSUlWdVRPTmRIKzlWL202d3R5Wi80TzN2NU9WRWFkQ2Z6?=
 =?utf-8?B?ZmZGSkpqbDk0ZVFxem1MeEhHZFlrQ3dBSCtXb21WdHBTVS9FMGtRY0czb0R5?=
 =?utf-8?B?VEtRTmJJakNqUXVMT3M1eGVaWFB6clA1VXJqaHlkRm11TVZWM3lOZ3VWa2hz?=
 =?utf-8?B?VVVEZ0JQd0xsWDJzWWxWZnp2QnBkakd2dU1jWU9uUUZWTFhvbHhqT3JxZWdE?=
 =?utf-8?B?czlJb1ZVTkh3RFdBcUIxdVliUUhnc0hNalFjdmpHWnFzTEdVY2VRUjRsRVJS?=
 =?utf-8?B?VDZqajNkdFVUQ2NkSUNodGg4TFhIaC9VaXhWYW1CdkhRLzdMeEdkYzB4VUVP?=
 =?utf-8?B?T28vQThzb2F6ekEwRTZlVy9rLzlKQktwV09QSlhkRHN3QklJN2NqakRDeGFx?=
 =?utf-8?B?NnJIWWt2T28vZ1EwWVNPWXBBcGhPTmFnNTBYc3VOWnNlMDRGVm9jRUJYRHpY?=
 =?utf-8?B?MFlObTVucjFvVUhNRDdYZVpJQUFhVStDWk12QWdWNVdjNXFYMkRvTWFSQ2J3?=
 =?utf-8?B?Vm5nb0YwcVhicW1VaW85TkVIeUhKeG83UE1FK0d4N0FHV1MzejRaNDE5aEEx?=
 =?utf-8?B?MWE1cVpuSE5LU0dSaUxYT0ZhSG84aTMrbnRCempybU4wbnQzSHRjdkJFelRW?=
 =?utf-8?B?T1FSTTRtdmpFTXgxekpGSWIwcHVDSzY0UHRNT2EwWThBbDNxNzBjQUkrVmxz?=
 =?utf-8?B?VmE5bnZDN0RRVERBRVlSTlM2cVM1bFVRWkVrSG1ZbG5EbDQwVldaTVFsK3hT?=
 =?utf-8?B?ampiL21sMlBqNjBSQS9Ta0hyTS9GQXlOdkQybjRoNmxobnVxVnpEZ3ZmbnlQ?=
 =?utf-8?B?RTVRUFJTcjFCZjJRMWNpM1lxOHE5TmpON0hEZFVyOGtRZWo3bWJreFhwU21w?=
 =?utf-8?B?R2hUOUNoeHNmaUoyenNwVVp0TzY5OVVwOVNod085R0J5R1JOREs2NmZqL3Vq?=
 =?utf-8?B?NVRJYlpOUGl1b2YyNTRtd2E2ZHN0QXl6cXJVSlpSTXNnN1JvV284UEsvMlB0?=
 =?utf-8?Q?aXJN5V6VN20VnCy5aNGUf/A=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR11MB3668.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44f77a7c-567e-4742-725a-08da96ffc87f
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2022 09:50:55.0343
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nCDiDl9ITQ6D7o8wmAG4MYDXQJex8REtxtUrzjCMqpEZsuAQleyGNI6SsLnMlfSyOPSd1V6akhjAU82ulfzYWXM4ZMpXth44Nrtlg3CZ5va0KhbrelJx7mNmMh2prLs1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5887
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCYWdhcyBTYW5qYXlhIDxiYWdh
c2RvdG1lQGdtYWlsLmNvbT4NCj4gU2VudDogV2VkbmVzZGF5LCBTZXB0ZW1iZXIgMTQsIDIwMjIg
NzozMCBBTQ0KPiBUbzogS3VtYXJhdmVsIFRoaWFnYXJhamFuIC0gSTIxNDE3DQo+IDxLdW1hcmF2
ZWwuVGhpYWdhcmFqYW5AbWljcm9jaGlwLmNvbT47IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5v
cmc7DQo+IHN1ZGlwbS5tdWtoZXJqZWVAZ21haWwuY29tOyBhcm5kQGFybmRiLmRlOyBsaW51eC0N
Cj4gZ3Bpb0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LW5leHRAdmdlci5rZXJuZWwub3JnOw0KPiBn
cmVna2hAbGludXhmb3VuZGF0aW9uLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIGNoYXItbWlz
Yy1uZXh0XSBtaXNjOiBtaWNyb2NoaXA6IHBjaTF4eHh4OiB1c2UNCj4gREVGSU5FX1NJTVBMRV9E
RVZfUE1fT1BTKCkgaW4gcGxhY2Ugb2YgdGhlIFNJTVBMRV9ERVZfUE1fT1BTKCkgaW4NCj4gcGNp
MXh4eHgncyBncGlvIGRyaXZlcg0KPiAgDQo+IE9uIDkvMTQvMjIgMDE6MjcsIEt1bWFyYXZlbC5U
aGlhZ2FyYWphbkBtaWNyb2NoaXAuY29tIHdyb3RlOg0KPiA+PiBPbiA5LzEyLzIyIDE4OjM2LCBL
dW1hcmF2ZWwgVGhpYWdhcmFqYW4gd3JvdGU6DQo+ID4+PiBidWlsZCBlcnJvcnMgbGlzdGVkIGJl
bG93IGFuZCByZXBvcnRlZCBmb3IgdGhlIGJ1aWxkcyBvZiByaXNjdiwNCj4gPj4+IHMzOTAsIGNz
a3ksIGFscGhhIGFuZCBsb29uZ2FyY2ggYWxsbW9kY29uZmlnIGFyZSBmaXhlZCBpbiB0aGlzIHBh
dGNoLg0KPiA+Pj4NCj4gPj4+IGRyaXZlcnMvbWlzYy9tY2hwX3BjaTF4eHh4L21jaHBfcGNpMXh4
eHhfZ3Bpby5jOjMxMToxMjogZXJyb3I6DQo+ID4+ICdwY2kxeHh4eF9ncGlvX3Jlc3VtZScgZGVm
aW5lZCBidXQgbm90IHVzZWQgWy1XZXJyb3I9dW51c2VkLWZ1bmN0aW9uXQ0KPiA+Pj4gICAzMTEg
fCBzdGF0aWMgaW50IHBjaTF4eHh4X2dwaW9fcmVzdW1lKHN0cnVjdCBkZXZpY2UgKmRldikNCj4g
Pj4+ICAgICAgIHwgICAgICAgICAgICBefn5+fn5+fn5+fn5+fn5+fn5+fg0KPiA+Pj4gZHJpdmVy
cy9taXNjL21jaHBfcGNpMXh4eHgvbWNocF9wY2kxeHh4eF9ncGlvLmM6Mjk1OjEyOiBlcnJvcjoN
Cj4gPj4gJ3BjaTF4eHh4X2dwaW9fc3VzcGVuZCcgZGVmaW5lZCBidXQgbm90IHVzZWQNCj4gPj4g
Wy1XZXJyb3I9dW51c2VkLWZ1bmN0aW9uXQ0KPiA+Pj4gICAyOTUgfCBzdGF0aWMgaW50IHBjaTF4
eHh4X2dwaW9fc3VzcGVuZChzdHJ1Y3QgZGV2aWNlICpkZXYpDQo+ID4+PiAgICAgICB8ICAgICAg
ICAgICAgXn5+fn5+fn5+fn5+fn5+fn5+fn5+DQo+ID4+Pg0KPiA+Pg0KPiA+PiBXaGF0IGFib3V0
IHRoaXMgZGVzY3JpcHRpb24/Og0KPiA+Pg0KPiA+PiAiU3VkaXAgcmVwb3J0ZWQgdW51c2VkIGZ1
bmN0aW9uIGVycm9ycyBvbiByaXNjdiwgczM5MCwgY2tzeSwgYWxwaGEsDQo+ID4+IGFuZCBsb29u
Z2FyY2ggKGFsbG1vZGNvbmZpZyk6DQo+ID4+IDxwY2kxeHh4eF9ncGlvXyogZXJyb3JzPi4uLg0K
PiA+Pg0KPiA+PiBGaXggdGhlc2UgZXJyb3JzIGJ5IHVzaW5nIERFRklORV9TSU1QTEVfREVWX1BN
X09QUy4iDQo+ID4gSXQgbG9va3MgZ29vZCBldmVuIHRob3VnaCBpdCBkb2VzIG5vdCBpbmNsdWRl
IGFsbCB0aGUgZGV0YWlscy4NCj4gPiBCdXQgaXMgbm90IGhvdyBtdWNoIG9mIGRldGFpbCBnb29k
IGVub3VnaCBzdWJqZWN0aXZlPw0KPiA+IEkgdGhvdWdodCBzb21lIG1pZ2h0IGJlIGxvb2tpbmcg
Zm9yIG1vcmUgaW5mb3JtYXRpb24gYW5kIGNob3NlIHRoaXMgd2F5Lg0KPiA+IERvIHlvdSB0aGlu
ayBJIG5lZWQgdG8gY2hhbmdlIHRoaXM/IFBsZWFzZSBsZXQgbWUga25vdy4NCj4gDQo+IFllcywg
d2l0aCBmdWxsIGVycm9yIHRleHQgYXMgU3VkaXAgaGFkIHJlcG9ydGVkLg0KWWVzLiBJIGhhZCBp
bmNsdWRlZCBoaXMgbmFtZSBvbmx5IGluIHRoZSBSZXBvcnRlZC1ieTogdGFnIGFuZCBtaXNzZWQg
aXQgaW4gdGhlIGNvbW1pdA0KZGVzY3JpcHRpb24uIEkgaGF2ZSBmaXhlZCBpdCBpbiB2Mi4NCg0K
VGhhbmsgWW91Lg0KDQpSZWdhcmRzLA0KS3VtYXJhdmVsDQo=
