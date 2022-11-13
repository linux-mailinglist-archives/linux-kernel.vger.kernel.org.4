Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6C086270E3
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Nov 2022 17:42:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235434AbiKMQmH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 11:42:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235439AbiKMQl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 11:41:58 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A15010561;
        Sun, 13 Nov 2022 08:41:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668357717; x=1699893717;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=XtJx2o1mcreI6aEG3xYpAuWQDKgBI/afDh8p4ZlP8ug=;
  b=bc2rUINgHvwcQViW5XdEunGQQJ7TskO6T7WaG8EiU5R9kP+1qJiFfKC0
   nMJwN4DKgCa0ikR50tbqqOlQAiL2TOBHbsHZcAnHWiAimEirt7D8CvSIq
   7UTs/oB8z0SH6rnrVu4VRUbpvMd8VwzaMRkQ9fYxKN+rNDcGMiZtGAB3U
   VZc7+d+kTmEaUSWk21vHQJUMiD83IuVtHS3ZlLBQ/sf2tduF5pjewtHiL
   vpy3o7IH91duRcwmw4v1UWZJOXvkXX0/JDV24etSImpA/Qe5ermsA3U18
   0NHg1p+lhHYKxgMP+lRW3TDYfFD/It4lvrK04EbIizfsOB7eaQKB+/qXo
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10530"; a="376090373"
X-IronPort-AV: E=Sophos;i="5.96,161,1665471600"; 
   d="scan'208";a="376090373"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2022 08:41:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10530"; a="780661609"
X-IronPort-AV: E=Sophos;i="5.96,161,1665471600"; 
   d="scan'208";a="780661609"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga001.fm.intel.com with ESMTP; 13 Nov 2022 08:41:56 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sun, 13 Nov 2022 08:41:56 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sun, 13 Nov 2022 08:41:55 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Sun, 13 Nov 2022 08:41:55 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Sun, 13 Nov 2022 08:41:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RdB/ZRjbDG1oCMpfWyS2Qit/DBqs2vSwT5uZevmVzGljf4a63S7Ce9Lvqj4WkC8KEXE9XSDfSMakP8JHdfoEWGtKSZ6dQiicL8Q3csUoxFUOwuEHaGuQTIEkjmalXKZhr4dzS6CdEmviRfQ2ZvOEbVxTNZZT0pXOi5ZqoqjtgC7NZzMIoACheFG+zegsRmeqT1bvfLDlbwALdbWQfVC0qa9nlbVdtgTlRtI/VHGwya826uthGA/2GRDZFW+pjdOXJijEEnfJ8JTMzfsxPAwWm0yXkf5UwaSIwE5svaRK7U2L1rtDkiQLp2NA/UfPmmjlNPLsVPF6JWeFqszn/7Hz1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wH+blhtgPC8wvcAXBjZTHLRD0ssK/ujlk65ffODy0bU=;
 b=mViJHrFFpeeSCPDmIhrCmo3J7twBE+KbuHLT5iuyOUwp+IPR5eKGkS+P/kTKSM+LVpiHfzecpga8xKFgUbPxDGKpva41bdo/fv5WCQlwZSVTV4Zw/Ug9hC1OdsjHMFQ6d8W3Y1n37zc7RwYcdPjVpHMPS1LgPSA4bUWfGh9S7lj4DW8X1SVFA8m2EeElWFl6gjyVdHQFPA1WKUcI8hOk+JI8t7Yvnd3CUVzOGSk8kPFxE7gSQP6KbfXd2i7AjDxIhnyKSjvpGtJ5pgXJTBPqHPDqSQPUWEeHZy7+2keKe4viaw1exCT2xOXpbqyUMzXT8afxKcLl4kZZJKvfQMTKgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3768.namprd11.prod.outlook.com (2603:10b6:a03:fa::20)
 by BN9PR11MB5435.namprd11.prod.outlook.com (2603:10b6:408:100::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Sun, 13 Nov
 2022 16:41:51 +0000
Received: from BYAPR11MB3768.namprd11.prod.outlook.com
 ([fe80::f980:8dbd:ddf0:11c0]) by BYAPR11MB3768.namprd11.prod.outlook.com
 ([fe80::f980:8dbd:ddf0:11c0%4]) with mapi id 15.20.5813.016; Sun, 13 Nov 2022
 16:41:50 +0000
Message-ID: <5e65889d-d68c-b29d-6cea-7b4ce4c87b4a@intel.com>
Date:   Sun, 13 Nov 2022 08:41:47 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 12/14] platform/x86/intel/ifs: Add current_batch sysfs
 entry
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Thiago Macieira <thiago.macieira@intel.com>
CC:     "Luck, Tony" <tony.luck@intel.com>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "markgross@kernel.org" <markgross@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "Jimenez Gonzalez, Athenas" <athenas.jimenez.gonzalez@intel.com>,
        "Mehta, Sohil" <sohil.mehta@intel.com>
