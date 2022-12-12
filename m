Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96472649D63
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 12:19:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231680AbiLLLSX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 06:18:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232342AbiLLLRG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 06:17:06 -0500
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2056.outbound.protection.outlook.com [40.107.6.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EEDC65C4;
        Mon, 12 Dec 2022 03:14:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vxwmub2k1cmS2GgtlEiCWsbWsU2wxBAvdCtE7n5IUItbKx7jD9U0RSsT8092ON1wY17Lyd+qfW1AOaLThgQVz54eqJV1sFIlpxMihACeFpwD09xEm2qCIZh/IiXIQo/JysR1AsOUBy/qNgKPYZH670ieJDIYNposqIq9B/aSrM+OzdKVlYOGf9tZT9WTPAM0xvTUrETORkM91+J2kmeg6wvlLEmxILjXA0M1ZkzvJoqnZZjucU2Q2AcKaRYihj+nGg+0xqklPjX8Jcn3dfMhdZR5B6bPgux92MJw7ZIhFPaLYSNA91zopFLG3I7O1P28uXUTGi8FWKyodwpy5sPC9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mKMoIBbHOaOQt8p+4kBmSFnfA3o7DRU6cwy4uw5PqA8=;
 b=CISelE/XnGY4fhNJPDtdF2yGUyc289uTOqyaVBfLXW37w+SsqbI3dmMO98Jc6g7geJu8eTdSs+Lc0RJocntzrdc/GLC6xtj7Ng45JphiXcl6bfH7rVnQAENuCkLiNB6xaQp45/sVrH5F+IzUZQw45YtGcrVq0ROGwjHvb1Tk232BIhS35SdolPdlRdReeNsaaZqYVFGkB0Ecjkh8WQQyQEtVspJm8NbvU6fmkjOouRXRFGmC5ac3s6j9lNvBeWYOLFkimAoAX34gBGJ7IP5+1CZUOxtkhaHUP9lsFlC6xN1XOmbpVgShq4FLt6e+AnIiYXK8htkPE5+jc/ZxUalgiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mKMoIBbHOaOQt8p+4kBmSFnfA3o7DRU6cwy4uw5PqA8=;
 b=AgyH/76u8GdaRF2TyFj8sl2PX1o/cvIYp6USzOQsBgoqRhRbl8RrYhVNP1L1FSysfupFkrd9tRD91bnOt+AbjE/tkqNmOvzQ7tm5u6PtHO88im/kywNbNnkpaD6tCf7qza7SYe0B+T816r0+fdsqhHoWvryqSzSG1R4K9tLgPjjXaPsMTB4TFHD0+SY4SQlB2QafevwV4yClNoK9xr5qPBKGnDk0MMs9JNY2L/xFORXY2cA2ZzXXpOFm30eO80rMpFopEENZAI39AQJcLkF+YbnUGDAOxFk5Dk9hmD4oLOz7KVcw5FzfVdxl6eA3db0/7r+3j7QGK2qu/tI1M8/Yeg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB7104.eurprd04.prod.outlook.com (2603:10a6:800:126::9)
 by AM8PR04MB8035.eurprd04.prod.outlook.com (2603:10a6:20b:248::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.8; Mon, 12 Dec
 2022 11:13:56 +0000
Received: from VI1PR04MB7104.eurprd04.prod.outlook.com
 ([fe80::ae59:a542:9cbc:5b3]) by VI1PR04MB7104.eurprd04.prod.outlook.com
 ([fe80::ae59:a542:9cbc:5b3%9]) with mapi id 15.20.5880.019; Mon, 12 Dec 2022
 11:13:56 +0000
Message-ID: <4cf7bce3-dfbb-b064-9d91-27616bf11d6a@suse.com>
Date:   Mon, 12 Dec 2022 12:13:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] USB: drop misleading usb_set_intfdata() kernel doc
Content-Language: en-US
To:     Johan Hovold <johan@kernel.org>, Oliver Neukum <oneukum@suse.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221211120626.12210-1-johan@kernel.org>
 <efca6b26-fb20-ae38-0fc4-8612f1ee150b@suse.com>
 <Y5cDBSZrgC2TUnXs@hovoldconsulting.com>
From:   Oliver Neukum <oneukum@suse.com>
In-Reply-To: <Y5cDBSZrgC2TUnXs@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0094.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::14) To VI1PR04MB7104.eurprd04.prod.outlook.com
 (2603:10a6:800:126::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB7104:EE_|AM8PR04MB8035:EE_
X-MS-Office365-Filtering-Correlation-Id: cbf79ff7-de42-43ad-f233-08dadc31f5f6
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z6RuyT+4PbBbaEOgiBqUGEgAhyAw4IGv4JAaPLy89cDYex9pfsuBmL0Qi4kSFUEPKRGiklxBd65jVw8XUVAS7W03M4mSMEr6egTDntZCfXC5J3XJLeJDlxPEba3+nnrJ2XNyJQCT2sQDuj2sUZtnfrWD0Ky+g0OikK1bcHMqCyCQi94YRXU/NpUqF+K+CAaCJ6tqUP95JrTOYIsh8aBY5GI0rn4ranRlWPQK3+erDjI3R9zfBY9fcnP/H5h1eVoL8InPhke0c5WWsPbwfAikOOiiPEYBFtrJs61haz9iQKv0cAMXI98nForeHkQzecUiw3siu6DXOy2aajQtHKCYLESy1MY1EzvedKeNj/iLTDLUtYLpkzvSnNF4qMPwoooTHI7opJD6nGN6U3dArhQCWSzB6hiJIK917bzp+JIs5PWS65gc5u4bbU52fmlAoO04kpGR2gdZ4b9qUcN07xSt06NUpYYkZRP44eVj9mE6RUwqild/CHeQEPO79z8UnsbXZ2Vyj9UYlxy//2+CcLwf5vfKwM92e8HAc1V6uvPSUoHSQYNi/7OBA3Lz4nT+zp9Y/tuibNOR1ut4yTQ1xjoS0uo2ljfUs6AiPy4iD5fmZTFynLhGwsz7CrQpZcbTWljk6vhk6OAbexh0+5UjLE1nZ1AOuDR/gZKI6++gULWM1E4tAKXsOaXiiGRpO2Pg4HYgYNyEPiPG6so4kYYBDs1wZwIv8/zh1lzLTHlsxyMzbeU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB7104.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(136003)(376002)(39860400002)(366004)(346002)(451199015)(36756003)(8936002)(6486002)(478600001)(38100700002)(31696002)(86362001)(5660300002)(31686004)(2616005)(316002)(6512007)(66476007)(54906003)(66946007)(41300700001)(110136005)(8676002)(4326008)(66556008)(186003)(83380400001)(6506007)(2906002)(53546011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZDdES1JIWmtQRkRkdTNjdVZXVnA0VEhpK1pmL2lYYU45NElpTTExV3J6NXFz?=
 =?utf-8?B?QUVJZGN5Y0crN0hMNnhXR0prQlVOTTN6QWJmSGJwTUJwWWRYYWFWQ08zeitn?=
 =?utf-8?B?dTNiYUVHNVBpd2NzNkM5OUF1bExEUW5ZOHhsQnN3U0VPT1FNS050R3ErTU94?=
 =?utf-8?B?RVBuQWhOditZYktsdk9vWjR2UVZ0UE1mU1hJcVhUR1IzWC9FWWloWCtSK21m?=
 =?utf-8?B?SlAzNkxTUk5PY2Z3UVlRQU9DQ0RqZEtMNWR0OWhoQVkzQmpjR01VeU9TK1hq?=
 =?utf-8?B?TFIzZmVCQlR0ekE3RXBSZUVxbWkzeHYrWXRMUVB0bVE5bEtOMUtRbkI4T0JP?=
 =?utf-8?B?ckZzSDlHMzNxK1c3SkVIdWM1YnlUOStaOUtmMmtzcW1CVW01SHM0MU9QdUdP?=
 =?utf-8?B?UXlsSjUwaHVINEp3R0FuYi9xbC9SMytOUE14RENsZjJhaTNjTWM5WGFhZmNm?=
 =?utf-8?B?WVNPTWRiZU1BZUJZSG5Tcncvb3hWSm9DSmwxQU1LNGdkQmRUNXVKRURBMFhI?=
 =?utf-8?B?S215YWhIRXdjTWpuajFwRUY2b0N6STdGM3JFaC9Yb1o1TG9FRUVURzhhWWVD?=
 =?utf-8?B?aFBDb08yK0hObGlaUThvcEdpWTNwS3JZZHFLWk5NSXlsL3JMakcxSlBpekN4?=
 =?utf-8?B?RWlzM0JiY1lkUi8wR3FmRndKa0FSVUtqM2FiMkV6VVdBZTZDeGxUWkx3d00y?=
 =?utf-8?B?cDBPVit6b0Z3cTlmeE9UeUZFbnFuYmxCNnZUZ1dsUGpIK3FVUTdURDVaeHd4?=
 =?utf-8?B?aGdJeU93blFpRzVCcWlVRTJqU1FwcE1wWFdJamZYejZDb2FEQzVKY0FXU3gz?=
 =?utf-8?B?R1hwaGNvbldCQUJXYU9BU2F3QTMzVG1KNFJ2UFJHSFI4SlMydnB1dkxoODhl?=
 =?utf-8?B?QTFSM2plUHpkMDEyaG9jSFlGYTFXcklJZzI3WTlWbUU5NTRDdDlWOHNiUEJ2?=
 =?utf-8?B?TzU4YjFFbnI3T1NhQmJuOW5VbVg0N0tRcG50bVJDTXZGemJNUXdobk9PWVZj?=
 =?utf-8?B?bUlyR3I3V1BMekg2UG1EVTBSV2RQMDNKakwwOG81Z1kwTDcwcDJCL3JoeGpK?=
 =?utf-8?B?YkYzNmlMakR5Y1JpT0YzV3lkN0hSNE94WG9JY2FyVHhVVkhaaWtGWWQxSjE3?=
 =?utf-8?B?dDExL0I2QW5BQXg2TXMvWUhBUjA4a3M0eTQ3WjZDSzgvTlV0RWJlMVBaZUhq?=
 =?utf-8?B?T1RPU3lTOVdoUWFnM3FEWVkwd0d2dEd5MHpuMFZRc0N0aHgya0VpMmxzVW1U?=
 =?utf-8?B?TSs2Tk5TNS91RHYwZHlWUWRTNEEyVyszb0NxNm1Ndm05L3BobkhCTXUvbkVr?=
 =?utf-8?B?V1JlSk0ySlpVbDZoWmk3Z1hrOEIxcGxqOE5aRTlyYjJxZWdSNHJNMmd0MUNZ?=
 =?utf-8?B?UWRBcU5ZeGdXeDhUZzdZWnFWZVdHWTBRZ0cwWi9RMHNWV3VHSi84NWNCaDhm?=
 =?utf-8?B?OWc2Z1Azb1pqZkZkU1JMQUlNMUlSS1pwVWJoOVZ3M3pyWHUyQTdRUUwwYWxt?=
 =?utf-8?B?eXlTTjZCUFRYU0JXNEh1cmxXY2lGYVA3aGdaeDl5UVJSM0ZkUjhjWUQvSmZQ?=
 =?utf-8?B?bFlQMlJVRTBvR2dMaXp1SG1KQ3NncloxTHFqSnQzUGRkbkdBaDRWMjBjRm15?=
 =?utf-8?B?MHFuOGVTSE1YTEpyOUVCUHZ4UzBnTVl5by80SjR6ckFyZ2lSMm5lQ2Z4QmJF?=
 =?utf-8?B?cldkRjJlcHRBdk5MR3VJSjhrNW8rZmlNdzF3dDZ6UEh2ZHFWZmJUamFLd3Zv?=
 =?utf-8?B?czlhTHAzbTFETE5qWTBaZnBYYUhzS0pVcG5UbitVa2ZFcTAwc2FGR3E1eWE1?=
 =?utf-8?B?NmFnRzdjRnpXYkVOaTRUNENma2FBeW9aZUZ3R3JtRi9VelI2Q2ZSbzNad3RF?=
 =?utf-8?B?aWN5ejNMYTh3am5vZkFKZW1FeDFDRXNNc0JlQWpaYXhHVGhoS3ZJbkhMMGRO?=
 =?utf-8?B?RFltS1o1RG5lM1VCclg3ZG00SHlLSlhlV1JaVi9rbXJqWnJtOHNmekxZVm9p?=
 =?utf-8?B?ZFJQZlhXa0JKTFZNVmRHdytlNWJpVXRqTmVZQnhrRlNLN2M0T3M2ZnJIZEh0?=
 =?utf-8?B?KzVuRFFDdWptOWY4NnJaOGVGdC95SGVTbjRZbEVPdTVhclJWZXZCWUwwNFNo?=
 =?utf-8?B?NGcyUEtXSEgxdHZ4dUUwSThjMERKajk3NXBsb0VCV0poVDh6eTlSYWJLNDZ4?=
 =?utf-8?Q?KesoeiezT0YNnuNfvvmIOeZHVfw4nSvCohLTjX5jpabI?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbf79ff7-de42-43ad-f233-08dadc31f5f6
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB7104.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2022 11:13:56.5862
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b/XaMQoAO1nqKgNEp/Z6T0jy4aSLmuBu8b1QKtWAswSbdphEz4rsNHdAWdxRlNX2dGjyXomJxRPS2SlSDxKV5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB8035
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12.12.22 11:31, Johan Hovold wrote:
> On Mon, Dec 12, 2022 at 11:19:00AM +0100, Oliver Neukum wrote:
>> On 11.12.22 13:06, Johan Hovold wrote:
>>
>>> Due to a misunderstanding, a redundant and misleading kernel doc comment
>>> for usb_set_intfdata() was recently added which claimed that the driver
>>> data pointer must not be cleared during disconnect before "all actions
>>> [are] completed", which is both imprecise and incorrect.
>>
>> OK, but is that a reason to remove all kerneldoc? Kerneldoc is generally
>> a good thing. And if a pointer is NULLed by driver core, that will need
>> to be in it. IMHO you'd better just remove the questionable part of the
>> kerneldoc.
> 
> Yeah, I started off with just rewriting the kernel doc and removing the
> obviously incorrect bits, but then there is essentially nothing left of
> the documentation.

1. that the function exists and its purpose
2. its parameters

most kerneldoc isn't exactly a great revelation. Nevertheless it
serves a purpose.

> A driver does not need to care that the pointer is cleared by driver
> core after the driver is unbound. The driver is gone.

Is that true even with respect to sysfs?

	Regards
		Oliver
