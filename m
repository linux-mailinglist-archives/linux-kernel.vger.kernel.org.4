Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62D6474F957
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 22:50:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231153AbjGKUuO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 16:50:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbjGKUuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 16:50:12 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EC49170C;
        Tue, 11 Jul 2023 13:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689108611; x=1720644611;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=lro4FuLGbWTfBle3PRHNygGmH/BSDsED/cpXl3Pg1Rk=;
  b=Or5r6LbUFDxe5CZ+vEOVisgrMKQ5mW9htm+sWI+u36mhO6t/B94tPizH
   VNaHdfdhQ/GRDqscUEZkNLefx0obuYQo0w5GDa5ZcAgajcSzNSxA3nqRU
   tK9m2HGW5aDxmn6aRUjks7MloW+DORngIz6kQeM4qYI/xh0c3NOq9MCVi
   6cZsKiLQPvVhYxIprOLS/yhU9MrDYMhF9pYbmEN/qLVd940c/Nwrtoyuo
   hWqY6pavt+ZWWuJzpNGVOgiUDffuCJOqX4qb/qXjI6LCnMuya3PyUi+Av
   6zKyqEwCgcNW6BKKy/BQlH93gngrz2tEVd1EjPJRVV+xcQGCaxGMRb4cp
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="428468543"
X-IronPort-AV: E=Sophos;i="6.01,197,1684825200"; 
   d="scan'208";a="428468543"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2023 13:50:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="721250287"
X-IronPort-AV: E=Sophos;i="6.01,197,1684825200"; 
   d="scan'208";a="721250287"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga002.jf.intel.com with ESMTP; 11 Jul 2023 13:50:09 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 11 Jul 2023 13:50:08 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 11 Jul 2023 13:50:08 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 11 Jul 2023 13:50:08 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 11 Jul 2023 13:50:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XdDKvHsNeeih3WKUbwYvXLrmzgXVFZ0NL5mjvDUh3woUyyVP4ansncS2savU/nN7hLVsCFpR3aR58Ftx6a+I6tT3Ymrj5Z6eOl3Ij/onCTWpyoqofsINQChK38ESGM8QDdqu6xLeCAE2aynuNom1rtL8qdvdmbsaexRaSFoIfH2Sz34c5CpTHAmQeRY69nAyEj9GyQ5IK53GC62oA4ue7xx0N4K0bt/YcCkkP+XAdbuimhEhfyEqdbodIVPiJs6pJ4ts+nfKaAymbY6LAMd2k8YavrONyxdnsfRpVP65As2FHZ4FAfjWa8Jpmx4yVIBB9o4swtZReBZwjIe1XQadIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ipZ2e9xGYCnGnUKQku8k2N5vPa/5M2m1by2xo2VkYE=;
 b=Y9A/aw25cKlkMX6ihmXcv5R3GWzQt7ChEX1kYEGhXT6/7wq7ws0f+Hhr4hPtjP7FUlg/kvBJni6bnuCL1t8nf4JSEGHYJ2xF/FUjB2/StU0YivUA57kH9P0wH7Dayi3grBNBt7ykddsC5aq1suz6J4wz3EazzdxUBWhMjVZlg93dcOsffhn9zI8NoSrGDZF1bxxmO62Wao7md2MmrDuzlBIPE28mh0d3QKxtVd3uXGnPMjUjXJQO9usJOeajwTpL2ZqIVlN2W5q64BNn6M6IUCufbtizJzhhbEI7n8QLu9/vh81XOPVeOrwhK3QxjzO+hwE29qA2VRZ/PKlNcNzw5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by MN6PR11MB8147.namprd11.prod.outlook.com (2603:10b6:208:46f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Tue, 11 Jul
 2023 20:50:05 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::3b1a:8ccf:e7e4:e9fa]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::3b1a:8ccf:e7e4:e9fa%4]) with mapi id 15.20.6565.028; Tue, 11 Jul 2023
 20:50:05 +0000
