Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEE356B6CE0
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 01:45:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbjCMApT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 20:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjCMApR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 20:45:17 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2084.outbound.protection.outlook.com [40.107.93.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40EFD28D10
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 17:45:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G5kEY2Q2v8ziIz5fGvzvAWKFn+z07p2lThU3Uw2a2y8nndiFFmIDw2hf1ve4U7hjMivKxF7W2lO5Mr7bw1xe4FSfRBlRQEzT6s/AiXYgDXA1Rz7MjVvxjQlyC5TPYXKtap8dIolegTF6dm2d1RlhPgX98tTQ+K9a3z74cm1eFM9n4/aSZJTRt+KKI3iu3ZbvCFD6IvVIydvidq1cwc7aVDZ1UJCz1jjUBnHLH9lD6bP4lQamD1roJuQeJmAPoThqAjIqy1sxI/PvKzZuddt2Tc6KWjudVMSqgUKsEEktlwMzy4grzvNe6HPkV9cTuR9jUMmM40fdnhlqzOPWYQkV0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tf/tYSMabuDqTjqC1eeHUQDha6ybue+x7XSrGrnJIr4=;
 b=l3tnD5HBomOc1oIlQu88BNQE5Id3pU7fT9Qvg7GE0dFcybzFkU5JYdbXAKCDguL10cD/aDCL4rgZZ+MNwrYQXFqxwvrXwvpr4Z6Lw09XrwzDLdwv/z3aihDCEycMNfxUQCNwV0gV+5O3/WJecEkZTuWfgX3fWdD2uKD6ClWld82aYJoM7XJfkauXVk0inDZY76amk3i/1twI0xzwNy53A9sRL3po988G8g6jiA2g8IbjT0R6ESlPM9HtPxsvCb+lW085uHg1WouTqm3xvYEHpSvL+f6QqVyKGMYaC6w1X/wkzGfDP3Y6yi65l7S07XZCzLkQ7Yq7LaR8n5dL3Qgg6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tf/tYSMabuDqTjqC1eeHUQDha6ybue+x7XSrGrnJIr4=;
 b=I+pC3AbYkddcoK8kKA4/AUqDCBn5+pxxRpf6p9yS2SCG1vlZ4YEEtSakSoLVOy7q0vV383uXWuUgfC9vdJgokTIoZ/R23dPD3OoG2ZAQvZyCpxwXQhhgvia5SJbKfyRA8I+T7B9n+cnr49CE3bZFHxQeWZZpXlMP8L9nDi0ix0Ye9XRpiJmIeqJoEoxJOsSIdUVYWwl+H2cHwGCTxqX5X+hbJhsfK6ZXUfyW8Np3jFQFWmoSXOLvQBV/84eoeEBYxE/4e1VSo7BJlfXOwuvpFbpfPlx7SmIpEQq/HDOVIlBoM1nEsYr9eSMk4rxUrIetXZPLWI4ZgozP5Prc66zjLQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by CY8PR12MB7414.namprd12.prod.outlook.com (2603:10b6:930:5e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Mon, 13 Mar
 2023 00:45:13 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2dea:daa3:6051:1f43]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2dea:daa3:6051:1f43%7]) with mapi id 15.20.6178.024; Mon, 13 Mar 2023
 00:45:13 +0000
Message-ID: <a5f8ae02-85f5-b98a-5900-603f189ccb85@nvidia.com>
Date:   Sun, 12 Mar 2023 17:45:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [RFC PATCH v1 0/1] possibile regression in the mm_types
To:     Vincenzo Palazzo <vincenzopalazzodev@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     jgg@ziepe.ca, Liam.Howlett@Oracle.com, david@redhat.com,
        willy@infradead.org, akpm@linux-foundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
