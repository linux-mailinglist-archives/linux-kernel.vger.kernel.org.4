Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19CB273E1F7
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 16:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231587AbjFZOU5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 10:20:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231530AbjFZOUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 10:20:40 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3348A30CF;
        Mon, 26 Jun 2023 07:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687789177; x=1719325177;
  h=message-id:date:from:subject:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=FEJr/ZjR4L6Mj+m+ANvbpToFUixMw4uM+zrYAXaYqio=;
  b=gyB0cdmGzYXsa36WLiaerd3Zz5U+/njSFo9G+gMbjZTfE1IQYnoLamNf
   EaT61OelrN9BSO35TXdnY9KpT4+qlnFVfIKQrlEXPENrhkc658iELgFJL
   a3tIdWv+h8p/tsPlTM0+JvRQvIHfCxIlbSVHZ0SZMTp44F4XXU6yw+nx1
   y29RNr/Yt3f1citfkFfoHYL6RZHHHXjIHsonoSqRjcUVEx4JuWn3CLn3u
   rVtpqD2yYx1EqhptwGXSq2vyg2t1GTOjEgAMJ1zwAdPkdxWRC3j8dXmgs
   ikx1v3llyxHOKKS0UJ97vmNnPARCjwEJo3+YFycStDfbH8O/0tnYiLZfz
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10753"; a="364729612"
X-IronPort-AV: E=Sophos;i="6.01,159,1684825200"; 
   d="scan'208";a="364729612"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2023 07:18:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10753"; a="716155565"
X-IronPort-AV: E=Sophos;i="6.01,159,1684825200"; 
   d="scan'208";a="716155565"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga002.jf.intel.com with ESMTP; 26 Jun 2023 07:18:16 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 26 Jun 2023 07:18:18 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 26 Jun 2023 07:18:17 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 26 Jun 2023 07:18:17 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.170)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 26 Jun 2023 07:18:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mW5kJ/UqPabJyo0jwsvnVgYzigs4MHR6OKfAxeNPwI7utM4uGf+bCG2wLNq1Xw1cFXjmUQDXa2UXCXPjyyoA5uKciAjEufbuKadwS5flT1rGn0WaWEJaF/AVPw+c8bIFAIdU7Sy2bzS1bdGV71U0mwZUx5UYYjUJ9PQRewS5oT27FN8JaeEcXE4uyupLxEjFKImryZ6v6Eu1U8Ux5H2HPM8bDDWLQcpFF7vjO51W7rW617mvafzRJ59eZ9To69UTDm83Qttln0j0zrefOVkCqud+CgB9/33LDA04lSlfBBhKa3x18t2sjTkzGnjb8WOVU5aw7HVF3Ma0KaiED3Kh5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R+fj7gXjgf+6GKcbWSaLbL5jh9yDK9tbYiByrcHbEFA=;
 b=by6WZxevi+7jc1TlDweshb1YjMx84COYe1TBjCxIC3RMDXbHjbVbwTBCJUOZ9qAvhvbEXSNO3OPQOatQ10Wtoy+qcPqjZQgDMicmvYqr2Vhuxm6kHR52dBh3PIDhRkYBevETpmMSTYl3c04SQSNyh3YMZ17j7o0FzaTOgJlWEj1oS12FJoJ47JQIfa5mcZiudOxL+DhqQ9rfTD3RKWEL8waimOMEj09Is07Is2SYcoIRYw/hTyoSohVejwMIhwJ4sXRYtv1FCGg+vIWnP/2lw4eL6X0XP8wO5UgRsdmChMAtZtI5KI3pPWW+58BGuUJgmAlW6ddxybYuYrNDGFX/+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by IA0PR11MB7402.namprd11.prod.outlook.com (2603:10b6:208:432::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Mon, 26 Jun
 2023 14:18:15 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::82b6:7b9d:96ce:9325]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::82b6:7b9d:96ce:9325%7]) with mapi id 15.20.6521.024; Mon, 26 Jun 2023
 14:18:15 +0000
