Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55326620227
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 23:10:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232300AbiKGWKM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 17:10:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231705AbiKGWKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 17:10:11 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2059.outbound.protection.outlook.com [40.107.237.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 063B51E71B
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 14:10:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GF+tUI3e0viKLtfwM6/olnmb/UX+WWaf6qmftAMjp5M/IIeGKvs5I/syj5ErR6Hk7L+JpowPC70UU4ah4Ez91xyQu/ly4s411woEtKxxjm+xVXLDEL6B6nFZW5T7GpTLWycZaS90dRXBPu77Gc4JT9VAZX8HcQzfy2J4ExtVSeJr9CmYZkOiEnAgRaaK1nAKX80cIQn9Ia7rvmg2n09VsCwG1NLW4R2vVk34n5dEY8FFL1TXBdO5sltQDckUdtPWLcsdNtMhYHfuvzdl/DXzsJi/O2eBZd4vAVQOi0uYWX3skRw9Tsi0TRgFwAtTRE6hsnsOrDGfu/+08YtT527CnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OAk3FpUbSBll9nq7yL6sBLGfrQ72xxi3ctyKhQeQ4f8=;
 b=BvLnWyrEZCOsau4+yOTiUfdF5/66nI7fu4dNdJd2tNxAoB8+fudKLNDT0VT+bk1QHTHLmWt+uKYZHXt/MW+3cWbt7AXtBre4MAcS56O5A17LQS18HoZhfamUg8Pvy2z7Jmv7niVEvin+qGSKBbU2o8xHFbtrmCl3tHDq38oT57aWyVIEhPm9QI1amQsAkqcPoCjWH3q3YIwIEmo7EFvw+g23k3pzWxRj+rDU89ULOwxwBkSFvOJjv8HTjMiPyAP7CwlyNYhZGI3PrxrGCFXw3i+suCKHxOl/72RblmDcGmE8E481q7Nh7qmQ7Kb7Co3+Glf5QCgN6O5m5+cmN1ASNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OAk3FpUbSBll9nq7yL6sBLGfrQ72xxi3ctyKhQeQ4f8=;
 b=q2WNg4vqz+QCB4ApJAPLga8Ay6w3bTjturJIbOPCnhlDOxK58rqrXcErys6Gr33FIgray/Dp7Gc825qPL5H9HPnlM1UC9oyjigGdtgXc1jwm0MlmwrEUFYYec0MIxvSkqZ5JWcS1YJqwO1QNe+i4hQYVtDUjXFiQwGiIpM9HoFQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by DM4PR12MB6279.namprd12.prod.outlook.com (2603:10b6:8:a3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Mon, 7 Nov
 2022 22:10:06 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::4da8:e3eb:20eb:f00]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::4da8:e3eb:20eb:f00%2]) with mapi id 15.20.5791.026; Mon, 7 Nov 2022
 22:10:06 +0000
