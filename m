Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0FFA62FCD0
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 19:31:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242821AbiKRSa4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 13:30:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242726AbiKRSa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 13:30:26 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2071.outbound.protection.outlook.com [40.107.237.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CE9330569;
        Fri, 18 Nov 2022 10:30:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MaoD+rWO7fhjZK0AcHgxk0hk2VNAWQgAtU9dhlPDBugY1V5i8vDR0VPchSgmAeR5v4CQGMzsoNOPusY8GDpVHxWIO23KHW3ceK3Tez8fc08WSlGtR56NhsX25JGt6kK+wIEziuSMNOOkSl8lOi9Ww9p+wCpplOT1aikHzklMG/UCUsXU+fI5Zh15ylN2g/Kezrds/f/1pmsIqfPwqlNW/urIYBhYBHBDRetYv28EfB2yzH+Hdgeky9A7u8tr3JRzCZ/j4LuvsU8/5Web6eHc/aX9IuCWLZF71iDORfQxWa+EST5Tpbe2Z/eYquUgkMg4Sru7yDARZ7gyvFsOBNF1TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mv/MQK/YpGvrGsjRPSni1bNh9pMAvWO1yUfA3/o7HRM=;
 b=RNDVW6gaMt8e5Dyc4GKMw1c+unY70oDzNhT8DR/03pkGqMbf/NWSFtww8R3XBLMyx6WtxWAcIVARxIiwzi/mtBr3RxZMfhgnsGN6xp996Diuxl9mLGGV9noa/yETRIhmzqY8O6dggn5iilj3mv4Xtrix3GWfucRb4qYxjc5ihNCbZf7+whUd076x8QdPHdqpyD4LzZjg2+jMNfg6n6SIqq4MZfSf4IiUVc+DuFVPKg2Ee7v7ia3fgZHov8xRr+cui8jy1gENFMRQeouyddeAlXj+ltXHLew3w0Drudj4pByHC6crxf1CFHBIz2KArWFomLwYpENQ9ravHAc7vTFogw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mv/MQK/YpGvrGsjRPSni1bNh9pMAvWO1yUfA3/o7HRM=;
 b=in9mpcHEPvsiJoCVmhYc+BiB9YS52avD8CWJdrFnlMn2KePDDYr/gIIUpUvKmFHfONGg/8JmuXUciPuSlYd/8r/UOQOERLAXwt0zEetooDYW0W5WyNP7x44dzVgapmB8/fTKb9fQrJ5WCv4U1dSaWRXTQcxaP2mT4go3o9WibBU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5874.namprd12.prod.outlook.com (2603:10b6:208:396::17)
 by LV2PR12MB5726.namprd12.prod.outlook.com (2603:10b6:408:17e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.9; Fri, 18 Nov
 2022 18:30:12 +0000
Received: from BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::9eca:d454:d407:7ba2]) by BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::9eca:d454:d407:7ba2%3]) with mapi id 15.20.5813.019; Fri, 18 Nov 2022
 18:30:12 +0000
Message-ID: <30c2065d-7f40-4170-9148-37b70b1ed5b7@amd.com>
Date:   Fri, 18 Nov 2022 12:30:11 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 0/2] kernel-docs: New maintainer and Spanish translation
Content-Language: en-US
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     corbet@lwn.net, lukas.bulwahn@gmail.com, Dhaval.Giani@amd.com,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        bilbao@vt.edu, ojeda@kernel.org
References: <20221118170942.2588412-1-carlos.bilbao@amd.com>
 <CANiq72=ANWtA+64O_sZu2r6XzNKnR7Sm_pXEW7XBtSUFYXPNVw@mail.gmail.com>
