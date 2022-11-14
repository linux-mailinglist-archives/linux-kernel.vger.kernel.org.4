Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D38D5627B1B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 11:55:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235836AbiKNKzR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 05:55:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbiKNKzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 05:55:14 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2070.outbound.protection.outlook.com [40.107.21.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FE80A186
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 02:55:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TEt/uPzLIKdkVBat7FUApZ/jbril+zNw9+1fLw7PpZU5GZ+WCEo4CTLnxoXouHlkk5cqHgdLFxr0aU9uZPn1BDrHClF3CiCqyvODDd5SUUvFG69gVFuULvjb/KV8mlpMCEMlfMFmK3Re3jcZ4zcjnojqiyCf/+7ftkdaV9QLCL/uhJrvT7V07OdAZnsHlTvpZbGdqCn5Wg58rOC08nvLUJcgmxOAvA/HJ/UYBlTc+TRrwfeTbRQJx2iahLA61us9//aLrlTiiXBbY0jPnouGaSbs6R57Ln+YsU5IEvUyJSDwfu6DtIUMh6MgXCfzVWlXTCSj9OygIm/LbYZh/jM/XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A+l3sX5ll1BOtoYQOTgBV4AShXzgXANvr9yYhrIbgTY=;
 b=k4xx7YJRzvdxXxU9P8PuN+swvSVBdy+JPen0YWxJtDDyDbmKgB2o0nxj5WJUlAYhW4plLlisJm9l8CBlyE+Ii9ae+s7Vifc5l3tVAIS7DgL2EywF2FDzxIFntatlzz+s88qU9xizLznkT8xVUG4maMP30h2GPR0asfc6w+vGtH8IiVBVWh9J+0b7PXPqirp6EufWi85bO9ZBI11op7txl4qk7sdkdKKexPpsu8agpQhcnGtaGW6QSVFLzzvMwyfZG9wtvc8SselSz8bNOpbeHFzs+GJJn+bs4wJjyDTPjYSmQenvFRvpHYJT8D0/B9vkZVPaYY7dad26gM9Xx7MklQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A+l3sX5ll1BOtoYQOTgBV4AShXzgXANvr9yYhrIbgTY=;
 b=RncC5eOU5rVg6FlKLU/X5QxJBN77dhBEr+/whRltqPn6F2FQoXNb8cfxkHEVmrTCq3u1t9pX1WCDHRII2e4r94QaKEpmgt2nDlglFdO7cqFjNSzxXPWXOFWITqLGY7iDF0gt9As5trvf3vbret1Ucogsd9Z5gDTO3e24HrJolQLbnWoyYK8Farhj7+bASdsY1UNpSahGJSI5g0jsXqNrXZeI0zfKm7kL7F9a4bMDKNd3MwScFjbTevXJ5ug2JlnOE0eUkICj3N2BALG/ZgmLWZbVicy9P6/X8IvBzeDozwifg2EKR7CiJsx4SC8La0TMoFoh6lA90ZcTuQb5ovnHKQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AM6PR04MB6551.eurprd04.prod.outlook.com (2603:10a6:20b:fa::20)
 by AS1PR04MB9309.eurprd04.prod.outlook.com (2603:10a6:20b:4df::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.16; Mon, 14 Nov
 2022 10:55:11 +0000
Received: from AM6PR04MB6551.eurprd04.prod.outlook.com
 ([fe80::48df:9a8c:c706:36b5]) by AM6PR04MB6551.eurprd04.prod.outlook.com
 ([fe80::48df:9a8c:c706:36b5%3]) with mapi id 15.20.5813.017; Mon, 14 Nov 2022
 10:55:10 +0000
Message-ID: <f5af4537-0be0-4e2e-bbb2-4c3af8810060@suse.com>
Date:   Mon, 14 Nov 2022 11:55:09 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] xen-pciback: Allow setting PCI_MSIX_FLAGS_MASKALL too
Content-Language: en-US
To:     =?UTF-8?Q?Marek_Marczykowski-G=c3=b3recki?= 
        <marmarek@invisiblethingslab.com>
Cc:     Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        "moderated list:XEN HYPERVISOR INTERFACE" 
        <xen-devel@lists.xenproject.org>, linux-kernel@vger.kernel.org
References: <20221114103110.1519413-1-marmarek@invisiblethingslab.com>
From:   Jan Beulich <jbeulich@suse.com>
In-Reply-To: <20221114103110.1519413-1-marmarek@invisiblethingslab.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM5PR0202CA0013.eurprd02.prod.outlook.com
 (2603:10a6:203:69::23) To AM6PR04MB6551.eurprd04.prod.outlook.com
 (2603:10a6:20b:fa::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB6551:EE_|AS1PR04MB9309:EE_
X-MS-Office365-Filtering-Correlation-Id: 3502c171-6bf9-42af-43e0-08dac62eb36d
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Nlr1Wx8GBsawTTmTW9iADzzBoyZiw8ScUb3iyGFbSmPEJBZcBbFrkaD2ZskdnqTB1MWk/L/EUowDezaZ08w7lQfyPAGnTR97YJi0ZRtyXICRlpNa/ZheccA1AmxdP84GZ+ge9Rumo79AN1fbV9ziGuboR5++Jld+TSIhj3OZYVrAGpZY7qD+LbsIgG8jYWaCxc6Ot7OJAbZ7jL1RVHxac3SpdD/RFz8FdmM8K4gE4GMGXKu8IB4ReFX68/rdEQko0xq77dOpWEkIvqyPErDmN8tvzc/w4G+Gs3E4Brp/LLK9BVeXemUkn8bOGHKNSksYJ1dbfCUj28nrJmqpq4v5LTbSGwYZDbbnFmtpzoqohA01IAq5NdczpxQELez/ZfwlmMZcMfd+ZBwJz/mmwbhKq64lWYnURxLnXQ60UQlC/yILV5CFe2PQv+nOVkiBcxPzXxQP98Ota1ptXL+LeBCfjKozeDkvZYZwGrDtG2EFYew224gPXTZgFpPp/xcrC40iBpe1bPM9dRQ2Lu8h+3t4krVGF6mHhXfueFU5ZU/di8tOKggbbKFjkC7sJ7w9s/gpDQK94l6NgTJPkAsMV6az1HhOyw5xTt9SQNzMyzj2b3XqiqE91WC4FbBiMAo5jOy/Vi+3n6VvuiIJaPzlFydgvEjMfjnW1vqKXB9WE4xhagVXNzGh11TIXQF4HSPY8R42XkqTJmQiaU5RASFBx5WTWWNHF13HcnAkUa86Y6TfN7b55/mWrD1vpDJWxyBxREWjY2DtotStu9REcOA9sujZ/paarY1fPBYp0p6EnNtm3nk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6551.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(366004)(39860400002)(396003)(136003)(346002)(451199015)(36756003)(2616005)(186003)(83380400001)(31696002)(86362001)(6486002)(478600001)(6512007)(6506007)(53546011)(38100700002)(41300700001)(26005)(5660300002)(2906002)(31686004)(4326008)(66556008)(66476007)(8676002)(66946007)(8936002)(4744005)(54906003)(316002)(6916009)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Rk4xMmYxaENEU3p6MDVJMnN6d2ZQRm5Fb2ZhTUFCdDhidm92OS95ZG9BVVVH?=
 =?utf-8?B?V2E0ck1UditzdEhwY2JHSlphMDZUSGhDVmllTG5nankwQTVQZzQreHZ2V0F0?=
 =?utf-8?B?ek9zMVg3OWE2VitNdFBDVnBxWlNSTjRWUGxwUGNUYzY5TEZUNkJQUjlkclFJ?=
 =?utf-8?B?WkloZkpOV2JxTXlyV21KYUYxU3M1SnluVkpqN3AzL1EzbHUrVW56Mk5wdlF0?=
 =?utf-8?B?UW0zTStJdm1wOGUyd3krY2hUV29Ca0xhNFk0VW8zWEhCQ0pqRGZrOFlkbWVP?=
 =?utf-8?B?NkgrRldiMnNkN0J4ZGFEYmFoQk9wcXNWSlowQ0VTOHNmT3RNbnEvN3Y0UVJJ?=
 =?utf-8?B?SVZTUEtQVTZHK29HQlFFN2hoL1hVc3dOVDRqclRZdmovREtYeTJpdmVGYkxI?=
 =?utf-8?B?V3hTOUk1UTRQeVJZVCtSM0dZb1NXSjY3eDdZQ01oUHFQdXlabWZVMXo0RGJP?=
 =?utf-8?B?S2F4bU0waVpLT3lhM1hBVEVYRUFTUFlRNlBwWFJGRVNYclJHMmhpOTFydzJW?=
 =?utf-8?B?TGJ2SEVqOHEraWlNWEZMaWNQSjBrNWw0ZE4raWlOb1lFS1kvTCtjTlByTDJl?=
 =?utf-8?B?YVFKQTUzTlBRNE5xdm9tNjdVUVg3Q2hmWkF2UmNBMUwxZ0xEWEpWbVExSVpv?=
 =?utf-8?B?eTRqSjZTOUF5ditBdjNOazYxb2x3VlZaclpNaUt4Y0V3Qk9zUE5HRkRTcGly?=
 =?utf-8?B?RUt6N2JPNlNBZUEzU1cwOFQ5ZGVPSWRpSFRBRE9QOW9Id3M3SXVnV1RoZDcz?=
 =?utf-8?B?V3NsMG1ZN2pScHQ1RjBUbWlKMk45bFY3Z3VzRTQ4WW9oc3QxSENpWE4vVnpk?=
 =?utf-8?B?UmFTbXE1TG9BaTBYV292SmkzMjVwNS9KUnMvbkJYZFJxZG4vcWkzMzZ4QmUz?=
 =?utf-8?B?ZmRKUWsrSkhGdVdZM3Y2TXRTQ00rUnNHUUx5dTJhbDRhOSt0YXl3YitsSlVq?=
 =?utf-8?B?VXlUUFM1cmNRR3luQmR3S0hrU09TUXpOYmRyTzVJWTErSm5hY3pFYXNOV1o4?=
 =?utf-8?B?VERQNGNwY3hPa2w4aDg3OUJsR3o0MWdMRTlPR0VFQng3S1ZoRG91a1pEWTZG?=
 =?utf-8?B?L3NYRUVhZWpJbnBMMnNucm10MFp0S0xpaUdqcGJJZXRvY3RTdU1ZMVgvOWhU?=
 =?utf-8?B?ZmdaZStLSmJBUDk1TXhXeGlYUFpERFZyUjFpcjVONk1Od2FJSzA0RXo4bnFi?=
 =?utf-8?B?My9ia1k0S2VOdWZ5OWxmWjZ2dEVzb3RqWHp3ZXZIRFFZZFQ0TmsrTTZONG11?=
 =?utf-8?B?clpsSEdubUtVaHY4Vk13SzlXVFV5cDVsSDVuL2RIMGIvUXlqVzZWMWJiVHRX?=
 =?utf-8?B?NTRLNU5WL0o3TmMyV3p2MVQ0WlhWbW5QZmhVcW81UWFyOTNQSWdyYXBEZ1cr?=
 =?utf-8?B?Sk5qZWxLK25Ib05Qc3U4R0VtMjcyajdybTIzZWRwRHN0QzRnNnE1cVFRTnpo?=
 =?utf-8?B?Z3g4N2MvREgzUVJJL0xQd085OFZlNDVBbzFRMm9UL1RkYUM1dTlkblRVRjFU?=
 =?utf-8?B?bWVVdktVeEkrSnpSb3dmbStDdnVtRjJIQldZT3AzZUo3MS9tbmUzMEUwcmxp?=
 =?utf-8?B?VlEzUk5rUCt0OHF5SlV4L1FiRVpQQ3J5djNmUXpCNU9PSGZxcEpTdWhEREtr?=
 =?utf-8?B?YklzcnhySkw1cmoyZjNPZ0hGQ28wa3RIeVMyQ3RmVkhuMm5uUTBRZEpRSGJM?=
 =?utf-8?B?b3ZBRE5OOG56TzlRcGQ1ajY4NFk4VVRENEFGek5wTmwyc1BFWnNjQVFGNGRl?=
 =?utf-8?B?MjFWOGQxSXcxL2dNYk1mQ0lhbjNhbmlVNTZySk4xSnFaQjhkRnM4K2JiVnNM?=
 =?utf-8?B?TVZsaHBDa3ZLcE5oZUNWbi9HVlVQWEZEOXpTMFM5c1JEUmx4Qm14OERUN2VE?=
 =?utf-8?B?SmJOUm1WTFNFVzFZbkJNcDNJdmt3dnVJeEtxa2dRK1NocTNZSExQNjM1dHY1?=
 =?utf-8?B?cWd5S3FqZnBWVEdnWnlSby9BeUY0cFNqODZockFrT0UxbHJXK0l3anQwZ2p2?=
 =?utf-8?B?RS9OS3gzZUNST3RkRFZzbUN5MmliYlN6bUpHb0htTzljN0FhWkNNM3pQbmxQ?=
 =?utf-8?B?cnV6MHlOTlR3VWpmcEk2WUJncUY2RUtkNUVPNTJiaFd0NUEwOXNEdDhGRExl?=
 =?utf-8?Q?0QX8+eWMgygfodDIQ9aw8DTw5?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3502c171-6bf9-42af-43e0-08dac62eb36d
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6551.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2022 10:55:10.9142
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mvDG+OiCzV7sjqgVkKx0dSOwnK96JyHcif9fHryrLDyqX0k5lcL2deqgeTRjex47fq/9FGBpFihSM0syrkxyXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9309
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.11.2022 11:31, Marek Marczykowski-Górecki wrote:
> When Xen domain configures MSI-X, the usual approach is to enable MSI-X
> together with masking all of them via the config space, then fill the
> table and only then clear PCI_MSIX_FLAGS_MASKALL. Allow doing this via
> QEMU running in a stub domain.
> 
> Previously, when changing PCI_MSIX_FLAGS_MASKALL was not allowed, the
> whole write was aborted, preventing change to the PCI_MSIX_FLAGS_ENABLE
> bit too.
> 
> Note the Xen hypervisor intercepts this write anyway, and may keep the
> PCI_MSIX_FLAGS_MASKALL bit set if it wishes to. It will store the
> guest-requested state and will apply it eventually.
> 
> Signed-off-by: Marek Marczykowski-Górecki <marmarek@invisiblethingslab.com>

Reviewed-by: Jan Beulich <jbeulich@suse.com>


