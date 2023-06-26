Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D35973DBA1
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 11:42:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbjFZJmC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 05:42:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbjFZJl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 05:41:59 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2061.outbound.protection.outlook.com [40.107.237.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4EEFBE;
        Mon, 26 Jun 2023 02:41:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TZve5C71kPS/9MZOrJXJMVhTikb/QJRYUKp7GeMGUJFBSpl0WXO32IsmYzDd2rTgteUO+zB3r6tojXY2TVfirL2FkSHpQPI2FmmlZxlFMH5Ma4Kjkf2A5iWyHlAWawIus/HX6Nus436csX780PUR8P23DyfCAHgC5PxzO5GwbHOXYyILbx4Jp5jyrL0yY4QZ9R6+hupXrGbBRfQdH/803rv9KyM2SRbVwP40vXR7f46zCJ9rNg7wG+66eZka83ia6RGgIJLoZuxxSXJYFc1O07zJFlKd6Q7Pl3X1gQEoi8esB7ahgChizkHDEEi5yME2wwQyG5M4Yn+GIZa6QNKt7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RgBThYf/OW48m/AxcQhudrj3BtlSZyfLLI4HT5w3YeI=;
 b=YuUNlGlU8tuTHW6LrF2xlv2tNqZZCwqTbrFKNnsg8aD6tHR6SJdp2BAFcuRdCL3fmVco1GnKZ1h44Q0tI3OT17VFcK4kMo4nZqrmRE1saZAqt+2QUc0q47W7YOZDdkrErq8G673Br6Fkq2Q64mz0xWcF4CtJrYyi9BzJyxYddmoVgYNsI894D5Wm0lwJZOkFG2uKJGxnvfcfcchfocURkRBFXNQ7UdXHwmbthIZgMWb4zAwS/zHoUUQGch8pMPVyJW5+++Hxpn83RuYOer/wGjCXO6omU0ns/s+qfGZTnkTzZE444wszHraIk1Xd6oTY3BDAHOGjEppOwK2c9hm3xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RgBThYf/OW48m/AxcQhudrj3BtlSZyfLLI4HT5w3YeI=;
 b=RRTLMhAz2E8Zdov9CBkhZlrHTCSbQtuYg9bP3l+Gq7rmssP0X8o8edQGaxs/7a2BVjAm8gE+Eju9QOcS1Z3ZXCWR1050Lzzi3H4Tu+FR6HVypXAECi/HVcipmx2jmqF9LAtRmD1OYRo2hXovwpUaFzOwLn5zMcP0pIFGdCsFFB9i6e+ZyqHBIpNRtMImaI3iENB/nsWqeQGdseqJ8l/heZlFaSBz75gdjzpOdReq4eSOUrz5VAmut0dRdv5dI/qqi47n6Bg9hAqzPKgZCdjNTegLfYfIRvCJ0HxeC0LELWYQymRQdWOEsB/IEtUuUBkD4VdtDk08mfB0N4GS3cJZ9g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3205.namprd12.prod.outlook.com (2603:10b6:a03:134::32)
 by SJ0PR12MB6992.namprd12.prod.outlook.com (2603:10b6:a03:483::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Mon, 26 Jun
 2023 09:41:56 +0000
Received: from BYAPR12MB3205.namprd12.prod.outlook.com
 ([fe80::bda0:2d44:96c3:c3fd]) by BYAPR12MB3205.namprd12.prod.outlook.com
 ([fe80::bda0:2d44:96c3:c3fd%4]) with mapi id 15.20.6521.024; Mon, 26 Jun 2023
 09:41:55 +0000
Message-ID: <020c7602-34c5-f31e-22aa-da0032854489@nvidia.com>
Date:   Mon, 26 Jun 2023 15:11:45 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 2/8] ASoC: tegra: Fix AMX byte map
To:     Mark Brown <broonie@kernel.org>
Cc:     robh+dt@kernel.org, krzk+dt@kernel.org, thierry.reding@gmail.com,
        lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        jonathanh@nvidia.com, mkumard@nvidia.com, sheetal@nvidia.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <1687433656-7892-1-git-send-email-spujar@nvidia.com>
 <1687433656-7892-3-git-send-email-spujar@nvidia.com>
 <ad4b4dc9-7466-45a9-a008-c2301a7485dd@sirena.org.uk>
 <7893c366-e6aa-d606-c3d6-e85f73a345e0@nvidia.com>
 <ZJVwpE5KeL8rgvB9@finisterre.sirena.org.uk>
Content-Language: en-US
From:   Sameer Pujar <spujar@nvidia.com>
In-Reply-To: <ZJVwpE5KeL8rgvB9@finisterre.sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0045.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:81::20) To BYAPR12MB3205.namprd12.prod.outlook.com
 (2603:10b6:a03:134::32)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3205:EE_|SJ0PR12MB6992:EE_
