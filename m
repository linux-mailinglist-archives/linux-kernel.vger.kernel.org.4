Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53AD45BEC8D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 20:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229461AbiITSKZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 14:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231372AbiITSKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 14:10:05 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2059.outbound.protection.outlook.com [40.107.223.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 393F9186DC
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 11:09:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X0OOc6cPeZB1xCOiswgZgXYhrHvVKmK61jgAORzEEsmO0DufTKdG20dIfYB2npbc5N2RkC4iNpdiXCou0RlWGhIT8kl8euvwrwWpAGWPpd5ABW7b3RkBU2qUcW4W/tV8+4oOmQKYITOBY4p303GIDnOSpg7ebZcgxUyY7TCmn21s8fDfCm479bR/zex9e9N5TqaPRqnjxcxpzPnNaHUK2p9t1QtxzcACUa6K1aFGUaFIVpwzTkD5W+mkzR92TuSUynnBTFPHA1BjDD3qAvtiflxVIRZqv6SDKGcbfk6COEw/1kARDS6OHiL8x36RIFqbUmPw7GG8JvEVsrN/elOxJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n4qAkhIwdgP28/Nt9Hmpfb0dgzUB9w+CcjcQ1WKJ8QA=;
 b=bFvyGtYdPV/mt+sgJtSE0tWvPcnqVv4crRZCh6WNqMs3Cz8lKv9FcsKHUk382kQV54TpVRJ25zTqrA53Aur94YpsAqu/RzUqnOf9lTHLrpiU5/2NPAqVNyQUnrAoxRIxlOOb3pGjvBi3F3FNrdJMSedPUGj7y7UtnTIFpJVMsm1YNQMbSZLoxNkLQFL39KyfQ311KNLUJj3Y65rpBR8tMt8YbxqMKUPeLpcpkN25zIkya1Tw1oBRxZiHOfMvLf3uUH7E6tVR86JbPWSbJTry2P0bOYxHg5Nxv0c0MZTLB+KI4pgX6xMEDGVWhW7s3yHujWBlJOC5oY9vMwAp1Axd+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n4qAkhIwdgP28/Nt9Hmpfb0dgzUB9w+CcjcQ1WKJ8QA=;
 b=LZsmdnNyYtO7Zm8+9k9IER0WDg74vgfP6anHxxYTuum7q1dFjB2VQuq3rKjkDL3tNSa4BghC97fXEZw9itDkYvd7mUYXjonVPAqooMMJUnXBhdhd67MffGZZSQZgKFzl0ni2S49HUqs5vVixn2kk0JSAbdpe1EQBipfFuMz6mJ0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by PH7PR12MB6420.namprd12.prod.outlook.com (2603:10b6:510:1fc::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.14; Tue, 20 Sep
 2022 18:09:48 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::76ec:6acf:dd4d:76a3]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::76ec:6acf:dd4d:76a3%7]) with mapi id 15.20.5632.017; Tue, 20 Sep 2022
 18:09:47 +0000
Message-ID: <f4fea2ca-00ae-ba85-b666-9fa267961add@amd.com>
Date:   Tue, 20 Sep 2022 13:09:45 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH] ASoC: amd: yc: Add Lenovo Yoga Slim 7 Pro X to quirks
 table
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Xiaoyan Li <lxy.lixiaoyan@gmail.com>,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>,
        Sebastian S <iam@decentr.al>,
        Travis Glenn Hansen <travisghansen@yahoo.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
References: <20220920171320.7776-1-mario.limonciello@amd.com>
 <YyoBjHftjG/ACAuJ@sirena.org.uk>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <YyoBjHftjG/ACAuJ@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR03CA0010.namprd03.prod.outlook.com
 (2603:10b6:208:32b::15) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|PH7PR12MB6420:EE_
