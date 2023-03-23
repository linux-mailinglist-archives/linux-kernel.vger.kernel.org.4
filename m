Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24F466C6C66
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 16:38:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231350AbjCWPig (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 11:38:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjCWPie (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 11:38:34 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2059.outbound.protection.outlook.com [40.107.8.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C758F9EEF;
        Thu, 23 Mar 2023 08:38:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hidMWQ4saLVqc37PgryR0+0By4llT00agk+ikaXfHHtyk5gIcoSY+Tlg7YEqKVhHcVpM3ICxbnScmuF5yMkQIQnxGSZXu56y3tfwqdHovgQxsekLa/Po7v8PH7kLvi8N6lAvsuwCg4l2hAHYMIyKwmyzKY+r42YTRft2KVekE3BDVPBxXXL0xyhJ+jsVPM9xkS0wHOszt88NkAu4xDLWQ8/rYtcSxioxv/JAEJtt8nN0OmQuC023VErq+bx4zeFXZATpsdNpbZgi0Vmhl5OK/sIrXKBsdT8zGvmwnSi1gDBFc3EO27htfQRZUBaAMnLczsjIQGHsFmrOa4UL4lZ6wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iHnhj4ByIDmHtveoynOp27KSxFeYnI/BvL9blv3AJPY=;
 b=IDVpOkMt22IELVtve+WxNsoXT7TBjM65pP5KlAk9xL+dqelYMqNlwmVnh2OQVB1BMARQF5YQTYmhs1UCyCJPRRwrUaRD64iwZZPLFwzeqTq194iCbweIBqN5JSuDnmxKEUUY/Q/A+9tM4KQANyCfEM6P8X1SAJrjWHBpfBh6JGQBGP3oNyPQXFj1kOHY8na6RlpDVp3nxPXkG82m+sUvR6W1avyyfYlVl2wCBJbD8xNWJsBSGBGPzgXhNlKXIlLO9wQoX4SiisdIaQ4aq7QQ/uGNdoKshLfz3tPclpfpxW2R/wXqr0sGiqX7TUAwDP2YNB9VJaPgQNB67Jf6bRFX+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iHnhj4ByIDmHtveoynOp27KSxFeYnI/BvL9blv3AJPY=;
 b=XDFxrzQ6psp38O+gA7DjA8rIT9HIFIWToekbkL5vCOBkcfkSH7YHiEacVGVzycCpih2KH3xFMxlQr43VqIiqYImVhGOdZ17JQHlX9uxw3Wv3qU2e5BokscO1dQKMwEgCn9aTA9NqWgOYPUSgNaT/3MsWsadfAWI7MtWOczAvqxDzV2juzCo1weF4FXatWjXbqioVLY29BSOMsMXmsUZYlplpp+yENIMi/dj6bjvyZRjzlaXBoYn0Z2SCyUWoT20jhw7lV9DpOzGW9SpDnyi04i4UWHMRTsWaBNXL/VffBUZesD6pkyy8XenCTGIJLqPpg4aFfbJeZ5UKHwvY6ZsElQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB7104.eurprd04.prod.outlook.com (2603:10a6:800:126::9)
 by DU0PR04MB9636.eurprd04.prod.outlook.com (2603:10a6:10:320::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Thu, 23 Mar
 2023 15:38:28 +0000
Received: from VI1PR04MB7104.eurprd04.prod.outlook.com ([fe80::2ea:4a86:9ab7])
 by VI1PR04MB7104.eurprd04.prod.outlook.com ([fe80::2ea:4a86:9ab7%3]) with
 mapi id 15.20.6178.038; Thu, 23 Mar 2023 15:38:28 +0000
Message-ID: <3b3f6024-1ce2-9d8f-f5bf-e30993256fab@suse.com>
Date:   Thu, 23 Mar 2023 16:38:24 +0100
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
 <181feb34-c46d-cadb-ad20-46074a53b4c9@suse.com>
 <6677e2c6-b621-4c7e-9dd6-631a02ce5996@kili.mountain>
From:   Oliver Neukum <oneukum@suse.com>
In-Reply-To: <6677e2c6-b621-4c7e-9dd6-631a02ce5996@kili.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0047.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::18) To VI1PR04MB7104.eurprd04.prod.outlook.com
 (2603:10a6:800:126::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB7104:EE_|DU0PR04MB9636:EE_
X-MS-Office365-Filtering-Correlation-Id: f67ec1f7-1dc4-4108-229b-08db2bb4a609
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VRrCvUZiJE4FQIuS7a4zBqfeJ1Ua5zhiZJRp7pB0iPpJL61zsWdPjJjCn8c5jOOK/kdODGrg7WXeSfY4BoZrv5YFyN/SnuAYkYkio89Pt+zE+wn3noatYgU1yh2BZZnisT5bNP5ZxKUAQcURRB8LlL2xUfrEA+jSmMZx6avcb9z1NNtXrybV8JNjnW9eLymJIiYWRwkOYNTnM7LWZjnr0V+aYJfXh8fwSbNAjc3V3R0mGeJwuNNi2lJctueNNcJIA/pWXR2/OSsRPcm3yQ02BxWYH1sbDxQLogKuXSx1zYcet1SlpcNzR4PCopi68B3S4gJl9wH/1fDV/21rhwdGlmUxNIjAMO+iucby4DSinrTCnw9jxagPGuaPrT0zzK8BKIpL85VxZK0D1Tvw230+h9+SlF8fmX+YU7nK3kQ8CeNQeKe6T5C47qAi3Ir59RJoBcHlVbDl0QJu+mHhoPTqaJCdOIG1jviI7He2wzsEoWBFf/spwPqc/EGGv/TGP4tpYF0q96pn6ybrrZUN50s7/T/FUGzdiEX+uqNeyHL7wrV8JHuXIPjUb3KFzaIGUS/NruXE/HLHMam2Kl0ZsJjHldPT9XEHd8GFZoBUNO/C7qqXkUjm8wnNWFx7REcqiI2yPlP2ImdN/qKEbRdCr5cq30cTQOvg5CoZZs4tv8Dn9orNb/lWQO58Pl/BtPd1CUotk2I+3k7kyPtkY1OZ1I8tDaPSkWBjagPGyday8rkRWts=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB7104.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(136003)(396003)(39850400004)(366004)(376002)(451199018)(66556008)(66946007)(66476007)(8676002)(4326008)(110136005)(316002)(54906003)(5660300002)(41300700001)(53546011)(6512007)(6506007)(6666004)(8936002)(2616005)(186003)(478600001)(6486002)(31696002)(86362001)(558084003)(36756003)(38100700002)(2906002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MVNnQ0Fub08rQktIQ0tOaGNMR0g4d0pEb2hQbWNxRmJuaUM3b2x5MC9qaU1T?=
 =?utf-8?B?dWFuN3QvMm5vWU04UFRITzBrZjhTdjA5WTJYRHowT1NhRjlZcjVWNnBaVVVs?=
 =?utf-8?B?LzlwTGVwY3IyZ1hmMnFLSDZHZjkvQ0c5ZWVrRHBiUU43bmxmZnZ3VHRCNERz?=
 =?utf-8?B?bUVRa2dSdDFEdTB6OXVZWEk4VlNVem1yWWRrdVlTeHlXWFRLTXRXVkFFSXR1?=
 =?utf-8?B?MXhYU1dUbWZiUEVBTXJvTGdtMm1HcjJDZkpwMU9XakJpWVVKTElZMkkyMldv?=
 =?utf-8?B?RHJGclhsSVJCWDNRVGhEZURyQnRsVmNzbVdhRitHNDJNZ1pPSFhMRXlxRE1l?=
 =?utf-8?B?U0FQZXhwbHlsWmFxY29nWitaR1c0dXVSejhqdGRtR09hSEp2aGdYQkZIUXZr?=
 =?utf-8?B?c2ttbHBPdmdUcGJFd242ajlHWGxCZy8zWTkvTDhxNHlFMkJvSWQ5eDBEa3lv?=
 =?utf-8?B?Rkx5ZDVZVTZtVy9lajZqd1VXVEhSUTI3RFBQYzlibC9zNEs3TDJFQkhXYmtw?=
 =?utf-8?B?Qm5mVXI1ZlF3bCtHUVFiazJ4eXVZOW13bTZodWRmRFMzQW52cnJGTHJOTjRu?=
 =?utf-8?B?dDNWME8zQnZ3MURiUnhXTUo1WlN3SGcwam45Uzg1VTlRL1lGUnRCcWJoV2hQ?=
 =?utf-8?B?TXFLclVMWVlOdTJSMXVZYUthRGY4NGthdlZHQUEzQkg2OVBoMUw1VTFIQ3VX?=
 =?utf-8?B?c0M2b2xSY3BXc3ZScmZnZ0tobkdRNnRkTUZGc3BVNnlYdGhpNURYeCs3Y2NM?=
 =?utf-8?B?R2ExWkh6WlpwUmJLN21NZ1BDaFBBcE9uQ0VKYVF5QW9wemorMG5yRjc0dVN6?=
 =?utf-8?B?WVZGOVQzNEc0b0VrdTBoeEo0KzVmTlpxa3pIS1N4WGRTU252aTd5ME04MEdo?=
 =?utf-8?B?VEkzZnJOTGg1aitnSVRKalZ5VHF2dzg1UkpTcDNJTHZoSGc3R0FmZGRZUVdt?=
 =?utf-8?B?WHIxMFhPR1dyR0xlbnlVTS9icWUxWnQ1V3FHZUtnRFdMUDNSY2NrZTZNQ1Zs?=
 =?utf-8?B?VjZBU3R4aUhxRlRDa0hMN2NmMS9vNzFIekFKbkdlbThKQnRJNUVGR0ZnTEJC?=
 =?utf-8?B?NEdQL3VDNUdreU11VVY2Tm55bTVHbGNEYitlMGtURENpTmN2akx3V3NkVjY4?=
 =?utf-8?B?d0NBMkI1UzJWUGJrN21mcWowZzlqT0hwRFZVNG92cHlIUDNnK3lITnJSMDdY?=
 =?utf-8?B?Qzc2SlgwNnFYTmtWUTBINGw2RjZxazlrdTA4ZkdyMHZBN3JmZ2N5RUdha1M1?=
 =?utf-8?B?NWhQbThOQmJpUUFleHZaTmpHMU1TYitCNEE1b2dGaWc5bGpSRlFBK2FtQTZR?=
 =?utf-8?B?aUMvRUN1ems1dmxIbFowVkR6cThqZU4waGw5RUVMbGw1bFEzcnFiOVJSWlBY?=
 =?utf-8?B?eUJrYzJ3dFF6VHZPaGIzdEJZRDBqNTdCZjBkTHBjRVlTemIvem54WWkrZ1dB?=
 =?utf-8?B?dEpGMTlBM0Y0ekdtVTJXckxmRk1tZVNvYVYvS01OSFR1UW92RGdTaENXZVlv?=
 =?utf-8?B?NWhwNXVqQjFleFV3ZjJkYUYvNldiVXl3QU9PdWltbzhHSnpheHJzZy8xOFlk?=
 =?utf-8?B?My9PMDBVMU9Nbzk1K1dGVlZva0JBcDhsTytya0ZEQ2l2TjA1NkFsK0lESWtx?=
 =?utf-8?B?VDhNRC9SKzY4U3BjVkZYSHNtZUJrYWVBVGszd0JuSzNjbUNsSkV2K3E2QnlE?=
 =?utf-8?B?NXBhMVhyR1ZDc3d6dDFLcmRUNm9Va21XcTRCZlhham9JUEhRTnE2a2xtUC9j?=
 =?utf-8?B?N1FTMGRpZzR2dm8vY2NrOVJwSGh0TU1XSjV0VGZIT2twVUR0Y3ZlbXVJaDVE?=
 =?utf-8?B?OHVLNXU1T240TkQ1cW9mcmF5aUZwa2VCeUlFa0Y1ODY1SEJ6SlFWWWZWcEg2?=
 =?utf-8?B?TlFlamhNb0kzSkJFcU5rVHR2TzhkcjNLOEFBUjgrMm5ZZ1E5K2JqUHI3WFB2?=
 =?utf-8?B?c0dpeVVCSi9pbUJVZG0yTmpTeVJja05iMUtDd0xKQlBuSmpZVkR6Ym9wdXNl?=
 =?utf-8?B?OFA4K0k0Wk5Senk0S3Q1YmdaenNmRmpkWncySkcxNFVFdEp5LzNlME5hcjMz?=
 =?utf-8?B?ajU1VE1WTlFZU1k2MENPRHVINHVab0t6VDNNcG1WM0ZQRzVNZHpoOHQxSjNa?=
 =?utf-8?B?WDV0ZUk3cVp1b0h6dlBPaUpuY0JqK3lKVEtJSFZPVTBCeW5tT3puSk9LeEtO?=
 =?utf-8?Q?c+PnfZZVaJISyRtMoEroyiRL/CX5q6DEDsWiXOUfDi9e?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f67ec1f7-1dc4-4108-229b-08db2bb4a609
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB7104.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2023 15:38:28.4031
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cAODvQ8Csbo0bXELF6ZqbzEJMHoPVMvYHHaQ12Zn0OgZo4AFRwaYmCKnsbWhl1nrwvNkj2W4smW6E4CkEU06qQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9636
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 23.03.23 15:06, Dan Carpenter wrote:

>> irq != 0
> 
> You've reversed this if statement in your head.  It says that if
> platform_get_irq() returns zero, then return -EINVAL.
> 

Argh. You are right.

	Sorry
		Oliver
