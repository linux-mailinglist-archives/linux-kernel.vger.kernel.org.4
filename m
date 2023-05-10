Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6145D6FE320
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 19:16:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236375AbjEJRQD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 13:16:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236662AbjEJRPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 13:15:45 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2066.outbound.protection.outlook.com [40.107.92.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D943211E
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 10:15:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k3IGKIjvkokETzhPiaKfptK1W0p2/ceRH62B6TmKpdIM5aTHqHb7YUpKmCH7g9lKhw8p+a1Hd7nYzMoJNkaedLuCO0ajQy7UobgBZEl+8cwRmh//JWoTpg6HljbwxnD9m5F6v9mn5nlICqHk/oCsfYI5TC58wy5/jl/mMlmmc/ubsutGM+475KSZpTuTwQ3wKJfCgB0nGZ2tOSj1AUGEr8rfro1mDTv/WOg4kGY1kuHyZcrNHUXXbzP5//sv/bZC+6aOafGbFBV4UaBOfxQY2EjPrgfIZj4XMVp1Gp4rtK+8xNwaLEvMJE9Wi6fIRHlnfsi/gH8LZ2WKTH5lto8n9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oMnD4I3WP7dMMQrfnmclAkVIpn14O7lIw1NcWQS2zjU=;
 b=j/cyUE9CzlMWYJOzZ/RRN25bOGb2iCP/B/nx45bRpxKHM/fwSlfGJz3eUR/AjqkDg2Mw6tP7p5fnHBLw5tIfBARjGpaMfSjwn+bMFogXYEEOOiYIDgFEPUn9bdkk8A+0xOa+uW/LFQ3RZc6WNlubJudX2AOQXekSuq5bueNAGNo2yOW5uBjfCND09YGH3z9y9bjoUkhCFfY6QdGQ8e5eRDOJ95Gf5JSRl98UjWVnPLNTnSAqBP0/I8VsOPdkTvaft+mT2ly5UdZ+AD2eBPfSYo6Ibs5r8z+HecKPpxcNJyC8SiMdmtmFUuALfY3s+boC1kT1HXTSqZwsYEcDpslZvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oMnD4I3WP7dMMQrfnmclAkVIpn14O7lIw1NcWQS2zjU=;
 b=cYPK9EeYKNJ06jPrQDJ1xV4ldVnCQAPdNO6iKgQV6a79ve5sksCWjN6Wrt9+AC8L+uGMr9tlcl5wdo7ytiIvUEDvD6SM/2QATQsUpelFrUN9ZqDh+4UqkQdnersL2g7quzrT11X2hn3rnIzFGXDZRTPV4jbPT3nMiXMGlkFfkKD7xwnE+TixO/EymCFquTyNJ0NmYWqiuQ6pZGWPtoTFazjykngU8xgMsYI0y90sVLurxcMJAcsT9Az8eF9QCmE6LUFDz6Jwaw5918dPacGWO+HoMeSmbgKpjI4ndXMhhjE84eFLU0WrEqrNHpVX3K+sihu7sxiuV4p66Z7ZZXY87A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN0PR12MB5762.namprd12.prod.outlook.com (2603:10b6:208:375::12)
 by DS7PR12MB5840.namprd12.prod.outlook.com (2603:10b6:8:7b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.19; Wed, 10 May
 2023 17:15:33 +0000
Received: from MN0PR12MB5762.namprd12.prod.outlook.com
 ([fe80::df7e:720:b6c9:df7a]) by MN0PR12MB5762.namprd12.prod.outlook.com
 ([fe80::df7e:720:b6c9:df7a%5]) with mapi id 15.20.6363.032; Wed, 10 May 2023
 17:15:33 +0000
Message-ID: <6daa1fbc-0d13-8f09-6f30-d11c899c038f@nvidia.com>
Date:   Wed, 10 May 2023 12:15:30 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 3/3] genirq: Use the maple tree for IRQ descriptors
 management
Content-Language: en-US
From:   Shanker Donthineni <sdonthineni@nvidia.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Yujie Liu <yujie.liu@intel.com>, oe-lkp@lists.linux.dev,
        lkp@intel.com, linux-kernel@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Michael Walle <michael@walle.cc>,
        Vikram Sethi <vsethi@nvidia.com>
References: <202304251035.19367560-yujie.liu@intel.com> <87a5yuzvzd.ffs@tglx>
 <ZEsiYbi8dorXTI5t@yujie-X299> <877ctw5mdp.ffs@tglx>
 <ZFdbtipfTsIF0u6z@yujie-X299> <87mt2f2mhm.ffs@tglx>
 <ZFtGvfDFLyHeFVFH@yujie-X299> <87ttwkxn96.ffs@tglx> <87r0roxmvu.ffs@tglx>
 <e1c50a59-f85a-02bc-6b48-fceaa390b2ad@nvidia.com>
In-Reply-To: <e1c50a59-f85a-02bc-6b48-fceaa390b2ad@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR13CA0177.namprd13.prod.outlook.com
 (2603:10b6:806:28::32) To MN0PR12MB5762.namprd12.prod.outlook.com
 (2603:10b6:208:375::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB5762:EE_|DS7PR12MB5840:EE_
X-MS-Office365-Filtering-Correlation-Id: f6b55c23-f07d-496b-07ee-08db517a29a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AxtwB76KmPyewMVC2jHOZcFj59jMNcO9CkkolZnEMqsNFHMNf4V2yAH6JqV5hx7l79b9ScCl722uoMdKoIPeIobw3DH19zVK/iYpCeKxp8MkAMdX27wvoaflYAuqXRfUdm19LJAhSf/ImuAgSmLJpIAaAVH5kzStm7Jhf83QjwcNEp69EHKC31IHh23jdFPlYMX4q+05cLPWOF7NbSHeXImqKSwNR8AkSZZcccF6Ez3U5IENs+W1Payc8CrL8itdEcWAmnnorpXs3sOBLK/EzqzQZOBqochr7+R2dk2KQKsg+kZEVISMHaXDzb0n2etrQWIlWbbaz9pbMJel1/MCR8AYzQjSuvp1xSH3aYxriM3i1kJy2c7J98T2eNEIF3goM4s76ObYQr2VQvjOXszabvn3DF7IEMvm+9/GSSh8HXCxGG30CK6eA/Q27u6jxaxKbPeHwlG8RfNWGUpjuJorM6SYOqxfFfLb4pBeyzuDIQEI4EpdUyDxBwShHhSufz/lZINT3zuwfFsozM2AJw/GuoX/3XdXjInnSbQKR6PrQO7l9mVZRY0mXP4sU/SX3X2sNlecF/oQlYG5HyDYujDGGuvhtRBjUkC423yJA5gCXm3Zh7dU/9pKUxIIQN1vd0cuTCW0otF2ab71qYnj7r341kh/QiVM1WIFparAt0baNp/+BWa2ugnxvPYFzxcDRIXOPSzFu907O5t4usuGRcB7SVJnVtsPRdod+zIqEPA0ihc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5762.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(376002)(346002)(136003)(366004)(451199021)(38100700002)(966005)(53546011)(26005)(6506007)(186003)(107886003)(6512007)(2616005)(83380400001)(36756003)(6486002)(66946007)(66556008)(66476007)(316002)(6916009)(2906002)(4326008)(31696002)(5660300002)(41300700001)(8936002)(8676002)(31686004)(86362001)(54906003)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QnBrZ2hGSVZ1TmMxNUdVUzFvZHB5T2lFMldZVHJ0TXArbFBpbW5DY3BaMWVL?=
 =?utf-8?B?NVVIS3NmdGNRSEo1RzBlQllVWVNoLy9ZMnZydStaeWQxLzhUektXWEo0d0pQ?=
 =?utf-8?B?TWErZk8yU0pPbVo4RjVqTFB2T2dnR1JzZU1wV2JlSzlsVGpYM2JjY0NlNzNl?=
 =?utf-8?B?YnMzN2F1R1BNbGFEUDBXaW1wOWRRSHM3clNCNmRpa0V0Zk5iVHhQMDNWSEVy?=
 =?utf-8?B?bjlZZmRXN1ZGcDRweXVXa0VQQ2tuQm04cVJaUy9JY1VKeUx2Q3QzRGUzMlNM?=
 =?utf-8?B?TVlwQ0xQYkp1OWFNamxnelI3aUN4WlQwU1dyZ05TdFZHZldXK1M1V0VTdDc3?=
 =?utf-8?B?U2dCOTlEVGJEMWxGUnNoajBRdzdERjFDTDJ2S01jTmtmTkk1Z0U1WU5WcFhE?=
 =?utf-8?B?dCsxaDFwR2xBclVqU2JXenFsQ1lsWnE3NG5ybC9zMEFHakhMcy9BY0FtcjI0?=
 =?utf-8?B?YWRsaCtBYkwvZ3FRRFFwcjB4M3VjeWRuT1E5Snl6UFI4K3hqa1NxbzViRTBl?=
 =?utf-8?B?ZTB4ZWhESG1MaTJqZC8vaWZ0OWQ5S3NxWDVvaXlxc08veTlkZk1QMHl4S2Zu?=
 =?utf-8?B?WXh6eVRlZGZKYURrRC8xYUIwK1llSzdFaklYL2gvUWZNKzM5SlcrdUlZMVpB?=
 =?utf-8?B?SjE1RmRxYTNRbytRdHNnR0dBbmI5NlFRc1ZiUlRPZUlzbHhJMlJ2d0Zza1RM?=
 =?utf-8?B?ekZIbW1wamlxRmoyOGxiU3I5QTY2VXhtUGhkbjJxd2FJeWRUZVN5czRMUDJx?=
 =?utf-8?B?Um8vUmpwV2pyQ01ndHp5ZFY3SHdVbnJuOGc4NXdET1ZYaU9saGxubVNkbHZO?=
 =?utf-8?B?Q0ZvRkRreVRzQXE4M3NyWllrSmoyNWdvNFNIbGwyT1FsNDN4NTNiT2JjMDJi?=
 =?utf-8?B?V1RJOTdrcG1TRVg2ZndYNjNpM0Y0eERCSW11NXZyYzMxZEJjQ0piWnIrSUNH?=
 =?utf-8?B?NTRZU2dDclhiUTA5SUVzSXJCY05iNnlxMlVTQVgxQURtbEcyTlpWZmlBS3d3?=
 =?utf-8?B?aDhCWTdGS1N4QWpSOXkxOEJTcmQvUlY2WlU2MXZ5TXBiT2hMajZXMEI4OTlu?=
 =?utf-8?B?aDN5NFhZeUFKNWduMUtrbEVFVkFVbEZFaTl1bThVSmlyaDlYVmhjTHh3Wnh1?=
 =?utf-8?B?bmNqaFZSK01pS3dVelZ6bFJvZ1RlOWtNVVNGT2pBaUw5MzhRbFlDTG8zZEFy?=
 =?utf-8?B?M3dJa0d1dDA1ZTA1M3Jha2tWZWF4R1BzSVM3Mmp0L0ZwelU3Tk9MTDVHTkV5?=
 =?utf-8?B?WUFVNzV5TXFvRkF0T2NOZWxTN0JDNktNTTM0M2dBMFRPeXA2c21Qeko2dDdX?=
 =?utf-8?B?RnUyKzk0a3c0Q2NPeFBQS0hNSXZmelVZMFBVMGVZNkkzUllYekplNWlTZzQx?=
 =?utf-8?B?UFlnMkpmZFZKSGVnY1FOVlFNWWJOWU1uTkVNQmcxNFdHWHp0ckdhSHc0Z3lN?=
 =?utf-8?B?SU1ZV0ZuSVNDWFFQbUJrTGlKR0NHZkMrUy8rTnU3UjJzdnlKQmMvcXpBS0xR?=
 =?utf-8?B?UlBIa1BEajh6cnVveXNieWtCNSttcnMyS0k0VTZWbnpyUFVYT005Uzhlc1Vm?=
 =?utf-8?B?a3h5R1hYZlppeEpCM0Q3UVd6RnV0dW0zdk5uSzZSSnR3U1pFKzF1YnFaUUEw?=
 =?utf-8?B?YWNPK2RDckJydXhYUTJiUzNOR0dhYThvUHFKRUcxMEJqMDEyYVk2WENpNFdp?=
 =?utf-8?B?ZGhuYWUxMEFJUmdCcjVaeDB6SWpBaSt0ZnhadmhDZFpTNUxPSll2QmtIUW92?=
 =?utf-8?B?cVB5N2xKTStmNUJvTjhlY1lpMUQ1OE1vWGFBZXNmQ24wOCs4U01EWHB5bm40?=
 =?utf-8?B?RXlhVXZrUU1Qcy9lb21VaFZhMjhyeE1FWm84SDFvL1c4VUJVN25nblJkUFJu?=
 =?utf-8?B?RTArTlQ2Rkpza0lmUnNJYWdsVDZOSlQ1VUpYOFZBams5WWl4OThadmo4T01J?=
 =?utf-8?B?YlI4a2lhNjhlL0czSkRhbFlTNlZSSWM2T1U4T01WVFZXOTExQXB4WndENTlJ?=
 =?utf-8?B?Mjkvb0l3RWN2YkFucUcyVzF3WHV3NWw4ZjVyR1A3bW0rUTZnbjMyaHVVSHhX?=
 =?utf-8?B?RGFBM01NMStQRE42UXB5UmdzbEg4ZkkrK0NuMGtFd2tNQXBVRVRQVEtScFlI?=
 =?utf-8?Q?Zn6jVTg7dAEc7W+sJwuyHloUo?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6b55c23-f07d-496b-07ee-08db517a29a4
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5762.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2023 17:15:33.2393
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rah7WECMYURHGPmkSmw86LESskckEhvGj3NQtTzqGh34O9opzH2a/79UzJ+PllFHamY5D2UfUhJ48ZzJr9ZuUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5840
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On 5/10/23 10:19, Shanker Donthineni wrote:
> 
> Apologies for my lack of familiarity with the maple tree data structure and
> not testing all functions. I received advice from the review comments below
> regarding the iterator. I am looking for your guidance to address the issue
> with the iterator if not possible can we increase NR_IRQS for ARM64 arch.
> 
> 
> https://lore.kernel.org/linux-arm-kernel/875ydej9ur.ffs@tglx/
> 
> static unsigned int irq_find_next_irq(unsigned int offset)
> {
>          MA_STATE(mas, &sparse_irqs, offset, nr_irqs);
>          struct irq_desc *desc = mas_next(&mas, nr_irqs);
> 
>          return desc ? irq_desc_get_irq(desc) : nr_irqs;
> }

The problem has been resolved, and I have confirmed the functionality of
CPU hot-unplug on ARM64 systems. I have posted v4 to fix the issue.

https://lore.kernel.org/lkml/20230510170033.3303076-4-sdonthineni@nvidia.com/T/#mfa8e2a5490f275cfecb2e93473c24f35db7adcaf

I have made the change of replacing mt_next() with mt_find() in irq_find_next_irq() function.
  
static unsigned int irq_find_next_irq(unsigned int offset)
{
         unsigned long index = offset;
         struct irq_desc *desc = mt_find(&sparse_irqs, &index, nr_irqs);

         return desc ? irq_desc_get_irq(desc) : nr_irqs;
}

-Shanker
