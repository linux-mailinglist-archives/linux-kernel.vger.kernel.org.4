Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A9CE6F5972
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 15:59:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbjECN72 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 09:59:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbjECN70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 09:59:26 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2085.outbound.protection.outlook.com [40.107.92.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77F603C3C;
        Wed,  3 May 2023 06:59:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BZ6y6jVhYgZB8jHTchEnnWUhCKHIq1l3xMSO5xIDEAbIdi3sJ+DH7xnbdthAO0yuXyVGb7Guca57mSL6CQ30vLri5lIgxDji47YHzNS8QijFFFTjBjx0EbVD5mc1Z8LBhG2Q1rvZ/duIfDGfE8UUNtXKYHrRWVI3SwghK53y9X/LMyqcyMs4M5c6B8QidxCJD1dviFZMhPjRNFvFZdBqBYDKAZaqZfnSsQMxvr22h9BMZTIihbX1ivE6AH2vqNxae2MHl/BTYPrua62W9XNjMXIm45JhOdqe/KbI4ZmIGPLE9zPF3YnkYnf9dXkDlQoUzt0lsKId34XX/mxkKdqr8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BQE3JGfCeRn9OJPtuzIdn/meYe/Cdymzjmy6UFy6F3U=;
 b=kELBrnv3JNGkV6BbgjiyifcboxlUR6wRIm9T9t8DAdoW1JnlYA9+KLz6IaTgJ1xZEUklJaCP0DQuH59X6UXpKfssTOdcu7grbiHji3C6H79dz0IWJ7XfUj47gLh/HgaOOUjJxOI3BVH2w03/ar0HmG/X8Yaow0KtY34GttQT9NFC79hSZAN1S370hT2egz6/pehjJ+V06AGLghPVJ9VIpLpb8TstHIM8EhlI2tz3GMdzq/w7UwG+72JXILh2nu2ng103aW/ieaRg8YPheWAzu/tY0Hhnr2awrXKaG5l+UUhRxtzbRjLpCJnDOeTmIxh/hv+IlTF3KUnfCyvhBHkQnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BQE3JGfCeRn9OJPtuzIdn/meYe/Cdymzjmy6UFy6F3U=;
 b=j72S4kUSzV7b3BgrUG1RZ6EC1suMBc2Ht8igUz0KBrhgU736cWaYSThiKWcx2lKAjJaDXOyFwqwRr9oKCXt9BQFmxlO2kYpR+fRfiEE6602BATOM/YShwOWhGiue8rkY+uHd4mjRixQmnT+1nrdc00IE1f5L51r6jLVDQs653S8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by PH8PR12MB7447.namprd12.prod.outlook.com (2603:10b6:510:215::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.31; Wed, 3 May
 2023 13:59:22 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3f45:358e:abba:24f5]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3f45:358e:abba:24f5%3]) with mapi id 15.20.6363.022; Wed, 3 May 2023
 13:59:22 +0000
Message-ID: <ac090da4-6cec-8c5a-22ac-36e130cb201a@amd.com>
Date:   Wed, 3 May 2023 08:59:13 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v2] xhci-pci: Only run d3cold avoidance quirk for s2idle
To:     Mathias Nyman <mathias.nyman@linux.intel.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Natikar Basavaraj <Basavaraj.Natikar@amd.com>,
        Donghun Yoon <donghun.yoon@lge.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230424214859.3109-1-mario.limonciello@amd.com>
 <8c4f85c1-32db-a84c-f77c-6e2aa556d2f4@linux.intel.com>
