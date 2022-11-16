Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 448EA62C8A5
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 20:03:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234322AbiKPTDL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 14:03:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbiKPTDI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 14:03:08 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D3265801D;
        Wed, 16 Nov 2022 11:03:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668625387; x=1700161387;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5dn9p/wNvWgbsKlig7x3CLNWa97vhk8SHYNzurSnV2I=;
  b=PZp2Gth72LCCDYDJ2vievawsXiQNZjJmOUs7IC2Qfv1FqJr/H/QY2sRa
   UxGhIvpQJjXgyCSECvxtqiByy4/h677Tgw27+7v/3AB7VFYopUhpD/4J/
   xr0eOd0WIPejD5EI9PyNqdfytC14HqdPBqOCbcsQeia1XQ940u8c7HXBu
   ufcyHzJZZew6FqOoNBcpJ4kjmpfG0KJoTqwwZfIvbXo9OSsv84P5jTBZH
   Ks2V2lnozLggIzuSoJfl3s08M3qv52sbUbm6hnETQMGSh0y3IA0xJ51gh
   zRfsOO/nD/+xmEV0I6+VIsCHDWS4wfqD8JgQKmBybsjGAjUnmeJATiIua
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="376901458"
X-IronPort-AV: E=Sophos;i="5.96,169,1665471600"; 
   d="scan'208";a="376901458"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2022 11:03:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="633738353"
X-IronPort-AV: E=Sophos;i="5.96,169,1665471600"; 
   d="scan'208";a="633738353"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga007.jf.intel.com with ESMTP; 16 Nov 2022 11:03:06 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 16 Nov 2022 11:03:05 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 16 Nov 2022 11:03:05 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 16 Nov 2022 11:03:04 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 16 Nov 2022 11:03:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WyHUKumoCPm1+wBZ2yISBvfj56WqKx/oFaWHzR5QxtJt0VceRVWsOcfUaCmo4lMK8BXNV3kjHrNsysPZmVelGh8nt+8vlDCa/V/+O5z1wG8w5BoFIDfHErZ7unoaT8FWii/qWyJ5Qh324SpwgaoJyUeXg/YJDUHPRmXJlvrDv2M8w/tRNHFSYozJcdwceWY+2UZqMPzGG3aKdkxcEdilkffkQ4CRvLfCHGz4cWHgSayTcp6CXHb+Vzi8pkE7KS/brDs2N9rR0ssLkmppCAH2oUUJSedexTpAkpGVnS5aIATKFKBb+hx3qA4HXfsU1casq8CxDytkRJUGfnRGV2eoFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5dn9p/wNvWgbsKlig7x3CLNWa97vhk8SHYNzurSnV2I=;
 b=AgtCQMQRSxf48XGWQHQpcIKQda2UdoZ9+gUlmFWnGezElIFvYhs8CQVk0in1YxXgfM8P5+pixrLJQaGj0U2n/VjS3Y9SGVjJI7Z3+7vxrcJI6IVp+60LqwwG0PNtUWIdL9AkZnhVwFa00uVAkRv4J7oxz4C8xvSPqOEF8mbcB2JACOOi1rQ/jGE7xC+k84tRX+6CYpEZwNFjoHCRNg8HKegwlW36QK6USD3abtn25g6w5XK9QVaPe6E8spToO3SWbP5K4l8fxd/A/ARqnXLUezIzUNpGimHCh9r8pzNoXJbS1nxHmrSZg83UTB+s2OBkUR8paUmh2MOUroupKKVnng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by MW4PR11MB5872.namprd11.prod.outlook.com (2603:10b6:303:169::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.19; Wed, 16 Nov
 2022 19:02:59 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::4eea:7bf0:e6b0:5014]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::4eea:7bf0:e6b0:5014%4]) with mapi id 15.20.5813.012; Wed, 16 Nov 2022
 19:02:59 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     "Joseph, Jithu" <jithu.joseph@intel.com>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "markgross@kernel.org" <markgross@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "Macieira, Thiago" <thiago.macieira@intel.com>,
        "Jimenez Gonzalez, Athenas" <athenas.jimenez.gonzalez@intel.com>,
        "Mehta, Sohil" <sohil.mehta@intel.com>
