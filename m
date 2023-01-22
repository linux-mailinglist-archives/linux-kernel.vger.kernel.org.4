Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96700676B97
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 09:22:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbjAVIWt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 03:22:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbjAVIWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 03:22:46 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B63922711
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jan 2023 00:22:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674375765; x=1705911765;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=YDHA8V69gqGnkexOvlrI2bHGBQIJVmVNHJ5147Zshjk=;
  b=iArX1PGESkPn6FdGp0oYs6uF3MJCXbmg+DrT4rp5soGUqBYaR6mmU6wz
   TvoxDG4U3zvGb4LXJHSv3PB0stUJEPuG7qhPxdr7/wDua01ggjmhMccpW
   +ETpadT/4i5dzXHgAa244VqN+XM7cLW0lSwctqDLS65Kl6ZQr3Nm+J12H
   xX7TVP02fmZKnesvaU1fakvjXlgbEj5TV/Q7Hny3N51Ycb05EoKol46wh
   G+oZQM+yWjXC5ohXTXO7NVR0oBQThvY0UjWVyaLIK91QE188FGbikpIzi
   avw+34dxSFIqWn/90CSt7TiYn8kQgq5+Z0WYe0C+mOB1zSM0DlYQBXlck
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10597"; a="323567670"
X-IronPort-AV: E=Sophos;i="5.97,235,1669104000"; 
   d="scan'208";a="323567670"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2023 00:22:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10597"; a="749835160"
