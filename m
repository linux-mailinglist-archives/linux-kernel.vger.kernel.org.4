Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CFBF6FB653
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 20:32:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbjEHScg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 14:32:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjEHSce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 14:32:34 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D01C59FC
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 11:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683570753; x=1715106753;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=RVBoQbaahFT7+1yDzc4EsG87Q8HM5vZW4mJPfwVyvxU=;
  b=a0wcRz9b8/H0fYrzpTFkMvklIUyoFrfgPpmDYimWDr3PI9lxSoJJ0SGB
   gC3OpbBiAwjy6siVmElD5pNRqxlK7PzT6t/RAPJ5AEFxxjqMZ6/yR6Y9k
   IqNk9B89OxGq26r1INFn1GKbjjGpNMkT1Te4mI03ng9dP26gQjuz7jSyK
   GKGvaKd5B/YMZ5xak6+EY5lAmeo591abjd+8k6S5bGx3jgFkJ5G4TbmuI
   b9sbh3Lq+Kj0+qMW3HvCRzQ6O9HrvVTB7+juxzwPOkWmDSk5BfiP0r8P0
   OxZasfitTRhYQ7m4GRMTCb+wHedMB6mF2SxQDb93gg8Bs9LVoM8PZ0eAd
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10704"; a="436045853"
X-IronPort-AV: E=Sophos;i="5.99,259,1677571200"; 
   d="scan'208";a="436045853"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2023 11:32:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10704"; a="872888145"
X-IronPort-AV: E=Sophos;i="5.99,259,1677571200"; 
   d="scan'208";a="872888145"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga005.jf.intel.com with ESMTP; 08 May 2023 11:32:32 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 8 May 2023 11:32:31 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 8 May 2023 11:32:31 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Mon, 8 May 2023 11:32:31 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.109)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 8 May 2023 11:32:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eoMqaeKWiQ9MIM+yXQCfxVKyUtEoagCaO8uN+D+ce6fheBR6ifU6xtxjSh/EjuLV3tTU2XC2tLidEzfnU+fDUmWOYyJunH0y11zccHkGUj00qk0rjc/b25guulIy8v6mKfR5n1PLQAaMhXV/BfTJNpqvYptPFxAKgiC8BZLagWwWvjDCw6DbfZ+57WMQ/PU68y3gFAI9DAe/A2kXYw9PeLmwXMnK5JGEwhWGSjRoHMdQ4hYmU2z1KVmpa5OWO/B6icTjCnyHqwE1NFYinzlpcWbRa7eR1WhBtJNZEuBYx5yiErhri2Eg0Z9SH0SH20x4bjufXTuasshcBv3BIJn6Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RVBoQbaahFT7+1yDzc4EsG87Q8HM5vZW4mJPfwVyvxU=;
 b=Jtrp5NOAyJvPle8T64z+hg0HWgyM7ZkFT4SvHe8Qes46BI8R4YDuXz/ylyjN9HOjc5+hsrCDb+djPVpAXgV83fGt6JBqXAUw+wCAW7pJhxdzRuxmyLrgBNh49xmRoh8IfDGq7gOuFNvfqH/5wUzVHTXxjfxlX+8kPHG/KyERfVqYyb0kU30ti4/ptyXvjC7xtu6/fyo9j+X6m5U/mFErZ0B8lAgmQXWFq3kz2/b1lgNya6X0MR4rVRhW5+NoTUV2y4gJm/4sYqna4OU1nSnI36aBlRmL/m4eJgm3VNfvpUE7s1+GyD3v8O87h/Gn77WJ4hTN5J60o+IFtnhvQ1Gvwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by PH7PR11MB5981.namprd11.prod.outlook.com (2603:10b6:510:1e0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Mon, 8 May
 2023 18:32:29 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::a52e:e620:e80f:302]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::a52e:e620:e80f:302%6]) with mapi id 15.20.6363.032; Mon, 8 May 2023
 18:32:29 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     "Chatre, Reinette" <reinette.chatre@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        James Morse <james.morse@arm.com>,
        Babu Moger <babu.moger@amd.com>