X-MS-Office365-Filtering-Correlation-Id: 34c67743-bbc0-4216-54cd-08db762993fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z3ovdgN7JF6pqcFV3HMAh3fbv05wzbWFG1SO0ewm0GFwtTwuhZcb0jlDsh48FR6KhfpKRtJC9I8MrbRD5ioOdhelWYmP7CKtOF+r2D+HQRMfZiMgMbHi/vaXUEMUCFbgX2Fvb0mU3s6v6Sq6x5WiK81S2o3BLZeZXl4FxVzjPT7fidHT0L/xDnPOCtsh2ZtLUM3KZASIeusQHObgXyCQ2bL+c5NcqDGuFoQZXH7FZlhfXSPPfWNGhNpDA1gzXTMuw0FkrXDSQ/dzvihzVqqvySYK/ALuH3hFUMPLyhCi40uQBozxp3cEHRZXDNE8LId13jTOgnPgL3t99j/PZ5CWZ0VMQNBAT7n6rA4YJdVb/kBaPL+ivD7dl/jlqM4KfjJjxpQ8ZUiHwopLV8FKy+I9gdvY55gS1wbKUKnIpgbhk8KnJ/4qWHnvSjD04sPxcLwPd62YnCr5CKvQ3svg8HS5iJZe7zqSvJz5Z9RLs+xT2NahYHFxgnwp8uJ8JPdr6R3duKw+nSS5rQccB1UkGS0QjpgT7AdEah7EvBXcJto8P8Xq1a6s+N8YGu3TrrQyL6ye9HLcgxrB0qNNxNo9Qt4UHQ39vbqQenS0y69arRGqz+j5FsQUniAM9BcbtCPsG/zlBSnCRbBTToLGS/nZrGp+RA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3205.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(136003)(396003)(39860400002)(366004)(451199021)(8936002)(8676002)(66476007)(66556008)(4326008)(66946007)(41300700001)(6916009)(316002)(6506007)(53546011)(186003)(6512007)(26005)(2616005)(478600001)(6666004)(6486002)(2906002)(5660300002)(7416002)(38100700002)(36756003)(31696002)(31686004)(86362001)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WjFrODkyNkp0bG5SRnlXc01Vb3prTjYvL0lOTXNpMHVBREpUV29CZStHY2VH?=
 =?utf-8?B?cjJsVTh1aVlDbjZLaDBSS0xXVzc1cHhpb0FHTm9OdThDbmZNTmhEOEt5UHdR?=
 =?utf-8?B?bThSK0JIa3hGQktiMFdoQmwyeUNTL3VseVBXZGtKN2tjQTRSNWpPdDgwVFh6?=
 =?utf-8?B?bEc4akhkcVFPejlobmVPaWtaOERHWHczOUNRellVd0p5SEE2aWRLNkpFM3ZM?=
 =?utf-8?B?WjRVZ2NpVVZTRFloTlZnR3I3ZnpIWFV5aDFadFhHaDFldTZ4a2RLeWpVS2RL?=
 =?utf-8?B?U1lsak1wYWlnZVJZQ2N4OGUvSWlHL3JpMys0Z2d2ZWd4aHBzRUFNZVVYRk96?=
 =?utf-8?B?QWdYQ0dGSVhwclU3ZkNrcThIZUxGbnRvd3VqZmhpbmpKcjNUUHdwZnoxeWZR?=
 =?utf-8?B?eDJ1WkxGbHQ2RitGWmZPK0d0Zm1LSDdaMzZkQ3p1eFZEbnA3NlRDRzArMUwy?=
 =?utf-8?B?amgyL2kzNXJKbjdKaURVbDN6Y2p0MGZCSnVsWVA4enIxU3JmTVFpN2Zyb2N0?=
 =?utf-8?B?eDhlVkVnUGovVG9CeEJLVTlZaDBzMlNxa2VyN0JVcWF1TUJudnhSSGI3QzZt?=
 =?utf-8?B?MTFocVhJUzQwQUVjb1pYNDc2alowb0dDWkcyQUtWR2NuS3EzcGVZcTFRcUw4?=
 =?utf-8?B?SWg3MFB5TUdoNVIxQllXSERjVWVYbmM2RTc4ZkNiQTJPSVpWZktaQWw2WmhP?=
 =?utf-8?B?RTBFVVdoczdMdmdYT1Nwd3R5RkpiL0w0dTJkZURUYmFyd3J3amp1ZmpHZDRl?=
 =?utf-8?B?RUFrNmNjdjNOUEVOaWZ2NzRXeWk4QXZ0MUw0NkRKV1dFMDdYM0tYL2FETzRi?=
 =?utf-8?B?a2JDMHMrYWpkRVk4TEtUZjVHNzA3dVpNZzJWZWNqZGpkcjR6WU1EQ1liRlVW?=
 =?utf-8?B?c2FLU1lPaDF2L3pFWjVGenJqWDZkcm9hQ3dYT1g2UGJqTCtsNkZaeHdDVE42?=
 =?utf-8?B?OFdXOU95K3pRYmtTUG5qSVIxSlpIK3QrT1R0eHBNeDYvVnBCcW03RFlRMjRv?=
 =?utf-8?B?bzA1dVBQb21SYmZNa2pnNnZjQmhOUVJSYlRpRzlpdFBwZ0ttR1NoNFZ1aDJW?=
 =?utf-8?B?N0k0R0dOT1lWWEpSNGo3eXp2VXl6SW5mWG1zdzFJK3VCazhiNEhhR0tRVFEv?=
 =?utf-8?B?b21oTnFaVzl5U0FWUkNZYWE1VXBxa0xTNHcwak9OR1gvYTlCRm0zQTh1VDYv?=
 =?utf-8?B?cW5TQUNCbTBTakV5S2d6UHhxbTZjTlNjNzJTcVRtdzRLMVhFSnpIelAzUUtr?=
 =?utf-8?B?aVUrL1Q1aTcyRkkwYk5qL2VuajlYcmgvck8wbktKTEZ6SE0zUEw5QnVyM2kr?=
 =?utf-8?B?V3RmRVdhWlgvb1ZoZXBWVGc4VzVHUGdXUlliT0hyN2NRQ21jSHl4ZUdRQW9H?=
 =?utf-8?B?M3IvRXMxTnh5T0t4c0YrOE1LTTB5dDdiMXdCdUhpT0UyaTNZZmVQWjQwd3Ez?=
 =?utf-8?B?enBMKzBtOWxmbGhSczhJN3Q3bjYwN29yR3pqTnZERC9qc1JnMlA2K1MyMXNo?=
 =?utf-8?B?THA1Q29zVWJQV25SWnF2N21GNlh1TTZ6THBHSU94V2tSSVYyV3Rxb1FOWjhV?=
 =?utf-8?B?bEFHYlpwZldmdTdsVms2QnpTanE3dHVRTmZEQjQxZ3BRWjRKWlFvRENkb1dQ?=
 =?utf-8?B?Q0JyTjFLa255OFNvbUx2WW00Qk40eFM0WkNBZFlRUStuNEI5Z3ZWN3AvS0xm?=
 =?utf-8?B?UW1QbU8reDhpUW0vVWlRaVkvRkM4aytHSHFKSDlyUVdrWXJoNk1lUm8wRHpM?=
 =?utf-8?B?MDZEYkRuOFJwMkxtWHJZWmhDaGVXYUhiditRMjZ4dzk0aGF5RWpSVWdRa1pn?=
 =?utf-8?B?U2krYVRkeXduVVBBbGYycDJKWGVwdVNjdkFOMGNzcHE2dzhUckNZbGpzVEgx?=
 =?utf-8?B?R3lXWFJPYlgrcTFTQndHVHN4VEwzZFRLM2NJNWVjQ2F6RnFUNWxoYVI2S3U5?=
 =?utf-8?B?VEN3NzNUS0t4cTBJa2tuYmVpeEQzWWl2SGJ5eXRDd0VJRWpzRTJBNFBOeUxk?=
 =?utf-8?B?WnI2SE9XUU50NTVDazNKTW5lYTRScXlhSk5NV0k2QUg2aTdJTEl3RmIzS3Aw?=
 =?utf-8?B?bytDeUhsVkI3S2lrVnBFaGV0dXRiZVhHNzdycW5pdGkyOG5aTXZ2QTR2THdp?=
 =?utf-8?Q?rIPE0KbWqqWuqZKiRywwmI7AD?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34c67743-bbc0-4216-54cd-08db762993fc
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3205.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2023 09:41:55.5838
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WC88Bpg4plrPwkaZC8SQgstshcLqobzjtMHGvfoLu7876dsAAu4uAHxFlhyreFkWYlP+cKUEtvzInPr5WxSnyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6992
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 23-06-2023 15:45, Mark Brown wrote:
> On Fri, Jun 23, 2023 at 11:09:32AM +0530, Sameer Pujar wrote:
>> On 22-06-2023 17:37, Mark Brown wrote:
>>> On Thu, Jun 22, 2023 at 05:04:10PM +0530, Sameer Pujar wrote:
>>>> Byte mask for channel-1 of stream-1 is not getting enabled and this
>>>> causes failures during AMX use cases. The enable bit is not set during
>>>> put() callback of byte map mixer control.
>>>> This happens because the byte map value 0 matches the initial state
>>>> of byte map array and put() callback returns without doing anything.
>>>> Fix the put() callback by actually looking at the byte mask array
>>>> to identify if any change is needed and update the fields accordingly.
>>> I'm not quite sure I follow the logic here - I'd have expected this to
>>> mean that there's a bootstrapping issue and that we should be doing some
>>> more initialisation during startup such that the existing code which
>>> checks if there is a change will be doing the right thing?
>> The issue can happen in subsequent cycles as well if once the user disables
>> the byte map by putting 256. It happens because of following reason where
>> 256 value is reset to 0 since the byte map array is tightly packed and it
>> can't store 256 value.
> ...
>
>>>> Also update get() callback to return 256 if the byte map is disabled.
>>> This will be a user visible change.  It's not clear to me why it's
>>> needed - it seems like it's a hack to push users to do an update in the
>>> case where they want to use channel 1 stream 1?
>> Though it looks like 256 value is forced, but actually the user sees
>> whatever value is set before. The 256 value storage is linked to byte mask
>> value.
>> I must admit that this is not easily readable. If you suggest to simplify
>> this, I can check if storage space increase for byte map value can make it
>> more readable. Thanks for your feedback.
> This could definitely use more clarification I think.  It's not obvious
> that storing 256 won't actually hold (and that should trigger a
> complaint from mixer-test if that's what happens).

OK. I will provide more clarifications in the commit message and the 
driver for the existing failure. Will put a TODO item in the driver to 
improve the logic and make it more readable.
