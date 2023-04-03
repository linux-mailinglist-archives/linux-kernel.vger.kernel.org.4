Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AD576D3F7B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 10:54:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231702AbjDCIyN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 04:54:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbjDCIyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 04:54:11 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2045.outbound.protection.outlook.com [40.107.105.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CC80172B;
        Mon,  3 Apr 2023 01:54:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GfdYP7UHmcGxfWOnz7j8O8PL4ey2zI1VffD44qGTi3DogN3P2qA+q5Dym9WLkEEBH7hMOA7YvmaLES10Ic5q/lE97RGHRdLx8ODBUGi4iALEBgsTMKvkTfqYvzsRRpYQV2Ht+MtwMY9GUuWDCBBlX2OvIeQKmGxqjA8trMs2IZter6slWFIk027vHrxebsmteKU/TzT14N0oMtgOpb2NziD8vhB8DyJpM0mQgYFHPQ/vGdqgnxw+QMa6qC/7r/HDDzj2xC5L5Gif0zygMcb2m0g4aug3yvTbsqA3nJl7/hXr+AHxwGp9ifY8AwPmMAlG3S1dkKyYexVjJabwdl5pBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rYaY2Wdk3FyM/fCEIyKj2Dxn3JHCEK5g2BJaNs+5dqs=;
 b=LIQqMsQswHaimk5WhTnkYM5wjY0Ahn8ykJYZXNHQzzxr2vZBak1s1YlFV0FrkAyRyZmj0JIFs9V1dhg0n73UdKKHO+tJarx51U71m+YsPUD8MiRHJ4O2sFZeCduDPZlKihaySLQ8reyAixExSNYy5TPGHt0v/Fs9fh3L/GR6SNN7J9gDWERqDy4SJuLdKCl2bw2AjWZ4zlGqr5MgsV3TwVwZ7QH12A7Xvvnq2/myxCuYezBHc82cZXUDkJyUzzlXmMxsOTGKI4uFQFwufTxA8pSc6h4eD/ZKNckYsf511m0/VpHCT7M5GaHd1rVxOXct2pJRM/gtX/Jlla5R+AeHTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rYaY2Wdk3FyM/fCEIyKj2Dxn3JHCEK5g2BJaNs+5dqs=;
 b=tcAaruTogeedVrWv5vqqK/pOpPBhcKGZSflz+zQC8XvUDL5tiJ7hzVzdxZWZS3/CW9R82kpjj13aHgCmBQ4wCydP9jFW9SybPFvXG5KcTMjka8ixsQERnEmo/wN4IKVL+86CFToTET03xWaI7EUICb7Jjjz/znng8bvWy8PvG+E0anhaS1t8tWttLm7hPotJiIEirReCji9w16ciYu4mmNVrDuaNDmHnSr/HVmRuQam9R0+CDf4cXH73uT0HnaYzBXSvJtKkGei9+oWqQy8t/KP2noEI6I+2x377tnzpGtBQ5eLhWjibitXSCBOX6xgJQ5Y8NPK258vc8dzoHmhzAA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB7104.eurprd04.prod.outlook.com (2603:10a6:800:126::9)
 by AS4PR04MB9484.eurprd04.prod.outlook.com (2603:10a6:20b:4ed::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Mon, 3 Apr
 2023 08:54:08 +0000
Received: from VI1PR04MB7104.eurprd04.prod.outlook.com
 ([fe80::74bd:991c:527d:aa61]) by VI1PR04MB7104.eurprd04.prod.outlook.com
 ([fe80::74bd:991c:527d:aa61%9]) with mapi id 15.20.6254.033; Mon, 3 Apr 2023
 08:54:08 +0000
Message-ID: <7b1f757b-b626-5d49-354e-343e040b8762@suse.com>
Date:   Mon, 3 Apr 2023 10:54:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [syzbot] WARNING in sisusb_send_bulk_msg/usb_submit_urb
To:     Alan Stern <stern@rowland.harvard.edu>,
        syzbot <syzbot+23be03b56c5259385d79@syzkaller.appspotmail.com>,
        Thomas Winischhofer <thomas@winischhofer.net>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
References: <00000000000096e4f905f81b2702@google.com>
 <b799fc68-8840-43e7-85f5-27e1e6457a44@rowland.harvard.edu>
Content-Language: en-US
From:   Oliver Neukum <oneukum@suse.com>
In-Reply-To: <b799fc68-8840-43e7-85f5-27e1e6457a44@rowland.harvard.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0159.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a2::19) To VI1PR04MB7104.eurprd04.prod.outlook.com
 (2603:10a6:800:126::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB7104:EE_|AS4PR04MB9484:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d55ab84-473e-4248-b99f-08db3420fbff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0a2WqvK8ofAxr6/rrATyuFa1PTbteMz0xj+EAqh+cCEkXvqQ5efNt0WUx6a+0Xfqt6yjGHZ6k7h9AH7U7Hy6Zcsqre4kVjnAZHQA2QjeJGutfx/7MJx9yY+MP65d59mA7RWbUzhOmAoy0Xs7VNCWWQ7dWZWHvAz7sNFuRJRS9qe6aMxX6BAEwIx2iaQlmy0Wjoos9xgNtOr8laYarv5Q91UVjIjBk/NeH4OxpvAj3pKWi9+lv8uiylRC2DEgVWCAq4hAtf03PTcKpRU05rRgw5TAenKrL9heRzQ46VBOeVbwKY5amGQBFiJHWuW8Y1vsn+8EH14VE1nvKv/wtG5K8ztofQC7VBFvIuWNPjQZN4Sugah6/9Oid6DSFDVvZ3UHFykTE0oAlBtReJ+KusBEKv1tmkfUql7h+ubNhHFZGwQKpbfZX94TLeQVCKcmvmeqNhCNFQfkbRUG7iFGU3IYRcIbX6LVvYffuGsykvhyumEw7c67XhFeVybRuRWGSgR0pJiArB1B64FTff2/ckpxQKVPGJ+JUMixVBOPkqSL/GzOVZdRFHSsBiO1NwYKIQFjwZ8aOHEgO79Q9PETwuLl5p6UbQPfI5dxE1SUyb9jy8D1iVHBKQ98EZBGfbtjW2ATdEjPmfFJGtGDkf6Edy2rUDqRmol2yVScQs5o4MEldN0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB7104.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(136003)(396003)(376002)(39860400002)(451199021)(31696002)(86362001)(36756003)(2906002)(31686004)(2616005)(966005)(53546011)(83380400001)(186003)(6512007)(6506007)(6486002)(6666004)(4326008)(8676002)(66946007)(66556008)(66476007)(41300700001)(5660300002)(38100700002)(110136005)(316002)(478600001)(4744005)(8936002)(99710200001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K3liUlFsVTFlVWNncXd1YVFCSlVNVjBWSlVXaW14d2V5d0Q3cmV5NHJWTy9B?=
 =?utf-8?B?QWoyVCtRUjhXVXBka21Pd2RPd2E4SUp4Y3hqR0JFT1VKWFpaMU5td29mL0VP?=
 =?utf-8?B?R2tjZnpBZGZmMGJGRklKVXp3Wjl1ZXp0ZEE1NXArU2dCd0pNSm05U3RpVEMx?=
 =?utf-8?B?U09xT0RzZGt4V0IvY1kvQUFvWVN0TEl3T3BLZ0o2ZkxCaVNMYWJON2hGU3dQ?=
 =?utf-8?B?WHQ2UzhlNytGclMrcGcrR05BOFBlMmhxTmdQdVRaM3FUbkNWQnluTUFMWmlM?=
 =?utf-8?B?Q29OODIxQzdhb21jKy9lUGxjRFphNVlEUUtiRHUwSWRLT0grc1loNm5XSDAr?=
 =?utf-8?B?cGIxR2Jqc0RGNUhrOWxubEV4K0pnZEVkdFdiZEpUbDFLVTRkeTJoV1UyUlBX?=
 =?utf-8?B?NFg4Y2NXaDBlNmlzaDJKbDJXOUUwNTNBM2dZeHBYSzhldytNWFZPUTRocldL?=
 =?utf-8?B?c0NWdFFQZmREcVVGUSt2bXJwV3BLL1N1WjZ3YzJHQVhrZXhaVzNaODZ6NHFp?=
 =?utf-8?B?dDdsUm5QTFNHNW10Z1BCUEg5U0YxQVVaY1hkaWVkNFJUT3liZDZEVGJkVDJN?=
 =?utf-8?B?cWdVY0JUb2Ntc1pnMkNNTXFnVjJYdk1nWlN2VnRJVkNGbld2cjVUWnZBL29D?=
 =?utf-8?B?VHA0WXFDdlk4MEN3YzEvWCs0Qk81S0F2ZnpuQnZpWUp1K1BmR2cxdWM3WTVr?=
 =?utf-8?B?TW8rdFVQem1SeVF1YTVuR3pGQmVkcU96RXNsdGNSTlNYQk80TWp0N1kvRFFW?=
 =?utf-8?B?NGtpM3lPZ3hSMmdWbGgvZW5kM3daWm44NGhZMlJmVVRqeTJVMloyUG9KeFly?=
 =?utf-8?B?S0JHZlRBN2p0ZFFXdytuZHd5b0NKeU9iRXV2K1VISVNVcE1MVHcvRkR0Qjdh?=
 =?utf-8?B?UlZ4Tk1YbUlFandwTVU4OFlzZzJpNVFQeFFvN1FYMHczbTdYa2RzTjlWS29p?=
 =?utf-8?B?OUlKckZWQlRiV3BOZWhpMlFtZTNYME5HUWlFOGlFajk0ckFZa1J0OVNwUEg1?=
 =?utf-8?B?YjZPSnB5S1NuZmh3Tk9aZHlzd1hNKzQzYm1NT2NCT0U4SjVZL3A4RnN1YWFS?=
 =?utf-8?B?c0hoMXpHeXRtSWR1RldZU0M2ekVsNG1xRG8zcW9SQ01XaUZWcUNKK3RSRnVj?=
 =?utf-8?B?aXNhbmpRRVE2a0s0MXpSazhja2o4REVSWWc0ckkyNTdjQ2ZySnczdHE3TE5v?=
 =?utf-8?B?WFJLOTVNZVZBVTl6OU4xcW4xMUdkak1TUlpuUGZIdjBBVDk2TmN2MGl0LzR0?=
 =?utf-8?B?RkNQQ1RiMnIzMGVqSDNVOFg2cHI1L21XYWFld3RCMFRjWHRxL2lzSDEyR01E?=
 =?utf-8?B?N3RTSU9CN3lxRXN0TUFHS3B0M01uS0pNblJDWjl6amRBT01EODNleXY1TnBy?=
 =?utf-8?B?RVl4VnNvTElMd1U1ZWpsV1gyOGorbUhlVndRdnF0eTZYT01mN0Jsc3NRQ0pQ?=
 =?utf-8?B?RkdtTFBRZ0wwZmpDUE1iTkdubVZPT2c0azRDbmFXV21uRmFjcG9KOHNXSFdQ?=
 =?utf-8?B?UUNmMkIwZVNkdGRUN3o1UTdLYWhmS0ZGb2RlQ1I1MFNYVm1BLzZtSkk4TUht?=
 =?utf-8?B?SFBBSXJtSnNIdmJZdSthUmpKaDhGZFQvT0c1UkF3aTVERGNtZ2pwejFMcUZz?=
 =?utf-8?B?Q1lTcGtuRkRDcEp6NkhqWVl3aHU4eDJKL0ZXNFpET201ZU5kZmN1OWIzRk5v?=
 =?utf-8?B?bXNoNlBTbjREOE1rVVc2bHdEdzlXV1JaRTVmWWxsN1JCWWJvRzdIZ0lIU29X?=
 =?utf-8?B?c2NsUldaczhYa2hUSm9aSGtRVzFxeU9iRVlPdTdJT3dRZkF3RzNzYXpwOExN?=
 =?utf-8?B?RkFlNGlDcEo3WEF6NlF6cUlmaDBNOFkvc3FWdnAyL0xPZ1pkUDZ2dm9vd29V?=
 =?utf-8?B?NUU4dGZCT0wrZzBTcHlQVGlJancwSjFnWG9ZcWxWWEczMENIdnZzM3FKTzZ2?=
 =?utf-8?B?VFJBb3ZTVHg4TzE3emowU2hXYlgvV2VOM2JIcVUzMGlqc3UzR0Ntc3ZHVzJn?=
 =?utf-8?B?TGdaVGptOC9QNXc5LzRiOEs2bUxVNTdja2cweGdCNzJrMXdYWG9zdVh3Uncr?=
 =?utf-8?B?b1pzeEwrQW9kNmd5NVlIZUo2Vkl2NFErdURNMXdsWlJUcmozMXhicVdZR1lJ?=
 =?utf-8?B?YXB2N1o4RTFyZ3l2ZjNBdUtTK0x1dWFRWHFZam1CMW1ldFd1K2dpSGRCd29Z?=
 =?utf-8?Q?suS7ivD+pZpqdl9LuYfWT0YcuNgyGq4ZTywGXZF2d9T2?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d55ab84-473e-4248-b99f-08db3420fbff
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB7104.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2023 08:54:08.1775
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v/6Nte38lX2+NTjt/13mO2xQlxw0zLAjV1NzIkvjFDhsxmnClbBPOHNCzKQYy0lazCBhHUHHx4LDK9u+cMZcmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9484
X-Spam-Status: No, score=-1.6 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 30.03.23 17:34, Alan Stern wrote:
> Reference: https://syzkaller.appspot.com/bug?extid=23be03b56c5259385d79
> 
> The sisusbvga driver just assumes that the endpoints it uses will be
> present, without checking.  I don't know anything about this driver, so
> the fix below may not be entirely correct.

Hi,

this patch by itself looks good to me.

But the need for it is problematic. Do we have any vendor specific driver
that could get away without an equivalent to this patch without showing
an equivalent bug? If so, why do we have a generic matching code, although
it is always insufficient?

What is the purpose of a generic binding interface in sysfs if every probe()
method blocks it? Allowing a generic probe looks like a misdesign under these
circumstances. You'd really want to add IDs to drivers.

	Regards
		Oliver