X-IronPort-AV: E=Sophos;i="5.97,235,1669104000"; 
   d="scan'208";a="749835160"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by FMSMGA003.fm.intel.com with ESMTP; 22 Jan 2023 00:22:45 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Sun, 22 Jan 2023 00:22:44 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Sun, 22 Jan 2023 00:22:44 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Sun, 22 Jan 2023 00:22:44 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.49) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Sun, 22 Jan 2023 00:22:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jTS7XfFl4cP9x7z5AaRSWYAq5fyJUZDlaJxVR3hea3o8UGFkK94KbJxctKYsJBPF3WdZ548wjNiW3B1qG6rNXCkFrvdf0VQ/GMU+MN3Q027mlAUkgWlAhl+4F7/7A47rK+aiaRCRPI0AEV26AZc4d5Ebkd8S0nEUTsyGxOk6nn3Vtpt0K5Dqr6C8viHfhwk45nNpQU/kEuYt6QYkC2o0gk48d5M6B3azQpiewpv4IdTDSt5zoZkRYaiAgF4hrob7+owQROgNQqfYHugoT3dZ+ItxQ5vr6Qyw4N+qahS+gCBvR5gFPkHCsHd4f2cU7gDwkwR3uu8wYyECSjPurs5Esg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YDHA8V69gqGnkexOvlrI2bHGBQIJVmVNHJ5147Zshjk=;
 b=NgTJgcJGGcutq/GMzyI8e4CsPk/tWDw0slkRnzRpDB7ztjPtFB0T3e0x0wWYhOEVYVziQ9DQ5RG7qWYRccDaRnCAL7/UVm7C626qgnYexGVIXRWOWHGsc+otwKwnssPxgxn0byt/joovb2ijasR/wNYTG2tfml5OV5F6dMKM/zW7KdIOq63S9Sp22cSbCF9o3UyKOi/n3GY5LJf1PVPIiLf3RkO3aRRia3fQlb0csOSwS+336kc6RM3ilWi9BQJ5SHk/3+GkEeTHpuLQ1W/UXPUwzcOBBWFZFnDvklqZKeN4EHCHenmqPjCbLUiFPgTRGZlZQOYSHuOJoUbhhDVNrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA1PR11MB6734.namprd11.prod.outlook.com (2603:10b6:806:25d::22)
 by IA1PR11MB6323.namprd11.prod.outlook.com (2603:10b6:208:389::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Sun, 22 Jan
 2023 08:22:39 +0000
Received: from SA1PR11MB6734.namprd11.prod.outlook.com
 ([fe80::59d:4c93:47eb:9811]) by SA1PR11MB6734.namprd11.prod.outlook.com
 ([fe80::59d:4c93:47eb:9811%5]) with mapi id 15.20.6002.026; Sun, 22 Jan 2023
 08:22:39 +0000
From:   "Li, Xin3" <xin3.li@intel.com>
To:     "H. Peter Anvin" <hpa@zytor.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
CC:     "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: the x86 sysret_rip test fails on the Intel FRED architecture
Thread-Topic: the x86 sysret_rip test fails on the Intel FRED architecture
Thread-Index: AdksoOwgh+CixkbaRlyKVQgPVVpsjwAVg5YAABeOzAAALxBJsAACU4CAAABdugAABvhwsA==
Date:   Sun, 22 Jan 2023 08:22:39 +0000
Message-ID: <SA1PR11MB67344F0957245A2BC8CA57B7A8CB9@SA1PR11MB6734.namprd11.prod.outlook.com>
References: <SA1PR11MB6734FA9139B9C9F6CC2ED123A8C59@SA1PR11MB6734.namprd11.prod.outlook.com>
 <5d4ad3e3-034f-c7da-d141-9c001c2343af@intel.com>
 <18B5DB6D-AEBD-4A67-A7B3-CE64940819B7@zytor.com>
 <SA1PR11MB673498933098295BFC7C2900A8CB9@SA1PR11MB6734.namprd11.prod.outlook.com>
 <b6e36a5c-6f5e-eda6-54ad-a0c20eb00402@intel.com>
 <65D9F1DE-96D4-4CC7-A21C-A740B7DDE0C8@zytor.com>
In-Reply-To: <65D9F1DE-96D4-4CC7-A21C-A740B7DDE0C8@zytor.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB6734:EE_|IA1PR11MB6323:EE_
x-ms-office365-filtering-correlation-id: 587af2d8-d2d2-4d5a-fb07-08dafc51d320
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2JUM3RF8MBoGu2pKJv4/0WnoTNVwZOX5u0QJaMtpflRvxfxywS8tmc4+8EIeuoB2qOnGcOWmSf7/SUSd87Jw2nW3j44962ek/1iyf9NjEn8lEe/RF8Z6ecQpAf9drcM8APNc3aIx7YOJsMUMXfleuQR8Ocw8UYte4X7UcPAsXUo68yMxuTJT+myOddeuw3xpLWJW7SgaUvbyMxQaISEePNwAQWxC9f4Kew7HPOK7q/RTAmZmP3GUfoZLW0snyBCE/eGyYErf58T9wSnChKEnxd2EqZseBBLpTHFTTWd5I3iB5ThBRcpUsOKAxaE6dZuBgueNy/6tU102mVHgoylF6d3lmEblyAa0A/Nw46j11yRSQHAdP1jBXsWy+hRF0ZC8EdqroQQK7rozJcoNXWqC/9oEQB7Uyz1PvSIMeYKdMo3TcBBzklTBSIGerNW1nyFTb/X5BbzBruuUQycOkoEQC/NTcCD1oqwvbESciJ8eTGYRO23LNnubkbKeShvGW9MxsuchpSo5zUDSSorly9b6RDWiLRhrUg1Sc02/y0Q4B6QZ9/JHNnuiyA0Wv+9VtscAWY7C1Na7cB8mM2YtEbWNq6PXqCwfphaN/QtOrv+XOGEbjO0butAVpO7715zNdXEICx8KRCQiUMy4vspmH/pIW9vw+J0OI4sIEWhYElB5qTLqvFoIOkwnL+N6XP2chDnwvDq6fc84MXNKIZKDYn9DkA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6734.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(346002)(366004)(136003)(396003)(376002)(451199015)(86362001)(55016003)(2906002)(33656002)(4744005)(8676002)(64756008)(41300700001)(76116006)(66476007)(9686003)(26005)(186003)(66946007)(66446008)(66556008)(478600001)(4326008)(71200400001)(38070700005)(6506007)(54906003)(110136005)(122000001)(5660300002)(38100700002)(8936002)(52536014)(82960400001)(316002)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cjZhMllRa3JUdWRpd3hKeEIzU1ZnRFFYcG5PUDJSUGtoNC9yMGdZcW9sR3l5?=
 =?utf-8?B?aFVpdHlWUzhKMkhUY1FYTmkrZXh4NXA4U0IxdWUwZ04wcTZEaWpIaFB5RTR3?=
 =?utf-8?B?dUM1d2F3QzJLc2hOTXR4RTZUbzFGUGQwVDdPRVVoSENFYnBCZCtwVEtZRFg3?=
 =?utf-8?B?UDZPdERrZHlhNkRSQjlpenk3YjlDMU51M0NVdG9IdmpldEYwVlBtTnNXS2Ni?=
 =?utf-8?B?bXdPYnpZdlFBRUdoa3JWbnRPNlduME9uR2I4RmpNVzZLN0ZKSmgzSEhDTy9p?=
 =?utf-8?B?YmJiUmpNNmthN2JqYVgwY1hQYnZjNnpjcUF0SFppWDF5YWhQdWR1dVRLa1Vx?=
 =?utf-8?B?K2V6bWg3b1dzYVpTWTM4eng3SVRMbk5IUnZCaFhmUUhBQ1pmV1Q4YVVKMndh?=
 =?utf-8?B?WmVFWlAxanovcDR6eEkrbHYzU3B3UUNTbldYN05za3U1cDFya004V3pMWEcz?=
 =?utf-8?B?Q2UvTjVENHZRbDlPTHgwTkZncXJKNFV6NXJadFlMeFloaTkxM0kramlZUUdp?=
 =?utf-8?B?N2tlb0lPRkNNbTBzR3BnSEhrOCtJenI0bHR3NE9BNVU0WWlzODRacElXN3Rm?=
 =?utf-8?B?Q0VScVo4dUxpcnFReDM0ZzlILzFNQmNWQkp3Zmc5VUlIWVNsWnIra3I0UVdY?=
 =?utf-8?B?QkpHVURqS2s5ZzBxamJOQ2RlbEZRb09vaXRqNld0Q2o0em9rb3MrcUM5dmtq?=
 =?utf-8?B?MWNEazJ4UTRNVjk2bWZ1ZHJibkx3TVJXSWJjdERUQnZmQjJNdXJMUkFaZXJh?=
 =?utf-8?B?NnVDZ1drQ1lhVWo3N2Z6Q0xRTnR4TlZ1T0g2VEhXM0w0SnB4TXV4U3BQWDN1?=
 =?utf-8?B?TDFxUGthaXBRamNJSmxJWUYrL00vNVJBRDVBVjlFUGRuSyszckVlbU5ZWlFV?=
 =?utf-8?B?NG11MVFQK283Z1lTRGRWelBUZDdmNHNueVIrN2JlTk9lMkpsQjZuUUM1SFYx?=
 =?utf-8?B?bTlVRnZpZzJuRENsczZPY0xYcG44ODVNTHdVS0FaenBaYzY4TWlCVFFDaUdE?=
 =?utf-8?B?T3RvQzJMckdLRmhkSkJJQWNQeTkwTlB1azhVZEUrNmtMeE9zdTN1bG9rR2xY?=
 =?utf-8?B?ZzN4Wm5XYVNabVFGZTJiM1Q3NFNMcWFBVEhJc0h3b3FocnhpR3lxRFlBVEgw?=
 =?utf-8?B?aG95YkpZSUhySWxmRnc3MVVEMWluQW4wbnlickd5UEVmTmswZWNqb05VTFJ6?=
 =?utf-8?B?WDdFLzZlMzUydTJSbzRZZGZGN3Bva0VPS0l1MkZDZDVnT0hKRUExWEpnSEVx?=
 =?utf-8?B?ckFnNkZ0YUZFdHk1NFdmTDlNQm00U3l1ZElpZlh5UEY5VGlhdGxtQWJFOXRU?=
 =?utf-8?B?WFQ4cUU1eHNIQzZWekZrUnFFOVliaUUzK1d3NGlLWVV6QTQwNWdSWmFEQWx4?=
 =?utf-8?B?U1EvK3BHMlpPRnBRSDF4bHQ2S1FjN1N6MnZxY01hSmEzdDhKUHY1UEJuK0th?=
 =?utf-8?B?MTVlSjZjY3UyVDErdFUyNmorRXpkd1JQMG9lR05nQTRXanVIU0FtNWh3bFlv?=
 =?utf-8?B?c0VHZWU2RU1ma3BaRlhiYjl1N2I4T3I3R2ZVQWZIZ3lEYzdQVG1vTEhHbzNC?=
 =?utf-8?B?TUN5MVoranVkTDNnL1J1Tk0wTVh4MWtzN0s2ak51aUpNT2RNSlh4MW9YcVc5?=
 =?utf-8?B?ajhGL05zbWltd3RuMERTWFd1QW9aSUV2ZVpuYUlKYVhMMFNrWFRHVk5kSXpw?=
 =?utf-8?B?NWo5a1BoT2NDVWVEN2J4R1pvZVBiU0tzQ0FPUXYvOEIwTUloNC9EK1FrT3Fu?=
 =?utf-8?B?d29La2twZHpkVUZtU2tYNktvTjBkMDZQWkhDaVBsRkZQY1liY25BcWx3VXhk?=
 =?utf-8?B?ZEMxaUFrdnA2SEhlbm5mSE1xRGgwZG5VTEhpeDZHSUY4U1lrZzB4VWRNSUNw?=
 =?utf-8?B?MzhrRWJUdWVWWExNVy95c2NzYWx1dlg2Qm5DM201SmtzL1AzSW4zdFd1ZUlI?=
 =?utf-8?B?Tk1EZXBGRkFUdFRzWEhEbXFYMFFqOTkrUVI4K3hEV0VaZktaN29wMTU5QVNY?=
 =?utf-8?B?MVJLWHE1emc5eXk5bU8wamlHNU5hV1NZajdWeTRCd2dTTmNZMDRlUHdNRzlB?=
 =?utf-8?B?eVRhTDhuNjlQSDFqeU5uVjl5MXEwQ29BaEdla085Y0JmV3VGdUtaVklvUzl5?=
 =?utf-8?Q?g2RBByLRLQDL7vlch0G1X73vb?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6734.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 587af2d8-d2d2-4d5a-fb07-08dafc51d320
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2023 08:22:39.0426
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xZuIztMEQWZMP3XsAhrd9HwM8KVQqP9fLxPHr69JJJ9R5GIFmIQ4tGVFIYU9lqxKeDP+LmspuuYkFhEggq+Y2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6323
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBKYW51YXJ5IDIxLCAyMDIzIDg6MzQ6MDkgUE0gUFNULCBEYXZlIEhhbnNlbiA8ZGF2ZS5o
YW5zZW5AaW50ZWwuY29tPg0KPiB3cm90ZToNCj4gPk9uIDEvMjEvMjMgMTk6MzgsIExpLCBYaW4z
IHdyb3RlOg0KPiA+Pj4gSG93ZXZlciwgaXQgZG9lc24ndCBzZWVtIHRvIG1ha2Ugc2Vuc2UgdG8g
ZG8gc28gdG8gbWUuIFRoZSBjdXJyZW50DQo+ID4+PiBiZWhhdmlvciBpcyBtdWNoIG1vcmUgb2Yg
YW4gYXJ0aWZhY3QgdGhhbiBkZXNpcmVkIGJlaGF2aW9yLg0KPiA+PiBXZSBraW5kIG9mIGhhdmUg
YW4gYWdyZWVtZW50IHRoYXQgJXIxMSA9ICVmbGFncyBhZnRlciByZXR1cm5pbmcgZnJvbSB0aGUN
Cj4ga2VybmVsLg0KPiA+Pg0KPiA+PiBBbmQgdGhlIHF1ZXN0aW9uIGlzLCBpcyBpdCB3aGF0IHdl
IHdhbnQ/DQo+ID4NCj4gPkNhbiB0aGUgc2VsZnRlc3QganVzdCBzZXQgcjExPXJmbGFncyBiZWZv
cmUgdGhlIHN5c2NhbGw/ICBUaGUgb2xkDQo+ID5zeXNjYWxsIGVudHJ5IHBhdGggd2lsbCBzZXQg
cjExPXJmbGFncy4gIFRoZSBGUkVEIHBhdGggd29uJ3QgdG91Y2ggaXQuDQo+ID5FaXRoZXIgY2Fz
ZSB3aWxsIHBhc3MgYW4gcjExPT1yZmxhZ3MgY2hlY2suDQo+IA0KPiBUaGF0J3MgYSBnb29kIGlk
ZWEuDQoNClRoZSBwcm9ibGVtIGlzIHdoZXJlL2hvdyB0byBzZXQgJXIxMSA9ICVyZmxhZ3MgaW4g
dGhlIHRlc3QgY29kZS4NCg0KVGhlIGNoZWNrIGhhcHBlbnMgaW4gdGhlIFVTRVIxIHNpZ25hbCBo
YW5kbGVyLCBhbmQgd2UgY291bGQgc2V0ICVyMTENCmp1c3QgYmVmb3JlIGNhbGxpbmcgcmFpc2Uo
U0lHVVNSMSkuICBIb3dldmVyLCB0aGUgQyBsaWJyYXJ5IGltcGxlbWVudGF0aW9uDQpvZiByYWlz
ZSgpIG1vZGlmaWVzICVyMTEsIHRodXMgd2UgY2FuJ3QgcHJlc2VydmUgJXIxMSB1bnRpbCB0aGUg
U1lTQ0FMTA0KaW5zdHJ1Y3Rpb24uIEFuZCB0aGUgdGVzdCBzdGlsbCBmYWlscy4NCg0KVGhhbmtz
IQ0KICBYSW4NCg==
