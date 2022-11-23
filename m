Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2365E635108
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 08:20:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235665AbiKWHTz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 02:19:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235343AbiKWHTw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 02:19:52 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FC5BF390D
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 23:19:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1669187986; x=1700723986;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=U5zHRS4HHXXOIuejWCs+MOmOyRsQweo83+7/u/hxy88=;
  b=X1AyBYrA/P98gt/QYOWqgqwtAg/vZGw3rFLKVIe/Sz55EGLd+fltXM8H
   tKFzlF7xaIkySGfSeAcclbfAor4x1Ag9RtPZR0FgQJSx14eQzwjdL8hpF
   38Ub32I6Bab9cYVrUfI7qcFFuyTYP6/8KTXOViG6k+uVXEYTc5oUbhP1F
   CtqT7v1vhQslcDwrjkmjt6vH43ylcf2q8Z5yO2YNNWwM5eZls5uzihQUV
   W7wBvbZesut06AcvrEwtzvUW9dj+/MEKyeQ8y5mBxkXprwFKf/syTRjwM
   F50dogF+Ye5g5UEIK0jOTp0KPvYxzlmg8/h7xTJsz1nMfKEr6+2kAtTUD
   g==;
X-IronPort-AV: E=Sophos;i="5.96,186,1665471600"; 
   d="scan'208";a="190190789"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Nov 2022 00:19:45 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Wed, 23 Nov 2022 00:19:45 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Wed, 23 Nov 2022 00:19:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZXwR/GDC5M+lNGivBxqWiPyVLvVlefJpJjlFxBzycN1SclYfs0xcTo18fGcX6/pSfHDN3axRPgoGeXsiZyqVtdav34fRL3JMjMpKKLp2lnF0XVxa+Df1XmbBGFsGPB+C1nL/Bo0hajDwonvTnS0xUbFtjdYh5kXsCK5jJGKkPfA4Cic+ITlG17ghT2ylqV7ZGkH2PSrsoFOXWd5/v4FNxMlJh/u20ZMJDBsq4fLaH/+EPBvLu3vecqMIBuJOtK40DxtX0cu0K1jmXYA8fODA9rgsXJe15mOIHRjJCXKG7URk8P+Z+o2UckOe2R3beq4doNVv2dbo26lVgDgdOX917Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U5zHRS4HHXXOIuejWCs+MOmOyRsQweo83+7/u/hxy88=;
 b=bNofDUdVyHCIErRadJOFI0ROfRctc0KXeklNSurWHpNncBPbxXKi8TfOno7R6gsFJxcX/Nv2P/QWQhgYdOS/+d1Noyr+dA7HkEC6yHbvgJvVd3QDH0vms9ZkZcBKeUNL7YJhIQU/wWtqfSR9csxyrLRdcQbyflsy+dpbWYdZRJnxkSglA+GBDaMmnXHWKOOAnsWeJDUHYKx/fvOx84GoQOm3bb123J8Jn/V0N0DY25cpQHK7rHEsefLobk5Zqr+w+mftXpMaAGueuNxwLJKN/qQeBcGuT86T+RcPDwIeyLq2caGU4qI7gUUDBXY+puKdL0wyp6o/pCUUfO6fjwNUQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U5zHRS4HHXXOIuejWCs+MOmOyRsQweo83+7/u/hxy88=;
 b=sI9ErtKKEjxvU1HNhMsCCPuk1s4HuBRpWI0AMXG3wq2njO810MycK0RFbH+xDpSpkVD06nBqSdxGk2f5QrEXMUbxqsmv1MLpaw8veMxukxb34YDFnSWGaWYDBrMDdFS7ZBNw9KUrem9lDc5tGQ/0KR3vqKnesVBixCm3A8fZ7oQ=
Received: from BN6PR11MB1953.namprd11.prod.outlook.com (2603:10b6:404:105::14)
 by MW3PR11MB4554.namprd11.prod.outlook.com (2603:10b6:303:5d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Wed, 23 Nov
 2022 07:19:43 +0000
Received: from BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::98f6:c9d1:bb68:1c15]) by BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::98f6:c9d1:bb68:1c15%10]) with mapi id 15.20.5857.017; Wed, 23 Nov
 2022 07:19:42 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <clement.leger@bootlin.com>, <regressions@leemhuis.info>,
        <peda@axentia.se>
