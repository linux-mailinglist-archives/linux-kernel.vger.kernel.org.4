Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FA7C6AF6BF
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 21:32:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbjCGUc2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 15:32:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjCGUcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 15:32:24 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2070.outbound.protection.outlook.com [40.107.102.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8157258B64
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 12:32:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oUWh3lmdNDcyiNB79PgwFYCZoYI5ApE8RpWxwgPSg9h2YQSEsCFE1CoaUzpfV4Cfti6iabW6/lSTkRezVQ5l7viai6OV1ETQxcwJJNhzNIYkNZNP0vDkvkLTLIZc0YUtqo6namJ4yhnpJlO4zqSadyZsTiuk+0RQj6/Ec/O9jFG22XKFWAcuYQYTubLCle4D/KOk/qDPsMcscv8uviWqHGXS3+BizHiw4Y7/eVW8aOOhAEMV1iHgLCemB1KPTnr2Pn9Y4qMyHwg1pEPY93rdZJOQ/n70QAej2FSRHjMd0kc0AJQTQ/2Hx6BZJTAFjdzdGf/ACF482NzKp6KJta9Tbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YjV31CRN9laZMiVgxfRXCEFTFLL9vLAfNsiFmvwu+Rs=;
 b=cxnLsEDXbPpQXDRanDc+rGj1kgIDdkzPC5S/kWk/e5oNIL9KASHSYQfVwuNT9flfStMJN3pvI1HawOrC6THefnYjoA3MuutSkLzWMGcBNDcnUdUaWmf6Agpkx11xNdEF/VDUwMZxwbpY/TsTRAgCk/vZewtGFTelHn6yxA53dvLqP/ZgUDz4U2kZ9sxpxApw5nTW6JCrDl+zGPGDVGOy7+U4PU4LrXVBv19bEQJQwofKkK/UBX6iB5iwYlBrxcDj21tPD/yVm95wUjPbDdkvtQoZHeFtccL9wLIW6wp4TRd4k3kNbtOxejcCJxYqJtgqxCfxvvDdQhD9y6evPq9/tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YjV31CRN9laZMiVgxfRXCEFTFLL9vLAfNsiFmvwu+Rs=;
 b=ljnREZzGwJzrshmVIxxda/oyWOtUA3t3jt/85jl29gBG0BxVwvJCTdz05YiMZkBSTOoSaLfs3zZ5JNMr6T3YSFDO85aCqE5IpzQasB5RW4/Q/Z1PRvn98n9wT0w2Oy8XX/gP6gmrjPcH8syTfaQ2ZXjWNL5NxCsQN/RlvfG5hLg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4123.namprd12.prod.outlook.com (2603:10b6:5:21f::23)
 by MN2PR12MB4566.namprd12.prod.outlook.com (2603:10b6:208:26a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Tue, 7 Mar
 2023 20:32:15 +0000
Received: from DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::e4f3:9509:c6ee:41cb]) by DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::e4f3:9509:c6ee:41cb%3]) with mapi id 15.20.6156.029; Tue, 7 Mar 2023
 20:32:15 +0000
Message-ID: <772384ea-9e6b-2390-f41d-0599f9408102@amd.com>
Date:   Wed, 8 Mar 2023 02:06:07 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH V6 2/8] soundwire: amd: Add support for AMD Manager driver
Content-Language: en-US
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        vkoul@kernel.org
Cc:     alsa-devel@alsa-project.org, Basavaraj.Hiregoudar@amd.com,
        Sunil-kumar.Dommati@amd.com, Mario.Limonciello@amd.com,
        amadeuszx.slawinski@linux.intel.com, Mastan.Katragadda@amd.com,
        Arungopal.kondaveeti@amd.com, claudiu.beznea@microchip.com,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20230307133135.545952-1-Vijendar.Mukunda@amd.com>
 <20230307133135.545952-3-Vijendar.Mukunda@amd.com>
 <09453549-73b3-bedb-89f6-61d482cabdf9@linux.intel.com>
