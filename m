Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49EA36C2BA7
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 08:47:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbjCUHrw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 03:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbjCUHrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 03:47:48 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71305410AF;
        Tue, 21 Mar 2023 00:47:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LY0l9+LPTAP1QZbBeI2sOg6h738kjQODehrc3C8RCfRIhvajDpavewHxGgzrf3hk9S3oaAI0ZdHHmvxvYL0+i/ApqiKBGvx1/K9FWduIRAXis0CvdHEW1CaoWhxFgGR2JLO+IqlFOaMd0XzhuEW5SmjIIV8ly8t0876+BVuv6khMIBCAHSNz1arvpCmO+pacy9bchhXdYxCgyMt8sBM6WeikoAc2CF/mX9cbqq5KwfFpnSKYqG/y+rzx5iU2V3QlRk+4gd64Yv92KSqYukPx+hJ4A7eKSUFsXCHSnQFzCiMcYGAOZvSu5uxzwBQFTKZBqk7STR048MfLe58JPx07pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OC2fSX9HCEllToOEWAZV6nK7bwSBaKdPD9b5sbHNj1s=;
 b=KFSxw8eYSKqWxR43V4MvfJQyZT15Uzuteo0WlmFvj1PfOuy1OrccaQ78ygSmyoBf6biw7286C35lFkJy0yaH6l5M0oH3O3U7h8YuvtA9HbtMNtv3/M6XUpsiV/st++dUUvOMnS88V++qSx3EGWWCecW/UCe1v4hi4IwJNc/r/FbuSFqN+5H6T9i4ttYhkQXy8JBVBeGcau6kaGMD6VHfZHYj3ZuLJ4iHvSL7h8KF3iVjlJJtk5JRbaIfMny+M5k+KGHLt0G/n3ELXYcvFEcaxg/7gUyNo2n7FOrCpRgkGVusU7JgZ3iayD+PBoUtD6Ds+lPdBuDIi+nc2/sYbwV+kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OC2fSX9HCEllToOEWAZV6nK7bwSBaKdPD9b5sbHNj1s=;
 b=XifHihM9r/kkPBO2zHBsMOq31cIV8SGPdYf7zU0n28GIDGuuY/0cr3QgA3eK2oAsilkb4M5+CvuGXq6Jry5vCGJBRjt64ntgKRa+hmr7Bna0es3hGzG1xa3ha7SR451V9QRdrnv/dPTulwS/oIE78PMVCKRz5yCgs+I0fHXDCbmtSRkmE20gQlh/g+Ac7Gb8k/da2PabrwQAz/WAEHyj7FYXPUddMDiTrgMYcIlqV/+qM8Caf/NGBGFAlDUCeCupEg2axaxGtXxSf15geyXEdAxQPywp2K/AOOXgchQ7M3Vf0w0KUuHhjxlaBnHApi2ZWs2jcYAR0nGohQcE6ofR0w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 SA0PR12MB4400.namprd12.prod.outlook.com (2603:10b6:806:95::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.37; Tue, 21 Mar 2023 07:46:57 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::5464:997b:389:4b07]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::5464:997b:389:4b07%9]) with mapi id 15.20.6178.037; Tue, 21 Mar 2023
 07:46:57 +0000
Message-ID: <5159fc03-e39d-b784-e852-8a4057ec5354@nvidia.com>
Date:   Tue, 21 Mar 2023 07:46:50 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 2/2] mfd: tps6586x: register restart handler
Content-Language: en-US
To:     Benjamin Bara <bbara93@gmail.com>, lee@kernel.org
Cc:     dmitry.osipenko@collabora.com, treding@nvidia.com,
        richard.leitner@linux.dev, benjamin.bara@skidata.com,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230320220345.1463687-1-bbara93@gmail.com>
 <20230320220345.1463687-3-bbara93@gmail.com>
