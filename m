Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDA206D4B0C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 16:52:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234076AbjDCOwP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 10:52:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233990AbjDCOvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 10:51:51 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2074.outbound.protection.outlook.com [40.107.15.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B11C92987C;
        Mon,  3 Apr 2023 07:51:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U972j1htJ+Ydo2b/VPn+WhHXrE6g1MrHSNWIHq4aSMyKcOqBX49tKPgX/0zgSjgY+UGHkBeA7sjRO/vUu5pgcf/FQZqvovjSuLZnf2edbL/b06OVZJ13V3nDdlANiU5UEUeDEHovYKmxseqWouRW1oj+8tBG1BJBGSKFBlTMQTZnV7XudwPBMtowHp6dYRyzJuK9aaTSSsGN8P/AGhtS7/CT6x6gDXX+uDx9MOEaR97lJTqsbfzmw4N+ytLSNfv/4mqALUSi9YnrERVElBqstc8RYgzZhz97rXPz5mjAzV7nxttl2dQ2PrYaC3f3A69HCiPOsc6a+DXYjhg6nzp8Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RpeVt0FD3MNjcc7P5BbAxd8/K16WBI3sEtn8tQ1FuVk=;
 b=Vjwtvk5pSsA21fe6LhtNCE8hB40XVr8wsWw2pzqnrXhrlpo0TtP+DOqOMrmSPMGrdHhTGmyG910x3eWDpvU7P4g5IHrEkj2vVPpX1gT0RLFnLhT0Mb9cIXIab/eamZJWZLQMoxn2zBFOW8zL/YjaOj9PZDYdKLbA4dPLlKzDqwbfXXIDGld3zOQjFsBMhc6mSU7g45wbeilYkOTDAQertktmh7rByxSJGW9hqG117X5UPkqYIotp/GuNbLye2ISjgY7rD05F8KUo8nLuWMXoLXES0B32gnTMM3Vf/GFNzBCYWnzvtxIX3QQXBEC7jxgs3L57jVPPaY6tzY7PWringQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RpeVt0FD3MNjcc7P5BbAxd8/K16WBI3sEtn8tQ1FuVk=;
 b=cbLttsNA9HWi7buR6eMU+zf+ECncPWaaXrRAINhNd1BXCf6TF+xEQcA+H7vkmkruS4cITPuMCULWtkBk6m7QqY0fW7C0jYTSvjAltjN8Q9xXjWM0hMJqEvqB6pNrrOpfhz9YETsvxhbczB6ZxqrsPUbmGOOqQmHzq3fu1Ft0wFFHK3Y6mx9fdYDnlhaNuuhYduPPUpvb0Nh8KtBBAHUdSdwoen/013UB+RjYPv12UeDpRjFY1yoMUgC6pbCa/mPe4bOK94FBfAqfmyKppPI/Ex/Bjp0jAEQmo+p6fKCx7FmkfMm/1sZk0sZ3WpvxfrR5zVqLP9dIIFCP5M/yzqyghA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB7104.eurprd04.prod.outlook.com (2603:10a6:800:126::9)
 by PAXPR04MB9231.eurprd04.prod.outlook.com (2603:10a6:102:2bb::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Mon, 3 Apr
 2023 14:51:34 +0000
Received: from VI1PR04MB7104.eurprd04.prod.outlook.com
 ([fe80::74bd:991c:527d:aa61]) by VI1PR04MB7104.eurprd04.prod.outlook.com
 ([fe80::74bd:991c:527d:aa61%9]) with mapi id 15.20.6254.033; Mon, 3 Apr 2023
 14:51:34 +0000
Message-ID: <97ea1633-3c9e-5042-4edc-8c52f668cc9e@suse.com>
Date:   Mon, 3 Apr 2023 16:51:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [syzbot] WARNING in sisusb_send_bulk_msg/usb_submit_urb
Content-Language: en-US
To:     Alan Stern <stern@rowland.harvard.edu>,
        Oliver Neukum <oneukum@suse.com>
Cc:     syzbot <syzbot+23be03b56c5259385d79@syzkaller.appspotmail.com>,
        Thomas Winischhofer <thomas@winischhofer.net>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
References: <00000000000096e4f905f81b2702@google.com>
 <b799fc68-8840-43e7-85f5-27e1e6457a44@rowland.harvard.edu>
 <7b1f757b-b626-5d49-354e-343e040b8762@suse.com>
 <f396acba-2241-4f62-98ff-ba97ea1a7139@rowland.harvard.edu>
From:   Oliver Neukum <oneukum@suse.com>
In-Reply-To: <f396acba-2241-4f62-98ff-ba97ea1a7139@rowland.harvard.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0124.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:94::15) To VI1PR04MB7104.eurprd04.prod.outlook.com
 (2603:10a6:800:126::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB7104:EE_|PAXPR04MB9231:EE_
X-MS-Office365-Filtering-Correlation-Id: 1977f1db-b192-436f-005f-08db3452eb35
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kVfxRPIsSKL8sWNOWacaZU/+/x8O1uNxsSZ+Z21beKFI8+YQZc/pt5Q5/VUdpBIdjQOyhxo9X4r74B0DefaPAASEgo87wH9dE9uJMkMW7QJgO1An5dcapz1fBM5UUlfPM85PqibjN4kw1hAv1heEkoXld0TqECuzCQuYYS2cr6QK6MWVp/ysv38p4lS1gM3dLWe8JzCRAN5qc0NNKKU2/l7slTKaXDI6TeG9IJksCU/OoQLXXu0E/U2sRncxfhXeTWls573YxNQemu0rQ2whbFGquOdJO4hGD/Om9bC0X1QZULdDzY+c3Y1vUrhq1Go0to5UcI4fCxa0bUQkDGpASRHSxWhyc8v1ESrMAZ9uqXnao7nQxhCqxCvROjawf91YLRAiN462Uqp7tHo8fhG1ffN6OQZHCv6oPW8obKp+M5b9bv+vdIWPzWDgxnzxr/Au22TuQb76yCXLiW+TMafLNjFZz5Nywsw219V4hnz61gaqwLUwyQ1rA5rr0dcw918mpDyheSMLFwv6MQbdQ6DMjz06/9bqWinGoxC+PJeDsuCfiqxu/+GxTzqYUgivPwCBjraZ5/uRJYaW5upTJR3a5gitTjOS8HuWYzrJAG9u4CnTv0u5PxqPv+1DtpZRd/h+vf7X7eAeHwP90DDRTsep5w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB7104.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(39860400002)(376002)(396003)(366004)(346002)(451199021)(2906002)(8936002)(38100700002)(41300700001)(5660300002)(36756003)(86362001)(31696002)(478600001)(110136005)(316002)(54906003)(53546011)(6486002)(2616005)(6506007)(6512007)(6666004)(8676002)(4326008)(83380400001)(66476007)(66556008)(66946007)(31686004)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QytaTmhISjVjYUlNRDg0cCtyUHVmbWdvUTFzUXJQak9VUkxkeVB2bTROc3B5?=
 =?utf-8?B?TXhJdEVUL2tzbXhwdGlJK28wRFQ2dzd2TG4ySkR4YmFUYzdVWFZkNDBPM1pO?=
 =?utf-8?B?ajQyZDZhSHlqbDBQZFhzSTd5RjF1RUdDbUcrZ3ZHNHVoWUJUcGtvM3VoOE1Y?=
 =?utf-8?B?dVQ2bzRTRWpZczZBMkFRa09KVytwUi9FeUlLT1B0WDZPN1VVQWZPMkQrWkly?=
 =?utf-8?B?cmM4MWlSMStmbGtqeWUyeXk3dUI0VGdpYWdXRUhyRzdUNDBWUnM5MDlsbjN1?=
 =?utf-8?B?N1podnRnT2U0UmtSSkFMb0JsNHRlVTlrcXZ5Q3owOVhhZ3VSYVRqQ3d0ZFJm?=
 =?utf-8?B?NENoN1ZGZUdaTFFiK2VYZ0p6anY1eHp2d1JzOWVCZ2s2b3dYNmk0OFdmd09h?=
 =?utf-8?B?SjBMVk9jYUdOMnQzc2JyS2plN0I2V1V0NmVNbmVDcFdkcmJ3cUY3MjRoWFR6?=
 =?utf-8?B?MUhycGhqVVdDVGpKODNBd2ZMUS9TU29WbnkxQ3c1c3RZcnV2TEkvYlJ6a2xk?=
 =?utf-8?B?VzYwcFJmT2FzRDl0bVBXSHA2c1duM1ZzMWRlRExYNFBpQS9PSmFJTHdnUm1Z?=
 =?utf-8?B?QzJnWFN5b2JUdTRkaUJ1S3ptR0hpV1NzU002Vmt6TkhFQ2FhdG1nMi9MakFk?=
 =?utf-8?B?cnFSdDZZc1NwMDF1UHRqSVRHd3ZHalpqL01ESFVFb3l3WUtHNGlqd0ExVGhN?=
 =?utf-8?B?OWVRSnJXdy9aNnlrNys5emJpTmg3N0FFcnhla2N4M0QvQVJZbG1xS1kwdkRD?=
 =?utf-8?B?Y1F2ZWxhWWFVdG5UZFdZMG50YmMzOUI3RzV0b1FmTDhhR3RIb2h0WG1JTTNm?=
 =?utf-8?B?NGhta0k1bXcyY1VoOTM1ZGx2K1FLeVZxbEEwZFA2UFlTdllmUTVmM0NSQ1Jq?=
 =?utf-8?B?SFJQZGlSbENIZUVnbTRnQkp2RXhGYmZyMmJMMVVnQnIzMk91WG9USDREUVZW?=
 =?utf-8?B?UWZMTG1HSkJRWTN6MitCZEx6WDFPczZ6Ty82Z0ZHRExqQlFEbEJlMlpldVdI?=
 =?utf-8?B?KzFNTXVXV2JabGNNSXhVekp4UFpIM0Uwb1ZLaDltMXlkekxjQm5heGZMSG1n?=
 =?utf-8?B?QkZZWFhKRkk1RVYyLzhhNkpwUjRmZE1uck9JTGRmK09hZjhkTFFlLy9DeGVx?=
 =?utf-8?B?bGNubnJpenVFU3I3NTArQmp5K0lTdzlPczU3QWhXUFVTenQ2blVEalpEaTZs?=
 =?utf-8?B?RjhiYk9HUDBuK0x3KzlvV08zME9TSmVVTFR1VmJFYSt1L3o2OHJSYVhTZkpp?=
 =?utf-8?B?dmJNK2JTcThZOEdTMER1cDFnMU5oV0Vtc3gxb25xZVdvNHJhdEZxYmVtaXVv?=
 =?utf-8?B?clhDNjJRTmRVYnN4K3NibnA4QmZXRjh1VjFYMkdxeng0ekUyUkFHK0Y5eWRC?=
 =?utf-8?B?QWowSSt2RXZGdWdzN2RNNzVaYzE4MncrVlUrc2s1d083ZnlRYjBjTll0TXhw?=
 =?utf-8?B?ckRMV0tEZnY5Y3VPUXZqdGlwTy9JQWRObGF6dW85MGJyVlFQZUNRNHB4Um9O?=
 =?utf-8?B?eTc4SERDUnZOVUQrWk9OcFRkZDlwRm1xa1pDb3pYejNCNFUyZnY4WGNGY2Ja?=
 =?utf-8?B?QVQxQUo5TUYrcmd3M1FneGpNbTB3eFQ3NytDaVZ1OVh5bFN4MGJBUXdGclYz?=
 =?utf-8?B?V2wwSkxML2VhUnI4dDVCQXo2Yk5mbi9GSkhkYjJtamptRVhGTGxYRWpzZXZ0?=
 =?utf-8?B?b0QzTXRlR2tScmhtU2JYeGg2ak5mK2JSeUtZT1FlazJsUlNPRm53bUJhYkE0?=
 =?utf-8?B?QkFDUFB5YnBST210YUtKZkNnNWdjNnZ4dVBoZThMN2xZVTUySVZCTWpKbnhC?=
 =?utf-8?B?R21CZTlsZ21oYTNLenR6RUg2NTVRMEFtcHJZZnBJUC9KOFNnYU9jR3JqeFE1?=
 =?utf-8?B?bGJBenpKdjdXTHRRejBHeE1TdmhxZ3VtcTZWcFBEaHVNcnBDZktEWU56aUZn?=
 =?utf-8?B?MTl4cmowaVVFLzc5N2lsYXpDajlGdlpIUlgxVitKb1U2VVRLS2JEdEpzL2dl?=
 =?utf-8?B?QlpmbURhakZDM2kvMHUzQUlCRnNYa1JyS0FNYjMwdnhIRTJ6Sk1pQXplK2hO?=
 =?utf-8?B?TTRrNndlcjJYbndTM2xYTEYyRWJrWkJjMzdkUXVCeG9hNmlENHBCZTZLMjU0?=
 =?utf-8?B?UnFOWUZuMS90Vm5LRUJya0NMZDNWODh6cm5WczBaS0VzZG92bXhVa3NjM1NU?=
 =?utf-8?Q?zTkCuC4wZ5uvxvSrUb9sDtKfJYQrnzFgjp817xgPbFcX?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1977f1db-b192-436f-005f-08db3452eb35
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB7104.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2023 14:51:34.3086
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /9grh6PamEV+O0asa9/sNjeVxvSN1EQ4ajxveDjjlzVUgmoupkwEJ1Zxa1mPtQ5R7gasmenjtEstM64CynojPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9231
X-Spam-Status: No, score=-1.6 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03.04.23 16:33, Alan Stern wrote:
> On Mon, Apr 03, 2023 at 10:54:05AM +0200, Oliver Neukum wrote:
>>
>>
>> On 30.03.23 17:34, Alan Stern wrote:

>>   If so, why do we have a generic matching code, although
>> it is always insufficient?
> 
> (I assume you're referring to usb_match_device() and related routines.)
> 
> Not sufficient, perhaps, but necessary.  That is, in addition to
> checking the available endpoints, we also have to make sure the device
> has the right vendor ID, product ID, and so on to match the driver.

The thing is that if we also need to check in each driver, the criteria
for matching devices are not sophisticated and strict enough
> 
>> What is the purpose of a generic binding interface in sysfs if every probe()
>> method blocks it? Allowing a generic probe looks like a misdesign under these
>> circumstances. You'd really want to add IDs to drivers.
> 
> I really don't understand what you're asking.  If you're talking about
> the "bind" and "unbind" files in /sys/bus/*/drivers/*/, they are there

Yes

> to allow manual binding and unbinding of devices.  Even though only one
> driver is likely to bind to any particular device.  (Furthermore, all

They, however, allow binding drivers to arbitrary devices.
Now, you can argue that this will not work. Then I'd say that the correct interface
would be per device, not per driver as it is now and would retrigger
a binding, as if the device were new.
Or you say that if the administrator wants that, well, shoot
yourself into the foot, the driver shall not check.

> this was true even before we started being careful about checking
> endpoints numbers and types.)
> 
> And we _do_ have IDs in drivers; that's what the .id_table member of
> struct usb_driver is for.

Which is not exported through sysfs.
So we export an interface that is not fully usable, not the one people
really want. You almost never want to say that a device at a specific
port is to be bound to a driver at one specific time.
You want to either assign all devices with a new ID to a driver
or unbind and reprobe a device.

	Regards
		Oliver
