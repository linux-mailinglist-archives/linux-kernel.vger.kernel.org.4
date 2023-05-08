Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A3306FBAB8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 00:02:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234400AbjEHWCA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 18:02:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233787AbjEHWBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 18:01:33 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2072.outbound.protection.outlook.com [40.107.237.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 581784EFC
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 15:01:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VPQX2ZWz3+Pws7UyHDC+QU5ZLocP27TNnlsFhnrYnP7UCpRGtEiHIa8i17mmZiDHvT6t+rs0P62pndbco/zxoVqtIsQJDUIwZrTy0GiSAhH/7f2LsBXMs+zvCMwBY44VE/mK4DwOQn+VFbZzh9aiU/+B/GjX/hwmCT9tj/JriWTl2Ks+7ZkYAv1hxreD5Z4d5kecWQWvLQt/kahFdw+8xBgCMZN58g3hfbAfxy5ZC3wUgmooIJfoUzjsLfn6arCw8I8HWXj+XSc4ghQEkOmvkcT9U3w5KV+uHbD/xO7xQOUhyJjXApfagcJ4jmQnc5cIL3gO35+WIG9c5yBVSoqA8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/c+Vot5DLYpT1iETaw5nX3OBW8JphxDeEa57HBXVC2E=;
 b=Ke6H7grrJWxK919keaK4nNcMKgcuuAsyAASA8hKGiV9RLc/oIP+xg6vXtzeUmbKKkbtz8eC97cRNLOjEmv/r9mWQPCA3X1+spYsT9eai/fbop6a7901Fn+SAjeYBJRt6YGkmnGi1pVv95gvYisHlaNOKoFgRsuozWPah9Pz2WY9klfMZ/sgjZCkTBcWEMU9I1g6It/y2yXSqS7/+qa11mLWzILRQbTo40JhKo1jC8FNLN7C20xl0oXRuGdme9JTBFmp5wIa7GWHsVgmdyGaOH1IwfGUqlYafsg98bpSuzvMLwAWOlMD3LI2AajSwPuxCFneVkJwcBHTYD4ltihBpqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/c+Vot5DLYpT1iETaw5nX3OBW8JphxDeEa57HBXVC2E=;
 b=4rNAUEc1QKeBLVfAxeJaQzy0M0IgMCVAKYOHpTyLX+OUkAYU09ZTJd0lILjXSyuhppg1rOBZgCMV0el+/jvzaJa7EQIsW2WcbbodP5/qH/i7oRDqAvY4UbbkBV+OkTs3PlMmPbaFXAr6XLJMVLd6HqITlF3Kg5LW0uvOrulaU6Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by SN7PR12MB8057.namprd12.prod.outlook.com (2603:10b6:806:34a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Mon, 8 May
 2023 22:01:27 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::b911:e5f7:65a1:5ea2]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::b911:e5f7:65a1:5ea2%5]) with mapi id 15.20.6363.032; Mon, 8 May 2023
 22:01:27 +0000
Message-ID: <864f265d-08d3-88d8-c0c6-263ab0e10813@amd.com>
Date:   Mon, 8 May 2023 18:01:24 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Cc:     yazen.ghannam@amd.com, x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/amd_nb: Check for invalid SMN reads
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
References: <20230403164244.471141-1-yazen.ghannam@amd.com>
 <20230403193245.GCZCsp3RjNZFSE5f9s@fat_crate.local>
 <abc57738-6ab9-50e6-6c05-5059299d19d1@amd.com>
 <20230403203623.GDZCs4x5yVReaPVOaS@fat_crate.local>
 <a8826972-376a-5af6-8e61-d74520e355df@amd.com>
 <20230405180648.GEZC24uJ+GSMZxczaW@fat_crate.local>
 <05c682d7-bddc-d990-37fb-cd1779f7e604@amd.com>
 <83d4ad40-4812-0583-ba4a-da3e79732e51@amd.com>
From:   Yazen Ghannam <yazen.ghannam@amd.com>
In-Reply-To: <83d4ad40-4812-0583-ba4a-da3e79732e51@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0214.namprd03.prod.outlook.com
 (2603:10b6:408:f8::9) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3108:EE_|SN7PR12MB8057:EE_
