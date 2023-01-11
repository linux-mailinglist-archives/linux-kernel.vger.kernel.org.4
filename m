Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14A1B665ACE
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 12:50:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238606AbjAKLtu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 06:49:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239078AbjAKLs7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 06:48:59 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2054.outbound.protection.outlook.com [40.107.8.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 864172D1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 03:45:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IuSovQhox+7pvm2LM8mMy3OCazP++cMoCFH5nB2NFR/zh0XCCcBiCqeWgs8l0N36/BPhH6LRRm8k2pgmP6ZM8H/LYd9lxQeZDFhqs1Fqt0f/lclHeWXjflCxkm9/pEuL9Xw05TquB6/53XmHW4j7hC7nNzOVneYQObzYJmlp7dfG7i9/KJb1JGzjdhpj6cCBSRWu+LufKzxmNrgbEanJCTqpo4E0dFvqvO9v312Vw/OvUs/2KYfmi4+8kFj1R+uVLw8r62MAPe5VSCSBZz/NV0l89o9fICgDDg4NDSJVVyTjRf5XF6vGC9dYIeuCaNtW++cqCUnZ5sbrrZcUNAUOdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vJyBKwRcILZLfFiT4JKRJBdJChq++tQiSdJTUxAwsZY=;
 b=fAlE4NRljiXH9tSwhmUC6x1k2x0msNp8wokCaWCFHoQzerrlVxvA+Fb5fjy/BDD3woHZD9q/FYBhntTcbIX7X2Paw8qN7m9isccG6PivvOnN3ocXdxMpSK3mHsiYwwrL+RA2P2HlPL/rIdEsHJC4wuD0Yl5ClaEUDeDFYfHu7YBa7vI+foi+IGIXWXT/2Nwd0Z4pn1cxtRJxUQ4ZCFDN3GR1UYu3Bom1haH62TiPGwn3tkij/7aKUSVmdP47SKtUdrK8WdM+qB49vs/qbEKA38OFBkbjDC+OiX8JvBiW99dgbnYLcDbmKydRo3/hIvJ1gENf5iWSP4h44lzgFua+Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vJyBKwRcILZLfFiT4JKRJBdJChq++tQiSdJTUxAwsZY=;
 b=YIMH09P5xf84nJhadwq6Ng0PRQbK1DZD2febd4fZCf+ROeN1Ec2Z803GrqUTifeoXWkpREY/h4IcJiTxhKg5Ke9lkWE+05nUOwhBgpnsJtVmIFcdEkFYpgo5MPGAv374hXwVuavEvTvSDWiQ+qWq91OtBK3ULEHzmw+JF+4Fu4wb7Eo547ly/M8wiGFxHVA+bAp2xjIgQ/mvNg2cmqttF/1QuL40reEw6bP+myb+LahgB4NyeKA8jpOaGnHmEM1ofNIfCpeMSSlI5QGcsJ/n0eOkxssm0VhF25udU9jMs0YkWcLzblOXBg6uaxUx7OxtteEWUoNh1COlNAeEtVkxRQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VE1PR04MB6560.eurprd04.prod.outlook.com (2603:10a6:803:122::25)
 by PAXPR04MB9489.eurprd04.prod.outlook.com (2603:10a6:102:2c1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Wed, 11 Jan
 2023 11:45:42 +0000
Received: from VE1PR04MB6560.eurprd04.prod.outlook.com
 ([fe80::2991:58a4:e308:4389]) by VE1PR04MB6560.eurprd04.prod.outlook.com
 ([fe80::2991:58a4:e308:4389%7]) with mapi id 15.20.6002.012; Wed, 11 Jan 2023
 11:45:42 +0000
Message-ID: <f2c151af-b3ba-69e6-2878-3256971f5a9d@suse.com>
Date:   Wed, 11 Jan 2023 12:45:39 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: Wake-up from suspend to RAM broken under `retbleed=stuff`
Content-Language: en-US
To:     Andrew Cooper <Andrew.Cooper3@citrix.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Juergen Gross <jgross@suse.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        xen-devel <xen-devel@lists.xenproject.org>,
        Roger Pau Monne <roger.pau@citrix.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Joan Bruguera <joanbrugueram@gmail.com>
References: <20230108030748.158120-1-joanbrugueram@gmail.com>
 <20230109040531.7888-1-joanbrugueram@gmail.com>
 <Y76bbtJn+jIV3pOz@hirez.programming.kicks-ass.net>
 <aefed99b-6747-5dcc-65ec-6880f7c0d207@citrix.com>
From:   Jan Beulich <jbeulich@suse.com>
In-Reply-To: <aefed99b-6747-5dcc-65ec-6880f7c0d207@citrix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0119.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::19) To VE1PR04MB6560.eurprd04.prod.outlook.com
 (2603:10a6:803:122::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB6560:EE_|PAXPR04MB9489:EE_
X-MS-Office365-Filtering-Correlation-Id: 43b48721-5c99-4d23-7067-08daf3c95e1c
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: owCNN63GRNTThhPWm/9y/E20yMqdne0m1WZtQCfsCZU/7nH5q44OzXKTMHE4pAAtFttrLQU3J1MGfefSLaW8wwT/9A/FYnM7wIuf7CrrZhiYIaCDM5ggZpmG5KwcAPXpW+05wWCWjlHI8PMUb67SnDCd62hPpSL3n81mYWvo87QRRHVKa1O3JIFMuarWg7w33O4F6yVQCykcLv2bEg/vbgztp1n+/ZOEfai2WyZOstZUwmRc95TBrqc4kNZHV4didJQslLSi4JzGXNFAAewW/4TC77YlRmkCBhTz5Rj+P9tXzkQRIOV/9TxXS18vU6ZNBPUiRXjuoiOO9qVkbw8YE3SmMxLG0SnUzXBjdAUoeDADmCxG6ouMcHpC69lZDZfx5cVjnlARxmTa0q9eAh7K9l1gddmJ5spPdXCC98CNdoiQBYnPwO5aAeBtSJy8KJTgbvm9XfULU+gzUg3qf9CctaWND9TGr8YO5flHtDnVrcDz/q2YvxHGoX2LX/lIf40Tfw2vcSeuYOfGfLPGtD6oEvvr7n/WJInq8se2jTgptRKfI7ZThmADxKbLc4yjX6OLS+Cg7pEISTpeL+9H8P68hJEQM9DhrftiBDd0wdIwqwvnL8D4D3P3R+llZJLQGyvo3vShuvPpLaMe72BBKN/GaItFTA0D/5wnrhZj7wpPy6PCFoxqHLiorGkdkJKKq1WWmEzFIzp55p2so+CCJrVtcscTQpsRj311cH5dxYlO35bb3+6IyoH/RzcKhoNVbidr
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6560.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(376002)(366004)(39860400002)(136003)(346002)(451199015)(53546011)(15650500001)(31686004)(2906002)(6506007)(6486002)(26005)(478600001)(6512007)(6666004)(186003)(8676002)(83380400001)(2616005)(36756003)(316002)(66946007)(66476007)(54906003)(66556008)(6916009)(4326008)(41300700001)(5660300002)(4744005)(38100700002)(31696002)(86362001)(8936002)(81973001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T1p3RUd5VCtpSCtySlRHTmx4Yi9YYThyY0JYREFhYVhmcDk5SG5WODBQMU5z?=
 =?utf-8?B?K0poRmdqTlpWMHd2NUh6eFBPb3ZMOFk4Skl5clVsVUQ2bTBHRGliZ09CWUFo?=
 =?utf-8?B?MEpIV04vQ3dPMC83VWlOaVVLQzlVdmYycFpneWphd2NKN2tURnlXb3pyaW9p?=
 =?utf-8?B?M0hiQnlZVTZrYnJuanp3SWdqSGFuZXk1cjQ1UllVayttTzVFRVg2V0pNQzBk?=
 =?utf-8?B?NjhiZ2hpdjVPTkpIZHpTcWhZSytqSjJhT0JpVEZkbGRzVVlBZ3lsdzdqMkdJ?=
 =?utf-8?B?SGhwRU5wOUdVY2VUYndZTzdEQWZJM0R4TUQ5cVZ3MkJJT0EydEpwS0hKRm5Q?=
 =?utf-8?B?ejJmZFd3R0VGTWJZb3J5aXBoVGNPWGtkbkNoY25DOS9uakw2eGxoL2Zqd2wy?=
 =?utf-8?B?TU1vRElaY1F2dG9Ka2l0TklNWGJ0T1JMZktWSDhjWkgwTGFnRjlKcERpZ2Z2?=
 =?utf-8?B?RXl0M3dWRFJQTTdNeUZXcWZTOWd0ZnpYUU9mem9NU21xRjZqejRVcmJOY1dh?=
 =?utf-8?B?NUhiMW00ZXJGWnlWRGpkRGZYUjlSUnF2MXFKTnNQR2Izd1phYlFudWM5dEdJ?=
 =?utf-8?B?djdWZGY0NkZTYjlJdmdYc3hJWVJWaUR1TmtlV1Z6SDZGOHR5MlZMc1RhbTE4?=
 =?utf-8?B?NUdMTnVlSCtXaC82QXAzUDhBM0RYQkNxa05IWDczVzFxSmEvc0Y2NUxQNEJz?=
 =?utf-8?B?Rm1QUE5JdVFneFRyUEF1elExWWtXVmlXa1YzalBOOXJ0SThrZFB5WnUzczlB?=
 =?utf-8?B?NDJzSFg3b3F5d3htYmJ3d0RrdWppTU05RE9uMU8xM2JwMjQ4eEMwQlZpOFd0?=
 =?utf-8?B?Ynp2YmRNc1ZicDhNQnB0QUpuWjgxYzFiZTF3aG5vYkRRNXhkQVBsbEJ2VEcy?=
 =?utf-8?B?OFdncGRnR1prNEZuZkRyZjdPVlFrVDBLZG5hK2tnOUJ2RGJTTSs1OEVoMVZN?=
 =?utf-8?B?Yml5YzVqN1F6dmlZblY4a3l0UFBxWkduakNlWmxCRzJDZHNSd0FtT3BjMWlx?=
 =?utf-8?B?V1dBN0locEF4Szloblc4N0lkMFZEN05mNXhhNExOVGFyQ1pDTnhEVVZHS3ZV?=
 =?utf-8?B?N2c0UzZUNVA5VFlnSXhFZzRrT1YxUWplYlRjR2ZqVUtiUCs1ajFEenRCMzVQ?=
 =?utf-8?B?Q3d3ejRORUljUUluS2MrMjhWVFhlem9iaW9ucHkvN2pxcDFtdjU5eGlEbWEy?=
 =?utf-8?B?SFFHajdjWFNjb1czRTN0L3NuOHNua1lkdXU5MmRXcHU5OGdOS2NLN0JTTXJ3?=
 =?utf-8?B?MTB2RzlCNGw3cHdoQVlUN3pZOTV6VDNybE9uSmkwYmVYUkNVZjljNHNZRHJT?=
 =?utf-8?B?Y09YUnlZUHFQRjBJZllqU1d1TDREOVdTQ2k1QUhyT0djUTBVN1YyUk5Sb0I0?=
 =?utf-8?B?VU9PL0FGVDNpd0hhdElwTDZzdHZnSE1DK1Ewbm55dy85TGZWbDQ5alFmbE1y?=
 =?utf-8?B?ZHJCbkZERzIzelB3YjBZOU9qYUZEckRDVjFmWkg4cmpodXIxV2tSYXQ5Qi85?=
 =?utf-8?B?VVovc3V2WDNGaUNXNnZPN0ozN0dGUjhweHZLVGJEZVN4MjY5Ulg1dHN3anJp?=
 =?utf-8?B?eFhWUENha0JkQk5mem9lNG0zYkRwZnFlN0FsVkF1WWtZSE9GZ1MxWHhPRjdk?=
 =?utf-8?B?Mk9mVk9OekFXQzk3RXFJTVVEV3RCdEpqMzM2b3YwVHUySnJMMFZCMDVYaGkw?=
 =?utf-8?B?MENGZWRiemxRZlltUit0RzZBZjJXSkdXWUxQYm9BTExSYU1SMUluWnB4QVZj?=
 =?utf-8?B?QzEvOXdabzFRVzVOTk9EczNUZzlFMTVaTWFhZU5jeXpKZ1NTMUxqKzhmczha?=
 =?utf-8?B?ZGFaaG9aZjRWNkQwa2ZGRUpXVGh6a0tHdlpJRnAzd1M0RUlZVDhnN1dUZVNJ?=
 =?utf-8?B?Rm80Vk1ZYTQvS0RKRGFRLzNPTmN0cE5ObGNybEQ2YlB5dzlnRzE2cWRsT29X?=
 =?utf-8?B?dDFOaTAzb2ZScFVZaFl1anNnR0VORjNUN1B5cG1CM3ozZjRrWnp5VkVHTzBx?=
 =?utf-8?B?SUlHb2NPNFhXTnlHZEJPQURZcGlWTGJlL0ttcFR2dnBzcExtby9EbWU5aDEr?=
 =?utf-8?B?KzRiY1U3RTZzajA2K2RYZVZmUVRKNE9nSHJIWU1qWWY5SldBTDVicWJkK0Zy?=
 =?utf-8?Q?Sv5fZmG1pacWQlwpi6XbUdfRV?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43b48721-5c99-4d23-7067-08daf3c95e1c
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6560.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2023 11:45:42.1119
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PKsUwEW9ReEg0+L9PyfNKN04LQMbr2R5om7+UCDS4ee0xhEr2fp5eyQWIoTHOan9I2uk5cxsBqRDy4Zpu+YwEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9489
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.01.2023 12:39, Andrew Cooper wrote:
> The bigger issue with stuff accounting is that nothing AFAICT accounts
> for the fact that any hypercall potentially empties the RSB in otherwise
> synchronous program flow.

But that's not just at hypercall boundaries, but effectively anywhere
(i.e. whenever the hypervisor decides to de-schedule the vCPU)?

Jan
