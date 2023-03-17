Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D12F16BEA88
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 15:00:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbjCQOAm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 10:00:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjCQOAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 10:00:40 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2056.outbound.protection.outlook.com [40.107.100.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D624912BCB
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 07:00:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f0CJkudvj2j6CMpjt4zUyo2eoyIewaXoMG+wFQKBihuB99AJ7kX13Nqs5U6uaOf1fzRRVLRSyLzfvr0qZxQKk0msEhzFT0yxCbBhHKzO7rB/UDV222y0e3H8A9qssdCihsszxGCU95z1lKag7L0wKt1/UcbdnJQEk1reWFOIphE09swWedKyyRFpJqq7BUHRPB1bOr9csrE2WW1CnbnhSchnXGtgMFGgWsU976ma23/Dl57h68ZWiBjENMkpvU2ZMcj7i3x0pOs/1fO7raZkP2fL+Da9byqrqQ1MzJCKkJDM5Ky5lMwgF+UYtvGxdSOhO/pO+GtKvTXbXQEDCoz8rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mgSe9oXsGjAzeKLsGpTW+b3uyngs/KyrcUQnjQ6l2+I=;
 b=DahnqaFh9MvUbxj2ZciyXACxU1b8L4sEoZKiyc4b8J067ixDSR4IJMBfMPIiWMJAAeGXFdRHHmp4L10+QY2X7xYI44WQFpVPjcjwdGEqwkcUfcO1Yo8QhVnPG2QM5cr+vCOmxkljtw+Vb8Xm6XLysSXsZ05YU+pzUjL9AA552AUQDWCJz5b24z+lPJTQE+K/IZRZ/eXM9N2Km9i5pUGFjGulF3yix5P4UK0HvnwJCa1My/WUWohLfaOtyMONdmKUapMDNPoybIvmABs3YPbzFcZxsX1HW/MuZbufNHuTFC0C8zhk1lPlJmlHXvt5ngFw0kLX4cwQZbxgvzT1HCct5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mgSe9oXsGjAzeKLsGpTW+b3uyngs/KyrcUQnjQ6l2+I=;
 b=lkgAymEP7K9uNyBRQQ7MR+JxHGa1xdL8riDmnjgqXAiweeOE4T5KkbeByQC8mgGkUV8A+Htkwi+zGuVOcfUiATZ6iOa7kc4umc9akmFgYY4J1zllN0RdYPYwzGMrZ2aIX6wqL+g7ulLztMcPkhGLYP1dP0mUQU2E+h8OPxjFVyw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4123.namprd12.prod.outlook.com (2603:10b6:5:21f::23)
 by IA1PR12MB8238.namprd12.prod.outlook.com (2603:10b6:208:3f9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Fri, 17 Mar
 2023 14:00:36 +0000
Received: from DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::e4f3:9509:c6ee:41cb]) by DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::e4f3:9509:c6ee:41cb%4]) with mapi id 15.20.6178.035; Fri, 17 Mar 2023
 14:00:36 +0000
Message-ID: <f30689fb-3fd8-b76a-f614-0aa2c4719327@amd.com>
Date:   Fri, 17 Mar 2023 19:34:18 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH V6 2/8] soundwire: amd: Add support for AMD Manager driver
Content-Language: en-US
To:     Vinod Koul <vkoul@kernel.org>
Cc:     alsa-devel@alsa-project.org, pierre-louis.bossart@linux.intel.com,
        Basavaraj.Hiregoudar@amd.com, Sunil-kumar.Dommati@amd.com,
        Mario.Limonciello@amd.com, amadeuszx.slawinski@linux.intel.com,
        Mastan.Katragadda@amd.com, Arungopal.kondaveeti@amd.com,
        claudiu.beznea@microchip.com,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20230307133135.545952-1-Vijendar.Mukunda@amd.com>
 <20230307133135.545952-3-Vijendar.Mukunda@amd.com> <ZBGTDXJvVjVuUkiZ@matsya>
 <7a7f5d93-d6ec-5ad1-9927-7ac4b6d9a643@amd.com> <ZBRsX7W4l1HyT44y@matsya>
