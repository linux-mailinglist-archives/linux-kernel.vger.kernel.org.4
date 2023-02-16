Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F299869930B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 12:23:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbjBPLXm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 06:23:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbjBPLXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 06:23:39 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2051.outbound.protection.outlook.com [40.107.237.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2730B1EBC1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 03:23:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S/Rk1aCjpHrV4PZGuThm3VlxsRgnnRW94DGRO2OM+K2oKY+RRrhIaBN6BbJrLmO5WkJNBzzKbUvfdcNfl10GxR7ftp+nNBELEXmfz8iEvZ8F5FYGIEHqJA04rmJEuNHJqWpI8ibrhR3j1wG2CID0K5LfqrzQvCJX7b2xAlzZk2S19QkkO/WXlLidefEG/KQ1MhE3Dav8uMQMEhDw0l2hD/tmnZDHVhwsVm0iydWG+n/FM/NUsQCJ94Id+ZmQf29xPVEZ1tFpmc66DzZVOXipxHBYtsxSbxXrO5d7OmQYrU5zc4zpOFsSK3OP7cfrNm5Vg2U7eSQHaWaJ7OjwtybU+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tPd92+NkJuOoEOfr7wYOPKGxwR+f+5y9r9WLNbYYufw=;
 b=f3M2pFVKcBe3tWddpVPTRaD+6kDNCnoET6+YQCe/VgGzFGYnDs9qtrJPxYHa+RmCogmHaVH0V0n5CRTFCTUZjKLV8obYkra6jSSZ3Oaf2eyxbtGyl6+rbua5pB79Rb1NvN/fRvKKqDJQOd5VauOilgYVKSXgpv/r/flcnu7bdVcIyuxUqArDCBvPEU/4iyPVnuSctZQSsD4/VydK54cQ6P7ANB6LEJxtE3FLkT+lbZwnoghg0Jsvse1R//UIC/SlpEg1UCJq9t+JYCCATraIS0A/Kuq2jyIil+sRcRGcIBqnW4jAx9/8l5lAXtHPqssDIDunSzLUBPFSqMbljzq4dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tPd92+NkJuOoEOfr7wYOPKGxwR+f+5y9r9WLNbYYufw=;
 b=wlRe+6/Prl/7X1Kx1iCalbadpjcoNUVfDa+ePCNQQmC0dVS2uMb3EcpycCiZ+/uZU9gadQPWKnORIsP+vHw81NrHLtW+jn7Mn+y/DzX1XiXorwazjVNb3AFNhvlveCFRkc9+Gd80Vb4ywjTwB7wUM+xMquYzf9LDeiMqVoXBrwo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3398.namprd12.prod.outlook.com (2603:10b6:a03:aa::24)
 by CH0PR12MB5091.namprd12.prod.outlook.com (2603:10b6:610:be::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.13; Thu, 16 Feb
 2023 11:23:30 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::dc39:38f2:85ed:4e2d]) by BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::dc39:38f2:85ed:4e2d%7]) with mapi id 15.20.6111.013; Thu, 16 Feb 2023
 11:23:30 +0000
Message-ID: <407cf4bb-1462-e9ae-75a6-034cea7735b4@amd.com>
Date:   Thu, 16 Feb 2023 11:23:23 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: Reg the next LTS kernel (6.1?)
To:     Greg KH <gregkh@linuxfoundation.org>,
        Kris Chaplin <kris.chaplin@amd.com>
Cc:     Ruslan Bilovol <ruslan.bilovol@gmail.com>,
        Willy Tarreau <w@1wt.eu>, Theodore Ts'o <tytso@mit.edu>,
        Michal Simek <michal.simek@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <c6c4787f-f0c6-7285-f782-d36bd86b1e01@amd.com>
 <96e41e6d-bec9-f8cf-22ed-1fa5d9022238@amd.com> <Y8FAFAwB9gBzQXQG@kroah.com>
 <314489f6-cb54-fb3b-6557-d69b1284fa4d@amd.com> <Y8GFYEnIy0Wbh/n6@kroah.com>
 <Y8HPw2t+TbdXa83C@mit.edu> <20230114071412.GB5088@1wt.eu>
 <Y8JnHyKNTHMjsHSb@kroah.com>
 <CAB=otbS2uwfm0+YHMXXY3TM94V82LtxgcBXGZq1Zxbvd36Wkug@mail.gmail.com>
 <2e2c9362-1f4e-a183-e619-c5dc3e56324a@amd.com> <Y+4RkU0x9VRYcUGv@kroah.com>
