Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ACD96044A0
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 14:10:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232050AbiJSMJ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 08:09:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232802AbiJSMJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 08:09:00 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on20721.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e1a::721])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2983C50702
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 04:44:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iiatoNfG3uBfMlWxht32OJHjo3u3YmjEzrBKwrZwCHui3SmA1kbhm1Th3E/CZ/i6L5bjJN/2jXlcfFtK3M90UZNQTA+v5/WTHxqIIAFgPEeATdhpzyHydxmi6B8+VN6hV98h1o2MN+UGA7bAyvavzdvTPdWYTLfbMu8/B9PaLv+94+X2+xCDCMpHaGF95lKGT9ZzxRs8V6TkruBtg/mQ/kiiFmfdUGFD6TXnj7LzpNC5cahywx+BgfnrAg/2FDxtPLMzXZr3J0HTRYwF3hHjXwWGUcfMKePd+X0iuvDKyWKjojCjrgdlNqfjjFDzWumeb2juGyNTA6P46nmSHTpu8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Ydn3i3UV/gZYSOaIno3f8ypG8PbbgnZS9oRsmPUgyg=;
 b=PRiFGtLzQINWBZ3d0vFXDDIgPvwyvnY2dyQ3fsmPgGLC43Bnwtu6yVzOxUF7vgpafMEJSSp6EDdyP40jtK3OPGMmfot4IUcnN0e8P688OwSWMDyl4mjfqSrZ+9rm8lE/oAeR+Aks/+GN4bYFQQTZ5duBHYdg059Gj4jQ02m+Q3BdjCgBiN07S0WoCbGWj6MOIYtLy6/6ZD8SfE8CgWFPAEOgFyWpM4Ox156eOD+V8rOOQ32pizx5aK1gudZffbQfCa4UY9RloqBKgHR7xjpSXcGAP0pV8zbGt3aH8uBdSlgpaSgtUgpN+a3CfrrqsKSfV6Yhg4UrcJW+YyY2gbBJMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Ydn3i3UV/gZYSOaIno3f8ypG8PbbgnZS9oRsmPUgyg=;
 b=n+bV+2OU5rCjQ90fvZ5Kiv2XT5L8L/GfUcSkl2T66qY3jOQ3fs6EP1HL4dYB10P0YCoFrQbAY1taC7gsNTsMiP/aqsjgPGuJqZvTqztDfCwidr1/JMrYTP2cQe52+37bNVbBb4Nxs6HPmhLIeyctIHOo5Ow8WQ4adtA+4pcxE+8Yph3i5nDcaSNPdLzZMHPDlYTEMqwjdd+xMcMouz5MGjxPmVhQ7pR7H7D43J2CogMXfjGD1wDHo66NJPnP8LHOITynaWb8pvMbaMkrzUfyk8aaqTXDN5xcaVav1BhDC+c+HMu+/2naqHO2DYsFExRlKtljsLr7hkfe3f6WaInYHg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VE1PR08MB4765.eurprd08.prod.outlook.com (2603:10a6:802:a5::16)
 by DB8PR08MB5530.eurprd08.prod.outlook.com (2603:10a6:10:11f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.30; Wed, 19 Oct
 2022 10:38:15 +0000
Received: from VE1PR08MB4765.eurprd08.prod.outlook.com
 ([fe80::6809:fef7:a205:b08a]) by VE1PR08MB4765.eurprd08.prod.outlook.com
 ([fe80::6809:fef7:a205:b08a%7]) with mapi id 15.20.5723.034; Wed, 19 Oct 2022
 10:38:14 +0000
Message-ID: <2ae8251a-456d-abdd-ed1a-1bfc04356741@virtuozzo.com>
Date:   Wed, 19 Oct 2022 13:38:13 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.3
Subject: Re: [RFC PATCH v5 6/8] drivers: vmware: balloon - report inflated
 memory
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Nadav Amit <namit@vmware.com>,
        VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
        Arnd Bergmann <arnd@arndb.de>, kernel@openvz.org,
        linux-kernel@vger.kernel.org
References: <20221019095620.124909-1-alexander.atanasov@virtuozzo.com>
 <20221019095620.124909-7-alexander.atanasov@virtuozzo.com>
 <Y0/Qu0eSYFqtuC/v@kroah.com>
From:   Alexander Atanasov <alexander.atanasov@virtuozzo.com>
In-Reply-To: <Y0/Qu0eSYFqtuC/v@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0501CA0001.eurprd05.prod.outlook.com
 (2603:10a6:800:92::11) To VE1PR08MB4765.eurprd08.prod.outlook.com
 (2603:10a6:802:a5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4765:EE_|DB8PR08MB5530:EE_
X-MS-Office365-Filtering-Correlation-Id: ff6a2cbe-7fb5-4452-8e69-08dab1be0723
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m4Qgowx22ojbJvw8CV2JPjNNT8J/DCVkOMDWj1nsM2xN3jqy7CW2pCv2qskUOmOsOBNOOLHg1WGdxf4zMfrd8u4XtsuM7nmYcpIctBwBm17BQzbAdetMln5kA9O+34iLGljaKACwktlhAGTBMkL2PVEINgjEBX8dno+BOO8krMKuzX0gqFWUc1Vqbcv0H9wXj/F3kCNqg7IdnHFXORzO7UZBg7vWXWVkQD2dR2KkW5o3o0/ISuRNHtQWlgdy/T80ezO0E0JYTCLmJlvf3G2IAF5zJr5w1TFSbkLrllqy3bznKMjhHnB/lf2GoicktmVbuGHgafvfQaQoYnIIQN7orTvt6/yh46R5VEvjdu/OK9TjyGwZ31bz3BtkaNaVnscc/ngjeiTHM/rbw7yhxqQdLAFOuJ+kOuBsVMbaczhoGXkTDR0vKxZYbSXwjfAw0yHKHCJT/BN9ohr6bByGJ6XhaBTJZjIlGIxOVae0FUndbUTJMGR8JW/g3jTQdGj4juUi/i0pad+a44lENCZZIqcpI8liB65dMJBQPQgEx55uDqr+v1+jBu6zygNck/g0BDPAc5X6dsSwJCP8f/pmCjDja+IB2kDYttE6uEd0JSrXs1yf88ni+pYu9Wg4M4d+yElz/w3wiM/QSBNLzRIQhTq+UTRvbOpH+igB/LYS2c7BR5nWjdvQB7AEHeZ63mgfm/fNKP22uH69y+rI07TIk7QG1rg0V3TmhE3+dvtJSCXbNuCTdDD245u8rb2ulHwI/CtEsi6vic8OOauVeg+1lrN31KI9CCiPM9EVJ3Fpqo2MaL0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4765.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39850400004)(396003)(376002)(346002)(366004)(451199015)(38100700002)(31696002)(4744005)(8936002)(31686004)(44832011)(5660300002)(4326008)(41300700001)(316002)(66556008)(186003)(66946007)(6486002)(478600001)(36756003)(66476007)(26005)(6506007)(53546011)(2616005)(6512007)(54906003)(8676002)(2906002)(86362001)(6916009)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VGZxai9rZzU1VXQzcFRHQnpubGdWaXhoNlRTTmN1ZGxyZDZJbnJMQjZEV2ZS?=
 =?utf-8?B?SGUrczRLRnBtM1FvTDdxd3pJOG1qQkhkODdUQXdSY1hlL1gydFFqZ3pETWRE?=
 =?utf-8?B?L1I0MVFqWGpxSGY3c28xZnlZMXMrcnN0Q1dKcmovU1NVUXZRMjNBUFhJWkhy?=
 =?utf-8?B?NGZLSTBDWlh4Y2lPL3BRWnlrU3c0bEh5cERFUlkvUFN1M2NDcHRqUDdWRi9R?=
 =?utf-8?B?L1BobGU1R1BqUEtWVVR5dW9GT0xxMy9UNEppRVRNaDJLMWNMS1llYi9keDdL?=
 =?utf-8?B?R1VmcURVTUNiZmJEMXQxOTBxZm9oZ0tWWXhmSkZaZktIVENaM3hhUXAxdFRQ?=
 =?utf-8?B?NVQ0cElZMTh0SzQveFZJM0sxVE91NHdobWVBYlVWdzhSemZ3YUlzZmhuajFD?=
 =?utf-8?B?dXJrL3ladUgwamFNYng4Wm5Ca096WEVlUkcwdG1FT0ZoUmNhZXlaWXI0aVFj?=
 =?utf-8?B?S0JQL0ZrVElGSU43cW12dU1Bc0lLaDlrelNBcG44QmtyLzVLUGZCU0ZVL0h2?=
 =?utf-8?B?VmVqTlN6NVVsdzZFMDVjVFEzY1VNSXJVelpSWVY0SGx5NXNBUUdyTU1yQ2w2?=
 =?utf-8?B?QlVNcFFKMHlxK2lNTzBBZHZwOFdzMFM1S1lvb3pDdVdrcCtyT1R6SEtEbjlG?=
 =?utf-8?B?Y2JMSmpBWEdPWlpENm5laUp4S1N6TFh6d1I4TmtvQ1VnRmphTjJleWtqajE2?=
 =?utf-8?B?d2laWkpRdy9FL0s0R0xqSkMrZ0czUDA4U1hmQnVjaXl2bDhYSEZ1eWEwQk9r?=
 =?utf-8?B?cDNVenVnQ2ZyQWFxQ3B0Yi9sQ0NXc0ptNG5vWTJJRlJPMW9iSERzTldZQThI?=
 =?utf-8?B?TE9vZkx0SDZlWlVROEpYUGFtdHpjaE5rL1JTMjdiYXROMGhhZ0tLT3ZKKys0?=
 =?utf-8?B?SEFvRHNtT0ppdDBsbXhkRU04bW5EL3BCS1dmeVNWY3BJc2xGazUyM3NNdlY5?=
 =?utf-8?B?K003UmV1T0lBcllEL25MZWVEckJGdHhWcnUrUi92TnltSU5ZOWR3WlVIVVEy?=
 =?utf-8?B?cndsbDQrK0VvbWhtR0o2bnc0UGZTbkFhaW5QR2tLNVFNdzBJSVlmSEVMQ3ZZ?=
 =?utf-8?B?RlA1cXJVeW9uYnM4NiswbkJIUEtXcDFVUTdXRHZKNExrUTA1MlkyaDNJbGpn?=
 =?utf-8?B?RU1YQ1paRWxkZHROSE5FR3RXV1BJSmVrMFhPNVFDZS8zeDlDU1AzV3pwUUhI?=
 =?utf-8?B?QmVEMUtLdmd4dzlkWlNySE1KQlJuWHB6b3M0a21Dc1JlSW9uU0FLNFVDOFZ6?=
 =?utf-8?B?UjVqL1p4YlpXT2M2dTBUeDJHWDBjQmRmdnk1a3ovSHhTb2trbFMwNkFqdm1D?=
 =?utf-8?B?QldMN3E5RmFaK3k5VXhsRkdKdkhPOEJiTElrUFYyY2FZMDFVczhHclJWL3la?=
 =?utf-8?B?VURoN1d1cjE1NEhLL2xhSXk0RUZSYVVmem4xVEJOWWl4RmY1cnJKMC9hRmNX?=
 =?utf-8?B?RmdBMWwvUlFvdUNmaG5QUkJDeHk0RWlFS3JtYk9qaWNjT05JbzB2NENyTTJI?=
 =?utf-8?B?dWxaRFNCR2cvRnZLNFBZOXdITTRJL1g2SVhWR05xaHJudWF0clRYcm1BY05J?=
 =?utf-8?B?VmJWUUNGZWEvQ1hsN1FrMkF0QTNXVm0rZkJ1Y2g3N2ZHOGlFT3BtUDR6b2F2?=
 =?utf-8?B?RDZnZ2lTWTYzb05qSTBoN3l5ZEttL0pEbXorYmtvems1QWdFczVMWFJCTk51?=
 =?utf-8?B?Q2xXOVVQWkd3OVp5VHkyaWVzVFpXZFltNmUzdXo5RGJoS29CdXcrTHNSTWhP?=
 =?utf-8?B?VDdhOERxd1U5bE52YzFRdTdzVjdpZy9QMDVxeEpBWGVVbis2L0h3Q2w2cUdk?=
 =?utf-8?B?K08xMFFTNUJaM2Q1QysvYXBnZC95bE9zZmVCL01qdjk1RTN5c0R1UFpVelZO?=
 =?utf-8?B?cHZjdnZwMU83dEJtemxYUHU1YWVURVd4QzVPWEJzVHUrZlUyRDZnZ3owMmpF?=
 =?utf-8?B?U1ZMVFZ3T20zUkxteFVYdVdIYXpkbEV5VGV2ZWIwbzFJbkxvT1kxeDl2MUpI?=
 =?utf-8?B?L0xla1U2UTlaWUw4SzVJZ0FheGE0RmFWRFoycHkrU0dUcHBqVE9XL29aQWYv?=
 =?utf-8?B?UDVKNllzcjNURFJJNE9ENzNJU1plSFFPUnprNTY0U3duNVp3aWJUZ0syWHBT?=
 =?utf-8?B?VmpJOFVFZG1hUTBkVGVzM0lQRTlsWmpkUDd1YWNWTDZURmpvZU1HQ3dlM2NR?=
 =?utf-8?B?eEE9PQ==?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff6a2cbe-7fb5-4452-8e69-08dab1be0723
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4765.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2022 10:38:14.8801
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ztuKDWo6qag8TwK624eMNWX9Wojf40ROdjOsQN7B0wATPjbxbgO2AwQlP0MtWfdt9VSy84TPuie9RX0FyhrhxdvVPtNoTzNTnIOLCPvi+xWxJgXqmWI0E42GIq6Poj98
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5530
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.10.22 13:26, Greg Kroah-Hartman wrote:
> On Wed, Oct 19, 2022 at 12:56:18PM +0300, Alexander Atanasov wrote:
>> Update the inflated memory in the mm core on change.
> 
> That says what this does, but not why it is needed.
> 
> Please expand on this.
> 
> Also, is this actually fixing a bug?  Is it a new feature?  Something
> else?

The whole series is about adding a new feature - providing access to the 
balloon inflated memory amount - it's in the cover letter. Should I 
repeat it for every driver that implements it?

I've organized it classically:
- prepare
- add infra
- use the infra

What can I improve here?

-- 
Regards,
Alexander Atanasov

