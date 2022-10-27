Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD0560FF66
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 19:36:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235860AbiJ0RgQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 13:36:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235586AbiJ0RgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 13:36:12 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 613A3ACA3F
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 10:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666892170; x=1698428170;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9t/l/OzlcptUa0Lh916xmpxEBB6nxjs8J2IgCIFDAjQ=;
  b=lWjhmXuFLThs8XCP08FjWHSGxe+a157vEOgjZ71K+l7d9RzcbqnmlGtA
   Xg4QeZb9//D8kwWt3lb32IjKZCs9ALpYIGDs5qwfufpboVOz5QJCL+hzu
   DH4w94dQlZx3QBfAhzaU/CXhbDhqDrlSciwGKO+oXPVVyn0xRZeJWt+ZA
   0g9YkuJvF6ldfmSHxH4V7IcK4VB/Hf+lVyOcupslkvcAcU7PPRgZ2/2l0
   IJ8yDc1EpK4w71OuwrR5SU7Ob4lapfGP/dO1xT8jrc5y0lIjvxZ4bGH14
   mRYq7IqucqPOJSnGsdeRnqlC+TLEfQ9Q8U6f+Ny+gaGepLZDr+lVwPUQ1
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10513"; a="394608906"
X-IronPort-AV: E=Sophos;i="5.95,218,1661842800"; 
   d="scan'208";a="394608906"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2022 10:36:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10513"; a="663704594"
X-IronPort-AV: E=Sophos;i="5.95,218,1661842800"; 
   d="scan'208";a="663704594"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga008.jf.intel.com with ESMTP; 27 Oct 2022 10:36:09 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 27 Oct 2022 10:36:09 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 27 Oct 2022 10:36:08 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 27 Oct 2022 10:36:08 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 27 Oct 2022 10:36:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DZNDLfNtnRnxgVpLWI7Pdi3US6G0iAo1POBMjW0b8T0hEzIb5k5d3Twa5L2nOtBsq1E4AilUAlCUFtzotYMFs8kQgbX+lXnzOoTEzO4D3WV5dPtBxtYYDJtg6m3GNVlPF/Zb0Oq1+/sdAZELHZL+Jx7wuxlrInaDAOpE1k6hDJMyYEFzsyNJg3NEFx6rT8P88xpRGfOTD7jeYXoTtlWlfEZ6qUsn+fCGIwUO+26O8ma9GT+LWi/SgGIYH0knpPRZ8mU0pCkgauzcbsWP59qvHrOq2GoFfL6+m5KscBblyPdBacQKz5JgF+AeMBSRCrZrkhT69vo6PQrRBtyb+JJy1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MfphHS+4JnrQv1CmqeEjU/hb7dTzbKKAvLRISkaGyFU=;
 b=awtGKvfvnLeXsaEfNMI9wV+F0gQvJthcpHf0dImMiprcfx6R3Do9GpBqc23B49cbPYDaFK2MqSipqgia/5/H4VKI7+bKPWxgIMEIaBM2wnK13TTxDofMIgPXxn7YVssxyQ6iU2DplSyhe/bE0gkPXbj0CWT1JcNTyZu1T2kZDL60y0GfbB5sP+5oECFT1EREH5KQxPKaIql8VEjE5pjtUlVjnBYV35+jnFvmmDcM1ezZ6PZgiLT7SCHF1WOO+5thcZdotCh58kYAzZApo8N1WkkFh7SdrrFchQFajHRee5E7YOR7bxZN4wEIUyxVaSIdxpKKpKcEuU5Zrd8gIx6hcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by SN7PR11MB6750.namprd11.prod.outlook.com (2603:10b6:806:266::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.23; Thu, 27 Oct
 2022 17:36:01 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::207e:ab0b:9e29:6a4b]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::207e:ab0b:9e29:6a4b%12]) with mapi id 15.20.5746.028; Thu, 27 Oct
 2022 17:36:00 +0000
Message-ID: <08c0e91a-a17a-5dad-0638-800a4db5034f@intel.com>
Date:   Thu, 27 Oct 2022 10:35:56 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.0
Subject: Re: [RFD] resctrl: reassigning a running container's CTRL_MON group
Content-Language: en-US
To:     Peter Newman <peternewman@google.com>
CC:     James Morse <james.morse@arm.com>, Tony Luck <tony.luck@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "Eranian, Stephane" <eranian@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Babu Moger <Babu.Moger@amd.com>,
        "Gaurang Upasani" <gupasani@google.com>
