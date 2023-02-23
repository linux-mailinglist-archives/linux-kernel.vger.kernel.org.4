Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A1396A0791
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 12:41:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233365AbjBWLlb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 06:41:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233248AbjBWLlP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 06:41:15 -0500
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on0629.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe0c::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 224AB51F85;
        Thu, 23 Feb 2023 03:41:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PLnNiH+Cholhy5vjVV2btJqctsv4y9pD3tHoXVdjBXxyikx63StlXm1YnvP9EcpZI5YKe0aYpfj9Kz2qN3cjBZ74XeqBJiSdBP6ix3qYlnrlq4QHBVdLvUncR4cEia43A/dBxgkSUHaFZkx6xMAvyigVOO2/uNma/7Kd8pkyCjmg5NF96DKIJ3ZxT6btpMlTmLr1cLDR9yqVoqezQ5wiTs/NKzoiiHpNoqoMGVdW+XejdxWJ+OufL8jH3rwGXQolX0tYTH3H1xPNgAqrrHSTLalcubYk4jFbz6/Ic5oWqSYWt3b7Q4Woy69YtaNJ2TS1UbazHvdtbSzOTPmlJUlpXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cMdAu4aEFI5dsdeoi+lmLcRZBukYPkLl/dCQYyPbr+I=;
 b=Q73b85xCRoDhLi4cB9dOhJxUWhiCzESWOyy6gebS3lLY3T3YCviviUhlqMQto+AZIP58ZBiudiidIpmWCLCyZTbGXw33o0/FHvzDQvcLsdKKrU4v5iRbjCHJkJMHWYTPYeqDag2IiPwXTN29/mxxsbN7VNUDDvopt0K6umu9Otp68kKxujFc7ABx8jfJVuCRC3kKvaWtBdaYAgz6xeMTeHC9yqVNlZaNquc4oI/2G317xYSrB5cLU/Uugyc12GgjNEybLwtINyDU8AcEns3iM4L9F5xBQ2ng9gLWx1XY4hG3l3hFbzIiRjlPzQt4OSkKnGzcjTugFdlR39TXjxcW5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cMdAu4aEFI5dsdeoi+lmLcRZBukYPkLl/dCQYyPbr+I=;
 b=aXLurlsfI+zN4T4H4yZ5zVPQ2uOEjFs0SG+431Xj7dh7PktLqkRaLB9TJw/wdcTb6x7BfAIeknuzmWEHg/WNK+FGGwLUhAO7gjustfr4HNumuUHFtdyr6kMB+F+xDn/XXaosXDdI68q8BAQ9YwDwttlCgy5b9qbwjGsvs8gcp565DIsYWwGpDh5WGGgqfSQ2KC5UCoWcqB8vVkLIRg5RlMTnAdwUV80RwEyZGXFS0LJwiP5iZNuzfF/j9pJfvWlvfzH/67dCEnzAeTqRBrCrY/KUcwbaugee9NV2CGadxDrcQSlpobvBAOxRYe9p6IjW93hKEHdIyGbYD5BSm/FwZg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB7104.eurprd04.prod.outlook.com (2603:10a6:800:126::9)
 by PA4PR04MB8014.eurprd04.prod.outlook.com (2603:10a6:102:c7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.21; Thu, 23 Feb
 2023 11:41:08 +0000
Received: from VI1PR04MB7104.eurprd04.prod.outlook.com
 ([fe80::2191:53f7:4a90:c7cc]) by VI1PR04MB7104.eurprd04.prod.outlook.com
 ([fe80::2191:53f7:4a90:c7cc%7]) with mapi id 15.20.6134.018; Thu, 23 Feb 2023
 11:41:08 +0000
Message-ID: <07d02f6c-be4b-42b0-9edf-6f691571c5e9@suse.com>
Date:   Thu, 23 Feb 2023 12:41:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] HID: usbhid: enable remote wakeup for mice
To:     "Limonciello, Mario" <mario.limonciello@amd.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Michael Wu <michael@allwinnertech.com>,
        Richard Gong <richard.gong@amd.com>
Cc:     jikos@kernel.org, benjamin.tissoires@redhat.com,
        linux-usb@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230222013944.31095-1-michael@allwinnertech.com>
 <Y/WwXBF37hoZBbQa@kroah.com> <c99a7ae3-b8ab-30e2-67bc-87b5a7736728@amd.com>
