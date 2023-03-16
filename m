Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C59A06BD975
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 20:44:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbjCPToT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 15:44:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjCPToQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 15:44:16 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC69915CBF;
        Thu, 16 Mar 2023 12:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678995855; x=1710531855;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5QMRcK6AAfZiZwRfateuHV++eIJfkhxfUApxNRThzRA=;
  b=bGK71iLFI0lQ52RfHoMzKwZa6cDEZbnn7xoLRkVqmhCcN/+oL0ruMDmp
   lryt4Bn/a4uIlU5R6a+yIBQSSR4Fi8qp3Ev07z8/vTm4nbLuP3r3YvjtT
   jcadsFLFrnSIUiduRIBwWGP7k8v8iA6aiopB3VT8wZxmMnouRr7101EwY
   cGCFSoWv3eclwtC5KNQuMyqwBCFjfD6MBNFi/8Dg/uKc05p6G6wQll8JI
   VFlJABaGM9bFLblbAAhIqjz7tZSZszzHn4Y9SPvnOv3uEqm+iD8hDrzF9
   /9PzlBh2EkbBDHWCcWO3YytC/sE8XqOhOaTabI62SAQ8/e5oMOlM+5Zgk
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="326465766"
X-IronPort-AV: E=Sophos;i="5.98,265,1673942400"; 
   d="scan'208";a="326465766"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2023 12:44:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="1009374719"
X-IronPort-AV: E=Sophos;i="5.98,265,1673942400"; 
   d="scan'208";a="1009374719"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga005.fm.intel.com with ESMTP; 16 Mar 2023 12:44:13 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 16 Mar 2023 12:44:13 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 16 Mar 2023 12:44:13 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Thu, 16 Mar 2023 12:44:13 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Thu, 16 Mar 2023 12:44:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gcDP1lgw2nZCy7nUsKGzaxEPLkmyMIq/YsqrDUwWsKPjYzElX9dfmUoEeMgNyxIBbm9Ppo3oPIOvfyWhbenxh1EfQoDWYC7coKQwY5LCmLo015juZs8MAZJMrW3UCO2ekkZbq7phM8bzEVct2NyLH9iTtBLB8kRCWpBRSz2yKHyWRSF2W7XKyXsbGOkFowcELFBaLCugueiSAOXZVJEdULAztyvoF3YX5lLl4pe+v/DJ/5Muj0yP87TVzLbOJkD1bC0MIIB6dA9OxwPf32rffwb1rhFqy0/0WbiAhrLcWMGttyPOB1jo18NTYqMGwi2HvlZX6TTSMZ9/vSPFkvLd8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pKr/hdUckwCM8ETeP6HSwASKq5CruAnhUvUUQY1yh90=;
 b=Iw+GqzD0SPAB6/RbaxiFPkPBI1Mo2gYI8xcZ4c3uM9e85NqLtry1Sd53V0cZqX3ClfdNEoGWStM20GjVVP8gIW0Iuw5M+qOwJBJ5sVj1aEvq9JJYXMz69sa4n8I46+ss3aYUdvPUL+S8io/v4kYGNbuZkd5D5nUaxfa4ftG6duPi2UOLnH5tDZYhOS2IGroVb5EmHkP4hhxYGNKiathEpjQLMBOAjPa+mXegvjMJWChASwmAIbxQJ0p0ixfsoWpztwrgmsQNW+8lvNIoq8UKkmKpAcZ80yDCHP1qHOl5WZASEZtww5VBh0iJcylesD/KDyBC58RqBmoBBAqAcozTQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3768.namprd11.prod.outlook.com (2603:10b6:a03:fa::20)
 by MW4PR11MB6761.namprd11.prod.outlook.com (2603:10b6:303:20d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Thu, 16 Mar
 2023 19:44:10 +0000
Received: from BYAPR11MB3768.namprd11.prod.outlook.com
 ([fe80::9a08:f53b:3a33:1211]) by BYAPR11MB3768.namprd11.prod.outlook.com
 ([fe80::9a08:f53b:3a33:1211%3]) with mapi id 15.20.6178.031; Thu, 16 Mar 2023
 19:44:10 +0000
Message-ID: <bdf5705c-9b79-80fa-a31e-6317e4f2c0bf@intel.com>
Date:   Thu, 16 Mar 2023 12:44:06 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3 4/8] platform/x86/intel/ifs: Introduce Array Scan test
 to IFS
