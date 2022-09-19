Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2C155BD5B8
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 22:27:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbiISU1L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 16:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbiISU1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 16:27:07 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2041.outbound.protection.outlook.com [40.107.220.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4F1B309;
        Mon, 19 Sep 2022 13:27:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ODHVo8LUsxwYAV8oTX5seWojWS6F44NlUyLWM9wq2NYT4lnR0eoedC9adlvs92Sxj4jkWqx6umZeUIFP0Q+wr92IeZIWe9zryVCjrH8UT60CHBhLn08uJUsBj4SihZO8s/hWXPOTMLGqql0cZJkp2/Ss+WeTRS6JhcC3aAGIMZ3kliaKAeG0XCIkQZt7nGxP01iHdPl8ZijkWAaQP1WhM72sQJLFpcbutqlLxyWotElPW6YJfgWBFpbEesi6mCf5xX6EIwDRLunBNjFvUxVlTCvyCVL07SpSi34po1jMMYPkqCOPucEeUbAR2xR+Gnb8pv6KyxGzTiVJ+W0UqZ96fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NN6ZtkqOEbLv1Qi7tol+fP+3g2CNW80Sf6kVRuF9xO8=;
 b=P7Etdmxe92q62bb4CaO/AfN31SNdWWwg2y9RoOPdkWdF8rwJjPN34YXWDysUrhXVwx6TvZNnRDqKWBXRi5lcMlITSCpaqdPwN65DdKv+io5O8IoKMQv81cLT/mxu6E5XDo/HO9zm+aa5BSGqqJzCq531uibffri/3Lq2RZiRf4ptdWphxQK+726dNqPl75fJHtzGZ+lhDSyFxj/S+/H7LWFLOi1ZizOZp/WRXFhH2kcFDKnf/NBBdsPcNRs92Fq5ww2MnWP2WMsmpDICfOnUCpXUAXDVz0x7jdX/MBfFj2qMH4+Ufs7CYCxnEf8HcfcvWjeuLTKYqHPWurFfig3u8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NN6ZtkqOEbLv1Qi7tol+fP+3g2CNW80Sf6kVRuF9xO8=;
 b=a/A4apRk2d9SGPiBnMcB1mFFZRdOzJvU9giR/I57zV8cBZOHgAacTz/HxYiQanPLAa+6jK9v/vqzFUv2fK3O8Fwx8iYDs0AcfiALMYO0kcgTiknoSna40EvI95+1n0cju0q7dl/b9++nGbabjnFN5i1HeCR3xJdoQlScfGpXazY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by DM8PR12MB5494.namprd12.prod.outlook.com (2603:10b6:8:24::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5632.21; Mon, 19 Sep 2022 20:27:04 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::4120:60cf:46a8:7109]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::4120:60cf:46a8:7109%7]) with mapi id 15.20.5632.021; Mon, 19 Sep 2022
 20:27:04 +0000
Message-ID: <9dd5a111-63ea-8c4b-5515-d24d1d9c73f0@amd.com>
Date:   Mon, 19 Sep 2022 15:26:57 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v4 09/13] x86/resctrl: Add sysfs interface files to
 read/write event configuration
Content-Language: en-US
To:     Reinette Chatre <reinette.chatre@intel.com>, corbet@lwn.net,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de
Cc:     fenghua.yu@intel.com, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, paulmck@kernel.org, akpm@linux-foundation.org,
        quic_neeraju@quicinc.com, rdunlap@infradead.org,
        damien.lemoal@opensource.wdc.com, songmuchun@bytedance.com,
        peterz@infradead.org, jpoimboe@kernel.org, pbonzini@redhat.com,
        chang.seok.bae@intel.com, pawan.kumar.gupta@linux.intel.com,
        jmattson@google.com, daniel.sneddon@linux.intel.com,
        sandipan.das@amd.com, tony.luck@intel.com, james.morse@arm.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        bagasdotme@gmail.com, eranian@google.com
References: <166257348081.1043018.11227924488792315932.stgit@bmoger-ubuntu>
 <166257366204.1043018.4834615270384002210.stgit@bmoger-ubuntu>
 <13294a8f-e76f-a6a9-284c-67adbc80ec7c@intel.com>
 <04132d34-c69e-62a0-35ba-bafa44210c0a@amd.com>
 <bd424e21-c24d-fcf1-96e8-38c9f7546d19@intel.com>
From:   "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <bd424e21-c24d-fcf1-96e8-38c9f7546d19@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR03CA0023.namprd03.prod.outlook.com
 (2603:10b6:208:23a::28) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|DM8PR12MB5494:EE_