Content-Language: en-US
From:   Oliver Neukum <oneukum@suse.com>
In-Reply-To: <c99a7ae3-b8ab-30e2-67bc-87b5a7736728@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0030.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::17) To VI1PR04MB7104.eurprd04.prod.outlook.com
 (2603:10a6:800:126::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB7104:EE_|PA4PR04MB8014:EE_
X-MS-Office365-Filtering-Correlation-Id: acdc9566-7e85-424a-f04d-08db1592da9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A9sWOEGQ6kyDRVp8aNIxB31nc/STFfKgtDYLPk6OEPo3dPNa2+BLjzigMdnLElI8XKmAgfiRfoWh8Q6Ubvfl7N2m+n5sRwzBXjVTIvT6+4eKO9RkddcsAFVS+EYGBMiwDQkG5EZDr528+IU8+TcWfBDc+BejmkbRy1hnb73abvzq/L0kdkpeDm2jCzsVz8BiuocklHdEcL/lahaQcLWtQxM7Qk81I2TP5kFtIWFgzprWJdBTxTtydbmxYqiNagll+YUWgrVYZxks+qKkMfDvmTdrV4W5890/kyZ48FNvmrhnypDX59OBDv0yaPYo0eD74zpGbv3I29eM6rVViJzgKV0v3Z36WScyaRpcT+dUUShKLrxy9mudVFNx/lDQo6Mm0KIBnsXGsxgVpyFQg8jaAgyH0AkX/Q4CQLKUewnlyWk9GazqJY/a54imQWN7K68wKffU7o0236xgBmNfSW5VOc4PeUKSYdyw/fT+70bXkMA03WWEkCO5SyhKrIjzTPzu1aZdgQMeoiOsFVnUUe3jjrg6AS9pbbWa+gTu2ZaUMgmvTYln7ZkYX3eizX9HfKDfMSOU3ACfej1qJMbjUOImyZwhIokkIFbbQvEi9mZ5LqF0O5x2K2nEaN2HjIlTqm3CX0/KWVbO8AX7VStwvu8qZBfcdIY4zJZfczcvG3oJ8lGtRFQk7Rmgj3dzZ0pfG/d9fGj7Mi8w/QuvktY4dT7wWw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB7104.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(396003)(366004)(346002)(376002)(136003)(451199018)(186003)(6512007)(53546011)(2616005)(478600001)(6486002)(966005)(8676002)(316002)(4326008)(83380400001)(110136005)(6506007)(31686004)(66556008)(66946007)(66476007)(8936002)(41300700001)(5660300002)(2906002)(38100700002)(86362001)(36756003)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VVB1WWlpLytNZUhNWjVMekxpc2VHUyt1R010QUVwZ0JvdzRuYThXMHM0ZUV1?=
 =?utf-8?B?cFRSSTNQRWs5eEVmZnJTalpFcG00SXo4MFRyeUdpZFc2V2tZZUNGZWpVK25E?=
 =?utf-8?B?a2ZINmVrTElBOFg1RUlabEQrQ2NkdGRET3VEZGVMMzBOWVFuNWx1d29yUHRO?=
 =?utf-8?B?a2Zja1U1YUxVVUJoN2swWW1vUVIwUmFncjViMFdHVHZxT1Y4YlI1WjVWeG5l?=
 =?utf-8?B?NXJDUkpKbjBydVpQSDNMUE5lcVpGUzdPaWVhNGZud0xvWS9FbjQ1ZDNnTUgr?=
 =?utf-8?B?UFV1c3lsNEQrcDZad0p4SHVlamNHSGFsbytPYWtsaXRKN3VKZGh6bC9IZ3hP?=
 =?utf-8?B?WDNEdUQ0SFh0b1pKemsxc1A3RFRYUUhPTUxSREFBS3AzN0tRMC9IRTRMZXo5?=
 =?utf-8?B?WVVlOVJkOFVYTXVoM1RRU1BsNVVKOHFiR1lhSHMybnJnOEFSQ3FGM0tHS2lU?=
 =?utf-8?B?bHluK1BzS0V6aGxkQWNJOU1NZUxqRWFpUHJpdENBV0ZBem43dnNzV2JyQmpm?=
 =?utf-8?B?MEFwVTJQcU1vaGJ1WmE3WDgwcEdHV1czTzRab3hQVkVpYzJMc3Y2cUlaUkFL?=
 =?utf-8?B?SU5oc0ZKb012M084VUFFUjZwenJibG53MXhPVng0cTV6OHZPMGkrZTZ2N2Ux?=
 =?utf-8?B?WHNJU0Rjd29XSmFYN20xNU12R3c4aUtmQ2E4cUtvUHlwVDdyZTlnODJvLzBH?=
 =?utf-8?B?NXpiQWd2dkNVNHd6ZlMvQW45ang3VzVOaGg5WmFMTmp1M1N3OEcrUTAxMkkx?=
 =?utf-8?B?NHlnTUl6VDkzOW9MTGRObUJZSDJMbWlMaUJTN0g4THM0KzJEQWJwd1lNMVdR?=
 =?utf-8?B?TUtXVzBWSFRCUFFjekZVQzNqQnlONEdWeHM2ZUtDWXhKckMxZ1g3OFJuU2tL?=
 =?utf-8?B?dDhwd2llaGVodk12K2p5OHh4a2JMd3FPQnRuaDN5bFcyV0ZRYm1PZzRqMDlP?=
 =?utf-8?B?S2piRTVhYks3NnVMM3JSajdEWW1seXM5VmhLWmlHVlUyMFVQWDBrdXRPR0NS?=
 =?utf-8?B?Q1FHL0hzelNuMFRJN3E1NXhKcTcxZDVONWdJZHdxalRsWEJucVo3R3EycVJW?=
 =?utf-8?B?cGVWTHJYazBiT0hmSTZaWlYxS0o1eFdzd0pyK0E2b2hkNGE5bkdaSzdvaGpP?=
 =?utf-8?B?TWJ2WVRSeUlQaHlGRnpMRk1UTWl6ZCt5UnVEMFlHKzNVcDJaNk9ER2Y3cEp3?=
 =?utf-8?B?M2FiTkhSRUFVUlFTWVhFclJXWmUxbUJQU21HNUtTVi9sNGsrZSt4NHo2d2I2?=
 =?utf-8?B?SzJ6Uy9XUE4xR2Q3cWMvYlJoTFJyN2swdzVOZm80SlpjSHdrWUl4dGZjZ2JF?=
 =?utf-8?B?TlpyRzFnMXdwSnd2MWZyN1VNcUNNNDlXS00zcGNRaHF6cTRCdXNBS1I4OEN2?=
 =?utf-8?B?R0pKcU4zSk9iVGJvSFBuZHpqRFhhMkF6TnliS09tWnlWMVlydEMrMnNkeHR6?=
 =?utf-8?B?WlMva2pSaDhRM1JreU1oTStCdVJxZ1k4akY4ZkQ1eXQ5dy8yRE1hRkJWWFRB?=
 =?utf-8?B?VVZCNFJYR2wyTDE3V2hCekNtSUJ0THlUbFlwdU42ank0YmtQbXBSdXFTQ0J3?=
 =?utf-8?B?KzRxcUk1U3B0WjRlYWxxZThsaWFlY1Rwbk9xemZQeDJCa3k5WERsUnI4dUth?=
 =?utf-8?B?eE0zTy9sK1lxZU1XRlFNTWV6WWR1WEZWYWIwcXM1OHhDZFZGZTMrR2Mwa1Ex?=
 =?utf-8?B?SVJYamRZSkVSRENyVzFYTER0WTB5RHhRdXJmWlJXMnRLbW4rRHNHQ29NVVhm?=
 =?utf-8?B?QzVFamJMeko4WEp4eU5kSWx5S1k1OVV1Ull0QW1EOGZmaDFmTWFlWEhxdlZ6?=
 =?utf-8?B?WllXVFBHSjByTHRtb2JLRHV6aGpRZWV5N29WL1NBWGlxSHNtZlpsTUFCVTBk?=
 =?utf-8?B?dWppRUhUMU5jL3NBTEw0ZG1nb3RoOENWYjZPM256SU4zUWkvN2QwaFZsRm5i?=
 =?utf-8?B?N3g1YzFneVdQYTh3d3l2dit2YVY4aVJEeHRmMmtiS2luc1AyV1pEYXRPTUJo?=
 =?utf-8?B?aTh5VUhYY2QrdUpCYmUrM3ZNQmtVYTFmT2ZGV2xFOFQ5MXRXSE9uTVBrSVlY?=
 =?utf-8?B?K2VBQjhHOVBhNytwSXM0ZFBBZUltRUlMMllhVWpGN1BDWEJEeFgzb0dGaVRq?=
 =?utf-8?B?NGlxSVVsbldWVFV5ZGNmOVNleEduUmEyS1R5WmNvdnZFbFlBMWVqUjhXNFdl?=
 =?utf-8?Q?EZcYFQNDZB+uRDznoHw/FBahoTeyxMyTg80KQ2qMoGaK?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acdc9566-7e85-424a-f04d-08db1592da9d
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB7104.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2023 11:41:08.1967
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Aw6+pnydLwEQyRTpY+zHH/l9kE0blqvUlsSmecNHqfSElxC1ZF3ihD7GtGZKQwfO3mYdGLHo889/EimWmGYY3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB8014
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 22.02.23 20:50, Limonciello, Mario wrote:

> Richard and I both sent out relatively similar patches in the past, but they never went anywhere.

The problem here is that the default will never satisfy a great majority. just a majority.
So if we admit that there is no optimal solution, why not pick the tested,
that is, current solution, as long as it does least?

> We did confirm that Windows does set a similar policy as well though, which is what prompted us to attempt this.
> 
> As there is more interest again maybe we can revive that discussion and merge together some ideas from the sets of patches.

Well, the most obvious question, as this can also be done with a udev rule, is,
what are the risks of a change?
  
> Previous submissions:
> 
> v4:
> https://lore.kernel.org/linux-usb/20220825045517.16791-1-mario.limonciello@amd.com/

This one at least restricts it to some cases. And as much as it pains me,
we need to ask whether there are risks in not emulating Windows.

And on the other hand, what happens if we do this. Are you sure, for example,
that you do not break use cases for S4 with this change?

If a laptop goes into S4 because power is too low, we really do not want it
to wake up just because somebody accidentally hits a mouse button.

	Regards
		Oliver