Message-ID: <e7e49ed5-09e2-da48-002d-c7eccc9f9451@intel.com>
Date:   Mon, 26 Jun 2023 16:17:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
From:   Alexander Lobakin <aleksander.lobakin@intel.com>
Subject: Re: [Intel-wired-lan] bug with rx-udp-gro-forwarding offloading?
To:     Ian Kumlien <ian.kumlien@gmail.com>
CC:     intel-wired-lan <intel-wired-lan@lists.osuosl.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <CAA85sZukiFq4A+b9+en_G85eVDNXMQsnGc4o-4NZ9SfWKqaULA@mail.gmail.com>
 <CAA85sZvm1dL3oGO85k4R+TaqBiJsggUTpZmGpH1+dqdC+U_s1w@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAA85sZvm1dL3oGO85k4R+TaqBiJsggUTpZmGpH1+dqdC+U_s1w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0050.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4a::19) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|IA0PR11MB7402:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d0e3234-89f2-45da-7bff-08db76502e55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qVDbw9Gdl7/UBvRazrKwqyJPLxSQmfQbkiqkYp1G/MeEBa92+5Vg5XpRmH4NNdFaFtghy7I2PZbge5WVdtMPBewbkYhuwqFv+1Pnlh4xoxunx7IidxABc9uPXSUmWSjko+X7R5lpAmrg2Esm0h4LORT+QX7LDrNoCHl2c1aRWhh8a/rHsgW7KoTbXM9XMhPlgk1ILb7v+3xFaAeRJybN4XuicgEb5mgBrc0vtVg8jGsJmAzYth7rAeDNuScTrNF7sQaBmaFrKQ4+xaGoOo6c/zD/Ywal6VoOa7qbvlDEK2X7A9ya+GMeBGY3SBL1gQaVVzQ5yBSD76VSIA40R3tvhtuOFi1eHrkSwYFE+GIRxGpDqthgw1zVHQkQ1AV3Jev+6bhPDcKnofzgyAacxP4U7MStViCiC2QgtxUudMQY10wOm/ghxRXSMn/rO8X6PVMq6n9SiQ5d18CmrefeAqrE7T5I1b+dcrlwEwK7f9yUp1JTbAS+J9wSRS5/K78cp0bwZEogiz3jRAqPm0hGRUmO2znWH0wxWEUfY0/lqjW514h+d3OB4hLdqwo7HsTb999PKariMLg0IBnFF+Udjazl/8D9hBLFcpIlffbvIZB1NTOmkWSUXdZIxIEF7ycCM+HtkNNxu41Jtb8dugreFUuPuQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(39860400002)(376002)(366004)(346002)(451199021)(31686004)(5660300002)(4326008)(66946007)(66556008)(6916009)(66476007)(478600001)(36756003)(316002)(8676002)(8936002)(2906002)(966005)(54906003)(31696002)(86362001)(41300700001)(6486002)(53546011)(6512007)(6506007)(26005)(186003)(82960400001)(38100700002)(2616005)(6666004)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WDVuZzI4YUdlTUkybjFQSnNsVUhyNTV2di9TN0dFYi9OZ2docjhhR2dkdlBr?=
 =?utf-8?B?SkFRZVNxZXVvRWo5cmVhZlFLQkltOVdENkVRZmVid3hJcnJOZm53WE5kaXZF?=
 =?utf-8?B?cUlvU1BJN1M2TGpHOHpYdmN6aWlJQTZPM1Vhd2RMaEZ5VGRDcDRvSVpWRFBT?=
 =?utf-8?B?clZTd2Z4UjExQU16d3pXdFNYMGtiSlpvc2hha1E2b3VMTnhVcnkrdWh6ZVVB?=
 =?utf-8?B?cStTQ2I3RWo1SUUwK3hFM1NuY2lLVG9DRUxrVndyelZGZER1MUVhc3hFa2x0?=
 =?utf-8?B?RzhKRFh1aWJsRFRkSFZycVVzei9NNE41TVR3R213dVJEZERuT01wdWJFWmht?=
 =?utf-8?B?REtoR2UzQ2VtSE16dVNJbFdXOFZKMVhvdXF1ZFhIRm1PNjc5QVRXd0xWa2lH?=
 =?utf-8?B?Y0RvbWs2RUtWbXJwdmh5Q3o5VTRCQlBwN01HZVJIb2l1L3lGNFVSS0xaUkRZ?=
 =?utf-8?B?bFhwZG1FRWc2cDlKTlZpdzQ4VUdOTkMzcFVxc2FYbXU0TVpKeTBZOWg3Q3Bu?=
 =?utf-8?B?R3c2TzBvdUtIbjRrQjdTQzNHQThWdERNUGF1ZEpxU0xsdHl5UkNqWjZxYU14?=
 =?utf-8?B?NWR4eTU4cHJMZGs1QUVBcWNuUk10a0FTUXRSOThURHZwbE5jUUZabUNZRW5z?=
 =?utf-8?B?ZmV1N0tleG9RSVo1R3d1U1RYYnIxUkFLdTBsK1F1ZXVTaUFPcGFiSzVBaHhE?=
 =?utf-8?B?cks1T2RVcUNCL1ExWTd4RFFWbHVtUGlGSjlhamNFWXhoUWFhczBYTTVxUTBT?=
 =?utf-8?B?dmgrNFlGbUJCZDNBakxpbnF4TllXYmdvWlNLOTM4OFIwM0h5L2VzNlNyQmpo?=
 =?utf-8?B?M1oxNS9mWEVVRUZ3WjBtYi9Mb1pieWFtMzZIUHhEc3JKT2xXeVdET1BhRC9p?=
 =?utf-8?B?MXVENm9uM0FJTEhXeWttek1nN2JLMHEwM2VCSWdhRzZvVnU5S1gva1JkaUhv?=
 =?utf-8?B?S0xuU2RaT3dNbC9UakdYdjNGcWlpVkVsZmFQSzRjbEljREErbkowaEVVcnhO?=
 =?utf-8?B?c0poZjc1cUpoSkZYa0NEWHNvNlhpdE1BekJ3aTVqNFUwOVBZYVc5SUpYQWVw?=
 =?utf-8?B?L2dVR0k4Wk52U21Vb3poa2I2aWxESWlDY0tXd1hIcXFJOHljWUdqTUJxZGRV?=
 =?utf-8?B?YXRzQXNpSDA3ZVRkQ2hOSlVjNitzTHNMd05PQUVrUzJrdFlXNnVkbWgvSFBX?=
 =?utf-8?B?clBCTmdXR3pBNmZac0E2dmEzNVZWQVJlcmlqUndFalBldE42Y25ncjUzQ1NN?=
 =?utf-8?B?N2ZBamFzdFptQ1BINTgxbUZoU0w4NEh1dEl5eWVaTW5JbWhlMlNHV0lNakRs?=
 =?utf-8?B?M3VreExOZW5Od0tlaS9vYnlWcUNnZk8xWlhVTGdCcFAwMzhMTHlYMXB0Zysz?=
 =?utf-8?B?dTc3dFhDSWUxdmdZV2llWnptYmwya1A1NUNtMFlsdGJuaGxLRS9nTWIxSytR?=
 =?utf-8?B?WnovZ1hCSC9naUs0NXVaQWZEZnpUcVl3OEN4Q2xRVVFoWmNwcnl4cE1IU1Vq?=
 =?utf-8?B?MGU3azQ0b0d0S0xhb0d1UG9RLzAzeWJ1WENjRW5GZUVlV01lM09BWW9EY0RI?=
 =?utf-8?B?Ymo3R1hjR1BiZzE1bjQvSmJkTEQwdS9ueFI2WGdPWTZEcUxsWnBOUis3K08x?=
 =?utf-8?B?UjNTS0pVaWgrWHVqcmFiRHNIZTRVdmY1b3hPUk40ZUQxS2hIZUJlUjNEZUdn?=
 =?utf-8?B?bGpZVVppVUdqYVNtNUNzZTIvN3ZqSmhOcUZWNGV3MDY5UlpiUW9CQllqcG42?=
 =?utf-8?B?NTBKbThUdnBtaUdYKzh5U1Z6d3NGMlJyWjBsMHRWRVJycWY5ZVZyRWN3TDB2?=
 =?utf-8?B?ZSsxSkgrNk1EeEljdUZwMjBDeFdZT1JXWDVuSFB1c2JTWnFnVTBXUjVKQ0Q5?=
 =?utf-8?B?N1h5Mzg5dXBoT2lJblVJQmEvUWIzREJnMTdpSjk2MzJKWmRIOFg5R3dMcUQy?=
 =?utf-8?B?NXQ5OWx2MGk0NTl0dTdUUHVqMVlpUG9NUWZ3MFpTUnZlR2lrbkg1VUdqckhu?=
 =?utf-8?B?L29vS21kNTV6SE1mbFhKUDM5dEZ1VXRXVHhpK0VCTCsrbklNeFgzNUVIV2Vi?=
 =?utf-8?B?bGNPQ2NMeWhmVkF6bThjbWtlMEpNTmMzVU8rN0o2TzVCaitzUisrRlp2MU5u?=
 =?utf-8?B?UG8rRU1tVUFsWWJkc0xOenBVSWhid0c5eWNNbXkzcmVOYnRjZWN3eTkwRkJB?=
 =?utf-8?B?Nmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d0e3234-89f2-45da-7bff-08db76502e55
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2023 14:18:15.3081
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X+gJY4k16FTYwhUekZxYZjDeiyrvh44gMR78cPPTDQFMGrKGejpa3Ay/yAG/Fncc7udHlYEApMcVoeZyDlEv871GV0zD3n7nJd+Zdc9CLX8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7402
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ian Kumlien <ian.kumlien@gmail.com>
Date: Sun, 25 Jun 2023 12:59:54 +0200

