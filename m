Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD1486BD992
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 20:51:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbjCPTve (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 15:51:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjCPTvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 15:51:32 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2056.outbound.protection.outlook.com [40.107.243.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 875C17B4A0;
        Thu, 16 Mar 2023 12:51:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kcNKCg8I6Bsrg2GSUXYdLhh6IKTqqiA4u2zolOfOSbqo8GDjom0kwELZyn+TKNjqwtg48kh2+i6PWp7OLgWlXOBd+b65euO9NUUhnQVNQndscT/k6TFi6URk5MaX0U7lINCrvpsPmNmLmnDUUOMJY4SU5sbq6+d3LO6cxVc3UDVMdUe1RC7hb9QktBlRiJJkUUeCFlw2DZbdDI37yB8D8bNe0EBYX4H6v35ZpYrxnaaU/K/mLpJFI3OpUfqkfWcENUx0Xy3LIK3b3MGVnHUT3VwksBep4jbyz3tD1y+i950/FmsTaUI/AHeRxavf2QrWi/WyTDKDbMY5lubLPlL3QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DHeILnDXZDmvfPyikv+tMzpsCNfzhycr8nflIuP6zt8=;
 b=T8rFpFLf1y9W3HEInmeXHcpPfGGQxFgUx9G/H/mBEK0t+Wttx1wuWNoRJnjV2slaSiRdlvdRMSDUKevW38Dr670ZZ7qU7p5ocEsKWwMnKp2YsUMKxYV2Q2rOajMXJH4/8glGEECbJ11EL06tN9AqTyJUYqkeq2WyG/TM1PyWqwBuDr+J+vnX/9azOo7J0k6ThCRFvzpnX2Ps7AlQlGcZGAKkEZ4tAEb/zPSupG/PJoi8S5UX4HaRnKyuIy1Ek7/iRazc4y0Q4IK8k78aqIGxlnnIOlmYj462pWjku47livd006aI8/QIZAaYd2VMYO0bZJqSZtaHWSBToVdz1GJAIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DHeILnDXZDmvfPyikv+tMzpsCNfzhycr8nflIuP6zt8=;
 b=b9+Z33SkY/h9CzhZFhXm41PWi1bL3cy7RRE/+e6S3jWlBKguSFjtWoHNZh21grh63omIT+Bayjbbi+wvXdseq98s7CM7Feqh+cDFyJX/UTiyrOov6vMV3h7aGDLxmDkOSjXjXtJfu8jpg7SuguzGqfzmCmddyAc8sb+5xcW8HA0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by DM4PR12MB5133.namprd12.prod.outlook.com (2603:10b6:5:390::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.31; Thu, 16 Mar
 2023 19:51:28 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::3490:de56:de08:46f6]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::3490:de56:de08:46f6%9]) with mapi id 15.20.6178.029; Thu, 16 Mar 2023
 19:51:28 +0000
Message-ID: <39c85927-9c34-0284-86c6-724f417423db@amd.com>
Date:   Thu, 16 Mar 2023 14:51:23 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v3 1/7] x86/resctrl: Add multiple tasks to the resctrl
 group at once
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
References: <167778850105.1053859.14596357862185564029.stgit@bmoger-ubuntu>
 <167778866506.1053859.2329229096484796501.stgit@bmoger-ubuntu>
 <9af9eb7a-476c-d4b0-e114-3f5c2b45dd95@intel.com>
 <MW3PR12MB45537DC45130BB5F02F0F3F095BC9@MW3PR12MB4553.namprd12.prod.outlook.com>
 <71b58853-e7c9-b522-3f90-c3d84cba1317@intel.com>
Content-Language: en-US
From:   "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <71b58853-e7c9-b522-3f90-c3d84cba1317@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR04CA0044.namprd04.prod.outlook.com
 (2603:10b6:610:77::19) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|DM4PR12MB5133:EE_
