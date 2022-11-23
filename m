Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40A2D635731
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 10:41:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237978AbiKWJkb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 04:40:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238006AbiKWJjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 04:39:46 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2083.outbound.protection.outlook.com [40.107.22.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58FF9F1A
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 01:37:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AzVjYFI7anG0jg4L5qgC+pSMdtzcQstZSQdUI7YYd9CGUYAbFDKzmWFba/Kt4TX5RqECu8FZqJ4Q2txQFwUhNXO+Tjryf5p3Zu87eyagS4KStBVU9cK6vHxDua/xBR0v39682kpyDnLFIOgMtymsbCxIEbw+YzPch9t9fW7NtD1SSNDYS0WZO9X8sUB8xj4Mj0+ZKdubNsm6ukgd20ipn0toUKtyCHwoOvIbRZOJsegm2L4EDHFCjl7312rdBTAFW3GOuKzQA9E43fpViJiDK/+5xFJqTW9Mgyq0U7yIkGi0DPpQYh6lSEBjRrX/fkSvYT8p9zhBgEw7aaVJB3yslQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x5ty3CLTZ0hocY15yoErpTVc1qvUG4mLefS0k4LtJ8I=;
 b=Va84C3FqeJcUyNy5eMp469qv0bTS4KobtGM+aQjZ5Kv4lqkxWPWBj9rzm4PQ5JyNHWsaBMTsRzOnoAfNu4G/Rrxz/xfpMcJ9QfK1rAyAz8RBNV1rXE/Ee6FsSInNwWkUyiolVApjObBYPZaPFKDmsGuU7rjTLKdOaoMtiIEAx4qCEF/qjsA/mmwMJSQvnsv6pyC1I2Yrl9Nm0HiJm+x54MtXkJfi+7OQWWvUkcfvKmKxZdOygKqm/qCPlyB7TNUBh9AGpAnpudrmXgb2spmsaZO6862qay/z1YnMn5buJ3wfw1ZsjTtvn+XAGsG2AOgbEogyPJSzhXY0vA5tLs5VHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x5ty3CLTZ0hocY15yoErpTVc1qvUG4mLefS0k4LtJ8I=;
 b=uahANS8slMezmCHiQtiKlc2m32VyUchqus1OmguGOWpKd8VnVSIKPWYaPI+eS1dL1m1atWlAy2Ashb4gFwlU62wHPa4UKdi2m8Vt6sNbZ7Oxmnf1M+3DGaP5MD23ADyp+irHbEzexn4wntl29mn+Kszdq7X5g0iPXFv628dy7k/Sf+DSSDgOE3zUFJmf0e5oFN67mLvn1qjmd0oAlDkDH1LLGHc+dG6P318kGeaYxnGfilnRz5rWrtyWKcY1z9Hd/46VJx1RffqT3splrX3E3mZ5zk1IIPys1il3MwYHOy6RYQbd6R5ITYZDEAGnvldw9owUz0GrD1WrGOzJQQYj9w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VE1PR04MB6560.eurprd04.prod.outlook.com (2603:10a6:803:122::25)
 by AM9PR04MB8858.eurprd04.prod.outlook.com (2603:10a6:20b:409::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.11; Wed, 23 Nov
 2022 09:37:26 +0000
Received: from VE1PR04MB6560.eurprd04.prod.outlook.com
 ([fe80::4da2:ea8b:e71e:b8d8]) by VE1PR04MB6560.eurprd04.prod.outlook.com
 ([fe80::4da2:ea8b:e71e:b8d8%4]) with mapi id 15.20.5834.015; Wed, 23 Nov 2022
 09:37:25 +0000
Message-ID: <1a9a16d9-221e-6fa4-0ace-fd6e8afaaa4a@suse.com>
Date:   Wed, 23 Nov 2022 10:37:24 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 3/3] x86/xen: add a dummy trampoline for Xen PV guests
Content-Language: en-US
To:     Juergen Gross <jgross@suse.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        x86@kernel.org
References: <20221122163810.29752-1-jgross@suse.com>
 <20221122163810.29752-4-jgross@suse.com>
From:   Jan Beulich <jbeulich@suse.com>
In-Reply-To: <20221122163810.29752-4-jgross@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0145.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:95::8) To VE1PR04MB6560.eurprd04.prod.outlook.com
 (2603:10a6:803:122::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB6560:EE_|AM9PR04MB8858:EE_
X-MS-Office365-Filtering-Correlation-Id: d2cd3074-9759-44f8-342f-08dacd36547b
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /JEJ1A1tsKVMY1X+NXNp5Doav6TVzAqldaZuxe5i9Tf266fIsAK1T0623sI+Q2PneAhBZxUKxtuKptbX6egWoYac7XiZfrA5RZDxe/bhJ4lifHCQDNyS3mPB3PmxehG3rGsDvH4oTena9KkCxn7fCgxCTLbycA9m+FhrMgEZrJvhNw5118+eas/luA4Lko6ZnZzwxL6L+8tE7jQWwi325Axm1vW8N/5m4OQ3DPW1ycjl4WJ/zfPmOdVKzihLtKXcwkdXXZAf25cut9pVlK8g1E9ky3ER3Hr/BWTnxLzci3MqZj0TYkCHDrmP3R6VcYBfjt+VasOEgjp1FT2wds7EzyKz6n16iC6erC3XPVnXD12ePAXa+qtNpo63QmwrubaFDJ2H8izScliamBJB1e2Vyumyjp5RYK3j8oLRbi8kw20tVVfhM/Q9s3rMXOuRHxeYhA4urQcOpK6yV198mdR7X/lLVToUOeroXHyPZrN9CMe+P4Pv4Avz91hRJoGR5GwyNSVAqZM7kPSz2WnELj7Chzd1QN5c0MeB4LidqEKVuVlcCWSxogpKD4wu3fXFmY/ovvrXrC01xjKEuP9R7Fwo1XaQcQoohvfsdHjqncocBIY9QT8As32Pzbsmw8jX61qlGw2FLZcRD2WDW6VDOaiZ8qxPzW1t764P5229Ne8g4ljZ14X22zsH7tUPhqUIFLSLIFY7rfJuT6smD+a3Okm+d+6Q0OEkQVHklIQ0mOi/O5I=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6560.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(346002)(366004)(396003)(136003)(39860400002)(451199015)(8676002)(316002)(31696002)(86362001)(66946007)(66476007)(4326008)(36756003)(5660300002)(4744005)(6862004)(6512007)(41300700001)(8936002)(53546011)(186003)(478600001)(26005)(6506007)(6486002)(2616005)(37006003)(38100700002)(6636002)(66556008)(54906003)(31686004)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bFlPSzJlNEZFSDdsdnpZbnEwQWFLQXJncW04S2cwYVdkczlPeGpUZUx2QVVI?=
 =?utf-8?B?cThRZXNZSG9RdGpTMFFvRE05a29iOG1yanlpQ0Nud3F0aVloelpOelk1UkRo?=
 =?utf-8?B?aWxhSWsyUTdvc0IrcWQ0N3dxT29OL1JyTXFwODM3d3JLQTluV09FaTZ3WU1W?=
 =?utf-8?B?aFBYem9HTldkYkhQNUlCdUM3b21WS1FpOEYzWkpuem4xVitwT0IyNGlmcmg3?=
 =?utf-8?B?V1dNeHliNmlha0duMS9vaHlVQWNKNytJYXFLTDNMWXphdFhGWGF2ZkFpcVVN?=
 =?utf-8?B?T2dvTFUvTmFrMTdaOHBEd3dyYXNyWUpuTzBjUThtRU14MytjUzBQL1QwR0pm?=
 =?utf-8?B?dFFEdThoYVFhSGsrQnQxY0lsVUYzSHRDczlGeUtxYUdFam1lbjRBbDVDQmJH?=
 =?utf-8?B?d3o2Qk1zQ0czWVQxRkp1cG41bForTDVYRWc0enJwZXJwZXJycGJHOG1IK2wz?=
 =?utf-8?B?WnMrdmk4YnBIaXpiTkFubDFzNHhPZW1PeGdXZWw2N1djNDMvdVFScHRHZFZB?=
 =?utf-8?B?cWZETWJWRFdINUhpTlp6MXRqYzJCMm5Uc0hHRnJaWW5YcUp5UFloZFRzc3Bn?=
 =?utf-8?B?YnVGZ3NtQkt6VjhBUnlpYU9ES0ZpUlRXUDE0MS80bkZnREpXUnBpbW1IUmhU?=
 =?utf-8?B?UGFxTmRIK09QRG5TVzh3TXJxN1d1OFdjYmtITFZLTWNET3k0MUZEUnpqWFgv?=
 =?utf-8?B?ekxTd1g1eXNidHgwK050SlhMdHVDTTZ2RlljNDFWMU9LZzBrMlpSQ0R5QzA0?=
 =?utf-8?B?dE0wdTlwRmlDL2U3N09SSHRqTXpzUnUzWFRNN0xpRkdybldaY3ZyQjVRbVJx?=
 =?utf-8?B?N3pCa2ZkNjdvSTNLdElaaXNvNE90bmo3ejNDV2ZWc002azlFclhadkFVMHpX?=
 =?utf-8?B?Vms5OW9vbjBCQ2pNcFBwSDhqMnFRNTRJUmJPRWgyb05odUlpSFpJNmt5WFhG?=
 =?utf-8?B?V2pic1RPZzdTWGZId1pWNmtiT0RKTm04VGhnUU9NOWxXVUdwdThSK3Z1eXVL?=
 =?utf-8?B?T3FvOGtORmRvb0NBZTlGcGJ3dlBsTjRSYVRVUElkNE9VaWtKenhqS1lrVXBy?=
 =?utf-8?B?VWRtY21oRVY0UjkzTFBHRHV2aVYyOHltdUpzZndrQmxQZ0ZiS3Z0RHJtUXYz?=
 =?utf-8?B?YUNBNEFCRXhPeTZQcmFsdUloQkdkeUozTFJXTGhRZ1lmaG9aTFFmMXFoTTNB?=
 =?utf-8?B?eG5Bckk2ZWxab1RXb2ZNOUwvNlNVRzRGczkvNGR3cy9HNlZnMVpUN0VLbnZk?=
 =?utf-8?B?dVhkYUVOdGdzSVdzb1g2TFRaTHhaMnZRdHluTkhValRRWVBBOFJCWXNvMEtV?=
 =?utf-8?B?M29OS2tPWXRFc0F2eE9lc2NGRGJKRXhtaDd2TXZ0Q1lwellsd2RMUTFMK1U3?=
 =?utf-8?B?aDc5YnRYSUVtMnNLM3IzL2xJd0xmQzY4NVNoc3FEZnkwK3NqeWZvZ1dWaGt5?=
 =?utf-8?B?MStYK3ZZRisvbU9HYkxYQTVOTktrNkdSblRydXpDVmZiWGdXa3UwNlBBNDBX?=
 =?utf-8?B?bmorZ2VIeVdYQXpUL3Z1bk1oRjRnN0lydVZicmxIYlVjbEZVY1dja1VJdDM0?=
 =?utf-8?B?anNBVXIzNWZ2TGV5QUttZVVEek9INVk0eDBuelRyUXg5UFRQQVR2Ri82SFNn?=
 =?utf-8?B?dFVPck5sQ2dFODZzang2eDIxUGVTUTB3enVhMU4xY3VpMGU1Q1FUdENtYzlq?=
 =?utf-8?B?Y2F2dVdINy9zeTBCcW5DUnJYQzVVTk5XbldRdUFVZmd3WUxkcjJnWDRRZFNu?=
 =?utf-8?B?K1JmRjdpVDFEWDd5K0dhb0pyd0REYkNmYzNSaHViNE1pN1BxaXBscXBMelY4?=
 =?utf-8?B?ajJ2dzJPWW5RcWl2N3RENXJrSjVuR0p4aWNZN1JJQWdFbGRGVStKWng0dnVU?=
 =?utf-8?B?aWJ2dUQ4NjJSS1MyNmpxUGgvUHBEaVdtZ1lYRHpkaXJPRi8vOEVDR0ZzdjI1?=
 =?utf-8?B?UEVPaHE0N1hhWm44SHdVTjhWMlVRTkw4citkSnNOV1cvUThoOWNOa3pHVWJI?=
 =?utf-8?B?K25uYlVuOEpOWmxCQlppQk5mOHNIZ1JHcWdsQlN0OW1VbGEyNTlIU0Y2R1Rw?=
 =?utf-8?B?cUJ2RHNqY3BBdDhMbVYvNllFUUZQc1JubjYxZWZhYm5XYjNhY3h4ODduUDZC?=
 =?utf-8?Q?pI/+elSyCG1YQSjtxqbw/kmgV?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2cd3074-9759-44f8-342f-08dacd36547b
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6560.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2022 09:37:25.7509
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q94exXPPITLJRrX4O4d/1RterQG4+qNQSFHCJ6p4b1Q4hHSoRYg91a2B4awodEo1stBZjwTMODPtbJwCkdNvMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8858
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.11.2022 17:38, Juergen Gross wrote:
> @@ -137,12 +138,28 @@ static void __init xen_pv_init_platform(void)
>  	xen_init_time_ops();
>  }
>  
> +static struct real_mode_header xen_rm_header;
> +
> +static __initdata struct trampoline_ref xen_dummy_trampoline = {
> +	.blob = (unsigned char *)&xen_rm_header,
> +	.blob_end = (unsigned char *)&xen_rm_header,

With both pointing to the start of the struct, doesn't it suffice
for the above to be xen_rm_header[0]? At which point there'd be no
reason to wonder whether that struct could live in .init.data ...

Jan
