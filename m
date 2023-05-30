Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 716617168A4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 18:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232059AbjE3QGe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 12:06:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231965AbjE3QG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 12:06:26 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDCCC109;
        Tue, 30 May 2023 09:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685462783; x=1716998783;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8sCKZvSRx/c3nsYvoQJ2yHNfHlSYRqPhHc4LiwSoPjU=;
  b=eNgK4CEkzLoMwQXCMrqxK9KmZuL8XsO3p3RNLOj9HYvTtupt4i2EuBHn
   PyQws1et9/+zumjOsXd1VszOmP29Um73V6/sEWfZIFQuEQzJPs9kg8qkN
   yTkK3SKWOYElcptHXyEeqeiXvQlimvH7It/WfH5wQ1Oygbm11/0W3YPhZ
   bxic9IQwwnpUuaPSw+OcX6xdT4FaR7rpKkvstUhca0bVDLrRdQK+4g7gx
   Mc3/Ucva/cIOsK/qIcPKSKi2xgWIMieYBv0eK4DUdMOrXkDQiM1cPTxDu
   ypgxq4WTPlTCwDY+AKT/oqwoIu4ny6/cmMrUzyidc8TLSi1hMcCSnPXy8
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="441321688"
X-IronPort-AV: E=Sophos;i="6.00,204,1681196400"; 
   d="scan'208";a="441321688"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2023 09:06:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="850839881"
X-IronPort-AV: E=Sophos;i="6.00,204,1681196400"; 
   d="scan'208";a="850839881"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga001.fm.intel.com with ESMTP; 30 May 2023 09:06:02 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 30 May 2023 09:06:01 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 30 May 2023 09:06:01 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 30 May 2023 09:06:01 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.49) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 30 May 2023 09:05:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jzHJWIHHCEnhgYMgnaSNFDXG3GCIjylQoYytG31RnvljUBIq0X/aTafFZDIN0D8Wu6pyqMgFGAewEfBc/shhssDK6zohjrzXGOHfQqo1ZDuM/Fi8IXpsM5fnD31MQvKgS2AgTPqD1yatChJS7LXYPvTiH5Rc93+i0g0XK3ZYRDVNV+oEMsiKqUa7h0DfVSKILvU1xnF6YzV1HP4KcoLoL6zhn40bIsvJtxOseb5cL9obKJEhtGt9qjBIk8KEKOW6FTEIGa41pgXCYweJdn9ZH1RPCg0e6qAqj6VIYZvS2ky7ZSR8hfaWQphDcmJK8Q9p0qL7J3g38h+9ePjwllrqrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3mjDhrawPzZg+dC0EUQiQFwgaE/xXFNEMcog76O9ElI=;
 b=fvRusUxFNY1rSUUUMA3R0c0pm50mtxfuAb6iyUOBohXOC1vmFDOgkhnqaNg/BMBsGCPH0vmukLwUPB8r+aKI8C0YM7RxyIBrCjiKBdYcgt1cPRxj3p+5JAxsSuM6AeBGbo0nrrZNAXN8CRSmpLAMhovFPtFX/Vz1xAAEsjaa+ODRSsgZCi3XFYQM3PHxlQKhgMc+9A0sE6//6Yg5LD2zxVwiU70xPe8nVl2FrcKorDAyy5okBGG72tpESDqVXsWDkNZ7bPocGT1vvlvFEMxy1tt48rN6jssl2iBvJrSwFIeTlZ3EpA8z+EXlcn97svU77QYqkUXtVQhDoxQ3rReLnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO6PR11MB5603.namprd11.prod.outlook.com (2603:10b6:5:35c::12)
 by SJ1PR11MB6156.namprd11.prod.outlook.com (2603:10b6:a03:45d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Tue, 30 May
 2023 16:05:56 +0000
Received: from CO6PR11MB5603.namprd11.prod.outlook.com
 ([fe80::4287:6d31:8c78:de92]) by CO6PR11MB5603.namprd11.prod.outlook.com
 ([fe80::4287:6d31:8c78:de92%6]) with mapi id 15.20.6455.020; Tue, 30 May 2023
 16:05:55 +0000
Message-ID: <4376a7ba-2f85-6160-b7d4-d5c08b5b3429@intel.com>
Date:   Tue, 30 May 2023 18:05:48 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v2] ACPI: APEI: EINJ: EINJV2 support added
Content-Language: en-US
To:     "Luck, Tony" <tony.luck@intel.com>,
        Piyush Malgujar <pmalgujar@marvell.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "xueshuai@linux.alibaba.com" <xueshuai@linux.alibaba.com>,
        "benjamin.cheatham@amd.com" <benjamin.cheatham@amd.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "jannadurai@marvell.com" <jannadurai@marvell.com>,
        "cchavva@marvell.com" <cchavva@marvell.com>