References: <20221021203413.1220137-1-jithu.joseph@intel.com>
 <20221107225323.2733518-1-jithu.joseph@intel.com>
 <20221107225323.2733518-13-jithu.joseph@intel.com> <Y2/JNAmSoYlLKq3A@zn.tnic>
 <CC3629D6-B205-4150-80E5-FC7A7A76DD25@intel.com> <Y3CevK2zhAmiUyG9@kroah.com>
 <Y3DZmKYV+8HBtZ+Q@zn.tnic>
From:   "Joseph, Jithu" <jithu.joseph@intel.com>
In-Reply-To: <Y3DZmKYV+8HBtZ+Q@zn.tnic>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR10CA0027.namprd10.prod.outlook.com
 (2603:10b6:a03:255::32) To BYAPR11MB3768.namprd11.prod.outlook.com
 (2603:10b6:a03:fa::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3768:EE_|BN9PR11MB5435:EE_
X-MS-Office365-Filtering-Correlation-Id: b5bbca1a-f477-456d-a4c4-08dac595f6ad
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: glQIa4EawnrPV9WEcMrvhllSCMTfIG/1EhK17LMXlaSN0qEIwW57+juQ6ar4ji3pxjMNlVxd89LbYuWKRMg1gpDZZjwLGp7OYfe8BZLJynQPlMs4TKh45jtcMRWkImltEE+rSVMwu96EC4os99Dn1PnV1BesHF1FsDFw1B7bY/uWN6kLeIZxmSm8V2TMY6OAnpw9jsoGZfWmjoWyegpdhDtPiPj8vD3EqdiULGxz5RctqqYAsoHZlXYgs42cqokfIgSyJoaQ+yowHvcpEN7/csfi3bNee3oC5nx2luQ9+x1EMKV7I8nITIxPQOI2MFxkPqJ7tNjauLxPfNASD3628eXCHFYBnTGeI6Morsh/gv3eNpORIR+HL9kumQFrvvIl2kcBkurjPWKvUFtLku4EylEsQlfP4PZqrLFdO0MuDBy+gQ+svNXD+vwnk30b3jt9F4XV9i5qAyukRLD471OarF1Ut4fEb2mTexpEdWD+/psLyvB9ziVWKDTi2y8slQYmwLi18Cjg3QSf4n03CScS69JDPP9dAKYroL3Ip9jxD0zr+zOMoEXwl3AR2P4g/XdZB8C1vRiwClCLcOXlNWAQTNmYYHb8sbC6PI2UidUhu1dcHmZ42kq3WggcuneBtPNWtaD5VG5GbK9zFfnKOMuLArE6CoBanrrRdWGPdeOyPBALkaUGHc8/0ZYbVkTcdHNkOy5jLjex2TnfLvRa+q5e7sDBDH6DAGp7Ujahb3TdaqOdQgcrmG2NwCWvEpDkkfzAzeHtmh9dwUnnY+7tK2X0ZRW3StrcwRt3TOOt4ve5yL3zzUbzRVZJaF53mqk0Rb3gaqDifzNvSTlimcXivJUKuA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3768.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(136003)(39860400002)(376002)(396003)(346002)(451199015)(6666004)(478600001)(53546011)(110136005)(54906003)(6506007)(6636002)(966005)(31686004)(6486002)(26005)(186003)(36756003)(66946007)(66476007)(8676002)(66556008)(4326008)(6512007)(2616005)(41300700001)(8936002)(5660300002)(7416002)(83380400001)(2906002)(316002)(38100700002)(86362001)(82960400001)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dVRHZzQ2S1pGOU5DOGtlcU0wZWEvcWY2T3JKSmkvK0JoMitqdFZEamZMV2hL?=
 =?utf-8?B?RE5SNElhdU0zeXUwdWpnNGQxci9QcGdNK1piU0ZmeXRoSjdmQkNCakgzSkVj?=
 =?utf-8?B?cW91YkxCTmI0MGRIbjJuZ1NNbkxjRTNBRzV2WHNSTzhLSVBoNm5KV3BycFhF?=
 =?utf-8?B?cVBrVzFGanNrb05QRElVVmlPbFhjblZ5U0RzQzNOMkRiTUNyZDN0N0p0ekNu?=
 =?utf-8?B?VEkyYkZWOVp4Rk9heVE3Z21aSWErYjM0dUpNdFEvYjhqMDd4MlBvdklsUmNN?=
 =?utf-8?B?VmpSbldXRWZDSUhidlEwejZ6WnQ0QkNBYk1UQk80RGdlQVA0M1NmZjFEMHVl?=
 =?utf-8?B?anUzU1JjZEdHSmFDSlZ1VmNFdE01b2p1VzJTYlFXcHQ0VUZIUzFNTGJEblBu?=
 =?utf-8?B?MVFFNGNrRjVPN3hLK0lKYk9rMFdZMlN5RlEyazhoWnVXUjlQTEFtRGJPSjZS?=
 =?utf-8?B?bUlzSHA3NDVNS0lndmU0ZzNPVU9tbkgxUllPUWxxa3k4ZVNHUERGRm1KQ2Q3?=
 =?utf-8?B?TjJRd1ovK1o3bmF5ckhNaHM1RXlKa0k0cU90WTZjVFVBalpZNW9RRVpWVk5i?=
 =?utf-8?B?MWw4R21hWTQzYUEwQ0R4dStOeFZ1d2R0bFdYMVhkTXR0cFhBN1FqYXN6LzBK?=
 =?utf-8?B?dUpQT205SDYyTWR3L1FDN2FrTGxublhYdDJyR1ZSeHZFOU5XWm9kSW13YjBi?=
 =?utf-8?B?cGdBNy9uVUxIZlBtdFB5YnZJeVFnZVB2bnorWG5PT0sxdjFHU0tVT0tZZU9F?=
 =?utf-8?B?bDk0NmM3NHF0RWdtT003czIrOW0yK2crSjBSMzNQcXlwNVJtbHhCcHVtV3di?=
 =?utf-8?B?Ykh0RTZoaFJ4bW1wTjkrWkthQ016L0E5dklXWWlXYXg2RUQvZ2p0RFNQUHpl?=
 =?utf-8?B?djM4cTd4QmFCN3RSWkZvOU82c0MzdzhwWTcxRFlNNEpML28xUmFDeFhZaWNT?=
 =?utf-8?B?V3FabWNjeTc5VXVaaDFKb1pWdUk0amczd3lhbENmM1dvdlY1UTFIM3NtT0Zy?=
 =?utf-8?B?VGFKWm80RzhBUFZpS3hzS213d3pTeGVuandPRUorNGpQb0lBdjAyVEtQelU1?=
 =?utf-8?B?bWxsNHRFUnJUeDFiekk5c05KaHZtN1ZCUEZXekF3WlFtNUJuOWp1Nk94dDBi?=
 =?utf-8?B?SXNzSjFheFpIYTl0MUtjb0lnaFBUWHRyY1FYMk5aMjVmTnc4YlBGMUdTZjJM?=
 =?utf-8?B?VEhYaUVnelI3VFk5TVhJbWRBdno5WU95ZVIzZDBLamgyRC9LNUIyVEJJcHln?=
 =?utf-8?B?U1BZQi9xcHh3cEpMWUZ2UTlkb0QzdlVod29UTGk5ZjZtY09qMVg4eCt5YUVi?=
 =?utf-8?B?enptUVRUV0ViSTVCaWMvY1hPN2g5RW0yUGI4TXpQYlRoL3RQaXN3dForZUMy?=
 =?utf-8?B?ZG9PZ0JDOE5keTh3S2VlY0xOcHU2T1dYaUpzSTdBbnp2UmdER24wWGhvWHI1?=
 =?utf-8?B?TkJ6VnAzRXB2MHh6UVNKVVdPS0VORjArQk1Gb2dLUm1hdkpXanFrRnZCNWYx?=
 =?utf-8?B?aGZyOXVROXRqVW12ajZOQ1J3cGxwNm5ZU0ZVdmt1K3c1c1NTTWxtUzBYZjRx?=
 =?utf-8?B?N1dlU3g1QVpWNjFqaU9QL3hGUDZoa2pOUWhaVEx0S1NNcGkwZmxVQm1rS21k?=
 =?utf-8?B?WXlJaG5sQldyTS9RNTJMTjVIMUlQS3l5aHlLVTlyb255QzdNdU55OTNlaHF4?=
 =?utf-8?B?Y09VZnFmVFRVTzA2Y1hGYk02eHpmWDR4SnMzVG16RzEwa0habTlGTGlIZGcy?=
 =?utf-8?B?Vk5QM0ZwQU1WQVpHcHlFQTBmd2tYMTBhRFppM252WVlEQWpEelo4eTVQbk5v?=
 =?utf-8?B?aWZIUWJUWFlqVGFJY28xOXB6M0sxSkNmRzJUWW1yb3dESmkzN1QxVG5HckZm?=
 =?utf-8?B?YVovM25ZalJlNmthMGZyUzZ6V1VRZUViVHVmRGxlRi9JalVOODkrK3h2WnNL?=
 =?utf-8?B?VGplbGNzYlFQcXcwRERjWFplL0N4aDdzVXFRUXJwcWFuRDZ0Nm93VHEvOWVT?=
 =?utf-8?B?NW5QbElTVDlFNHU4cGJBaG5PK2Q0YXlnMlc4V2tnZm1ndVhheDA2Z2c3TnNl?=
 =?utf-8?B?SUc5aXdYcGZOVkMvUU1wSytPeTBka0JINmg4TjFkQWpYRWFlN1JkeW1DWDFV?=
 =?utf-8?B?d2FhaU1DWEJ3cHE2UEJ2dndWbkthSURoUmJrbFdQd095MHZEOWtXaGlRL0U0?=
 =?utf-8?B?U0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b5bbca1a-f477-456d-a4c4-08dac595f6ad
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3768.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2022 16:41:50.7751
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7FuKmdu9+n6XGsLtDFNAfp3y4wRJGa4NuWcRwD/4ZAKP4mughRZ84DG7CZiFz1g58In7p2mzAU5RAknGxedxVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5435
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/13/2022 3:48 AM, Borislav Petkov wrote:

> 
> So instead of what the code does now:
> 
> +	snprintf(scan_path, sizeof(scan_path), "intel/ifs_%d/%02x-%02x-%02x-%02x.scan",
> +		 ifsd->test_num, boot_cpu_data.x86, boot_cpu_data.x86_model,
> +		 boot_cpu_data.x86_stepping, ifsd->cur_batch);
> 
> It would still use the *same* scan_path - /lib/firmware/intel/ifs_0/ -
> no one is proposing to give a full path name - it would only use the
> filename string - 06-8f-06-00.scan, for example - instead of the "0" in
> it to build that string.
> 
> And, ofcourse it would check the format of that string against family,
> model, stepping and sequence number (btw this way you drop your
> limitation of 256 for the sequence number which you don't really need
> either).
> 
> And then if the format passes, it would check the headers.

Do you think it is better to restrict filename input to confirm to
ff-mm-ss-xy.<test> format rather than accepting any string and treating it as
a file-name and trying to load it, if it is present ?

(Given that, before loading, We do intel_find_matching_signature(), which validates if the
 signature/pf entries in header confirms to the machine we are on before loading)

We did accepting file-name as input before [1] (except for validating if the filename confirms to ff-mm-ss format) 

> 
> And only if those pass too, then it would load.
> 


[1] https://lore.kernel.org/lkml/20220710160011.995800-1-jithu.joseph@intel.com/
