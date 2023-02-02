Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 226F468727A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 01:44:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbjBBAog (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 19:44:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjBBAof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 19:44:35 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2084.outbound.protection.outlook.com [40.107.100.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29E4C2B61F
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 16:44:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G8bkbf2Rqsugbixm4HOYp7n++8fPcX4t5zJakiaiO2NQpZwvlxEZu3sXeIQYutQlvHw0vrxfbX0p012Kc58F9tzIe2JuTYQYKZ5rkofuDo9AWSTPVSevcEmN1LyfMOYRUtphwvf8pJ+SqUCRnZJP8tSerFXxM0Ds9gXyQHMasmsaWiuRG72mGi9ZN6WtooKFa7viV4bEPzUcHg3YfaLWDDi0QPdtstpqM/CMhO7+RQpoV22BWKdpc8Uf3pUhyVEeZhd1aT5BZTjFkdJpDylhuFLANwrwYaSZcLCOdOPEYESNkt4fPGoCfbOY0GqkdtMwY4pO5txrhN30pZeZUWKUBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8ORxS1KZIoxqa985O2jT1IkeqYoDzwihKqisj5IJ5Rw=;
 b=lHZ+EdL7fi3eJ07RXsMkVjWZTkzkngAPcm/T9eoP/i9wcbtG/2ef4ca6WqpLtirnkl0S0nIqUUkdw4DbBhoSor58f9M8wQ1VD3ArvSbJ1MyKS7Husn002/b8nt0IzGdhqxFCI5xtscOsdnvy4fRVQxYaFJT2fIP7ZLkkkHhtnbhz7FNTi6c7pwk6Rt6UmUHTSN5PeM0pwrhU9+nYTggy88XQoOfszU0CqOwkXB3U3XUyQqCr/07X9HZKNlh/dDqdBckrhG9MfaFXn91rijbyGTpPwAH8Xj1iYZ6p7/SKGjtZxI8KjFvA+gMmV9ukAEYt3IfI4O5/uNZxzQhdh5dgtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8ORxS1KZIoxqa985O2jT1IkeqYoDzwihKqisj5IJ5Rw=;
 b=aesHn5HG6mOAb28yPa264eQwey8GUAT21MIOUc+dbahJ5xc2SQjglvhrJbSpBHQt4OutsmxgpOZZXXhIn0sk056bk+xoQTFF/bTdW1RoBMtQK4u4Hs1oVtkvMS6oJ5Kyi7j7JGBUTpAk99X2bPUEjn80k0V9wROP5PV9/I0nGJg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6263.namprd12.prod.outlook.com (2603:10b6:8:95::17) by
 CY5PR12MB6574.namprd12.prod.outlook.com (2603:10b6:930:42::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6043.33; Thu, 2 Feb 2023 00:44:31 +0000
Received: from DS7PR12MB6263.namprd12.prod.outlook.com
 ([fe80::2ba2:7ffc:1e24:4bba]) by DS7PR12MB6263.namprd12.prod.outlook.com
 ([fe80::2ba2:7ffc:1e24:4bba%9]) with mapi id 15.20.6064.024; Thu, 2 Feb 2023
 00:44:31 +0000
Message-ID: <39506e9f-9bbb-fcf6-b488-542fd3657eae@amd.com>
Date:   Wed, 1 Feb 2023 18:44:28 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] iommu/amd: @Add a length limitation for the ivrs_acpihid
 command-line parameter
To:     Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>,
        Joerg Roedel <joro@8bytes.org>
Cc:     Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Wan Zongshun <Vincent.Wan@amd.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>
References: <20230130083843.802106-1-Ilia.Gavrilov@infotecs.ru>
Content-Language: en-US
From:   Kim Phillips <kim.phillips@amd.com>
Organization: AMD
In-Reply-To: <20230130083843.802106-1-Ilia.Gavrilov@infotecs.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0114.namprd03.prod.outlook.com
 (2603:10b6:610:cd::29) To DS7PR12MB6263.namprd12.prod.outlook.com
 (2603:10b6:8:95::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6263:EE_|CY5PR12MB6574:EE_
X-MS-Office365-Filtering-Correlation-Id: 32414902-764f-4983-9269-08db04b6a5cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n5u8tk5XYusruDR372+6wq56rMr2chXxU1uYOjauGLLfPSQPnyvfLagsvs3eOxSseWv1+XxTj9/NYHNtY9MdOS717iikFNy+jlcOeDJrBf3Y2fetjpP1c0GEkA4cN6dyH5q24Veyy9HGj9AkiE4tph1JFvKHwpwGMHGkjPcyLp1R0CpxXhI0CM53ViZUKt2557y1+oiETxkZfk9CeZR76xqas6Q3AQSFSJC+zD6OHDIqnHTT2LPgWyihlhm9ovTRi2JI6VAZxp0/yqvrO6yMXPMM8a3L+jxbN7YS9l9leA2ReWoGN71gNdoGg5vK8V1uRPzab8oajq81jf/Vw6f/1ycy5PLiiqD0FfJzsYQTU5U1oMDJ53i1MBDCoVttCqAEfKiV0vW9OCTXnrS12Pwq+XoF4+ywZtb7OP5egnq0kHvzRFJ/dSzdrnPCHkeNKANib7GtrzNhu/tvhtNsNQqtoz+iqoZJHYzTX30WU3n0gMIk5NsPi2g9Jgub1e1q2fctc0VRwsOiiBOThQXRruSZnthXbpeaArmgYhiB/xJcBfMJp0oz69E7qH6BiI5J0uTdK3EFzQSYAEAyKjOxpNDDrmhPaJfUpnfcFfdRLLS6GgWzJQX5kFd8s6qIxm8E/V1VBEWtHTGGK/Ji3j/U3Y+UL928o3TbnSTh80RLOfObqSsv88lqRWMbO4fO/H+SkYd0FPZEFlWpeJNfgU7i0eybPRWLmKuFvhmCs+I6IrLCiH4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6263.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(39860400002)(136003)(376002)(366004)(346002)(451199018)(186003)(66476007)(6506007)(41300700001)(86362001)(2616005)(83380400001)(53546011)(38100700002)(31696002)(36756003)(54906003)(316002)(110136005)(66946007)(6486002)(66556008)(8676002)(4326008)(6666004)(478600001)(36916002)(6512007)(44832011)(2906002)(8936002)(31686004)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dU1SWFlFNjk2czMwMFEzd2dROE9pWGk2elNoTnpCNDc3M2ZIcTRYK2NJcnlu?=
 =?utf-8?B?UlFuUnd0WnJ0SisxQXp0OFVjRkl2UVR1Y0ZyL3JaUE1TSTFBaTViaFJ5RFB3?=
 =?utf-8?B?ZnhMS1RpWDdKcjB0eXY0d2JSSk9RWHZRNiszV00zaHJQeml2b3I3UVgvdjJr?=
 =?utf-8?B?WDE0SkpvWVlOUTI3dlJuQlZZbnMwQUloSmo4MUhyNE5mWUNMRWpPQ2o1akM1?=
 =?utf-8?B?NndaNlVYVU1ST0JGSlVxeUk1YmhmRXpHUnIxaEIvaHhRK2ZVaWtPLzJERXNP?=
 =?utf-8?B?bXpIUWRJMGxVYi9VTnhBOWFjeUl1dGFJWmF1T20wcUdGQUI1T3BKODZ4U0N1?=
 =?utf-8?B?ejEwUVVOTWliNEh4RkZ5czRuUW9xaVVicFBuZzl1MjIrczBZRElzQmlqR1VY?=
 =?utf-8?B?ek5vUkFmQjJoRkorSis5blVpNlh6bjl1UzNJNHFDVE02K0ZHMFkxSjVGSGZC?=
 =?utf-8?B?VnY0MU9vWWVmYkdjVHY2WTFsRzhiOXgzZlYwaldwY1ozWCtHWFNPcjkrRVZ3?=
 =?utf-8?B?NUQ2MjR2dEprZTc1TFpaRVZIbXRxNGdxMTF2ZTVJZWlDV05pb2JVaTg1YW9y?=
 =?utf-8?B?dVpIanpBdnQ3ZmFVRWt4U3ovNDV3UUttQkpzZHIwWTJPbUpZZFloZERrQ05H?=
 =?utf-8?B?THVxU0d3YjlKWW1RSFNSSTRLVFZNQzM2U2VnYmRDWkJ0SDBaUFlaRXk2eDdL?=
 =?utf-8?B?S3dhZ2lxdzBNZHpCMGMrVDFINHE0K21TRW5hRVNIL3dKRG9ySzUyMFQ5NTk0?=
 =?utf-8?B?bFhIZ0JmdG56MS8yU0lxcWFCTXB0M2I3bE9GUzFEd3IxRVJGTzFLUW9sM3dX?=
 =?utf-8?B?L0Q3Q3dGME56TkxtWkkrMjdWdUcxcno3R1NMbDJ3dnM3WWhFWmpqR0RMWGh6?=
 =?utf-8?B?amtLbENrVElpNkRCbDFUbndQM0s3Z1F2VXhGT2xzK3JFc3JQRUM3VGxzclpp?=
 =?utf-8?B?STdBZElBWGRCTUluMDRRVEV0MzJnLzAwdk1mcEh1Q2ROSDNycldYcGRJVDRL?=
 =?utf-8?B?bUlxWG5xNnFrZ004Z1l1Y3dxSkFieHZQTUVoS3k0SS85SWhDcFFqdE9vZnpz?=
 =?utf-8?B?aDVwSHhxT1lIUHNQTDFUYVMxamdPeEdtWWFtS3kzQkdRQ0hkNmRGVUhHWlZq?=
 =?utf-8?B?U0psWFFKUkxpcFQ2SmIrcjYzOElPdFBzWkFMSkJ4MTg1bjVGMGovYXFsVFox?=
 =?utf-8?B?SlhBc1l5QzE5L0piTmxPdUI3a2FGVkdxVm1CbFFTczVHSlVoZXRmeURQUlc2?=
 =?utf-8?B?cFg2SkVBRWZ4a0R3SEhQZGtMU1dSNTBua1ZJSGw0ckZ4ZW5RUklDbzRYSE9m?=
 =?utf-8?B?WlFCbWsxQThmeit6VjZUNGE3Q2FBcFgrdk4xWjJKTnRKdTBXMU53UFNadm1C?=
 =?utf-8?B?V09nZkVabDg0TkY2L0RJL0JJVHFyNUlMaVZkd2xJWXoyWkxWVllYb1JoaGpF?=
 =?utf-8?B?SlhmbDVnK0JYNlpDQ3lHb09EcnJzRll3dWZlcGFiTFBhWEh5bnU1dEppRGtw?=
 =?utf-8?B?dVV0cGR2VTE4TFBwL2NmV1VMVHlXU1NHTDMvYkcwbDErTS9JaDJLeWxPK0tq?=
 =?utf-8?B?czRZY0dKcjhRQVBWR1ZqNzVlQ3ZoMU5iRGdHU1djM2o5RWFjMTBoczhOLzRo?=
 =?utf-8?B?RzU5WFFtVnRuUG92dkFya3R1bXh0aDRXM1dnK2ZIVGNUUWladjdpZlpzY29G?=
 =?utf-8?B?dEMvY2U3MDNZeEdEU2o2cUozUGU4ZGllaUxmcDY2VHpIMHlwUlBlZlJ1ZDlE?=
 =?utf-8?B?NVVSR082TmdxYWxZQlZLNHhJL3ZiK2JLWXkyei9iUS94WURuWklvcDBHK2VO?=
 =?utf-8?B?K04wYkVlMEFMdU9NSUd1aGFTQmNHVy9GYWJ3Y3pBZ1FaU3VwZFpocFVMRi9p?=
 =?utf-8?B?MGZUUUlmei9Rd0syaVBSaWJaeFB6L3U3ZStpd2tnUXRrckNLeDNQNmsxYkdN?=
 =?utf-8?B?NmxQcjc3VCs0c2FtT3RRY0JvRytZN214di9kZVFnVSt4RFUvcWpnUzhOcE5o?=
 =?utf-8?B?TythMFBrV3dHNUMxVS9KMnNhUjAwSktTSzFNTUZZRGVHTG9hU0NGK3p0M3M2?=
 =?utf-8?B?SnpmenZLUyt5b0xLakxTNzNsZ3o2K2M2TUsvNWd6WExCWGc2N2FpNTdERmtT?=
 =?utf-8?B?bVF0eFMxd3NsWFEyTHJ5S1B1N2UrVTRJOHA5aUhBa0R3TUwxSTB3aFUyTGlO?=
 =?utf-8?Q?NyYwzY+TKet25xcXrCbcpa/yaX/Phu1mg3u3Rnvm1J2e?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32414902-764f-4983-9269-08db04b6a5cc
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6263.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2023 00:44:31.6683
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7cTVLez3fwW4c/yNafEH3G6tFyckyk5To4mK3sa8/GDgOnc3FKsME8PSCiRwyEKJqjdJg/TIVTA+iUDsLUT1gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6574
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Not sure what that '@' is doing in the subject line...

On 1/30/23 2:38 AM, Gavrilov Ilia wrote:
> The 'acpiid' buffer in the parse_ivrs_acpihid function may overflow,
> because the string specifier in the format string sscanf()
> has no width limitation.
> 
> Found by InfoTeCS on behalf of Linux Verification Center
> (linuxtesting.org) with SVACE.
> 
> Fixes: ca3bf5d47cec ("iommu/amd: Introduces ivrs_acpihid kernel parameter")
> Signed-off-by: Ilia.Gavrilov <Ilia.Gavrilov@infotecs.ru>

cc: stable?

> ---
>   drivers/iommu/amd/init.c | 16 +++++++++++++++-
>   1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
> index 467b194975b3..19a46b9f7357 100644
> --- a/drivers/iommu/amd/init.c
> +++ b/drivers/iommu/amd/init.c
> @@ -3475,15 +3475,26 @@ static int __init parse_ivrs_hpet(char *str)
>   	return 1;
>   }
>   
> +#define ACPIID_LEN (ACPIHID_UID_LEN + ACPIHID_HID_LEN)
> +
>   static int __init parse_ivrs_acpihid(char *str)
>   {
>   	u32 seg = 0, bus, dev, fn;
>   	char *hid, *uid, *p, *addr;
> -	char acpiid[ACPIHID_UID_LEN + ACPIHID_HID_LEN] = {0};
> +	char acpiid[ACPIID_LEN] = {0};
>   	int i;
>   
>   	addr = strchr(str, '@');
>   	if (!addr) {
> +		addr = strchr(str, '=');
> +		if (!addr)
> +			goto not_found;
> +
> +		++addr;
> +
> +		if (strlen(addr) > ACPIID_LEN)
> +			goto not_found;
> +
>   		if (sscanf(str, "[%x:%x.%x]=%s", &bus, &dev, &fn, acpiid) == 4 ||
>   		    sscanf(str, "[%x:%x:%x.%x]=%s", &seg, &bus, &dev, &fn, acpiid) == 5) {
>   			pr_warn("ivrs_acpihid%s option format deprecated; use ivrs_acpihid=%s@%04x:%02x:%02x.%d instead\n",
> @@ -3496,6 +3507,9 @@ static int __init parse_ivrs_acpihid(char *str)
>   	/* We have the '@', make it the terminator to get just the acpiid */
>   	*addr++ = 0;
>   
> +	if (strlen(str) > ACPIID_LEN + 1)
> +		goto not_found;
> +
>   	if (sscanf(str, "=%s", acpiid) != 1)
>   		goto not_found;
>   

That works, or, this fix might be able to be made more brief if
we could transform all the sscanf's '%s's to:

"%" __stringify(ACPIID_LEN) "s"

but the latter might make the already long sscanf line lengths longer...

Either way:

Reviewed-by: Kim Phillips <kim.phillips@amd.com>

Kim
