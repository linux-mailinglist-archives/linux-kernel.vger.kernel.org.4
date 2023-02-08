Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44FB768EB61
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 10:30:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbjBHJaX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 04:30:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231157AbjBHJ3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 04:29:41 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on20626.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e1b::626])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 153E646172;
        Wed,  8 Feb 2023 01:28:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kd0Cf9bWeqdvVz92cJLVsfNbz//2E+Hnv5Nq6be8HbhuzjqOsDFCdK8MG/A6O78r3KjppkY3BkHXF52UHW3ZYII/gCkKzlMBFuAn6JyzicKDUqeKABkEogAuJVyxn4Pa3VYK2Pw1eqC8rLzMUrwOXLPhZp9YTF5/ZhZzd+hD+ArfHW21XMZv1axqwrb6lv+MEwaHNV0R+2wX4F2oTJNlc9YaOkffViRx+OowVgJCXgQJq7oqLEolEz/qcHt0BYS787l/BabvUz7vaDNYeE7CXpohktSa67MDkyGTjzF9dIKLoEDhS61cU2gV57w60lXaBz/Ow7USJZJK1pajEPGwdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NDu+41wMENsGPd5SzRT+xT+rvGMClBAKKtxXD6polcc=;
 b=Y5BafszhGbT3K5eovozpUeBPZBXK7QvBVG+AgtrOGMcPTAwNlEvvx3i1PZzVIZqwSoiNSJWlc6KlCkW2qaB4e14Jqqt4SVptxd9oL8ajTTpUcevwmc44NWVxn/xjlcD1x0b/SnXtDvHX4omBmFplhXSPN3Ycg9chpwfQjdmuIR3D7+HI9FM1LQ8JL2UN21CBIj1aRbTW1MT9kHlIu/3zq7as5I0azDf7Yv/EKILUiT6XEeWPc+SRnMZvkAcw99bWr5gjT4LqYMsRPnS0OGKrVWKDSMBwJcRsoy+NikbSSWhdiVuUq3rP1aGJPT82W72FHagbVIXEB7Ihg6zh++iTuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NDu+41wMENsGPd5SzRT+xT+rvGMClBAKKtxXD6polcc=;
 b=HmYvlhSdmZBLN7cib8swhoXZvJhE45GkWg9abRGs6bB69wUSVFAojhhWRY6PWrNG0LF8hKFRggKG9iq3LhpnCiNRNVx6PXg0l1lJtiKhU7VMmnFh6JEbNZub68e5x5zPyA0/R0fd6psbVEQ849LeQq1n3XYY0/Inbm7Gjs81or0e8zYJnoXechdfuBUC5jgBC/DH8vWxPwlTPI3SJiIpqZ9anRnNxU+kIsPNwm1YIN4Phgj2eam309izV/iDJS+kCWjBXRYfP4DVJ18LfVEWlo5+h5mxjo+HItUw6ib730Y6JywdfAoFc/Z7YgNozLu/sXHkMAWIW5sr0Xupqq6sNA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB7104.eurprd04.prod.outlook.com (2603:10a6:800:126::9)
 by DB8PR04MB6825.eurprd04.prod.outlook.com (2603:10a6:10:112::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.36; Wed, 8 Feb
 2023 09:27:02 +0000
Received: from VI1PR04MB7104.eurprd04.prod.outlook.com
 ([fe80::2191:53f7:4a90:c7cc]) by VI1PR04MB7104.eurprd04.prod.outlook.com
 ([fe80::2191:53f7:4a90:c7cc%5]) with mapi id 15.20.6086.017; Wed, 8 Feb 2023
 09:27:02 +0000
Message-ID: <251560a0-489f-eb54-d039-5270436117b9@suse.com>
Date:   Wed, 8 Feb 2023 10:26:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
From:   Oliver Neukum <oneukum@suse.com>
Subject: Re: [PATCH] scsi: dc395x: Replace arithmetic addition by bitwise OR
To:     Deepak R Varma <drv@mailo.com>, Ali Akcaagac <aliakc@web.de>,
        Jamie Lenehan <lenehan@twibble.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        dc395x@twibble.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>
References: <Y+IQoG3aYdTfMStu@ubun2204.myguest.virtualbox.org>
Content-Language: en-US
In-Reply-To: <Y+IQoG3aYdTfMStu@ubun2204.myguest.virtualbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0126.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:94::16) To VI1PR04MB7104.eurprd04.prod.outlook.com
 (2603:10a6:800:126::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB7104:EE_|DB8PR04MB6825:EE_
X-MS-Office365-Filtering-Correlation-Id: 19876611-b6a6-4a19-5d01-08db09b6a263
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PGRfFUpKahtWxLH6WwMwTtPHUJ5u29+FB8ZNDrQ61twuH1huoknpZ130J6/E1QtGYJy9P4fSDrrxnO+DlwfvafUw8aCTZVnLmpiQ5A+HlJz3fFHRA4HXqEewZ8Pt8nfVknYqHRgwIMW7iJN2yvzBqARNm1DwzgcBMytpORb2/yvzslF3OmQ0Xo3w/f/B9YhDOe9wU2YE2Xtij+cMHR0b0oObT/CJnNmi8TMXCcvn54/rzJHzibncCROE8pJJ9wdsH3Rphy1Nv395kaJULxyjJ8lselFypX/zy5ulmvz2V3lmRp3CVazgBA1P7sm7sebuvW66CNDB/qRSwVSU6vo0PC6OE/8LUyEiyGxz+ujmb+dce46LvxyYB8HxeGWsdiF7I4WP7RsnIr/syhxBTgFW724qrGViVV3uWsSCvtkX3KoUosH1qiDtglQWmi4uKIcAL5PYK410CI8wNVfhp1T35m/923J96FMN6jedxOrc1hl78cyQ8XaDVb45Y7uD2eSTdYpRVSjO0CA/bpuycdETWlLhJp1QlCChLfNXVH8Xx+1Et0h7bKOE+W+qtVeBUhitHsBX+uYqk0o3QOQVZDzHdYcBIoa+uihijW/FzCogT4SuIVEtpBd5XMMUjbm486bermvltBU01MH8Np/r2f16QfAnk82zbNmxjRQzvNt9HAj/jF7lp7liKAp67rNR326uZj6IFSEnwkKcZDRD80Yki1CYy1H9HWovkfmsIv60Njs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB7104.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(366004)(346002)(376002)(136003)(39860400002)(451199018)(2616005)(6506007)(53546011)(6666004)(186003)(6512007)(316002)(54906003)(66476007)(66556008)(4326008)(66946007)(8676002)(8936002)(41300700001)(5660300002)(7416002)(4744005)(2906002)(6486002)(38100700002)(478600001)(31686004)(31696002)(110136005)(36756003)(66899018)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VUttSFQvMkExTHg5a1VYaHZjYklUaWluRkFzR0RwSEdLcUtYTTBOV3p2T0Y4?=
 =?utf-8?B?SnUxRHVVOWlVUlZDM2hhNDFtcHJ4TmxoeTRNYndFaFF2T1dxRHFBQVlMbVk5?=
 =?utf-8?B?cmJieWIzekkxaXpyNVJlL05RYVhXazNZbmJwNVZJSm1xb1F6Q1NXdGRBU3BU?=
 =?utf-8?B?eTFRdlJRSWpTeGlKL20xc2RsRUZwbDk4enIreU82WGlaa2JLZDVWVnJNL0l0?=
 =?utf-8?B?REdLS1B2cG1iYjhGaERjdDM2L2lXR09XS3VTNmg3WEo5VEQ0TWdCa2hoUjZn?=
 =?utf-8?B?N1BPQWJ1TUR6V3gvWWo5YVpWWTVVQjY5bTRKM2pETS8xWFE5dEgybVdIZ0Rv?=
 =?utf-8?B?S0V2SW1OdENnaE9xK3lROTFSRkxEeEJ1aWhNYTFOQ09PdVVIL0dNS2szb0tt?=
 =?utf-8?B?S21sUktuUGV3Q2FUVUVuT0djdnFKeHFrU0RLenU5Nlh1ZllmN2Q1VW9id1RD?=
 =?utf-8?B?NXlEN0RaTzhIZEV6dUFMV1hFYXVsQ21ZbVF4VHkwdG44dW84TEJuQ2ZQMnQz?=
 =?utf-8?B?WVdJTExYeFk3Z2JHaW1MNWNSbFNPN1dod3ZobkN3VzdyQmQ4cG1sVUk2UkdH?=
 =?utf-8?B?NHltZkVRZnhyZ0dRREdlSjl1WlJNWHBOakI2MW04d29mV0d5ZHdRditCaDdy?=
 =?utf-8?B?OEtsTFlvODRheVpRRVFyY3R4K1JpTjJEUm5ONVpVb2FRSm9wNjN5blg0SWtP?=
 =?utf-8?B?N3dRSXdWN0tUZnpJbjVHaHdpQkhwUXpneDNQTHhPU0lNYmFacEVyd2lQVlBE?=
 =?utf-8?B?OEc0Wi9EUVZ0aHdUNzVSMG0xQzhLeGE3ZmlQdDZFSC9TcFpiS3dSQXNCV0RV?=
 =?utf-8?B?M2ZvL3pPN2NMZU5lZHBaOEtybnhuR2NWekFHRUYzQVdVT1BjWk9TYzhGQkRq?=
 =?utf-8?B?cDk4OXJLSkJRM0NYSlpUcEhsbWRqTFdIUm5kTXdzZnpZMTZQN2ZxZHVJZXB2?=
 =?utf-8?B?OWtFRVcwcnJNZUprSWJaa3VnMm5NdlFVRlVSQmpYRzlKeWxSc2FrcGlXZUpr?=
 =?utf-8?B?UER5b2hHeTllbVl6SGR0RjhLd3doVm5OTG9UeEovSHcwOGwxaS9idTYzUktn?=
 =?utf-8?B?VWI3N3M2WE9yaktkWkdoQTNCaUNMaHVIWEI1b2VibTRHMFRpbjFzVk5VL0Fx?=
 =?utf-8?B?Z1ljZlpUMGMrYi9FZEIzL0NETHJVdHg1MjNLQXN2TFVIY1ZwcGVwNVB4TVpr?=
 =?utf-8?B?MkVnVVZVblhNT1NpemFaQmhvbmEydStraHpzZkViaGRUWHlObWtNN2YxbUp0?=
 =?utf-8?B?c3FqS0dwVmFwcmN0c1FUVjQ4VVB4THhBK2d2c3FlZU0zcmhpazhlSFVjRmJS?=
 =?utf-8?B?anB4RkMwY3N3bnQ5UDJSWkp2emtyOFgxeXY1MjAwOFNEalB1VjREMzVUbmhr?=
 =?utf-8?B?NkRmT0w1bU4zbElSQmFMM1dnSVA5RmxONzlRMUthWXJFVGdWRVZKcVhUeG91?=
 =?utf-8?B?U29tN05ZZjJ2WjdLL0NMV1RITWZLdHBjcmdLWUtPVWZRZ21wWm9lN0tVT0Vv?=
 =?utf-8?B?SnF2ZXBub2hiek03a1Bna2JzNmRWMzFtUlZZbStVUVk1eTVGUE1oWG1nTkJF?=
 =?utf-8?B?akR4V1lSSlMwNkpqVFUxTWxTL2lEM1Z3Vi8zRlJHdStxOU8zTEl2R3o0NE4w?=
 =?utf-8?B?NzZhNWk0bUovaDZyQmJTcS9LeGEyNzBvWDlDSFp2TThGd0thdGFvZ2VKNDVx?=
 =?utf-8?B?dU53RHhlT3RHMUhEdnd0U1lvOGpuRy9zVFJnanpZUGJMY3BYOHFYVVRrTHM2?=
 =?utf-8?B?aVF2eld3M3puVlhLRWtVSkdxMDlTVXNuTmYrZEY3Zkg0d3Y2VTBvR0duait4?=
 =?utf-8?B?cWYzS2JORGJ1Z0JUT0xKMmpjK1l3Y3k4eTFQTTlvc2xuODlTblltd0dHMEM1?=
 =?utf-8?B?T1RXUjFPQ3RUSGZ3M3ZoWDk2Vy83SkxaRnlId2FPQ2I2ZGlRWHFzc1RENjNp?=
 =?utf-8?B?aTdwaFBkZTE1NXR4bENpSmJPUnRaQVRtaFlvWTdiU2QvSTVPMXNNamtZNE5O?=
 =?utf-8?B?TXJ5bndrc0JaVHNjcVl0aWMyNkl3NVBkQlNqYkdhUTRvQ09KdkxydVNxWmd5?=
 =?utf-8?B?TWVQSU44a04xQXFCaTRpc3N0ZjU1ZEZQeTBGZlJjUElEVHMyendiSDBVTkVF?=
 =?utf-8?B?aEd0UmFGc3lscGtmZEJVY0Y1WVZDN1ArbEw5UTdUL1BxZEg5anY0L3hsRlds?=
 =?utf-8?Q?2Q9D/qYxVeiIWCcZx4izWtNhmeS7QxLFhdRzTnuS86Kg?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19876611-b6a6-4a19-5d01-08db09b6a263
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB7104.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2023 09:27:01.8987
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c7lKsV4r6fWsmBE2M5ZruTZChKFgAZWPrtcI8T3HBqX3W3VOAx0fvyau4d5YzEqacVNG6wXff/wH3LLQi/Pd8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6825
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 07.02.23 09:49, Deepak R Varma wrote:
> When adding two bit-field mask values, an OR operation offers higher
> performance over an arithmetic operation.

Hi,

I am sorry, but this change log makes no sense. These are constants.
The compiler turns that into one value in any case.
If you do a clean up, say so.

	Regards
		Oliver

