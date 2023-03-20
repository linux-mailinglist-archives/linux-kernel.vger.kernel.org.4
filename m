Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A3546C21F9
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 20:53:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbjCTTxm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 15:53:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjCTTxj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 15:53:39 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2059.outbound.protection.outlook.com [40.107.96.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73854166EF;
        Mon, 20 Mar 2023 12:53:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e4yQ3U+QjdwwDdZE56ngDYfbSOWoF6CJNJb1hVcTN3DAm/8xABIigbgjzP63qtCRb5e7LfWoD+I5ZIoh3iE5NtAKX+xoY7hLzRV0xuU6ykMI2PKOULwYq6X4TExXDoHyroz65eTiNpobYquKfwFvKZp2j2oJ7NkyTEt+hDU13DFf+jh+/j+yWb77JeZArMdyCa2I5ybQbTV1sqNXKOs8CIUhakMPux9umlF/TuuWgfxnBGaTptrNSmFmJ9UntHK8GJZ52XgcudViIegf+RgGExLmwhq3hnAgHep+RFhKVFqDWZheeURmaDRkbekJyUIKXoiid1zl9f6Na5QldYJatA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Eu8meu0c+SWHNO3vQ5vMyWssD3evjzZbtMkgJAVsP18=;
 b=FfFl2G2XhdqJi7lWuzZH/PedLzMzz5/XY1QesbEH+EIADfVUOCR2/JziOVRJlu2GoGnRu6+qt31ZiFXDgh4HAh/tiTHYxZwb4mOMOiXiwpJlWmwskJd3gYFimVt/MX6uQOz/v6gB9EzoIqBF2Twi5sfZ8aZWkqWy4m0cjzxT2VIQ8kbkiivJWs7q4lcose2q12FVSSRYkapuI29X7NgFfUD5HlKq2KBxeOaCUTEFr3tYnmRgTQMg+pZlH26TX+nNmUMYzZdcEzqBORpZ3Y4Bqyxld5StzZ7/jwXN/kgMwjlZJvEsrQxHKLCzTAVO5KJPVBQJpdQOnbThnXRlNZaULg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Eu8meu0c+SWHNO3vQ5vMyWssD3evjzZbtMkgJAVsP18=;
 b=J0HabDDbIiwq94hVEBOAm+txaerFxsiTdrXzhgOV3YK2qqqFt3mK2/5jRnikeaa1fnO0QR4GChInwdi1ITf0SAP379zt9N2/z+4FguZuwcXbP18iTTC34cuisRq8214ARFDjmGotq1T5Bc0eFjKmPLnh9nrR3VRyVxNLkOIqfAY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by BL1PR12MB5802.namprd12.prod.outlook.com (2603:10b6:208:392::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Mon, 20 Mar
 2023 19:53:10 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::3490:de56:de08:46f6]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::3490:de56:de08:46f6%8]) with mapi id 15.20.6178.037; Mon, 20 Mar 2023
 19:53:06 +0000
Message-ID: <111e712f-96c7-7c58-5b55-05a11634469b@amd.com>
Date:   Mon, 20 Mar 2023 14:53:05 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v3 5/7] x86/resctrl: Display the RMID and COSID for
 resctrl groups
Content-Language: en-US
To:     James Morse <james.morse@arm.com>, corbet@lwn.net,
        reinette.chatre@intel.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de
Cc:     fenghua.yu@intel.com, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, paulmck@kernel.org, akpm@linux-foundation.org,
        quic_neeraju@quicinc.com, rdunlap@infradead.org,
        damien.lemoal@opensource.wdc.com, songmuchun@bytedance.com,
        peterz@infradead.org, jpoimboe@kernel.org, pbonzini@redhat.com,
        chang.seok.bae@intel.com, pawan.kumar.gupta@linux.intel.com,
        jmattson@google.com, daniel.sneddon@linux.intel.com,
        sandipan.das@amd.com, tony.luck@intel.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        bagasdotme@gmail.com, eranian@google.com,
        christophe.leroy@csgroup.eu, jarkko@kernel.org,
        adrian.hunter@intel.com, quic_jiles@quicinc.com,
        peternewman@google.com
