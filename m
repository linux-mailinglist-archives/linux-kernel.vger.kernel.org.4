Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 011226A5E30
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 18:28:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbjB1R2Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 12:28:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjB1R2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 12:28:24 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E25CCDCF;
        Tue, 28 Feb 2023 09:28:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677605303; x=1709141303;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4k0iKJV2vMKeqIQgSIorNxU0wctfI7EI0fn+i1jfZLs=;
  b=CqBSxF6PkWMfHBlH5EvsArqgNz8AXYm8rFHaOxLV79mRZregiqyrRaXT
   rcCp77Z7CHysbX0RYhraVTcKijys7l48luCa7mncPCUdEqrq/nCsuTWZF
   CLZtUZ+awgDlUp0MZDeI8h7ZOTfNCPP1mM/uExoCd679LlTK1Q2t+ToA2
   e/zHPGgOxI+OwwpFxmCBrJETXocNonKwy8YoSDhhICK5ZLU19MIXhx+9K
   Ta2LYAnYwZqCMfzKpIh+OS2+RT0ctOkKqweWdFMauc/EZlHgkYwRTSCsA
   pz+QI+OTG3tjMbRlaoJkGH6HoOqLSTT7surqiNYwrBM1xNSDYTSJr6WSv
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10635"; a="332927957"
X-IronPort-AV: E=Sophos;i="5.98,222,1673942400"; 
   d="scan'208";a="332927957"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2023 09:28:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10635"; a="783948443"
X-IronPort-AV: E=Sophos;i="5.98,222,1673942400"; 
   d="scan'208";a="783948443"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga002.fm.intel.com with ESMTP; 28 Feb 2023 09:28:22 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 28 Feb 2023 09:28:22 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 28 Feb 2023 09:28:22 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 28 Feb 2023 09:28:22 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.170)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 28 Feb 2023 09:28:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SVOWNdoYZf007P1nvO7+74zF5EjEidmIhjCH82P7l5S2PZ4cOz8mMVzkj2pCIJItqcWPqG6VDcVp4DaW5NRw8/NsHGjHHhhMJhRN8o9XZ5yRXcjC7INUwcJPCwUH0aRMAGxaAts9bXf2WPswC32nXXWFi0JvsnJnI5zSQzRxjyHbV/8Z9X4JhR9tZMeWPp5We9EH99FkXevTl36lnOhDfOuSKT+Y/hfsQqbjg17TcuvM79lL+HUZ4ScBWQMWYagVRjdN9is9DHApZceH/CKOK5NIq8+IttjAO3S81VP+R1m4tQWtkc8kWSZ9PF5X/4fDze+OLPQPjWWhMTB9dM4/YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4k0iKJV2vMKeqIQgSIorNxU0wctfI7EI0fn+i1jfZLs=;
 b=kElBIpwfBEKjU1lfhGxgY2S2VbN0ZbA4vi7K827c37yqTpXhInjvytt/trUyxX5LqOhOrWnmn3V957L7J4bTkQMBiQam5V1NmFF6Qsl8k0LU38f/sRqPczEXjKFd7a0FGRzNUNwukuipfKrBCeT4q4z9YOTQsFqsit8r3Mnd+JqDbXgjS5BqtjD/B2k/JvEbO5jeG8AtqLWqgG2uq63rT8nZh23fUpay79PGYYXO00dsgl2GTygrC6zCWp55cz8vPW7zk6q3mv60z61OeIwpDw2dFVfM59Ng/ED0ZLYL9ivHNVzldEhzrdA97V/mPyWAt8rN19OiHcKSu4miH5SuJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by SA2PR11MB5081.namprd11.prod.outlook.com (2603:10b6:806:118::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.30; Tue, 28 Feb
 2023 17:28:19 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::ee6a:b9b2:6f37:86a1]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::ee6a:b9b2:6f37:86a1%9]) with mapi id 15.20.6134.026; Tue, 28 Feb 2023
 17:28:19 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     James Morse <james.morse@arm.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "Chatre, Reinette" <reinette.chatre@intel.com>,
        Peter Newman <peternewman@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "x86@kernel.org" <x86@kernel.org>