References: <CALPaoCj-zav4x6H3ffXo_O+RFan8Qb-uLy-DdtkaQTfuxY4a0w@mail.gmail.com>
 <b2e020b1-f6b2-e236-a042-4eb2fd27d8b0@intel.com>
 <IA1PR11MB6097236CFF891041DBA42ECB9B5F9@IA1PR11MB6097.namprd11.prod.outlook.com>
 <Y0BhzKkksSjSeE3W@agluck-desk3.sc.intel.com>
 <81a7b4f6-fbb5-380e-532d-f2c1fc49b515@intel.com>
 <CALPaoCjdeRjyX5L6BBX688ZM21eMwetuL9QLF1+GEDUskGcU2w@mail.gmail.com>
 <76bb4dc9-ab7c-4cb6-d1bf-26436c88c6e2@arm.com>
 <CALPaoCiKUQC+LxDwKQ0gE5AQniJi_nbzrXi_HA9ZBRtiXdw_dg@mail.gmail.com>
 <835d769b-3662-7be5-dcdd-804cb1f3999a@arm.com>
 <CALPaoCgiwtvxZMJ6f-BOTNMPXDbMB8QM42HyCAvYRi4grPiphQ@mail.gmail.com>
 <CALPaoCg2-9ARbK+MEgdvdcjJtSy_2H6YeRkLrT97zgy8Aro3Vg@mail.gmail.com>
 <715e4123-fdb3-a71e-4069-91d16a56a308@arm.com>
 <CALPaoCjUk31HvhaqWKfkLNLyZJzbDLJOnEqTsqn882CToLCGcw@mail.gmail.com>
 <317b4a96-f28d-aab5-57cc-f0222b7e4901@intel.com>
 <CALPaoChNAaoJ7uzuxFFDn-f5nvUCXyJ4jkbETHXNdDpXNnh9pQ@mail.gmail.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <CALPaoChNAaoJ7uzuxFFDn-f5nvUCXyJ4jkbETHXNdDpXNnh9pQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0025.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::30) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|SN7PR11MB6750:EE_