From:   Carlos Bilbao <carlos.bilbao@amd.com>
In-Reply-To: <CANiq72=ANWtA+64O_sZu2r6XzNKnR7Sm_pXEW7XBtSUFYXPNVw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR01CA0020.prod.exchangelabs.com (2603:10b6:208:10c::33)
 To BL1PR12MB5874.namprd12.prod.outlook.com (2603:10b6:208:396::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5874:EE_|LV2PR12MB5726:EE_
X-MS-Office365-Filtering-Correlation-Id: f90d48b9-d2de-4325-a6c2-08dac992ee5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dym4k1+jBB1TMoMxZ/2V0n7TV+1JXqh0eohpHP9kTGPkgnQRChi1IF19h+C3IypP8gu2SbbchAwhPU65HC3u8MD8FaF1y+Z0BeiJnY5Q2tHx1q2Kt5Kfhd7de2sfvnQLHpwnm7eviALBnDpBsShXbY5WS7XW34mTW6HgQa+6o/KxrpmvXGigxKuM5H45ascCtO5CS+E449f1+IfKwPcKTlqYrIzqV8buGtXAiLZ64VPnLzHM7wao4QAOOGcwM0RDBS/b/oskFz2wvdthvGZL5FLODSoDK+opljus50a7X5zr33Q6iaj9mtPVPP5titDZiQYNHG4IEThuHSoZyUH7M/2bG6JlVo6Uq/B0CFG1UtLebTnXKGfZB+i4otuYLM4uZzwI5Ip6nQlerZpKhta0GO/peqa7nQjQA51RvoKZVfDHkHkxjnQy+52l78D4q5RmNVC93kRSdL0r8Lixx0pXANp036nczDXfTA+xmYf8KP31Vas6xTlw0sWr4BF34ZRF4mI4q980wNtiABCQ+MoFwuQ3xq0Wa6TMEzIgGAo4ogGcx4/sNikF/RCDj1/nIOrxUusBoLbfeZpheYPU3CvSSrEoxVhX5Zk6/fquWc+rEVQ6DqUWfVpd+LYYBUkfU4h6j5uzASGCeYifZs/IxkqujewfeGSkmkR0SRqIcLW82/BlU4KTgiSRjyPI3D5YruoPwbg9PoCiZknaqhRmeH7GMUIvgwgjo7G2iHG1IA5DR3U=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5874.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(396003)(39860400002)(366004)(376002)(451199015)(6506007)(86362001)(6512007)(478600001)(26005)(53546011)(31696002)(6486002)(31686004)(36756003)(2616005)(186003)(316002)(6916009)(8676002)(66556008)(66946007)(66476007)(4326008)(41300700001)(38100700002)(8936002)(5660300002)(44832011)(2906002)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YnVuL1lJQklNTGk4YURMMUFZelNEQlg1NUtidFIyMVlDUXZBNDcwQjU1UDhP?=
 =?utf-8?B?UEQwNmlKUTFpYTZ0Z3JEdkJnQm5zcXJ4a0JIVENCb2pEU2xGTFNvdFlKaHJm?=
 =?utf-8?B?UUZJR05zbXBPRzUwSWhnZ2RER1BQbFhkemdoWmU2WjBpV3pBem4vQVNPVndB?=
 =?utf-8?B?TmkrT1ltU1FXc2NhVUJkVjFUWE5oTUJzek1yYVVhZ1JwZ01wZCtKS1YwVmVy?=
 =?utf-8?B?N1Q2M1g4ZkhNY2NGV0F2ckNHYk8wTTdIREZhSHdWYWZrTEZXd2VIb2x0Z1oy?=
 =?utf-8?B?R3NBdzc0RWZ6d055cUVZb0o1VnhqWXprNlBrVHE5aTZjWkUxekVzajZyekNx?=
 =?utf-8?B?UzRnT2VLYkhFOTZCZklyQWMrMG1XbGxDQmh1RDg3VmZMb0FQUHZ5aVdVTEND?=
 =?utf-8?B?THBzTklENDJQenRuZ3N6OXlxNWJHMDR1dVVnRFB0N2l4bkFqRENhQVJ1QU5U?=
 =?utf-8?B?MmVDNFI2aVVIY01MdHpmZXJKcFgvY29IQlFmNzZsamVRay9QWGJ5WXM3NUtX?=
 =?utf-8?B?dXpLb1RvKzhPVU4xZjVLUzlFQUlCL0ZCZkRIeHcwQjhwZm82c2EybHlIdkdm?=
 =?utf-8?B?OFdLRHAxd0NhQW9sOXhuQ290c2tvM3JORnJvSWZIS2d1SGxTM3NOamVyUEJE?=
 =?utf-8?B?L1dDc0g0bzFwbmErdXZ5L2N3bWxEMHowRThrVVYvRkFSem9FZjVYeWlFbEFQ?=
 =?utf-8?B?c0JCWHkzNE5lYUw5UVYxekFWL0hPSzZSMUhHZEJFdnk0U2xtalJYV2hyNmN3?=
 =?utf-8?B?NnlzaUNCSnVrMDRtQTFNZk5BeEM5bExIWHRsSXpQZ2VyWXp2dVZva0JtaHls?=
 =?utf-8?B?UXF0azBHbDlGTnVHNUNnYUtYTkwzN3RTWk1pbk1QTGwxYnBEd05YVTdoVVZB?=
 =?utf-8?B?RkJWRkk5VjlsaE9tV2ZtbXNyUklicWJqc3BGRHoyYTVJc0JqalNZSzM3THRq?=
 =?utf-8?B?Uk95cjFja0pJSXFHNXdxK2o3R1RJMUVpWkM2eHU0THJYNExZOFhXRGRQTHRK?=
 =?utf-8?B?VDNQcUhHcXNCa2hQZ3FSNjZvWWtxWFA0TzJnTWl5aFNlQk90R1dzekxsZDBN?=
 =?utf-8?B?MlR2b3EzRURrTUR2Wi9LcW9zMFNudlFUVFY2dVdXRGpvcFhvNkpZTnV5MUpy?=
 =?utf-8?B?b3MvaFgxSlVHSkJXQlA5K3lKMVRna0dmbHZMM1haak1OTkdTNXJtWmVTdFhj?=
 =?utf-8?B?L0pWQmRWajBWM2VRRDdRUmZiYjhsenV3Lzh4M09qMWlZd3BjcGpTcnZnVkRx?=
 =?utf-8?B?UWpBbkRnTE95QUdsREdsQkc1VmFWMWhuV3RIMlNURTdxTkxmT1g5NzZicnpG?=
 =?utf-8?B?cEZ2VnpFQUEzQko1R0NaNjI5RDZRZzJCb01ZejZIampEK01oZW9iWTF5SSs1?=
 =?utf-8?B?RlZ0MjJOMjdVZy9qK0pPNXk2ZWg3MFZobm8ycFlWbHRWdHJ3amxHZXFMZlNo?=
 =?utf-8?B?UURwU3lyYnFsckZkUHg3aExKR2xYWk1TZlpsbXdRbEJlbEtMbzcvcm14bUpr?=
 =?utf-8?B?aTRPRE5zNUlVNHdyZmdMNnp5YWlDNTN4M0QzY0pkNVZvYUhDNVBVUWNkVy9T?=
 =?utf-8?B?S0Q4d2RKRWJDcy82eTh0UnFwY2xpTTZJV0pYRlFzYTIxdzlSQWpwdndQSDUw?=
 =?utf-8?B?UEltZGZrd2RwZ2cxRnc0ZlpNd04vNTkvL3h5dlJFWmVnalQveDFGTFFpbWVU?=
 =?utf-8?B?MVR5TDdzL1pzMG11cFlXQy9RQmNQa1IyVEY5YmttT2d4cThWT0RHemhuSXZD?=
 =?utf-8?B?N1dkN1hOZlpla2Z4UTRPdHVLRWpKRzMxVWg0d0JnNWxyZllTdStNVDNISk9h?=
 =?utf-8?B?elEzcnlqSzA2d2cvaWRQRkFrUE9YTHlsZnJwNFBiaG05M1FOTXFEeTJVckk5?=
 =?utf-8?B?bHczeXFXdHM0Y0VTMmduZkYvVEtOUzh6NWxqMUtmbUVXeHdtMTVTanlUc2FX?=
 =?utf-8?B?OFJrWTllS3JwTzduSE4rNkdmUHhkbkJOK296WHdHa0VOLzh4Tkp6aDA5WkdV?=
 =?utf-8?B?N1pVcVhjbzBFYk5xK2haNmxrNmpGSm8zWkV6Qllsa2NQekdjMTFJWEZpWDhi?=
 =?utf-8?B?TnNIZU1CR2xPaVZ1cm1URDFLR0hmNHBjekVXbldmdGwrZVhBbmZPU3dGRFdH?=
 =?utf-8?Q?qeh/GhYaJA65adQIp4Zxnwoes?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f90d48b9-d2de-4325-a6c2-08dac992ee5c
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5874.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2022 18:30:12.8597
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MNXPoZ5AGO/UaNOBGxDlymTPJMqZDA7GWIuqQXwy+k7a0BvfDdJsBDWx3SX2OGRQuX256HVSxpCeUqX3Kpx4rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5726
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/18/22 11:56, Miguel Ojeda wrote:

> On Fri, Nov 18, 2022 at 6:09 PM Carlos Bilbao <carlos.bilbao@amd.com> wrote:
>> This is a cover letter for just two patches, but I should provide context.
>> I was going to translate kernel-docs.rst when I read:
>>
>> “Initial Author: Juan-Mariano de Goyeneche (<jmseyas@dit.upm.es>;
>> email address is defunct now.)“
>>
>> I figured Juan-Mariano (CCed) may keep a Spanish version of the document,
>> so I searched for his new email. He replied back proposing me to take care
>> of the document from now on. I will carry the torch with pleasure! This
>> should also make Lukas happy [1].
> Maybe some of this context could go into one commit message so that it
> is recorded in Git.


That's true. But I don't think if I'll be able to synthesize the whole
story in a few words. I could add a Link: to this first cover letter.


>
>> This cover letter is also a call for anyone interested in adding new, more
>> up to date references to kernel-docs.rst. The document has been abandoned
>> for a while but its original goal is still important.
> Indeed, updates would be appreciated!
>
> Cheers,
> Miguel


Thanks,
Carlos