References: <20230504133224.2669-1-pmalgujar@marvell.com>
 <SJ1PR11MB6083A266C4A869FC9AAA5A9AFC6D9@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <SJ1PR11MB608326A6AC3FFE42699DDB40FC6D9@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20230509143721.GA10616@Dell2s-9>
 <SJ1PR11MB60831FCB30F2A642B95C9D9FFC769@SJ1PR11MB6083.namprd11.prod.outlook.com>
From:   "Wilczynski, Michal" <michal.wilczynski@intel.com>
In-Reply-To: <SJ1PR11MB60831FCB30F2A642B95C9D9FFC769@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0097.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::15) To CO6PR11MB5603.namprd11.prod.outlook.com
 (2603:10b6:5:35c::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5603:EE_|SJ1PR11MB6156:EE_
X-MS-Office365-Filtering-Correlation-Id: 20f1056d-b18b-4409-3fb6-08db6127bffc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Qw0i+Wog9sz/nLNip4gEvD2hBTymXO1+g/zqLuQSDo/eXxRb8/6NYagzEwoPhfjQsojnuWPmnmkLy1zGfsntRULhm37x0R78r/88m8KnGEZ2eUK+G5ZUs2TRVuGMboUxF2VONQnt8I/eKb7GGqIhN2dQgoYA2H0kvsv0q+nti0K0FoDt7ippXP2sqnoCpvxg1lZbZ1ndHwGdMQtc35nkcMibYgKBeML/zoa8TLPQRICguU/na++kSiqfJ7wF8kG/7+tv1pwT9mJCQi1kgETltl1d4yqGAbnHCdkUYdeXePBwiGv3mjr4f2lLuKjlqZnihtVxnVj6Epdfv0Ey5qcozbBWj6Ep6tfHDYLZdGY4ED3R1WI1PHK2E7kPXa18hO2OYlNqJoqT+bFfKS7xBwEk3Un1i4DRt759Q4e/SZ1Ri316/V7Q2EW8KsI5cVRQ4dE9EQKRAtsaxBok9nqzCD7pd5W5jc/aS96lPquibN2b/Tjlpdr7Ch/R0NYNHr9rOvW2XeSfkGaatUCln7oTnE5OxiBpr8/P4CsxfEFleRVQvFprHiZ1e5kZybIKhtHrDHvw2kvvxvKzQAk39s7n8cKC4VnB70vDHxw05WNdxH3vHW9xn/Oc1IqA0U1Br6Jj2+/BKvTdp8qQbFbEvqQEjpFysg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(39860400002)(376002)(366004)(396003)(451199021)(966005)(186003)(2616005)(38100700002)(41300700001)(31686004)(6506007)(6512007)(53546011)(26005)(6666004)(6486002)(478600001)(110136005)(54906003)(66899021)(82960400001)(66946007)(66476007)(4326008)(316002)(66556008)(5660300002)(8676002)(8936002)(7416002)(2906002)(31696002)(86362001)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M1FQQ2Zoa2xvYVVPMlNOc3UyWEwybVFPR0ZqdDNkakhWUjQwbm55bjhYM0Vq?=
 =?utf-8?B?QS9TRW56Rk5Vd1RIM0Rld091QTZxUkRJc3lReVN4L1Uzc2hYaHp0MTZIMlN5?=
 =?utf-8?B?V09tVTFNN1R3anI0bnh0bG0vbGlZYTBIYThrbjlqTnNDSVo4aXRSaHN5dVdG?=
 =?utf-8?B?U2d0MlRqa2Vaa1hqazA1d2VpVUtjTUp3OXlRTjlQUzVPOWVsOGdQZldOdEtG?=
 =?utf-8?B?Q2s4eVBnQmRUWkJITzJxalhMQXFhcDJXNWRHb0d3OGdoYk5ieFh0ckhKdHhE?=
 =?utf-8?B?QmJlNG91Q3JMcDFESlBYUE8xOXZYNzhpVnlNSTdtMGZsQVQ1VWp5U1p6TGl0?=
 =?utf-8?B?OGpoZDhwNFF3SHd3d1FIMExaYnY0YWNFTnRWeHRnSS9VMFVOUmRCdkcwTlo5?=
 =?utf-8?B?MytsZVlkWFk1OGhodlRVQUoxRTcxN1VkM3JmK01vSGVKcHpocjhQRzBsNURH?=
 =?utf-8?B?cW9xRWZBL1lmYTdIS2I1c29JSy9pbmwzcUhscmFYejI2enJNdGdUOFYwZmVH?=
 =?utf-8?B?eG5PUHBvTnVLcmlkV21vSW1vbDBnWlFJSUxCSzB1YnUrQTlWK0tCK1dmS1NF?=
 =?utf-8?B?TkhPVDhvMkxqV3ExaXJLN1FubVVkNFhqOEdHY2xJUXkxQmZsODZRYWlycDlH?=
 =?utf-8?B?TDVFM1dJNnRIcHN1bjFyYU1CcXFuQU1iak42cVM3VDZabWUwUldDTnduSHFt?=
 =?utf-8?B?QzFJd1Zha2JPYkwvR1Q4ZWVTakc0S3RHQUt4ZU5rZFBJQVBsR3pZaFhCMnZm?=
 =?utf-8?B?QU1qRkVtREV6Q2ZLZWxVb2VpV005eTE3bDFhb0xQNFlRQ3R1cnNNNUorUTgy?=
 =?utf-8?B?dW8vbysvMzhWS3RXRWdmbFhmNEFZdEljdmI3L0I0SWloc0NrVzJpUWlWNk0z?=
 =?utf-8?B?N2RSdzhjRjZ2dmJzRkNkOW5IRmNYSDFrcVlMTUgyZXZLNk9Va1RFY01VVWtS?=
 =?utf-8?B?ZmtvRGJzU2dCaW5XK1Y0QjVzMzJjdjlOb3NKaS9oQkh3NEVCbGIwaWorblQz?=
 =?utf-8?B?cVRjbFZaaVI0eGxacjVkRDNDYmVhSjd6RElWL2R6cS9SdWltVE5QMitNQit5?=
 =?utf-8?B?S2ZTYzYzVFpKNjFPRjZYODdWRm15QVdvMGhhMHpPaVQ2c3orbmc5dUV2djJJ?=
 =?utf-8?B?b1grRXk3VjZLbWJUYjRhTXU0Q1hlRTdYTCttdWdlK2FSRFYzc3hGZ2NWWU1t?=
 =?utf-8?B?OTcvVVEyTDZJRVpyeGpNTkdtdExEWlNzaCtXWEVndWxCWjVCMGFJZ3lucnQ4?=
 =?utf-8?B?a3NtME1qeTRuT1FvUnhEdkduVkNNbTNpN3p2VXFSS1hzdzJ5Sm5hOXowbFkz?=
 =?utf-8?B?TGRBdGNPMFk2aytYUUJQWnc0dDVtVUpCa0RzbWVZZlJCV285TEg3ZzNvMEhk?=
 =?utf-8?B?TGp2WmhaTDFEbW1VdGE1M2gzYnNLN0M4NG5ZRGgwZlhFQ1dUYlhuZ0grS2M3?=
 =?utf-8?B?Zmp5ay9wRVlCMW13Y1R4eEoyd1h4RER2N2hHeDJ3Q1JOclhZWDBJLzBOcmJ2?=
 =?utf-8?B?a3o4MDJmVlY3ckEyS1FLcGJnU1pZdFZmdGtqZTJCZXl2NStQVlE2NHV2QlRz?=
 =?utf-8?B?S2M2ZjZzbkkzcmZoU2dibmw4QlJzc0pKb0U0OUFTRlN4WXh2OUZWU2F2QkFS?=
 =?utf-8?B?a0pWQUdBZFkva0dLUC9PRThONnllY0VpK011TW5GZVB5cHhVTHh2SzJ5R09T?=
 =?utf-8?B?MVF1ZVQ3ZEdMdlFsNWNnOTJ6TUNaY2ZFVGlnNlZkRWN3YlF3UGlvWDlQcUdu?=
 =?utf-8?B?TEFML0NjQUlUMXJIbFQ1d2hYNU9XdVpzQzFoc1F4NDB4bXpVcTRRUUhlQ0Nr?=
 =?utf-8?B?ampKOHA4cXIxbXRBdnVSYXpvWG1uTHpHT3ZrQTRmQ0NFdWsweC9aRXRUbk1q?=
 =?utf-8?B?ektSRWY2ZklXdWQ4TDlSMmhic0NUUXExQTBSeVZDSHdJREtHb25IV1RzNFhj?=
 =?utf-8?B?Ti8rdllHbUtHeDdaMlFxMDUyeExEY216VHN4c09icmUyUUdsOXZNKzVYdVQ4?=
 =?utf-8?B?WkRaWUlMVUFoZnNselpnck9MQU1tNkJhd1EzRXIwRUNEOEMwbVFGbk5RaXpE?=
 =?utf-8?B?WXJFdjA3bG5FU3JORzlLNkpjUllOSnFwR3h3UHludForOGk4MWNDd3UzWDRn?=
 =?utf-8?B?WWpIazZLNTJ4eUQ0RnpWSXNVY094eTNkRENnR25nVG0zVzk4a3poK0o2Wjh1?=
 =?utf-8?B?Mmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 20f1056d-b18b-4409-3fb6-08db6127bffc
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2023 16:05:55.8415
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2o+3qv0SnBAoqMr49wXzFbtxsiilYAoWN8rfY/JzVwHmAGIyp6IAEP1R/OP8Nnqe9I3aRjyoBfAIQaYnRwwdbw9Y7y06vmsOidQIQJU0HSE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6156
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/9/2023 8:35 PM, Luck, Tony wrote:
>> If a platform supports einj v2, then the einj directory wont be needed, as per spec,
>> if a non-zero Error Type value is set by EINJV2_SET_ERROR_TYPE, then any Error Type
>> value set by (einj case) SET_ERROR_TYPE_WITH_ADDRESS and/or SET_ERROR_TYPE will be
>> ignored. So based on einjv2 is supported or not, we can have either einjv2 or einj 
>> directory with the related params files in it respectively. 
>> Kindly let us know your thoughts.
> Piyush,
>
> There are a lot of validation tests built on top of the EINJ v1 Linux interface and interest
> in keeping them working rather than forcing a giant "change everything" when the first
> EINJ V2 system arrives.
>
> BIOS team here thinks that the EINJ V2 spec change is (or can be) incremental.
> Platform firmware can choose to continue supporting EINJ V1 while also providing
> EINJ V2 actions.
>
> So Linux should be prepared to handle:
>
> 1) Legacy systems with just the V1 interface.
>
> 2) Incremental systems that have both V1 and V2 interfaces.
>
> 3) Future looking systems that only have the V2 interface.
>
> -Tony

Hi all,

It seems to me like backwards compatibility has been a big priority historically for Linux.
I guess with debugfs we get more leeway to change things, however this interface seems
to be present for a very long time and seems to be entrenched enough to keep backwards
compatibility.


Piyush,
Did you make any progress on the solution ? I can offer some help if you don't have BW to work
on this.


Good video on the topic :)
Link: https://www.youtube.com/watch?v=Nn-SGblUhi4&ab_channel=FelipeContreras

>
>