Content-Language: en-US
To:     Hans de Goede <hdegoede@redhat.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "markgross@kernel.org" <markgross@kernel.org>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "Macieira, Thiago" <thiago.macieira@intel.com>,
        "Jimenez Gonzalez, Athenas" <athenas.jimenez.gonzalez@intel.com>,
        "Mehta, Sohil" <sohil.mehta@intel.com>
References: <20230214234426.344960-1-jithu.joseph@intel.com>
 <20230301015942.462799-1-jithu.joseph@intel.com>
 <20230301015942.462799-5-jithu.joseph@intel.com>
 <7f82f241-39ee-15e0-1ae7-e98e50730c95@redhat.com>
 <275d2f04-782f-2c9d-187a-7a510bf34f41@redhat.com>
 <SJ1PR11MB60831C996C2EC462262948CDFCB99@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <363aa89e-de06-6fc4-e396-d8cc311017b9@intel.com>
 <076097bc-1e7e-72d9-efa9-79d6a94d3f0a@redhat.com>
From:   "Joseph, Jithu" <jithu.joseph@intel.com>
In-Reply-To: <076097bc-1e7e-72d9-efa9-79d6a94d3f0a@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P221CA0013.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::18) To BYAPR11MB3768.namprd11.prod.outlook.com
 (2603:10b6:a03:fa::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3768:EE_|MW4PR11MB6761:EE_
X-MS-Office365-Filtering-Correlation-Id: 558fe9cf-e706-450f-070f-08db2656cfc2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q+aSSrhGSQBYHqqmutjMD1Z+7NGJIsA8DuDFyXE/1UnSLPaZMSQfNgqT7yEBoEPvxHpdCb+wyJdUC0jkrCGqtgn/saDynswiseuGpKEdzpAYw4sPIg5W96BHwP6Y7DMSfHWbSzm28OHjLKV1RD2h9DYz9BAMCFCYFC0xB2N0ko6hbRxmA/h/uZsqkeXc9wupn5JtjuFvh1mV/QNYSrOkLXjy3aQuXtDpoKJwpD5A35jgLKrtwoJA9fhykhDcm+bZDitmy5yx+XKhFyfaa4zhZJej/PPaumLOS2f2oqJLLRQRYontX0onF9mFrTSVkpBo1730a5sLYMCmpq8bnR481S4uavGSsiLbVI2YfxRBgPWrgcAyKXen5NvEJr2XKuwIyKXEByBibrwfLEe1PpJri1OdDVJaQNkwF+VBlrfSa7tBDWE1p33c9SySAv+94vnn+wmh7+KMZh13vKUA/nU8FLET5JvBfd8SCLgEwlr9/Mtrsc+qLF7163Ycxule9XXeQ8nXMliwU2DB5DJTxuDyatcLZ59jyLTtLTvf1b/gi6FzFqhTpQ11bzIhunVEjP0ngCdlZ7Q3HGLL7IQVwLiTExpmWwVNFkv+1I/WuV73i60rIc90U7sD/XwioRTzprEqI4t41Xue1Lpx9/0x4xwSOVR3u+4zYC0s0ARuSgpvdogkEgHLTAOgoni6jamYkHfqijik5WIhvJln+NZHqTKFVY+rBnSynWxphM3RALpxJCM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3768.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(366004)(376002)(39860400002)(136003)(346002)(451199018)(38100700002)(82960400001)(2906002)(41300700001)(478600001)(31696002)(66556008)(86362001)(54906003)(110136005)(36756003)(66946007)(8676002)(316002)(5660300002)(4744005)(66476007)(6486002)(4326008)(26005)(53546011)(6512007)(6506007)(2616005)(7416002)(186003)(31686004)(6666004)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q1RoUGN3dGJrWjlxSUJkcURwQkRUYVFCeDhDV05BSk45MXdxL2hNSW1MSGNt?=
 =?utf-8?B?SU5Jbk5mSDB2NVJybHZyb3plaXMzb3E3c0hRVDdvbVorY3c0a0tYZitDdnhl?=
 =?utf-8?B?cTZvUTlpVjVwU0pxQUExeW1VWllJYjIzRWZhaFdFcmpZVWhmamxlbmd0dWR4?=
 =?utf-8?B?MHpTZVRLQjlLTmpRQUFxWThJTnlrYzdpdHFNTmVZYkxnOHVGQ1BDampmY0dl?=
 =?utf-8?B?QnRMUHhHaTVpSlJ6NmhNU0FoN0E4UmltalhWb2xWd01ZMk5aM0lUMXo4V1dC?=
 =?utf-8?B?SVdsbVhCRnNoNUl2VjBCUVBLREdGWXphb2ROZU40ZS91b0hzbXptRUVwb3RH?=
 =?utf-8?B?ZkN1bzY2OGhBUVF6ZUlzTnlXd3dpVnJybWEzYjh0dVI4cGVrQ0VTVVlrYWR5?=
 =?utf-8?B?WVRtcC9yMU10c0duU21qSlFnbmE0dGFQREduMmdDS1RxSUtqTGVBZ3RYN2d5?=
 =?utf-8?B?b3dwNkczeld0TFJjQzRXaEN0T1J3OFFpLzNoRUtMZzFNVFQzQUZPblhuQTFj?=
 =?utf-8?B?dDFzY0xpYVF5ekNXY3BFekt2L3B4NWIweDdvU0FYRWViOWw5ZTg1WFVNRTc1?=
 =?utf-8?B?RDNYT1NMM3BCVFBJQnQxT3U5OGJvb2R6Wi8vekpDNDZYLzdMK1Q3bGJZNGpG?=
 =?utf-8?B?WFBEeXFPaHAzeURJUlpVY1JtZitKTXpwR2Z6c1NmWXJWMXBDdlRGdzRrdFFH?=
 =?utf-8?B?NSs2YVIxYVl2T3NabXpJNmVmRy9YZ2xJNmZtTEFXWTFZNGxWWjFJWU9FTVMv?=
 =?utf-8?B?MDhkbWFxL0RuRVRMRCtWYUkraCtYdmFZM2p6Lzh0QVhZSmpCM0xSTWpPN3pR?=
 =?utf-8?B?VjhSS0xyRytsbGZUaHp4U0YzYVdrQWc3UDRHa1ZTd0ltL2ZmdGpLRDhZMjI3?=
 =?utf-8?B?Mk5Hc3BjUldkUW8xS1BaaUo0K2hWVHFkVkhSTWdUWFR4cTdTbDQ1bEVQMnZX?=
 =?utf-8?B?ZmNjM1VkakdwWXlvN0RoT25VQXNwMVdhaDNXV2ZQbVhXekl2R0ZOMmVudFRt?=
 =?utf-8?B?dXJCeXdiTnR5SnpyTHZhZjFOa3hDTzhHT2xRZjhwVFRieFYwa3kzUEgrMGFE?=
 =?utf-8?B?Z1Y4WTBubCsybG1zYnZQUWk1ekJoWDBzWlIyUGRHd2FTc2xlaHl0d2N5ZFNr?=
 =?utf-8?B?R0ZENnZtcWJOZmk1SDFXTER4eWxsUlNLL3I5T2pNOWdCOWlHTkVOL0ExbDdr?=
 =?utf-8?B?bXh1bWdja3prT29hRFNUa093Tnc5N0Jaenc5dVBRYjRjZzVLQlJ2eGd4a3Fr?=
 =?utf-8?B?VDNnZG5reVBUdmVoMlNTOFkyWTlwTFMxOXpmaEtVOHdGZ0N4MVBMN2MwbE9s?=
 =?utf-8?B?MG1UVjdTZGsrcCtsK2FxcGJ2ei9BdGJTbVh2Zy9vbGY3QzhQNFB5WjBIenFi?=
 =?utf-8?B?R29tYXBkYkEvQURlQ0dZYlFXSzQ1WVFaN2Z5dk5YdVF3dDdlSzV5aDh6bjBN?=
 =?utf-8?B?K3FxVy94SVNDT1hDcHV0VUR4S3NaUHJScVIwQzVQUTB1dmFtU1paQXZ4dUVp?=
 =?utf-8?B?b1VqNys0MW9HV3FkdnZwdTkrT1cvK3lvTFF3cStCdUhEb1VwL01JY3JIMXVp?=
 =?utf-8?B?RzF1RU1NeXo0TjJpOUQ1SmtJS2xzcjBCNlZRZ1JRQWJjYzF0OCtSRXlDRUdh?=
 =?utf-8?B?OURmeC9Mby9sUENaZWx4OVlqbDFJV3plL2xnemF2UmVQU0xwM0tKd3lyZE9Y?=
 =?utf-8?B?Qzl6S2NEZW9KVVdseE5pV3JNQk5tZ0dIN2JJTzJGRCtYNUVod0d5RUt6b1Ro?=
 =?utf-8?B?cGxpNXlUS3FKZTNLVnBNUUwzRURPYWdpbmJqWjEzck1UZm9rL3cxTEcrUFNs?=
 =?utf-8?B?aXZLUkNIcXZFVzBiM3ppY09OcXRURFhFRHlvSG04ZlZIbTY4VVlWdy85dlVk?=
 =?utf-8?B?RDB2MHJMODV1Qzh5TGpTUVFhRUlPMVBiYnhTUEQ0Uko2SzJWOTlJY0xqN3RD?=
 =?utf-8?B?R1htWGRaSE13WEdVQ3BaM0R6Qm9PNDNxcitteStIZ1FGc05RL3JKOEZ0L3cr?=
 =?utf-8?B?V3dNMDJidDVTMjArRDlYNDBxSnc2N0h1U2FHaUVXbW5sRDhNSlQzM2VVS2xw?=
 =?utf-8?B?U3ZXb2NYcE9CdXFkMzgydmdTc2JZVXJLNjNncU9lTkJPUzl3N1dZMHhtZ3FD?=
 =?utf-8?B?VGFUOWppeXd5UUhtN2FVUzRYSm8vQ2ViVUJITENmazZyMC82RWc0SGRtM0FM?=
 =?utf-8?B?ZFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 558fe9cf-e706-450f-070f-08db2656cfc2
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3768.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2023 19:44:10.1605
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BHoB0BojlDDqluwC8jq8Fiap432GtS2xbuqo2P49U/VtgDQlchKEBylP89laMWu4XYty3Ypx/DUYgrbOeebLDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6761
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/16/2023 2:50 AM, Hans de Goede wrote:

> Ok I see, lets go with 1 intel_ifs device per test-type then.
> 
> If I understood things correctly esp. also with the /lib/firmware path then the <N> in intel_ifs_<N> basically specifies the test-type, correct ?
> 

Correct

> If I have that correct please add this to the ABI documentation in the form of a list with
> 
> intel_ifs_<N> <-> test-type
> 
> mappings. And also add documentation to each attribute for which test-types the attribute is valid (this can be "all" for e.g. status, to avoid churn when adding more test types).

Will do. Thanks for the review comments

Jithu
