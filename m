Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 036D76B1139
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 19:42:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbjCHSmX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 13:42:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230140AbjCHSmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 13:42:09 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2052.outbound.protection.outlook.com [40.107.8.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E81F3C0810;
        Wed,  8 Mar 2023 10:42:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EKyFbTAzg08YCmICyCFFf/eZDZIXsL0j84ifQY91bCrCSY9O+jJh24IF6tc7SsEVV/djGJCc29q192Q2z626b2AGZUliNONs1Bft91rsHUzliq0/h0MtHDsqjJDEv2ISFqi4U28/rcsaokXVtB0NWzoZ5pxIpDf8XbXkSAJp6Vzb0ldGCtcnrJnbLkuAo0fPzILRzXVJLY1pc7cta5InsIU0bS8UpCqSLjyuqimXxvSX00xY6JjIZ2tXXuyD/Btp+NI2uRB80HkqOFYnBs7nBE7XokSUHGaRUtR5VdaVQmuIGeuXGzEn4SddnFG01FlkgGxCnPw/ka3uur+7R8lUdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5qRdw4lNUBJIkUpoCpF1wcFR5snKb8Q8hFnzSRAWP1k=;
 b=eMXfzRgoCdVrxMraP+lJbx8LrIYiFmZPoVRHEXUSunL7wGWdlfIrFUpxcvIhhW1kYsDXDOdugBdJaj3Eg9IBw3hkD6EChHniKCKNI0bW3fFZIK4vbdfstWVTCd8jyyIbRyl1hUN0oTww5QUvE0/JPF43E10TzcTLvUzYOBokR86RHWqzPrqucMgH9c7M1mKMI5zwadP4l1kxEsf/SR9BmgJfzmrDIoDVW+Or+8cMQddhaWhOwyAvs1L8or7ZOwEmP7yyMDL5nHJehst3Gm8kP4CNKN5wfs8b4QQQtQw9aPEQW5/4/b+S/JhZY8c1PmgRGaH5Pg/BIM2ruNryuci4Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5qRdw4lNUBJIkUpoCpF1wcFR5snKb8Q8hFnzSRAWP1k=;
 b=IlIoAcblH0JydEoriMdZe493JQQ1eGBFGNGjivvdiSyJa8ByWgYxm/rlxuERVO/vDCmTnuopFM4EYs8YUArGJ9apCEUTVb7n5DIFI12dzeEKn3rsx/ZEzMH/5aNm+1V5VzYJE7ulJWRWaKdPy32BezbqOzVkJ+u64l/+vmPb4cGo6gqLR5h46OU1vpFxTtMnzoZ41zCkNVfTNuJImTLl/Nb0/hBMsFmU7q7B6p50oqAm8H0dawGCiO9SBoDdaNachPPSVK9bHDuIZ+UZoJz4a+c/dLgHDrdHqKfwpa+KG4g5Rb1wp3Ec5tbIkQ23ddrVUO6AjWqxEn8ZEokoueZ5Sw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AM5PR04MB3089.eurprd04.prod.outlook.com (2603:10a6:206:b::28)
 by PAXPR04MB8271.eurprd04.prod.outlook.com (2603:10a6:102:1ca::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.29; Wed, 8 Mar
 2023 18:41:58 +0000
Received: from AM5PR04MB3089.eurprd04.prod.outlook.com
 ([fe80::32a5:c2e6:91d9:1a68]) by AM5PR04MB3089.eurprd04.prod.outlook.com
 ([fe80::32a5:c2e6:91d9:1a68%4]) with mapi id 15.20.6178.016; Wed, 8 Mar 2023
 18:41:58 +0000
Message-ID: <a4ecf9eb-509a-84a6-8a9f-a3f5ea54ecac@suse.com>
Date:   Wed, 8 Mar 2023 10:41:51 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] scsi: core: Add BLIST_NO_ASK_VPD_SIZE for some VDASD
Content-Language: en-US
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Lee Duncan <leeman.duncan@gmail.com>,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Martin Wilck <mwilck@suse.com>, Hannes Reinecke <hare@suse.de>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <20220928181350.9948-1-leeman.duncan@gmail.com>
 <88927435-ae58-c24b-e7b7-b675985de433@leemhuis.info>
 <86D685F2-D411-460B-A09B-6BE942372F0A@gmail.com>
 <yq1zg8pl1nq.fsf@ca-mkp.ca.oracle.com>
 <f8c5619f-1e1a-f759-6ab6-ea84bba3d635@suse.com>
 <yq1edq0jg2h.fsf@ca-mkp.ca.oracle.com>
From:   Lee Duncan <lduncan@suse.com>
In-Reply-To: <yq1edq0jg2h.fsf@ca-mkp.ca.oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0103.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::19) To AM5PR04MB3089.eurprd04.prod.outlook.com
 (2603:10a6:206:b::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM5PR04MB3089:EE_|PAXPR04MB8271:EE_
X-MS-Office365-Filtering-Correlation-Id: 0abad45e-b0ca-492e-3c8f-08db2004cc24
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LjFatBBxlOcVEg0zi4AB53BzgcabXKbfp8XJulPtfHOpx5sT1eNury2l3fzA4yW43dssq+yqVDnJWblpoIyExgVKUcx9tRn9uvz2OCHXR5v+zQJTPebqjkFo4ADssG8PWJjDU9BOva8vTyaL//frnUxCRv8Un0ISdcQMkUCLAcdiCv183UIl64vG7hC35PL3VqhHfi+NU4dOMFog8Yv51nniU06zRT6LVyC/zsjDk/QIT/k+D5UE1D6u6r3V1djGGKdx0dCQOVSnFlfa/bXcuMRfdEucK6ZCbzmO5sKSOVA3PwgLe0j39YWUlpw9ZKydnj1LwW+k4CDKfVMgLOEfexgrMHh+MJt0TIFALx0aHNn2LM+A/Xq+iTR8jC3v87RgQhPUOAl7U5lfxFweRwHbk14HzPFRFjdzKuBuhbOLtoGHbVBqfW0DIU5+L52RdP3ug58EYOEWbbTLStZzw2dTgTQRw6RiT6fLkWtX6+4h7HzkAIVtWi+70HKxDmaPZwpMeKs67Yt/0My680IaVRpdq1Px1elhDEtWgA44bRB+yxEpCEHKYBAWP3GRWeHgWpodSn4Xi5D6Nv0h1TnTOo0ohFTBHBHdbQPYM0OueurVjbUtZbY8foX3fMgeCAehxrm7CMH/3Ft93FH3+rleO+pfNtjl+YcLRTLEisgDW1SBwoztNqV7KYD+yl7PTliE5MPi56MjqzxOUr3r/aWSJuIxqrFI2MtBWY38iGMJbvYcGyE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM5PR04MB3089.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(376002)(366004)(39860400002)(136003)(396003)(451199018)(4744005)(31686004)(5660300002)(8936002)(2906002)(41300700001)(66946007)(66476007)(66556008)(8676002)(4326008)(6916009)(316002)(53546011)(6666004)(6512007)(54906003)(478600001)(6486002)(6506007)(31696002)(38100700002)(186003)(86362001)(26005)(2616005)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QTVLWHMyQy9UNCtqNTladmV3NXB1UlhBSXMzb3J1b0Z1bUs3enpMNU94MURC?=
 =?utf-8?B?cEtmYU9pLzYzbmlWajFBeFlLbElCanJIcmMwMlZMRllGbndXU2ZEellkWHlV?=
 =?utf-8?B?L25tdVZJUzF2bVo3bmtOYUtCSjBBYlJpaDhnbTFKYTYzVFkzVVlkREErdzVH?=
 =?utf-8?B?MkFQRkhONVZmakZxQkNzbEp1NXVEZm1hb29NeUtHcWtNTnIrK2xaU1hvMUda?=
 =?utf-8?B?K2JpcXphVWs0SlZXcGJvcXdHYzJXU20rUHZEM2oyWTV6dVBJczl2TndWSHJ6?=
 =?utf-8?B?a3U0RmhlNzhJQUZwMDRGYkRySmNUa1E2WFBjK09lK01GTU9tcXZoNG4wTkZD?=
 =?utf-8?B?NnREcm5nbVJ1TGhuMkVBOWxlRmNSNkEwN3lHSHduOFVCWGNlcW9HeW9FUlgr?=
 =?utf-8?B?YmNSTEtGdGFpc3pQNk9wUklDOEx5cy9KNUtnRUJFK0xwT0tRZTFTc3dVdmtL?=
 =?utf-8?B?OXE0cmxtMjYyNUEzVXB5ZGRWaFRrV3h1aE1ucTZpRjBmVkRLLzF1TmNjSGFP?=
 =?utf-8?B?YlFnaXZnamQ2Sk9IMU9XLzVjbHlxMGdubjBuK1hmZktxVjhINTdSa1pselZl?=
 =?utf-8?B?d0dseFpPK0pqZUdma1RWY0VWckp0ekpTNnZCSWhRSlpaa0xqbm9MbWNrR25x?=
 =?utf-8?B?angxbTFNdzJhZm00UXAweXl3MmJIblgvaDNxak90bHdoQmpJbm1EbE9WODdo?=
 =?utf-8?B?MzdVUFVzdCs3NUpSb0gyQnhlVGR5S1hJL0tLQ0k3N3ZVb1FZSjd6REcrRlQ2?=
 =?utf-8?B?NTM3RStoKzhTL2ZKb28rQWMrSFFKNW9BUlRxaVVESkp1VEtxMFhLdjRtNnU4?=
 =?utf-8?B?S3c5K3o0UTNpOTlReGlXb2VVbTJwQ0JZMnlFdytBdkYvSG91UVk5aWJnTEdz?=
 =?utf-8?B?Vk1tWFZrV0ZCbHZzNlNLdThWbmQ1SGY1OUxlWXNabGJXdzNHd0l0Z1VkUmk2?=
 =?utf-8?B?TERoOTRhbzBUbElicnZDUCtWWGNPdmRJdTM2b2pxdmUybEF3b2NsK2FFcEdw?=
 =?utf-8?B?WXZiTlVRVmtBb241bFFEalJ1cVhhREJ3OE5uNkozaGt3bG9PUWx4YytuVU5s?=
 =?utf-8?B?SXBhU3crSG9VdHdWcE5WTTNlVnUyZXJOSnRrVUlwZi9pRDVCQzNIdUtQdXJP?=
 =?utf-8?B?eUZiQWhaZWVwRmVLcnBkYmljdkJZS0tVV1dwNnJpUTBmUXlsSFVlMW9mcndZ?=
 =?utf-8?B?d3lNVnZpRjg3a0Z2cmlNaklBa291aW93WkcvSU5JTTBJMVBsamNzTEpUcisr?=
 =?utf-8?B?VHdGQWJYbzFoaXJZY0E3YWxxMlJsTm04WllGRFhveU5OZk9RMzhFMnc2TUJF?=
 =?utf-8?B?ZGozTkphazdhUzl2cjcvelU2QWxBWXpqd2JvdTZzcUphRDNxWEM0MkloSWEz?=
 =?utf-8?B?MmQzUHE5U0dGTGlrUDVGVUsveVBkQSsyZm8zNU9EQms3QnRLK1hrTHREVnpq?=
 =?utf-8?B?L2ZjSTZNK1lwc2tPQ0FRWGdYSzEyTzRJeXA1YzZ4bkFyb0ZEcTgrZmhqVEJa?=
 =?utf-8?B?Z1UxWEtMRmcvTEdpdHJ3OU9DVnZPL01hYk1kSk0vN2pmV0s1c1dmb3h1Rmtr?=
 =?utf-8?B?dXNNYXo3bFJNQ0xxTk1KdENHWTRoZHVjS2g5YVVlOG9URWtpZkkxUFhXYmxL?=
 =?utf-8?B?ci93OTJTTjIweVJRbDBIMytIcDJFeG16L3AyY0dQZEwwSjJZT1VFdXo2WDVF?=
 =?utf-8?B?dGNxUzVNd01HY1FZVW1GY0N5OEdjdi9TWC80VWdDTndpUHBvWjV2bUJIS3Ir?=
 =?utf-8?B?a2R4RFd1ZjFtcmNFdThoK3pYbUJTSnhiYVlydlNYZDMwMmM4WW1WQ2J4UUdo?=
 =?utf-8?B?eHpURzVmUXNvUTQveHRlREh5elBnTXZ4ZVBEOUlNajRPODJSNnFEUk92UkhY?=
 =?utf-8?B?MXhlL1AxY0xOSzdrOHRJbGwra1M4U3gyRDk1eEFsOVZlSjNzUGMweGlDWGdO?=
 =?utf-8?B?OUVEY2tQaEtuVWtkcnJRWGg1NXNudi9BWG5lOU9RWTNnWThGTWZpWnV1LzVu?=
 =?utf-8?B?dmlINmtwWS9JRCtKbi9MMERxK0Jrc3FMYnNVT2trTEhkZHJaNFE5ZWRJSHRP?=
 =?utf-8?B?d09rbzNqTWtZQzRSY01ydXhIMnN4eFZKdVpoWUVndXRWemxpaCtzbFF3Qndz?=
 =?utf-8?Q?LiEpW51kfD/PQ274H4sZs1zec?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0abad45e-b0ca-492e-3c8f-08db2004cc24
X-MS-Exchange-CrossTenant-AuthSource: AM5PR04MB3089.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2023 18:41:58.3223
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jTGdTIKEwkR46FtSiUkhP9GPrKEIDKDDoo3p7VsVgGqxNuQxqE45hb9XCksGNZkuHuwLJ9LiZKHBWaCr0ndYvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8271
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/7/23 15:40, Martin K. Petersen wrote:
> 
> Lee,
> 
>> My worry is that this won't always work. Looking at the code, the
>> buffer sizes used for VPD pages include 8, 32, 64, and 252 bytes. I'm
>> not sure how reading 255 bytes into an 8-byte buffer would work.
> 
> In the scsi_get_vpd_buf() case we will allocate a 255 byte buffer since
> that's what scsi_get_vpd_size() returns for a VDASD.
> 
> And in the scsi_get_vpd_page() case, where a buffer already exists, we
> clamp the INQUIRY size to the minimum of scsi_get_vpd_size() and the
> buffer length provided by the caller.
> 

Please add my Reviewed-by tag then.

-- 
Lee