From:   Kris Chaplin <kris.chaplin@amd.com>
In-Reply-To: <Y+4RkU0x9VRYcUGv@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0516.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13b::23) To BYAPR12MB3398.namprd12.prod.outlook.com
 (2603:10b6:a03:aa::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3398:EE_|CH0PR12MB5091:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d19dec9-003e-4057-0429-08db10103adb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VM5XBC/cTsnlLJw7M1pXZ116AlcJ6PazltNSv2RqQVeWpp6lQifoUqNT/P9SmBvBB0q2IWKdXzsFeWYHXUkmJdu7JNvwdEhgiq677bcQ65UyunZ7Ec3l1FMDMKrnkpWQqUehnY32KeBGYFGlu5QQKfHZdRkgZiC0GlN2OeReG3ONfdgQ/qdFGqDGgwCJd4x8PcEmPXovK+JoA1LiTjP3m0V2YiFQaZnjoov+oXoKK7iPpWJw+VsF+61lsWknOen0cwEkim3LELGsU40PQ2DyMGgf9qCGvCGpaQXfEB43ydUz1bldv8UPlVzlLiZFoaSthOKa74TcU7E6MoUg1Bf3xd+6n5MW26CUGaPlNL2ADXx1GJF+okipE15CQNRwfg4E34/vv1UWW7EztWzDQqQpqNj/1tYDv2UVTu4wscClLLhZwhoyAUpi6DCwIGr/U0G1mj+MNnUH4w/917kD1X2gyyf7+SM5oQBZCUfw5ZA9bWYxZAVam2pEJmSbA/lkJ6/jWrTJVg23K4WygEhyQogGegwIL5hIt4KDbhlO3BggB6QCy6eZDH+SU5Y5AMB1Lep6uvQanLRs7G/Jj0WjNNORcaJDNCnmW0OD38P9Sdnqe/R/wJ+LY2bOtwAJUIcUwL7V7Gta6d0gpHEt9kaoKTszwHn8TxHF0HuzfB58HhPklVn8jerEruBoD7mK8DryqMEs+poJKw68H6Gid3ym9j6lYAK1hEkyEqoORvzgOjjfAo0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3398.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(366004)(376002)(396003)(136003)(39860400002)(451199018)(86362001)(38100700002)(31696002)(558084003)(36756003)(4326008)(44832011)(5660300002)(2906002)(8676002)(66556008)(66946007)(66476007)(8936002)(2616005)(26005)(53546011)(186003)(6512007)(83380400001)(6506007)(110136005)(54906003)(316002)(41300700001)(6666004)(478600001)(6486002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WHlnV01jRCsxQy9LVGV5V2x6elIxbUZuMWlPR1pIaW1PSzVMblBJTlJVcUIx?=
 =?utf-8?B?c1Z5UzU5QkxiVElqemhwb24rcTZyUmxZZ1A0QW5GLzVCRE9PT3daYk1TT0hZ?=
 =?utf-8?B?MHpCSTVTRXlDd1JVUTRDSFJBZUJUUE9Cb2t5VklLQ2xIOFBIM0lRdVppS29M?=
 =?utf-8?B?L05ybUdYKzBETHVEMU5nWnlVYWJsQ0RPc1pmM0M0Nm1VVWUxUHFaditWRUhY?=
 =?utf-8?B?SElvL1drZkJOQU5BeXEybzhmbWI3ZFFTWWVkbjN4bXZSdXVZekJtV3FLK3dn?=
 =?utf-8?B?aTEySkVrQzlGK0pEek81V3JEQnlCQnR6UE5BK3A3aEc4K2pSNG5QQW8vWitp?=
 =?utf-8?B?MGRDd2VGVjdhaysxakl6MHNDcmRjYzFsaUlyRXR0S1FpaWRUZDQ5Z0JqdE9B?=
 =?utf-8?B?MTRiYlhaUkw3d0FLNWJ0Si9UbTUwV29PUTliSTI0UlpwVG9SZkpnWjRPbTc0?=
 =?utf-8?B?dkVIQ2I0RUhRYW5vNm9JMjdPamxRTFNmTTVWbXpIRzFSS1lTa1hrdjZCd0wr?=
 =?utf-8?B?NXNJejBMT3paVHB5QmNydWVmZEllc0FBMVUzUy9mYVZzUVc5S0p1Z1U4dnNO?=
 =?utf-8?B?Tm0vMWs0dThIeGJzODlEQ044alJaUk5iTDgrK1RNdjg5TlZZbk5nZUJJOW9D?=
 =?utf-8?B?Y0NnVU15TmFXUElRbXBiRFpNR2dmVU9waXRMNG94eU44czVNa3FNS2x6dGw5?=
 =?utf-8?B?OFl1cUY4QVA2VlZuSVk1Y3ZCTllmS0pwd1dhWlhrZG0xWExMU21IVThzRWZt?=
 =?utf-8?B?V29HOWFTZS9OWlo0Z3dTSGVOd1o1cGJHQmFhcGkwL1Vpb0FWNm8vbG9KS3Ns?=
 =?utf-8?B?L0NvcmdPWmxHS2dXN0U1bDQ3dHZBNzBnREZUUzZIYmI1Q0RGbFFBRHRtSUh1?=
 =?utf-8?B?L05LRmNQUTFVcnc4eW44czQ4SkovZUt1RVhOb3FnVHA4NFVPM3EzdEROSnJz?=
 =?utf-8?B?RExPSzVtZUNOdFMza1RLVDdzOFVlZnIwemFTWi9jWEp4Z2pWUUpiUVlzaGZZ?=
 =?utf-8?B?REVZcDJvbG5KKzd1SnZrTEl4cWZ2S2dOZHRqMksycFlFT0JZejJWY08zdVJC?=
 =?utf-8?B?aUNZeWxtZGswU1Nsb3ZrTzBaZHlEYk5Ia1BVK2JjaE90K0FSU0d3NTRyMUdQ?=
 =?utf-8?B?L0pML2JWSlJtWjB6SCtPTE9BbkxGUjREN0liZXEzd2JjVUpaS0JpYnNlck5Y?=
 =?utf-8?B?OGdFS1NCSEZSYSt6STkxelhONG5oZHBHUmZzMlcxZjFaVStYcFdNQitaUkdL?=
 =?utf-8?B?Z2lmTmxnaFNiTGtYYWVhYTlnUk5vU29uVU91THkrNmRkalU4cWFZRU9QaFdm?=
 =?utf-8?B?WUlBSkRmdUlqUjcxQXhKNENFY2RxUDkzNDRYWUUxdWV2RGEydWtCTEowdWts?=
 =?utf-8?B?S3VXODkyKytZdWozeFh4allXdlRCQTdsdWM2cVZQbXFyTlpwWXhIbExDVHRN?=
 =?utf-8?B?VCtQdTJ0WjFVTkNlTjZ0blg5bTBVWVlLUkc2aVFHNkkrbGZ5MWxKRGVYRllt?=
 =?utf-8?B?SjZkVjhzTXpnMFh2ek9Ra2RSc1BSZGd1c0RaV0J6OW9nTjdnS2dySWI0RVM4?=
 =?utf-8?B?MjhjNWZCK3YyYmxMY1NKU3RXOUlObC94SnZKZi90RWZNVFRMWFJXaWpHQ09u?=
 =?utf-8?B?Rms2OGhaR25GcTRnai9hdTFEZkxIVHVvMzBXc0RJSFJZMDRLYktBNlVIWlN6?=
 =?utf-8?B?dy9EblpRcVExWk14VE5UeFF4Tmh6cnpESEFhM2RvYjJ0RXg5bFJFUGVVQjd3?=
 =?utf-8?B?T053bU1LYlpITnFWdTdvbkhMVnVXSmloend1cVdpVnp6U2p5Q1UzQXlEa1BU?=
 =?utf-8?B?b2tOZXZQQVp0UWlBdkpqKzZycnl2cExkYnRpQWh1VFN0Qy9MVjJhWXdNbko0?=
 =?utf-8?B?WU5URHBGZmw4UkdKc2RraVdJUmVPeWdFbk5kUEYwTUFjTUlHZWlrNTdLZEht?=
 =?utf-8?B?dDBrYWg2MFVLYS83YWtiKy9ubHlBOEwwWlJrYUx2dVFhYXJUWmdrUExySXVU?=
 =?utf-8?B?RWNGVW5zcUtQNWw3ZVBjTUxSaWJ4QUgvd3FvS3RITGZXa2lYMTlKZXZ2d1VN?=
 =?utf-8?B?VCsvcGxPZ0RodUtINXdZMWhENm9WL2EvUGxwK3RPdUVjekQyU1YzSWNNOTIv?=
 =?utf-8?Q?/nw8=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d19dec9-003e-4057-0429-08db10103adb
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3398.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2023 11:23:29.9135
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i2PZUdABJc5wj2qLpa47uKwVFy5JkKqf/Qk2DdcVXLHDc6CVw8JfW4HhScClVPoT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5091
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/02/2023 11:20, Greg KH wrote:
> Have you looked at the above link recently?  :)

Oops!  Superb.. Thanks Greg.