Subject: RE: [PATCH v2 09/14] platform/x86/intel/ifs: Use generic microcode
 headers and functions
Thread-Topic: [PATCH v2 09/14] platform/x86/intel/ifs: Use generic microcode
 headers and functions
Thread-Index: AQHY8vvyIqLlAIN/nk2Y48Ur1ZJbHq457fwAgAgFtj2AAAHwQA==
Date:   Wed, 16 Nov 2022 19:02:59 +0000
Message-ID: <SJ1PR11MB6083B59A7551D79D49B928B9FC079@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20221021203413.1220137-1-jithu.joseph@intel.com>
 <20221107225323.2733518-1-jithu.joseph@intel.com>
 <20221107225323.2733518-10-jithu.joseph@intel.com> <Y253FKtLnmV3r7Kj@zn.tnic>
 <Y3UdO8/oaEnlEk7s@agluck-desk3.sc.intel.com> <Y3UxvAD+rKKQBsYs@zn.tnic>
In-Reply-To: <Y3UxvAD+rKKQBsYs@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|MW4PR11MB5872:EE_
x-ms-office365-filtering-correlation-id: 3efc4c5b-baf7-4b8f-ba6e-08dac8052dac
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JaHY7ZrAQ3pxKr4dHJ2s4KK8riUKZS11L5HneQ7SePHRN++8pf9nO1+0uyWau3p4kptWrYqWeFUPGkK/MawLMK6lkSGB08G4ZwyZdrbsSgRPlUzUZjZZgcwVs1Uh3pTM09AHOU6aHr2OdQFYDeRjRDkAuNlq1kIY2fXfakbvjeMoJtUPbRdsM40fAkFMgmuc0mJn2mOt8iuzk3ctzPVcOL0zLT0x+SrkiHTHX8SIMn4Gdy1+uJ4U6RnhHB8TejnvjJ6gT8QKrpLFVVDhjzsbFcyWg1y2IphYSc0/MDNKtquYr7F08FD00tEjTXYzWOq7XoA/R0qz0/sFp7xJEuKLDE2SnrqDozV67E1ER51+8EO830dgYDqZfgCLs3Rpa6SMmd2AiC4URZe9eSeiMTGjJ1ljSl9gqzXja56jGtv7uKyewSjT6f0dGyKyTiLr7LSC/15bpiq9xEJK8HOEak7fyaBh4mL5ofjRADr+3oszYvYhKeryCUHOhS/E+cFhwibj9WEY0rXU0mFmflDiCZVXFcBhBTf440PFC9DDTxoxY8ryWGwkrECvZkWsBOojHOoAubVfxt22EApyJtgZuhFhjSabRBaaPeEW9J5zkOWAl/d43Bu9Z4StNe1zLmYffTxNfWlOXk3/ZKbdMsw1eOCjbhcCFkbGZHD9QRAjaE6toIT6NYLOUqnH+7TvjPkXojNblUulz5DVZKhFd/jvBJjnTdAG5+uVc09PGPsWqB4WlhfBAFvbQ2nzzPS/D5v9PZouFgyKCGqTgKrlUALhTkTNT8yBM8cNc5J+2HD3Xrwm8CE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(346002)(396003)(39860400002)(136003)(366004)(451199015)(4744005)(52536014)(5660300002)(41300700001)(4326008)(64756008)(66946007)(66556008)(66446008)(66476007)(66899015)(8676002)(76116006)(316002)(6916009)(38070700005)(71200400001)(55016003)(86362001)(2906002)(54906003)(478600001)(33656002)(6506007)(82960400001)(186003)(26005)(8936002)(7416002)(38100700002)(122000001)(7696005)(9686003)(41533002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UmlSNTloTmh0UWhnWUZXV2U3T3huUUZrNEFiNUUyeitLcjRKZHduRnl3LzN6?=
 =?utf-8?B?akJDQXJ2Q1dTMEZtZWdCcDUvMG9aYzF0OUZWV0NUNHJVc3lTeFMyUGhRc2li?=
 =?utf-8?B?TjhTajFIcE1lTXkvc2hrQmpRSzJuQ3RiUW9BR1Bsa0REWlJDMUdEQ2JhcDU4?=
 =?utf-8?B?RU8yR1NzT1ExZ0x1S1Q1RUIxZStUVUNwUjhUT3JwR2RwcGhaa3FsSStlajha?=
 =?utf-8?B?K0hjL0UyeEdaU3VRb1dqbEoxbWlEb0NjelR2UXJad2NTcDRBQWtHVVFyeWJG?=
 =?utf-8?B?OTRrLzc1RjlUbEgxSDhJNFQrNnFiNW5QREk5dHhoQjl1OW5pYmRUemZGYnZS?=
 =?utf-8?B?cHVsOFZ4Q2JIdVRUQ3ljUTRzUEJqNmN4eXJhWDlxVGdYeXU0b0FKQURVcnFU?=
 =?utf-8?B?eENGbUdRSEpGOVFhc1ovOUIwRXkzcG1Cem5zSnhHOFM0RVJEdm1Zd0E2ZXYw?=
 =?utf-8?B?djd1aHEydmI1dTJxYWlReTlua2xqQVN4bnBBL2dHR0xVS2JNZEV2WVEvcEhX?=
 =?utf-8?B?NVV5anVTdFlyYVU0S0pVQ0Fqd0ExeGtLdXdTam5VV0V2YndVMWxYb1R4d0Vi?=
 =?utf-8?B?YVc0V2FtdVVkWXA5SUlCY2gvM0lUb2pzb3RNV0tYSnhYNUpzSThTUHhoQlhn?=
 =?utf-8?B?bGZ3OEdWS1R4UGtWbGtXYW81Nk5QR0l3dysrNE9tM2NTaGs0NXYzUkhWeTIx?=
 =?utf-8?B?UG1Lc3Rnb2R4NFJvRk92TitlRExWcVlad0N4bFUrdU5EM0Z1L1hySTJpdTAy?=
 =?utf-8?B?M0pmV1BKeUdodXNFOFo4MGtnSHlQVnE3S3VLSzJXdDRObXVRekl4THQ0aXFZ?=
 =?utf-8?B?VFc4UHg0KzVBY2ZmRzAvV1FBOFVZSHN2TzNpNnlLSXdXbThJSGlueEZxTEZ1?=
 =?utf-8?B?VnlTQ2VveVd0T1ZMVVRnNTNiM2xoR2dKdXcvL2srbWV4WkFTc0N2bjhCTWhT?=
 =?utf-8?B?UWtQZjN3TldPZ2R4a0dyM1ZUTkRqK3VrS0hUUy9vVFduc1kzQmdBOGNpdSs3?=
 =?utf-8?B?UEhjK0F3MnExYkpKRUFuMEJHY2xhQzRSd0RGWWNuMlJGY0NFYUpTUElvcXEx?=
 =?utf-8?B?eFpFdHl6SlNDS0RESWRBNE1tNlVKc0x1UUhhck5BYmNJS3k4V0Z0WlVnd2Fp?=
 =?utf-8?B?ajROMmNhLzYzTFpDN24wa2NBSDFDZUo1RFZQa1cyTFluV3ZTK2ZtZC9EQkFF?=
 =?utf-8?B?OEcrdGlsTFNuVjlIdVhlNVQ4bnRrdTVvTEttVWlYQzIya0NSS0FOajlTSHdI?=
 =?utf-8?B?THhYMTZtWFoxQ0lrQ0VBRmQ0ZWFEU25jMTFQQXd0UHlhNmpXV09aM2tMV1Z5?=
 =?utf-8?B?Mk1jVFZ3VmlWZ24zOFR1dkx0L241d1lTTXJreGFqZ1ZyVDNhYll4N0FKWTI1?=
 =?utf-8?B?VXExVWh2TGQ0UkFQQzV5dVRmOXdmUVRHRjdoNW9GY0g5akNGR3dMN0VoRS8x?=
 =?utf-8?B?MElqUmtTV0UzOGVyUi9ZUTAwckpZYVcvUE9ycU01bG8zemwvT3c4N3lMUnBI?=
 =?utf-8?B?NkJ1R1dNTVVRN3ZYdlI2WkJIS2p4Mi9TZmdaZHN0eTVtVW9rakwybnRxTTAv?=
 =?utf-8?B?Ym9URUNyaEc1eU96WFFMZHZXRWQvUHdQVWF6KzZxbE1hbm5mWHkzNWxySXU2?=
 =?utf-8?B?Ym5ORXR6WjgyWi8rSXdOdC9oT1JyNmZDVXB6a3FLVkZ1WmFrREcrSldZUTls?=
 =?utf-8?B?R3VmdFJYcEl3TTZzcnNsY2Y2RlVBTXJXZ3JTNWxZT2VDRjNYeVl1WHVDeFo1?=
 =?utf-8?B?ZXBBS0F3UEhpazJueUFQUTdBd2F1c09GMHYvN2ZQeFF3Z1M0U09LUnpFQ1lr?=
 =?utf-8?B?a24yQVNUa0ZnM0pKem5UVkdkNm5IZjJqMFpHVCtCbURQODhVZTFnOXJTK0Zs?=
 =?utf-8?B?UXRpVUtlMzREK0kwNUExZlpCZDVuVzU3T2t0SnlibGxIcm55WTZkRFZzZDha?=
 =?utf-8?B?cGQvLzhucHdjeWFuanQvSmVva1gxTXc3cnA2TmVXZGw2VmlLMnVYbi90NEJq?=
 =?utf-8?B?Y2c3Z2dmOVhlblUyV3FnakZJdC9RUmxLdW9RRWk4MUY3NDc0eW5vLytWZFJ5?=
 =?utf-8?B?VFdHQVFWVzhIRElOL2pYN1hxUFdDdjl5VTRRM05FTmhpb01RS0ZzdjhQWmtq?=
 =?utf-8?Q?Kn6Qse8jrX6SOLKwBeYSkjObD?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3efc4c5b-baf7-4b8f-ba6e-08dac8052dac
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2022 19:02:59.2720
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lEPOpPr/QKvV0J5SiEuEYPdLDl4zPZ+yIU/+TT77ktFek4CY0xeETEsUQYut0LB+Xrvmenj/Hr3S52WfPwzVdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5872
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBIb3cgYWJvdXQgeW91IHN0aWxsIGFsbG9jYXRlIGJ1dCBhdCBkcml2ZXIgaW5pdCB0aW1lLCBp
ZnNfaW5pdCgpIG9yIHNvPw0KPg0KPiBBbmQgZGVhbGxvY2F0ZSBpdCBhdCBkcml2ZXIgcmVtb3Zh
bCBzbyB0aGF0IGl0cyBhbHdheXMgcHJlc2VudCBkdXJpbmcNCj4gdGhlIGRyaXZlcidzIGxpZmV0
aW1lIGFuZCBjYW4gYmUgcmV1c2VkIGVhY2ggdGltZSB0aGUgc2FuaXR5IGNoZWNrIGlzDQo+IGNh
bGxlZC4NCg0KVGhhdCB3b3Jrcy4gTm93IHdlIGhhdmUgbXVsdGlwbGUgZmlsZXMgd2Uga25vdyB0
aGF0IHdlJ2xsIHRha2UgdGhpcw0KcGF0aCBldmVyeSB0aW1lIHVzZXIgc3dpdGNoZXMgdG8gYSBu
ZXcgZmlsZS4NCg0KLVRvbnkNCg==