References: <20230312224150.425382-1-vincenzopalazzodev@gmail.com>
Content-Language: en-US
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20230312224150.425382-1-vincenzopalazzodev@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0054.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::29) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|CY8PR12MB7414:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e7de942-5184-4744-fd14-08db235c34ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1cZ4EFCzmT/nXrYeVcdZhReLYqOG24CzDN07xRSeXqqhFc732FNpEoUkmmtPBd0b1y4/JzK+wiOwRm8ABI2KiskbcYBcnBnbY5czBqSd2P5yPAvWb6q7ZKx7vYiXPcCDLt8gCluH1/bcZnEbaD0g2aRDqs+yA5xCDtW7loW0nUO7vJiv7nM60idGQjueM98VTox5C+z8wsS1JgFPg9uv1oYTlqAQNJnKSaO9qfqO61MzMjS0tAA3I8wwqEq5GsMxYX7ni1ot0iaRu9lQnSomzetMBLr9eLIptUOEk9s5wJlxqlE/Gy0YNnEu049TwDHnixZ3f6DfrjuPR3/CKbOTiSdyGQm3+BlBICgN7pmpPYAG5MG7T+MQnyyUtVQDDPAWdq2G4SxAVNaFxSF41CBIA/OsShhvR/MRob6fGWDXZPckrcp3kwVe0N/g27dstnsEeGeRV66WEoriH5HOHv07QvYcNO7ToQGRvvwBAAMdh9rnI6HUWLBrqKXExJThZiWOAWYBd/PlHC17DxppDtSDAcLlCr2iAbeoL1TgIuLpjbxN49rcJyZiyG1CEpCp4g9aemXuGD2MzX8plhwQKhTeIkws5RKsr0iLVc3gPrFroWaYHDMQWXnV7Pjq/grCzh3O10qYYt9NQ9JGu2tb/7kYCtRtfPGZlh28ew3u8reTHYtOYi1HarFfQO3KtkXJWPUQCFL90VIBVyfaWhRTqc+ScLzSV92UokiBJrnsCea4MJo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(366004)(346002)(39860400002)(136003)(376002)(451199018)(2906002)(31686004)(83380400001)(36756003)(5660300002)(66556008)(66946007)(41300700001)(8936002)(4326008)(8676002)(66476007)(38100700002)(86362001)(31696002)(316002)(478600001)(186003)(2616005)(53546011)(6506007)(26005)(6512007)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VXIzdGhlZ05SeldjQ0p3a3l4dzBCdWlvdzE4WXdJUk5Cdk5ZVDJwcHU5ei9F?=
 =?utf-8?B?bTc0QlNHVEFiRWViRjlPOFZ2VVlXaVBNNmVoazRUZVprSHlnTStMUG00bjRs?=
 =?utf-8?B?SDFNc3VBelVNZm5hSDhXZ1NOek0rUGJYU2oxZmJnbHBWbXB2dFJScUNiMUll?=
 =?utf-8?B?RE5OR24vbDFINHZIQUs2NXB6Nm5TYVpRY0UyblliNjF0YTBCQ0lUMEdIM1pM?=
 =?utf-8?B?bnpRSEc2dHRrOStmc0V5c3VoTzdNZXF0QUNsR0ZJVFFMa1hTNWxSZk85b1oy?=
 =?utf-8?B?aDJBT01wTkdTTHRaQXZ2VjNtZ1B4RHI0MlBHY2UydWRkYWtKU0wvV21EQ1R6?=
 =?utf-8?B?NFZMaFM4Zzg0dVJWTVNVTWdNOEFyU3ZoNU1heE9Fd3NzRStiSHVxUnNzbitJ?=
 =?utf-8?B?VUdnVDhyVEdKNE1SOFR6RHFPWW5LV2VaQTRYOC9IcnBCQjIrTGlYd0I1c0E3?=
 =?utf-8?B?WHBucG1Gb1RlNExMaHYyQlJhNDNaN1NWTzFRelhkekM1dEppNEplUExRbVFh?=
 =?utf-8?B?TDVsZnJ2c3I5SjJ1cGZYcVVTMXBEcDVqY1NrUDVBUzBkYjN4bUU3V001OXRv?=
 =?utf-8?B?YzJ3ZUdkU0phdGYxNjdjS1lOOCtBb1AvdzduMXlIZ1RqZnRaTkZIQ0oyOTd6?=
 =?utf-8?B?T2Y1SmJlN0xFK28zOFg1TTlqWGMrNVExRG1PV2orOVJURE0rT0lkT0JZaVhI?=
 =?utf-8?B?Sk5OZ1JyR0dDbEg4VC81UjZrS2t5UXFaQ1laai96VFZvVGlSMXFQSDJibkw3?=
 =?utf-8?B?TnZRTUxhQlBEaVZpKzNzbnlqbTZWbGFvQU5nYmU1VVFYeFVQOXphZFoyczBJ?=
 =?utf-8?B?emIvVHFWUWdjeUphak9McEErNUlEVWtnWmZUa3Q4aHQ4MUtVVy9rcFJmYnAw?=
 =?utf-8?B?bllqbjZsTUVvQkhXWncwMmQ1R1M5bmVrZ2JsMVNCcnYvK2NMTjhoZUFkVDM1?=
 =?utf-8?B?UnhJYitsVmFycnJmV1hIekZBa1VsZjB4Y2VtdUEvTmRlNC9lTjJlVENvakpi?=
 =?utf-8?B?cTM0ZkpHUFh5S1pSdnJwUnJhK3drblVVd0FBVVZiRjdtMUlGNFdYRU9pSlR1?=
 =?utf-8?B?N282LzVta2djQndCMUh6Y0JyTTA3MCt1cjNNTk9oVXBEWUQzMElFMlZNbHV3?=
 =?utf-8?B?aXRIWnZTUFliM2hsc0h1T05zMXFzcmpGdkttUG5UR2tQeGJVQURZTFRWeFJx?=
 =?utf-8?B?U2JGWXlpLzA1VzZKV1JQaHpMRzRZU1dVTDgvWjFXYiswVFliRVNXaGdWRDNN?=
 =?utf-8?B?QXpGamxyWHpIaTRrQnZ1QTgvU3d0NzNiblBCS3pFdW5rQ1dzUzdlRUJ2QlVl?=
 =?utf-8?B?Wm5NQThmdUdCVGpwMkhTRjRxbWF0U0NrSXhhRHBJNHdiMFhaMU1SVkE3N3NC?=
 =?utf-8?B?bzBCMytSRXVqQnF5ZUdpOUFsSmZrT3lWODVpWXMxYW1YYmVpZ2g2aXJKV3VE?=
 =?utf-8?B?bmUyekljbitocVp1Q2NzRGpzR0h4Y3VHL1ByNnllbysrQThCUklJKzJ4R2lB?=
 =?utf-8?B?Q3k1UlZ4OWppUGNaeldZSGlNWG9Uc3M4cDkwSVh2UVRXN2hpcm1aTnl1Zm9J?=
 =?utf-8?B?cit2NCsweDFxbW1ZQ3lscHlHcGw3UDM2RTVrdFQzV3AxdnpNK1gzcTdlOGxh?=
 =?utf-8?B?bEszV2tWRE1RbTZTeEgwcldjVzN2VTZuZVBwYkllajZ4cjdFdC9lcFovbEZx?=
 =?utf-8?B?TWJxdnA5UmRRQzFIbGFPTHMyMjJSM3p5WkJYQjcyOGdGS0txVlV0ZEZKeGg2?=
 =?utf-8?B?MUsrODZQSHl2WFhXcURMTzBsK1V5SGd5VkltVUhPemN0TlJ0cTc4M0xVbmRs?=
 =?utf-8?B?WDFZdklFU1p5NFV6ZXgyK0U2SWUxcUg0V1k3QWdWd3dGVW01Z0tGaGtTZzJm?=
 =?utf-8?B?aXFyTmRibnE3RzlpbDcvdzRiQW9RWWdtY3pGSFFxZ2IzU3hCREdySFFYT0Vo?=
 =?utf-8?B?UUdKVWEyUVFiNUVnTUlKczRndU8xRGRpTEtLVlpEVG5zd2xaeWtOU29TejB1?=
 =?utf-8?B?OWFTcXBKZkFtZGo1SlFYK0xoQjRxZVdhVHdsa1NVUmYyenYzbnlyWEJSVktN?=
 =?utf-8?B?MHhCT2tmN216WS84eGxxL1J3YUIzcWFYM1I2R1FoaVY0bkc0c3N6ekNiakwz?=
 =?utf-8?Q?xBC8QnXLaPoJR+9pjm5daMSgp?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e7de942-5184-4744-fd14-08db235c34ca
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2023 00:45:13.4144
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A8ZdVs71iVdtuS/vnllXB2uDF0YOFU1I4JkhhWWHHXM6yWG41s7QV6xznKbndKqozR73kkAkViq6iVo6hkSXNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7414
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/12/23 15:41, Vincenzo Palazzo wrote:
> While I was testing the last rc1 version on my build machine
> I noticed that I was not able to build my nvidia driver and 
> also, the vboxhost/7.0.6_OSE driver while I was building [1].
> 
> So I noticed that this change was introduced in the 6.3-rc1 
> and proposed by [2]. However, I think I can miss important 
> around this change,  there may be some motivation to 
> have the `const` constraint here, 
> and this change needs to be done in the out-of-tree driver 

Yes it does. The out of tree drivers are responsible for keeping
themselves up to date.

Note also that this is an -rc kernel. NVIDIA is generally careful 
to keep its driver building against released kernels, but with -rc
kernels we often just wait until the kernel is released, in order
to avoid too much churn. Most customers don't (and shouldn't) run
an -rc Linux kernel anyway, is why.

Anyway, no, we don't patch the upstream kernel for this kind of 
issue. But thanks for thinking about it. :)

thanks,
-- 
John Hubbard
NVIDIA