References: <167778850105.1053859.14596357862185564029.stgit@bmoger-ubuntu>
 <167778869402.1053859.6094569492538617564.stgit@bmoger-ubuntu>
 <f4808265-f136-631e-0220-9019e64ee9d3@arm.com>
From:   "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <f4808265-f136-631e-0220-9019e64ee9d3@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR04CA0011.namprd04.prod.outlook.com
 (2603:10b6:610:76::16) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|BL1PR12MB5802:EE_
X-MS-Office365-Filtering-Correlation-Id: fe9a2472-06b2-484c-bf89-08db297cb8d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NqtqwYIMNFJzE9v6tDyi97qAyoPb87xQKiqAzRUcB+fanA5zhPPtLsJNyeAG+DrFcN3Cqtb7v3Hy7Ta+bpkQoWphBEA2JBxaUJw7mJA4QR9SeiO6KJxC0VMnKcsJksOh7PQkzLKdUqKqaCjnip/J3BSUkxoa4tKF1DnNAClLOvzkmphNsARquUNFHnrRuCZCWzBKNiRweoO+Oy7fVf4FtKh6/iOc20vbQO/D+l5yHQATXIWHUyU46XDW1cA5Iiq5ssd9Aj2WrSTLnh9MFtDf2XX/d6H1xPgOpVHyAg6dU03xkUQOHw/q7xIXOHeQpyDG6StttLyGK72hPyGaKNGVeImG+uJJTN/YUHO+S9fumOjsyQnmFE+EMzSU849vieAniHTZ6/qzD0HqAfBfxnU0vsFdKF4Azz1syWn62NWqwIklEXc3nNSemiboQLFddjRkbXj50vU/tXExEKrorDxjiKoUz4tGyOA7qbqXmNXWOaFkYpTwWRwEhLiLfvrhtGRa5P+AnbwvL4hwzMr4w2h1bW4JjpWYuiDjoa4qRRGK2rLnntkR4/YMl2eDR1uCcUKVj10Adty51mFVwglL5ukoAM9CcbdukY22ZyeDsggseE5OE6fMDTqhZrcZKGseE9JI5nT9V639/ve/d4aYzn3GqjSM05+s/5ysU/0dWoAnddS3FYG8TxVh/Vm2ABCS62m6BrlDwWhMuYEGp4o9Tv4t3DJYk901hTDvLNR2izpF5Sw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(396003)(366004)(376002)(346002)(136003)(451199018)(38100700002)(66556008)(2616005)(478600001)(31686004)(316002)(2906002)(186003)(3450700001)(66476007)(8676002)(66946007)(6506007)(6512007)(36756003)(31696002)(86362001)(4326008)(26005)(53546011)(41300700001)(7406005)(7416002)(5660300002)(8936002)(966005)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?THNwZmZDbEVHN3hiNksyOEsvR0RLTEw5eEtyaER4Qi9PR2NMdG5ISit6Yk5E?=
 =?utf-8?B?ZWc3UkpqNDZpTmtuSTRBYXNrdGszd2hncmczclNZdkVFM2wyTEdoQnQ2OEZZ?=
 =?utf-8?B?NURwWUFFQjJhZnlhWXd6dUdpalhVK0MxM1RFMUVhWGp4RHdzcE9DQlFnWjdU?=
 =?utf-8?B?QUJ2M1dCYStmRS9Rb1pRLzVuUlhxelRPWWVnaWU1clR6M0NVZVhBaHBlL29K?=
 =?utf-8?B?RWZhV0h2QUQrZWFXRjhKbUVNWldOZk9DWVJtaTJwRS9ScWdwdUlud0FNN3VF?=
 =?utf-8?B?V3RocSs1eEFUQWhMRm5aR2FlaU5KYUo1N2lXdWpXWUNhN0VNU1doc3lET0FV?=
 =?utf-8?B?dDFuQjRSNXVvOUtTZVdXeHpDN013WGwwV2NndHR4NTljb3N0bWovcmZLVW92?=
 =?utf-8?B?b21HUmEvditOSXp1cm4wbkUzU09NNFZoWDdBcEQ3NW9ka0NtM1ViNHJ6TkNq?=
 =?utf-8?B?UGVqbWJUd1pPSWQwSllkUHU2WEJSMzdKYlJzZm5RZDRmMk9SM3RqMExORTBB?=
 =?utf-8?B?TDNqeDdtWlFxdFRsSGJ0bFArM1N3eDh6eEd2Y0d0Z3RKZElDVjFmS2VXdmxt?=
 =?utf-8?B?aGxieTE2cVBTbGxFU29yUjkzZklzbEM5N3BHbVNyWTM0NjdEUmdyblgyUyt3?=
 =?utf-8?B?MDBkWFp4VXZlN2d6TkphbmhRK3h2NlVhY1Z4RHh1RWMvNCtrdUxUNURzbCtp?=
 =?utf-8?B?bTVJZkdzNUU5NWVSZUdyYWRWL0xMdExqZC9jQkt1NWY0U1gvalVEUklkZEJT?=
 =?utf-8?B?MWloNnFCcWJjR2JPMEJKREgvZnhhVFM5UFRIQ25wckUxVVEvTXBjenlJUWFj?=
 =?utf-8?B?TFU4WWtxa2J6RnllTkhsNVFwNHRzc2pKM1lyWkNMRVdyb3lLWFR4QysvbmZ5?=
 =?utf-8?B?VlFCR0JJQnN5dmhCUkdURFlma2N3N3ZTMVdnaVpWbUJWZ01qWVh2MWlLUkM4?=
 =?utf-8?B?VW5hcjRpSE9HL3dsK3JxZnB4WGovWldXVG8zUGZrcGxMZUZKVlVmQmtUc1NS?=
 =?utf-8?B?a1F3cElIaERJOE5GdS9pa2pBQ1g4d1ZzdXdqWllKbkdSY1JseGdIQlZ5Vm1h?=
 =?utf-8?B?SjIrYi9HZTNjYktGSEtQMmZ3TXhkRU1JK2drMkpJKzlZMmxGTWYydVlaU0hM?=
 =?utf-8?B?Rm81M2JvY3ppK2lFSnloQVlMekZFWHdJb2V0SXlBaFc2eUJwaUYrTkpBR2E2?=
 =?utf-8?B?Q3FIQ1JDNEJEUExXVGRjd2t6Q2ZOVVFTS3ZqZFo3eEFCbUpoV1A0aHVoY0h0?=
 =?utf-8?B?SEc5Y25HQUhFSVZNcnMwbUs3R25mcGIvdFlkbzBTdldtTHFBMHA3b0ZYaXZY?=
 =?utf-8?B?bjZEOVRYanhCTWxGS29QRjRESHFMQ0QveEZQcGZjSWtOZnJEUEY0cDBLcVhN?=
 =?utf-8?B?dytqcHlnWmt2dzQ4T2x0WlBGdUViOE5BTWdOVG51ZlV2eUxDY2xydXo5bHNT?=
 =?utf-8?B?aW5NbjRiOEdmaldVcmNFZHlzL25KRk0wc1NCQVZ1TlFJMGxGMmI2Z0VRaXJG?=
 =?utf-8?B?UUVLRnJxanB2Q0dqT1ZkNXQvOGo5WlArTlVQYU9XNU40ZElYbFRjcVk3NzBY?=
 =?utf-8?B?dzE1MTRUbTBIQ0VPdWNiVDRuckJmQnMra1J6OWFtaUpNUjJmeUc3bmhhZHoz?=
 =?utf-8?B?bHBUMktqSkV0SllCNjJuRStXdElnRnNOT2NHRHJGcEJaRkt5VWxJc2RmVlNh?=
 =?utf-8?B?dkxKOXRzUlVoOE1RMittVnlqMUcxcHdabUlMaVd3T2R0eDVyZGp2ZElHM0xZ?=
 =?utf-8?B?U3J1RzkzT0lZQ01RYnBYRExYVTVUVFMxNFVDeW1ndktoSy9MbHo3bXBTNjRM?=
 =?utf-8?B?cWhLZmdpL1hpWnIwKy9wZFVXMnlhdmJVa1FJYXdZYlJLbUw1bkNmbXFvRFBM?=
 =?utf-8?B?Qm44TTFmYUVTNS9DeUgzbHZqNmRMQU1oM0hRR3Q2UG1ZaWFzdm5ZZnNLN2Qw?=
 =?utf-8?B?cGhyWHB6czRjdnpuUHJoQ2FwRnVqLzYrazY4Y2RWN3J0Y3lwOUszV0lUNWFw?=
 =?utf-8?B?RHdCOFI2ems0cDJ0VWx0UXVMVmVrQnovcDBBTCszUFgzRU1VbDdBejdjTWlr?=
 =?utf-8?B?VTZjaktDOEZrWlRlVHFpSERzSnd3dmRheVdmbnlyOXkrZ3dBSXdDVFh3bUoz?=
 =?utf-8?Q?ypdPGn9gW3nTtN9qLtJGovRN2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe9a2472-06b2-484c-bf89-08db297cb8d4
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2023 19:53:05.8409
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yFFZce56llqtmd3Wg3//mqmmX3vGKhznLSVzGGSFWa1Y1Ui0x52whR0xLWestDF1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5802
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 3/20/23 12:10, James Morse wrote:
> Hi Babu,
> 
> On 02/03/2023 20:24, Babu Moger wrote:
>> When a user creates a control or monitor group, the CLOSID or RMID
>> are not visible to the user. These are architecturally defined entities.
> 
> On x86. Any other architecture is going to have a hard time supporting this.
> 
> 
>> There is no harm in displaying these in resctrl groups. Sometimes it
>> can help to debug the issues.
> 
> By comparing it with what? Unless user-space can see into the hardware, resctrl is the
> only gateway to this stuff. What difference does the allocated value here make?
> 
> Could you elaborate on what issues this can help debug?