> It could actually be that it's related to: rx-gro-list but
> rx-udp-gro-forwarding makes it trigger quicker...  I have yet to
> trigger it on igb

Hi, the rx-udp-gro-forwarding author here.

(good thing this appeared on IWL, which I read time to time, but please
 Cc netdev next time)
(thus +Cc Jakub, Eric, and netdev)

> 
> On Sat, Jun 24, 2023 at 10:03 PM Ian Kumlien <ian.kumlien@gmail.com> wrote:
>>
>> Hi again,
>>
>> I suspect that I have rounded this down to the rx-udp-gro-forwarding
>> option... I know it's not on by default but....
>>
>> So, I have a machine with four nics, all using ixgbe, they are all:
>> 06:00.0 Ethernet controller: Intel Corporation Ethernet Connection
>> X553 1GbE (rev 11)
>> 06:00.1 Ethernet controller: Intel Corporation Ethernet Connection
>> X553 1GbE (rev 11)
>> 07:00.0 Ethernet controller: Intel Corporation Ethernet Connection
>> X553 1GbE (rev 11)
>> 07:00.1 Ethernet controller: Intel Corporation Ethernet Connection
>> X553 1GbE (rev 11)
>>
>> But I have been playing with various... currently i do:
>> for interface in eno1 eno2 eno3 eno4 ; do
>>   for offload in ntuple hw-tc-offload rx-gro-list ; do
>>     ethtool -K $interface $offload on > /dev/null
>>   done
>>   ethtool -G $interface rx 8192 tx 8192 > /devYnull
>> done
>>
>> And it all seems to work just fine for my little firewall
>>
>> However, enabling rx-udp-gro-forwarding results in the attached oooops
>> (sorry, can't see more, been recreating by watching shows on HBO
>> max... )

