Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C276B6B4E7C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 18:31:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbjCJRbH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 12:31:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbjCJRbE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 12:31:04 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D9C4122CDC
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 09:31:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678469462; x=1710005462;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=zCyStWRWNR/Gi18xEPl4U9oVDOokSxjQqUp6UV61/fE=;
  b=JHeRAtg21nV4WdT7c1BWpqYbFPMDvQEOw8jYNEZySyyfr9xvBXquPOH9
   YD1Odp6GmYr3dNGNrvRo25TGvSJCLQEcfTs7YjFd2roh81eXzMkOj/gJV
   4zc0hYwFmqeZRm2pKqt3LJ4SkWhSAxB7PBvrKXH8nRweJhI8+w2QT1hlV
   ORm26Uh3WJNluI9hzI9sUnC1UBfidOaDW2n35mQgQqQlwXlOzLC1mdzc9
   tGG/0xfvJMtKkdupRMwR+16sL6SWj3z/FHtdULax1YqBXoJOhxwizMKTd
   SO9JCSHphSfNKTDNs3Xwui9ctrM1Nv4Cx1sYIio+l4+Mzl6qWETG4Rh3O
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10645"; a="325137100"
X-IronPort-AV: E=Sophos;i="5.98,250,1673942400"; 
   d="scan'208";a="325137100"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2023 09:31:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10645"; a="788092361"
