Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C5A35B977B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 11:32:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbiIOJcW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 05:32:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbiIOJcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 05:32:17 -0400
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-eopbgr20068.outbound.protection.outlook.com [40.107.2.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BA5296755
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 02:32:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JGCZgrFrYu5JZgnbkbuAl2nh97pPHWWy7PicsktV2zJHru2XPtbIXvOzPki2rj6NsibEF9xSTVnLbrPfh+/OEpXXZGW/jR5L3vgNEXOe1oPPSkfmCYM/VEZHeZyavLmEDCfz8jAmOlcHoPvzzO1d1SdznvGYxq5xnisZySZV9mLizNznbHdHU21yEWjjkQFqD8/k0/hOPFPdE2ltSyqKTegousdP8m9bkChPtrGjRy9jBXUvFaSyQzCuxtSok0fJHb3AqKrw+QI45GBe8vwr7X4KfdMkvPN/ZQndmxCXUWHtQKjbCctNtpCB9gSgclH3aY3KWd9a6cXSnAkWs7xkvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ILzV6Uq8lnNhepmaqhpUu1XImfYV1rqfGGKmBx+yiOg=;
 b=eBzJjUHDond59PIHPm/2w7+Fs3Fm3Ya9jm7qmTzFOLF18Td+FPMgh9PnErHdki0meJ8GiJ+0eKbMQL4lAgB/a/XeHuyG1+9APRBKef1VRlCHXm0JbSGQOHh2jVHop5/hHrtfaNvVDWdxDuunhYtbLjLcwOhHQgkPkz3j9LRTiFmYybfyUHKATa0MGA7oOz/GVlyigjMYNJg07tgK4b6rCFMHAhZyvgxknRAk67r6NHdUSubGS4xDMDkp1147xSH785SXn9qEeMxe2BMjwwSoUt60OJXLGvZzb7q6okU1tiud2uwz8JHrtdbw7+YIpJJ7/XR8TXhjzVpJHJ5jcv3ylw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ILzV6Uq8lnNhepmaqhpUu1XImfYV1rqfGGKmBx+yiOg=;
 b=a3RizUP1OqH2FixccheVn2jZO9Ghrtbu8Kx4ULOgdvW6vKLicX4iv/aJdhz+uIVxMl2K5iNT/hUQZweZ1WHXLDZpUu4e2aq8s1AaL6Pzf2j9u5mfPpotuWUlvCJCesJYasSMbHLA7XfkE9gHB9G/1ipknZIF38Qk6tvdJ8gGpPet+PECoJ1n6lnH79+6XaEYi7Ld4MU2p0Kp7NgjvbfOSXTRhBelZK2am8adxbLAcS2jMJnxC8wPEAFqUx3Zl9H34mShuUoX4Xll2G+4Z6hpmRS6khUrbxsqRXflOBDcu9A9ceg/JEvHNYZcsnMJXPw43T554UGyLodLbvCpjkK7ig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VE1PR04MB6560.eurprd04.prod.outlook.com (2603:10a6:803:122::25)
 by PA4PR04MB7632.eurprd04.prod.outlook.com (2603:10a6:102:e8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Thu, 15 Sep
 2022 09:32:11 +0000
Received: from VE1PR04MB6560.eurprd04.prod.outlook.com
 ([fe80::59bc:901a:98a7:76d4]) by VE1PR04MB6560.eurprd04.prod.outlook.com
 ([fe80::59bc:901a:98a7:76d4%5]) with mapi id 15.20.5632.015; Thu, 15 Sep 2022
 09:32:11 +0000
Message-ID: <8137166b-a4c2-aa26-84f9-7b9b2a7e028e@suse.com>
Date:   Thu, 15 Sep 2022 11:32:10 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] xen/privcmd: remove privcmd_ioctl_mmap()
Content-Language: en-US
To:     Juergen Gross <jgross@suse.com>
Cc:     Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
References: <20220915083944.10097-1-jgross@suse.com>
From:   Jan Beulich <jbeulich@suse.com>
In-Reply-To: <20220915083944.10097-1-jgross@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0096.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::8) To VE1PR04MB6560.eurprd04.prod.outlook.com
 (2603:10a6:803:122::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB6560:EE_|PA4PR04MB7632:EE_
X-MS-Office365-Filtering-Correlation-Id: 941c63d3-4f12-4a41-f89d-08da96fd2acc
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jbs9mMPTPPAylaDMDdWrARrx4LvEZzfVf5R2vhB5FNr6MES6C1DQNebwezZmvOPkXn5L6dvzz4BTsZYKmzjCwGThyhbfrxfL4JsPk2996PelpplspvwdRMH0Cj2psKSxHYsyUc5xwbynJlKIPEQdd96XOMnD5SaV4a+A4q0WxJ0gybW/MhsgiFI7QtJ/IlZIPf8XL+dD6obAu9vEpSNHXOBsTfMKBPvljjyw0Npjf06nDfOiYsdpcPzlHa/3UwchYJby1E0cWV48iXBH9/iy1x8Q6mu7Q95vhnc+KeXnPckIr/xWpyTqydok8cka+KPJZH/tUbgF+7V3TWLMa2vVVVdbF3K4fj1ZPJ95JfhhXxkNnCdcA0FXCyo/jz+yhwv39y6DleeIi3LtixbkC2rhSSOxdFNAK9nAnMaN04NBSZ5xa89wYdnrWdTXe7rIORFVT2e0oAcC23Ka4EWreINBeUdy6NTSn5kwJ+XEFgfBwpfo21HGnzfVO9ev73gdYEznN7wRW6VGIwijLTAFH1IIyKAVH4/6U1dE4lB55RunUFH3Oxqjb+NjJhjMYjZyA7o38EcFsyun4J4ZKMtqHmmVwkzj0xhSayETVfhz1KFDlZjQ0q1+fYww8Kl28O5SKHrUuWJ3SFAqFE/PAVs4QUAmq7sPRGd5s6UyY8w4rQdDjybbVt49Jh8N+KFeOHPT5SQB+US7WoERV468Wcl48o4L8LbP2JA1ehAjyv4RdzTGnRyBJglWlWCPAIEGFRKVRDb0YmcUkZMs7dfnIi4jfK5oZm78iWKS5yZ4iZFMfu1o0bo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6560.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(136003)(396003)(39860400002)(376002)(366004)(451199015)(66946007)(26005)(41300700001)(478600001)(4326008)(53546011)(6636002)(36756003)(2906002)(31696002)(31686004)(186003)(54906003)(6512007)(6506007)(2616005)(66476007)(6862004)(6486002)(8676002)(37006003)(8936002)(316002)(66556008)(5660300002)(4744005)(38100700002)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZGV0ZjhvMDloV2ZFUWlRUGtVYWNqbmpxRk9TN3BIUzRqSDE3NnFrbWJDQS9Q?=
 =?utf-8?B?ZEt5b0hIOFE2ME5lbDRDbGFtQis1dWJKNzh3K0NzcTFHUUpNQzZLZ3h6WVlS?=
 =?utf-8?B?aVNIZDJxa0hiN2g4WmlEdkVpcXNLbVkzeHpSbDkrRUYxeWQzUjVvaEJvSHZJ?=
 =?utf-8?B?V20wS0xvVEsvWFd2YkRoRm5ybUJTTUJnVzlyMWptY1FlRjluRGt4ZTNWakxk?=
 =?utf-8?B?MGx4dXJ2eEJBck9hWlAxUXkrVUh6NDFIbUJqMnA1ZERyQzlGMDQwM3hGUkF2?=
 =?utf-8?B?OUJwcU15QmdON2w5cThqVy9Qai9EZXFtYXZBcTEvU0I1TTkzNVJEaGRiRy9k?=
 =?utf-8?B?WENhUWJUWGZJQXBFNDI4eWc1cFptTW5uTzNhSkpMbCtDRkl6SU9WK01TVUtI?=
 =?utf-8?B?aXNteCs3VHdwN3dVSmdOZTlQNFk4bTlPL0czRVZwZ2pMeGU4bU5uUDJ0TUFI?=
 =?utf-8?B?dzJSRW1UaHdIV2pHajAvS0E0NjV0Tk1TdFhzTE9FRG9pMmczQkFIMk53VWNK?=
 =?utf-8?B?RTBxT2JJQ0dsekRWazV5d21Db1E0cFMvL2ZOWVlHSzFDcnVYSDVqd2p3UXBy?=
 =?utf-8?B?clZXditsajRaUW5kOU50TG0rcGRWREh1T2tEdFdoNG5lSG01L0w1VmR2a2hs?=
 =?utf-8?B?NnF6VHBuUU12U3loYjlHTkFPcjc0c3hGcDk4a1dXa3FRWXNFMVdOL0UyU3JZ?=
 =?utf-8?B?SktuQWFYSHNQZEZ2VTdhTnJ4UUg5bS9KeUhKYUpnSEkwTisvL2s5QVBwS2pk?=
 =?utf-8?B?Y25iK0VweFVUem9FYlZiOGJuZTlIN09ldTNRRDByUnFaRitKYk1ub2VEV3ll?=
 =?utf-8?B?WVQ5V0ZYMTExRmR4NENzS2ExVkFjakN1MURtOWVEZjUxT3VkcXh2S28xdUVQ?=
 =?utf-8?B?Qjk1Y0pOS0YralhydFozQ3RwWm1mTlRoNkhXamhSZmR5bzlpUE40RDlHRnh2?=
 =?utf-8?B?R2FWcHZiRmRsRHhBTElmU3pwQk9GbHF6SmRnWVFRTTlwNnh4Umd3YjBMMjlm?=
 =?utf-8?B?ek1nNkVFV2NIQ1RaTVZwSFd6ZWdxQ2c3aFV5SWZKSmtyUGNwZFZJbFo3VUVX?=
 =?utf-8?B?QzlPWTBQbHNTbG5JNHgra3F3OHU1QldvUFIxQnJnVVFJQmRRWUI2bHp0aFVy?=
 =?utf-8?B?Z3Nnc0M4cDE5K1JlSlg5WFR5OWIyK0hraDNwT2dGdkNVVlBJZWYrbXhTVy9s?=
 =?utf-8?B?MFNmSmFzMm41N2NuZWM4bE5BbFFCN3NDYVUzdE5BaCtWSHRQaHR3MStMM0xT?=
 =?utf-8?B?N2U3R29DM2I0clJ4SEUvekFyVmNYTzJXeGxlL0ZjcXc1dWVmTnB3RVM0MUw4?=
 =?utf-8?B?dnQ5bzdRVlNqa2UxdmZvWmRaZE9GTWtkR2lWaVh4b3A5UmtmRXZ1ZmNvTjRx?=
 =?utf-8?B?V0U4blF0NnFVSEl6c1Y0eTFQRTB5aUN0aWFtMndWei9RSDI0akQ2SUt4a1pG?=
 =?utf-8?B?MWZwYm9TOHltdG9URHc3TnRFSjVjMm83aFhKUGJSMFRBbG5MYTJnTGdYbXB5?=
 =?utf-8?B?K21vaHFYbmxPWWRwT3c3YjNyYVFhNW91TjgrelRlaHM1NWNBNFNtTitrWlky?=
 =?utf-8?B?eXFvSWhBVURwMDVDU2QySnJyOGFtU25oekRCMHN0M2dIclp1eEUvKzhrRjNB?=
 =?utf-8?B?R3QzRWdxSzFod1JmZmVnTzFyWC9SUFNCNHR4OWhHUys4dFZUVUpIVXh5TXBP?=
 =?utf-8?B?MC9ISDRFckZIaCtMOWFOYlMzZWVnNEtINzRrdFdEaUNsTXNHaCtvWXFnMldG?=
 =?utf-8?B?aHZLMEVGazVyMVRZdjJ1UUpmb0dwRkl3RlFZNHlZdEJMSktYMzd6Yy9WRzFC?=
 =?utf-8?B?YnJ1bXZFRStsTFpqMlM0a0ZQQTFmdkNjU0dSN0VBcTNXNlllVmpvcFB4RURj?=
 =?utf-8?B?eUVrZkJwbzNlbEozSnNrOElJYTgwcUs3aXpOVitpZzN3cDY1bitQenltbVBI?=
 =?utf-8?B?eWZuaytoaENqd1R3SzQxWXZwZTJWajhFWnRsaFpCaXZ2aWUvZ00wc0hyYVR4?=
 =?utf-8?B?dWx4T3dqdlROckdlTlY1Z3BIakZ4aE1xYm1DWHdVZjFrN1EyZW5QeDhjakh4?=
 =?utf-8?B?UC9nS3Q3RlUwZWxkRFA5Tzk0eU1IR29RVzA3L0IvNUl6VmFBUTU1QmVzR2lx?=
 =?utf-8?Q?CPdy9cG5S76kbnsJ07fGjNaKe?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 941c63d3-4f12-4a41-f89d-08da96fd2acc
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6560.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2022 09:32:11.7970
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: osYeF35OKz7dyHVIpdvD5OmAdoDc+eBzkTG+Akr2zDi4eJnZZNwOo0FvnObVv0iZIf+RZ+EhukstRG48YClgsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7632
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.09.2022 10:39, Juergen Gross wrote:
> The IOCTL_PRIVCMD_MMAP isn't in use by Xen since at least Xen 4.0.
> 
> Remove it from the privcmd driver.
> 
> Signed-off-by: Juergen Gross <jgross@suse.com>

Can we reasonably remove an IOCTL, without being entirely certain that
no users exist outside of xen.git? Even if so, shouldn't there be a
staged deprecation process?

Jan
