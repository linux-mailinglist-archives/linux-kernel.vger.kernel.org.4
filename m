Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2137B5FF393
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 20:27:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbiJNS1A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 14:27:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbiJNS04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 14:26:56 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69F211849B1;
        Fri, 14 Oct 2022 11:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665772015; x=1697308015;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=q+Rcarng8FQDxia8LXDIrKKR2xLnEPDA40FA2yBpoxU=;
  b=CRuttM6sybZPhjXMcJ/8YTspV0kRgYVW0NngqkWTlWYcc1TPE9dY1G3L
   FqyAlkiep4Ces526j4AoPBbezaETmVmnwneLNms04fnL8va4Qu7rNIsRJ
   cncAliTxxAowwdVTkL7vKIFndDd9BLJgzFIaKGq8I8/mDFYYAY7st/S4o
   cW6NF5Eu5MBPrQ49+eOD8bVfMtnbgXe3eGgjtH9DxGlWuChxzQ4XijqkC
   33xRYTDa7zFhrXfoQXsDtaQXLdSmAau+EfmxaHOaIi81lLiLDEi2p8Pee
   pNITPANCPCX1HGGYBsl/x6ALaD6l5/5M0oNeKWKjU/10iboV26OwN7D9K
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10500"; a="391747055"
X-IronPort-AV: E=Sophos;i="5.95,185,1661842800"; 
   d="scan'208";a="391747055"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2022 11:26:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10500"; a="660822631"
X-IronPort-AV: E=Sophos;i="5.95,185,1661842800"; 
   d="scan'208";a="660822631"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga001.jf.intel.com with ESMTP; 14 Oct 2022 11:26:54 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 14 Oct 2022 11:26:54 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 14 Oct 2022 11:26:54 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 14 Oct 2022 11:26:54 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 14 Oct 2022 11:26:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kOKSPEzjVnmQNHugjp+mqjFMXxMylLRn/4iZILSNw9Dy8zkN5RqTqNztyFgtHdCW8Lj5G2kHXCU651JjJ8gtz5hDlKW3mIEdhBb0ptQISBuVqU8NjyQVugkOyLlTPj90jcSdLhqQ0vKGYazUgbV558m6ST+4BV5lB55xOH0fAI31ADXeSOP7u8MNP8RpviB7Zt8NHtO5UqNrs8eYkXnwWWpOSkR6uDTi1aHGj4ktz5sEPpAWVYOFhU66cKGn7BwX+1259wyaqE2ono/cRyTOm3AhtmUPoDsKHmlTysm7AA9nwRks9HDog2Yzuvh5VhCUHzGSWGDr1POT46Fk0ETnlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q+Rcarng8FQDxia8LXDIrKKR2xLnEPDA40FA2yBpoxU=;
 b=T91GBtRnxBMei824v5/MkC8EYxvzH67WGfYEe/8ynRaoYxwgNnh83Rq5ZxeTJWh8CANn3U/zD5ATGry0zO6/NVoVbjL/0Ra5lNkhjFWGWN3eiQaFG+o0wegoUdouI/HD6+9HXzrUTgYkxMkDpOIz2q0dWU/uQeGxehMUa2ufOgtJmuNLLtMjTBlaorlSEucFBvr7D3DmrNF7rNECLFye8fnrtVQyxYboMmHAy4UuWqi50paaraWLFIG1mrrRTNYytJw09nf07KYXib23TbPqZ+NqtzkZDVaPil6ZNlRgbxjl1HqVQrecIUuHCxkfQ2nk8ZHjPpZCaD7g9RAmWwZd8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by BL1PR11MB5253.namprd11.prod.outlook.com (2603:10b6:208:310::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Fri, 14 Oct
 2022 18:26:50 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::10a6:b76c:4fb1:2d60]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::10a6:b76c:4fb1:2d60%5]) with mapi id 15.20.5612.022; Fri, 14 Oct 2022
 18:26:50 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "kernel-dev@igalia.com" <kernel-dev@igalia.com>,
        "kernel@gpiccoli.net" <kernel@gpiccoli.net>,
        Andre Almeida <andrealmeid@igalia.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        Joshua Ashton <joshua@froggi.es>,
        Melissa Wen <mwen@igalia.com>,
        Paul Gofman <pgofman@codeweavers.com>,
        Pavel Machek <pavel@denx.de>,
        Pierre-Loup Griffais <pgriffais@valvesoftware.com>,
        "Zebediah Figura" <zfigura@codeweavers.com>
