Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1F686C69E0
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 14:49:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231516AbjCWNtJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 09:49:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230109AbjCWNtG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 09:49:06 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2076.outbound.protection.outlook.com [40.107.21.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85C803599;
        Thu, 23 Mar 2023 06:49:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XwjSKbWHpQ+EacohJGdwjXPaqGr5ms4FQ2FW/S2psQmlP0bNhWEBkkxRIiqL67Io5DbLflv+C/e3vOkjed+Az7GmNMag1bBBgRZNmmxnFN2VoUCeuOAXQ+HfysAGDrIsfF27124vzAxeL11/V/KzRqiE5aV3lNtAbPTLISIDiZFJqO+yhkRFKBM+0bEufUrE0usiZVJ/sHkGG3KfQQm2Y2Ee8tXpPa4fPhuJQkta9ANkoF1DTTrVxFUsKtvBBfcu8rlomjdIyl2m/pcG3yCbA9eL3sSD4D2NuvNvORIBSvWnWmZteLDrqVjLAWdHiVxk+tPlWOv/IADo/pkghFgmRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UN6LbXBzyJ+G14Etlitd+s5TUhIr90ZSExumYVT4JLk=;
 b=B7RszWNV8nC8Hgw0ZTM6r6ObaFYsNh+ZSe/v3wX00O5g3vXTTzDB0Eo2I2Ef7cqHtHtTbGzCN1gVDy3k3DJuXl/zG5vdHqF8s3LQCypOW6LgPDcTCQLzIlt4X1ONKorWGEnHUb3FzSa/61laXooC3Qv0363g6qSXgZPyeti1jPFVJN8IpcKTwS4XV4iGMAGiBke0JGJtaxDsSHNu4IE7Cq3j7M6WqEGgNOOX+mS3WGtKQs4X+6LFoWLksmDQTOHYyHwO+VTpL8feVZowY52aLCdcgTwdwg/J+bLyb3KVIJnhAybj0NlDkAbkpM3sJE/ewbiZoZNr1RJs0iNjKoitBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UN6LbXBzyJ+G14Etlitd+s5TUhIr90ZSExumYVT4JLk=;
 b=2uAFqo3+8YDq4S22L7gCMw685KcmDXZvdZS9UjYX0Dk8tAnr5VtJ1oOuXSJ+BpAS5oa0YKVJyKwdgBghC/IFjKztmUl4HTxuch3kL6q6uLGCE8jG1gfS5xnyauF9OOjP2IvCyhdt21Wm9z0HUWgoUhF3AbyjKKPTQdR6Nv7/w2wOEhg8SsJQvXHLBdr7lYAwPuDUE7yahjjsT0kZm1J8BFeh/pChrVG7kr3XBdBLrk1g1X4e8xPwv0RYBmvg9KFZoDI7yC58UIyxmpH6dWWMg3Vd1sP0GWcRvcv7KGfaEdNGEDMNW1gukhNntwUnVquEOFXrVlhoQJq6HdpIYMKKKA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB7104.eurprd04.prod.outlook.com (2603:10a6:800:126::9)
 by DU0PR04MB9693.eurprd04.prod.outlook.com (2603:10a6:10:322::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Thu, 23 Mar
 2023 13:49:00 +0000
Received: from VI1PR04MB7104.eurprd04.prod.outlook.com ([fe80::2ea:4a86:9ab7])
 by VI1PR04MB7104.eurprd04.prod.outlook.com ([fe80::2ea:4a86:9ab7%3]) with
 mapi id 15.20.6178.038; Thu, 23 Mar 2023 13:48:59 +0000
Message-ID: <181feb34-c46d-cadb-ad20-46074a53b4c9@suse.com>
Date:   Thu, 23 Mar 2023 14:48:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2] usb: dwc3: host: remove dead code in
 dwc3_host_get_irq()
Content-Language: en-US
To:     Dan Carpenter <error27@gmail.com>, Oliver Neukum <oneukum@suse.com>
Cc:     Sergei Shtylyov <sergei.shtylyov@gmail.com>,
        Mingxuan Xiang <mx_xiang@hust.edu.cn>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        hust-os-kernel-patches@googlegroups.com,
        Dongliang Mu <dzm91@hust.edu.cn>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230323095311.1266655-1-mx_xiang@hust.edu.cn>
 <129aec21-4997-6b8d-5bd2-8e013f575208@gmail.com>
 <73fd29ce-3072-dfce-ebf0-3e197230fa94@suse.com>
 <201fba22-f537-4d1f-bfc4-e4dc931707bc@kili.mountain>
From:   Oliver Neukum <oneukum@suse.com>
In-Reply-To: <201fba22-f537-4d1f-bfc4-e4dc931707bc@kili.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0018.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::28) To VI1PR04MB7104.eurprd04.prod.outlook.com
 (2603:10a6:800:126::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB7104:EE_|DU0PR04MB9693:EE_
X-MS-Office365-Filtering-Correlation-Id: 315ab942-260a-4126-7e8e-08db2ba55ac3
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V8SrY739VUonDNro06CkcIW6zcoQarVyQLl9fpRCeunYvkwf0vLwvhIOtk1uTBxn1zqRPfpxfv0H0wBORTxrjPFiu9FiilUmKnGTkpj/npU9Ml9iAbn39dq4Sr9/i65m6dz1z66pNDySACMvR/1yO17lHqqeP9Lt/EK4vuvi6Lw8pa6snhHBsZgQF11IqjgxEPDtbaAWiLXz9t4v0osvEb72y5Uha4dLQzElbT5H7Gz3Yk3Hfz5rQz+JgRGRBd2nHYBrM911quTqMAJA+3FB8xHABIqScNmdpy2bGxf8Bq+1i1uylimuCWy3UnaDePJ5PGCTbS6Rks7k63iW/0VzhGemUHxF/V/IVjU7G9NCeNsigt2hrS91BgShSbisrXFQ//j8RKmOL0MamylHMWdh0jSMw98Kq6YcgKTVKzBb+spTwBc9YtpJcx5+ODo/SvcdupXEAP8jY7Yy6mJCxF1UJ7RWyijm9KDIFY7iUyQ0uwBJSBI9nhXDRfwCjFSGBTJh5iaZhZQjYG0EivaoXhMjFcnl3xC8aBzItt5QCqsmgzGpYWr03xAhyYkdWpV9ESVe5cOvVXF715WxDdgUM4FWdd02Ac4vk51xkRYVtTFIroNEzJOqs9i/iDwO0aiukh2qF6yMmwwfjpvC6wa/aP4q/O/2dk+Fqd9ammz0OYx+KoITevv5KIEMtM+rdSfvtIJftRYNSU3TD0f2TDk56jkrT4FaUCDW9SqwvS1VAtEsarE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB7104.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(39860400002)(346002)(136003)(366004)(396003)(451199018)(31686004)(41300700001)(66476007)(8676002)(4326008)(5660300002)(2906002)(86362001)(36756003)(31696002)(38100700002)(6666004)(6486002)(478600001)(110136005)(316002)(8936002)(66556008)(83380400001)(66946007)(6506007)(54906003)(2616005)(6512007)(53546011)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eG5PN3oya1ZJRHZ5dHJ5ZnpYRnVVVWcvdlBQeW94SUtjZzRxeWNwTWIrMm9k?=
 =?utf-8?B?Y20yWkJBd0dnbnhoNFNIdldZMFpicGozY1ZMREh4R2pWTEo5dmk3TTFtWHZU?=
 =?utf-8?B?RSt2V0Y4dWZUdEI1NCtPUkFvdjZYZlJEdGpFb1J5ZWlrbnV6RzU0TThrdHFu?=
 =?utf-8?B?WDU5OEIrcWZ0a0R1ajQxMEl2Z2lrcTdsZkwzU1RpaVA5aEd3aVptSUJvb1gr?=
 =?utf-8?B?Sm4wQ1ZTTWoybXNycGJZZDFqKzE5cm9vR3J3WnFVV2ZoRHltMGEzTmFYUVlC?=
 =?utf-8?B?RDdudUZaNXFUSkdTYzF4ck40eUpNS3lPbG1jLzk2UndKZHZVcHpPcTN5OEtw?=
 =?utf-8?B?dkRGSDJVWEhST0gyYXB3blBFQlNLRlhxQnRDSUk1eGxOVDcySlVQMU1kYnN6?=
 =?utf-8?B?SUFhZmxIK2gxZTl3bVA5NDA4OEF5VXh3bXlJRDhOK2VuVUZZdHhFVXVYa3lP?=
 =?utf-8?B?dW4waW05S3hnWlBrZmR4ZkY4S25yaGNUNkdiamVvd0xxMUdxUEx2WmpRcFB4?=
 =?utf-8?B?UHJHQ2p4L20vOUwzL3lUWTI5NFR2Y05scWpBamZVajZRUmZRbk1sSTdxdUxs?=
 =?utf-8?B?TUdJU0EvKzlHejRXZW5KdmorSXBRU3NUQUlMMGE0bndoSjZReldXNlVsb3Z6?=
 =?utf-8?B?VFdCdU41cUVBU3VEZEZBMG14MklrdVVxUFUrNTlGMktiTkloaThVQk16b2Ez?=
 =?utf-8?B?RXhiWFFFbFVzb29NT05ydWsvVlkwNmV3RUFRblZNWVJZVTFtRDlEQ2ErRXg1?=
 =?utf-8?B?WUZyZXhjQ1pEbjBGT0RvQSsrcG5ZMkpNaG5FaUloemNoN2NCZlFoWWtYR2Vr?=
 =?utf-8?B?NnJYUmtLcEVsUWh2QmV4MkJxa3Q0dFZtV2ZtMHhESFNXV3IrUnJWaGxMVVha?=
 =?utf-8?B?OFg4LzY0UGFaMWJYMFlIZzhTY0pTR0VpMHFPOENnS3hzakNwcUt4eHJ2RVU0?=
 =?utf-8?B?VTBJYTV3RVNMRGFpYWk3UjZGZUtFam5BMGVSZW1vQTZrUTFLa0JrS3FqWXQv?=
 =?utf-8?B?V29kTHhzMDF2Z1QzMVMzYUxWS0txdEVWMEVxT2dNeFAzNG5jZUlPbGtONE5z?=
 =?utf-8?B?aU8xUDhlUkpWc3FaKzlFM1VvR0lVY2VNd090R1RuL3U0ZzRZQ2NTdnVyRzlx?=
 =?utf-8?B?bm9UME93V2hxMDg2bUxSZU5kWmZuWFhjM2FsMHQvSlJMVDkxRTBNSzlYeXo4?=
 =?utf-8?B?R1FXbWZFdUdsbk51M2hZRnltYlNLcURaNC8vZjlxcXd4UWsxT3lWNlV3OUpp?=
 =?utf-8?B?YzZxajY4SmdJdWxMcmFnTVhtREFKRTJHRi84bFdqVmtSZEtXNE1vQmpGQVpn?=
 =?utf-8?B?dDhmQk9ZcnJlQnljWmFJODBhU2xZd0JPWDRMQnBvME93MmgvbXR4TUxnYzdX?=
 =?utf-8?B?NGxsZFZNaXVPLzVwb0QveWY3OGZZZTI5b2hVM24wMTZhcUdUMHIzdkxJdTgy?=
 =?utf-8?B?cnNKdHVQVWIwK2JHR1NwN3F4ZGpCQ1BhajRwRngraC9iQU13RzFrcTMvT0Vw?=
 =?utf-8?B?QkRLclRacUF5RUxPbnNjZENSVUZlV2R1elhhSHh1UG1aclNOTHppcThFSHhh?=
 =?utf-8?B?d2g5aGJUQmxvTHdpNjdhOFpQWmUrakhvK2JyamFOWDZ5UmlGV1JkMER2N0U4?=
 =?utf-8?B?RXdFKytneS8yQkdTemlFVks0cUpDb2pORTFpWU9JU2NkWFhOQ01kOTZielRJ?=
 =?utf-8?B?Y1RvT0ZhUGZ4KzB2UnIyNDB0eWFUeURvUS9uN2kycThrMG5GM3FVVG5iWlNT?=
 =?utf-8?B?amtPKzlaeWliMTVINDdHdWE3MkIxeWZoU3V4T213cDhCLzVMaU5jeFVjK2Mr?=
 =?utf-8?B?dXdnaEptcVBjWDRuUGpuNGU3SU9UR3E1a2gxMjExemtNeWN2dGJ2TWNBVmhX?=
 =?utf-8?B?TzVCekV5ZTBFekZ1UEp4TTR1OFQwNWhleFpCZ1dHbll4NXR0OGtTbEh6YU9G?=
 =?utf-8?B?NFRibUJJRU15SHpnbkdCV2NUd1I3NFJWbXFveHNUakZrVlJ4N3R2cXdXUlB0?=
 =?utf-8?B?NTh4bWlYdStvb1lSL0JMbDhHaE0ydXFpZnRNVTIzdjZ4TkN0QWJ6QUgxYTkz?=
 =?utf-8?B?bnlOVHA2V3VYRUViekt4UWpzQWVmeCtLeVVVV2NCQVJrNXdYS3lRMjg2N3pN?=
 =?utf-8?B?M0NWM05qSlE3aHh6aDQ0aWYzaGphTkhVbHQ5c2FGT0pwMnlVUk82NWVJK0dP?=
 =?utf-8?Q?KBq8KyHTIhG1mE4yISx6bFagYHC24iwzCrqGOhKv6v5R?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 315ab942-260a-4126-7e8e-08db2ba55ac3
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB7104.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2023 13:48:59.7135
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7bRxiFh5B4kkMyRaDWRT7AuLXmY7SVfraKV2w7CKmQ+wZVA7OcfsW87oHhSPlr7ijWK7EmgeXmTSIzOrfpELjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9693
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.03.23 12:13, Dan Carpenter wrote:

>>>> v1->v2: remove redundant goto
>>>>    drivers/usb/dwc3/host.c | 4 ----
>>>>    1 file changed, 4 deletions(-)
>>>>
>>>> diff --git a/drivers/usb/dwc3/host.c b/drivers/usb/dwc3/host.c
>>>> index f6f13e7f1ba1..ca1e8294e835 100644
>>>> --- a/drivers/usb/dwc3/host.c
>>>> +++ b/drivers/usb/dwc3/host.c
>>>> @@ -54,12 +54,8 @@ static int dwc3_host_get_irq(struct dwc3 *dwc)
>>>>    	irq = platform_get_irq(dwc3_pdev, 0);
>>>>    	if (irq > 0) {
>>>>    		dwc3_host_fill_xhci_irq_res(dwc, irq, NULL);
>>>> -		goto out;
>>>>    	}
>>>
>>>      Now drop {} please. :-)
>>
>> Well, no, please drop the whole patch.
>> If platform_get_irq() returns -EPROBE_DEFER you now give that
>> as a return value.
>>
>> This tiny bit of optimization is not worth changing semantics.
> 
> The v2 patch doesn't change the semantics.  Mine did though...

Now I may be dense, but let's look at the current code:

         irq = platform_get_irq(dwc3_pdev, 0);

assuming irq = -EPROBE_DEFER

         if (irq > 0) {

not taken
                 dwc3_host_fill_xhci_irq_res(dwc, irq, NULL);
                 goto out;
         }

         if (!irq)

irq != 0
                 irq = -EINVAL;

out:
         return irq;

returning -EINVAL

Patched version:

         irq = platform_get_irq(dwc3_pdev, 0);

assuming irq = -EPROBE_DEFER

         if (irq > 0) {
                 dwc3_host_fill_xhci_irq_res(dwc, irq, NULL);
         }

out:
         return irq;

returning -EPROBE_DEFER

Your version:

  	irq = platform_get_irq(dwc3_pdev, 0);

assuming irq = -EPROBE_DEFER

  	if (irq > 0) {

not taken
  		dwc3_host_fill_xhci_irq_res(dwc, irq, NULL);
+		return irq;
  	}
  
+	return -ENODEV;

Yet another error return.
Now, I admit I am by now sufficiently confused to know which version is
correct, but they are all three different in what they return.

	Regards
		Oliver

