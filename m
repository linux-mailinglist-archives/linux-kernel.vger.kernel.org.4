Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07292649EA6
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 13:29:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232023AbiLLM3e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 07:29:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231370AbiLLM3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 07:29:31 -0500
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2089.outbound.protection.outlook.com [40.107.103.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BD9FF009;
        Mon, 12 Dec 2022 04:29:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e54l0wtwoDCYa0CD+7XrAJUIo/bDQ+GXVICt2b5ylsSS29PcoRLL3ylS5e4i9xJr0ttuioEUmVKZ9L5MyHUQO7N3amO06OKyHl5mOHNCPe+DTPbVAYQtj/W9Pd2C8Ygj1M8fmKmiAtit1EtF5dX4syiSoRK8vydV/CwQsOANbAnegGXroZ0cV2GpjcBdk+X0fHkQtwOtjjAK7t+mVsTFjk7bNCS7he5bsHj74jRauuU0NMMppW/Dit/m+msT1CuRPEUkhbkGTVIkeB0lc5dzEiip0CW1V8Dx6PgXqCsIpclqHHfE1cshZsMJYqqeXZs5nsifjsNmPJKymw+nDe84wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eBL0PDIA4RLImN/wpDPulA+KRpDhIYcQtoLTV5SGAFc=;
 b=AEu0KiujZk/Ak/qD3wb43iJBMt4+b3NCKp6frQBk40UCk50fBUyFnA7U2KNyBqGp5ulD3f3GUAQHvkqN08jX1+v9tNjGDGu03hztbwNQ0OY8OQzGhR6rRyBjnizAO+fgVhM+ySuROv6bcAWtzTk70WaBQmWGLLVD98XiNlvRBfDQ3DWOIbtQSVm3ytr2QGTlssH+M/RMjI4Pr/TaXYjGaOYA7jhOsjXKppiY8yMfzRQTj9J5KJriwVHLtHx+qFBVEQR20+3RXM212issEOEYFgHg/HcNbwQCRb0J97UctK6hV2LFQ/y8o1Zj1miIDQt2ye5cEKl0KSQbuQo2gXPIWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eBL0PDIA4RLImN/wpDPulA+KRpDhIYcQtoLTV5SGAFc=;
 b=aG73RQwB+sK/4Kanrc0Xi3XsCxggY7qWKz28yWi42mNOw6nydGq5wT8tVKI4wnR9vmPLmIDtGUod0POollq5emAeMUblinQB9I57OtWytiWSJ6OzFHJSKQiaR9cnZgcAg+J//XdMfBQVL7lahMzMWR1T+U8FdFA7nAhxsqnesUKX9KnWo3Gf9taMhvz/YFiIbv8pNQYW0ljWpsZU6FIFdMO2aRJDMoslscuBtOP8TBw/iqFV+EBOpk6mvM7tlNZMzhJ1A1w87zz2kp8p/1JuDpz9EgweJbbkFB8yuEUWRYE6cd8/8fJiq2FbHA/Gnea+lRF7ghnQwiK9x8h5g2uWAA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB7104.eurprd04.prod.outlook.com (2603:10a6:800:126::9)
 by VE1PR04MB7264.eurprd04.prod.outlook.com (2603:10a6:800:1b1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.8; Mon, 12 Dec
 2022 12:29:27 +0000
Received: from VI1PR04MB7104.eurprd04.prod.outlook.com
 ([fe80::ae59:a542:9cbc:5b3]) by VI1PR04MB7104.eurprd04.prod.outlook.com
 ([fe80::ae59:a542:9cbc:5b3%9]) with mapi id 15.20.5880.019; Mon, 12 Dec 2022
 12:29:27 +0000
Message-ID: <8e60fa70-15f5-e438-cb49-d3d2281bc975@suse.com>
Date:   Mon, 12 Dec 2022 13:29:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [syzbot] KASAN: use-after-free Read in __usb_hcd_giveback_urb (2)
Content-Language: en-US
To:     Alan Stern <stern@rowland.harvard.edu>,
        Oliver Neukum <oneukum@suse.com>
Cc:     syzbot <syzbot+712fd0e60dda3ba34642@syzkaller.appspotmail.com>,
        WeitaoWang-oc@zhaoxin.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, khalid.masum.92@gmail.com,
        kishon@ti.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <0000000000002fc8dc05ef267a9f@google.com>
 <Y49h3MX8iXEO/na+@rowland.harvard.edu>
 <cac60598-5080-5876-d28d-e8caab8b9b0f@suse.com>
 <Y5IhgenNzQXzbWqT@rowland.harvard.edu>
From:   Oliver Neukum <oneukum@suse.com>
In-Reply-To: <Y5IhgenNzQXzbWqT@rowland.harvard.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0060.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::17) To VI1PR04MB7104.eurprd04.prod.outlook.com
 (2603:10a6:800:126::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB7104:EE_|VE1PR04MB7264:EE_
X-MS-Office365-Filtering-Correlation-Id: f73b14ce-1a68-40e8-df0f-08dadc3c82ab
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dOo+UsZAlDJPyoJPLXv58Ny0HPrGi0rbkQKnhwGdVyWHe+a2ooMlFMuV5fjWblxACsYqfyRm4EhIKeGJ236AQz5Omnn3D6WpwxSlPPsBn80cFAMFsj10HBdRKdBK78EJx9G9Ov5acE4VOy9rCtJLb9sLakCZdx6xKZTMhPqLmB5HnPyFKtA76zrro9Jq+cirLfbXVgK07buH9+xZ6N8tonZfp512/heK5EcwEXoEzw+O9jDAVOhig4zvJJv7rHCRSD4hjymuEgxEl5gD2bYiqxVWZV2WwVsRqG3euwVEVeQsp3hpXKeFW65A1JRWVnbbX36a10HsKuTa/k2dJjoTnUjrVe1qZxvHh3UBiIuBsgsRlr1CEVjovzAlgvHNTjB9iiyjXFcxd+E6QuLQgQGTr4Q9rcJpWqoPMNtCiP0hWQXq6SpZY/D4Zk9vmIah5qVLdxKpV7GlchqDFQ6evBRWPidKGcyVrBW9K9j5/C6Sfa+9iAJh6AcWBuO4ql3BD6qOXnp6UeDC4dgWho9BpzO1K0FL9+mWCfQ7dnZyjaICj06T4zhVzXtJTPDWgcirZXEI2mCEr6bZ1JPHc9z7HMJcKME7ZZzNS2vgqTlFhqkx6fnmJtP5itqW1NxwIEpretycENBxJnCwZXoHPBm2/qCkbNYaQUAxTduGnrxohy3USqED2RBc0PJF4a856MtSeQoy1KtRZ87D8IezlTfzTt0hVXQc6MACXkjuxMQ51aZYVbgf132uLhdJiAOnufoznqbA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB7104.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39850400004)(366004)(376002)(136003)(346002)(396003)(451199015)(38100700002)(31696002)(86362001)(478600001)(6486002)(8936002)(6666004)(66556008)(41300700001)(8676002)(110136005)(66476007)(4326008)(66946007)(6512007)(83380400001)(2906002)(53546011)(316002)(6506007)(186003)(5660300002)(2616005)(7416002)(31686004)(36756003)(87944006)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eG1Qb0VOL0VzUFhNMlpXWEFZWE5vQ3V2dGNNM1ZZejU1eDJ4MHV5Qks0TWtX?=
 =?utf-8?B?Q00rVlZFYzVCNXhBKytzQjlYSUwxWDNQSjlvT0JLOUtibTFNRjhHdDNqcWpu?=
 =?utf-8?B?b3Z2Z3l1b01sK0xUSWRxZzAyYy9KcDMvVk1pNXlaVUNPRnE3eHJqT1FqbFBT?=
 =?utf-8?B?a0hZaWJPYlRqTzluTTNZMVdpQWNYL2M1K0twYW9nWXZjRG9uZkNwbnZleUtJ?=
 =?utf-8?B?SUxNdExEYjBzTW9aQ1M3TG8wdU43TVhnZkliZkJEbVhCVzNWSzlsL29BYzhU?=
 =?utf-8?B?Z2RDTVU3SVdweVVHdUJmeXhwZkxzL0xpaVJ1UVV3Rk5VOGh4dzdoM05hWDNW?=
 =?utf-8?B?NFV3YXJjVmhNZmsyKy9LUkxEbTBENnJoTHo1UnE2bGhaSHdtR1c3Smd1Wmd5?=
 =?utf-8?B?alo4ajAybEgreVY2bEtGalk5SHVnSmhFRXNGR0FKSk5VazA5UXQzcHdNV0Vx?=
 =?utf-8?B?YjNtdXVDcFl1UlhReVlDeXFYL3FDS2RRWGI0eW1ISEM4S3hoRkNiYmMySkJy?=
 =?utf-8?B?d0dNRmJiK1BOSlVmeGtjT1NoUC9NMXJXZHpoQWxCVE9BWmhjZExPK2t5d0Nq?=
 =?utf-8?B?N01qTTRRb1h2Ukl0TDFXbHVLZWRCTkRNQStTRFZJTVljdTNpZm0zUlkzVXZh?=
 =?utf-8?B?WnA2UDFQWWRRRXptam9kZndwV2R1UHRnN0RZekdYSkdWS0lOSnNpV25OUHVL?=
 =?utf-8?B?VURlVmhtWFNxYlg2c0ZxaG9EU2x5N1JPcGs4cEhtdmxwNktDY2F5eDZUN0kr?=
 =?utf-8?B?OFlFU0NzTzZMVEZWVmhlblFSbDBCcjR6VCtYK0M1azFOSGFuQ1dseWJhUGF5?=
 =?utf-8?B?M0wvelhRWHp5UTJMcE9Ubm1KUjFJTDZlVXcxOWJLOUZkSDdZNi9zVUVhazA4?=
 =?utf-8?B?azc0TkMyck9kR3YzT21KTndobHAxczh6VzdsRmxxb2Vqb3ZPWUhhVjVoOGFP?=
 =?utf-8?B?djgrdkpLTktGL0R1ZTFuYzNSMnRTVUFlanFGaXVETndQd1M2UkdUdWRsMWNN?=
 =?utf-8?B?Tm1naGswYWFzcldTRTRoUFhpWVF3ODlEYjhLeThZRVVJelpFMnpGajdLRlRt?=
 =?utf-8?B?aVY0UFVkOU1raTdFTDF2N3dkQ1llT0ZDRW83VVBHUnNaM3c4Z0FuUkVDeXRE?=
 =?utf-8?B?cGNWd3hrYmRFSTZLRTlBUWpDd3Yzc21CclVmblhqK3IrZzE1Q0NtK3NJczlL?=
 =?utf-8?B?WEpCdGtIWWFNSjBjK3Jkd0xyMGdjeXQvMWpFbDZhOXVVc2xsRjhKTUxtRzA5?=
 =?utf-8?B?b2dPR3VQZk4zRlhCbGlpVjRVb0dRWVd1YUJ5eTFmZFE3Y3FyQ2hVREU0V1dL?=
 =?utf-8?B?d2NibWdKeUNvaW1FK2R6eVByS21jLy9hWThBZWpMU2s2eFZUT2FSc3lQYVJQ?=
 =?utf-8?B?aHhqNW12TFF5cHo3NWg5bytLd3FHY1Vxb1V3ZE02blpVRE1Cb3NrQ3JvYk9s?=
 =?utf-8?B?NVZyZVBJZFVNcUdpc1E5V1kwVFB0QWlRb0pGWUVnem9YbERsUmFTT3JDeW9T?=
 =?utf-8?B?MmdCd0NxK2VBMWpRbHE1d3doMU1TZG16MktERE9ucUtDbUFvNW5GOHJ1OEhx?=
 =?utf-8?B?b04xZzZRby9Qb0tzMFJDQ2h3REZxdXp1YWh5alE5RStDNDJBeXJIS0VUOGk5?=
 =?utf-8?B?V2toaFhsMTZ2Qk9Ba0FIaCs3NzIyTE1VY2hkY09ISTZld3o1byt0S3JRSHJD?=
 =?utf-8?B?QzdXR3JWbUQ4NWNaamJ1eHlWWCtjWW93Yi9BZnpOcTR1NGFUWlJ1Tlc2UXYy?=
 =?utf-8?B?d3BWNjZ5QitnK3VMRmVTNWNFdlVDMWxTdEU3UDl5N09RVkFNNjhOUjBDY2du?=
 =?utf-8?B?ZCtMazFybTRlUlhJV3Vtck5mdk1kL29vQ1lzeit5MkxuWE4vUU5kYSs2TkZ4?=
 =?utf-8?B?M1hpSmFOQWlQZThYaEs4am9sTkNUOWZldVRjV2pVeSt6OGhCbHMyUFFGelBl?=
 =?utf-8?B?ajBkMVBWYi81MEgwcE1VdkFhalkyS2NpNnJnM3hETElSa2JXQVRKRzVQNStl?=
 =?utf-8?B?aWh3eDBRNUtkY2o3ZkNDMXduV1RsaXBXQUxUQ2JUK3NLUmR4OUg5MjRyT29K?=
 =?utf-8?B?VFoxYk1uVFFkZ2hoMllINXVqbkF2UjJaT1JnRHNVUDdZQ1p1dEtzbmtrQTZ5?=
 =?utf-8?B?ODIwemovbmh1d2FGZEhiVHhKWkUyNFhwVHl4UEtuY1RPNXJTclhFWlF3Vnor?=
 =?utf-8?Q?AK7hIS93Pe2d5sTR/PvYoIlsFUvzyOh2w74vKGOeIvkM?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f73b14ce-1a68-40e8-df0f-08dadc3c82ab
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB7104.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2022 12:29:27.6671
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: grIGln+biT8Vjx06L6ya2lPhwg7Ji9yeBzZkP+yTFaIyiNu5b+fnd7t2PxbOkOPEYgwStPT9fSGiHQLijehiDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7264
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08.12.22 18:40, Alan Stern wrote:
> On Thu, Dec 08, 2022 at 03:36:45PM +0100, Oliver Neukum wrote:
>> On 06.12.22 16:38, Alan Stern wrote:

> It's hard to tell what's really going on.  Looking at
> xpad_stop_output(), you see that it doesn't do anything if xpad->type is
> XTYPE_UNKNOWN.  Is that what happened here?

The output anchor in xpad was used. So I have to answer that in the negative.
  
> I can't figure out where the underlying race is.  Maybe it's not
> directly connected with anchors after all.
> 
>> As far as I can tell the order we decrease use_count is correct. But:
>>
>> 6ec4147e7bdbd (Hans de Goede             2013-10-09 17:01:41 +0200 1674)        usb_anchor_resume_wakeups(anchor);
>> 94dfd7edfd5c9 (Ming Lei                  2013-07-03 22:53:07 +0800 1675)        atomic_dec(&urb->use_count);
>>
>> Do we need to guarantee memory ordering here?
> 
> I don't think we need to do anything more.  usb_kill_urb() is careful to
> wait for completion handlers to finish, and we already have

By checking use_count

> smp_mb__after_atomic() barriers in the appropriate places to ensure
> proper memory ordering.

Do we? Looking at __usb_hcd_giveback_urb():

         usb_unanchor_urb(urb);

This is an implicit memory barrier

         if (likely(status == 0))
                 usb_led_activity(USB_LED_EVENT_HOST);

         /* pass ownership to the completion handler */
         urb->status = status;
         /*
          * This function can be called in task context inside another remote
          * coverage collection section, but kcov doesn't support that kind of
          * recursion yet. Only collect coverage in softirq context for now.
          */
         kcov_remote_start_usb_softirq((u64)urb->dev->bus->busnum);
         urb->complete(urb);
         kcov_remote_stop_softirq();

         usb_anchor_resume_wakeups(anchor);
         atomic_dec(&urb->use_count);
         /*
          * Order the write of urb->use_count above before the read
          * of urb->reject below.  Pairs with the memory barriers in
          * usb_kill_urb() and usb_poison_urb().
          */
         smp_mb__after_atomic();

That is the latest time use_count can go to zero.
But what is the earliest time the CPU could reorder setting use_count to zero?
Try as I might the last certain memory barrier I can find in this function
is usb_unanchor_urb().
That means another CPU can complete usb_kill_urb() before usb_anchor_resume_wakeups()
runs.

         usb_anchor_resume_wakeups(anchor);

I think we need a memory barrier here, too.

         atomic_dec(&urb->use_count);

	Regards
		Oliver
