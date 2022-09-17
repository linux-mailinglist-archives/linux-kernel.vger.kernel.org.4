Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41B625BB6A4
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 08:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229436AbiIQG3Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Sep 2022 02:29:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiIQG3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Sep 2022 02:29:22 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D1DC4AD7B
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 23:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663396161; x=1694932161;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=GkpGK2+XPouWaPhpfvr3XDEnuL4zF+lvU4sVZzKija0=;
  b=i30wAwwcmfdO1+2iwNAYjqbLolIprxfM1QZlq+vL9ZaYMywZT5+U9/hq
   LwVuuRMXgvUmMrsnvzpcZasWippKg3lL9k3uqQJfKEuHax4DaRnIHH/HW
   MsXD0s8AxA3+b4st7p+lscd8GCdz02yupBJybZmB1+rwAbW0JB/ZEu6BA
   PZ5bI0ixBav4eQ1pFdLNUM6unYkEa2BzU9xY5LcNm+IKIO57ZB+kHQQG7
   CNC8f+Lmm/aRnPofIOcug8QHh8T1LdBnWzd/uSgxeeOn9FDEUHYaTia7p
   ag3DBIzxeentznDYvvmeiGwDcmI2qstq0RbpDaGxJW0xfbwK1MoMyWwep
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10472"; a="300500005"
X-IronPort-AV: E=Sophos;i="5.93,322,1654585200"; 
   d="scan'208";a="300500005"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2022 23:29:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,322,1654585200"; 
   d="scan'208";a="793329890"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga005.jf.intel.com with ESMTP; 16 Sep 2022 23:29:20 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 16 Sep 2022 23:29:20 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 16 Sep 2022 23:29:20 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 16 Sep 2022 23:29:20 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 16 Sep 2022 23:29:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jhxn09Q/jz0MYLzVhg6adL9jg3kfYKY3NNNb+qChOeBy4mxR04VYQy+2fn+ekxFR/WSm4Ap3ms2BJVb9Y7UHlf66r8iHWO++ch45OtUkMYZt8zgdat74FIdAkvAzc8ziY5h/vST0KggAxADx1F0JruyYvABz1z4r6jB1QITJukv4GLfK6fnmxyLGik5WK/V3EK3gq1u/DIrznPn+7rYXl6cCfTYGJdnPVXGvkcTXteMAgxsMXHWDxET+LzlHVFFI69q1Uah/cAX6SqCqQYjWD4zlGGbo5HqcgHTNaFViL42eHFf8uaW88MT5u8/Tau/XgGteGuhzQE/Bnr1/Yt8HjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GkpGK2+XPouWaPhpfvr3XDEnuL4zF+lvU4sVZzKija0=;
 b=UawkzRqEX08oz2JuJAGLVkeeGmjTph6m3677E52vNG/kP5fnqiroX/QesnQ8R9OJvuNWGIp7lhqaDIfI5a7RSE4B4jFgG3NZzlHxRf2VPOUElaKqbXCdn0gvXHYakyrzbzQfMolXeYIh/xEu7hhQfO6Ms0ghI6UsMJBUG55d4jNOL7V21+Ds55kiyr+AiZJTHZ8cZm954tnj/8tUcRjpyS4U79LZ5RibgMVzMLzmLrFPpISl6UUmzK+zVh8IPHEyEM3eD01uapWjyQrKRHRFUy7dDX7C8cYKYwbAaK4OcPyPFNGZN1fu91iqiNtwco1QSfrEvxQnrJ4gLcWdHTQfQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB5357.namprd11.prod.outlook.com (2603:10b6:5:394::11)
 by IA1PR11MB7387.namprd11.prod.outlook.com (2603:10b6:208:421::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.16; Sat, 17 Sep
 2022 06:29:17 +0000
Received: from DM4PR11MB5357.namprd11.prod.outlook.com
 ([fe80::d539:80cb:2876:b6e8]) by DM4PR11MB5357.namprd11.prod.outlook.com
 ([fe80::d539:80cb:2876:b6e8%5]) with mapi id 15.20.5632.018; Sat, 17 Sep 2022
 06:29:17 +0000
From:   "Arava, Jairaj" <jairaj.arava@intel.com>
To:     Takashi Iwai <tiwai@suse.de>
CC:     Pshou <pshou@realtek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Nujella, Sathyanarayana" <sathyanarayana.nujella@intel.com>,
        "Prabhu, Swarna" <swarna.prabhu@intel.com>,
        "Afzal, Naeem M" <naeem.m.afzal@intel.com>,
        "Hsu, Shui-Wen" <swhsu4021@realtek.com>,
        "Perati, RK" <rk.perati@intel.com>,
        "Mandri, Padmashree" <padmashree.mandri@intel.com>,
        Kailang <kailang@realtek.com>
Subject: Re: Sarien/Dorset device: After system resumed from suspend, 3.5m
 jack is still shown as detected when unplugged during suspend 
Thread-Topic: Sarien/Dorset device: After system resumed from suspend, 3.5m
 jack is still shown as detected when unplugged during suspend 
Thread-Index: AdjI33vqg778sLHVSWSHqfAWugAyCQA1K1KAABNBNlAAFhW+AAABUq1O
Date:   Sat, 17 Sep 2022 06:29:17 +0000
Message-ID: <FB5B44CD-62B6-411F-9E50-289D371AA669@intel.com>
References: <ee87941f7f654213924aa1bc79db32f7@realtek.com>
        <874jx7vdhs.wl-tiwai@suse.de>
        <DM4PR11MB53570968A455F76371004B689F489@DM4PR11MB5357.namprd11.prod.outlook.com>
 <87k062r1k3.wl-tiwai@suse.de>
In-Reply-To: <87k062r1k3.wl-tiwai@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB5357:EE_|IA1PR11MB7387:EE_
x-ms-office365-filtering-correlation-id: 4ffc5992-38fd-469c-f8d1-08da9875f252
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: x8BhwMA3E6gMvJrDIDqFBJWT7bIvycHmXEaiMzW/+OwGbBqhaNFZgHGgY6D8j1EuEkV22Th5Jt0V2Bfe+/anMh0hxvwatbayrvt/OtWlxew12/JGFkqFRZbmZu1QapwEvjhbol9SqTk+w6za+Vb5/ZTyd4e1hguusfj6deaRdqFwGYLrn+G/aUQJIYNNNHgTWbyWBPDpyuYTQKrCEWk/MqiSD1ObD/nZWmHNItN7Gxv3JSXaJWWqOPkxE4W1/5OTf3DU/rSnYOwfZLClVcK/u6wniyYDlxxihnXo9vzWKPByOU1ij0rIIwHcFx/lbjDUU4u1K/apE/wiid03Z41nNrdp9sem0cIhVTrD2bttAaNaXUtEvQ/JW1/DNnP6LWhMkdZiXmVzORj+6U69wFoQtavWeu7Kr1rI6RZAYfpGLuy9McsF5LDQF4xtzz1mDTZiX4rwSulh41ie4FDTVAdNN9AqNnepKsQ/MR7O/3ZIoC622koJJEmj3CPYIlJ0FfvJld71OweAiOcX5hWz24KP4lMf1sZBdZkMoML88E07lc/HOOeLna9U76SObilmz7HImYgS6buwtm+9DF19W5aQx4NqDX049ZXylBQmK1DKEyDkzNkZGL2xjcIlgg0BE4RuvFEdMJUYDJfmtUNv0BK/6HNbjgviWl2svtgKL7t5DaPReJ20h+6uBTVWHq2bHPhfmgkwviUUTeLrYZKH0F6fJdhNJoG/VL1H6nQ3YCgHgBTn7+Gfv7rymYu4C3BxIquFz/HeWeG2BWKECz+SXVPik+Rany8Egl/4ChYoP4Xryd88if1GKfDFWE1WOSUcg8RoslFIcHBdVG6iAdiBwD1S0g5wluu8f50FuHcLadjLSY9QVgWwvwPmSqtHGd3S1Rpr
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5357.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(376002)(396003)(346002)(366004)(136003)(84040400005)(451199015)(6506007)(53546011)(41300700001)(86362001)(186003)(6512007)(4743002)(2906002)(36756003)(2616005)(33656002)(966005)(478600001)(316002)(6916009)(15650500001)(5660300002)(71200400001)(122000001)(8936002)(83380400001)(54906003)(6486002)(82960400001)(38070700005)(76116006)(38100700002)(66946007)(4326008)(8676002)(64756008)(66446008)(66476007)(66556008)(91956017)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TnNIS3NNV3hyMWN2Q2hLNXFBUVB0ZnZ0UnNlQ2p2TjVmNVVoMUJUQXNSdmdy?=
 =?utf-8?B?bTRkOW9FYmJoZzUvNWxydWdXNTRRbEp6MG5OdGFnc3N6K0g5QXVIenc5QlRF?=
 =?utf-8?B?WUxlQ0RGUFRBSlFSUGF6WlI4N3Fja2xyRjEzaWxwNzlka213aTQvTXV5Q3F0?=
 =?utf-8?B?S01DaHMwZEt3VGNnRS81cjlwVGV6a0syd1lMK0dVVXpadXRTdnBjNTNZTmVk?=
 =?utf-8?B?SUo5a0hzZWtiKzBBUkJZVjJ0U1JMejZQS3lzNm1wYmdBUWYwSEJybk4xaXg1?=
 =?utf-8?B?QUl5Q0x0akF0SFhXNVRoSVhnaERkKzRGdjVVeFNJRDk2YU1JZFZQTHJ2V1Jy?=
 =?utf-8?B?bUkrSndCM3VCbjY0N1BSRHQ1T0Yrc2FxNmNoaVR0QVE4M3pFVU56WmVqNlpF?=
 =?utf-8?B?N1J3b3NKOVR0V2JxRTNnM0RNdlJhREpjamRqcDcxcyszM1VUZzY1em5pb2ZD?=
 =?utf-8?B?WE1jSzZsWWJqZEpIU0p4dTZWUXZTdXgvbFVsZWliUWczVjVUWFRMU2R4RVlK?=
 =?utf-8?B?cEZjeG5vRWNPb3E1dGl1Mmh5SVRaMTBUckpOeDVtMUZzQ3ZaNDY1bnpEMi84?=
 =?utf-8?B?UUFKOCtpQnhRMU1XRGV5a2thMkFlTmFJYk0vbDBVbTEzOVEvR0dpYnAzYUlx?=
 =?utf-8?B?MDRmMHBibDZLZXNJQTFxNzZsbnViWmI1S013N3ZCM0x5dDlqU1hpalRwZXpa?=
 =?utf-8?B?OTRDdnN4bTBJV0g2REtpSXRZeUhBZHQvcmEyamlJTndubUZWSjM3WENQOGlh?=
 =?utf-8?B?WWxrRFBCYjRubk1heGcyL2szWmpwaFppam5uNi9wWDhEN1lsU3hYZjlQaEdZ?=
 =?utf-8?B?MTlwUkE3QUF4emRGTWZpNkI0ZDJIVlRSVjd2Mnc1NGhtUzI0NEpYdEhqcllC?=
 =?utf-8?B?VWprNm1zbmJ5ZXovYWZwelNtRGpySVUyRjRVVlRnamdNTXNOWlJ1T0tqUjhn?=
 =?utf-8?B?QTlHYlVnUDB2MVh2d3VvZm9ETUJ5bUVlQlJ6RGtXOHpncEo1ckZNUjRIVUhO?=
 =?utf-8?B?VjdtTUFiOWRYcEowaWhNVWZJMVk5Q1JNbDRpb09WOVVHM0VRaGJFbGNqbzBH?=
 =?utf-8?B?S0hZR0d2eGJyOEVQelRvR2xINjBkVXR6bVdrK0JBUm9NNWtiMUJuTWREKzRN?=
 =?utf-8?B?S0tJU2VBVUptV1cwTmVNb0dGUU1RbmNEblVBd0JNYVY1OFY5Skx5aW5JTlJQ?=
 =?utf-8?B?K1ZxRzAyTkZmRXdmSjdURDQwZlFudVZleGd1akFEdVV5R1gvR1JVR0Jnbk4x?=
 =?utf-8?B?dmgvckVsQjJ3WXpNbkdSaTFLdnJtOElpZ1ZWV1YvRGhGN0djdU05cjh3Y2lK?=
 =?utf-8?B?OVRsdFordjFteTVSejZ0QWZzbU42a2lUU3I0N0lhSUFnRUFITTQ0V3lSYkRv?=
 =?utf-8?B?UUxreCtRWXhISDNzbTFaRC9SNjRjM3VkRVREdHFLT282MDgzektkL1g2MXhz?=
 =?utf-8?B?Y0dJeW0vcGZXZ1JpNjlYdFFIWnhFL0N6dmsrSldzTlBCZUx6K0paNkhOY3cz?=
 =?utf-8?B?bmxBK2h1Ykk5Q0RhNU5Ud0MyVGc3MEEwdUpMbENocHF5c0dxTFl1KytKdjlQ?=
 =?utf-8?B?d2ZaU0d3RFAvSHdUdUd2Y3RmYzVmZ1k0QTJqOVkxckFwNkZNZ3o4Yk1QQ3px?=
 =?utf-8?B?eXVhRWdOVmpMa1lsOENvUTdDMnNQSXN1NEtWL0JoMmFrWTRQdmFqemxWUnNl?=
 =?utf-8?B?YW83TDZTQ2lIOWJwKzBmWGpXV3o5bFNkY01mRUxKdUVLdzM2ay9YV21wM0Y2?=
 =?utf-8?B?UlptWm11M0oyQS9uQVBFWDJyRDdVVkxFUjlZMWs1UEtZSy9VV21MV2NwbGVX?=
 =?utf-8?B?akc4SXZUOC9idTdPeElWVitMNjFtN1VGb0phWWk5Y216K3hkRDNkaDRaWUtE?=
 =?utf-8?B?SEZNeEF5Q1VaVnJSRWhmcGF5aVQrUHhGeUVERjVGeUxKd0xERXhrc3ppZVpi?=
 =?utf-8?B?d3pXU1pBbUNtbEVmZzVqZVJwNnBsLy9EUXhiSkdXRzh0RjVBV0ZzVmUzbEVm?=
 =?utf-8?B?c0h0WVpvRE1pbTJRanczWlNCWVJqOUVzZ3NIR3dPYTRSLzNLWlpZWHpVY3hQ?=
 =?utf-8?B?YzNpRm5MTWkycU1QandqaWFrU1p5MFJkcEwwbmcvSUpvSUpBL20vcC9IVm9u?=
 =?utf-8?B?d1NER1ZjUnhkdHZVd2J3eGV0RVZ3V2pCbDMxcUdYYlh3eUdqUkdvNWJ3b1VR?=
 =?utf-8?B?TVFQd3Fzb3ZwMWtHWkJUTm1OcWRvaU85SklTd1lRUTRheSt4aEZSOTJYS0tm?=
 =?utf-8?B?RlFwQXp4Q0QxME5ESTdWbkRJQzNnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5357.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ffc5992-38fd-469c-f8d1-08da9875f252
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2022 06:29:17.0310
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yTP2+uPYqxyok+X0g0leUMV/JopAG3FxvuHcj8DwEm3UXGXsb4Hgsx0/MCFlPNNhZBpq41J9VnGRh8EtuRom+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7387
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgVGFrYXNoaSwNCg0KQWZ0ZXIgcmVhZGluZyB0aGUgY29tbWVudCMxNywgd2Ugc3RhcnRlZCBs
b29raW5nIGZyb20gY29kZWMgZW5kIGFuZCB3ZSBzZWUgdGhlIHVuc29sIGV2ZW50IGhhbmRsZXIg
aXMgbm90IGludm9rZWQgdG8gaGFuZGxlIGl0ICYgdGhvdWdodCBpdCBpcyBtYW5kYXRlIGZvciB0
aGUgY29kZWMuDQogSG93ZXZlciBhcyBzYWlkLCBieSB3aWxsIGxvb2sgZnVydGhlciBkZWVwIGlu
dG8gaXQuDQoNCkBQc2hvdSwNCldhbnQgdG8gZ2V0IHVuZGVyc3JhbmQgZnJvbSB0aGUgY29kZWMg
ZW5kIGZ1cnRoZXIuIEhvdyBjYW4gd2UgZXhwZWN0IHRoZSBjb2RlYyB0byBiZWhhdmUgZm9yIHN1
Y2ggZXZlbnRzIGR1cmluZyBzdXNwZW5kICYgcmVzdW1lPw0KDQpUaGFua3MsDQpKYWkNCg0KPiBP
biBTZXAgMTYsIDIwMjIsIGF0IDEwOjUxIFBNLCBUYWthc2hpIEl3YWkgPHRpd2FpQHN1c2UuZGU+
IHdyb3RlOg0KPiANCj4g77u/T24gRnJpLCAxNiBTZXAgMjAyMiAyMTo1MDo1MSArMDIwMCwNCj4g
QXJhdmEsIEphaXJhaiB3cm90ZToNCj4+IA0KPj4gSGkgVGFrYXNoaSwNCj4+IA0KPj4gVGhpcyBk
aXNjdXNzaW9uIGlzIHJlZ2FyZGluZyB0aGUgYnVnIGh0dHBzOi8vYnVnemlsbGEua2VybmVsLm9y
Zy9zaG93X2J1Zy5jZ2k/aWQ9MjE1Mjk3Lg0KPiANCj4gRGlkIHlvdSByZWFkIHRoZSBjb21tZW50
IDE3PyAgWW91IGhhdmVuJ3QgYW5hbHl6ZWQgeWV0IHByb3Blcmx5IHdoYXQNCj4gd2FzIGdvaW5n
IHdyb25nLg0KPiANCj4+IEFzIHdlIGtub3cgaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxzYS1k
ZXZlbC8yMDIxMDMxMDExMjgwOS45MjE1LTMtdGl3YWlAc3VzZS5kZS8gaXMgY2F1c2luZyB0aGUg
My41bW0gaGVhZHNldCBqYWNrIGRldGVjdGlvbiBpc3N1ZSBkdXJpbmcgc3lzdGVtIHN1c3BlbmQg
cmVzdW1lLiBTbyBhZnRlciByZXZlcnRpbmcgdGhpcyBwYXRjaCB0aGUgaXNzdWUgaXMgbm90IHNl
ZW4gc2luY2UgdGhlIHVuc29sIGV2ZW50IGlzIGhhbmRsZWQgd2l0aG91dCB0aGlzIHBhdGNoLg0K
Pj4gDQo+PiBTaW5jZSB3ZSAgc2VlIGluIGh0dHBzOi8vZWxpeGlyLmJvb3RsaW4uY29tL2xpbnV4
L2xhdGVzdC9zb3VyY2Uvc291bmQvcGNpL2hkYS9wYXRjaF9yZWFsdGVrLmMjTDk5MiB0aGUgY29k
ZWMgZHJpdmVyIGhhcyAgc25kX2hkYV9qYWNrX3Vuc29sX2V2ZW50IGFzIHRoZSB1bnNvbCBldmVu
dCBoYW5kbGVyLiBIZW5jZSBhZnRlciByZXZlcnRpbmcgeW91ciBwYXRjaCwgZnJvbSBodHRwczov
L2VsaXhpci5ib290bGluLmNvbS9saW51eC9sYXRlc3Qvc291cmNlL3NvdW5kL3BjaS9oZGEvaGRh
X2JpbmQuYyNMNTYgIHRoZSBkcml2ZXIgaXMgY2FsbGluZyBodHRwczovL2VsaXhpci5ib290bGlu
LmNvbS9saW51eC9sYXRlc3Qvc291cmNlL3NvdW5kL3BjaS9oZGEvaGRhX2phY2suYyNMNzEzIHRv
IGhhbmRsZSB0aGUgdW5zb2x2IGV2ZW50Lg0KPj4gDQo+PiBCYXNlZCBvbiBhYm92ZSBvYnNlcnZh
bmNlLCBzZWVtcyBzbmRfaGRhX2phY2tfdW5zb2xfZXZlbnQgaXMgbWFuZGF0b3J5IGZvciB0aGUg
aW50ZWwgcGxhdGZvcm0gUmVhbHRlayBjb2RlYyBkcml2ZXIgdG8gaGFuZGxlIHN1Y2ggdW5zb2x2
IGVuZXRzLiAgSGVuY2UsIEBQc2hvdSBhZGRlZCB0aGUgUE0gZmxhZyBjaGVjayBhcyB0aGUgcGF0
Y2ggd2FzIHRlc3RlZCBieSBOdmlkaWEuDQo+IA0KPiBJZiB0aGUgaGFyZHdhcmUgY2FuJ3QgZGV0
ZWN0IHRoZSBqYWNrIGF0IHRoZSByZXN1bWUgYnkgc29tZSByZWFzb24sDQo+IHRoYXQgbXVzdCBi
ZSB0aGUgY2F1c2UsIGFuZCBub3QgYmVjYXVzZSBpdCBkb2Vzbid0IGhhbmRsZSB0aGUgdW5zb2wN
Cj4gZXZlbnQgZHVyaW5nIHRoZSBzdXNwZW5kLg0KPiANCj4gUGxlYXNlIHRyeSB0byBkZWJ1ZyBt
b3JlIGRlZXBseSBhdCBmaXJzdC4NCj4gDQo+IA0KPiB0aGFua3MsDQo+IA0KPiBUYWthc2hpDQo+
IA0KPj4gDQo+PiBUaGFua3MsDQo+PiBKYWkgDQo+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0t
LQ0KPj4gRnJvbTogVGFrYXNoaSBJd2FpIDx0aXdhaUBzdXNlLmRlPiANCj4+IFNlbnQ6IEZyaWRh
eSwgU2VwdGVtYmVyIDE2LCAyMDIyIDM6MDggQU0NCj4+IFRvOiBQc2hvdSA8cHNob3VAcmVhbHRl
ay5jb20+DQo+PiBDYzogbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgVGFrYXNoaSBJd2Fp
IDx0aXdhaUBzdXNlLmRlPjsgQXJhdmEsIEphaXJhaiA8amFpcmFqLmFyYXZhQGludGVsLmNvbT47
IE51amVsbGEsIFNhdGh5YW5hcmF5YW5hIDxzYXRoeWFuYXJheWFuYS5udWplbGxhQGludGVsLmNv
bT47IFByYWJodSwgU3dhcm5hIDxzd2FybmEucHJhYmh1QGludGVsLmNvbT47IEFmemFsLCBOYWVl
bSBNIDxuYWVlbS5tLmFmemFsQGludGVsLmNvbT47IEhzdSwgU2h1aS1XZW4gPHN3aHN1NDAyMUBy
ZWFsdGVrLmNvbT47IFBlcmF0aSwgUksgPHJrLnBlcmF0aUBpbnRlbC5jb20+OyBNYW5kcmksIFBh
ZG1hc2hyZWUgPHBhZG1hc2hyZWUubWFuZHJpQGludGVsLmNvbT47IEthaWxhbmcgPGthaWxhbmdA
cmVhbHRlay5jb20+DQo+PiBTdWJqZWN0OiBSZTogU2FyaWVuL0RvcnNldCBkZXZpY2U6IEFmdGVy
IHN5c3RlbSByZXN1bWVkIGZyb20gc3VzcGVuZCwgMy41bSBqYWNrIGlzIHN0aWxsIHNob3duIGFz
IGRldGVjdGVkIHdoZW4gdW5wbHVnZ2VkIGR1cmluZyBzdXNwZW5kIA0KPj4gDQo+Pj4gT24gRnJp
LCAxNiBTZXAgMjAyMiAwNzozNDozOCArMDIwMCwNCj4+PiBQc2hvdSB3cm90ZToNCj4+PiANCj4+
PiANCj4+PiBIaSBUYWthc2hpIEl3YWk6DQo+Pj4gDQo+Pj4gQ2FuIHlvdSBoZWxwIG1lIHVwZGF0
ZSB0aGlzIFBBVENIIGZpbGU/DQo+Pj4gDQo+Pj4gQ2hlY2sgaWYgaWdub3JlIHVuc29sIGV2ZW50
cyBkdWluZyBzeXN0ZW0gc3VzcGVuZC9yZXN1bWUgYW5kIE5WSURJQSANCj4+PiBjaGlwIGluIGhk
YV9jb2RlY191bnNvbF9ldmVudCgpLg0KPj4+IA0KPj4+IFNpZ25lZC1vZmYtYnk6UGVpU2VuIEhv
dTxwc2hvdUByZWFsdGVrLmNvbT4NCj4+PiANCj4+PiBTaWduZWQtb2ZmLWJ5OiBKYWlyYWogQXJh
dmEgPGphaXJhai5hcmF2YUBpbnRlbC5jb20+DQo+Pj4gDQo+Pj4gZGlmZiAtLWdpdCBhL3NvdW5k
L3BjaS9oZGEvaGRhX2JpbmQuYyBiL3NvdW5kL3BjaS9oZGEvaGRhX2JpbmQuYw0KPj4+IA0KPj4+
IGluZGV4IDFhODY4ZGQ5ZGM0Yi4uNzU1NjBmZjZlYjgzIDEwMDY0NA0KPj4+IA0KPj4+IC0tLSBh
L3NvdW5kL3BjaS9oZGEvaGRhX2JpbmQuYw0KPj4+IA0KPj4+ICsrKyBiL3NvdW5kL3BjaS9oZGEv
aGRhX2JpbmQuYw0KPj4+IA0KPj4+IEBAIC01MCw3ICs1MCw4IEBAIHN0YXRpYyB2b2lkIGhkYV9j
b2RlY191bnNvbF9ldmVudChzdHJ1Y3QgaGRhY19kZXZpY2UgDQo+Pj4gKmRldiwgdW5zaWduZWQg
aW50IGV2KQ0KPj4+IA0KPj4+ICAgICAgIC8qIGlnbm9yZSB1bnNvbCBldmVudHMgZHVyaW5nIHN5
c3RlbSBzdXNwZW5kL3Jlc3VtZSAqLw0KPj4+IA0KPj4+ICAgICAgaWYgKGNvZGVjLT5jb3JlLmRl
di5wb3dlci5wb3dlcl9zdGF0ZS5ldmVudCAhPSBQTV9FVkVOVF9PTikNCj4+PiANCj4+PiAtICAg
ICAgICAgICAgICAgcmV0dXJuOw0KPj4+IA0KPj4+ICsgICAgICAgICAgICAgIGlmIChjb2RlYy0+
Y29yZS52ZW5kb3JfaWQgPT0gUENJX1ZFTkRPUl9JRF9OVklESUEpDQo+Pj4gDQo+Pj4gKyAgICAg
ICAgICAgICAgICAgICAgICByZXR1cm47DQo+Pj4gDQo+Pj4gICAgICAgaWYgKGNvZGVjLT5wYXRj
aF9vcHMudW5zb2xfZXZlbnQpDQo+Pj4gDQo+Pj4gICAgICAgICAgICAgIGNvZGVjLT5wYXRjaF9v
cHMudW5zb2xfZXZlbnQoY29kZWMsIGV2KTsNCj4+IA0KPj4gSG1tLCB0aGlzIGRvZXNuJ3QgbG9v
ayBzYWZlLiAgV2UgYWxzbyB3YW50IHRvIGF2b2lkIHRoZSB1bnNvbCBldmVudCBoYW5kbGluZyBk
dXJpbmcgdGhlIFBNIHN0YXRlIHRyYW5zaXRpb24sIHRvby4gIFNvLCBpZiBhbnksIHRoaXMgc2hv
dWxkIGJlIGFsbG93ZWQgb25seSBhdCBQTV9FVkVOVF9TVVNQRU5EIG9yIFBNX0VWRU5UX0hJQkVS
TkFURS4NCj4+IA0KPj4gQWxzbywgY2hlY2tpbmcgdGhlIGNvZGVjIHZlbmRvciBJRCBoZXJlIGlz
IG5vIGdvb2Qgd2F5LiAgV2UgbWF5IGFkZCBhIG5ldyBmbGFnIGZvciB0aGUgc3BlY2lhbCBiZWhh
dmlvciAoZWl0aGVyIGFsbG93aW5nIHRoZSB1bnNvbCBoYW5kbGluZyBvciBwcm9oaWJpdGluZyku
DQo+PiANCj4+IEJ1dCwgZnJvbSB5b3VyIHBhdGNoLCBJIGRvbid0IHNlZSBhbnkgcmVhc29uICp3
aHkqIHRoaXMgaGFzIHRvIGJlIGNoYW5nZWQgaW4gdGhhdCB3YXkuICBDb3VsZCB5b3UgZ2l2ZSBt
b3JlIGJhY2tncm91bmRzPw0KPj4gDQo+PiANCj4+IHRoYW5rcywNCj4+IA0KPj4gVGFrYXNoaQ0K
Pj4gDQo=