From:   Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <20230320220345.1463687-3-bbara93@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0092.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bc::13) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_|SA0PR12MB4400:EE_
X-MS-Office365-Filtering-Correlation-Id: b538def6-422d-47f5-2c55-08db29e07285
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jFYX+mmOZxV8SBuDUZLmeoKrTv7UWrDItUmchCE3t+8FGOT4Ng13J751Qj2BoE94tRZGJrytHGRfSRxNcAK1GTh//K41CjcfucUdDICSVHTafrKuZbfUk7XObKjItSOlcI9ayHO3CyeCAvcBhPJZazXe0O26BBV9GhwyyXxZoAVLtUpsOVcyXG3Ub03MtywGCqt2shR+H0q7LFPm141uEJpX1dekBGVGmgDUXeYCxukBehgValtsN6nUPKFXY5AKtajx9pWk2cWRg7CR+fifqtCNgP7tUsAhKDMbjLjytu4UFMbJMQvnFl4EprLrNuL+WGzS2RipuFR4YZX6au1uCRZJZh0aN9xR58PzH/5DoOxE8xo9UfKI0woY+OEeCP5Uf2QvGCZ2n9oHNFRKf5SNjOxUXjz4j6T1g9ZoWJSJZmcyNcQ9zlW6D4ImgIwiCYCM+8IQR9nitlmU8mAYcWywTCuV+bApv8dIwxurgV+QLsR6rsxi39NmF9Zlc81R0CG2+vBHgfdYry9ZK1hTUs0mXMxlY1jGFyouylUaycLPgl58TaYhVi6mgkG3cxKHZn25sj2JgBEaXA8EbG+IIPS2Flb7yKgQ4QyahAEM8LxD5ZvK39jfvPShTbCes0vqt1DFrTdN/B9tynQhanl3qJxuDaqCEadVPZIWmaSa/5PbJB8Fw8BsdGc7FAD18W0Kg9qOjBoTEfcBrl9qjhr+9gVa9D8Uxh4bRDXfG030J1YuoX8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(136003)(366004)(396003)(39860400002)(376002)(451199018)(2616005)(83380400001)(86362001)(38100700002)(31696002)(8936002)(4326008)(8676002)(66556008)(36756003)(66476007)(66946007)(2906002)(41300700001)(4744005)(5660300002)(53546011)(186003)(6486002)(6506007)(478600001)(6512007)(316002)(6666004)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bXBXR3Y4ZVQzUVFRN3RpZkgwaDhqVGZyWlo5VCt3d0ViRy80Wm9JcFZOWjFq?=
 =?utf-8?B?NmJ3T3pDZlliTk5rSlk0NW5FaElkMkZMNVNkaUlmdFhOSUhLTGVkSFdhUk5W?=
 =?utf-8?B?eVBJeGtDSXJVcm0vNnlwc3UxS0EwMExuQVhuaFM0SW0xb0FocTNyOW1hcTho?=
 =?utf-8?B?Yk1PQk1vL1ZFc2pCMi9VRkZhL0pSR00vcGtLWG15dHk3UDB5VjRZekRxdmFp?=
 =?utf-8?B?ZkF1TE9IbmRHVDQycGxocGhwTFArVmNDcmNuK3FaV2tKYjFvN2JtcmppQjY1?=
 =?utf-8?B?L3ZLb3c0UGFka3pSaDJYV0lzSGRXWEZ3NzlUeW9idHZPK1NvcXAvT1p3U1o1?=
 =?utf-8?B?MHVPS2l5Y0J6QVd6THRETFFtNzFhY0tybjRaejNMaUtQc1RXK0xVZno3ajQy?=
 =?utf-8?B?dXFmbXUzOVlOcTZmZWpPL1k3eFRFTzFMWGM5QUlsQ2ZZMVFXSEx6Z1hxUXQz?=
 =?utf-8?B?M3JwNElpZ0JMOHlORFU0a0huNFpKSVlNWFc3MERCNktJRTJVRTdRU3pnOVF2?=
 =?utf-8?B?c0FLbmRyVWZEOTdaajN4cjhPaTQ5UWVTZmZoaWlndVJRZ2tVU2Jka0lpaStI?=
 =?utf-8?B?M3JaWTVTM3lEMkg2K1pUYUttdGU1WjNtNG5xZTFpd1JPRCtacWZmVGx6azNK?=
 =?utf-8?B?bHpZdllxVG1HYUdhRGg5Q3hFUk5hUXdWeExmRDh0TXUvTXEyRzlTd21ITzhK?=
 =?utf-8?B?b3poUVVKUGFCQ0k0VFhiTkFWaVVBbHBYNGNnZ2VPVmxhVlJGMDNCaVBpYWR6?=
 =?utf-8?B?Z3loS0gvWnVkOVZzbmpVNTR1ekpXK1dQL1VXQjZSTFBTVFJZVVNSMXhMNVZk?=
 =?utf-8?B?TWVEdDZTRVRGZUZTcGliTUQybmN6Y3JzQ24va2k2OHhnQWZqVEVlSHpDZG03?=
 =?utf-8?B?N2FaRXNpZ3NIeEJkWFpiSXArMlFiM1pWcWJzdzJYcDEwYTRlMHlBTHJza2Zo?=
 =?utf-8?B?N1N2eXF1WXdoSUxmRmp5V2VEVHZuTHRQRXB5Rmg2ZlZLb3pEdGRhWlhrUUNN?=
 =?utf-8?B?OU93Q3pOZmhMZzVPbEx4SWlVdUZuMlhHV3dUTHhWajBySEh3WDJyNlRYTmZO?=
 =?utf-8?B?TGVpTFJxQ1hTM2VBVDJTUGNKYXNkNHU0OEJyZm5LcUw4RWl2SExibnJYRXRZ?=
 =?utf-8?B?aEd6R3BrVnlmQ0krK2VadDBnaWNOcmZCTk04VmRQV1l2QWRqMEJuM3o4SHNZ?=
 =?utf-8?B?MzlaN3hPM0RpdnltbmhFVkhxQjNqajR3SkJQeC9pSU11WEhIemFzOHRoZ204?=
 =?utf-8?B?SE9NUWtoM2xUNUtEY1FHNzBLMndrWFlkNEVNY1liYlc0ZG5LUVM2WXJ2VldQ?=
 =?utf-8?B?UU5UeGMyS1pKakt4UXJzb2JPbVowQjRDUTVDdVV2TC9Ham5hdXZ1bDJkVElR?=
 =?utf-8?B?OVMyM3p3bStuZW5rU1RuUHg1Rzdqc0VOVkJoMjFuYjVLUDdKT2MzQzZicTln?=
 =?utf-8?B?Vk1nTXJibmZzRnV3OVVaR3AzZEQwNW85TEtsdXhCbHBUMFJIVllzSjNBZ0xE?=
 =?utf-8?B?VkdEK3BYY1c5SVczWW9PeXMva05jS2JjODBmVlZ6bnY3MXFDKzFPTUhEbVFk?=
 =?utf-8?B?L21UeGpmUXh1b0dLNlhFSU9LY25QQjVadTRkenJpYW1HNktmelR4L1ZSd3p6?=
 =?utf-8?B?UzlLaVN4WWhYRVk0MVVhNlhhUURRcHBRRzRkQ25ES3BhZE13OTlja3kxa1Y2?=
 =?utf-8?B?aXJXVjM3WEtRWHYwRjM1T2JZRzVtTkVJVE9SSUNpTDE0SUZhdkpVTkNrb0lk?=
 =?utf-8?B?YXd1cS9CM3lpMk5VYjVTdjF6dWtXRlNKUmM0RVptMUYvUWxtTnNFbEZRTkZE?=
 =?utf-8?B?QnhVaWtxKytyQTFWV1N6R1loR2sxVFZLK2FqK01Md2VVanBFQXJUam1Bd3ZK?=
 =?utf-8?B?SndBbHpqU1BoOUgweGxZWi9GOTdlRUY3c0huOEtDR1hIeFZVMkhiYmRTL0N4?=
 =?utf-8?B?WEZ0dmZwQXJab2RxSzZKTi9zekdKQ0xaL0tDakdIS2NEaGVlVEhvYUVOZ1Jr?=
 =?utf-8?B?SEhsU3BDL00rY2FFVEkrWC83N05waXZDV2w0aFZWbXBIRjNBa3ozMTZqWmQw?=
 =?utf-8?B?MnlVS1RRTGFhd1FDOXAvYTlLT056Q082MitJa1lpcVdySDB6bEpmZSt3SndM?=
 =?utf-8?B?SjdJUVFIYzFQMVE3K2RmM1Y3RkNXU08vNTU1eXZvSlB4SkFHSWZjYnJDVWpC?=
 =?utf-8?B?RDJPRnlISXFyTWdWRlVYZmh6Qnc0eXd2K3pSOTd5ZzQ5TVlUNTNVWGZSR2xm?=
 =?utf-8?B?b0h6R3J6cTdMYW9NcDdFZEhVVHR3PT0=?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b538def6-422d-47f5-2c55-08db29e07285
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2023 07:46:57.6769
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sqxpm3xSp7OQaZF3WOLMul+mnk2Gv3b5GolMltfoy6W4J+THqqg23+Sf79Ic6Qhq3GDHpuLP7fz5eTx11bk0jA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4400
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 20/03/2023 22:03, Benjamin Bara wrote:
> From: Benjamin Bara <benjamin.bara@skidata.com>
> 
> The TPS658629-Q1 (unfortunately the only TPS6586x with public data sheet)
> provides a SOFT RST bit in the SUPPLYENE reg to request a (cold) reboot.
> 
> Use it to implement and register a restart handler.


This does not explain why this is needed and/or why we are adding this.

Jon

-- 
nvpublic