X-MS-Office365-Filtering-Correlation-Id: e718ef5b-f459-403e-0ae1-08dab841b638
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pBl6WP/LFkLM+hQ33luMPp+6InxvC6KFV5N4wLSEpDUTKzYcRL/cGBxRblI6EL4AZ/2saM9h0Us1Yo0NF2DNAlRXK/f7gFFalGTdkCEBpkabXQbgMbl6KBHLi3/WlWAWvvk8yRlYAfCHoIqJzqcGa46xsX6+/3vztp3lq+HAqY+Xd684Of8ysAgAJgNe+a2EG+MoYbPBvC975V9n+w0qH4K1BKKEMEtBiUDGX6JiAoasgBbiKhgPSugB6YVUROgDlG/ISN2eCgmdJgbFU793jBHAkNgyD2nqNKbjdqr3HDQvuE3+SnwLvcH2golDYq9C9DoQyJekJfgfn9ums8kINalfm1l11rfZoPUtpsLPnrfAFzP2HF1vctyHunBilUtgV3ZL9PjqqvJuEQgWmcTfw3ttHUz0sCqdQEhfijYlQgFANMzWciJpCwyNxhUyxNlL9MN+OuBzK7ZVJLlGxw+HR4AKVZNKaEbSBCxtcyx7lVA64/eWwNMsbSiC9DjYZoh6hI62cVUA3QTkjYiSJIN5jgxtjExscUOZcJ+nIgEbUlBoEctpfIRGIhRcz1nvMiqL8Lffi/THXxIWqMro9Zv6DlBynb8v5SPndFK1MTIHQof1ZNFmqXep934SQ4Zqpx+acxhUM+8JCfDaKc4+0QkUPlhS4FybWMTou+chA1hqv5hF6mrkF6bTIV5PCmA02k9ezJlRHps4v9r5I4+YHgyXGsG2uXqGJmzVbvM4nmdD70Xsi5gABnMb7rWmh3QIjfCsI5/oFubFa6w0Oy2ilcMuqG8rHCv3FikKjYwS0vkhF48=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(396003)(39860400002)(376002)(346002)(136003)(451199015)(186003)(2906002)(83380400001)(31686004)(26005)(41300700001)(86362001)(6506007)(6512007)(53546011)(4326008)(8676002)(36756003)(31696002)(82960400001)(66476007)(66946007)(2616005)(316002)(5660300002)(38100700002)(54906003)(6916009)(44832011)(6486002)(66556008)(6666004)(8936002)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QnNHbExZNEw2WDI1bkl1V1ZuVmVjaTZWTnMyMnVWTERDKzUwbmJUQU9idDJ0?=
 =?utf-8?B?N3NOTW01a2F4TDM4ZnRTQ1FJSWRqUHVFdkVmUkFTa0o4bVBSVTVtUlJDZEFs?=
 =?utf-8?B?bktjR1FOZDVkbHdqaTQxOVc3SzRvQ2FKcDdzb0ltNm1nRkVoeTh0MTNsYVE5?=
 =?utf-8?B?N2UzOWJ4VzBaT0FQT0YxSGZBeGxrVVBIZ003SmFIYmd3NENNMWdxTURvTHpn?=
 =?utf-8?B?QlBkbWJXN3U1SEhhT1pFSkNFS0JEN3pybDdDMGpkZkorRlhkdGFxaE1OWFJP?=
 =?utf-8?B?UHJSZDF2K1F6dHJ2VjdzM0tOMWRKYjB3WHpmcjB2UXFIdWg1V2xSS2cwQ2pN?=
 =?utf-8?B?Y01lUFdrdXQwUXNNYUsvd2xOdzRQT2xLSjVWZVJNU0FTa3hBRDNjWGVvbE1K?=
 =?utf-8?B?aEFVWHE5VG95ZlNaVmpYTURUQlNvajU2VHF2a0ovNkcvYW5pRy9WV0hkc2Jl?=
 =?utf-8?B?aWhTSlQrcDFpVWZ6T0xsRWpYZC9iZ1dDWEZVdm1rbnpQZzNjWlJEMStyVWRS?=
 =?utf-8?B?SXNKbkh1TzJCWnlhZk83QjFaQUxENi9uU3phWUpBa2NpSHlJVHZIYzh3UTFS?=
 =?utf-8?B?eWZUQUptTlVTZVBnb2NOMjNGQzREN2g2VDdJUURJaTZ5Y2VpcEpxdFZKMHF1?=
 =?utf-8?B?YitMMU45bndOcGlxT2RoSG5SbTRRMGh0enk2V2h1OEhjL29QTzJ2MHNxaFhS?=
 =?utf-8?B?WmNPM1g0dW9wd0poMXJTMlkvSlpzd2s4YWwvQWdiNHNtUkVNNUFRaUo2RnVV?=
 =?utf-8?B?MGM0VUJVSjZ4eVduckdrUWNoTHZRSzZINEVzUGNadkJDSHNqK1liN2wyKzla?=
 =?utf-8?B?bE1BZkhxUXQ2ak5yZGVHMFcvSkRoNjRmdks4ZDFqUkFDLzhuVXZPZGd5YUFa?=
 =?utf-8?B?RnpHeng5OHZkMUJNMGZwRFlHU29HTzgvaFlmNnptZU1PenM0MzdINkdmVUxi?=
 =?utf-8?B?SE9aM3JXQXhoYmgvWktvVnpVOWd4T2toVDErcGFscklvdUNjWGM0YjJDTXk2?=
 =?utf-8?B?c0I0TjdjK0FveWM4cVRaN1hZUnZyL25pcDRRNS9tWjR5NEgrcHNzN1NJbDhS?=
 =?utf-8?B?NzEvcm14dzhycDQwd25ZZFJsVlh4ODZ3M1NXakhGck0rY3pJUmNaVCs1Ti9p?=
 =?utf-8?B?N3JKSjc0NFNlT0lyemZlblNqNnBtZEY2TkZobnIyUnNwdzhnaG02dnI3S0x5?=
 =?utf-8?B?OE1pMFNSQmNKczlaMGczK2lKZlFwalM1RmI0OU5DVW1KWkRhVTRqOUo3ZWEx?=
 =?utf-8?B?ak9NNlVGSVdPNURzWU1VZmc2cUFnNEVoVzlMZFJxcnJkM3o0cFdGSzZ1WHVI?=
 =?utf-8?B?d2h3Tk5UY0hRSmp0SDlEYm5SQVRxZmhISUpmN2MzQVZKbkNaVGhGcndqWm80?=
 =?utf-8?B?WlFYNXV2YVROaGhRQUZ3dFZsbU1HVGdwOW9ldzRGUzlEeGI3eEZoYnd5a2Jx?=
 =?utf-8?B?VUx1bkpsdGRncFV3Y3VJY1lWM09halBkWWp2L3lETXZEZEt4Y3VXa2FFMTFq?=
 =?utf-8?B?WHllZ0lBVFpldjZlVDFHZEhiVjhiYlpXU2JHWk8zQVdITHljUGZFeUp4d3Rn?=
 =?utf-8?B?WnQzYU1RVnRPenBUSUozd1lQT0ZobWdBZTdiYjdLN3dwWGlvRHBKZTNmYStq?=
 =?utf-8?B?MkZKc1FKNDJhZU51NmZyQ2V1VnhIM3c1czhzRkt2a3dQTkl6d0ZDc3h4Ykw1?=
 =?utf-8?B?ZEEyb2JYMzFGVVMvU0tjYUtQcGQ2NVdmM04vSG1yZEszS28vTW1ydHphcFEy?=
 =?utf-8?B?d1dvM0tSU3QvUmZUak5QSlFsTTRidXRuRDB0NnpCejNCRVYxeFZQVUJQYnd2?=
 =?utf-8?B?elgybXQ0d29odG9EYVhRYURyNldjdzVOeDlQZVROZ3pxS1NOUU5md0FBRkpF?=
 =?utf-8?B?YTNVclhmbjdBejVtMGxsTnY3NFdXcDVrQUtVVW4vc24vYUpKTEVhZk1Zdktt?=
 =?utf-8?B?aVY2SHk2VU5vdlkzN0JDSHJka3dON0tHcmxZMFRnc3dmdmRRd2VjQ2lwREJk?=
 =?utf-8?B?TWFoYnpSamE0RUpUMWh3cUNPOCtjd3l0WUJyK0hPRVR0b3V4RElkeU9VWU5k?=
 =?utf-8?B?RS9GNE1kVnpWWUxrVHJ0RnRqeFBpengxcThJbVFpUDlFYW56S1BHcFhrOFJ3?=
 =?utf-8?B?b05Qc3c4RkduV0JKdVh0dzRNTkpLQWZhVTh6NGtKeUorRE9nSFJxeVlMM0VX?=
 =?utf-8?B?dVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e718ef5b-f459-403e-0ae1-08dab841b638
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2022 17:35:59.8982
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xgLSpm2sY98svTDaatVDLwX9ZhXwP2RV/sz7nhu+GaUlgB25JWTTPEh0GEMLjGljNoKQefFLRhQgoXwmgvjbQsLYM8wicsJUfVBgNdL5ZzA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6750
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On 10/27/2022 12:56 AM, Peter Newman wrote:
> On Wed, Oct 26, 2022 at 11:12 PM Reinette Chatre
> <reinette.chatre@intel.com> wrote:
>> The original concern is "the stores to t->closid and t->rmid could be
>> reordered with the task_curr(t) and task_cpu(t) reads which follow". I can see
>> that issue. Have you considered using the compiler barrier, barrier(), instead?
>> From what I understand it will prevent the compiler from moving the memory accesses.
>> This is what is currently done in __rdtgroup_move_task() and could be done here also?
> 
> A memory system (including those on x86) is allowed to reorder a store with a
> later load, in addition to the compiler.
> 
> Also because the locations in question can be concurrently accessed by another
> CPU, a compiler barrier would not be sufficient.

This is hard. Regarding the concurrent access from another CPU it seems
that task_rq_lock() is available to prevent races with schedule(). Using this
may be able to prevent task_curr(t) changing during this time and thus the local
reordering may not be a problem. I am not familiar with task_rq_lock() though,
surely there are many details to consider in this area.

Reinette