Message-ID: <6bfacaa0-bb12-3f14-b8da-ead25c8df292@amd.com>
Date:   Mon, 7 Nov 2022 16:10:04 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] virt: sev-guest: Add MODULE_ALIAS
Content-Language: en-US
To:     Cole Robinson <crobinso@redhat.com>, linux-coco@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     brijesh.singh@amd.com, bp@suse.de
References: <ff480c5e688eb0a72a4db0a29c7b1bb54c45bfd4.1667594253.git.crobinso@redhat.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <ff480c5e688eb0a72a4db0a29c7b1bb54c45bfd4.1667594253.git.crobinso@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR14CA0023.namprd14.prod.outlook.com
 (2603:10b6:208:23e::28) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5229:EE_|DM4PR12MB6279:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c45742e-a98d-4c24-9ff8-08dac10cd3c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BDj9KXbzLZAjm6fFGveNCh372ziiAFmLGKpLs0PqjoSkBbsgf1OGly/L/7Q8i0XfKzazh2CjDSVndhQB4kfkKQ6EZiZs8fo3hYaSzLgmGD0N3fjt7NOxgjqxwOgjbK9aYdPiSxnsL4aHBT7KE8tp1OhgebQ7cViHxp9ro5yTxBcnA4MKMK+nFStZ+UfnBS7GJgn2X+nW1vvKm3JJMcJdOkkeP54y1b20yPi/F5Pkxi6RQ/7Hl6q/DIl9VpGtBqSHLVtXlLidx51E4RNKIqG3XSQR+A8p5SjSSbMmm2vhr3fnLXHA2O9x4rCWSp/1vp1Sl40tqtDrRM/pms3c0PFsUBUK0SXJtBhIcOQ1px6TiLBf0bght2hNWkXLESO9Gzfz/Kx8tujELglZO7sEcLE/AnbwIuwLQLE/UqrJUFKUegiD237UV10Yh6Y3dMp0LJd/NTlNDlkMNjzD1CG8mvfx5L57kPAOx443rmKsT/y8xcn89bVeTqXh/IHrg/FaY3L8PVBJCM7ma961EK21v3BcHf31rAD9ba3N5f7S7tzqJrtYV1TBvnuilQp/uBmkDMGrlONZr3UkjbSo9tTtnLoEcSGNB/UQc35Xqj1d7XZyTMc71Qc3IgHCLtW8XI5LDDvWNTyVp4uNHb8TQ1GyAna4JWWF0J5aZg+muZlybX7Ed93YGV06RDT4NJyCuotVgxH5gSICtYOVVfbqBpTmxkuGs4AenwM9bUXYhxYM+8LZtWDSTVIBICFdjxw767y3O32dlcNyZtTLfFnO5oQezDEzQv0KZFPWZ0B1mczWHg9VHqQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(346002)(136003)(39860400002)(376002)(451199015)(36756003)(31686004)(31696002)(86362001)(4744005)(2906002)(5660300002)(26005)(6512007)(186003)(38100700002)(2616005)(6506007)(53546011)(8676002)(4326008)(66556008)(66476007)(41300700001)(66946007)(316002)(6486002)(8936002)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S3pNa2NBZUdUNkVLdTNIMkx6MHRiVUdScGRDUUZKQ1hwRnVsS21ncVB1dEpw?=
 =?utf-8?B?bFBublBML0t4R0paZ2FJUytyN21IY0N5anBZQS8vOUNza1NMeldtZHhNSWFE?=
 =?utf-8?B?Zm5hTFN5WlU2VVBmNVUwNCswU3ZOL0d1d1F4S0MwU3F1amhTMGJpbWduVlFE?=
 =?utf-8?B?N1YyY1o2RUc5a3k2OWhmc2FtOW1UVWhEaks2QmNkSmNiQkJNbHQ5cW1nOHlS?=
 =?utf-8?B?U09qMUtSRlVUNUcyQkpUQ3UyT0NJRWN6a0gyemF3V1FhMFFxay9RZXJRb0Rp?=
 =?utf-8?B?eW1uVjBwZVJ6Q0NRaDllQXJZYUxNL3RFWVhiQzhaQTJpS2tXK0hKQXZQL3Y4?=
 =?utf-8?B?WkpWbE1sV2RQZEtFVzZjcnVOVllzSnI2RHZuSnd2ak9iQ0FyTUxKSUJ3aDQr?=
 =?utf-8?B?TDdzUWFMcUdyV1BDd3h5TmZvQjlFc3J6Z3VXWDRuY1ZiZE9keUFUUUtJN000?=
 =?utf-8?B?dXRtRWtSUERyTGZtdHFxTWRWOXhnUXl2a2dnaGtaUEwxUndnWndBejdIdkU3?=
 =?utf-8?B?bHg2bGEvUVZ0ZHJwVnJDWm1meFQwanFTb051bm9mU25MWTJNUDdIbzdkcWJa?=
 =?utf-8?B?Sks4NEo0ekhyVXd5UFYyb0lOc1B0azVTZHU5Y1M1MVhERVh4UUNwd1c4REZw?=
 =?utf-8?B?bUxBcTJ6R3Nubmd3eXcrQlZnRWkza0QraE0rTDdrNGI1eWl4V011Rkt4K1p0?=
 =?utf-8?B?TGdzVU1JVWlIODZwMmhkYTBjb1MrdTZTZXVobGZjK0wxdk8zbTh6d1BHUHdo?=
 =?utf-8?B?WTRQa3VqUnQ5cEw4ZUFtekNXUVJtSmdGcUlwc29QOHZKS3NIcFBRTkFDbTUx?=
 =?utf-8?B?WkdMNGNKTytBbkVUY255eGZha281MXg3WE82cWF2SmViNlpQSWNRZnZSL2RF?=
 =?utf-8?B?SUQ5NUNXU1NrSnpvUWYzakhYZi9rSmJqc3YvWVRBRk95eDg4eElYRlBBaUVn?=
 =?utf-8?B?ZkV0QXZVOEV5dlZaSGNrZXBiaXhVQ2UrVXlzSTFnWlNPY3Ryc1NkeGttT2h0?=
 =?utf-8?B?UHg3V3RuSml0dUJmT3J1WGw5Rmt0czJKY2g2SDJvcW0rS3lEMU1lc01oSWNX?=
 =?utf-8?B?ekhGMXJLVVZkcStKMEUvNm1OUTR1WENoS0F4QmNiRHVMVW5YckZRSTNpK0xi?=
 =?utf-8?B?QlM4d1Z2a3NtSlJRajNVQXNxQ1ppN2FxSEQzbm5MM3JlcTVOYzkxZEVhMFhL?=
 =?utf-8?B?WEYwd0JBZExURytGL2dtSXRZVzd0ZmdGWGZVRzJiQVRYb3VkdDhsVkxQL2JL?=
 =?utf-8?B?RDh2NGR5MzN5dmRxNlI4Uzd1TDVBdGlHSWZOVng5eUEwZ1d0Nlg1Z1BJNzlm?=
 =?utf-8?B?bk0vT3pUMVNzbi9HNTR6SWVUSjdScWhkd3Q1Y2VpVSs2bTJtSnVZYXlXUWpR?=
 =?utf-8?B?QmhlWCt0NlJZWnRWNE1uQXBjYzMxRHlCbkRFZmZiMEFiNStVUm9HVlBTeVhj?=
 =?utf-8?B?OW9rdldaZFN0TlBWeW1JL3hQVnNqZWwzMUtvYXFQTWtWUHV3cnZhYlJkQ01n?=
 =?utf-8?B?WjJHWmxHVjdxN1cwb1RNSUJ0VTgyc0xCbFNDTWE2U0RlZERxSUV5M3ZwTUZh?=
 =?utf-8?B?RGxsNE1KamQ3MkdObWllOXFUY0xjeWRsK2VXUDRqbHpSL243UTZpNVFXV204?=
 =?utf-8?B?RFZxeDdZR1J6WFNOVzN2d3FTOWlwelF3NlUrZnJ6d1JpV2cyWEhYbUVZYnFa?=
 =?utf-8?B?VHVqTEZVOHdNS1dMNFY5V2ovbnJkSVBpOGM1YUtoYm01ZUJTREpmNlRTK1pq?=
 =?utf-8?B?dXYyZXRRdkZXVDc1cVorS1NZRS9LU0lrU09WbVArZldIRGt0OFBTdUlyZTBw?=
 =?utf-8?B?eHdrYkdMQXlsd1BqWGFVQTNTdTNlaEkybGVSdERsYVlPWFRiaWU1a3h1MWRZ?=
 =?utf-8?B?WDNGc2psVnI2anV6MGFKd2xoSXhqNlFtcS9rYmZXL1JmU3RBOWgxb3BIQXBi?=
 =?utf-8?B?SmtIa3BMT0dHQXJ5OW95UHg0YXIxN1diWURTeXVRK0xuSXE0bzAyakJrdWJL?=
 =?utf-8?B?Y2NYbmYrWitpbzlpSkU1VHk2VVVJOThoYnpOY2EwblhqUzZ4Q2pYTDQ2VHdG?=
 =?utf-8?B?TmtqMUIvZWhCSTJ5amRwdGVGRDBSSU5CZHZiWTJ0TlkwTzdVSCthbVNyRmo2?=
 =?utf-8?Q?nAf8c/8wGUUxXJXt3rHYEPA+g?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c45742e-a98d-4c24-9ff8-08dac10cd3c3
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2022 22:10:06.7145
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qtiYgs348PFCOnLzVMXE2xrRtu0S6UoNjHaUqls7OLfxT38/os7bGpYYl2UfGPF1CsOjOFCz3tk/3ly2MrPH1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6279
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/4/22 15:42, Cole Robinson wrote:
> This fixes driver autoloading
> 
> Fixes: fce96cf04430 ("virt: Add SEV-SNP guest driver")
> Signed-off-by: Cole Robinson <crobinso@redhat.com>

Acked-by: Tom Lendacky <thomas.lendacky@amd.com>

> ---
>   drivers/virt/coco/sev-guest/sev-guest.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/sev-guest/sev-guest.c
> index f422f9c58ba7..4c426dbcd166 100644
> --- a/drivers/virt/coco/sev-guest/sev-guest.c
> +++ b/drivers/virt/coco/sev-guest/sev-guest.c
> @@ -744,3 +744,4 @@ MODULE_AUTHOR("Brijesh Singh <brijesh.singh@amd.com>");
>   MODULE_LICENSE("GPL");
>   MODULE_VERSION("1.0.0");
>   MODULE_DESCRIPTION("AMD SEV Guest Driver");
> +MODULE_ALIAS("platform:sev-guest");
