Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD8DE667EE3
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 20:19:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234570AbjALTTT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 14:19:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240354AbjALTSc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 14:18:32 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2050.outbound.protection.outlook.com [40.107.93.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 621103DBEF;
        Thu, 12 Jan 2023 11:07:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FmdkFN33SAI7CBY7q7sPXuzgcrF9Zav/j6DJNtNCxwA6F67qXUluNfOGW0UC7Sy4ODWtJEjehlFFJVGP99tB+BTDluGBgqE6zrO/uXfW9F210KJZIWmR6IMRI0b6v27Vl9quonMsVBvGdonqltbc3FoTWczQfNxNJKOL6FM5eq5e4Zff7D5Mtp8MTzJ0rojVnSMG1BemKmbcRW/UdE+DvGT+eowAzhEmj31Bpjw6hpkWEXmHbGjWIFXI1Y/wP5G1padTlSfOYcSMlX19NiUOPjjlnk8gLRhALx7wvMBrn1zqeGJIevSG0qEfF+yCFOGdrDaSMbqPCI1XS6LPJw4Oag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9az279QizIX2OrYQpUdAKMRZ5RcicnjloB5U2AfkBeE=;
 b=M8CRVwOfQ6DjaHh1EMpTQocsSgSe0PQPwf1JsbV9koIOr8/zXCjSPoCFYxmaH8QN+iXIJcYHXxIyPKUk2r9g/YysA7RyrBFKRzvUfEE61+tXbx8nohmMqpj8VMeZzf5c0rHzQP3wjBWVLxWnvVpxNTXYeCZnazxmN94FeBXlySa59SqGL39sNrBNbVdIR+x3b1k09WjXGZBmq+cNqQFBPWUZz2ei8ykYsZ2eMeY+LzL4RGp69MlnXqUsxfXfAeGO1DyI48GiiyR+6m1kA2zAEuG0ygD+afejbF0x4muPS+ayKaLchwQmNMhn+TlYkhBOXbACoWicgvNtXwDVH9l9mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9az279QizIX2OrYQpUdAKMRZ5RcicnjloB5U2AfkBeE=;
 b=ktct18LMjgKe+Q1TnpD9iS+fcrtvOPDDtokBuUcds8WZZ+rqJOWLUIhb/dMCUtCG9ZBLKBRjKxh7ICY1J86jqxmjKQeSvrWb7UkfYnQMblRRsR/781TMXjglHu9qb0XzhnZirkXLrnNLYshqKbF5z1Sv6NVGuJ/pWA5W88saQuU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by BN9PR12MB5113.namprd12.prod.outlook.com (2603:10b6:408:136::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.19; Thu, 12 Jan
 2023 19:07:00 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::790c:da77:2d05:6098]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::790c:da77:2d05:6098%7]) with mapi id 15.20.5986.018; Thu, 12 Jan 2023
 19:07:00 +0000
Message-ID: <d62e3b08-c3c9-1ebe-42be-4307d3b3e29e@amd.com>
Date:   Thu, 12 Jan 2023 13:06:52 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v11 13/13] Documentation/x86: Update resctrl.rst for new
 features
Content-Language: en-US
To:     Reinette Chatre <reinette.chatre@intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>
Cc:     "fenghua.yu@intel.com" <fenghua.yu@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "paulmck@kernel.org" <paulmck@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "quic_neeraju@quicinc.com" <quic_neeraju@quicinc.com>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "damien.lemoal@opensource.wdc.com" <damien.lemoal@opensource.wdc.com>,
        "songmuchun@bytedance.com" <songmuchun@bytedance.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "jpoimboe@kernel.org" <jpoimboe@kernel.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "chang.seok.bae@intel.com" <chang.seok.bae@intel.com>,
        "pawan.kumar.gupta@linux.intel.com" 
        <pawan.kumar.gupta@linux.intel.com>,
        "jmattson@google.com" <jmattson@google.com>,
        "daniel.sneddon@linux.intel.com" <daniel.sneddon@linux.intel.com>,
        "Das1, Sandipan" <Sandipan.Das@amd.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bagasdotme@gmail.com" <bagasdotme@gmail.com>,
        "eranian@google.com" <eranian@google.com>,
        "christophe.leroy@csgroup.eu" <christophe.leroy@csgroup.eu>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "quic_jiles@quicinc.com" <quic_jiles@quicinc.com>,
        "peternewman@google.com" <peternewman@google.com>
