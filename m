Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C9DB60DCB2
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 10:02:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233299AbiJZICl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 04:02:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231649AbiJZICi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 04:02:38 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2056.outbound.protection.outlook.com [40.107.105.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A806E9AFC7;
        Wed, 26 Oct 2022 01:02:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GPPXJp4RLkc+W46IWI1AcjyGTWVRGVikJ4eDmT2XK0lU1F9F3pg1v8wAzmwm/bo4MPb5Nv08rMBvOzmDOILrnIYN1k8UvLj3S8bNQ4ZDHMfZN6NfeI/mD+zQVKPoShcqcZEp0PHeKJylFph1N27BbbwYDyHPR3YOqlFshUMOnKcQev5ecQ4gME6SW0SaRS1KvOZFTcHmAeok9fUjGN9/uaAB/vMP9n5bvSG4i1Fn67+4aR0iHMUlDs4oaGPfJ450raDpMs/3GGYYbu4+ubfUUUQdw2hw2Hig1KeU8QTyXF+3cGmHUqHPbFBhflFeeFg8NseVdiyuXFm4qwWVk/mk8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bSrHMR0xerv6lsliqQVy48NZ2Q382O4KkH17e63OROw=;
 b=b17QB5I93uS0zoVlaww3j8coFO5RMTzHDZl4zYnhdrT6YtoCnctR7uLUCGu04NhSLrBdJlqmKqfe7bMZPPbpyVnBn6AFEW4r/I4aH+0ZGMmKusE5Dx+AYqLh6DZ/yi9xp+JEJR3E77AZCT9XjQDzqwwv8HNCPPnyQdZRPacayqjbSZzBI2xFM9smzTHFzIkLM8sa1pEpQ+0mwr/nMqSnadBGadlH+9VC/nHpGZ48+Q81vjcRABLn9Y4krkCtf1hS0Yu8hMyJOHWJub85CYGDWcaI799CcDOWNoqS6g0JRJlu0s+GX4Zb8ac7QBlsnl/KUdrgIC1ARm1OzgbbLw+vpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bSrHMR0xerv6lsliqQVy48NZ2Q382O4KkH17e63OROw=;
 b=4qKF+UswKesamqNii6ZZKZvcOQcvvoj7Nb91vd0W8yF5VIDhORmIl8Y99dJN7Pj8rMDc0iCyLu6M0W8QSmRpat3We0N02vRz5MX9aU/SOhWK7zZt1LGp+mV+vy2jVdHEUTf8vmfg1C3Tb6YNHBugV36tE0+6oUB4OSL3fB/DuQ0w8hyrd3nmi0UVh/fkdjYOm9t1T3gynVEXO9TGyLsCgyoc4KtujfKxpui4DuXRgfFlFEeGaf+Z9/Q9P+pcOHtk/3M1qt2fEx8XmtQZ0gFgF7NfT0sMa6HBMV/XaZQiFITCBdcovmgzpfbWsiXY8Xndj+U2ohVWlh7HX7pYZQjunQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB7104.eurprd04.prod.outlook.com (2603:10a6:800:126::9)
 by PAXPR04MB8846.eurprd04.prod.outlook.com (2603:10a6:102:20d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Wed, 26 Oct
 2022 08:02:35 +0000
Received: from VI1PR04MB7104.eurprd04.prod.outlook.com
 ([fe80::1bf0:ae5a:ac96:5dea]) by VI1PR04MB7104.eurprd04.prod.outlook.com
 ([fe80::1bf0:ae5a:ac96:5dea%3]) with mapi id 15.20.5746.023; Wed, 26 Oct 2022
 08:02:34 +0000
Message-ID: <65ed2576-55a4-fbf1-010b-a51e92389062@suse.com>
Date:   Wed, 26 Oct 2022 10:02:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2 1/2] usb: serial: add support for CH348
To:     Corentin LABBE <clabbe@baylibre.com>,
        Oliver Neukum <oneukum@suse.com>
Cc:     gregkh@linuxfoundation.org, johan@kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        neil.armstrong@linaro.org
References: <20221021133758.1881904-1-clabbe@baylibre.com>
 <20221021133758.1881904-2-clabbe@baylibre.com>
 <135c51e3-56b6-cdf0-3499-cd354f43601d@suse.com> <Y1jlTP7HuH1FQbpk@Red>
Content-Language: en-US
From:   Oliver Neukum <oneukum@suse.com>
In-Reply-To: <Y1jlTP7HuH1FQbpk@Red>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0157.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a2::13) To VI1PR04MB7104.eurprd04.prod.outlook.com
 (2603:10a6:800:126::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB7104:EE_|PAXPR04MB8846:EE_
X-MS-Office365-Filtering-Correlation-Id: a456b9fa-0998-4a64-643d-08dab72870cf
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rm33PhIQEdwXaoIIKdrapdNjX/lR9bo9hIEuPuBPSqpRTLcA+u+toxjbKNq9aJfkbmNy63asdWz6oInZsRXhuYQ9s6H5QP3QKYeAUnmmEIgAm6gZUHACe5FsLcUgW145WHKGBZGKJ4HPwb3wIY5Vllaxw3GJDgJwvgwidkO/0wmcugow45wW0Lzm2G+x3t+3tZYriLeulAZo66AzWovLI3yJY0XSXn/prpB/1H5ZRKL14MtQyAlYbS7m33TV9jrNj5mr6iE8b1PirHgBqa5cSQWgYjX4rHmS9PcRTxdrgs5UwXBDn8Rc6WWSLTr49/ajw/Jcnr69S+7C9+PyPJnEl1LujSNUs9xo7fkQ/xUa+SSbJn2aYd8WJY2jkrollVRG38noKmkwCg35vF4kBtkF9zgEKU/q6kh07KQiZlZ6zPUvqz/zwSqqGKbzvmEf9U3xQmmUaKNzB6XB8GzEqE4UpQdJC9RAnKr4CB8ISttgTFSC22JuSF9fx/v2lbLxl6o+3p7Y91JrtCJLZEZAWKeBKdtlMFW+HWTQ3hwwqH+X7jzSm2eaJzhj2lOSgN5EhliT9ZXQJlduIlXf7F7SuKtL4f5DcT0+Q/GjKkYJkw5C0Teb6eU414LrCgYJP9joC8f5lLtHb5eT1ox5AScEEgUje+dZYjONUjFCRqlMRxon1O2h2+drRt+CMJgYcJwkzE1fIQBwvmOKNYwEvW3HfuYGErNRq19+TpMBTPfKzchBOe1Z2/J71Zu03ZaEHt27nDMyMh/JtpZ16/jyhw4n1LJ5VU4oL3Q+zVSWkwJIXRHp+T4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB7104.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(39860400002)(376002)(396003)(366004)(136003)(451199015)(186003)(38100700002)(31686004)(41300700001)(316002)(5660300002)(4744005)(66476007)(8676002)(4326008)(66946007)(6512007)(66556008)(8936002)(6506007)(53546011)(2906002)(86362001)(2616005)(110136005)(31696002)(478600001)(6486002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WXdtUlNwRS9WZkdpOUlKNzBQVmdLL0o1dVR5a3RiN3dSajYwaHBDRGFCVnBP?=
 =?utf-8?B?bXJuTzA0elNwZk1DMHZCdTdqckpVYU81blMxamxuYkl5OHpOR2c0alo3a3FH?=
 =?utf-8?B?djhEUHFvOFludVJuOTZ1TGRIWkh0OGVadklQOFptc0NSbUpmVDRsdUYvZ2sy?=
 =?utf-8?B?UGhmdHNtWDBvbFVIMitxVVQvSlpEVDNkbW8yZmE2ZTVUUTZGMEljcjBFUHI1?=
 =?utf-8?B?amlkNnZ3bHc2L1ZqbC9YaTljS3ZUOUVaeEZrcmk3WXVjcGFsclN2ODdoOUdE?=
 =?utf-8?B?SG5TbzMvRlNrMmkzd0RzTGc0VVpOUlJGc25wK0o3Tzg3ckNkWHZHZzloYzk3?=
 =?utf-8?B?WStySUl2OEdZUjBiV05HRndGdTY2NFRJUmpITWFhNll1WmE1U0l1dkhFUzg0?=
 =?utf-8?B?ekZBUXo2czFvWUxEWWJWdzZhTHhhbFRjZklLQlZXNHRyWjhLV2dyYUxqdjZO?=
 =?utf-8?B?bE1DMW5ycTZBTVZvTXh5aDRaMDVmTE5wMVNJdXF5anB6RkE2NjFlNkQ4UHNT?=
 =?utf-8?B?cThEdWplZDZyY2VpN3EzaHNsTkpZRFZ2R1NXZFZybCtXWFpaOElraG9uS3ZX?=
 =?utf-8?B?OHdJV3QrcGhTa0J6UTUzSE4yRGtqWWQ5SHZhYjArOUh0aVRjcU9NbFpVNWFO?=
 =?utf-8?B?MzFRU3R3dW5lY2hIbDNDRXZGdGlwY0tLSWpCd25MRHNqN3RSeUNYSGJSL3Jn?=
 =?utf-8?B?VnhSaHlxM3pnT0RMVHgzVS9XL1dYNWhJUElsVzdjZUphZE13YzJEZjhNQzVI?=
 =?utf-8?B?V0JnS0l6VDBzcVBIRGNrem5WcWd0NGdacGg2YlR3aE9wcktLTDNHZ1VEM3Az?=
 =?utf-8?B?SG53d25rdFVxUXhpYkJ4cjFuQkpWY1hNTGg5L2ZMRGsxdGd6OWVNY3N0R3FM?=
 =?utf-8?B?RmpKUmVDK096UGpHWmtWdW9OY1JTYWpYT1ZvNVN3UkQxaG5DMThtcHUwQnYy?=
 =?utf-8?B?T004MXgwQmNXalJ5azlKRjZHMTZuM2R0QjRGc3VNMU5IY1BFQjNXWmhoRjZF?=
 =?utf-8?B?eWs1c1g2OUZyaHN6eXNtZmdZMitvK3RDZDUrekdwQjZpMW4yU2J1R3k4bE9X?=
 =?utf-8?B?WFp4Y2dDTXNaWXgxc09vaXR2WWNOQzFEdWZoL1hkbU1TcVphYUpDcWJhMHR1?=
 =?utf-8?B?cU9leFJ2a2Z6WVczOGZUYmswZWZSblRCK0NLL2owOVpiMDZjSVZONWMrQ1dx?=
 =?utf-8?B?ckkxL2NqRHUxYmVCM2l6R1k4NGhXdDJoUVNTd2tuVWl4dXpxOGJlcS9aY25V?=
 =?utf-8?B?SjJqMUNid0dYNWRRNXFxT0lUNUlndTNnakp1N0treGU5VUZkZ3VySU9PNXY4?=
 =?utf-8?B?Q21oc3FpdXVCWUh0OXJ3c2ZkTDJwNnZJRVFFK1JyMmxsZm9ydVk5VysvUzkx?=
 =?utf-8?B?UU1PSFpBdmRGUTYrMXJpRkpTaHYwMkhjd2k5Tzk2OTJ4N1FVU3k0YW1tNlN2?=
 =?utf-8?B?cFFlUzlVY2I1OXJIdG9YZkI4U2NRd3pHNWVGTlIxRnZvWHcvckJNVHQ3ZGFk?=
 =?utf-8?B?TXFuZmF1bHZnbmZpSXJ1RUVRbkhUdE51UGlkSmR1NGp0UDVtTDM0dG9QaGhJ?=
 =?utf-8?B?RXdXaEhyb0plYlo1TVBKUEdST2ZUUC9mazlrSTZrU080VmhWS09VRXZSSFhB?=
 =?utf-8?B?QWtick5ZZkRqM0lpRk9DdFZaV2l4ZUsrM3BRb2ZNODVjczl3MWtvdVNmTDA0?=
 =?utf-8?B?T25QSXk1RWNUQ28wZFM5UVJncXFFNmh2aHdUTk1vMTJ0bFkzZkhEaUxGRURH?=
 =?utf-8?B?clJ6TmN1U2JabUtEUjlmVitaQXh0bHhLakZOWko2UEc2U0g4WWdrb21sNFg2?=
 =?utf-8?B?SmgvR3k1YVNnY2F5YVlvK2lKL200dVByZS9PMmk0SHJFN2dLUk1jQkxDUjFw?=
 =?utf-8?B?N3RyVUJYQ3JFQm56QjZJSmVTMmtRaEdCTE8zY2U3d0ZuczQ0ZFV2clJYS3dj?=
 =?utf-8?B?SEpQcGdPUU9zd2hFOU5lWW9pVkNGczQxVmZxWkdKSGUzbDBnVitkcHN6QlVY?=
 =?utf-8?B?dTRxcjQ2OUYrSS91UVBuRGJBQmJaNmlCRktDYUFDZUNLTVNHc1NoeWJ0L0Rx?=
 =?utf-8?B?czZSYjZlMUx1S0R1STVlM3doR0tWaHJOd2ZEc0pZUy9VeC9HeWhibEZUa2pC?=
 =?utf-8?B?Vld3bE1VK2FRMlRxMUJjY3BWdlhFTnMzZi9zb1ZGTURHcGxMSFpDMXNkbnRT?=
 =?utf-8?Q?EVOtcyRW7O/k5JmtHiksx16yvSnaG+ficcaJlzbSZ7kP?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a456b9fa-0998-4a64-643d-08dab72870cf
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB7104.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2022 08:02:34.6967
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yujjDh2ZMWHbR/oD3LJFY/O1/74uQ1xHXyuoL+hpyTye3BHW4aFToqQFDZEzdTYwBgJl0C6iXSKrwqrJ9Y6MAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8846
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 26.10.22 09:44, Corentin LABBE wrote:

Hi,


> 
> Thanks for your review, I will fix them all.

I am happy to point out issues.

>> [..]
>>
>>> +
>>> +static int ch348_fixup_port_bulk_in(struct ch348 *ch348, struct usb_serial_port *port)
>>> +{
>>> +	int i;
>>> +
>>> +	/* Already Initialized */
>>> +	if (port->bulk_in_size) {
>>
>> BTW, shouldn't these be unsigned int?
> 
> I dont understand what you mean here.

bulk_in_size as a member of the structure is defined as int.
As a size cannot meaningfully be negative and this takes no
error reports, I was wondering whether it should be declared
an unsigned integer for the sake of cleanliness.

	Regards
		Oliver