From:   "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
In-Reply-To: <ZBRsX7W4l1HyT44y@matsya>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0030.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25::35) To DM6PR12MB4123.namprd12.prod.outlook.com
 (2603:10b6:5:21f::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4123:EE_|IA1PR12MB8238:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c0759f1-ce67-4829-7a9b-08db26effb3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8o1G6K+UqDEIZd5tzikuANIrfyjy/0q4gj4GpVZXrOldT2zq0h1xxBW44gHykx06n+hA9tnL1PLyRyZCwN0qjlHyrozQWCiWNkuLCJoof9VlLz3ayukCDud+IhPQnqz7Wjkq/zIrF/0vATp5Bz5PQO6K3S4Uc83stKQQJWWJiWDCzBXG070k0zKFM8CHOM6dELKGlYChQL1NR8Zg/JG+UUr3vCgcRZafpsVgK6ywgIeTwjpLAo4S1rpseOGZ4QO/Qoyag7rcAcyeaULbcpA3XpafdeN62syDJbfze551ytqWBl+dawU1lCE7zvznL4UR8VJbnwVPJCgvLY6zXZ6MMY9+jyq5rsupxJ7UjktC5V1yPRCh2oGiHWb5LnxNzZPCFVaoV3cbARAvu/jTQhTvifENQAWLxMUuOancveDI4kqmvaP9EQlsagsD6wu1dkf35SR64ZEbyIbrC3FEZt2FcLSHcIiOjwtF7S/vA6Z36JcbcWfm6V/IAJOIfggVARCiqaQop/25Sva7SHHUZsQA2vDAwUDd+PbSkKa40Ljgngv5bejGYIvkr5U5ZmF/BzM9aEEXQfCp5EwI8JBeozvJ9KRVEGmk0gIO4ai7cJ7Vt4UljGOKPIURUI4ja7jxKQSn7vM7av3VoLobrSNNhIN8BCzBGrd2M+MxqIKRqLPgeTsh34yousryRMIfDhIGCbu1g1BobNjMDsuEDFbklHv/yt7tBhk3Vu9mH5VRWrr5juU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4123.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(376002)(366004)(346002)(136003)(396003)(451199018)(5660300002)(38100700002)(86362001)(41300700001)(36756003)(8936002)(31696002)(2906002)(6666004)(4326008)(6506007)(53546011)(6512007)(83380400001)(26005)(2616005)(186003)(316002)(54906003)(478600001)(66476007)(966005)(66556008)(6916009)(66946007)(8676002)(6486002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dUVJQm8yZWhyL1NIRWJ6em4zYTRwdkxjZjlJN2xhdkxtcE4yZXRSZ2pRdk01?=
 =?utf-8?B?RnM0eTFXYXFCbFJEYm5ZTnlleU9GMUkzOHFDQUV1a0Z5QjN5S0V0NktxSFY3?=
 =?utf-8?B?UUtvNzhIVm1kTGljK0Zzd1I0VTAxd1JtRHoxSXRsd2pmeE5oc2dzZk5Ea05V?=
 =?utf-8?B?bkdxVGtid1pIaE5EcHBueXh5T0N0N2o1OUFMTE5icmtOYS8rMEpqT1J6aGNw?=
 =?utf-8?B?M0hRQ0o2K1ZqbWFBc3NkM3ZDdzR1WjVKUUtieFpjdGpjd1Y4eVNSS0IxR1lz?=
 =?utf-8?B?NTJPc2hPUmhjblRkTERhYVF3cXR4cmlTdEJEUDlHQ2Z1RnZ0UVNBQTlLT0cv?=
 =?utf-8?B?dXBFREQ0ZVgrY28zQ1VNbDNldUUwTGNXMDB0VHI1V1JQVGlCWnlDcGpsWkxp?=
 =?utf-8?B?dUJ6ME9tWkJtczFteG12WlF6MXRyVVhFSzE4ZzZuendQdlBiS1VhYi9BSlRh?=
 =?utf-8?B?enEvM3NEZExuQWtSR3dvZGNSUDdSVk1CcGhwV0pCR3B1b2xtaW5wMlVVVSsv?=
 =?utf-8?B?NW41ai9IZlFhcE1pbTNFTmd2aHlnT3VkUTB6RklTZG1ZVHJja2hJbjlBdHpY?=
 =?utf-8?B?YTNLUFUvVDhsc3ZvS095ZGxxWVBjdkNNK0hhOFhjeGt0SGJ3TnBxZHJiQzYw?=
 =?utf-8?B?ODdyYmprOGc1T0JXTC9ocGtINWFWSmpEUlFhNnl4cldWZ3FBRWk1clhoSTRo?=
 =?utf-8?B?S1RjdDBmZHBTeTJoSDZnZEErS2pKYWJPTWkxbk5yc0dXVzl0SFkxYzh5dTFo?=
 =?utf-8?B?N1ZZd2dCQzV0SzFmcUJxeFFLZmErWnlSSEk0Y3l2UlI2Q20wNHpsREZ4SVdo?=
 =?utf-8?B?Zk5zU3JVNFZ1TUNaN3lPd3Q2a2laYWNxeHVTbm5tbmw2UXV0WVQxV3lGZ3pK?=
 =?utf-8?B?dDRpRDM2R1kzSkJwV3RxemJnaUFIOEgzM015TFNDSkdOS0hzQUxtbmovVFJ1?=
 =?utf-8?B?aGRxNnV3ZGh4cktsL3diQjJJTU9Pa285ekVVMW9hU1Iwd0ZlbHdsQzIxV2pB?=
 =?utf-8?B?Z1lFSTRRSDBvaThlVEZLbklxb09lNlRYeWpHY1ppK2dyQ094Vm9BaFZCYnRJ?=
 =?utf-8?B?TkxXc0xDMXY1a05KQlJtRXJoM1JSM1ROLzFzTWlmeEl0MzhvQ01RL3RkVnRN?=
 =?utf-8?B?bGxpd1lZb2h1MUdPYXdNenBSZUpaQktVODlvaWZ2Mk1uckREMCtPOVpzK1E5?=
 =?utf-8?B?S05RRzBSVUxzQkYwMCtFVlU5cmtRdE5waVk0R0hyNHhnL3F4TnRKWmpkRlJv?=
 =?utf-8?B?dkVLQWJ3OW5sNmswdGJ3WEE1UVJiQmpOdHZ2aFZWWDJDRUFpSkdnZUh6eEhQ?=
 =?utf-8?B?Nnd6dEYvUSsrZ3MyWjdMVzU5UjNoUys3ZkFJcmtYNGM2eUJMMThYaGVSTWdt?=
 =?utf-8?B?TVZXQnJsUmc5ZGpMYkdmY3VQbklxSWgvc3JGQ2ZnTk80M0dtNlRLNmhWVStU?=
 =?utf-8?B?R1l5OStRZnljRXVSd0piYVhwSnZmN0dBTVBiUVYzOFBxNm1GZWdxc2d4cmJH?=
 =?utf-8?B?a25RRWs0N0oxbEVlbEU5OVdGdEUraWsvd0Z0d3ZROXJQZFdLSjF1Mnk1dys2?=
 =?utf-8?B?VHNpNCtJVWhmOUY1a2RFTFdZcjhReHhxNDlZcWE3RHRSMTUwMHhmeDhsQUM5?=
 =?utf-8?B?V2NTV2FFYWNUZmtGb2xHdUUreWRidG82UDRRS1B4ZExyRXJnMEd6enRSOWpt?=
 =?utf-8?B?TnB5U3I3ZVRGU05QbnpyMmlnWnlhcHRlcm5hSXEwZ3JpUW01akRBOWFRTlhW?=
 =?utf-8?B?dk40OHlyQ3B5Slp2Q0FWQUNlMWNhdjhpcHJwTXgvUzg3V0ppcVM5cXhCNzVM?=
 =?utf-8?B?enN0bVRSdWRZc05pbkNTUnVWRVZIbmJsemN2Nk1GazBqYndZOEJ4ZFVLTC9u?=
 =?utf-8?B?NG05NlBGRFkzUmNFQ0sxVTh3ejQvQndmSTZocUJQcFY4MW8vNUJLaHdkK0py?=
 =?utf-8?B?UFlML1dLd0xqRzM4b29FY1JoUnR5aVdtK2gzVXcwbjZucXdmT1dRZjVtTWI3?=
 =?utf-8?B?UzQvRkprbndxeFoveThQTUNyWVRXMDk0TmVZSXhodGw3N0VNbEE4RVBKZjJm?=
 =?utf-8?B?R3VXZnQ5Y3lQNFFJL0Q0dTlwZ0J5ZW5yaW5oZmJkTkNYK0tTR0kxNkduVWt4?=
 =?utf-8?Q?9nD2aikClezmPY5QKZqspGFYZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c0759f1-ce67-4829-7a9b-08db26effb3d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4123.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2023 14:00:36.1268
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EZUbEHJE2DihQbNMmz6oae4pb0HNIkgTa4FW4z3DGK6BAwcSfK7X0AlO5i8UhW5VcXyt3eZvq/XVHI9uYyJmqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8238
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/03/23 19:04, Vinod Koul wrote:
> On 16-03-23, 19:28, Mukunda,Vijendar wrote:
>> On 15/03/23 15:12, Vinod Koul wrote:
>>> On 07-03-23, 19:01, Vijendar Mukunda wrote:
>>>> +/**
>>>> + * struct amd_sdw_manager - amd manager driver context
>>>> + * @bus: bus handle
>>>> + * @dev: linux device
>>>> + * @mmio: SoundWire registers mmio base
>>>> + * @acp_mmio: acp registers mmio base
>>>> + * @reg_mask: register mask structure per manager instance
>>>> + * @probe_work: SoundWire manager probe workqueue
>>>> + * @acp_sdw_lock: mutex to protect acp share register access
>>>> + * @num_din_ports: number of input ports
>>>> + * @num_dout_ports: number of output ports
>>>> + * @cols_index: Column index in frame shape
>>>> + * @rows_index: Rows index in frame shape
>>>> + * @instance: SoundWire manager instance
>>>> + * @quirks: SoundWire manager quirks
>>>> + * @wake_en_mask: wake enable mask per SoundWire manager
>>>> + * @power_mode_mask: flag interprets amd SoundWire manager power mode
>>>> + */
>>>> +struct amd_sdw_manager {
>>>> +	struct sdw_bus bus;
>>>> +	struct device *dev;
>>>> +
>>>> +	void __iomem *mmio;
>>>> +	void __iomem *acp_mmio;
>>>> +
>>>> +	struct sdw_manager_reg_mask *reg_mask;
>>>> +	struct work_struct probe_work;
>>>> +	/* mutex to protect acp common register access */
>>>> +	struct mutex *acp_sdw_lock;
>>>> +
>>>> +	int num_din_ports;
>>>> +	int num_dout_ports;
>>>> +
>>>> +	int cols_index;
>>>> +	int rows_index;
>>>> +
>>>> +	u32 instance;
>>>> +	u32 quirks;
>>>> +	u32 wake_en_mask;
>>>> +	u32 power_mode_mask;
>>>> +};
>>> Does the manager need to be exposed to rest of kernel or users of this
>>> driver, is so why?
>> Currently, amd_manager structure being used in ACP PCI driver
>> (parent driver) and Soundwire DMA driver.
>>
>> In ACP PCI driver, IRQ handler we will use amd_manager structure to
>> schedule workqueue based on soundwire manager instance.
>> In Soundwire DMA driver, we need to retrieve amd_manager instance.
>> As per our design, we have fixed mapping. We need to use same set of
>> DMA registers based on CPU DAI ID.
>>  i.e if AUDIO0 TX port is selected in amd_manager driver
>> then we need to use AUDIO0 TX registers for DMA programming.
>> we have included comments for describing mapping in amd_manager.h
>> file.
> Sorry not sure I follow, can you elaborate which members of above struct
> are used by PCI driver?

ACP PCI driver uses "amd_sdw_irq_thread" structure member which was added
in below patch.
https://www.spinics.net/lists/alsa-devel/msg155118.html

amd_manager structure "instance" member will be used by ACP Soundwire DMA driver.
>