While ago, we had an issue with one of the RMID's event reporting. There
were numerous active RMIDs on the system. As a kernel developer, we
couldn't pinpoint which RMID was reporting wrong information. That
information was important for hardware guys to debug further. We had to
patch the kernel to print that information for debugging. This is one of
the cases.

> 
> 
>> Add CLOSID and RMID to the control/monitor groups display in resctrl
>> interface.
>>
>> $cat /sys/fs/resctrl/clos1/closid
>> 1
>> $cat /sys/fs/resctrl/mon_groups/mon1/rmid
>> 3
> 
> Er. Please don't expose this to user-space!
> MPAM has no equivalent value to RMID, so whatever this is for, can't work on MPAM.
> 
> 
> Where I have needed this value for MPAM is to pass the closid/rmid to another kernel
> interface. Because the user-space interface needs to be architecture agnostic, I proposed
> it as a u64 called 'id' that each architecture can encode/decode as appropriate. [0]
> 
> To prevent user-space trying to base anything on the raw closid/rmid values, I went as far
> as obfuscating them with a random value picked at boot, to ensure scripts always read the
> current value when passing the control/monitor group.
> 
> 
> I'm curious what the raw value is useful for.

It is mostly for debugging when there are issues.

I think we need to have a way to print generic as well as architecture
specific details.

Thanks
Babu
> 
> 
> Thanks,
> 
> James
> 
> [0]
> https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git/commit/?h=mpam/snapshot/v6.2&id=d568cf2ba58b7c4970ce41a8d4d6224e285a177e
> 
> 
> 
> 