X-MS-Office365-Filtering-Correlation-Id: 553c2482-fe7e-4d0f-71ed-08da9a7d5084
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nfLKjua+Uhsl+g3QtyJ9hfBhN4b1DyOwKyrxenK134oIRbZouRpGwq6F/mphgNQphAT8X8mMybLUxCq2zUneKPcXQrzP6qRxpS4XlGYa5YZf/UqHau3ws5PrUauqVi0Cogb85MaDsnDQa14yaJPjDhDBobSyYYDMPNSf5oYp/ouD2qNN8AKgh5dG0ZA6DAgZVo5EM848eWoGPcjJN3EC4DYFhNm/ooCvrNmA3SJL8x1/rCVetQM6DQj3eif7BrAWhRl/17cWIb6iLlu/KmXW0gC2JBBxwvEkrHLJKyPVh7m83vhNgtxh4xWm3Pk3zL0JrZ3lp3mX1ZvDOtu4gvNkZiF817YKG1YJgtiUcB9pEj1DSeO117XQyQ/qHY8CIDdZ/CpMLJ+8aT2OOq0F8rb0fZz05MaFpPdtW3mNHKeGs3QiFnzmgOP2SwBUugscTB3WYJyNNNrG2SrTIfMy79dcSby1pCC8GCfNNcQE47SU09kkxCG2VrKoSlROjKvPeA9SJRJzNvzTx6JgglgR0aGO91F+Zu4j5KkF8OqYgKvxJpZ3vcY/Je4Ccz+E0cx+UlvwiU5+7V/Ltlhp2Lg/d6PUN1ze2b9j+GfrN/A9WwYUYYGKh2yjxCwljWhwkT0QJUSH+cvx9WVTCcfmGsvS0fLoX9EIN02iZOx7wWK69PRdGTi3YRZWG2nuQ5Ml8LPquWq2sj41J5c1UXE6tnxkrIaMke6DasoafUXSf1RRlOJ8OWA5LIlXpy91c/reIfuArulL9EtECsaSZj892BYWeJwUt2foTDbbXaGTrkdXCDvDss4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(366004)(346002)(39860400002)(396003)(136003)(451199015)(6506007)(53546011)(6512007)(478600001)(26005)(31686004)(38100700002)(6486002)(8676002)(316002)(8936002)(86362001)(31696002)(36756003)(83380400001)(186003)(6666004)(2906002)(66556008)(66946007)(2616005)(66476007)(41300700001)(4326008)(5660300002)(3450700001)(7416002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Tk9NcFBVQlR1c0J3bloycFA1dTlia1h1NVN1eUQ2b3Z4OG9HTDE5c0xtMGhC?=
 =?utf-8?B?ZllXVk1Rc1pvUTlEWHZDRkwxZ0JMR2UwdEwzZDU4UzRnd0ljblI1bGZlWkor?=
 =?utf-8?B?cFo5YkZHb2NnTGZsZEMvdFZPN2FEbEI0WXhEeVhuR3pCTUNxVnF4UXBNTG1W?=
 =?utf-8?B?MC9YRndVWWhkWW9tekg2TElNdzdLUGpYMUYwRi9Hcjh3eUtodXp1blZRNHBQ?=
 =?utf-8?B?WkRkTEVjTW1jT2NPQnRtazFoZ1J0bEdHblpZVVBTeUZrdzBaY0xkK3VKaFhH?=
 =?utf-8?B?THRLUnRuN1hzMkoxRG0zbFE3UFQzUWRRVGRrUExIQ0I3YnBLTUsrRFNlM21p?=
 =?utf-8?B?MnV0WHEyTTR4VmplVXhZS1NYY29NWFlHZk1wN0IzTG5Dd1QzYWttVXV6Q2RD?=
 =?utf-8?B?dktnVndEZU92YkVDVzVkNkRDUlpFbW96TXloeWMxTXRrQVdjN3FuWFV5MWxU?=
 =?utf-8?B?b3h3OGgyZElwUWxsb3FOWnlSTVVRbmFEb1NkWjZjNDRyUG5tMjltcktGWnBu?=
 =?utf-8?B?WFI5ZS85YVBiV1djbGVzVDZRSXpxVjhTR0ZsY0w5cXlHVkdVL1dZWlllOXND?=
 =?utf-8?B?eHYvMTJYTnNNWEViQVdiNXorSFdaaDBMd1FxSkRPZ3g2MmdhWUkzZkl0Kysr?=
 =?utf-8?B?eVJsa1NTWjAwNHZaMW41YVlKakRCalN4TUxZSjdQT09UK3B4bFZpOXpPUXFR?=
 =?utf-8?B?S3ZYL3Y4RUZNVExCWitkR3c3dk4xY2ZIY05COWNmcXRKOEVHMWZzWmxNZ1Bn?=
 =?utf-8?B?aFlaTVFXYjd0OURDdkdOYnNxMHFtT2RyK0VWNjFGVkxJOHZFbnF3Q2llRHc5?=
 =?utf-8?B?anFEd29xai9OU3ZDYW9CcjJMMEZkTlFiRVJ5VUxrTklKbmtOaHZGV3ByNnJk?=
 =?utf-8?B?ZnFyU25mR012bFAxcjUvUExYM2N1bmg4ZTVvQ3JEa0Y4WVY4N3JCZ054QWRs?=
 =?utf-8?B?cEptekZmQklJS1NLWDgwckNqenM2R0EyeDByRmZOclFRVWpkRll2czNJS2Er?=
 =?utf-8?B?VkVELzJkZVlMazkwQmU5ZVdRT2k0WjNEdXVTeFFDbk8rNXR1TUdZWUdGakZF?=
 =?utf-8?B?V1lUL2JMQTJiWXJjeUJBWGcxYU5CWnkwMjZCUGdHMzV3bXB6clZVUzdWdUla?=
 =?utf-8?B?WkkwRy9UVVRsdFkwMEZ6Nlh0bnV3anF6dEZqMDY4bFF5ZjJmdmVreUI4Z3NX?=
 =?utf-8?B?S1M4ZjBkMFYxOFhZd1djckJONlZSdklJelFMcmRyaU11S3hTam9KZEg4aHg1?=
 =?utf-8?B?RGROeUxESVFCbFNJOWo1YVVCVUl5UkprWEpaeGFJQjk2VFVyR2NPaFN3bDJi?=
 =?utf-8?B?dE9BdnlBSzhOaXZPdnE2SUU4Sm1zUEpQbHFHd1V2TmNyZ3BQY2dGYWhVT2FJ?=
 =?utf-8?B?d1hrOVlCY0NJQlZvdGc1MC95Y2k1SVh1M1dFaTVBWFllRXkybEJRZkpUQmwz?=
 =?utf-8?B?ODNTRGljN3NzcTdmOWZnMnliOXlZQllyLzlLcU1xbmc3UlZXWEdkdnh2S0RF?=
 =?utf-8?B?bWthYWdRSGJ3b0IrUHY3SmY5OGpzNkVGNS9kRG10Q1RMbEdDZGFTa2xVUW1P?=
 =?utf-8?B?RkY2RXF4dHZOUmxOZHVUSTJocjNSOS9iUENnTXBNTWFKTmlKK25QV00rOU1C?=
 =?utf-8?B?TTVweURBakZ2Y21DbTRGV1VkUXpWVWx2TkVONVhBRHFHZjdpSmRlSHdNUWhN?=
 =?utf-8?B?K3hXcC9lci9CWkJjZnZzejN0Nk5EckpUanJEZ09KS0VhV0d4TDR0OUNrSHRI?=
 =?utf-8?B?SmtFN1BpZE1lNEw3WmJ3Qkt2bUhLM1l0ZGF4bURBSzBpb2ZkTXB2Q3luZUJN?=
 =?utf-8?B?NmdpVzUyZWUvT1ZjTlJqOVNZUzNwMkxrbVljamtBdjMxZUpzZDNiZEJua1VX?=
 =?utf-8?B?c3hsZzVTNERtdFJDbzB0MTVHQktSaEl3UUhnenhNUVVKaFZtaWF1dU9oVTdv?=
 =?utf-8?B?UVpMTm1aMHpCb0pOVktNZktSa1owdXczcE10S1RkSjd1aUlyb0s3Y05UN096?=
 =?utf-8?B?eUNiN0VqajZYcGhlR3AvOUJTalB0TnF5NkorNDhIeTUrN0pWc0N0SmFYRldD?=
 =?utf-8?B?VlJ1SFN3Um5keE1XMEFjNW8yaTF4NU15Q1hJL1FsNitCYlN3MDF5WWlXZEVa?=
 =?utf-8?Q?gOJU=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 553c2482-fe7e-4d0f-71ed-08da9a7d5084
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2022 20:27:04.1136
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4/X3k8rAGyYTB+Jijn6CzT/3oH4B6y5RIIvxyZIRwqFCqRPjv15qGAnfPC3HhjHK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5494
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette,

On 9/19/22 11:42, Reinette Chatre wrote:
> Hi Babu,
>
> On 9/19/2022 8:46 AM, Moger, Babu wrote:
>> Hi Reinette,
>>
>> On 9/16/22 10:58, Reinette Chatre wrote:
>>> Hi Babu,
>>>
>>> On 9/7/2022 11:01 AM, Babu Moger wrote:
>>>> Add two new sysfs files to read/write the event configuration if
>>>> the feature Bandwidth Monitoring Event Configuration (BMEC) is
>>>> supported. The file mbm_local_config is for the configuration
>>>> of the event mbm_local_bytes and the file mbm_total_config is
>>>> for the configuration of mbm_total_bytes.
>>>>
>>>> $ls /sys/fs/resctrl/mon_data/mon_L3_00/mbm_local*
>>>> /sys/fs/resctrl/mon_data/mon_L3_00/mbm_local_bytes
>>>> /sys/fs/resctrl/mon_data/mon_L3_00/mbm_local_config
>>>>
>>>> $ls /sys/fs/resctrl/mon_data/mon_L3_00/mbm_total*
>>>> /sys/fs/resctrl/mon_data/mon_L3_00/mbm_total_bytes
>>>> /sys/fs/resctrl/mon_data/mon_L3_00/mbm_total_config
>>>>
>>> This patch makes the mbm*config files per monitor group. Looking
>>> ahead at later patches how the configuration is set it is not clear
>>> to me that this is the right place for these configuration files.
>>>
>>> Looking ahead to patch 10 there is neither rmid nor closid within
>>> the (MSR_IA32_EVT_CFG_BASE + index) register - it only takes
>>> the bits indicating what access types needs to be counted. Also
>>> in patch 10 I understand that the scope of this register is per L3 cache
>>> domain.
>> Yes. Scope of  MSR_IA32_EVT_CFG_BASE per L3 domain.
>>> Considering this, why is the sysfs file associated with each
>>> monitor group?
>> Please see the response below.
>>> For example, consider the following scenario:
>>> # cd /sys/fs/resctrl
>>> # mkdir g2
>>> # mkdir mon_groups/m1
>>> # mkdir mon_groups/m2
>>> # find . | grep mbm_local_config
>>> ./mon_data/mon_L3_00/mbm_local_config
>>> ./mon_data/mon_L3_01/mbm_local_config
>>> ./g2/mon_data/mon_L3_00/mbm_local_config
>>> ./g2/mon_data/mon_L3_01/mbm_local_config
>>> ./mon_groups/m2/mon_data/mon_L3_00/mbm_local_config
>>> ./mon_groups/m2/mon_data/mon_L3_01/mbm_local_config
>>> ./mon_groups/m1/mon_data/mon_L3_00/mbm_local_config
>>> ./mon_groups/m1/mon_data/mon_L3_01/mbm_local_config
>>>
>>>
>>> From what I understand, the following sysfs files are
>>> associated with cache domain #0 and thus writing to any of these
>>> files would change the same configuration:
>>> ./mon_data/mon_L3_00/mbm_local_config
>>> ./g2/mon_data/mon_L3_00/mbm_local_config
>>> ./mon_groups/m2/mon_data/mon_L3_00/mbm_local_config
>>> ./mon_groups/m1/mon_data/mon_L3_00/mbm_local_config
>>>
>>> Could you please correct me where I am wrong?
>> For example, we have CPUs 0-7 in domain 0. We have two counters which are
>> configurable.
>>
>> Lets consider same example as your mentioned about.
>>
>> g2 is a control group.
>>
>> m1 and m2 are monitor group.
>>
>> We can have control group g2 with CPUs 0-7 to limit the L3 bandwidth (or
>> memory bandwidth with required schemata setting).
>>
>> We can have mon group m1 with cpus 0-3 to monitor mbm_local_bytes.
>>
>> We can have mon group m2 with cpus  4-7 to monitor mbm_total_bytes.
>>
>> Each group is independently, monitoring two separate thing. Without having
> Right, because monitoring, the actual counting of the events, is per monitor
> group. When a monitor group is created a new RMID is created and when the
> counter is read it is per-RMID. 
>
> The event configuration is independent from the RMID using the counter.
>
>> sysfs file (mbm_local_config and mbm_total_config) in each monitor group,
>> we wont be able to configure the above configuration.
> I do not understand this reasoning. From what I understand the
> event configuration is independent from the monitoring group. Thus, changing
> an event configuration for one monitoring group would impact all
> monitoring groups using that event counter. This implementation associates
> an event configuration with each monitoring group and by doing so it
> implies that it is unique to the monitoring group, but that is not
> how it works.

The event configuration is designed per L3 domain. The mon_data is also
per domain (like mon_L3_00.. mon_L3_01 etc). So, added the event
configuration file inside each domain. We have all the information inside
the domain. Thought, that is right place. I am open for suggestions.

Thanks

Babu


