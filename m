Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2755864A2CA
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 15:05:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232783AbiLLOFB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 09:05:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231779AbiLLOE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 09:04:56 -0500
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2047.outbound.protection.outlook.com [40.107.13.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D48110A5;
        Mon, 12 Dec 2022 06:04:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VkcsruYQExxB2ct1OJ3YlbTX8WMu6modFKcBC+K19APhdxbCOXxHXhbEMJqe0XZJb5VZZJ3HU0UsRwzD5z6VamCmXQN9J09tGL33R3DbkFFZGhSHKeGHZOzrxeQfxuF3/cqUw450HaUdT78Wz2VA91zY3WAI4H0BYMhR95/q9INBxW7bCXXtaUk7JC6TU/+vge+ceHQcrfqxcoeanljWzxheY7wbSLPSRsA+cdV7UbF/ORzHB9X79Hrfd4TXRU6ecZYkRotSJnEm2nxkRIh7oDF0FD33zQq5EXZYUcsuuS3E84diXGLM/F8dszUe512n3EVa1u2klGPSuN55/b/KWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LCqVjc2tHBGvjTvB6gmfM94IjkuX8He4XTHlArlYOMs=;
 b=fcKoizfnEUdLLrwXF+uVwhP1fRYH3DIbCQPaawvkVx+Zn43XXBlwavkhq8/TW1FhOB+Z6/kmeVzY79+d8NWcdWNzhJ7k6ZE1OpGJ0WPvCrMUTJ/noLU8Y+5z8wColWLrRvPtEosjkD1WGoItoBwKKvdrdcfaI3uaGnvBguy1RmtupYcbLhsrqgZjOs6wvDPqUnqB2vsfZcIv2H3qE9I2SDs979SL15M7dq7JZ+uaIiBaIF32T0xEagQHL/EI8Rc1PJfvYA+XF7Mz22368tqHucibwADF0OGGXg8H0L/uNKo6Ilb7GDTuswATke9ItZEwZcleKdW8pjRLkIXZOfJlRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LCqVjc2tHBGvjTvB6gmfM94IjkuX8He4XTHlArlYOMs=;
 b=HijPSzmd+KwAjLKOlr/zA8nAsjNyF8jrWbFHhJWpmn5S8FE0+oFGf92PErSXVQDo+dT2NaNLXk1eTiwP7k9vnn4Cp+RF+fZozG+qtft0n1F8J0hO2Cdr4Y9oG//grBImlmA8QwQKoIuOPZkWO/YNFi/ac8KeJSj+j1SwY7XmSHvCSM3tu0NAxibYPsiECMO5H/dPfoPFqmkVGSEK4MSeCSJkRPX0v2dcG54mrCtB0EkElwsYtNeZ6fcPhI3Vz5uBR3TAdvSmkJBvApbqN+o7aXSuoe5ges/8MTY9DjWCO0NuoMovOKVeli2SABtS5lRYtILkYhmWCXr5bQdOrDrWFA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB7104.eurprd04.prod.outlook.com (2603:10a6:800:126::9)
 by DBBPR04MB7899.eurprd04.prod.outlook.com (2603:10a6:10:1e1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.10; Mon, 12 Dec
 2022 14:04:52 +0000
Received: from VI1PR04MB7104.eurprd04.prod.outlook.com
 ([fe80::ae59:a542:9cbc:5b3]) by VI1PR04MB7104.eurprd04.prod.outlook.com
 ([fe80::ae59:a542:9cbc:5b3%9]) with mapi id 15.20.5880.019; Mon, 12 Dec 2022
 14:04:51 +0000
Message-ID: <b1a5874b-8028-db14-e2ac-ebe3967559a5@suse.com>
Date:   Mon, 12 Dec 2022 15:04:50 +0100
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
 <4cf7bce3-dfbb-b064-9d91-27616bf11d6a@suse.com>
 <Y5cpH8aV7aox2Pbd@hovoldconsulting.com>
 <2a2935e6-ae3c-85d9-a2e9-f42fb4ca7d59@suse.com>
 <Y5cvPulXceujfZv6@hovoldconsulting.com>
From:   Oliver Neukum <oneukum@suse.com>
In-Reply-To: <Y5cvPulXceujfZv6@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0008.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::13) To VI1PR04MB7104.eurprd04.prod.outlook.com
 (2603:10a6:800:126::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB7104:EE_|DBBPR04MB7899:EE_
X-MS-Office365-Filtering-Correlation-Id: f34db3a0-49bf-4606-8e7f-08dadc49d68e
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vbcE7Em96IOcpWY+u9ibnhSWGclIQLDOokJTl98Wo1+m7M1AW5hcE6AbvYdT6rtWfiZlBsBtv+bybV5t8QetEJN8Ah8mVBpblhJMSkGyVLkdYFq4ZQiqQECr7KGErIRzu/V6H2/q3RrDs491U4b+cKpr0xO6+jW2CwhGKx+WxiDA99az6yLSPxCakJtfMulJjF/3OMiIQZV6x5XTDHv03wbXq5yNTX3poKTocZmDvfz3vhVLqHizQUMZvSZ6NdsLK+4MATpe4BUv9Hfh7kP1b+0UEoJ3t2NDygNoaC2Sbyl6njBKuKNL8LfM6XL0NzsQzSf7mGBrD7zsTutLl15012FraFlIutFxSDoZ7ioLtkUvv0OJnvSYrHUBsVqf+a2Jj1s0KynxUN0TEstGdBrnGl8S36HatuzQwQCHwVCZiGRrhKPhv7ekhtiGCgdIJXmmzjPkmrq9w8LJC0avSCLt+GRLOnX5EyZwPVCNkVoXxHPGKXpOHjJ+3QvO1NBzPgBxbpOUAf+OxSDJru3wWCMKXleX+CajDj7TrU9zL99YOrNoAUW7L5ttzsK6C4bwA+jqt9y/vD+mseDv1NOX4PuGcHdXidYQ731fqr37IKebYMh/RyL3+J/+JFnHzfTuaJCft+e5+az0pcaYeRZqQNoMw81vf5JM09cVPUCcpdaMrCk34yu/Lml4qvq2eGVlp0hFI2PZ2b2HQFGwaHc1k1zAnQegHS9jYeMcJ/NR0ChKZKw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB7104.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(136003)(39860400002)(366004)(346002)(396003)(451199015)(5660300002)(31686004)(8676002)(4326008)(2906002)(54906003)(110136005)(41300700001)(316002)(8936002)(31696002)(86362001)(36756003)(6486002)(66476007)(38100700002)(6512007)(53546011)(66556008)(66946007)(2616005)(186003)(478600001)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VUZrWmplWXc3RTZPK0dZSWIrSzZxR1ZmQnV5dlN5M21FSHFnYzlaTnN4ZnQv?=
 =?utf-8?B?MmVTazl4OC82c09lU1IwRFZTVFpmV1dXeWpiM1V2dEIvcDVFc0M2aEtnWmkr?=
 =?utf-8?B?ZVRRMWIzcW9DVnlKVkNYejl6TmRZb21MT0p4MFFJdVdZS3c2SitxZXFQdUho?=
 =?utf-8?B?T0x6Y1hHOGxVd05RTjlLZXVUczJFU09oRldIbHN6TUVPRFZzS0haN1ZNdVdx?=
 =?utf-8?B?ZEhBUmRlZ01QVkNGNks2SWljLzVWWFdkZ3BXWnpkdlpwcGZlVXJJMFF6NDI2?=
 =?utf-8?B?a0pKUEpBeDhsMzJiRmFYbUtZNmVRNGxXZWRXTGVxdzc5ZEQ2dU1kZDZLdTJ2?=
 =?utf-8?B?RXlyVDNNckhsMDhQUXFQenBpL2NGRFRab1owL2x0ZWFoNmJiT0xCWGpldFJp?=
 =?utf-8?B?dXREQTZlbytvYnREQ2owRlNiVlNEcXlVcTlKQmFua25GOFI4cFFWWXFwc1pP?=
 =?utf-8?B?dmduQzZIclFvaWtmYVg0bHJuQkhzTDRaRnFnWWdySDRNN2VmYnNaKzlnV29p?=
 =?utf-8?B?TVZzWHFNem93MkY0NnRZNFd5S1VYNmdOUFQ4NUZxV2NjUVFMNkRvejdZNlI2?=
 =?utf-8?B?b0JKZkVrQ09aQm1vaEZPTWFvQXcyanFQT0gxZkhNUE0vMDNuS1k1cWxRSnZF?=
 =?utf-8?B?cTZzcDdneC9xbU5XUHNMY2hPYWVSUExiNU11eEl5em5zZUROTjlEZysxK0pa?=
 =?utf-8?B?TERyMEtyMjhaYlRZYlVMSzdIUE5IMm9oMTkwM0tISUlKTmxlM0hSblYzOEE4?=
 =?utf-8?B?b25yMHVPT3RyVWJCRUptSFJocXBvanBzWE1Uc2NTOE41SDJieVBDMVo2dGcz?=
 =?utf-8?B?MFV1TjlmTHdjWExMTnNLMk5YbUxXRzNubkRmSk11RE1PcGZIdXF4MjJHL0ZM?=
 =?utf-8?B?d1BUaWszVElUYlY5ZFNRcENOWHUvRkQ4U0pXT2srQTJZQmRDWStnbVdpems5?=
 =?utf-8?B?bmd4R21Wc0hWOHQvUGFNcy8wc3kwSzN4WS9rQ2RHcTZ6V2hWdGZYd0tiOVJr?=
 =?utf-8?B?TkhLSVZvTm5qaHJRbHBzOWw0YzNXdkV2ZXBza1BHTll4VDdheGpYQlo5YXFB?=
 =?utf-8?B?ZDM1U1UxV1NybDcvaXpmWkZNcWJtcHd5aXVQNnA4QVZYU0lWbUlHZm5JN2p1?=
 =?utf-8?B?VjVzdXl4djJIMzBickhndGdML0NhZnBBZkRiTFFPbWF0NERzcVhNU2FYeUF6?=
 =?utf-8?B?ZFdWdmdnVUxkbmw2bFJIUmFyUnoxdituTUtwQzN6V3ZDdVVTdVNucFpSK3dm?=
 =?utf-8?B?UEprWjdyekNLb0E0T2pkK2VvdkptckxJOVp1OVR6UGQ5K0F1R2xXVXFKaWdQ?=
 =?utf-8?B?RDQ2bzBiRkRqU2NaSTVCRTJqU0tjSGVlZ2Z0ZTQyc3JRSU96VythbjdicE9w?=
 =?utf-8?B?b2orN2o2Z2JqYjB0Z3hYL004Q2lSc1JQU0hrclMvUENGbXJrcUJxb3pPamZm?=
 =?utf-8?B?TDYzVy9ISGdiRnBRU1plSUQzUmk2a2s1TTdLbzJzMUJPVnV3RHowVDFaSUsv?=
 =?utf-8?B?eXQ1VDRDUGRidjF0S1prVTBMSzQraHlPRGlRa2VwZzRMbWU1SGczZytqNEU5?=
 =?utf-8?B?ZjhWbStycnVDY214aDhDNHBDOThCV0F0LzZ2dndWbzN1UlNXUmxyWTZDZW04?=
 =?utf-8?B?SWhHbmI5OVBUYkZHamlDeHRvZTd6S1ZUVGp0NE1saWdYdUF5VWQrbUluN29k?=
 =?utf-8?B?KzVKMGRFTFFWVmdscXo4SGcxLzIwV3NXTUZnYWR2VFlJS2VyZ2VISkxnTXZy?=
 =?utf-8?B?cWFuK25ESGtGTG9pVHJhclI5WjlxWUNNMlFMOWhkUXNMVzRpeVQwcW5WbGxZ?=
 =?utf-8?B?aU5OZnU3NE9WYWQvVldKWld4MDBvb0FQTitPUHBNUSs0RTFETWdka2JUMGl4?=
 =?utf-8?B?Sm1RK0REcWdKV1h2L2tZSjhEd0F1STdnZm9heXlZbG43YWtvclR5M1dESy8v?=
 =?utf-8?B?b0ZuN2FoQmtnMW1aY1VRSzB1RU5RQkZGRWxxYlh0UnhRV0kyWWkwMURpRmY2?=
 =?utf-8?B?dEF4VXkxU3cvTWhEeWtmTjNZTlBPa3Y0d3NCcDVFODB6OVlUeCsyS2NNOHAv?=
 =?utf-8?B?eHE3c3ZBVGRIRFpDMzZJbkdxOXdtdEs5Y1RlckNyVUNrb0xuWG9NL3N6YWFL?=
 =?utf-8?B?NTdXSFF5Y3hQQ1ZNUEEwc0dyRytRL2ZqVXF6b0txZ3lFbXZRR0lwNmxPZVNC?=
 =?utf-8?Q?ujGhpVbBKwBkRT7iJcHuPSW3K1DnNs3eGZvPq6vDJdBo?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f34db3a0-49bf-4606-8e7f-08dadc49d68e
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB7104.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2022 14:04:51.7986
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pxw9TMh4sL/Pkj6/YAJk17BsoUEi/2uw4eFqpdACGjKYs4ErZr4ZL/olXqIq2U0MorHXVnmTwSUDlywrnjc70g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7899
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12.12.22 14:40, Johan Hovold wrote:
> On Mon, Dec 12, 2022 at 02:27:46PM +0100, Oliver Neukum wrote:
>> On 12.12.22 14:14, Johan Hovold wrote:
>>> On Mon, Dec 12, 2022 at 12:13:54PM +0100, Oliver Neukum wrote:
> 
>>> And in this case there was also no kernel doc for usb_get_intfdata()
>>> which is equally self documenting. Why add redundant docs for only one
>>> of these functions?
>>
>> Because knowing that one of them exists makes the other much more
>> obvious.
> 
> I doubt anyone finds out about this function by reading generated kernel
> documentation. You look at a driver, grep the function and look at the
> single-line implementation.

Look, we cannot solve the issue whether kerneldoc is a good idea
in general here. If you want to open that can of worms on lkml,
by all means. go for it.
But failing that, silently eliminating it is just not nice.

> But it was never perfectly good. It claims that a driver "should" use it,
> when it may not need to (think simple driver using devres) and talks

If you are presented with an interface something needs to be done
specific to that interface.

> about driver core resetting the pointer which is irrelevant.

But correct and topical. I am not arguing what people should or should
mot know.
  
If you just remove the last sentence, all will be well. And if you
insist replace "should" with "can".

	Regards
		Oliver