X-MS-Office365-Filtering-Correlation-Id: 20ccd6cb-c258-45a2-a91d-08db2657d4da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z/kO067AKSIbwRvRVGdOTiI3zUw6g+4YTZLO/zHCUBbVEP8G9m9pegHvZC5ar6iTqg43qu8lsspN9UzqeBTqq549RxVQYuT7bQ/m13xJ0ulwmZshUE7pNMp4IDChzIssQRziQrnbxPioB/SDMxuE4DT//1U9CmUd0+9M9NrL7ksx/7kh3v2mmo442j317Zh7XnsZqXv1TtgvsVWi4XV/OJIkfJQB+p1Lsrg6JzEnOcULqrtpsWuh4mP+HjR8mf/X6aOa9hMZj5NWZXnnWVMBwm6kNUKiO+SpBD/GbNFPpcoqzH7g/fC3QB/DSCdL+xIlBG03CPPytIUqjlpfchic/ShABbtxRfZzyMolwSCDSMnoSl121ACKrmkjixMnE17O/bPVmpmO8gd9KFQeWUwozkg0TebggKDOfVQXKFnblyML1uPqFHheDYgCQssZ+jBRr9zBXvo42VTUPp2i9kx6DYseujnJv7b6eFq09U8ISv0ugdEwcNpwtM9afS7HQ/OJ2OmQ8UzhHedtdO1DU/UY4dQplLk8G/yA8eT2ci0+DexoxLm4rjcHvijLz5VjA76q9xcvGDK2hPXxR1WcoiK9UUJnD+dbWhJOcH+9feZsDHGXJc/b3r9LznNAcj1lNilTHQmoYU0mYHYT1eNRp6vTEsAKd40vgNS9vJFyp5jF94iRVs5v2E/Qc7HRGGi+NQWrNuWYkZ8raObasHKvAXeEb6Wv4tb56THitNZEPvQ2TNM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(346002)(136003)(376002)(366004)(39860400002)(451199018)(38100700002)(86362001)(31696002)(7406005)(36756003)(2906002)(3450700001)(41300700001)(5660300002)(8936002)(7416002)(2616005)(4326008)(26005)(83380400001)(6506007)(6512007)(53546011)(186003)(54906003)(316002)(110136005)(6666004)(66946007)(66556008)(6486002)(8676002)(478600001)(66476007)(66899018)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?djF0NEJCWlF5NDRsVnZrSExyM0NpTW1QR1I5MWxhTHQ4RXVvazJSZ2toMURh?=
 =?utf-8?B?eFZrcGhZTGpDM1BtQ0owYVgrSHZrTUlTaE51QS9KR1d6ZytSWEtPMHMzU2d5?=
 =?utf-8?B?OGNDSklMaXJ0SnppeGtJSEFZNEJwZnRiRXRjRnc1V0lzNGhocjY1bTNmelk3?=
 =?utf-8?B?NWJINXFjMmNFSkR6dytoVlZnYTZnU01yTEp0dU9qZG5PZ0J4MTdFVzJWTmJ2?=
 =?utf-8?B?U01MWmFOWW84aWlWbVh6NGhQSE1TRlBvWFNuMFA2N3ZybDl3WFUrc1NIOG83?=
 =?utf-8?B?bWliMnVPVTU4azZYU3FSVjRNYXVOQUNCSytpYjhWTUNha05JZ1NaVjd2VXI2?=
 =?utf-8?B?emhjUmc2Zk9kaWk5UndWNll1djlJSkQ1YWIyRHdBaGhZMmRqaEtSOWFUTENV?=
 =?utf-8?B?TGNPN0xNdHVNR0MyNXorTjFLS3Q2MnBsYlFlb0JybDFTZDhWd21XQmZxSnQ4?=
 =?utf-8?B?NXNCT1RBblcrY3I0TlUwUVhOZHovVVB1T0NXQ3Z2dlcwZVozamZuZWc5ZUw1?=
 =?utf-8?B?dzFxOUQ5cW5ydnMwT21aekVUSEs5bG9SWWtORVJ0VUtxa0FGN2dlRkJFekx1?=
 =?utf-8?B?UTNsRkxlRkZHY0k5Z0k0U01tVmR3OFFzdzNlMWg2Y3lBNlk2bGk5NUo1WnE5?=
 =?utf-8?B?bmNiT0tmZkcyRzl6UVdpb0RMRFptYTNkZnh1VEdsUTQ1dXQ0R1FJby9XSWJx?=
 =?utf-8?B?M1lZSzZoTFp1dU85dElWNnBqbVN4bUxSRFdBbGNxY0oxN0pyQ0RPU0VuTHVH?=
 =?utf-8?B?SGxWbTZhNjRnS2ZEbldkdjRCRkxOUzVxT1RaeDFNclBhY0JVZjVhNWZEaDNX?=
 =?utf-8?B?cjlJQUl6MzNzcmpMZCtoVncyQ2RDWHN4QmJLSmJYdHBZTHdSRUt0VWt4QXRJ?=
 =?utf-8?B?UnpIVzZENE0zd3JlS28wclhMeGNzMWsycjZ5ZzJkYXJabE1xSDlRV0pEZURi?=
 =?utf-8?B?RnFzS0VXVFA1UnI4TzVKbFFLV1Rkb1YwZzZHY2RkNGE1WFRmMktEZTc4MkhI?=
 =?utf-8?B?TE1tTkJPRlhHOUlTcTNiYkNHWUFsZWV4TzcyOTVFSC9GVjMzM1UybHZGR1JV?=
 =?utf-8?B?Q1dPZi9DMkRVSVkzL2c4ODJMTUJQbDBiM1gzdjlGUCtJQUV2WUpVanpZVXVj?=
 =?utf-8?B?S0prVnlIbnlWd1FnUWVJZ3VwSVY5YjRrRXRMTGFaemJ6bEZlampxRXpiZVZX?=
 =?utf-8?B?WUc5UWJkQUpGdHVUbEdrK0JJNFdRSURsSEQxMnRsam8zWkgyVmlMRlQ5WEta?=
 =?utf-8?B?WW5XanBiTm5LWFUza0gvUEtOYnBFWXVtS1poNTJLWFllVnM2Tnd2dEM1RHda?=
 =?utf-8?B?blhoS0w3azBGN25yT1RibE1xL0FvcXl6MldPRlk1bVBZTkN2VFZvbkd2KzRk?=
 =?utf-8?B?VngxRlRqV2FZNVQ4UmpmNG5UeVhlYktJUStLUmNoUDY4YWxvMElpOExZL05p?=
 =?utf-8?B?d1hjRjJ1U2htaG5OZXhsT0o1Vk5HeG96eGxGMkFoSVJLOHNNd2FYbUkvWmNu?=
 =?utf-8?B?UFFCWndLNGtSQUc2RjU2cFVjKzhBMGpaUHIvSGF4UDJyd2ZWVENGQUVFUUhY?=
 =?utf-8?B?SkUzVjZmYU1ESm1TMDY0UlozQ2VxTE9qWDhnUWlialJ6VndnWnF3V2VGWjBK?=
 =?utf-8?B?bitZanZXbmx0b1EwZmoyT05LTy8zWDFLbS9JaFNCTkdaUzVYSmRBUmlDSmhS?=
 =?utf-8?B?SVg3NHZWMFFPRURybmZlN3pCVjdiaFg5bmJYR2dUZGZyRUo2bWEvVnJZNVN5?=
 =?utf-8?B?eXV2UnM3MkhUOXJMa3hiL3luSGlmRVJsZnFYdFZJTjZjYzAxc2tBWlF3R2Mv?=
 =?utf-8?B?MS9DL3NGVS82K1pMQ1JkVEJtM2lhRlVYM3FTbnVpcERyWXlDOHNKbjlmblcy?=
 =?utf-8?B?QU5HVU9lN01WcnYvWHpBV0JuZ3UrZnpFcVNLWFNwM1ZFZHNzaktSV215dGs2?=
 =?utf-8?B?RXgyZlBjaDV0Y2dMQ2lsUDZoaGI2N0QvQkVlOURoQmRlZ1ZWYXNBb01vQW1E?=
 =?utf-8?B?bGVJYUtCNS9yWGYrRVJCa29RM2lRdlQ4bE1xUUtYdUdQTlFxcFhJcFUwWWRJ?=
 =?utf-8?B?b09QQzNhcVViYlRMSC9LdmZtQ2RrRUwyMit1ZmVNQzF1RU41UGg4N0xnc0Fa?=
 =?utf-8?Q?tce8//QGY8Z6dVeKUVNWjbZdy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20ccd6cb-c258-45a2-a91d-08db2657d4da
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2023 19:51:28.0666
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9XF/w/ojuZs57VStpuGkexMTdWOGzBYfi870emDXUHm0MG1lePik9h0D/2AESvpI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5133
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette,

