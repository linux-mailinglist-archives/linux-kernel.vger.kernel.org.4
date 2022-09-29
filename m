Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60F205EF480
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 13:41:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235392AbiI2LlO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 07:41:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233190AbiI2LlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 07:41:10 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-eopbgr130047.outbound.protection.outlook.com [40.107.13.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D73E130BC5;
        Thu, 29 Sep 2022 04:41:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HGgo0qRuaVtvTXoRD7uSlrSOQO/gBZ9uZXLKdYe7tcOjG59jLQMevUs+358pAeKgrOlZ81GlXjKnr27UG6NLHuPiUSalHngwI8p3j6bCPLLCLbXscRG0scuEU4x+CoAS71KNshzl3L+5gRXqSKk0l9z5gXHuTwse0ywpp7Rk8obuIykGrw+Zg9Rvkr0ik/1W9rnqu3sOUIo0x//HZZLJzPi2CBm5JbWSBPuXP4QidIHy/P+EM5IPHQGSeAOqv3xCpEC1INZu28UFRUQSp16IrMD1GQmQVQLAaG+yCbrFAS7/frJ6ycydn4356AG6Og+9IN7AZ/ss78LLGb4wUjyP4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T4PzJbBiTRFM8h946NcWyVAwM/B1jXFoCTRZzOi1cm0=;
 b=Aa4qRbNZCit7QQqZafyryKUUNTHrPRnJ/7V7dcJs6w738MPRW3gOMYRO9wv8h8Cpj9UkD+u7Fxus0WOQWWfBiHi11SpvdKlDJO9m3YrLPJVlbs+wT/lVhh/+jBXB1P67Vrc9yAtI41ZjmIvItcrTJiu7n16CROdrbJtvUwS3wso7Mkr4yP3MZEnLkAR7zrmzf6WerrQG1vT8uN/re9y4t5zjzgsnuLBhHxSsKv3fygAf3I2EwX6jZm6YBpfJn5IwWbem56efQCj0PGhRLgZdnZ01Hgej5NbJFnC6Fqs7k5i1bEP3VC5N7XxKwHFKYPBUAwKEw1nTbq64d2nWrCOdlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T4PzJbBiTRFM8h946NcWyVAwM/B1jXFoCTRZzOi1cm0=;
 b=ebhzUcqU81R4ORrnw6YV6T0x6+XSZNrDdR2UfZsLOpY+sas2ott8VPRVkGqEGcqlmxBJGdHJUS6L9yGe439OUNv9ir/Qlp4pYEs/i49NK9M1xy9A/JEkDPA5wfcD1gWZrQ+ITMrqx1ImsIHfmUfOXpKva8HKMnIZBJCl3CwlHI5b8vQpmjD7+Z0ck/6ei4IO/kAwd9kynd4L60C7tJCChcPCZKqod4UCDZe7ePK9+WGwayRvQwxHvMp+jwlWMv7gk0PxtODEKtWeSeU7t0LoY15Z4/CWQJ6r6gfQQxqnUits6UokgoqrB2adATRqT5k0KO/kmlMw2L/xEgWkAUxvAQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB7104.eurprd04.prod.outlook.com (2603:10a6:800:126::9)
 by VE1PR04MB7229.eurprd04.prod.outlook.com (2603:10a6:800:1a3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17; Thu, 29 Sep
 2022 11:41:05 +0000
Received: from VI1PR04MB7104.eurprd04.prod.outlook.com
 ([fe80::584:c4ea:a4f7:af1b]) by VI1PR04MB7104.eurprd04.prod.outlook.com
 ([fe80::584:c4ea:a4f7:af1b%7]) with mapi id 15.20.5676.019; Thu, 29 Sep 2022
 11:41:05 +0000
Message-ID: <4667816e-a093-4993-8d0d-332bde366f7d@suse.com>
Date:   Thu, 29 Sep 2022 13:41:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: KASAN: use-after-free Write in keyspan_close
Content-Language: en-US
To:     Rondreis <linhaoguo86@gmail.com>, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, johan@kernel.org,
        Greg KH <gregkh@linuxfoundation.org>
References: <CAB7eexKhQeqgpMaZoT=JD2EMwn=qTw4sWzF7hdU9XDFVsz3ooA@mail.gmail.com>
From:   Oliver Neukum <oneukum@suse.com>
In-Reply-To: <CAB7eexKhQeqgpMaZoT=JD2EMwn=qTw4sWzF7hdU9XDFVsz3ooA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0057.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::14) To VI1PR04MB7104.eurprd04.prod.outlook.com
 (2603:10a6:800:126::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB7104:EE_|VE1PR04MB7229:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f2afc6f-bffa-4fa0-b719-08daa20f7e56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tGDvJcsx0rnOlq+sN5Di2pwb1VKzu3nwOss3b96XSDfYYF5H62e5R4SH2LZC7+dOTTnoyNnxI/JPRYWfZuTDZgIdQjQBhAYI7DRg2U4EQGPZLgt4aDEdnyq6Q3NUmfoxHhg1FTMQ7qTxfUuVLmxF63R/3QNTXC8MquW6Nbi5nPuzRUo5R+JeU1MASDxiD1UvXpupJnRzrx6NnUx30n6k5+GJqFA1K0LMP7zC0ui+DLoezovXJb1czl2EszGGU/PJpLD+O6GJI7Ph4aQH4XFs3nHAVmE1WuLMvL755xMKEmI4Kr90tgvvFCbo4XTkdoIKz5RmqpWDTd855M9uSNaGARSYOvYfYqxqfCtq+hZ0M0/wLdE2YofkRQkfHTy8s+v6neUGWdwPRaR5OkzJ1ofGncbt9ocoEcFbzbleZAZVkCj6ax81JWmJxwn3toGlLP1JLmTHORGGFuhpRhYAspmr5A9W72Roj6WGOSxr/b3GP/Uan637+yzf85xsabzPRpCyROZnqSNiBhHDWjEuY05mejV2dFhY8Yex2tWpaLIAkcNOJoRuwvzGWMBBumIJVB4gbQ4M+dlss8miSH9ne2038FsPPYXxS8yy1k5QZyNlL08t8+68egysuV5qhsVFWT4cgT7aTi/EVhQkN+BSnIQMl1EaUT5eeVOK+4L1aY+HFKTQLaJoc37BIfGU4RTazDxeXkTmJ2w2hfrNmBPExDhqDpBeiWBoSiJdfh5PvP0wBiiDQLoMTb3AVTiS6e8uGaSlD0JT4M1amRdZoutA6Cz+UCOaEKCHZL5D26JEm4sciXpS4Du1XQseb7mVoaMXaSQf1jPtlYEo/A/OMXf7aaDT/3pwMMpUWtmrHpaJMUzYFpc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB7104.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(396003)(39850400004)(366004)(376002)(136003)(451199015)(6506007)(6512007)(53546011)(31686004)(38100700002)(8676002)(66476007)(66556008)(316002)(66946007)(110136005)(31696002)(86362001)(36756003)(478600001)(186003)(966005)(8936002)(2616005)(6486002)(5660300002)(41300700001)(2906002)(83380400001)(10126625003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dGh1dkRjMEE1VzhKa05wOElqUFBZdlF3dDB5WXR6TG9yRDZCRmlPQmJDTFEy?=
 =?utf-8?B?a3pWWWFQeFVjOU5Kbk9xWk1aMnNhSm5seTRXUDFmTjZHUGZXMXVKUjhpZzBB?=
 =?utf-8?B?K29UL1RXVVRFT1pZb0VUdE9BNTN3ck9mM3R3cStXcmF6QU1jK1QrdDBaN0Ra?=
 =?utf-8?B?MzMwZS9zS2xuL2hXbVZqRmRYbS9OaGkxQS9ONGZtbVBUejVWZVp5LzZBRld0?=
 =?utf-8?B?MHRqdUF4N3NpVDVzbzNKdDdYczU0NkRJNmxSQzYraWRhNnZ2dWVxL3JLRHdo?=
 =?utf-8?B?eFR6a2hjZUVLNlFWWlhMenJpclJ0S1UyUExkcGJNSVhTYXFwUEs3ZmNPRTY2?=
 =?utf-8?B?V0JiSmQ4SkgzV0d3cWwyUTVUM04zWXZUT2F2RXBBSTdpZi9uT2lUZlRQYktq?=
 =?utf-8?B?Y3gvVGZ1bWtCR3pNeXQrQ3hWSXBRbWUwbXBOWkk4MUZsMWdSY2Q4cG5vLzEr?=
 =?utf-8?B?TzFpMnh6YVNEUmI1dG5EVEJJUGNhR2FvOW5DNExjOE1lZCswM2MvcWZiUDlE?=
 =?utf-8?B?U3FpelRXYUdWZGk3NjhPcFNDVkF4L0NldWduZWZ2OXMwTHZ2SG1aZUlRamFF?=
 =?utf-8?B?c2RBbzd5N21TZ3ExbjB1VytiTEJVMzNhbzBWTThuTUZnQUVoaitYSUFmMEVj?=
 =?utf-8?B?TzRiUjhTN0tXV3FYSUNhcS9pL1JmM1h1OWdaNHh4SEx6QlVmeUpxSytGQ1FM?=
 =?utf-8?B?WkRtNThpU1hSSXlCZW40VXEvRVAyMUpGWmp1aHhZcFliaDkyQzg0MmZRUjJv?=
 =?utf-8?B?TnVxMDJ1SVEyRGJ5NUpEZ1BhT0hsVmhtZFgzelMvQURXOTA4RlN4UURNa1Z0?=
 =?utf-8?B?cm1VbG0rdkUzeEJlVWkybGQzeS9Ra2kwbm1LdndYUnpNTEx6ektSSDJ0SWk4?=
 =?utf-8?B?YVd2UWV6b0l6SHRFNkdWTUNtZ0VsTUsydWphQWtlUGJhOE1lSFR0YWZucjVB?=
 =?utf-8?B?b3dWdWxRK3VaMWtGMjJMWmZBU3hqK3U3UFlOc1lJcysxeGlzbEJERmN2SHY4?=
 =?utf-8?B?bHhTWm03bTV2TXZFVjZ0anFtd3pqVFNKMUtsb2hzK2JFQ1pLd3d0WXYzakE2?=
 =?utf-8?B?ajVJU0gxeElqbERQSVhoLzJmQXlNZXdDMjdJT3lMM2ZwMDl0UXlLelRNV1M0?=
 =?utf-8?B?bUlGRjVkUk9WbWgyTFNDb1kwL3NMTTVDcFdNVkdtV01uTGRxSnIvQVNnR1dU?=
 =?utf-8?B?NHZGNWVhK0JUOWwxeXU0dStsZHJFNGRBdExsY2NpbXU4VEtYQ2dBQkNKYTdo?=
 =?utf-8?B?bXRzWnMyMWt3VTZlc1NoeEY0MVNCcXIxRWhrRUVza2ttWEZZc2ZwR1dzYXkw?=
 =?utf-8?B?OXR5UFFGMlZUVnhmWUZmSkpCRGlEcjRhSWhOaWZnRWo5MW9YYUdsaWgyR1p0?=
 =?utf-8?B?U0x0Nmt3QW9jNVUxRElNekljVkZSUkRVUi9OalhlaW5oSkR2RGpMWCtnSVNB?=
 =?utf-8?B?NGl3ZmdGcU42YUhHRUwzZ2duRWJJRTZReThFRWpzbkYvVkJuNVgxVDJxQlJi?=
 =?utf-8?B?MTA3My9HUDF2cXhHN2tmcTIvbVJsVmNBamo0R2twMnFXTTVrRXlELzRsczY1?=
 =?utf-8?B?NFNzbHdLbGlLNVNYelQxSVE4YmlqcWJuVC9YTDgvTFNVUlJIeTFTb2tuUjgr?=
 =?utf-8?B?RXhDbThBZ0ZlVms5V2d4L1BEb2xiMXVBUktIbk0yMXBBNHNWTFpJa3RBdzQ1?=
 =?utf-8?B?MDFIaklDUnRIVlQxOVFBYU14TlJSNUc3VHRCYjNPY0tzc3RBNVRDVnRaV0FS?=
 =?utf-8?B?SzhJdmdDY3Bkd3dBd3B2Y2JtS0x4SlJkL09OazBuSEw5ZlBCU2x0Wi9XbE1x?=
 =?utf-8?B?ZDNHNlhINzJ5TEpOdWFFcENRY2hhY2NRYmlDUUh1WTdKak5MTE50djlwM2Ra?=
 =?utf-8?B?bVRsWTZleHhVUWR1aFc0WThHOWt4UTcycGRmLzd0amphZTMwb0N4ZjJwZ3Zr?=
 =?utf-8?B?QnY5eXVoWlBQdTVlSU84V0FLRHl5N1NDd2MyRXI5K0RtbklCa3BNV2FIQnFP?=
 =?utf-8?B?ajgwaHFWNzFjdU9OOGoyejhBaVBBRXVOd3VPRlg1cDVzWTdLRVZuajl1QjAz?=
 =?utf-8?B?QmZ3amg4S3FtUnFtdkp5MlRZRFprTTNlVTNtamxRakxiQTVnYzRVZE5KVUhM?=
 =?utf-8?B?YzJCRGpFZmRzdmhTWG1hSjE2TTllY0hBQmVzVjNzKzg5UHkxOWg4ZzVDWDgw?=
 =?utf-8?Q?bpt1gokaAy2DrF38+gp2pb6pI8zrp+sedXyc6O1+QQxm?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f2afc6f-bffa-4fa0-b719-08daa20f7e56
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB7104.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2022 11:41:05.5111
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FOraNgxUq1FYIda6O2AeEd57i2fDjok/r6l1I/qDddA8u9IcAqoqWPOAGNDtjmUD1Ff6d8muBXy/XosWjejCbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7229
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 20.09.22 16:47, Rondreis wrote:
> Hello,
> 
> When fuzzing the Linux kernel driver v6.0-rc6, the following crash was
> triggered.
> 
> HEAD commit: 521a547ced6477c54b4b0cc206000406c221b4d6
> git tree: upstream
> 
> kernel config: https://pastebin.com/raw/hekxU61F
> console output: https://pastebin.com/raw/gvADdA0t
> 
> Sorry for failing to extract the reproducer. But on other versions of
> Linux, I also triggered this crash.
> 
> I would appreciate it if you have any idea how to solve this bug.
> 
> The crash report is as follows:
> ==================================================================
> BUG: KASAN: use-after-free in keyspan_close+0x240/0x260

> kasan_report+0x8a/0x1b0 mm/kasan/report.c:495
> keyspan_close+0x240/0x260 drivers/usb/serial/keyspan.c:1589
> serial_port_shutdown+0x89/0x110 drivers/usb/serial/usb-serial.c:309
> tty_port_shutdown+0x1ec/0x270 drivers/tty/tty_port.c:379
> tty_port_hangup+0x103/0x170 drivers/tty/tty_port.c:407
> __tty_hangup.part.0+0x65b/0x770 drivers/tty/tty_io.c:660
> __tty_hangup drivers/tty/tty_io.c:592 [inline]
> tty_vhangup drivers/tty/tty_io.c:707 [inline]
> tty_ioctl+0x956/0x1430 drivers/tty/tty_io.c:2718

This is triggered regularly by the reproducer:
r0 = openat$ttynull(0xffffffffffffff9c, 
&(0x7f00000000c0)='/dev/ttyUSB1', 0x0, 0x0)
[..]
ioctl$TIOCVHANGUP(r0, 0x5437, 0x0)

basically just the ioctl()

> Freed by task 9889:

> usb_serial_device_remove+0x13f/0x1a0 drivers/usb/serial/bus.c:97
> device_remove+0xc8/0x170 drivers/base/dd.c:548
> __device_release_driver drivers/base/dd.c:1249 [inline]
> device_release_driver_internal+0x1a7/0x360 drivers/base/dd.c:1275
> bus_remove_device+0x2e3/0x590 drivers/base/bus.c:529
> device_del+0x5d2/0xe80 drivers/base/core.c:3704
> usb_serial_disconnect+0x23e/0x3b0 drivers/usb/serial/usb-serial.c:1205
> usb_unbind_interface+0x1bd/0x890 drivers/usb/core/driver.c:458
> device_remove drivers/base/dd.c:550 [inline]

Regular disconnect

Looking at keyspan_close():

static void keyspan_close(struct usb_serial_port *port)
{
         int                     i;
         struct keyspan_port_private     *p_priv;

         p_priv = usb_get_serial_port_data(port);

         p_priv->rts_state = 0;
         p_priv->dtr_state = 0;

         keyspan_send_setup(port, 2);

It is clearly written so that it must never run after
usb_serial_disconnect(). I must say that I do not clearly
understand how this is achieved.

For testing purposes could you add a check for !serial->disconnected
to the call of close() in serial_port_shutdown()?

	Regards
		Oliver