CC:     "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RFC PATCH 0/7] Add driver registration i/f to resctrl
Thread-Topic: [RFC PATCH 0/7] Add driver registration i/f to resctrl
Thread-Index: AQHZc9RpUDnrLIcguE2hFRoOJfWMkK9MZ88AgARWAUA=
Date:   Mon, 8 May 2023 18:32:29 +0000
Message-ID: <SJ1PR11MB60832074F3140B38C1B08596FC719@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20230420220636.53527-1-tony.luck@intel.com>
 <c0755752-ce84-b5f9-6ac6-97812e98b8c3@intel.com>
In-Reply-To: <c0755752-ce84-b5f9-6ac6-97812e98b8c3@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|PH7PR11MB5981:EE_
x-ms-office365-filtering-correlation-id: ae60087c-a435-4721-fc76-08db4ff2947f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dLZEzt3G8ID7na5R4S8PLfE7MDigkQO7Yz8xM4fEODfra8DFWf0iJ3QWh3erdztVvHLymZmsQWmDufr5kSpDMwyd8cjuzBj99/voh8QZcJoJ1AzpKkC5hQ+XP9pYKZCe/5uqbOW3exp+d7LYSSCedUFwz7KRxQfEhltc/2CceN5U7uwXdRLlhnVKYzWSR1uUw5d1oQzF42P1LZjhFP7e0XKC8IcigKjhOMawvyQeQvpWmkYGYkrsvsB/Xos/dDccLrQmEq1WcT3yTrOb6M0Sn5Qhn45XPv8Bvtf/0w1DcwgYmg85iCMcfH5RnZRveLsI0m0rvRaJYs0GKWfAHDi3BBrUnQG5NaImnMUFhlDQfFsFeMx2J8X8qsyA4OFqbirNp3fMOr+kNWKQywOF2DaK08+nO4EjTMVzW449J0cD4eDZx37wXfxT33T2aHzPDxvJxleVE4ReOMj0GldxCD9nzMIrn6LsCC8L31fImYZePvHnvk6NVMJiQoCOUx0bQI3s/F5wClJxnWx2euGAC+Zrvs7sjMI+a0wToFQoD2yqU9mwpXH54olKNn0wp8xGYk30C7DfUgf3IEU8z7k8m/9dfxLcpW4Lv15Hlk8N+Ge+RwUmK66NKNalUpo3wOK/Wzy8vUncH+s3cmP38l4Y016kkQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(39860400002)(346002)(366004)(376002)(396003)(451199021)(83380400001)(66946007)(66446008)(64756008)(66556008)(7696005)(26005)(66476007)(71200400001)(110136005)(478600001)(6506007)(186003)(54906003)(55016003)(2906002)(5660300002)(52536014)(86362001)(7416002)(9686003)(8676002)(82960400001)(8936002)(33656002)(921005)(38100700002)(38070700005)(122000001)(4326008)(41300700001)(316002)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c3c2cS9nWk85WUg5WEwvV0sxM0ZWeW5rS3o1WC9xZEtwa0lRMG95azhGYUha?=
 =?utf-8?B?OWExdjJ3M2tKbHZQK0tYR0Q0LzcyVXJZT0ttUEVJdUxsUHhUY0xOOGxQYUZE?=
 =?utf-8?B?aXh1TmoxQ3Z6d2lIeDNYMEtRN2phVGJJRUlJNU9UQlE5dUFORDBrWGhpZFEx?=
 =?utf-8?B?dW44NjJFeE5EOXVHZlF6SFhydytHWHlUQU90UDJaUXU0VWZPMEJCTytLNUhp?=
 =?utf-8?B?Q3VPYjA2N0hNL2VJSGZsa1JGbXFzaWVxVmEvSUh4eG81UG5jQmRjR0lWWk5R?=
 =?utf-8?B?Y0VmSFU1eGcxZzgxeDlEZW0vTHJsUlFwYWt3c2QvN1I0blRFYWZRN294a2FR?=
 =?utf-8?B?amsvb2VpRDY0QVNQM1JCVHRWK2RMcFd4N1FIUkx5RVZuRit6dENSa08yUHUx?=
 =?utf-8?B?SXBHVEpNbXZOMWxJeWlSd09ES3hNR2dqYnBPeVVwVU11ZGUxUHVUL1l1em5v?=
 =?utf-8?B?b1BjbTB4cUcyckNkU1BBT1VVVDVPTXFseTQybGdGZWR1ZXlUN01OU29VdFFx?=
 =?utf-8?B?L3FFbDFUYjlaaEpjeHR4L2owOFBySlFqNi90Wi8zZks1ODNmbkNpOHM3OUtx?=
 =?utf-8?B?eTE5UXRzbkxROWpLNVNTaUFaZ21QOTRBdGJNa2MzK1FDb0ZoUHg1QU03UWp6?=
 =?utf-8?B?amJvSjhxVkNlVUFFbHZpTGlTSWZ2S01BOWxjdXJUK083VUNPOVJTVW52RS9T?=
 =?utf-8?B?WE84L2MrT2t5Z1pRQVR1ZnVBWlJ6dk8rLzU2Ky9oMm8zTTIydGl3NnR1b2ty?=
 =?utf-8?B?RHV6bC9SRFlCZTN6UlFsYVNPN0RTRUdFZW00SG5QMW9NQ1dqeEpZeTRHM3ZS?=
 =?utf-8?B?ZzBJV3ovcU4ycmVGVlVPbEVINkNhTnhic2ZoVXFubWRkcm90bU1FTEYxZGVT?=
 =?utf-8?B?RFIxcVZZZkdia3l5eXNDVEN0TmpweVVVZFBXeStPZjRlbnlqbWw1MnRaVXk4?=
 =?utf-8?B?TSt0cU5taE1Mc2l4Umk5RklXUnZnSzZHZ2RIakhnVm9oUGk2NldBRk9qU213?=
 =?utf-8?B?dVl5NlgrMXluem1jL09vaGt0RkpIaGJ2NzQ2bmkvbkFvZEJyakZuNmcvVDVv?=
 =?utf-8?B?cG1DWVZqL0luRGlUSG5YbVNVQ0kvR0JBYklBQXZXejAyMlVwMGhFdU9HM2Vl?=
 =?utf-8?B?ODB3Wm1KRjVwT2YxRk45UDErZ2VkTWVHV3U2TkFrcjZVS0RuSWdGTlkvelND?=
 =?utf-8?B?dzB6QmNZYUVhSzY4clpEUDJlNGErM1crSExyTU1MbllzTUdIaXhuNlgzbnZL?=
 =?utf-8?B?SDB4MWZuTTVYVTJYUlBzUmNxQnpXSFV4YzF2bWxWRTVlZWJGYzYxYm9mK2tT?=
 =?utf-8?B?NTdZWVczczk5L2VUclA4ZDhwb1ZVZVppcWk0YjZoRDRlUFQ0VWlrcTRZaGZs?=
 =?utf-8?B?eFY5dFI0R1JVUFpKNmViUnZFRE43VFRwSUlITGxaOUg2UXo1dlI3V0YySWhw?=
 =?utf-8?B?c2dZNGgrbzQ1cUUyeHRoQ3hSVHI1TnJYMVM0ZHlmZ2pnSlE0ZitMb2VHck13?=
 =?utf-8?B?Zlh4ZWp5RzE2b3lDTWVVbVhMRzhnWEYvczhhNTRSOVhXaWVBR0JrQklIV3VT?=
 =?utf-8?B?N0hvSXd0eVV1NWZ6a0FsS3FaTkJTZW5rbHNVRWlPSSthS3lBT0RyeGMzcVR1?=
 =?utf-8?B?UFk0NVdiYkhrdE8xczg2NGFKTlpHRHJzcmQ2aFo0WnBnNGF3N2RYTTRpVUly?=
 =?utf-8?B?WllVbmxyaG15eEQwRjdkT1doZlBZV1JOMGgzMWhaTGZsZVE0d1B6dEZrbXJs?=
 =?utf-8?B?b0dDWE5oT2trZXE4SE8zdzVIQWJpMmM0eEtnLzhVQTgrNkRtL0lDZlk3eW5Q?=
 =?utf-8?B?WVQwQmwvZ1B0aVZoem1zYVFLaGdzSzhFczFFTURpenMyd2Z5ZHg0U2NRNnJn?=
 =?utf-8?B?OUhWUTdYbXdUSVZyNGkzTFhWSGdwaG52N1kwWjFVRWpNd1NRMFdZZGtsYVBr?=
 =?utf-8?B?ekMrTE1TS0pJbVNrdlJCOFNIakt1MFNjYXlONG9oQVpyWDN2VFhyUTdSWHdH?=
 =?utf-8?B?WTIrNVhCbEY4TnhLRlFYQnVNVmV4MkRrc0NIaTBDekFNMWJhU3hUN0JwM2xo?=
 =?utf-8?B?ZGo2L0dDeU8vYnkzelpIMENEVlFoQ3JkdTFMaStRMEdNRXhMSElWeG9Pbm1n?=
 =?utf-8?Q?FQBo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae60087c-a435-4721-fc76-08db4ff2947f
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2023 18:32:29.4935
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b9Fm6VDVT0W3GtXgMpa/Bwh1/hXeZVqFvhQnG6m51oDhB1Nmf+DYG5pux9VZ/qZW/YXSj9xJcs4VySpMyy3DvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5981
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UmVpbmV0dGUsDQoNClRoYW5rcyBmb3IgdGhlIHJldmlldy4gWW91ciBjb21tZW50cyBvbiBpbmRp
dmlkdWFsIHBhdGNoZXMgYXJlIGFsbCBnb29kLCBidXQgSSdsbCB0cnkgdG8gYWRkcmVzcw0KdGhl
bSBoZXJlIHRvIGtlZXAgYWxsIHRoZSBwaWVjZXMgdG9nZXRoZXIuDQoNCllvdSBzdW0gdXAgZXZl
cnl0aGluZyBpbiB5b3VyIGNvbmNpc2U6DQoNCiAgIkkgd291bGQgbGlrZSB0byB1bmRlcnN0YW5k
IHRoZXNlIHR3byBtb3RpdmF0aW9ucyBiZXR0ZXIuIg0KDQpJJ2xsIHRyeSB0byBnaXZlIHNvbWUg
YWRkaXRpb25hbCBkZXRhaWxzLiBCdXQgdGhlIHNwZWNpZmljIGZlYXR1cmVzIG9mIHRoZSBkcml2
ZXJzIEkNCndhbnQgdG8gYWRkIGFyZSBzdGlsbCB1bmRlciB3cmFwcywgc28gSSB3aWxsIGhhdmUg
dG8gYmUgc29tZXdoYXQgdmFndWUgYXQgdGltZXMuDQpJZiB0aGF0IG1lYW5zIHRoYXQgYSBmaW5h
bCBkZWNpc2lvbiBjYW4ndCBiZSBtYWRlIHVudGlsIG1vcmUgZGV0YWlscyBhcmUgZm9ydGhjb21p
bmcsDQp0aGF0J3MgZmluZS4gQXQgbGVhc3QgdGhlIGRpc2N1c3Npb24gaGFzIGJlZ3VuIG5vdyBz
byBwZW9wbGUgaGF2ZSBzb21lIHRpbWUNCnRvIHRoaW5rIGFib3V0IHRoaXMgd2VsbCBiZWZvcmUg
SSBuZWVkIHRvIGdldCBjb2RlIHVwc3RyZWFtLiBPciBpZiB0aGUgYW5zd2VyDQppcyAiTm8uIFdl
IHdpbGwgbmV2ZXIgY3JlYXRlIHMvdyBsYXllcnMgaW4gdGhlIHJlc2N0cmwgY29kZS4iIFRoZW4g
SSBjYW4gZ28NCmJhY2sgdG8gcHV6emxpbmcgc29tZSBvdGhlciBzb2x1dGlvbnMuDQoNCkludGVs
IGhhcyBhbHdheXMgaGFkIHNvbWUgbW9kZWwgc3BlY2lmaWMgIlJEVCIgZmVhdHVyZXMgdGhhdCB3
ZSBoYXZlDQpub3QgYXR0ZW1wdGVkIHRvIHB1c2ggdG8gdXBzdHJlYW0uIFJhdGlvbmFsZSBpcyB0
aGF0IGFyY2hpdGVjdHVyYWwgZmVhdHVyZXMNCmhhdmUgbGFzdGluZyB2YWx1ZSBhY3Jvc3MgQ1BV
IGdlbmVyYXRpb25zLiBPbmNlIHRoZSBjb2RlIGlzIHVwc3RyZWFtIGl0DQoianVzdCB3b3JrcyIg
KFRNKSBmb3IgYWxsIHRpbWUuIENsdXR0ZXJpbmcgdXAgY29yZSBjb2RlIHdpdGggZmVhdHVyZXMg
dGhhdCBhcmUNCm9ubHkgYXBwbGljYWJsZSB0byBvbmUgb3IgdHdvIENQVSBnZW5lcmF0aW9ucyBz
ZWVtZWQgbGlrZSBhIHJlY2lwZSBmb3INCmRpc2FzdGVyIGZyb20gYSBsb25nLXRlcm0gbWFpbnRl
bmFuY2UgcGVyc3BlY3RpdmUuDQoNCkJ1dCB0aGluZ3MgYXJlIGNoYW5naW5nLiBQcmV2aW91c2x5
IHRoZSBlbmQgdXNlciBpbmR1c3RyaWVzIHRoYXQgd2FudGVkDQp0aGUgbW9kZWwgc3BlY2lmaWMg
ZmVhdHVyZXMgd2VyZSBjb250ZW50IGZvciBvdXQtb2YtdHJlZSBwYXRjaGVzIGZvciB0aGVpcg0K
c3BlY2lmaWMgc3lzdGVtcy4gV2Ugbm93IGhhdmUgc29tZSBmZWF0dXJlcyB0aGF0IG1heSBiZSB1
c2VmdWwgdG8gYQ0Kd2lkZXIgYXVkaWVuY2UsIG9uZXMgdGhhdCByZXF1aXJlcyBhIHNvbHV0aW9u
IGludGVncmF0ZWQgaW50byB1cHN0cmVhbQ0Kc28gdGhhdCB0aGV5IGRvbid0IHRha2Ugb24gdGVj
aG5pY2FsIGRlYnQgdG8gbW92ZSB0aGUgc29sdXRpb24gdG8gbmV3DQprZXJuZWwgdmVyc2lvbnMu
DQoNCkknbSBhbHNvIGd1ZXNzaW5nIHRoYXQgd2l0aCBvdGhlciBhcmNoaXRlY3R1cmVzIChBTUQs
IEFSTSwgUklTQy1WKQ0KYWxsIGJ1aWxkaW5nIG9uIHRoZSByZXNjdHJsIGZvdW5kYXRpb24sIHNv
bWUgb2YgdGhlbSBtYXkgYWxzbyBoYXZlIHNvbWUNCmZlYXR1cmVzIHRoYXQgZG9uJ3QgZml0IG5l
YXRseSBpbnRvIHRoZSBjb3JlIG9mIHJlc2N0cmwuDQoNCk15IFJGQyBwYXRjaGVzIHdlcmUganVz
dCB0byBzaG93IHRoYXQgY3JlYXRpbmcgYSBzL3cgbGF5ZXIgaW4gcmVzY3RybA0KaXMgcG9zc2li
bGUuIElmIHRoZXJlIGlzIGEgYmV0dGVyIGRpdmlkaW5nIGxpbmUgYmV0d2VlbiBjb3JlIGNvZGUg
YW5kIA0KYXJjaGl0ZWN0dXJlL21vZGVsIHNwZWNpZmljIGNvZGUgSSdtIGhhcHB5IHRvIGRpc2N1
c3MgY2xlYW5lciB3YXlzIHRvDQpkcmF3IHRoZSBsaW5lLiBFLmcuIHlvdSBtYWtlIHRoZSBwb2lu
dCBoZXJlIGFuZCBpbiBvbmUgb2YgeW91ciBjb21tZW50cw0KdG8gdGhlIGluZGl2aWR1YWwgcGF0
Y2hlcyB0aGF0IG1ha2luZyBuZXcgcmVzY3RybCByZXNvdXJjZXMgbWF5IGJlIGEgDQpjbGVhbmVy
IHNvbHV0aW9uLiBJIGRpZG4ndCBkbyBpdCB0aGF0IHdheSBwYXJ0bHkgYmVjYXVzZSB0aGUgZXhp
c3RpbmcgY29kZQ0KaGFzIGEgc3RhdGljIGFycmF5IG9mIHJlc291cmNlcy4gQnV0IGl0IG1pZ2h0
IGJlIHJlbGF0aXZlbHkgc2ltcGxlIHRvIHRyYW5zZm9ybQ0KdGhhdCBpbnRvIGEgbGlzdCB0byBt
YWtlIGR5bmFtaWNhbGx5IGFkZGluZyBuZXcgcmVzb3VyY2VzIGVhc2llci4gQnV0IHNlZQ0KUTYg
YmVsb3cgYWJvdXQgdHJhY2tpbmcgZG9tYWlucyBpbiBhIHJlc291cmNlIGZvciBvdGhlciBjaGFs
bGVuZ2VzLg0KDQpTcGVjaWZpYyBxdWVzdGlvbnMgeW91IHJhaXNlOg0KDQpRMSkgV2lsbCB0aGVy
ZSBiZSBhIG5lZWQgZm9yIGRyaXZlcnMgdG8gImNhbGwgaW50byIgcmVzY3RybCByYXRoZXIgdGhh
biByZWx5DQpvbiBjYWxsIGJhY2tzPyBNYXkgbWFrZSBsb2NraW5nIGNvbXBsZXguDQoNCkExKSBT
byBmYXIgSSBoYXZlbid0IGZvdW5kIGEgY2FzZS4gQnV0IEkgb25seSBoYXZlIHRocmVlIGRyaXZl
cnMgKGluIGFkZGl0aW9uDQp0byB0aGUgZXhhbXBsZSBvbmUpIHNvIGl0IGlzIHBvc3NpYmxlIHRo
YXQgbW9yZSBjb21wbGV4IHRoaW5ncyBtYXkgYmUgbmVlZGVkLg0KSSBhZ3JlZSB0aGF0IHRoaXMg
d2lsbCByYWlzZSBtYW55IGxvY2tpbmcgY2hhbGxlbmdlcy4gRXhwb3J0aW5nIHRoZSByZXNjdHJs
DQptdXRleCBzZWVtcyBsaWtlIGEgdGVycmlibGUgaWRlYS4NCg0KUTIpIFdoYXQgYWJvdXQgZXhj
bHVzaXZlIGdyb3Vwcz8NCkEyKSBJIGRpZG7igJl0IHRyeSB0byBoYW5kbGUgaW4gdGhpcyBSRkMu
IEFkZGl0aW9uYWwgYml0cyB3aWxsIGJlIG5lZWRlZC4NCg0KUTMpIEhvdyB0byBtYWtlIHZpc2li
bGUgdG8gdGhlIGRyaXZlciBvdGhlciByZXNjdHJsIGFzc3VtcHRpb25zIChlLmcuIGRlZmF1bHQN
Cmdyb3VwIGlzIENMT1NJRD0wLCBSTUlEPTApLg0KQTMpIEkgdGhpbmsgdGhpcyBzcGVjaWZpYyBl
eGFtcGxlIGlzIHVubGlrZWx5IHRvIGV2ZXIgY2hhbmdlIChpdCBpcyBzb21ld2hhdCB0aWVkDQp0
byB0aGUgcG93ZXItb24vcmVzZXQgc3RhdGUgb2YgdGhlIElBMzJfUFFSX0FTU09DIHJlZ2lzdGVy
LiBCdXQgdGhlIGdlbmVyYWwNCnBvaW50IGlzIHRydWUgdGhhdCBhc3N1bXB0aW9ucyBieSBkcml2
ZXJzIG1heSBjcmVhdGUgY2hhbGxlbmdlcyB0byByZWZhY3RvciBjb3JlDQpjb2RlIGluIHdheXMg
dGhhdCBicmVhayB0aG9zZSBhc3N1bXB0aW9ucy4NCg0KUTQpIFN1cHByZXNzaW5nIHNjaGVtYXRh
IHJlc291cmNlcyBmcm9tIGEgZHJpdmVyIHN1cnByaXNlZCB5b3UuDQpBNCkgVGhpcyBpcywgYXMg
eW91IGd1ZXNzZWQsIGFib3V0IGNvbmZsaWN0aW5nIHJlc291cmNlcy4gVGhlcmUgYXJlIG90aGVy
IHdheXMgaXQNCmNvdWxkIGJlIGhhbmRsZWQuIEUuZy4gdXNlIGV4aXN0aW5nIG1vdW50IG9wdGlv
bnMgdG8gc3VwcHJlc3MgdGhlIHJlc291cmNlIGZyb20NCnRoZSBzY2hlbWF0YS4gVG8gYmUgc2Fm
ZSB0aGF0IG1pZ2h0IGFsc28gbmVlZCBzb21lIHdheSB0byBmYWlsIHRvIGxvYWQgb2YgYSBkcml2
ZXINCnRoYXQgbmVlZHMgb3RoZXIgYWNjZXNzIHRvIGEgcmVzb3VyY2UgdW5sZXNzIHRoZSBjb3Jy
ZWN0IG1vdW50IG9wdGlvbnMgYXJlIGluDQpmb3JjZS4NCg0KUTUpIEJvdW5kYXJpZXMgYXJlIG5v
dCBjbGVhci4gVG9vIG11Y2ggb2YgcmVzY3RybCBpbnRlcm5hbHMgbWFkZSB2aXNpYmxlIHRvIGRy
aXZlcnMuDQpBNSkgQ2FuIHdvcmsgb24gbW9yZSBhYnN0cmFjdCBpbnRlcmZhY2VzIGlmIHdlIG1v
dmUgZm9yd2FyZCB3aXRoIHNvbWUgc29ydCBvZg0KbGF5ZXJlZCBhcHByb2FjaC4NCg0KUTYpIERv
bWFpbiBhd2FyZW5lc3Mgb2YgZHJpdmVycy4NCkE2KSBUaGlzIGlzIGEgY2hhbGxlbmdlLiBFc3Bl
Y2lhbGx5IGFzIHRoZSBkb21haW4gZm9yIGEgZHJpdmVyIG1heSBub3QgbWF0Y2ggdXANCndpdGgg
YW55IGV4aXN0aW5nIHJlc291cmNlIHNjb3BlIChlLmcuIGRyaXZlciBtYXkgYmUgc29ja2V0IHNj
b3BlZCwgd2hpY2ggbWF5DQpub3QgYmUgdGhlIHNhbWUgYXMgIkwzIGNhY2hlIiBzY29wZWQpLiBB
ZnRlciBJIHBvc3RlZCB0aGlzIHNlcmllcyBJIGFkZGVkDQphbiBlbnRyeSBpbiB0aGUgcmVzb3Vy
Y2UgdGFibGUgd2l0aCBzb2NrZXQgc2NvcGUgdG8gaGFuZGxlIHRoaXMuIER5bmFtaWNhbGx5IGFk
ZGluZw0KYSBuZXcgcmVzb3VyY2Ugd2l0aCBhIGN1c3RvbSBzY29wZSBoYXMgY2hhbGxlbmdlcyAo
YmVjYXVzZSB0aGUgZG9tYWluIGxpc3RzDQphdHRhY2hlZCB0byB0aGF0IHJlc291cmNlIGFyZSBt
YWludGFpbmVkIGJ5IHRoZSByZXNjdHJsIGNwdSBob3QgcGx1ZyBjYWxsYmFja3MgYXMNCkNQVXMg
Y29tZSBvbmxpbmUgYW5kIGdvIG9mZmxpbmUuDQoNCi1Ub255DQo=