Message-ID: <30b63f35-1839-6870-d81b-1e8bff88dc70@intel.com>
Date:   Tue, 11 Jul 2023 13:50:02 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH v2 0/7] x86/resctrl: Add support for Sub-NUMA cluster
 (SNC) systems
Content-Language: en-US
To:     "Luck, Tony" <tony.luck@intel.com>,
        "Shaopeng Tan (Fujitsu)" <tan.shaopeng@fujitsu.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "Peter Newman" <peternewman@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "x86@kernel.org" <x86@kernel.org>
CC:     James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Babu Moger <babu.moger@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>
References: <20230621174006.42533-1-tony.luck@intel.com>
 <TYAPR01MB6330B9B17686EF426D2C3F308B25A@TYAPR01MB6330.jpnprd01.prod.outlook.com>
 <SJ1PR11MB608331B7F85320DD4CD93448FC25A@SJ1PR11MB6083.namprd11.prod.outlook.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <SJ1PR11MB608331B7F85320DD4CD93448FC25A@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0077.namprd03.prod.outlook.com
 (2603:10b6:303:b6::22) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|MN6PR11MB8147:EE_
X-MS-Office365-Filtering-Correlation-Id: dd14d848-8fc5-43e2-0d8b-08db825067b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j8ql8wmxq3SrEzWBuU7kvvfrSf8h3wo7JhWXKVeaT6jhk+H9eibF6QVuik1GHEwU4U0wz6W6xU3qiWqnL/8mWZUi8toEb7/PMCKa15b+8K0VrA0+loDM2rViCSoDccQcY90yQjEkV3n++QumrtcTsZ1pQPEMjD7Es8aDjrFUVPBWJ3mGavTVQnjAnQob1YDNQnFcmbd8e8mZA4+Oafw/pfPJU/VAs1QfwxzqKq2Ovmnmd8iuBoyt7vTMGR0G87BWP6SXZ5P+lWm0mKbNvLTK545RwyPZ5hP/X4BcyNvTDGw/vVMWdRG2sdESDaPZs3muSfxt6wGyxd0iY/fWng9eTAKqfrqLoyk3TfgzmGr/kyfsvj64FMq6fby1TSkPtW5ykjchmeewJauJ+qjIM64LD6YDwjjO4kE590YpUDPsTxF0EuqqN3O7vtJL9TlwIT08i9lhuKJkuthTjt2LqMWRiGJ5IsIsLwFEDdctCp8lJEx1/7Nnv+IxSM/aEZRBx6vv7ka0eb3Xn9/f+Ohx4xjPDT1ysaa8iV0gKLMOmjASqGMFVaojap3vJIoKBqWITQ9Y56gb3cfLFJrlysvZ4JBfoIuJ8O1KahF5L5RihvKfXt33UpXROLuBzlDXyvo3GqCUFpt43JpIUhrfwr6/f2m+zQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(136003)(396003)(346002)(366004)(376002)(451199021)(186003)(6506007)(2616005)(6512007)(53546011)(478600001)(26005)(83380400001)(41300700001)(44832011)(4326008)(5660300002)(66556008)(2906002)(7416002)(316002)(8676002)(8936002)(66946007)(66476007)(110136005)(6486002)(6666004)(54906003)(36756003)(82960400001)(38100700002)(86362001)(31696002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UVJuc3FIWDRKdDNQMHZZaU5xQ21hS1c0andkckl0NGw4MnFQTmpsOEpyUzZN?=
 =?utf-8?B?azh2eWozNkdnZ3V1SGxiQnZXOGYzcG02RU5DZ3MvZGVVbDEvOUdlQjVOZHdt?=
 =?utf-8?B?c3ZReXVDUnkzWGQ1YXh1REwveWM3azlBY04rM3JGL3BCQ1ZSSE1xN1d1VkFv?=
 =?utf-8?B?UGxIQTBXSXJZekN3TEpWdnJsZi9HZTBMc3AzaXBLSmJ3L2JLcWZUQXNBMnhX?=
 =?utf-8?B?QTZSU1NPSXJhRDNlRExqUWZEUUV0dEYwUjZOZ2dabzFid29McjhyRzdYUG04?=
 =?utf-8?B?LzU5bGR2UGV6UHBVaWFQdnRrQzVGaFpTb3gzR1hxT2gvUnFMNUlNYmRlY0ZY?=
 =?utf-8?B?cDZ1WXNPcFAwd2x6N2psUzY1Q3p2blVhblVUSWVzVWdIKzlxaWZsZEIxcXVF?=
 =?utf-8?B?bUxmdzhkOVgzTDhDYTRITkF2UmN5R0NzaDU4L0VUM2lheUdSTVJrdW5MQ3c3?=
 =?utf-8?B?d240MWVZY0lzWmY4eUVpMHIxWWY3L0YzSURGWFkzUThXSkcySi95aTNqbkxk?=
 =?utf-8?B?Uk9kc25aZjBhQmV5OWhLZ1d2NG84N1c3ZllxbHQ1eXZPSnNkUjUwQm1CbkE2?=
 =?utf-8?B?YjhCaURhV09sQXB5dTBER3MzOUFkOEVaV1ZKR1lFeWx2TkdmdTlzNFZsQW9k?=
 =?utf-8?B?c3JURGd6dWl6cnNCdWpxVTJZdmp2bmxLcjJmNWhaTllSd0FVMlpBbzh2WlY0?=
 =?utf-8?B?NklwVXl1ei9kQTJNeXo1a1VybitSK1RjQzJTam9wcmJPa0ZyQlNjOUk5VUww?=
 =?utf-8?B?aURlUjlqNEptd2lBN0hPc2tvYjNha0dua0VwNkpNa2RaZjYyVTRxcHBOTHpS?=
 =?utf-8?B?eUJ2TFllVG1KZStKSVg5eVl4S2ZTWFFsMElldDZYVndBK2E4YjFDM0JMZGly?=
 =?utf-8?B?L2g1NTdXNllPTkplVFJTV2MzaFlreUZ5emRrMmVrdUtTSTZYZFBzU3VsMXNm?=
 =?utf-8?B?WWMybHgzejFCYStsbmE4WmRJZ21OcnAxTzJYYjgwd3hmK25jYWpqS1ZuK2Vx?=
 =?utf-8?B?aW8vdEU3bjJtNFFlZmViM0h5UDBsNUNzcTNMaktBbVFGL1MxbWRxZm4xbmJu?=
 =?utf-8?B?MDJXelJjNG4wN05BamUrMDRHV1pIWERXTTdKempTSEFiU3hpckl5ZGNZVWR0?=
 =?utf-8?B?bHdBYlQ4bXdrUzJ4cCtCQ0pIc2kyUXM0NWRVeHNkL09qUUx0b1lNNU10Lytj?=
 =?utf-8?B?MGxPT0V5RjJwaDEwMHZaKzZiNG8ySDRIclhucGkzUjRWVXU1Vmx4aHVNLzJ0?=
 =?utf-8?B?aVVRbmpQZGNBdWZjZXovM1RKMHE3NWdsaERud1hnbXlyV0JPek9BTENGVUVN?=
 =?utf-8?B?YnNJNlVaaXdycjZqMmk2MWxIbERtRUw5WE1BTFZIcWhNT0xDcWlxWW9oVkll?=
 =?utf-8?B?TkJjTGlCMWsrREowQ2h4SEppWlAvS3BTWHFBRnJxZzVNc3NIRkRZdTR5WXpB?=
 =?utf-8?B?T0NUTmVKeVdpZzNadEU3YjZqYTBGRTZBZ1U2cUFmUmw4cGtCQUM2a3ByRjdE?=
 =?utf-8?B?RkRQTm9rTjI2YmJmeFBIQlB2SVdycnczYXhlNHNlOS9SNEltV3ppeDNpRERj?=
 =?utf-8?B?NUYyQVB6UzdRSExBeWMyQTJPWkpIT2ZUcFRRbmFjUFZqYzhTY2J6ajRYY3Vn?=
 =?utf-8?B?UDRHbnVzR1F0aUVIQlVGRzhFaEpoK2tzYi9iblRsditrWDNhMlZ6QkUveEta?=
 =?utf-8?B?bFVZMVNtTFcrck1nc1JwalVIRk9na1hBZDAvMXBGL2ozMU9EdmUvMTNsLzBo?=
 =?utf-8?B?M05IaXV5VU1sRjZrZGE2dUhyUnlZNDV1YWVDL25SNjRXWUxMZWtuZmczTVQ1?=
 =?utf-8?B?M2hqNVB0eG5lOXpTOXVGUngwNWU2YURERnJHb3pxK3E4SUJuM1VkOTFrYnl2?=
 =?utf-8?B?ZEQza2tBUWdYRjA4dTlVMHV6S3dERHBVVmI2WE9FSmlTZGx4TDFyVHVWdlNy?=
 =?utf-8?B?Zm9JV1FKbWpUUXMraEFhOWp3MkNCQjI4M2NYNjYrdUJ2eTJiNjRyUkxmMTJu?=
 =?utf-8?B?eE9lYXZJQ0N0Smo2SDlvL0xPS29hT1JVYjJYUTVNMnpaVlZETTdJZm1Yemt2?=
 =?utf-8?B?dUZTSzJkYXpFWk15ODJxa3NSVzNmdVh3U2gwZmtKMDgyc3dQcklEZ1pVRWZn?=
 =?utf-8?B?RFBvYUZLTnRPb25PcVZmdStYTUJGKysxekRZM0NKeEhFQkdDVGhxWHh5ejB3?=
 =?utf-8?B?K1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dd14d848-8fc5-43e2-0d8b-08db825067b3
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2023 20:50:05.3486
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dFTjUJPeLwuQYGJOSjtyhoRkrQMgwE40CW949yxRt/BwC5Zw2C9KkRtTlFd7FFrPf6Asv94VEJh4ELeBRYqw2viAc9ZC9vMkHcA9oOwsUlg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8147
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

On 6/29/2023 9:05 AM, Luck, Tony wrote:
>> I ran selftest/resctrl in my environment,
>> CMT test failed when I enabled Sub-NUMA Cluster.
>>
>> I don't know why it failed yet,
>> I paste the test results below.
>>
>> Processer in my environment:
>> Intel(R) Xeon(R) Gold 6254 CPU @ 3.10GHz
>>
>> $ sudo make -C tools/testing/selftests/resctrl run_tests
>> # # Starting CMT test ...
>> # # Mounting resctrl to "/sys/fs/resctrl"
>> # # Mounting resctrl to "/sys/fs/resctrl"
>> # # Cache size :25952256
>> # # Benchmark PID: 8638
>> # # Writing benchmark parameters to resctrl FS
>> # # Checking for pass/fail
>> # # Fail: Check cache miss rate within 15%
>> # # Percent diff=21
>> # # Number of bits: 5
>> # # Average LLC val: 9216000
>> # # Cache span (bytes): 11796480
>> # not ok 3 CMT: test
> 
> This is expected. When SNC is enabled, CAT still supports the same number of
> bits in the allocation cache mask. But each bit represents half as much cache.
> 
> Think of the cache as a 2-D matrix with the cache-ways (bits in the CAT mask)
> as the columns, and the rows are the hashed index of the physical address.
> When SNC is turned on the hash function for physical addresses from one
> of the SNC number nodes will only pick half of those rows (and the other
> SNC node gets the other half of the rows).

If a test is expected to fail in a particular scenario then I think
the test failure should be communicated as a "pass". If not this will 
reduce confidence in accuracy of tests. Even so, from the description
it sounds as though this test can be made more accurate to indeed pass
in the scenario when SNC is enabled?

Reinette