Where's the mentioned oops? Where's the original message?

Can't this be related to [0]?

rx-udp-gro-forwarding is here for, uhm... 3 years? And UDP GRO in
general is much longer. Is this a non-mainline kernel?
So many questions :D

>>
>> The code seems to decode to:
>> Code: c3 08 66 89 5c 02 04 45 84 e4 0f 85 27 fd ff ff 49 8b 1e 49 8b
>> ae c8 00 00 00 41 0f b7 86 b8 00 00 00 45 0f b7 a6 b6 00 00 00 <48> 8b
>> b3 c8 00 00 00 0f b7 8b b6 00 00 00 49 01 ec 48 01 c5 48 8d
>> All code
>> ========
>>    0: c3                    ret
>>    1: 08 66 89              or     %ah,-0x77(%rsi)
>>    4: 5c                    pop    %rsp
>>    5: 02 04 45 84 e4 0f 85 add    -0x7af01b7c(,%rax,2),%al
>>    c: 27                    (bad)
>>    d: fd                    std
>>    e: ff                    (bad)
>>    f: ff 49 8b              decl   -0x75(%rcx)
>>   12: 1e                    (bad)
>>   13: 49 8b ae c8 00 00 00 mov    0xc8(%r14),%rbp
>>   1a: 41 0f b7 86 b8 00 00 movzwl 0xb8(%r14),%eax
>>   21: 00
>>   22: 45 0f b7 a6 b6 00 00 movzwl 0xb6(%r14),%r12d
>>   29: 00
>>   2a:* 48 8b b3 c8 00 00 00 mov    0xc8(%rbx),%rsi <-- trapping instruction
>>   31: 0f b7 8b b6 00 00 00 movzwl 0xb6(%rbx),%ecx
>>   38: 49 01 ec              add    %rbp,%r12
>>   3b: 48 01 c5              add    %rax,%rbp
>>   3e: 48                    rex.W
>>   3f: 8d                    .byte 0x8d
>>
>> Code starting with the faulting instruction
>> ===========================================
>>    0: 48 8b b3 c8 00 00 00 mov    0xc8(%rbx),%rsi
>>    7: 0f b7 8b b6 00 00 00 movzwl 0xb6(%rbx),%ecx
>>    e: 49 01 ec              add    %rbp,%r12
>>   11: 48 01 c5              add    %rax,%rbp
>>   14: 48                    rex.W
>>   15: 8d                    .byte 0x8d
>>
>> But correlating that with the source is beyond me, it could be generic
>> but i thought i'd send it you first since it's part of the redhat
>> guide to speeding up udp traffic
[0]
https://lore.kernel.org/netdev/f83d79d6-f8d7-a229-941a-7d7427975160@nvidia.com

Thanks,
Olek