Subject: RE: [PATCH V2] x86/split_lock: Add sysctl to control the misery mode
Thread-Topic: [PATCH V2] x86/split_lock: Add sysctl to control the misery mode
Thread-Index: AQHY3/e3EaNy6EYV2kK+U8ev9N1i5a4OM3Xw
Date:   Fri, 14 Oct 2022 18:26:50 +0000
Message-ID: <SJ1PR11MB60832858BA290E844F6C13E9FC249@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20221014180506.211592-1-gpiccoli@igalia.com>
In-Reply-To: <20221014180506.211592-1-gpiccoli@igalia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.500.17
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|BL1PR11MB5253:EE_
x-ms-office365-filtering-correlation-id: 1d5b6bef-770f-4094-80f0-08daae11a94b
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XywaEw2K2XES3KXRJEHAq2Ca0qGB/Y8voj3IHzcY1O2rB0op2D09BzfnMQoTCylmOEc464O1QCIHP08FM7E+OBwVSyYMdn4SioHANMkaoatiDQMtW0D17as80+YDDbzFEBSufKj2oLIVDcuZj4qOSnPVyo8z4o3jkka8XDRcC94F8A/Q9EoFqRi5Wat2q5a4/uWdbQzF8ij7gdRDjNnrQlaXUXBCbSAn6jztT0yPqhaO7eoTX6gfd4q/irT5JajHPr5NPPvIYF2x7TDINk3ZTV/V+tFejS1YYFtpO8xkSJNpZlOEiCbqYxRWteMyzM1a5/C7p+LlEOTIMGjS5eQDXvz+Ec3GTneQhOxJ4FmIUYnQvt2str7o4L1Rd+5Q3vuZsISOmUEeb6m9NWLZmv5pXBqRkeEEqvV3JwGpUcjL/xvQ0t/HVzPi5ARS1wL5/LcnebF2rKn8rbZ1SRNsJ91JmDVqUGHBjwLAjRBm5JV7goCScb2tmig1wivPjdUqshiuzeHPLw62gx/Rs8N7yVL2L44Pd+H1AvPeciilyl3eSaLPOsAKue6pRE2dI7KWksAwdT/wfc3D/T/W+yAPXZdBh9cKY7tUVCOnee5lE8u1S9kGn0GNnrU+NSVUGsntAwUHjE91PDdiOnyXpKWKNfuBvQERYKYxPr5esxeT5s9W32UEeDmflaDTD2fxOj51xop1twdeR4zn9eybSH/olp7KKNa7iN8/mMfFsZbIR8ZyJKgNveizc7H9v9KpnNEaz3qihPrSWTd9YhJh4VcVsY0r9w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(39860400002)(366004)(376002)(136003)(346002)(451199015)(76116006)(2906002)(4744005)(7416002)(41300700001)(66946007)(4326008)(66446008)(110136005)(8676002)(54906003)(66476007)(8936002)(316002)(52536014)(38070700005)(122000001)(71200400001)(6506007)(7696005)(33656002)(5660300002)(478600001)(83380400001)(64756008)(26005)(9686003)(66556008)(86362001)(186003)(55016003)(82960400001)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TUloZE9xdndDckN5VDBjbjRYTmdRZUVERUt5UzdNbU04bE9GNVZicEpyVVNv?=
 =?utf-8?B?dGoxUlNvaC9xdGJjY0MxQzNvc3FpZ1hTMHE5VWpGZ1hscUpZL3BHbXpzMGZm?=
 =?utf-8?B?dlZBMnl2RWtOdE9VbWdtTkVTUER5MjFYazJuV3FSU25OUk5jVjV5K2hmM2px?=
 =?utf-8?B?cWxiYnBlUFMzcUFVakZiTzU2bW1BbGJZM0prRDZHTzdTVzBoODdkckZ6ZEVi?=
 =?utf-8?B?UWh6bFVoWHloOG1Bb2V5Y2V0bGRwcEs4UFJSckFQSEplVmNxSUpEWEpVZTVS?=
 =?utf-8?B?WHdNRVFvQWduMzFFaXd0TFhldVV6WnNVMmNIaTJzOVZQV2I2cU5mZ25IMVYy?=
 =?utf-8?B?QnJnK2pXZTNuZkpLcWJHS2kvSzJTem9YNjVvMWoxdjFPZzdrbkpCTXVMRjAr?=
 =?utf-8?B?TjZPLzMvOXBvNzkwNUJNZXo3aFMvWTUxamVXekxXdjAzR3dnZGNHUzhTYmRT?=
 =?utf-8?B?aGtrYzZmQ3IzR1RvejcwY0tYaVZRWFRvYXhGbnJ2UWsxK0hOaG9UVXErVmhY?=
 =?utf-8?B?ZVBlaXR5QTFjNzBHa2ZDaXFWdlZ4NjF1a2FXc3dwcm1oTVR2eERkUWhtZDVJ?=
 =?utf-8?B?ZXlsODJZWXNBT3MxRzZJNWxnOXFPYWdQNDA1bk5Ua09MSTBlais1TGFxMXZR?=
 =?utf-8?B?VHU3cHFiV01TTkNIQlpPZTRkZnhWcUtacDdyMFlIbUdVM3RxdHREakxHTjMw?=
 =?utf-8?B?MXMvK0huaHkrSzNCc1dveDVXTldzMm5DN0tiNFpRQ25Id2NnTXhmRE00V2d5?=
 =?utf-8?B?c042MlFBYkZZeDlFN2E1UHNYZWJzc0d2a1laSXNnTU1xT0xMd3Byaml6dDFY?=
 =?utf-8?B?OFVQU3ZOUGFNQW1SVTQ0NzZ6eDFkZ0k2cWlOSTJqV0pDYVZqVmxKc1F6NVhB?=
 =?utf-8?B?VDB2TlNRTE5TSGhWei9rRE1OMEZLZ1VCbjQxeHBOQWxIcVhjTWlrRS9lRVlT?=
 =?utf-8?B?eEFmMmIrUFQyY21RZUVUa3BEeEc0aWkvQ2lzQlBCWXNkVGQyTllqa1ZtNnFa?=
 =?utf-8?B?NWJ1TzlIR2NMdUJUV0NPS0NSSTNGQnZtbThqYmVtOFRkVFJ5T29VN1k4enp3?=
 =?utf-8?B?ZWlISS9ZTmNDZ2lHQzNRK2Z3b1IrVCtSS2Z1TWFBZm5iaUlhWWpENWc1dVNV?=
 =?utf-8?B?Y0FqUlJ4TWUrYmVkWklwV1pTWDFSQUdZTC9zcjJaZUNPMHJSdDhlaGtFcE12?=
 =?utf-8?B?dTdSOXBpR3JHdUI0VWZBMytmYWVPZFljU3g0ZG40azFsamRJM3phWlFjOUlS?=
 =?utf-8?B?Z1cvZkd4MCtYUHJEVkM0UHpld0F3VStsY0pTMFFKbmdUK2RQQ0lCTTJKeGpN?=
 =?utf-8?B?TkpZRjJmcWJQTGF2Yjd4U0tuL3dHR0JzSW53N2RXNzU2bStubjlDY1NaU0h6?=
 =?utf-8?B?c2RGU1MycXUwYnJpZHlIOHVZMmo3RmJTRXIzUFdKMnFTc1N0K212QVlvTmdG?=
 =?utf-8?B?aEt1L1c2MENPTmEya0tzc2MvNUU0ZDNNUnpaanZWY2V1MDRBZU5kTkZ4MTB0?=
 =?utf-8?B?aU9DTE5VcWcxd2JZejdOQmtwZ3FJbFVoK1htK0FxbEVYQk1XdDk3amRBRlo1?=
 =?utf-8?B?VE1DSkxnS2E1Vk5PdzkzaklacDcxd3Q5V3hNc0orM3JIVkFZc1R2Y3lzZkVp?=
 =?utf-8?B?Rno0UFg2UjZwekd4THpDMjRWNGZLTlFXTlNqWERLUHhIaFJ1M05qdkxYUFdt?=
 =?utf-8?B?aXkzbHhoVzlDaWpGLzVrVGVEbENITkFaN3RFZ0VqdGRsK3lEVGd3cVpLZTB1?=
 =?utf-8?B?NkVoN2RweHg1UmpXb1R1ak1wWjdCeEhmRDdOWDdpUmx0ZlNMV1o4aEF3aEN2?=
 =?utf-8?B?ZDVaY2ZSSk5VMm94a04zSGFiQW1SMmtrYnZJK1pYd0VnVk5hUGlZd1FSSkIv?=
 =?utf-8?B?akFEQVAxM0tiWnNtM0VCeFpSZ1lxc1p6ZWRDVFBVLzByWjl2dnEvb0x2S1Jy?=
 =?utf-8?B?MnN6RW4vbEhnMURhdkRMMm5RY1FnL2hTUVZDUlFrbnFBTE1GRU4zRStBaGZu?=
 =?utf-8?B?cjRSMzBxcThYcU5FbjFCSFo1ZURhZGpMVjJDUTJqbm9QM2FvaHRVVm1hNkRK?=
 =?utf-8?B?eWliV0FwMUNLSG90dm1OcUN5MjhyWkpveEtBa3lmWGE0d0dTMFYzZDZ4b05M?=
 =?utf-8?Q?OfDVTji26pb5aYml3cdL/rcIH?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d5b6bef-770f-4094-80f0-08daae11a94b
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2022 18:26:50.3852
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PFYA8/iPPmIkJvbQq0rYeMJCcos9s6Xb6DyPkKw1heVD8aX2SRmsGQdcmyGnMQSWS02K0ixZ62/1TbLFTwH/8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5253
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TG9va3MgcmVhc29uYWJsZS4NCg0KQXJlIHRoZXNlIGdhbWVzIG11bHRpLXRocmVhZGVkIHdpdGgg
c3BsaXQgbG9ja3MgaGFwcGVuaW5nIG9uIG11bHRpcGxlIENQVXMgaW4gcGFyYWxsZWw/DQpJZiB0
aGV5IGFyZSwgdGhlbiBza2lwcGluZyBib3RoIHRoZSAxMG1zIGRlbGF5IGFuZCB0aGUgc2VyaWFs
aXphdGlvbiBpcyBuZWVkZWQuDQoNCkJ1dCBpZiBzcGxpdCBsb2NrcyBhcmUgb25seSBmcm9tIG9u
ZSBDUFUgYXQgYSB0aW1lLCB0aGVuIHBvc3NpYmx5IGl0IHdvdWxkIGhhdmUNCmJlZW4gZW5vdWdo
IHRvIGp1c3QgaGF2ZSB0aGlzIG1pdGlnYXRpb24gc2tpcCB0aGU6DQoNCisJCWlmIChtc2xlZXBf
aW50ZXJydXB0aWJsZSgxMCkgPiAwKQ0KKwkJCXJldHVybjsNCg0KTWF5YmUgYmVzdCBub3QgdG8g
c2Vjb25kIGd1ZXNzLiBZb3UgaGF2ZSBsZWZ0IHRoZSBkZWZhdWx0IGFzICJtaXRpZ2F0aW9uIG9u
IiwNCnNvIEknbSBoYXBweS4NCg0KLVRvbnkNCg0KDQo=