X-MS-Office365-Filtering-Correlation-Id: 49b56941-cbd0-483f-3ab6-08da9b334dd0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: azbCZBwu+DdVfa6cOP4n/rKuBnoiDesQBiWtrGkeYQcz4vQoMz5ICEJylawJ7HR0Tj/RmPq9vhxVM3YLms0R93FbqT04a5EtQlgvlO3r0bEtsDfUWcyfKBw7x9Ka6K/7mSaDYnrC/2Mf7kh7W+TDTy5Wis5hNbgkKmgxnTzf1J0ghYs+5cAsfw3lBDdeqYvXqi8iUb3gQSldtz51Igg691gri2kuzqw1EBwwvB90JMvJqeD9nP/t2zJfoCTRaImdinC73OjkvATNBJGH7AmAx7jYrbQFGyIjFk/5y+pmWf+yEIs15YC4RULSXDF9ZzAyyMJELxdK/aYNvqGcztadBqWjQyCyah9HeYFD0a2Xj42m0hmTkNlv2wPOv2XMEPE7I8vHLIOi1UQN6X/aFHBgdD64VsyOrrg4uTwhoTsnmuAQ1PpCoxTedBImVZTPEylQ4AjEXp+2MdJ6bOg1zo/9SZ4gqx/dvL+JN/DmQGNKOPiXi9Uy+FO1SkomB7Sy8EhoNxUdiQgZOWNdhWiezWaGZDu0WtdoWjdc0KKXaOsrejmyytba/8pHPcE7JlHiDnG74iR9wzgHAr19E8fZfFtNCXIw/+yLebta6B32vbfz1u3YOo2NxiyidPfuJTdUpYAHzGMlGFDtJ8A3mSTxjuuoSxJ16JCG2DFmyAZZt+eoPBDMoHUOZT+7eTTYB/Kj7wzxeI/l9LcmJSYtWHqrX7VZPf38bOpjtgUHUNEZ67ZRWtFw5pUfARa6+DF9KZHNPC+mJRQcKEChlirNbrYdXSPsgM0U3OtYzm8/uSve88sbWLo4hNzCZVycMQ5SePZd4PYb
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(346002)(376002)(39860400002)(396003)(136003)(451199015)(316002)(4326008)(8676002)(36756003)(66946007)(66476007)(66556008)(86362001)(31696002)(2906002)(38100700002)(4744005)(478600001)(966005)(6486002)(31686004)(53546011)(26005)(6512007)(2616005)(6916009)(54906003)(8936002)(5660300002)(186003)(41300700001)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aWhwWTczSVM2VUdHUjZ2MTdqY29CMXdDV04wTURGNHNwS09hRjQvSStkU3Yy?=
 =?utf-8?B?UzFqUktsMXpiOW1mVEF2elVUV2ZFZHdyQmxEUlJCUjZ0dkhROU5DVjFyTkJv?=
 =?utf-8?B?VndTUWljWmhXNjBvZHdxU1hOVGZjUXJaQjdpM2grWDdwb1VrUkkrOEE3NWpw?=
 =?utf-8?B?eUtaRjhHVWkwL0YrdFpKcDB5YzIzZlRGMVRtT2FWajNmRXhicHFNYUcwd0oy?=
 =?utf-8?B?Ylo3UnhsZnlUUUhaS1JsTk1JZFFaMnlYOHZpc3NyeUNCbEZaNG0wNDA4V0l6?=
 =?utf-8?B?Y1E3d0hZTW9hQk4xTDVxU3hVZDM0QkM4N1d6eSt3SjU0U2lmZjQ2MC9DL045?=
 =?utf-8?B?TzRRc2k3ZFl3UkRVQmVEbE9oNkd0Z2E1ZXZZQVplYWxXS29kcXcybUhSWDNT?=
 =?utf-8?B?T1MxM1JuTHBleFJOZWlLc2dJa1ExbWQyaHFReGtDKysxTWlUL2xuczNlYlM5?=
 =?utf-8?B?d0YwQXVrU09nSmpxY3RuL3Ixc1hNT2N3T05Ic2dJUW14Y2lCR0lxejhBM2dT?=
 =?utf-8?B?QnRTbmZ0Q1N0b3JEMUh5V3FScXdMYnZ5VElNMFBnek1ZSGpGUE9TajAvM1lk?=
 =?utf-8?B?R3NmWkZJS05TYVVnMjhJVkhqY0JaYi84ekVYVmQrRjZKajdaTDdYV1lpc1hM?=
 =?utf-8?B?eHJ5dy9XWW9CNnQ5MWYyTUZmdlM4WlJwMVJkVzVCdDBMNmdKeHNac3Y4dy9O?=
 =?utf-8?B?bDZSOFJGNjh5NlMyYUcxMEZ4dmI2L3hFaGZicWIyR3dwd09xNDVqalZIempv?=
 =?utf-8?B?dDRMVERic3c2azFmYVUvNmlUM05xbEcwUStocGkzcms1SjFkalhwb2x4bmJI?=
 =?utf-8?B?NlFjdTBSZ25ONjNGR3I2a2FxMitPY21NM01BdDVMNFBkL1BCaGJIekk3Ti9X?=
 =?utf-8?B?Z3FCcWtpRGN5QWRNYjU0cHJ2ZHpPSFVmZXVaNUo2eUpjZDJQNXlxMmFwMDBl?=
 =?utf-8?B?aGd6OFk2RTZqRGpiZXBmU3k5MmMvRS8ySWY5MXlaNnBXUklXMWJtRTY5N1dy?=
 =?utf-8?B?ZGdOQnpYWHhtcGlsQUozUDB4aCtRaE1TeGoyY0laY3RGMFpoUGFjOEx3bk1l?=
 =?utf-8?B?Ull2dVFPWlFldmJvMHhQc0FxM3JZQ1BYT2FUUWNJcGdvRVVLWnhxSzAxS3h0?=
 =?utf-8?B?THJlT25RMzd0b1BqeHM2UHhYTU14UlVDT1Bpa2xIYWZZRkZUSThpdHgyaGs1?=
 =?utf-8?B?MHE3ZmJVWDhrTjhhUEVERDBlVFgvQnZjVFZiSEtQajQ5SEF5L09VRWR1dVlp?=
 =?utf-8?B?TXRBbHI4cSs0NTQxdlVuQXY5SnhSWUJTQVFQajJPa0htUmlHS2dLMkttZlhQ?=
 =?utf-8?B?bzA4WDBFTmJKbys0MXc0QUVBd3h5YkQ5Um5VeDNTK3NkOVo3NzlENXZ0SjRZ?=
 =?utf-8?B?R0VoQ09JNmtzSDVRenR5MzljRHhOdk5DdUVQaXVUemp6YjFBYXhSTkdmRUJk?=
 =?utf-8?B?UGZwUkhVWUZONEIwcVVKdmhhcVdxMWU4amZXaTRoWGorMVlpLzMxQ1dzdXBm?=
 =?utf-8?B?djRnR1RKaEpCZ0hMd294NXl0eTRuYWRSTk1wUERmb2pmeDE5cS9uTmN3VUhC?=
 =?utf-8?B?U1hqaUdBRkp1dXZJdmJrY3dpY3VCSDhWS3NNV0ZRajFEc0ZFT3NhWU95MHIw?=
 =?utf-8?B?SGdtQ0NMS0dyQ2tsWllHNWRwaGRKVDlKL0o1LzRYVWZkY0NmeFVHQ2FkYjR0?=
 =?utf-8?B?dlBCc0pTR0Q5TnByL0lrNml2elhrWFBFcHZYOG1Va2xTZ0xDTTJ3dUV6K0JK?=
 =?utf-8?B?dUY2UDNKWXBDSlE4elFvVnJSV1BnRjhGVytiZ0VqOGNqd29FeVhyVUpWMGVB?=
 =?utf-8?B?bjVEa0NVeTZBNjBTK2RoRmhkNmVXRkEzdzRQQUtibi9zd2xGcGRya1Q4R1Q5?=
 =?utf-8?B?bXJnU3kxOTZVT2gvQ205TDdpcE9PZHovUkRRdFViSFNnUlVjVEp0Ti9HMDE1?=
 =?utf-8?B?QnBYeEVXeWh4aWx0bHBvNFhib005SFJkNlhCWDJCa0t6UUkrZ2poZWVBdW4v?=
 =?utf-8?B?Titxd0hSc296dUZ3aTBYQnQvWWhYQXBvbDJnK3F2QnplQmhWZTlIM25LSHhB?=
 =?utf-8?B?Wmt3Yk9ibnNIWmlIMUNTU0srL29xVXdzWFlDY1FQQm4rL1hxRXFhbzdMTGJo?=
 =?utf-8?Q?A9nP/4kikgHqx0Rr9RRwC2q4T?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49b56941-cbd0-483f-3ab6-08da9b334dd0
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2022 18:09:47.8100
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4nGhOO2paPw7KR5Vn2KIKpySA70B2tka4yGsiJAr218WtzRQe8xDS7c98JEXxRI0A5fl0QZFB28YL8Lgrnl21Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6420
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/20/2022 13:08, Mark Brown wrote:
> On Tue, Sep 20, 2022 at 12:13:20PM -0500, Mario Limonciello wrote:
>> Lenovo Yoga Slim 7 Pro X has an ACP DMIC that isn't specified in the
>> ASL or existing quirk list.  Add it to the quirk table to let DMIC
>> work on these systems.
> 
> This doesn't apply against current code, please check and resend.

As I mentioned below the cutline it's on top of the other commit on the 
list touching the same code:

https://lore.kernel.org/alsa-devel/20220917070847.14346-1-lxy.lixiaoyan@gmail.com/