Content-Language: en-US
From:   "Limonciello, Mario" <mlimonci@amd.com>
In-Reply-To: <8c4f85c1-32db-a84c-f77c-6e2aa556d2f4@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR10CA0012.namprd10.prod.outlook.com
 (2603:10b6:610:4c::22) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|PH8PR12MB7447:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a7e161d-bb83-4809-e469-08db4bde98fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ckmCURWCVlMgbAhZQkNPYcyA/OQrUOkf3fmlAqQKSMpgUdqCYP2es1Zh4ZQAaIIBiTzl0Xq0ZVifyFVOn09z9qZK4AC1afAJKSlUgBJI7M0T8DaMGXD3U5DOzNYvHa0dsM3PKCGNNaIwBNXo/Q7qNTr6d00icYq9LUzlq8XiLRFLCvoBJsjPbZQ5Afbf1Bs9DT1hal8o9WrFp9sJm1ujL+ha7E7VeRyXSvv3ggnwU/dokipl6c6iMPthxiLqJHMA/3panyYhdgzmX0ZzAItVeiyssFES+pKcuUvCTNNMKpjvz/82YqsTYliIcGlIzbylEZFs2MgG1i87t8or2Oz+0j9h3H0Vewd94Ryfd73C6pIOy9pIywJ7rZxeu4cdzxvByBoBsPiYRKqchOO1+FoVV/v8ao7e9KuRhFqSaqde9aXiAhL+8cMmxC0dqNSx7bYyd28Z9w/ee2EAVM606jNUBx4O1yo175XtYVc2q6CN9dTPrM/MZ5nQFJuVkqnYT1y82dQSz/N12ADuZCsDnmIzysoUNs4dgYZngZMGtWkpa65anwvg+dDQm/jHQTICIcZXBchyT3y/gfhuqpaF91kq0qFxhyrl9Z0hCdHsiqiO9nta/+6uNkAmjxh7hLgv1b5Ll9dZn12d3QVpJutZmvRLIZE4oWX6i2vBm3ex1SPDlSzCU1XCCXeE62z/1L0ONSoh
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(396003)(346002)(366004)(136003)(451199021)(31686004)(8676002)(8936002)(2906002)(5660300002)(83380400001)(2616005)(41300700001)(6512007)(53546011)(316002)(186003)(66556008)(66476007)(66946007)(31696002)(6486002)(478600001)(26005)(38100700002)(54906003)(4326008)(110136005)(36756003)(6506007)(6666004)(42413004)(32563001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YkRIVDlETHlqb2gxZWxPRURyT25wdlpoTVFtSk9ESFI5b3J5TEZsbWowdGY0?=
 =?utf-8?B?OXNzNGdpTGtxOHZMNllyMkI2djRvdnRocWc5QnFmeHdoNVRWb2pBV1VFU1lL?=
 =?utf-8?B?c3hIZnl6dEhCaTdoRkhzWFFZc281U01iU2RRTWttWU5xZTgweGsxeWg1QUhj?=
 =?utf-8?B?OGxqdmVRTWU4ZmpMZ3dZYzluZzhFclVXQmpzRjMwanFZVkNCbXEvcE5TZDBH?=
 =?utf-8?B?VHRQYjdxNlRWZ016emMwb2hoVGJhdGxUK09oNS90UFBKYUJGTUNMZzYrZ1dW?=
 =?utf-8?B?VU00bGRjQjZTRFZiR2tKSVZrTjJ3Wnd0RzZVcThsSjJxRWlCRkN5R2ZQMDZr?=
 =?utf-8?B?eG4vSE9qUWVYYTNLTTdXZGdRVEFoNk5BQVczUHJTNFRpTTMwWFNaMFI4MFVO?=
 =?utf-8?B?azdGR1JiVmRyUzJkZTFCWk5GVjZTWGg0TkpLOERJRldjTTBDTWNkdnYzeHAw?=
 =?utf-8?B?MEh0OXhWMGJVS1BUVVNMbG9VcSs5U1N1aDdXRS9lSk1mczFkaFdzcU5IWWxv?=
 =?utf-8?B?L2g0UFpZcGFLV0hZMG9Qc2U3eHJNOEZ6c2owM2tqTmFjVzFvdG5kRDdUanNt?=
 =?utf-8?B?SjFua3JWZ1Yyb2FnOTZIdW54Zm9YcERyb28zcVhnZTZiWUMrZDBiWk1EUmhM?=
 =?utf-8?B?cUdMdTBkay9kUW1hU2xpdDcxNWFUMHp4V1NGN3Z5QUVhR0F0ZVpzTVRSRm9v?=
 =?utf-8?B?ektZdFU5MnF3a1p5WEQzUHNWRWJZNmVxRGdncnJVL2phb3FYOFIzbmI3OU9U?=
 =?utf-8?B?dnJzUmNBYTFIWTRGUkJLNExBRkhhVkQyMWV3U0xmV1hPbzZGbE5jaGhvaW1M?=
 =?utf-8?B?SkpwSmRHVGovUi9YV1ZSMmpsLytURjQzYjJ5enozVXRHK3BmMU5ycm0vbXNu?=
 =?utf-8?B?a25MUUtQVGg1UUFJK0EwWmUzMmxBTzRtWkx2UGQ0Y3p1elJncXBORUhRenc3?=
 =?utf-8?B?QjZDVkVjUHo4aGR4TGd4eXBuS0tsUjlxWjlkQjZXeXJ3MVlUdmxoS3FsSnRN?=
 =?utf-8?B?MmxVNWlLcDBmeXlocjczaWFLbFZmblJUSEZKbThOSHJaRTB6SnlYUmNxaElk?=
 =?utf-8?B?VVAwdis5VnFXak55cDlSRUJ6U2JKTFBlN0MwSUVObCtUOHdhMDdEWjh0OGtu?=
 =?utf-8?B?WGFldWs4NnFQM0QwYkptTDJnN1VWTHJHY01BNGdINGNlMjNUbDhidXBBbWI4?=
 =?utf-8?B?MEZVU3pDUTVxbWZkZDZ6K1BCd1BhM3IrSHRMVjhqRVl1Z0ExekI3VmRDREtm?=
 =?utf-8?B?YWxDbFIrMlJnMHUzeHFFbDlFakpKRjhKZHREc2dzMkFzN0NwaUVOQUF1RlNC?=
 =?utf-8?B?bGYxR1gzek9hajZvb2Fnc2NYRXBWb1ZTTElwVnV0eGR5TjlVRDZXNGo2NnhD?=
 =?utf-8?B?WVF3bHpEVzJxVVQ5SEpNRExUSnhSci9KTHpHSXFpd1duQm1lYndNYVNmK3Qx?=
 =?utf-8?B?eFdTUkRRMW5CV082cmNNRTJQRTQ3RDJaWEJkRGJkR1dyK3VVNVI0TkdJZnZT?=
 =?utf-8?B?VytTdyt6YnZkU3pULzVHNzZLa21meHRJVE54TVhSMmI2bWJiQ3p2cnR3dzNT?=
 =?utf-8?B?UHFlOXF3Q3E1MDQvRnVPdzh4ZjlCbUw1NWpaMkV2SllBOTNkandVVnFJMmxq?=
 =?utf-8?B?NGZRQUpzRm9oOFlBTEFiWGFIUmVIbGxtQkM1Z214bXFVTlRTRWtwckFNTFBa?=
 =?utf-8?B?ZmNqemJqQlVWS3YvUEdTTit1bldhcHRkYzFzV1FZVXFDUWRjY3dzMFFVK3Bs?=
 =?utf-8?B?UEl5ZVhSNVJQUno1Q0kvcHJwYUJrLzJSY2pncDh1bkwwRytKUklkS2dxWWxS?=
 =?utf-8?B?emFYc0JpL0Mvc1hFWGxoNDZaM3Q4N3UxMmJnT253aUxXc0pNUXhSRzNRQmVq?=
 =?utf-8?B?OXA3TVhMY1V0SUhRQ2ZrdmtPU25PaVNDdktIZUxJZ1VyV0tqNlhwZE4rLzF0?=
 =?utf-8?B?Ny9sYVdpSHExVnBnZkltSEcwR3ZwRFc0aS84ak1QR004YnNJK0FHaWxybkNX?=
 =?utf-8?B?VGxOVGxIZWNMQzE4M2RyUWtzWitrYzJ5RGxhOS9XWFlmS0h6WWU4NTZRQ05U?=
 =?utf-8?B?TGt1ODBPeWhDQlRycFFxNGlseEU5S3BTbG05bDUwQ2lkUXFQK1JFdm1VYnlH?=
 =?utf-8?Q?ojeVLuVz5qjXTlGLb0RDZxHO8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a7e161d-bb83-4809-e469-08db4bde98fc
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2023 13:59:22.6210
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5jpcLmeT/Fup18b+zNgI4QAXuqP19i9KSOsl2vGjvTBulMa2l/yXtI5KBn5/4JvfPRFGXoOhs9OFjE9qpyz/ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7447
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/3/2023 8:14 AM, Mathias Nyman wrote:
> On 25.4.2023 0.48, Mario Limonciello wrote:
>> Donghun reports that a notebook that has an AMD Ryzen 5700U but supports
>> S3 has problems with USB after resuming from suspend. The issue was
>> bisected down to commit d1658268e439 ("usb: pci-quirks: disable 
>> D3cold on
>> xhci suspend for s2idle on AMD Renoir").
>>
>> As this issue only happens on S3, narrow the broken D3cold quirk to only
>> run in s2idle.
>>
>> Fixes: d1658268e439 ("usb: pci-quirks: disable D3cold on xhci suspend 
>> for s2idle on AMD Renoir")
>> Reported-and-tested-by: Donghun Yoon <donghun.yoon@lge.com>
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>> v1->v2:
>>   * Guard against CONFIG_SUSPEND not being set
>
> Thanks,
> Checkpatch complains that it wants a link to the issue after a 
> "Reported-by:" tag.
>
> Is there any public report of this?
>
> Thanks
> Mathias
>
>
It was reported privately to me by Donghun, and they confirmed from 
private testing
that this change helps the issue.

I noticed that message from checkpatch too before I sent this up, but I 
figured it's better
to give Donghun attribution rather than drop the tag.