X-IronPort-AV: E=Sophos;i="5.98,250,1673942400"; 
   d="scan'208";a="788092361"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga002.fm.intel.com with ESMTP; 10 Mar 2023 09:31:00 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 10 Mar 2023 09:31:00 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 10 Mar 2023 09:30:59 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Fri, 10 Mar 2023 09:30:59 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.103)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Fri, 10 Mar 2023 09:30:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VPH+oTU3il151Y+FmIuAva14pYdYl5NyaWhrJtkFVjz3DqlB7z9jxeE3oL2S6vHvhqfZuOP70i3bgTNtm2CXrzo9jWL2sW9q8LCDPt/w5VMfbuk4h+lhnFk3y4Bbnct78qWPO5KX5C4cXaeyvEcu3cMzy0/gD9pG79j+nzYSsLZOuLBlaf+uy5Xv/DqgvDA3kIyJu8pqrZlCdfUY3zWbDRyoNbTSrLeQ/fg/2xEH3Z+6MBvnyfd59IW7jQm+4eL1Q94zFnIo6upct4gdtS5iIDZD/nicX4DlPVJHzO4ZRrM44UIpBF4NT7vrDVvJ/PFtwQCANZz9E0UdtZW6y+lv6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nwgrD7prmLwL5rDmmJloRg2CTkN3FcsWb4edMR3l6pQ=;
 b=itxjI4aZmgYMUsGqbyZx5LkaywHipQIZPvpZ2awpl+65Gk6KAA9vFV0uCW43CoHVP8BJcKRiHNlRFWEfNwRUaxbMPRGT4ASHIKpiZfdwrnx8jEgim4Ez4FNXuK3uK6AWkWKrAHj040CrTPluPIlqKKsuhkphlsahptC0Z7UIpSo2bXic45fQ5tK206GPvCei55cbXkKarepmedOUEfxsg0DCIdvmaTBfbAge+XqF9GCE+P588IFv2/nQ4LEg07/w4r6vrQI7ZWvapgWHOSrayN2PMXeoLIxk1+A2DjSzZ2BXW6+/ClQe7ndEG7SKbaEQhUoHRRTt96Zp3m3iriEjpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM5PR11MB1899.namprd11.prod.outlook.com (2603:10b6:3:10b::14)
 by CY5PR11MB6308.namprd11.prod.outlook.com (2603:10b6:930:20::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Fri, 10 Mar
 2023 17:30:57 +0000
Received: from DM5PR11MB1899.namprd11.prod.outlook.com
 ([fe80::dcb3:5ba7:4576:d776]) by DM5PR11MB1899.namprd11.prod.outlook.com
 ([fe80::dcb3:5ba7:4576:d776%6]) with mapi id 15.20.6156.028; Fri, 10 Mar 2023
 17:30:55 +0000
Message-ID: <a6f3d850-7cd6-2834-48e6-8ecaa445122a@intel.com>
Date:   Fri, 10 Mar 2023 09:30:50 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: [PATCH v4] firmware_loader: Add debug message with checksum for
 FW file
Content-Language: en-US
To:     =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>
CC:     Cezary Rojewski <cezary.rojewski@intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
References: <20230310140459.2972793-1-amadeuszx.slawinski@linux.intel.com>
From:   Russ Weight <russell.h.weight@intel.com>
In-Reply-To: <20230310140459.2972793-1-amadeuszx.slawinski@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR11CA0085.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::26) To DM5PR11MB1899.namprd11.prod.outlook.com
 (2603:10b6:3:10b::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR11MB1899:EE_|CY5PR11MB6308:EE_
X-MS-Office365-Filtering-Correlation-Id: d2c63c5d-34c7-442d-3e55-08db218d3417
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZEDffmboCw1UDYN+2Cgk7nwUtR7boozz6uPnXrUrBE21OVQRuchNwolydkEv60KdzqAlIQ5B24J6MaxH3tzHUtFjhX8QfcsNm3ScHLS+sNnDYPLz/7DHU3OluEs2/b7TIMOSnewM7OjmzC4nLJfktt1PCub9c9/FpEuFsEMjNZlp6zsIuN7ElBS23FES96XEPPImp4c7vpFx8xQ3TNc2Naljx6S8Tcer/NcaO5l/rKyN9shZmzSavnvWiNzVRkFBPveJ0M4tVf/nUdBj7JjW/aL0YhqVm6Y1RxsIc24cWRT8dv9KCB4GgP8DY8Hsy4uyNTNrpg1L5CQ8Ijfuicm1rR5tcXbnfsauG5gWZv9w8GXoYPim6nVYGdjHPJUc5arxUTn5PX5SE4fCypK6mwSIdmx7x7rCnOIWq6G4AYDvKxLrjhDvo+4oFm1lMDLf2AFWyzIrKaz0yWsSjABK0FUtPS9uichOycFCXgPjIJSi1E+RUa2oAlSv2ibozWuP5S+bjwlSxBxEKUrW44t+H2m7nM3OO5xhBeOAkzzAiqTcR47BYKLcK9oRqBnktAvaURLheJqMVCmZEyk59qIDYHMdOWCtmQm+WmimtAKQnRpagWW20OadU3xPkH8pEOg21C2QlLDVSSQJAf8LQL+56MXgDUcNf4UTYvlARSOrX6vXfYmZIwZJxmS8AdpMkZhPwY9EJN/DKH3I/QkaYoYbPW1uP/vFgLrl/QAtTGclhqfBaPz49iEsn6MOlzjQEJB1CGCRrVJv+AfdK81OAlE/ZeNAXg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR11MB1899.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(39860400002)(366004)(136003)(376002)(396003)(451199018)(31686004)(31696002)(66946007)(6666004)(36756003)(66476007)(66556008)(4326008)(41300700001)(6486002)(15650500001)(8936002)(478600001)(82960400001)(38100700002)(5660300002)(8676002)(86362001)(54906003)(66574015)(316002)(6506007)(6512007)(110136005)(186003)(2906002)(83380400001)(53546011)(26005)(2616005)(226483002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R1orZDVPZXF1RzU0MTR3TlFmdHdNQnpCcFJNN25TSU1TZGppWTdxQjQxRXBv?=
 =?utf-8?B?QjBGNy9nU0VYYnBQRkpNVk1HQWRBVk9oVmNFVlNMQ0U4NUNKdVM2ZG9aR0sv?=
 =?utf-8?B?OUF3Sm8yamoweUJ1alREeTNsQW82aTJVVXpyMXdyRmt1UTJCZWJQSWpYZElk?=
 =?utf-8?B?THM3UlVWajNFN1NqREdaVVozMHdpbkUycjlGeTJCdU4rK3VkdGpENE4yMXR1?=
 =?utf-8?B?V3VQWXRzbHExSndobFhIb3IvR2lGMVRGOGxUT0c5ZTNJMFhRbjg1bmlxL3Zr?=
 =?utf-8?B?QS81a0dpSlhwYTkwUmJhWE9sZWlxVzRrSkpNSkd2QzcvNWhmdGhQcGJiNWRT?=
 =?utf-8?B?Njc3SE50TjZES2UwSEl6WXJCc1pIT1JYU3BTMVFWckdMbkhVeHJVNmZFdHE4?=
 =?utf-8?B?b3VVNGZGSGkyclpvbTgrNllyMEdrVURXVU9keklpUEZuSW56M0p6RUtRNHdk?=
 =?utf-8?B?Wm1waFI2cUxMVWU2UjJxZjFYQXh5VlFVdDlPRHZpRUM2K21XZXFydk8rZGI1?=
 =?utf-8?B?RjEvQ1ZwaUlyV3lNTmNpN2dPSE94bTI4V1FobTBocC81a3NXTkJCYlppN0xq?=
 =?utf-8?B?bE5VSld5NGNSNE1seFVYNzFQZXNNUkdIWVpjeEZBSVhjSUxvSXo4aHZ2QjZn?=
 =?utf-8?B?TWhyRW14ZVFTd0VlN0RDcFUyU21pYlBpWjl2aE9rd3MrNnR3Skd3N0R4S1Jv?=
 =?utf-8?B?MDRjL3dNYWFqRDZvOGVaVi9YVVp6dW9JdEZ2YmFhUFY4ZTE3Y0lsZkUyTW5n?=
 =?utf-8?B?dGlobnF3VlVUZHNFWE04c1FqMS9ub0NUS2ZvMFVnY20xRU9ib01DSlhqQU1r?=
 =?utf-8?B?WHM1OUNWNDZsY2crOE82OW9kRnYrbUcweHhLWm5tWmRDay8vcE5seUhYL1l4?=
 =?utf-8?B?dXZSbWhOWThjL2EzRU9NbjZCWHR4eUQvNGUzbzhWVlZ3eGR6S1cvREZ3T1F1?=
 =?utf-8?B?SFpmUU53cXJ0bk5hOHFPYXlIb0g4a3k2emt2UzRzMldVUnNkY1dFeER4bEJO?=
 =?utf-8?B?TFJFeXFvOUpBVExHRjBhRVFqci96eTdmSUNZdGRoSjAwYmZ5TmpRYVJrYldE?=
 =?utf-8?B?WVRITUVyeWJCV0k3WUVxQjZqSkpROTlTaDN0c0phWEpBdlNIdVdRK2dneGxF?=
 =?utf-8?B?NXQwOHJpT0VsLzBIb3NRKzkvTVJpUjV6dXUyM0F3MEtOMWh2OTNIaHFqOVh3?=
 =?utf-8?B?OHFzQ3F1NHluN1podWoxdkpHOGVIV1FRSkFJWWswVkdJVkh4akRNNzVFTFYr?=
 =?utf-8?B?Rnh0aEYxbWdMODdJYzJISThJK1ZNSkRxd0l5Rko5V0VFL01oV2p4L0t0UTFm?=
 =?utf-8?B?VUE4WEcxbG1UZlMrQnBwQ3EwampPTUxHMUNEeW9uWGF2ZUF1bytDaDg0NXhV?=
 =?utf-8?B?VXc2amNKTjE5a3ZmdW5yNEZvSSt6bnA3Q1EzejUybVUvZFErZURISXBDRWx0?=
 =?utf-8?B?cC96OHFHeEIvK3dnNXg2V21lV056c0RDUEp0U2ZjM2NLRHZ4ZWx4RzdSRjdw?=
 =?utf-8?B?QkxHc0hwZ241a1JvMUNFRlpDd2xYZk9EaFovVVpNcFpRU3ExYzhUUU9oMmxP?=
 =?utf-8?B?VzByS2FqU2hMdFVHVVBlMXdjdDlLUW1QNVZ6RGNaNmdseldrK2UzcHhneHVm?=
 =?utf-8?B?ZDJTNFgrd2VKZmZJQ2FVamRaM1JvWHVCT0hQbXZ3TU90VHVUTHR1QklSWWJv?=
 =?utf-8?B?OHoraTJvU2R6WlVjT0FZdjBVMnZTWVp1MHdXTE5QaXJQRFFvc0hTSEhuVjRh?=
 =?utf-8?B?eExHMVh4alJGSVU0NTByNEkrdTNiVjk5c214ajNocXkrcVlrNUlIRTArUXBE?=
 =?utf-8?B?NDVYTU9ndlFtUUpvY2dEQThVS05CUGJXL3NzOXFQWGp2V1RqazZENFdUa3pk?=
 =?utf-8?B?dENKSWZFRGNoTkpiYWEyWE5obkdBK1BYVUxFUndxY012SjhRUDduYXZtV2Y3?=
 =?utf-8?B?QnpXL2x4OEUxSXUzMGJZbVpscXE5OFpIeGxRb0hBVlJsTHFQWnJicGdRM01i?=
 =?utf-8?B?OW9IbGZ0cE5GREloV09NV1BnMXpEdGUwMEtHcTN1OFJJa0pYeTdHTFRnWkY3?=
 =?utf-8?B?dTVZMmFQMzQxYmpDRDczV2Nwc1V6aFh5TmVZTmhiQ05rQUZUOUMwLzBXa29n?=
 =?utf-8?B?c3dZQktPUm15TUltZ3MxL1pxQkZtN2txSHBEZWd5WG1yV2VYNldXNXhzbEFO?=
 =?utf-8?B?bkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d2c63c5d-34c7-442d-3e55-08db218d3417
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1899.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2023 17:30:55.2940
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gk2s9kDKfp2g6pfH4RFsWlI6wj24cI36kQ9PQC8vXo/uxWocMJBcj0oNG7KRmZ+wMHQQO4rm3OvsBASw1Aygbd8nv0LmUqx4VrKEzlJsKCY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6308
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/10/23 06:04, Amadeusz Sławiński wrote:
> Enable dynamic-debug logging of firmware filenames and SHA256 checksums
> to clearly identify the firmware files that are loaded by the system.
>
> Example output:
> [   34.944619] firmware_class:_request_firmware: i915 0000:00:02.0: Loaded FW: i915/kbl_dmc_ver1_04.bin, sha256: 2cde41c3e5ad181423bcc3e98ff9c49f743c88f18646af4d0b3c3a9664b831a1
> [   48.155884] firmware_class:_request_firmware: snd_soc_avs 0000:00:1f.3: Loaded FW: intel/avs/cnl/dsp_basefw.bin, sha256: 43f6ac1b066e9bd0423d914960fbbdccb391af27d2b1da1085eee3ea8df0f357
> [   49.579540] firmware_class:_request_firmware: snd_soc_avs 0000:00:1f.3: Loaded FW: intel/avs/rt274-tplg.bin, sha256: 4b3580da96dc3d2c443ba20c6728d8b665fceb3ed57223c3a57582bbad8e2413
> [   49.798196] firmware_class:_request_firmware: snd_soc_avs 0000:00:1f.3: Loaded FW: intel/avs/hda-8086280c-tplg.bin, sha256: 5653172579b2be1b51fd69f5cf46e2bac8d63f2a1327924311c13b2f1fe6e601
> [   49.859627] firmware_class:_request_firmware: snd_soc_avs 0000:00:1f.3: Loaded FW: intel/avs/dmic-tplg.bin, sha256: 00fb7fbdb74683333400d7e46925dae60db448b88638efcca0b30215db9df63f
>
> Reviewed-by: Cezary Rojewski <cezary.rojewski@intel.com>

Reviewed-by: Russ Weight <russell.h.weight@intel.com>
> Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
> ---
>
> Changes in v4:
>  * update menuconfig prompt and help message (Russ)
>
> Changes in v3:
>  * add DYNAMIC_DEBUG and FW_LOADER as dependencies before option can be
> enabled (kernel test robot)
>
> Changes in v2:
>  * allocate buffers (Greg)
>  * introduce CONFIG_ option to allow for CONFIG_CRYPTO and CONFIG_CRYPTO_SHA256
> dependencies without introducing circular dependency (Greg)
>  * add new line between includes and function name (Cezary)
>
> ---
>  drivers/base/firmware_loader/Kconfig | 13 ++++++++
>  drivers/base/firmware_loader/main.c  | 48 +++++++++++++++++++++++++++-
>  2 files changed, 60 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/base/firmware_loader/Kconfig b/drivers/base/firmware_loader/Kconfig
> index 5166b323a0f8..6520e8c9cb38 100644
> --- a/drivers/base/firmware_loader/Kconfig
> +++ b/drivers/base/firmware_loader/Kconfig
> @@ -3,6 +3,7 @@ menu "Firmware loader"
>  
>  config FW_LOADER
>  	tristate "Firmware loading facility" if EXPERT
> +	select FW_LOADER_DEBUG if DYNAMIC_DEBUG
>  	default y
>  	help
>  	  This enables the firmware loading facility in the kernel. The kernel
> @@ -24,6 +25,18 @@ config FW_LOADER
>  	  You also want to be sure to enable this built-in if you are going to
>  	  enable built-in firmware (CONFIG_EXTRA_FIRMWARE).
>  
> +config FW_LOADER_DEBUG
> +	bool "Log filenames and checksums for loaded firmware"
> +	depends on DYNAMIC_DEBUG
> +	depends on FW_LOADER
> +	depends on CRYPTO
> +	depends on CRYPTO_SHA256
> +	default FW_LOADER
> +	help
> +	  Select this option to use dynamic debug to log firmware filenames and
> +	  SHA256 checksums to the kernel log for each firmware file that is
> +	  loaded.
> +
>  if FW_LOADER
>  
>  config FW_LOADER_PAGED_BUF
> diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware_loader/main.c
> index 017c4cdb219e..b2c292ca95e8 100644
> --- a/drivers/base/firmware_loader/main.c
> +++ b/drivers/base/firmware_loader/main.c
> @@ -791,6 +791,50 @@ static void fw_abort_batch_reqs(struct firmware *fw)
>  	mutex_unlock(&fw_lock);
>  }
>  
> +#if defined(CONFIG_FW_LOADER_DEBUG)
> +#include <crypto/hash.h>
> +#include <crypto/sha2.h>
> +
> +static void fw_log_firmware_info(const struct firmware *fw, const char *name, struct device *device)
> +{
> +	struct shash_desc *shash;
> +	struct crypto_shash *alg;
> +	u8 *sha256buf;
> +	char *outbuf;
> +
> +	alg = crypto_alloc_shash("sha256", 0, 0);
> +	if (!alg)
> +		return;
> +
> +	sha256buf = kmalloc(SHA256_DIGEST_SIZE, GFP_KERNEL);
> +	outbuf = kmalloc(SHA256_BLOCK_SIZE + 1, GFP_KERNEL);
> +	shash = kmalloc(sizeof(*shash) + crypto_shash_descsize(alg), GFP_KERNEL);
> +	if (!sha256buf || !outbuf || !shash)
> +		goto out_free;
> +
> +	shash->tfm = alg;
> +
> +	if (crypto_shash_digest(shash, fw->data, fw->size, sha256buf) < 0)
> +		goto out_shash;
> +
> +	for (int i = 0; i < SHA256_DIGEST_SIZE; i++)
> +		sprintf(&outbuf[i * 2], "%02x", sha256buf[i]);
> +	outbuf[SHA256_BLOCK_SIZE] = 0;
> +	dev_dbg(device, "Loaded FW: %s, sha256: %s\n", name, outbuf);
> +
> +out_shash:
> +	crypto_free_shash(alg);
> +out_free:
> +	kfree(shash);
> +	kfree(outbuf);
> +	kfree(sha256buf);
> +}
> +#else
> +static void fw_log_firmware_info(const struct firmware *fw, const char *name,
> +				 struct device *device)
> +{}
> +#endif
> +
>  /* called from request_firmware() and request_firmware_work_func() */
>  static int
>  _request_firmware(const struct firmware **firmware_p, const char *name,
> @@ -861,11 +905,13 @@ _request_firmware(const struct firmware **firmware_p, const char *name,
>  	revert_creds(old_cred);
>  	put_cred(kern_cred);
>  
> - out:
> +out:
>  	if (ret < 0) {
>  		fw_abort_batch_reqs(fw);
>  		release_firmware(fw);
>  		fw = NULL;
> +	} else {
> +		fw_log_firmware_info(fw, name, device);
>  	}
>  
>  	*firmware_p = fw;