From:   "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
In-Reply-To: <09453549-73b3-bedb-89f6-61d482cabdf9@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0122.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:6::7) To DM6PR12MB4123.namprd12.prod.outlook.com
 (2603:10b6:5:21f::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4123:EE_|MN2PR12MB4566:EE_
X-MS-Office365-Filtering-Correlation-Id: dfb6ac15-1d62-4eb8-2205-08db1f4b0982
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vNpubig9Rawze+WM4LclzyzuCZdvokUoV1SXRqG7Qb3Bm4CbdTo6oNXKGVgHT56+f9iIRgcEnglgwCVBSKAoducgOURFio/GX0ifKXCcOuOKx8+m3fO23d3LdX4b7Fpa+p9kWBEDIOgJYk/vJglo0xpRGlRCXddXNNxRXPQad49mKfQzmQaqQRWxvFNyBPEWjCo6YQxRPdHeTuNOP2rHshBr4M0lxwa1Oq+10zRCHvJknKqRUeoAfi3Tz3O+GEmekRCC7UeTlYdRq3rLENBGfnl1DMXjI0tFvsB8ygqlEFMoM7lXcz4HIab3KSsd2MRoZhF7nHSO8tcZxzGK3QhGyuLvmdtap/qHb7tpYziQF33fz6T+36unGVWDr5n5QBg2TPE9VLA3deXb42pIfZ3kipvYHarzRTzo2tYkENXBXAeBHMYRUgxtMgPinKS/lvs8GVtnZOQnsxsgV23knv6OzUPj+FlqV9Lc6Ozzrqd6n8U78wIOkxqRoPJav9tAZtzHlkRWNQf2zp9ZtpdcINxOswUxDo/b7v8VVWt9KCon3EumxlhapPlDUSF7RmHzvXqcUb+qY97bsGBMKurMLW3PgH3kMJBCVMSbRn7aLdgLBRxPmlIVOIk+vPEtVt5iPFQPDZ/LaZaorIFbCiZGXSDcfPStIeDurLgVEgVWHJFkuFV2Rw4E3Q1VFE+iDFCl6LA+rx5dTQeJ4pEkRky+SKhPlkclCycs15I0nSLa8zOGgkI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4123.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(39860400002)(366004)(346002)(136003)(396003)(451199018)(31686004)(8936002)(5660300002)(41300700001)(66476007)(66946007)(66556008)(4326008)(8676002)(2906002)(54906003)(316002)(478600001)(36756003)(6666004)(26005)(6506007)(6486002)(6512007)(53546011)(186003)(2616005)(86362001)(31696002)(83380400001)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d1dQYTM4T1cxNlhWMG1tdXUrbXI4ZDdlQXN1cXJzd2NKT3BXNGN4ckRVYm5V?=
 =?utf-8?B?UTdZcWFDUXVNUnF5cjdha09OQmcrZ29TVHNsSWVIRXU3ODZMMGdiNmtpalJr?=
 =?utf-8?B?V0RTRWZoM3RaSFBWTGtoQmVLMloxemlnaURkeWZ4WXNzdEZXWkp6NVB2ZFls?=
 =?utf-8?B?OHRjZVJTZ0hkc2pGd2pxSnp6alJhNGg2VTRYeG1TWDVZb0RtZHRuUStjZVN3?=
 =?utf-8?B?ektNSnBieGhrbFBBWlQ0aHZTay91OGRsTGd5cVkzbDVrOXloL0ZzWWdieWd4?=
 =?utf-8?B?RDJRb1d3ck1USklQMWdOaWsxQzl5VDVGczJMUFRwQlhKV29WQXpYZDZEVzNI?=
 =?utf-8?B?T05PL0djTTc4K3dReHpMOEVySVZYZlRYK3QzQmpuSEVydTFIMi9NbXRua2pE?=
 =?utf-8?B?MTZNMzE0cWswK0lCU1VQUjZjN2NYRFEwT0VicU15c0h3bUdyWXZnSXlGUXB2?=
 =?utf-8?B?dDBXcHlVYi9pRkZjMGY3OXlTMFdmejBVQy8vY21mcFRkRmZtelZJaXdVWkNk?=
 =?utf-8?B?MlpBbEU0SVNoUGpWUXFNaVpMM0FhT2kxckZtNlhnZHNHTGdySnlXd243L0Q3?=
 =?utf-8?B?cjJvcUs5R3MwcUpHQUxnR0ljdVJvUmNOaE9kNk9IekZndFV3Y2Y0eGJ2WVNx?=
 =?utf-8?B?YXJIa3g1ZkJaVEp3Uy9nQTFmTEc1eTdwcEZPOXlseG5lNDlrUE5ndWRaazBj?=
 =?utf-8?B?SlluTWRtUmtlVHFHZGQ1MmgxajJBYlZaYklNcnBONUNIVGN1RERxSVdKZ0Y4?=
 =?utf-8?B?UklsT3VHdkIwaVlwV2ZOejhxYmJaUGRYUENSZnYvdmpWYXdUTVN4MW5QRDVr?=
 =?utf-8?B?ZTBkendvdG41K1dlc0pNNW0xYUFvS0RSVXVJa2JvS2wrRHhBQ3k1cEVFeUIv?=
 =?utf-8?B?MDB2RlEwU0dod204akt4KzJpNFBMMzFaLzJ2cHQwaUxPeThodXlmWm1nZSt3?=
 =?utf-8?B?QUlTOE4xbzkybHBWTnYzOW9IY0w0WXFrVGhuZHg2YmpmTjk4TElzV3ZCbGor?=
 =?utf-8?B?NHY0b0c5aDU3bDNyNlBKNlNCV1h6SGhtaXdRN2pLNG9LMEVWeVgwQTEyUXVq?=
 =?utf-8?B?Q2RrOHN1SUxyZU5qWE41REhSZXhSMzEzZGJGOXVXRGxzemd4UEx4clB3VTBz?=
 =?utf-8?B?QytRdjN6NDJtaHMwM3lrcFJZWVpBdVF1T0JUbG5GcU90TnhMZEw1akVSUy9k?=
 =?utf-8?B?UzM0YjczWml2bjkyb3dYNkVQYUlwTXZWZGRWUEFEUnh5YytlOE9XV3N3MFND?=
 =?utf-8?B?OVppR09qU212UkZyajQyMzNBdXJUV1l4WGwvRDA2bEtaaUZzU2p1V05OV3Bh?=
 =?utf-8?B?YlZJeUN2S3VTcVFXWSt2UGxnZU4vU2xRRXlBZlpKSENOWmorVXJHdi90cC92?=
 =?utf-8?B?d0J0Ym5Va3l5STdOY094R2g3QWh3QndHWVdYMFQwcjZQbDFUK0dQTy9zZ2Fr?=
 =?utf-8?B?cHZUSkRiS3BkcUtOQ1gxNG1YaHpSNzlvS2xLdVVLdytJR0o3eHJEWWpxSkZX?=
 =?utf-8?B?Tld3ZXpzaVN5ZTUrajlIYmhZVzlKYnc4VXQzSWZlTnRVRjZCR09CQXNKTGZv?=
 =?utf-8?B?dnZCdnNqbVlvdU1CU2ZBbjFCeFRZV3cxQlJTaUc0SlE4U2FxeFRpbXo3UUUr?=
 =?utf-8?B?U1ZDcDhudGR0azhvSHJPVnRpRzJHbTIrcjZCdm8yNnhCWi9JMmNXc3k3UXdP?=
 =?utf-8?B?VmFjeUwxclVVMFVDeVo2aUprZmtTZ1M4M1ovOGFJcThsZlVGOFpVSEdpdUZY?=
 =?utf-8?B?eTgwQUQ2MzRhbHNpZ2FZb09XVjZIS1d1R2M2eDNkMXJ6SS92dm9Scnh2S3BS?=
 =?utf-8?B?eGlSdy9RVy9Id3VteWhRNXpPN1h6dWJqdW90RXZ3N3VzQlB2QkRFNTl3SitD?=
 =?utf-8?B?S29KNUpteEdMUnFJb0E4bTROTG9MdWVJY0NIYVEybEE1ZWxTVjdOa2MzTFZI?=
 =?utf-8?B?NGFJa0s5WEpBa215cHpnRXZxVHVVTVIzS1RnaU5LOFNEbzF4TDhjMkFxT3pt?=
 =?utf-8?B?SGR3d0dDSEFMK3I3ZjRaRDlsM254ZVIybTVNQWVGc3NJZXUyQjgzdFl0YXpo?=
 =?utf-8?B?S0NNWE9keWNvS1M5anlMbW84a3RkOENaYkI2Mkt1dkxkamNVcThka1l4YjRX?=
 =?utf-8?Q?AoDRUQKnxFFtqi1eLHFQHo5B0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfb6ac15-1d62-4eb8-2205-08db1f4b0982
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4123.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2023 20:32:14.9182
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vyrPv18iPSDPdy1tTnycUmW1IYVK3ac4yft1SPznOVE7HBXluxcnEK0Pi6xOieZU/KJUpauP7FB4BWOMQOgLAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4566
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/03/23 20:55, Pierre-Louis Bossart wrote:
>> +static int amd_init_sdw_manager(struct amd_sdw_manager *amd_manager)
>> +{
>> +	u32 val;
>> +	int ret;
>> +
>> +	acp_reg_writel(AMD_SDW_ENABLE, amd_manager->mmio + ACP_SW_EN);
>> +	ret = read_poll_timeout(acp_reg_readl, val, val, ACP_DELAY_US, AMD_SDW_TIMEOUT, false,
>> +				amd_manager->mmio + ACP_SW_EN_STATUS);
>> +	if (ret)
>> +		return ret;
>> +
>> +	/* SoundWire manager bus reset */
>> +	acp_reg_writel(AMD_SDW_BUS_RESET_REQ, amd_manager->mmio + ACP_SW_BUS_RESET_CTRL);
>> +	ret = read_poll_timeout(acp_reg_readl, val, (val & AMD_SDW_BUS_RESET_DONE), ACP_DELAY_US,
>> +				AMD_SDW_TIMEOUT, false, amd_manager->mmio + ACP_SW_BUS_RESET_CTRL);
>> +	if (ret)
>> +		return ret;
>> +
>> +	acp_reg_writel(AMD_SDW_BUS_RESET_CLEAR_REQ, amd_manager->mmio + ACP_SW_BUS_RESET_CTRL);
>> +	ret = read_poll_timeout(acp_reg_readl, val, !val, ACP_DELAY_US, AMD_SDW_TIMEOUT, false,
>> +				amd_manager->mmio + ACP_SW_BUS_RESET_CTRL);
>> +	if (ret) {
>> +		dev_err(amd_manager->dev, "Failed to reset SoundWire manager instance%d\n",
>> +			amd_manager->instance);
>> +		return ret;
>> +	}
>> +
>> +	acp_reg_writel(AMD_SDW_DISABLE, amd_manager->mmio + ACP_SW_EN);
>> +	return read_poll_timeout(acp_reg_readl, val, !val, ACP_DELAY_US, AMD_SDW_TIMEOUT, false,
>> +				 amd_manager->mmio + ACP_SW_EN_STATUS);
>> +}
> ironically the change to use read_poll_timeout makes the code less clear
> IMHO, specifically because the success criteria are
>
> 'val', 'val & AMD_SDW_BUS_RESET_DONE', '!val', '!val'
>
> It's hard to review and hard to spot potential issues. You may want to
> add comments on what you are trying to check. Same comment for all the
> rest of the code.
I don't think it's really required to add comments for
read_poll_timeout() API everywhere in the code.
'val', 'val & AMD_SDW_BUS_RESET_DONE', '!val', '!val' all these are
break condition checks for register read operations.
Rather than, I am happy to explain if any read_poll_timeout() logic
in our code, hard to review.

>> +
>> +static int amd_enable_sdw_manager(struct amd_sdw_manager *amd_manager)
>> +{
>> +	u32 val;
>> +
>> +	acp_reg_writel(AMD_SDW_ENABLE, amd_manager->mmio + ACP_SW_EN);
>> +	return read_poll_timeout(acp_reg_readl, val, val, ACP_DELAY_US, AMD_SDW_TIMEOUT, false,
>> +				 amd_manager->mmio + ACP_SW_EN_STATUS);
>> +}
>> +
>> +static int amd_disable_sdw_manager(struct amd_sdw_manager *amd_manager)
>> +{
>> +	u32 val;
>> +
>> +	acp_reg_writel(AMD_SDW_DISABLE, amd_manager->mmio + ACP_SW_EN);
>> +	/*
>> +	 * After invoking manager disable sequence, check whether
>> +	 * manager has executed clock stop sequence. In this case,
>> +	 * manager should ignore checking enable status register.
>> +	 */
>> +	val = acp_reg_readl(amd_manager->mmio + ACP_SW_CLK_RESUME_CTRL);
>> +	if (val)
>> +		return 0;
>> +	return read_poll_timeout(acp_reg_readl, val, !val, ACP_DELAY_US, AMD_SDW_TIMEOUT, false,
>> +				 amd_manager->mmio + ACP_SW_EN_STATUS);
>> +}
>> +
>> +static void amd_enable_sdw_interrupts(struct amd_sdw_manager *amd_manager)
>> +{
>> +	struct sdw_manager_reg_mask *reg_mask = amd_manager->reg_mask;
>> +	u32 val;
>> +
>> +	mutex_lock(amd_manager->acp_sdw_lock);
>> +	val = acp_reg_readl(amd_manager->acp_mmio + ACP_EXTERNAL_INTR_CNTL(amd_manager->instance));
>> +	val |= reg_mask->acp_sdw_intr_mask;
>> +	acp_reg_writel(val, amd_manager->acp_mmio + ACP_EXTERNAL_INTR_CNTL(amd_manager->instance));
>> +	mutex_unlock(amd_manager->acp_sdw_lock);
>> +
>> +	acp_reg_writel(AMD_SDW_IRQ_MASK_0TO7, amd_manager->mmio +
>> +		       ACP_SW_STATE_CHANGE_STATUS_MASK_0TO7);
>> +	acp_reg_writel(AMD_SDW_IRQ_MASK_8TO11, amd_manager->mmio +
>> +		       ACP_SW_STATE_CHANGE_STATUS_MASK_8TO11);
>> +	acp_reg_writel(AMD_SDW_IRQ_ERROR_MASK, amd_manager->mmio + ACP_SW_ERROR_INTR_MASK);
>> +}
>> +
>> +static void amd_disable_sdw_interrupts(struct amd_sdw_manager *amd_manager)
>> +{
>> +	struct sdw_manager_reg_mask *reg_mask = amd_manager->reg_mask;
>> +	u32 val;
>> +
>> +	mutex_lock(amd_manager->acp_sdw_lock);
>> +	val = acp_reg_readl(amd_manager->acp_mmio + ACP_EXTERNAL_INTR_CNTL(amd_manager->instance));
>> +	val &= ~reg_mask->acp_sdw_intr_mask;
>> +	acp_reg_writel(val, amd_manager->acp_mmio + ACP_EXTERNAL_INTR_CNTL(amd_manager->instance));
>> +	mutex_unlock(amd_manager->acp_sdw_lock);
>> +
>> +	acp_reg_writel(0x00, amd_manager->mmio + ACP_SW_STATE_CHANGE_STATUS_MASK_0TO7);
>> +	acp_reg_writel(0x00, amd_manager->mmio + ACP_SW_STATE_CHANGE_STATUS_MASK_8TO11);
>> +	acp_reg_writel(0x00, amd_manager->mmio + ACP_SW_ERROR_INTR_MASK);
>> +}
>> +
>> +static void amd_sdw_set_frameshape(struct amd_sdw_manager *amd_manager)
>> +{
>> +	u32 frame_size;
>> +
>> +	frame_size = (amd_manager->rows_index << 3) | amd_manager->cols_index;
>> +	acp_reg_writel(frame_size, amd_manager->mmio + ACP_SW_FRAMESIZE);
>> +}
>> +
>> +static void amd_sdw_ctl_word_prep(u32 *lower_word, u32 *upper_word, u32 cmd_type,
>> +				  struct sdw_msg *msg, int cmd_offset)
>> +{
>> +	u32 upper_data;
>> +	u32 lower_data = 0;
>> +	u16 addr;
>> +	u8 addr_upper, addr_lower;
> nit-pick: use the same convention for data and addr, e.g. upper_data,
> upper_addr. Same comment for the rest of the code.
As it's not breaking anything, will fix it in supplement patch.
>> +	u8 data = 0;
>> +
>> +	addr = msg->addr + cmd_offset;
>> +	addr_upper = (addr & 0xFF00) >> 8;
>> +	addr_lower = addr & 0xFF;
>> +
>> +	if (cmd_type == AMD_SDW_CMD_WRITE)
>> +		data = msg->buf[cmd_offset];
>> +
>> +	upper_data = FIELD_PREP(AMD_SDW_MCP_CMD_DEV_ADDR, msg->dev_num);
>> +	upper_data |= FIELD_PREP(AMD_SDW_MCP_CMD_COMMAND, cmd_type);
>> +	upper_data |= FIELD_PREP(AMD_SDW_MCP_CMD_REG_ADDR_HIGH, addr_upper);
>> +	lower_data |= FIELD_PREP(AMD_SDW_MCP_CMD_REG_ADDR_LOW, addr_lower);
>> +	lower_data |= FIELD_PREP(AMD_SDW_MCP_CMD_REG_DATA, data);
>> +
>> +	*upper_word = upper_data;
>> +	*lower_word = lower_data;
>> +}