CC:     <alexandre.belloni@bootlin.com>, <linux@armlinux.org.uk>,
        <linux-arm-kernel@lists.infradead.org>, <peda@axentia.se>,
        <linux-kernel@vger.kernel.org>, <regressions@lists.linux.dev>
Subject: Re: [PATCH] ARM: at91: fix build for SAMA5D3 w/o L2 cache
Thread-Topic: [PATCH] ARM: at91: fix build for SAMA5D3 w/o L2 cache
Thread-Index: AQHY/wv0Ns1xAxAVsEqa0Uhu4njSRw==
Date:   Wed, 23 Nov 2022 07:19:42 +0000
Message-ID: <a961e0a1-5373-e2e0-3acb-7ef3cc32d846@microchip.com>
References: <b7f8dacc-5e1f-0eb2-188e-3ad9a9f7613d@axentia.se>
 <075d8c0f-5448-73aa-bd3f-0d4e1216e87f@leemhuis.info>
 <20221122181452.6a386296@fixe.home>
In-Reply-To: <20221122181452.6a386296@fixe.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN6PR11MB1953:EE_|MW3PR11MB4554:EE_
x-ms-office365-filtering-correlation-id: 3e2eacd4-2574-4c11-5b7e-08dacd23177a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cvhCFtefEZbuWhFz+hzJl4cla3SsLYCubFKPE25jhc/7MU3HHt5q3MJbVvRW19HIJfzU78lkvUoitY8HmjCdvVAIvt+R+hlqo7aJQDO/jtHU0BPgTRLOjjH2/jWcBQTOQB9ZWS/4KTNIdoI30XxvUDClQaw4Z76U4vR/A2rrzvPOrPN//v3PteMH/6RY8deZZJ7ODFr014MZJ2inat5iO3NKmItRa9t6PxFz2qyuZWipY5dXa3iy8XLaKZycKMyXEDcNuYb0h95dOErrBjHHdvfy3WkN8QtbWpeufDbOAJw3WcMcpTDJh0SJ2wvtGr3paDKeh0Gz/xOrElgnt7AGLF0pcC9S3eiKjdZSkKaZOpu0lHYwQBIGt5xVVizXF5cY4h5tQkSzTLl4/v//DhowNZu8467Cpo6lSnoRYb7AsefPTfhpzCW/hpYnTIJenFSlmO5WbOBj33mYlsQO+nKfLIKY7aSb2BaWnkWC34TPMmlV1d9BhUiWpR3dne0wyvQ/fwQFhyEpgsen9bknwA7yagU7q61daRNyKPNI1oqnlgIDkEtLwQU31tjxE2Md8wdBKt7ZQ82RvPeiS5wnBThASSbXpBaXbfMgWlmoRkVJYviSw27UkxyGTv31CkM6TuKs3FCSXG8pVAbd5vShjmf+uxWeVxlR3PccAlcNgRFtT8anSAWSIXEzZzFLg9//fx3/a9q91ZtULbLSeD+b8juk0/IW1OUK+AAHj5TB/+wmsvw8CMSUqt5GAp4+o0cIrI9gd0pVFl338x4J4kamImMxJCtGzZLWCBZkJtv/nO012/Q=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1953.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(39860400002)(376002)(136003)(346002)(366004)(451199015)(122000001)(38100700002)(86362001)(6506007)(31696002)(38070700005)(53546011)(5660300002)(71200400001)(186003)(76116006)(26005)(66946007)(6512007)(316002)(66446008)(966005)(64756008)(2616005)(91956017)(478600001)(66476007)(6486002)(54906003)(110136005)(4326008)(83380400001)(8676002)(66556008)(2906002)(8936002)(66574015)(41300700001)(66899015)(31686004)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U0NDNnMvR2cvRjRjTEZZUVE0ZFFZY0lEU1pTR0YwVmNJZGNWSU5lblhDbDFk?=
 =?utf-8?B?Y3FqNXpRYWFRb2VUNW81OVVRSVZtQmhCcEpEMkk0RXduTXV1TFhZanRyQUIw?=
 =?utf-8?B?MERkVnEwSEVkRXUzeTFCczM3YllhYkN1N3l1YW1LMnhhV1NIbUxIVEhHazlZ?=
 =?utf-8?B?RzB6Y1UzQjQwb2ZVdDd6SlZvQ3lNcEtoNy9MUVdIbWVwZXFYUHlTSmE5SUlN?=
 =?utf-8?B?b1B1S0hpOGczUWtKWW9weFlmVDVBaS9zcWppS25yYUtVSjZsQmxOT2Evd3pX?=
 =?utf-8?B?TGJZdFI5UXFESHAvcS9ObTdFUXQ3RUt4eGZNdWQ1T0o3dHJUYVRlbFRFWXJv?=
 =?utf-8?B?LzNJOUhlYmV6YVNlMnpuOTRUdkI3UjltcCtDdEhzL2pVL1V6Wk1mQWM4VW9k?=
 =?utf-8?B?V203SGxVNm0zcmdNb2dWVTkrcld5amxIU2pzdVR4MXhBK1FlQkh1ajNjQnlT?=
 =?utf-8?B?dHVJUjRBWFBQWGVpNm50UktCUHpUQVI2c0tTY3lzeURzK2xJbFRMVVlsdDM1?=
 =?utf-8?B?cFNEbXBsbDhXQ1hDU3NJTUw1RktaNzFDenE3cEVDRE5GUU5rc1FpcmRpemU1?=
 =?utf-8?B?VmdDS0JjaktKMEplQU5pYjVGblFUL3F6MzUzWkgyay94R29Zakk2K0RvVHYv?=
 =?utf-8?B?LzVnTHRNb2p2cGVsZmVrTTNHZWtjUlRyOS9TNmhPMHNlSDdaOGc1MCtxSEZo?=
 =?utf-8?B?ZGZ5ODNadXI2YndQa2xNQmhrRmNxbXkveVR2bjhkS2Q2clNiOFQ4VkFlZ2xM?=
 =?utf-8?B?bnpkTW5YWVQvM00waTk3K3RZNDhUb0F6MXJkdGppZHR6cDI0bVZiNSsvdFFi?=
 =?utf-8?B?VG1TdStnTCt0WXRLZlBSZnptcTJwVHUwYTNBQnBWUmZZbGlxNm1wVk5ESlBu?=
 =?utf-8?B?SU5Ecm5ES1RZcVNhN1BNMkQ5bWNVZ2lQUGhYSGNXbHJMLytEamh2NGxDTkVC?=
 =?utf-8?B?MEluZ1A2dk1YQ3BiS0psSHZoYUhaTGVxV01QQmoyQjFnckx3eDlGYUsvdUlJ?=
 =?utf-8?B?aUxyVTNHWStNYVVFZERkbmR5NnZHVFphdityUEhwcGY3VnFZb0puTGNIQjhY?=
 =?utf-8?B?bjlkWHpZUkFUQzgyKzJNVmQyb2RMMkh0ZnFMSlFtNzBqQjB4bGJpMjNTV3pR?=
 =?utf-8?B?RytEWVV0ZTIwOUZRVGJxbnpZNk12ZkFVNTdTWklIS2RodEhQQUE0TUJuREJu?=
 =?utf-8?B?S2ZKbS94MVhTUmFKbjY3TlVmZGdacERhSWZnM0JKRjdzaTF3UlFTdGJqVUNN?=
 =?utf-8?B?Y0hneGp3UlZXWloxWFhLbUk0N3FSUTFqSUM5N2NUcW9iVWhYVlovMzRiZXQ3?=
 =?utf-8?B?ZDhtYXl0K0lpcEg1UzlEZFZRNDZTekhsWSttQkpHNkF3ZmQ0ZFpqN3lyaHE1?=
 =?utf-8?B?M29SV29NOVlWZlFwUzJKcjJNSGkzak5VbmhRdlRJSElPS0lBVFBMcitRd3l3?=
 =?utf-8?B?WGYybEtCbUMxVkRZNGUvcWFJYWQ3d1RQN2FVS1dIRCs0amtCemVhOGQwSlEy?=
 =?utf-8?B?VVRPL0dLYStyOXNDZ1cyT1R6N1JnNlp4NnNKMk9BeWhQbXQ4aVMzcU5qTUpG?=
 =?utf-8?B?YlIvbm84aW9mUlVMZ2s4d3RhRFFmZXlpMmRkOU1OejZPT2JzUW9Mem96MENP?=
 =?utf-8?B?Z0JXamZvZzhZUkxkdzZveWVQK2V5OVZQYmRCNW9CWnlaNzJDMWEzTFh6dnJY?=
 =?utf-8?B?M05ydnBSbFZ5bVUwTm1ndEIzZjJzdGpSVC80aklvTzlURUEyeHBneDdSUUwx?=
 =?utf-8?B?MWdyeit1c2FiTXh6Rm5qd29YU05XS2UxWmpEUGc4OXN1bWJLbTRpOWVYdmVx?=
 =?utf-8?B?czlwV01MYU85dDlySkY4S21ucThGNzlLblBOL1pMSTFlaTRrWG9KMDlpU3hB?=
 =?utf-8?B?WFFQQzVXa0ZtQjVvY3B6N1ZrR1R2SDNLcmUySjlxZEhWaEluaTEyaVBFbU05?=
 =?utf-8?B?OHBtbkZkdXZWb1Z6QjNkaTdYWjdQNmtUdDN1Y2E3MmZiZ3pqaXdmeVA0a1hv?=
 =?utf-8?B?YTdTbTUxYzFWQTZOaHplWnpZTXgwWHAwa3BTSGl2UGJxSXFZallHUXJ1QkU3?=
 =?utf-8?B?ZGxpdmo3c0NITjRmYXI0eU1YQXpmSnRLUzFKOU1uazR1RDhkbWVJdXNNVm5i?=
 =?utf-8?B?R2hmZnUrTFN3bEpvL1FJd2hsYjNnWVZQWFl5TjBZc21pbEtJMUFRbGxzTThC?=
 =?utf-8?B?RFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A9898834260C7441A8E6D132C7CBF6FE@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1953.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e2eacd4-2574-4c11-5b7e-08dacd23177a
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2022 07:19:42.7321
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rAjfQwQLB/7JjnGaPYGPmMkq91eILinPlV7JyQGd7dxc5gCaa/TppE/RAWpwyVV93uSZkour9HWsRXF3GH6KtpJ4g8hfzCTHwSI/bk0S4jc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4554
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,T_SPF_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjIuMTEuMjAyMiAxOToxNCwgQ2zDqW1lbnQgTMOpZ2VyIHdyb3RlOg0KPiBFWFRFUk5BTCBF
TUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBr
bm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IExlIFR1ZSwgMjIgTm92IDIwMjIgMTY6MTM6
NDAgKzAxMDAsDQo+IFRob3JzdGVuIExlZW1odWlzIDxyZWdyZXNzaW9uc0BsZWVtaHVpcy5pbmZv
PiBhIMOpY3JpdCA6DQo+IA0KPj4gSGksIHRoaXMgaXMgeW91ciBMaW51eCBrZXJuZWwgcmVncmVz
c2lvbiB0cmFja2VyLg0KPj4NCj4+IE9uIDEyLjExLjIyIDE2OjQwLCBQZXRlciBSb3NpbiB3cm90
ZToNCj4+PiBUaGUgTDIgY2FjaGUgaXMgcHJlc2VudCBvbiB0aGUgbmV3ZXIgU0FNQTVEMiBhbmQg
U0FNQTVENCBmYW1pbGllcywgYnV0DQo+Pj4gYXBwYXJlbnRseSBub3QgZm9yIHRoZSBvbGRlciBT
QU1BNUQzLiBBdCBsZWFzdCBub3QgYWx3YXlzLg0KDQpQZXRlciwgd2hhdCBkbyB5b3UgbWVhbiBi
eSAiYXQgbGVhc3Qgbm90IGFsd2F5cyIgaGVyZT8gQXJlIHlvdSB0YWxraW5nDQphYm91dCB0aGUg
T1VURVJfQ0FDSEUgZmxhZz8NCg0KPj4+DQo+Pj4gU29sdmVzIGEgYnVpbGQtdGltZSByZWdyZXNz
aW9uIHdpdGggdGhlIGZvbGxvd2luZyBzeW1wdG9tOg0KPj4+DQo+Pj4gc2FtYTUuYzooLmluaXQu
dGV4dCsweDQ4KTogdW5kZWZpbmVkIHJlZmVyZW5jZSB0byBgb3V0ZXJfY2FjaGUnDQo+Pj4NCj4+
PiBGaXhlczogM2I1YTdjYTdkMjUyICgiQVJNOiBhdDkxOiBzZXR1cCBvdXRlciBjYWNoZSAud3Jp
dGVfc2VjKCkgY2FsbGJhY2sgaWYgbmVlZGVkIikNCj4+PiBTaWduZWQtb2ZmLWJ5OiBQZXRlciBS
b3NpbiA8cGVkYUBheGVudGlhLnNlPg0KPj4NCj4+IENsw6ltZW50IEzDqWdlciBhbmQgQ2xhdWRp
dSBCZXpuZWE6IHdoYXQncyB1cCBoZXJlPyANCg0KSXQgd2lsbCBiZSBpbiB0aGUgbmV4dCBBVDkx
IGZpeGVzIFBSLg0KDQpJcyB0aGVyZSBhIHBhcnRpY3VsYXINCj4+IHJlYXNvbiB3aHkgdGhpcyBw
YXRjaCBkaWQgZ2V0IGFueSBmZWVkYmFjayBmcm9tIHlvdSBieSBub3c/IEl0J3MgdGVuDQoNClNv
bWV0aGluZyB3cm9uZyB3aXRoIHRoZSBlbWFpbCBjbGllbnQgb24gbXkgc2lkZSBhcyBJIGxvc3Qg
dGhpcyBwYXRjaC4gSXQNCmlzIGJhY2sgb24gbXkgcmFkYXIgc2luY2UgUGV0ZXIgcmVwbGllZCB0
byBpdC4NCg0KDQo+PiBkYXlzIG9sZCBhbmQgUGV0ZXIgYWxyZWFkeSBzZW50IGEga2luZCBvZiBy
ZW1pbmRlciBhIGZldyBkYXlzIGFnby4NCj4gDQo+IEhpIFRob3JzdGVuLA0KPiANCj4gU29ycnkg
Zm9yIHRoZSBsYWNrIG9mIGFuc3dlciwgSSdtIG5vdCBzdXJlIGFib3V0IHRoZSBiZXN0IHNvbHV0
aW9uIHRvDQo+IHRhY2tsZSB0aGlzIHByb2JsZW0uIGFkZGluZyBJU19FTkFCTEVEKENPTkZJR19P
VVRFUl9DQUNIRSkgc2VlbXMgbGlrZSBhDQo+IGdvb2Qgd2F5IHRvIGF2b2lkIG1vZGlmeWluZyB0
aGUgd2hvbGUgY29uZmlndXJhdGlvbi4gSWYgb2sgZm9yIENsYXVkaXUsDQo+IEkgdGhpbmsgaXQg
aXMgdGhlIGJlc3QgdGhpbmcgdG8gZG8gc2luY2UgaXQgd2lsbCB3b3JrIGZvciBhbGwgY2FzZXMu
DQo+IA0KPiBDbMOpbWVudA0KPiANCj4+DQo+PiBSZW1pbmRlciwgaWRlYWxseSB0aGlzIHJlZ3Jl
c3Npb24gc2hvdWxkIGJlIGZpeGVkIGJ5IG5vdy4gRm9yIGRldGFpbHMNCj4+IHNlZSB0aGUgc2Vj
dGlvbiAiUHJpb3JpdGl6ZSB3b3JrIG9uIGZpeGluZyByZWdyZXNzaW9ucyIgIGluDQo+PiBEb2N1
bWVudGF0aW9uL3Byb2Nlc3MvaGFuZGxpbmctcmVncmVzc2lvbnMucnN0ICgNCj4+IGh0dHBzOi8v
ZG9jcy5rZXJuZWwub3JnL3Byb2Nlc3MvaGFuZGxpbmctcmVncmVzc2lvbnMuaHRtbCApDQo+Pg0K
Pj4gQ2lhbywgVGhvcnN0ZW4gKHdlYXJpbmcgaGlzICd0aGUgTGludXgga2VybmVsJ3MgcmVncmVz
c2lvbiB0cmFja2VyJyBoYXQpDQo+Pg0KPj4gUC5TLjogQXMgdGhlIExpbnV4IGtlcm5lbCdzIHJl
Z3Jlc3Npb24gdHJhY2tlciBJIGRlYWwgd2l0aCBhIGxvdCBvZg0KPj4gcmVwb3J0cyBhbmQgc29t
ZXRpbWVzIG1pc3Mgc29tZXRoaW5nIGltcG9ydGFudCB3aGVuIHdyaXRpbmcgbWFpbHMgbGlrZQ0K
Pj4gdGhpcy4gSWYgdGhhdCdzIHRoZSBjYXNlIGhlcmUsIGRvbid0IGhlc2l0YXRlIHRvIHRlbGwg
bWUgaW4gYSBwdWJsaWMNCj4+IHJlcGx5LCBpdCdzIGluIGV2ZXJ5b25lJ3MgaW50ZXJlc3QgdG8g
c2V0IHRoZSBwdWJsaWMgcmVjb3JkIHN0cmFpZ2h0Lg0KPj4NCj4+PiAtLS0NCj4+PiAgYXJjaC9h
cm0vbWFjaC1hdDkxL3NhbWE1LmMgfCAyICstDQo+Pj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2Vy
dGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPj4+DQo+Pj4gSGkhDQo+Pj4NCj4+PiBJJ20gbm90IHN1
cmUgdGhpcyBpcyB0aGUgY29ycmVjdCBzb2x1dGlvbj8gTWF5YmUgU0FNQTVEMyBzaG91bGQgYnJp
bmcNCj4+PiBpbiBDT05GSUdfT1VURVJfQ0FDSEUgdW5jb25kaXRpb25hbGx5IGluc3RlYWQ/IEJ1
dCB0aGF0IHNlZW1zIGxpa2UgYQ0KPj4+IGJpZ2dlciBjaGFuZ2UsIGFuZCBub3QganVzdCBhIHR3
ZWFrIG9mIHRoZSByZWdyZXNzaW5nIGNvbW1pdC4uLg0KPj4+DQo+Pj4gQ2hlZXJzLA0KPj4+IFBl
dGVyDQo+Pj4NCj4+PiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vbWFjaC1hdDkxL3NhbWE1LmMgYi9h
cmNoL2FybS9tYWNoLWF0OTEvc2FtYTUuYw0KPj4+IGluZGV4IDY3ZWQ2OGZiZTNhNS4uYmYyYjVj
NmExOGM2IDEwMDY0NA0KPj4+IC0tLSBhL2FyY2gvYXJtL21hY2gtYXQ5MS9zYW1hNS5jDQo+Pj4g
KysrIGIvYXJjaC9hcm0vbWFjaC1hdDkxL3NhbWE1LmMNCj4+PiBAQCAtMjYsNyArMjYsNyBAQCBz
dGF0aWMgdm9pZCBzYW1hNV9sMmMzMTBfd3JpdGVfc2VjKHVuc2lnbmVkIGxvbmcgdmFsLCB1bnNp
Z25lZCByZWcpDQo+Pj4gIHN0YXRpYyB2b2lkIF9faW5pdCBzYW1hNV9zZWN1cmVfY2FjaGVfaW5p
dCh2b2lkKQ0KPj4+ICB7DQo+Pj4gICAgIHNhbV9zZWN1cmVfaW5pdCgpOw0KPj4+IC0gICBpZiAo
c2FtX2xpbnV4X2lzX29wdGVlX2F2YWlsYWJsZSgpKQ0KPj4+ICsgICBpZiAoSVNfRU5BQkxFRChD
T05GSUdfT1VURVJfQ0FDSEUpICYmIHNhbV9saW51eF9pc19vcHRlZV9hdmFpbGFibGUoKSkNCj4+
PiAgICAgICAgICAgICBvdXRlcl9jYWNoZS53cml0ZV9zZWMgPSBzYW1hNV9sMmMzMTBfd3JpdGVf
c2VjOw0KPj4+ICB9DQo+Pj4NCj4gDQo+IA0KPiANCj4gLS0NCj4gQ2zDqW1lbnQgTMOpZ2VyLA0K
PiBFbWJlZGRlZCBMaW51eCBhbmQgS2VybmVsIGVuZ2luZWVyIGF0IEJvb3RsaW4NCj4gaHR0cHM6
Ly9ib290bGluLmNvbQ0KDQo=