On 3/16/23 12:12, Reinette Chatre wrote:
> Hi Babu,
> 
> On 3/16/2023 9:27 AM, Moger, Babu wrote:
>>> -----Original Message-----
>>> From: Reinette Chatre <reinette.chatre@intel.com>
>>> Sent: Wednesday, March 15, 2023 1:33 PM
>>> To: Moger, Babu <Babu.Moger@amd.com>; corbet@lwn.net;
>>> tglx@linutronix.de; mingo@redhat.com; bp@alien8.de
>>> Cc: fenghua.yu@intel.com; dave.hansen@linux.intel.com; x86@kernel.org;
>>> hpa@zytor.com; paulmck@kernel.org; akpm@linux-foundation.org;
>>> quic_neeraju@quicinc.com; rdunlap@infradead.org;
>>> damien.lemoal@opensource.wdc.com; songmuchun@bytedance.com;
>>> peterz@infradead.org; jpoimboe@kernel.org; pbonzini@redhat.com;
>>> chang.seok.bae@intel.com; pawan.kumar.gupta@linux.intel.com;
>>> jmattson@google.com; daniel.sneddon@linux.intel.com; Das1, Sandipan
>>> <Sandipan.Das@amd.com>; tony.luck@intel.com; james.morse@arm.com;
>>> linux-doc@vger.kernel.org; linux-kernel@vger.kernel.org;
>>> bagasdotme@gmail.com; eranian@google.com; christophe.leroy@csgroup.eu;
>>> jarkko@kernel.org; adrian.hunter@intel.com; quic_jiles@quicinc.com;
>>> peternewman@google.com
>>> Subject: Re: [PATCH v3 1/7] x86/resctrl: Add multiple tasks to the resctrl group
>>> at once
>>>
>>> Hi Babu,
>>>
>>> On 3/2/2023 12:24 PM, Babu Moger wrote:
>>>> The resctrl task assignment for MONITOR or CONTROL group needs to be
>>>> done one at a time. For example:
>>>>
>>>>   $mount -t resctrl resctrl /sys/fs/resctrl/
>>>>   $mkdir /sys/fs/resctrl/clos1
>>>>   $echo 123 > /sys/fs/resctrl/clos1/tasks
>>>>   $echo 456 > /sys/fs/resctrl/clos1/tasks
>>>>   $echo 789 > /sys/fs/resctrl/clos1/tasks
>>>>
>>>> This is not user-friendly when dealing with hundreds of tasks. Also,
>>>> there is a syscall overhead for each command executed from user space.
>>>
>>> To support this change it may also be helpful to add that moving tasks take the
>>> mutex so attempting to move tasks in parallel will not achieve a significant
>>> performance gain.
>>
>> Agree. It may not be significant performance gain.  Will remove this line. 
> 
> It does not sound as though you are actually responding to my comment.