X-MS-Office365-Filtering-Correlation-Id: 979cd729-3c9f-41fc-a6c4-08db500fc52b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5IwphhgxXxyNyoyo9rClGUsQm2r+YARtRi3PrCQaY47eQYs38A4rmJrbfEYly700qGoY18Mtx5abjOXr/PXBxe4nvD9vkmoZrWeVrKntyo3CEuGsW+9W00Pdk0qdsPLxIh2kw/FgbBEYEX1O/GU57MjwvuVkkkLx4zVBqeXoBcjNcHzPyzIsGlv/wyRsDDy0dvxRbcQNGTd6mPXhFG+cq2dG8zEyGLkedQDlG8K+GGthnGM2u9vrx3woNN9TTQ1TxsucRr1S84xkiLywmITOa7alM0qaS9Hsu4iwmnimJCcTSyRLEci7ReCUqrBq00yrKuInFj0exZYs7VAGv/p7SfSb7r/dXh0EV0CpSkcd00mm1h5Aw0KH15i6avTT3vf5fzhZFLJ+9y/rNkohmmorUGBYxVhB1DrG4nJFgEU3rNcFMOQpRWUQ6n5FuKk8r30dPi6fpmW8kI0hnGOgR0otvoCMFEXENGNbvPNNqI2oEggaA+U2HQwyjCON6YhrQoYLDKLbSPh83BVO8//fCsTSvb1Qiay+yF4fSsWIra5gTyDJRi5cr0zGnDA5HOP+kl2EL9TBV4A0k0WoXZUsowi/jJnZtvxJxl6b4jo+QD/8iexXlf+5x4BKh0RpRB3T9uxYTZ2ZPf/k9Zssi1xIyDWrhw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(39860400002)(136003)(396003)(366004)(451199021)(36756003)(86362001)(31696002)(6666004)(316002)(4326008)(66946007)(66556008)(66476007)(6916009)(6486002)(478600001)(8936002)(5660300002)(44832011)(2906002)(8676002)(41300700001)(186003)(38100700002)(26005)(6506007)(53546011)(6512007)(2616005)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ekNQTHFkWFRJMHRHcmRpYkZWb0k3c2Y0azlCMWRlUDVOenlGVjdUZFJVSkpq?=
 =?utf-8?B?b2xXMzl2cWVwS1pIR2hreDliMUVvL3VDcWVPeE82RHNtRnRybHo2OEd0YlJy?=
 =?utf-8?B?T1NWRkF5M0pndkdGK0cvN0h1bWNZK25HMExOT0taWm13djVRSzRVQnMxR0R4?=
 =?utf-8?B?TGVWMjkzbXhRUW1YRy9yTUpLcnRSa0R3R21vdlZCalJwUnRwSE9QdUtFUEc3?=
 =?utf-8?B?YkowajJ6WSt3c2VmOE9PSEw3cmQrVWEwUWZ1SGZycmpXTUVvdHdlRlM4eGh6?=
 =?utf-8?B?dUs2ZjVROFR6T09IeGo3Qk5BOTlNWkQxUUtHOEUvV2lEbTIzMTlqNExCSTFa?=
 =?utf-8?B?U2JRREREK0Z5RFl2Skh3Y2NZK2xYaWNRWDFDeXBpRitmSUVRQVJzSmZJMzZV?=
 =?utf-8?B?QWJyZ0VuVHhvQTAwOWpmeGt4UzBjUUNnRm12M0VnM0V2Y01ZdUJTbWJnU0k4?=
 =?utf-8?B?ams3ZXJPb2NrdlJxWmNQUyt5YjRZd3JjT1FFdzBWWlJjckRrdUhWZDdrQlZx?=
 =?utf-8?B?MWlGa0hmNWFjT0VEWXc0STFoNzV0SXVkL3JGejZSMHZrdE5PNFlFL2h0TDdP?=
 =?utf-8?B?ajRHRWZBS0Vja0l4dDkzSmdadHBsSDBlcitvZTlRSW94MnpyanV0cTVObXdx?=
 =?utf-8?B?RW1Rc3V2SkNvaGF5R1YzSFludE1uT2ZrTWsvajdDV0h1NGR6K014a0J4b0Y4?=
 =?utf-8?B?bWsrUDJsK2p2ODR1ZC9GeHVkaHlKOGwwSDd1aTJ5Q2VEYlIvZEtBUUN2VGUz?=
 =?utf-8?B?NnExeUxpNmVoVW5BalYvcDFPQ1F4MkpuRm1taEJTWThNTWgwcVg5N0h4UDYz?=
 =?utf-8?B?L3pCWG5aYlpMN1NiSXZSRVI1MWY4VnlCZm92SmFaVHpRQWlaM0sxVnNyMWww?=
 =?utf-8?B?ZHhPNkpBVXhvamdTM0dtbjgxY1hQV0xUWm92WUJQcHJzR0NjbkpsbnpPY28y?=
 =?utf-8?B?YktCU0tHTzcvRDBnTnZHb2RCY2hDR0RQK21tbituNHJEUWQwak9zbTNQWGpx?=
 =?utf-8?B?SklBQmNTb2MwSWF6bU5LN0Z3ckJTYmNyMlVWQnpOUHVZZWhDTDR1STdkK0dH?=
 =?utf-8?B?Wk5hT3UvaC9ZT3MzNjd4NStsTHBvanRSbFo5NDF1NXg0VXdoeGVJbkltV1hT?=
 =?utf-8?B?YkhHWUVQUU1zR3JLY0QrbWVTZzM4Ukk1Qm9TNDJPckhSa1k1WUYyQkx2elNk?=
 =?utf-8?B?UTVLcUtOaVJ2ZU90dXJObVdWMGQ4ZnpRQzVXNUtsZ2xKSUVGSElYQUVCUlJD?=
 =?utf-8?B?ekR3R1EreUY1c2UwOEU1eFgwdTYxUVRkZ2F0bStZbzZERFFSdksrZW9nbkVh?=
 =?utf-8?B?ZFhVRlJFaU9XTmIyR1pOWmtpU3ZjQmhaT01VTjZHZTRpZTNYWDlBNGFPK3l4?=
 =?utf-8?B?emVhZlkxM0lqcjJuMjJXbnUzOUIvUk9KaWxscnRIT3NITmdwckYvYmNvNWRI?=
 =?utf-8?B?ZG1RRWVwMFJHL25BSlpuOUlqSDRlRmlzNnNNcy9uWGZLaFJyakhkTW44Tk55?=
 =?utf-8?B?OTFhY1IzZUg4UnVDdk80cmtjN0NiaVpxaHFGTFl0N2VldDFhbFJ4Y3AvRnh6?=
 =?utf-8?B?dzRtcUlReE4zWjhWN1J2S2tXV1VocVdraDBFTDN5VGpQdFNFZCtESDF4YmJy?=
 =?utf-8?B?Nm04NzVlUXFRdWcxKzR6aHV0aHlhUWFvR20yR0JYU2VDMllKSUlRVzUrZlQ1?=
 =?utf-8?B?RHRWV0VqTHRWWXYyc3ZheGxjMHpFbDQxSkZSODRubmtSQmpQZXNNeUFiK1Np?=
 =?utf-8?B?OHpNV2JoMUJGZ09CMVFncEZuaTdSaXd5dWdHaThZZDE5MUJOamhwV2hzNWti?=
 =?utf-8?B?OHhzQlQza0R0SEZOcnZLSitwQWYwYzhxNnI5QTRtUW13b2YyeEVlTm5va21t?=
 =?utf-8?B?SFRiL2FEbE16NzRqV1FoTGdUN09sM1dnRGdwUzBNbnJmZGlndUJzaDhud3l3?=
 =?utf-8?B?RWd6NTNxZzBTdVNCREZ0RllUUmF2cnhDZGdGbVMrNGNXSkhvQ0dma3cybnJL?=
 =?utf-8?B?RXNKVmhvOE5mdzlWOGRkTHZhRStwZUpER1JlZTFuL0U4M3U5dVl6MlE4VXdE?=
 =?utf-8?B?c0x6S2pZWjRzSnBQbDBsbTZ6QVMzT3JSaUs2M1JhaWpXOStpTGFhN0dpNmUw?=
 =?utf-8?Q?cCb+O8AtujFadvbzylXjY5BS4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 979cd729-3c9f-41fc-a6c4-08db500fc52b
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2023 22:01:27.1790
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gyyB/iT3RkOGHCr6RvpW0/KbkCoYx67BUk7+VY+Iu5uVulETmMBY5Q0r8WzSvIsRJ1zB7ASU6pHxHcdVvM8K8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8057
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/5/23 3:10 PM, Yazen Ghannam wrote:
> On 4/5/23 14:32, Yazen Ghannam wrote:
>> On 4/5/23 14:06, Borislav Petkov wrote:
>>> On Mon, Apr 03, 2023 at 05:36:40PM -0400, Yazen Ghannam wrote:
>>>> Yes, that's fine. Should I send another revision?
>>>
>>> On a second thought, I think we should do what you said in the write
>>> function too. Because the write can fail too. So if it can, we need to
>>> handle that potential error too.
>>>
>>> Care to send a new version which does this check in the read and in the
>>> write function? Basically what you had initially but with the write side
>>> check added too to amd_smn_write.
>>>
>>
>> Sure thing. I don't have a real test for the write path. But I'll test by
>> faking it.
>>
> 
> So I thought about it for a bit and quickly realized the "write and read back"
> method isn't robust when done here.
> 
> Possible issues:
> 1) Bits that are "Write-1-to-clear". In this case, we *don't* want the read to
> match the write.
> 2) Bits that are "Read-as-Zero"/"Writes-Ignored". We can't know this
> information here.
> 3) Bits that are "Reserved / Set to 1". Ditto above.
> 
> I think all these issues should be handled by the callers of amd_smn_write().
> They should do the "write and read back" check themselves, if needed.
> 
> For #1, they can see if their target bits got cleared.
> 
> For #2 and #3, they can check if their target bits got set as intended.
> 
> This matches what we do for rdmsr/wrmsr. As long as there's no #GP, then we're
> good, and the caller does their own checking.
> 
> The "PCI Error Response" for the SMN read is the only check that would apply
> to *any* SMN read. So I think that makes sense to do here instead of at each
> call site.
> 
> What do you think?
>

Hi Boris,

Just following up. What do you think about the points above? I can send
another revision for whichever way we need to go.

Thanks,
Yazen