References: <20230109164405.569714-1-babu.moger@amd.com>
 <20230109164405.569714-14-babu.moger@amd.com>
 <c7d563ce-13d9-ca6b-a5c9-7e08a3cdc3a9@intel.com>
 <MW3PR12MB45538E045D655C1D6B3BD02C95FC9@MW3PR12MB4553.namprd12.prod.outlook.com>
 <812a0d4d-dfb9-d351-9c9d-01d6943cd72b@intel.com>
 <MW3PR12MB45534504C044EBAEABA9E9E295FD9@MW3PR12MB4553.namprd12.prod.outlook.com>
 <65927b26-9f0e-7a82-a150-6459b5477a92@intel.com>
From:   "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <65927b26-9f0e-7a82-a150-6459b5477a92@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAP220CA0030.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:32c::35) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|BN9PR12MB5113:EE_
X-MS-Office365-Filtering-Correlation-Id: e1795ac8-7402-41bb-b610-08daf4d02e6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qjReDivAgc14e23PA9YAg+IPzcqkykuVB/vVSQ9vHHWSQ71hip+X6ZwR9k9Ei/PzXFMgIBByWdhz3klzqg4unV9qO+9SCoZwHjcVaneCqGgK1uoCgnrkKdd1TNls5xWSiFiLPNfudDdeAqsYTy78UeAH/zpMiX4KBejb/5jz8h/t0QwC2WviA6r8hhiIbgoL0mtcCCqXp/xPWqJJlo9IJgiGjpdJOhOG5d8E8+WxCuHLLvJYwY5GfUXidVuunjWZySxSmPx+WDSEue0uD4apDz9q/E9KywqRWF3siuWURWa37zOv0KHEQgRhCws/xr71A521zobkA//hZfcQzexjL2GBfTGnB/SbxNPH4XZjmJe21RcwY7X1mKbHSrdn/sxqf7hXo+DoPUchuPIK4ptyv5xD9R5e36hzpXnxX53VjUvJSeRuBHiFLvTbOtkJ6TgXYNP35GPnXYxdS8rHlaviHudR8inmB8qOfSXCIQIE3hNRFveNAf6cbRzGiLvrk3FkNG1Yj7209NJqMY+JsRPWtQxj5+AjhUdtEl+y5VhsRBN3a1UCoXtUruFJkIsebodxGfdFtvnsRQdZB7d5lA7IL6gjDQJybqkVuWvqcvqF4vgEBJLa4jWXIbRrnBlqLdrAeH3d3i8AKzMv8kKtdVv2BQBlksl2ldxQn9WsjCtDpveTAWigFYOqwABQQ66dvOvZWKT9v2fj0L7rlkRpuUBjT0wvnySmUzSJQg9xiKPLBO4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(136003)(39860400002)(346002)(376002)(451199015)(2906002)(31686004)(3450700001)(53546011)(26005)(186003)(31696002)(41300700001)(36756003)(5660300002)(7406005)(7416002)(6512007)(8936002)(66946007)(66556008)(66476007)(8676002)(86362001)(4326008)(38100700002)(6666004)(2616005)(6506007)(478600001)(6486002)(316002)(110136005)(54906003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K25KYVlOdEhWZk9SaDk1blROUEJvN2ZabUVld2ZPQm9vbjl6Y0JsRlFna2Z4?=
 =?utf-8?B?TFM5RE1nRjVWWExranpjZnltdm4vOEVMcStZbFU2NG9vWW5aZFFjMkU1cm1S?=
 =?utf-8?B?Zldic3p6aGIwV3c3U3dEQ2NOR0RodjlDVzdjR0dUTTlaK29qazhxdEJaZEd0?=
 =?utf-8?B?alFoRkpDVDU1ekFLdE5ZRklTY243dEtjdWhGbnZHN043QnlTa1U3cVVDNkl2?=
 =?utf-8?B?RzhVbmd4T1Vqb2xoaFJySEtWK2tCdmtNYkpxSmZDT28yVTZsZHBnVjBpdEU3?=
 =?utf-8?B?ZFR2dUo5SUpWaTJSdWNCZEFmQ1UzSnVYNUZqeXpuUXFtZnduRFlzWGhoYi80?=
 =?utf-8?B?RXZoeEJjZHNub0FsTTgvMWh2SjVSeGhIaWdZbFBSWHc4MFE0QzNROHBUSHdq?=
 =?utf-8?B?L21Ob09MVjBSZ0o2Wi8wWXpEUTMvQzVkMnY3d2FIbVpnbXp4b3dYZUlUWEt6?=
 =?utf-8?B?Q0pocHhhYkJuanA2U3kxT0wvek1NbllxbEI2SW1pSC96QTBrTU1LYmhFZXZZ?=
 =?utf-8?B?eXluT1RNclAyODFRaW81RVVTOWtJZEZsSkVLSFBoL3drQUhWQVpvMlhnQmFM?=
 =?utf-8?B?YzB4Wks4a3JHWFFoNUJDYjd2K1ZlbUNRclhIUFlIVExvM1FiOFJWT3pVWHF2?=
 =?utf-8?B?b1crMitDYTFwN1Uvc3lsb25BVnJLY0pyTUNGbm9sT2REa0RzRFBoWDJXZncv?=
 =?utf-8?B?VDNYUGZNY092dG8wNUZEYWZ3MW1ITUx1Nmc2VkFaN0oxRFhtcFh2dFQ2cFFa?=
 =?utf-8?B?ek1nWU1aMUc2UldkbVFUeWpwSk9obnBVQmJ0dWlVSUZhV3NLbHBwMVB3bStT?=
 =?utf-8?B?UTh6WjQxcnJmSGVUc0grUThJYU90d1RkeSt0bXc4ZmwrYzdGRHYyR0N1WERo?=
 =?utf-8?B?YW5xUUFzUFlYVVJCNXZHR2ZFVkpIK1dsSlhsd1FnSlljYVhXb3ZDVmd1STMy?=
 =?utf-8?B?c0NKS2oxUGJaOWc0bmI4Q1RrUExGcDNHSjljNFhBSVZjOVE1Ymx4MFIxeURq?=
 =?utf-8?B?MHA3by9sRmNxNDhFaEFUMVRYNU1taCt5NjhrdHQ2VFcwRWY1MjZsdGpWNzkr?=
 =?utf-8?B?KzhrUXV5YWk0RU9DUmxnUk1DbGtrSXZCTitPM05GVUJic2cxaUJaVld1SS9l?=
 =?utf-8?B?L3lWeEhMdUk5anAzK294a0ExOGF3Ylp1eTk0dHo4QUlTR2xzSk9iOFhsd2lN?=
 =?utf-8?B?N0h5cGpUNlV3RWZtYmdvQXg1a3FxQm5zYkkyUnFXeU9ITXdoYW02TndveVFU?=
 =?utf-8?B?YVhzWGZGSHRMSTRSOWlvZGFSOEJzZ1FHVzk1RlNjdzNMbHRoYW1sa3dTU2VH?=
 =?utf-8?B?ajMrdjQxS09NRGRVZmpLVGl3K3MyVEw2K01vNWpFVVh3VnpqWFFhYXZTQmJ2?=
 =?utf-8?B?bXAyWml3UmlLWGU0NndYOVhyOTEwZlE4OFVGUEpKMXhQV01KZE9FVjdBR1Q5?=
 =?utf-8?B?UTQyb1ZYMXJTMXFWZmN5T1RRNTVUVGkzVDhTZVJYb3h5VERqQ05jTEI1aDQ0?=
 =?utf-8?B?bU13ZlRBRmhZQXpodlFzbzR0TU9Obm9KeERsN0QyRHVHZUtwa0lVT1FQQzQx?=
 =?utf-8?B?SmZFMFJlUjhVdEtUN2tYNkdBd3E5dnpuMEE3NUg0OWt1bTk3MDFTaEFkZ0xX?=
 =?utf-8?B?SEhTVVRqUWtPQTNGeFg4Rk1zc1hFMkxkQ1FuUmFoN1A3cFJTRnZFb0NzTTVq?=
 =?utf-8?B?UXZqYjYwVnVRRzhuM3dOQnZPb0VyWmowTXREcXhNRXdYQzBZQkRYbGtLRmdi?=
 =?utf-8?B?RnM4UEV6S3kyUDkrcjdtY2liUzFDd2xFemxVMEZsNG1ZcGZKTlplQlJPOVV4?=
 =?utf-8?B?QTVFN2c2L3ZKd3N6RnVUTDRBU2xOeGVIenVURmNuNkp6NDJETGo2bm50ZlVi?=
 =?utf-8?B?anVsaEtCWldOSFlBbmNNNVAyd0J4ZFhsUnVDQVBGL0h1STI4QkFQWDI2Umls?=
 =?utf-8?B?MzRuZHNkZzIrMzl2QmVNZ2xiVHBFczJXVFhrVWo3Qy9HR0tyTHJRUHNYaExX?=
 =?utf-8?B?ZWYzMGdLRFVmWDlYMzNNVDFaamRyS0Z2UzQrNW54RlRhY3NyUzVQUXBLYmlW?=
 =?utf-8?B?Z2NmSVpjZTIrU3lLeVRjTDhMMXQ1a0RNRElpOWwweFk5a1hkTzVweWlOZFoz?=
 =?utf-8?Q?ag2c=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1795ac8-7402-41bb-b610-08daf4d02e6f
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2023 19:06:59.8450
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nuuoEI/Xga8SqnwollULbuu1oRfZNWDta4QdP7Anmhyf0f4BtFSAX21YyJuKqwmo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5113
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/12/23 11:30, Reinette Chatre wrote:
> Hi Babu,
>
> On 1/11/2023 4:47 PM, Moger, Babu wrote:
>  
>> diff --git a/Documentation/x86/resctrl.rst b/Documentation/x86/resctrl.rst
>> index 2860856f4463..7df5889237f4 100644
>> --- a/Documentation/x86/resctrl.rst
>> +++ b/Documentation/x86/resctrl.rst
>> @@ -24,10 +24,15 @@ CDP (Code and Data Prioritization)          "cdp_l3", "cdp_l2"
>>  CQM (Cache QoS Monitoring)                     "cqm_llc", "cqm_occup_llc"
>>  MBM (Memory Bandwidth Monitoring)              "cqm_mbm_total", "cqm_mbm_local"
>>  MBA (Memory Bandwidth Allocation)              "mba"
>> -SMBA (Slow Memory Bandwidth Allocation)         "smba"
>> -BMEC (Bandwidth Monitoring Event Configuration) "bmec"
>> +SMBA (Slow Memory Bandwidth Allocation)         ""
>> +BMEC (Bandwidth Monitoring Event Configuration) ""
>>  ===============================================        ================================
>>
>> +Historically, new features were made visible by default in /proc/cpuinfo. This
>> +resulted in the feature flags becoming hard to parse by the humans. Adding a new
>> +flag to /proc/cpuinfo should be avoided if user space can obtain information
>> +about the feature from resctrl's info directory.
>> +
> Could you please replace "parse by the humans" with "parse by humans"?
Sure.
>
> The rest looks good to me.
>
> Could you please do a sanity check by building the documentation to ensure
> that the usage of the empty quotes looks as expected and is not parsed out by a
> tool when, for example, creating the html docs?

Yes. Will do.

Thanks

Babu

>
>>  To use the feature mount the file system::
>>
>>   # mount -t resctrl resctrl [-o cdp[,cdpl2][,mba_MBps]] /sys/fs/resctrl
> Thank you very much
>
> Reinette

-- 
Thanks
Babu Moger