I am confused. I am already saying there is syscall overhead for each
command if we move the tasks one by one. Now do you want me to add "moving
tasks take the mutex so attempting to move tasks in parallel will not
achieve a significant performance gain".

It is contradictory, So, I wanted to remove the line about performance.
Did I still miss something?

> 
>>>> --- a/Documentation/x86/resctrl.rst
>>>> +++ b/Documentation/x86/resctrl.rst
>>>> @@ -292,13 +292,20 @@ All groups contain the following files:
>>>>  "tasks":
>>>>  	Reading this file shows the list of all tasks that belong to
>>>>  	this group. Writing a task id to the file will add a task to the
>>>> -	group. If the group is a CTRL_MON group the task is removed from
>>>> +	group. Multiple tasks can be assigned together in one command by
>>>> +	inputting the tasks separated by commas. Tasks will be assigned
>>>
>>> How about "tasks separated" -> "task ids separated" or "by inputting the tasks
>>> separated by commas" -> "by separating the task ids with commas"
>>
>>
>> Will change it to " Multiple tasks can be assigned together in one command by separating the task ids with commas."
> 
> I would drop the "together" since it implies that this is
> somehow atomic. It will also improve reading by using consistent terminology -
> note how the text switches from "add" to "assign". Something like
> "Multiple tasks can be added by separating the task ids with commas." I think
> using "command" is confusing since what is actually done is writing
> text to a file.

Ok. Sure. Will change it.