CC:     Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Babu Moger <babu.moger@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: RE: [PATCH 4/7] x86/resctrl: Add code to setup monitoring at L3 or
 NODE scope.
Thread-Topic: [PATCH 4/7] x86/resctrl: Add code to setup monitoring at L3 or
 NODE scope.
Thread-Index: AQHZMbXpHjS9mD2CUkuBdSFBMC+fXq7kzKUAgAADufA=
Date:   Tue, 28 Feb 2023 17:28:19 +0000
Message-ID: <SJ1PR11MB6083F264B1730DBB86F06E1DFCAC9@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20230126184157.27626-1-tony.luck@intel.com>
 <20230126184157.27626-5-tony.luck@intel.com>
 <3c3b99b8-5f8f-4671-944d-fd615d209456@arm.com>
In-Reply-To: <3c3b99b8-5f8f-4671-944d-fd615d209456@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|SA2PR11MB5081:EE_
x-ms-office365-filtering-correlation-id: 02a036d0-d73b-4ee7-b876-08db19b12f34
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EGxzBDxrRpAkKG8RBQmMkjyFLIlK7owZerXZNPPUg8OkjuIt/Py1rjJtkJCwZG+yg8T6BfnGjzwrDtxMMSyH/FI0RFA8yB9IqXPahLhSfJsrPG8meRtQqn91UoB9wP9J7Ltzu/Kxffip5c/LTbZU+kOidX4h+G0qXbSJoKMdNAySbk50NHTXVjjhRPwCt4TmiLaFUMXAxAbgC1081GR6/bcui6Ei/AIo2Ogt5O8wU4J2Ouag4+3mlCY7TLinTJIvA2hliY0IYTdPEoNDkeObFBjp3+tC+DRV8fTGe7QRjlSVA1TkSnruzg3VCOtvtIymXhQAZmTWNUS/wleZQjQJ7e8fkgRDQTV6GfeXl0eJ2Z71tfvA3TdDTytbZPp5p5wY3BRirA2pa8AjMxHUxH1xWhSBxDuATuEzxdrN9TnH0tCQz2yqTuPd2i8f+EmDTCKmF3aHUGrrCIAos4b2YHwCqJwu0pCAeE+jaSaoRkVngPxBMKiP28AnxmZqAsvcby0ab7WhurnKPaP2EEEWi19PobVx9aqy54vz7DVGTXFJ51V7VJ0+584LqDIy2j95gEKEHXQngYlvczFEzKvEDcu10DO511CqrINXboFMG8sjh84lwcx2ltkuqsrP2hBOFi58Ezn3V2w7iXdLOi+FTbYwVhAbELmDf1izdXQYuxbn/WyWDNqwDAUktfX3DzlRg7Nkk4AFBkQqFZbcGsDA2nOqIw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(39860400002)(366004)(396003)(376002)(136003)(451199018)(33656002)(86362001)(55016003)(66556008)(66476007)(66446008)(64756008)(7416002)(66946007)(41300700001)(5660300002)(8936002)(8676002)(2906002)(4744005)(82960400001)(122000001)(4326008)(38100700002)(38070700005)(7696005)(71200400001)(52536014)(54906003)(316002)(478600001)(76116006)(83380400001)(110136005)(186003)(26005)(9686003)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z3FpRmUrNGFnR0Z0L2c1NzNBcEZBam01TzhvVlE5dERpc2Vac3hGdnZOTjJZ?=
 =?utf-8?B?OFEwSFFUd0tUcDVzR0NUUHJRWXVFSHYvd0ZZY1dBOVpXY1U0bnJsd3A3QnY5?=
 =?utf-8?B?ZkoyUnJURzdkM0VtQlY4aU02dEhuOExwS2dzOWZ4akFZYlZRblZvZ1dXK2d3?=
 =?utf-8?B?WXQ1T2V2WjJSOWlDNnk4eVZ1dW4wQXB4ZS9QL0VKZFcvSEJLT21vMUZsem9Y?=
 =?utf-8?B?SVhzeUl4OXpVTWpsUWRJNG1oUStJak1RM3ptRnEvL0ZBMGw5SHdKZkJxaHlK?=
 =?utf-8?B?R0c5Y0VQWWkwbzFyUEVTOThoTFhsTHNuTy9Oc2xaRW9iSU11TTNJZ2JwTjQ5?=
 =?utf-8?B?ZVF2S1JvSnhsTXRIZjNHeEFkbkRsaENYd25ydkxZaDkvbjlSRWxMc09DZ0dk?=
 =?utf-8?B?V2pxdjBuS1lYN3lhMXd2L2ROR1c0Qmxidy9JeGpXNWV3ZnhhZk1NZ3BuN0ll?=
 =?utf-8?B?T2lmT0lscTRRczVTVDFncVJZaitST1hUeFg2Q1Z3TzFMRGliRXp4RGE0Yzkr?=
 =?utf-8?B?TUdnOG1TbURjc2xtWXdDbnY3U3hjUDZId3o2SVpyRUxXcmVaVEkvQ3B6aDYr?=
 =?utf-8?B?b1NSNVFKcW1tWVJ5S2lsUXdOVnhlSVFsenBQNUJScDhRTE9SVTI3NWg4NGVn?=
 =?utf-8?B?SVBWUmF4allQUkZDYjkvMFh1TUc1MHljS3ZjczlVeHpHTlJKZk1kWGJXdVJQ?=
 =?utf-8?B?b2xKdVpoZmVHVlZUS1RBbWxvRjF2UThYOXI1eUNyNFAyVVdnZ2pzN2N1RjFi?=
 =?utf-8?B?c1UvNFhsdTZkdnVST3pCVzB0T3JscDdGYzFoODFkb2FvNTVlbkFDRnFoUnhW?=
 =?utf-8?B?MUtDZHQ2SlQzK1c0Z0dkY3JIekhCTXZWajdha1BnV0RlS2hjYkpxRFBnNDVE?=
 =?utf-8?B?d0QvYyt6elRIQnl3VlgrRHorbDQzWDJmLzlMUmxEWnhUeDJ6ZnozdG9wUzBW?=
 =?utf-8?B?VnVnUHdKalpCSCtQZC9XZkozcWdhTnBySGxGcms1YUZwQnB1UUlHRHhoM20r?=
 =?utf-8?B?NmtkdXNYcUpubExULzRnSkxtUnFEM05hcUJXMGRmTG5GNkxxell3Q0ZnaXVv?=
 =?utf-8?B?MjVLZTVHbkZwbE9RYVYzNVpIc2ZYalNnM2NqTWNqcmhMTFdQTzc1dFN2blhk?=
 =?utf-8?B?VXZhcUNTaGRsMysvNmlIU2Z0UHZCbXNtWHJlYWxUaUFXYWtJQ2IrWmxFYXI4?=
 =?utf-8?B?SzRhaGZkMVlhTUtkTDd1Z1laSkd3ZnBlUFJYWjJGQXFoUmhKQ1l1Zmp3bmk0?=
 =?utf-8?B?WVJDOWdzV0g2dlZWaW5lLzNPL1hjSmh4dlBNRTNJTU5BcEVzL0hYbXN4bHk1?=
 =?utf-8?B?am9KUzI3MWZPaFRnME8xc0o2MnZSN0FSQndvZWNzWlBrZStXdHUvVjYwSjNH?=
 =?utf-8?B?K2UvUUJ1VjJOUGpuSW5LRXZCYXRQWk8yZzVJdDNYUGR3ZEM0OHJoSXU5K2Rx?=
 =?utf-8?B?cGExVW41aDdvWFNFV3Yvb3hVcUNOeUR3OW52VllFOU1hbm9YcWJVTDVhWTRL?=
 =?utf-8?B?Y0xJS0xESUJUOTFmZHFZOFJQdWM3eVVqaVVxck4yVDl1Y214SEFtVkQvTCtJ?=
 =?utf-8?B?b2R1c0JUWnBwUEZnd2hlRFFOR3IzOTZrRWl1YXlncHRVMitBU0FDazE1UU1G?=
 =?utf-8?B?RmtWcmVVZlE3RlJpUzRKemxHeUtsakt3YU1jWTN2U28vbWdtVUxLYkgrMjVy?=
 =?utf-8?B?dk4renF6VHVmaU9HZ0pBdHpHelVJMW93cVBPYXR4MUlIWnBTNG5VOGJsQk1p?=
 =?utf-8?B?KzBlZGltUWZZRGVWSEZpVU90V2gwYUliWktONXFjNGJOaXcrSndpQ3Z0UGZs?=
 =?utf-8?B?b29nSTVndkcvUUxkRXRLNFA5UzhYQ21kODRxWnNvRkZlenRqQmtrcWhqbTcy?=
 =?utf-8?B?MlJ4bHh0RHJKRjlKZ0hKSWxmd3FHYzVDeEYrMXhTanVpMWF5dzRjRVBHSzky?=
 =?utf-8?B?ZUE3S2JJQm5lUjZiN09yYkRZaXAzRVhxREFldnhYVFFJcGxZRXNQUmtUR1FE?=
 =?utf-8?B?ZHRwYytFbS9vNWtRaEF0RFZDbmU1Y3NFRDlOVEo1NndpUUd0OTZqUHFTb1BI?=
 =?utf-8?B?N0dXUkJRTUVIMWhVWWJNM3BBZFdGUmtVYW9FY01JOUdZak1mRFJwcVA4YzdE?=
 =?utf-8?Q?VmaHkcB2xOKKU3AnHlw/lAI+J?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02a036d0-d73b-4ee7-b876-08db19b12f34
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2023 17:28:19.4322
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Jjm58evUizbEtORFvLPYun9Tm8gmq8GFgwNDJzJa/5XGK8nmSvQB42F6Rsu+hJDgOLVkLwNdUO06wPPo+StsaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5081
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pj4gKwkvKiBXaGVuIFNOQyBlbmFibGVkLCBtb25pdG9yIGZ1bmN0aW9ucyBhdCBub2RlIGluc3Rl
YWQgb2YgTDMgY2FjaGUgc2NvcGUgKi8NCj4+ICsJaWYgKHNuY193YXlzID4gMSkNCj4+ICsJCXIg
PSAmcmR0X3Jlc291cmNlc19hbGxbUkRUX1JFU09VUkNFX05PREVdLnJfcmVzY3RybDsNCj4+ICsJ
ZWxzZQ0KPj4gKwkJciA9ICZyZHRfcmVzb3VyY2VzX2FsbFtSRFRfUkVTT1VSQ0VfTDNdLnJfcmVz
Y3RybDsNCj4NCj4gQ291bGQgdGhpcyBiZSBoaWRkZW4gaW4gYSBoZWxwZXIgd2l0aCBzb21lIG5h
bWUgbGlrZSByZXNjdHJsX2FyY2hfZ2V0X21ibV9yZXNvdXJjZSgpPw0KPiBZb3UgaGF2ZSB0aGUg
c2FtZSBwYXR0ZXJuIGFnYWluIGluIHJkdF9nZXRfdHJlZSgpLiBJZiB0aGlzIGdldHMgbW9yZSBj
b21wbGV4IGluIHRoZQ0KPiBmdXR1cmUsIGl0IG1lYW5zIGl0cyBvdXRzaWRlIHRoZSBmaWxlc3lz
dGVtIGNvZGUsIGFuZCBhbGwgaW4gb25lIHBsYWNlLg0KDQpTb3VuZHMgbGlrZSBhIGdvb2QgaWRl
YS4gIFRoYW5rcy4NCg0KLVRvbnkNCg==