> 
> ...
> 
>>>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>>> @@ -683,16 +683,34 @@ static ssize_t rdtgroup_tasks_write(struct
>>> kernfs_open_file *of,
>>>>  				    char *buf, size_t nbytes, loff_t off)  {
>>>>  	struct rdtgroup *rdtgrp;
>>>> +	char *pid_str;
>>>>  	int ret = 0;
>>>>  	pid_t pid;
>>>>
>>>> -	if (kstrtoint(strstrip(buf), 0, &pid) || pid < 0)
>>>> +	/* Valid input requires a trailing newline */
>>>> +	if (nbytes == 0 || buf[nbytes - 1] != '\n')
>>>>  		return -EINVAL;
>>>
>>> The resctrl files should be seen as user space API. With the above change you
>>> take an interface that did not require a newline and dictate that it should have
>>> a trailing newline. How convinced are you that this does not break any current
>>> user space scripts or applications? Why does this feature require a trailing
>>> newline?
>>
>> I have tested these changes with intel_cmt_cat tool. It didn’t have any problems. 
>> We are already doing newline check for few other inputs.
> 
> You tested this with the _one_ user space tool that you use. This is not sufficient
> to be convincing that this change has no impact. I do not believe that it is a valid
> argument that other inputs do a newline check. This input never required a newline
> check and it is not clear why this change now requires it. It seems that this is an
> unnecessary new requirement that runs the risk of breaking an existing application.
> 
> I would like to ask again: How convinced are you that this does not break _any_ current
> user space scripts or applications? Why does this feature require a trailing
> newline?

I do not know of any other tool using resctrl fs.
So, you want me to drop the newline requirement for this. I can try that.
Will let you know how it goes.


> 
>>
>>>
>>>> +
>>>> +	buf[nbytes - 1] = '\0';
>>>> +
>>>>  	rdtgrp = rdtgroup_kn_lock_live(of->kn);
>>>>  	if (!rdtgrp) {
>>>>  		rdtgroup_kn_unlock(of->kn);
>>>>  		return -ENOENT;
>>>>  	}
>>>> +
>>>> +next:
>>>> +	if (!buf || buf[0] == '\0')
>>>> +		goto unlock;
>>>> +
>>>> +	pid_str = strim(strsep(&buf, ","));
>>>> +
>>>
>>> Could lib/cmdline.c:get_option() be useful?
>>
>> Yes. We could that also. May not be required for the simple case like this.
> 
> Please keep an eye out for how much of it you end up duplicating ....

Using the get_options will require at least two calls(one to get the
length and then read the integers). Also need to allocate the integers
array dynamically. That is lot code if we are going that route.

> 
>>>> +		ret = -EINVAL;
>>>> +		goto unlock;
>>>> +	}
>>>> +
>>>>  	rdt_last_cmd_clear();
>>>>
>>>>  	if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKED || @@ -703,6
>>> +721,10 @@
>>>> static ssize_t rdtgroup_tasks_write(struct kernfs_open_file *of,
>>>>  	}
>>>>
>>>>  	ret = rdtgroup_move_task(pid, rdtgrp, of);
>>>> +	if (ret)
>>>> +		goto unlock;
>>>> +	else
>>>> +		goto next;
>>>>
>>>
>>> The documentation states "The failure details will be logged in
>>> resctrl/info/last_cmd_status file." but I do not see how this is happening here.
>>> From what I can tell this implementation does not do anything beyond what
>>> last_cmd_status already does so any special mention in the docs is not clear to
>>> me. The cover letter stated "Added pid in last_cmd_status when applicable." - it
>>> sounded as though last_cmd_status would contain the error with the pid that
>>> encountered the error but I do not see this happening here.
>>
>> You are right we are not doing anything special here. pid failures error was already there.
>> I will have to change the text here.
> 
> What do you mean with "pid failures error was already there"? From what
> I understand your goal is to communicate to the user which pid
> encountered the error and I do not see that done. How will user know
> which pid encountered a failure?

We only have couple of failures to take here. Those failures are already
handled by rdtgroup_move_task. It logs the pid for failure(using
rdt_last_cmd_printf).

I can say "The failure pid will be logged in
/sys/fs/resctrl/info/last_cmd_status file."
-- 
Thanks
Babu Moger
