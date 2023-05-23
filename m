Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C72470D0B4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 03:54:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232221AbjEWByk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 21:54:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjEWByf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 21:54:35 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2071.outbound.protection.outlook.com [40.107.100.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F9ACCD
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 18:54:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G0fzqbmkEJGZSm5JB0m8Y/A+sRw5JAMVFqmSkGgkQdHyz2sqSFHpgTCWjRXHhOEKYOgj0Yd6TDR0y0XfolX4H0g0+5FAvx8Xy4AQKK/mzQIgVv8qjaQ6VUrgELcEQ9iDpol2iGOxHMRJZQ+EV2KuKmvjtb/eZDaZvTuG6W3PgsQS/jw6wmBKet2abb/EUlroqF/JuSauqjbTb4FqT6VuO6S57v6TAm7TY5syfyVzXCqmRHFjNby7onkvMcJtU8+3LYzQ7amIUWHQsuM3sevmNxEFdgSZS+GNsDq9Ol0XsBO9fyAZCABLq6xTdlU9daSVQ4LEjUgrul3XFQHIknI2mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=deh8TyrQXB8e1FwfhBxlFFfoiEoKr1mkGFwaVFluKvw=;
 b=FAda0WAqPxdJnnYQ0aE9RcmJUlIgJscpiGpfsF/juJvm88KvzbaB5gnMYrBdrKT+6EC8nwp5Al5mqBJ7J6bVTW/ZxGNg2x0gj9ySk0JcuCaGOeJaImWud6WgEvxRXPmnTaNxlEVRzYTO5IssN9S1tS+N8uzd9+Pc9WoXiDhJjJG6cWTkVgstOEYAUwh1D5/khbxStrJHYjLftNYZq6RAqRiLALk2q5plfEpXKYGVY6EvFPLedmqx9RYk6Z/voZKs3cwxF8nfMVfWyO+YQ6lPjtt0HDZ98TYJNix6DynLNOfstv5nkKlChALJL1j/6OCSmsJK91r6/7wf/bcjRavVWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=deh8TyrQXB8e1FwfhBxlFFfoiEoKr1mkGFwaVFluKvw=;
 b=K8CozPh81Qs0VD05d3H4jk6RDJSSwWikcZTdXqYhRZg/FxgnOoJ+Nzw0B1ZIgUUuLjN8YS2+ef1r8PluU0Vc9xf354ojvw+5o3iCeczpuyJQOkTwVruWcmUQVV8nFa0s+1NZiXJEnRs5GnblNboyNmB+imoiRq+PzywTvcl0l29xGIp9pUtGUxNzfFbsstpRSXcb4JOKIShOLkF89rea73N9dALhw/Dta581tSTK6hZfXONLgCbQr25Y8MdYaJO71UZalv2n/wTvyGw2PNWmxf0UP4XkOKhC1UZcqmfPkqLT4LWBVBnQTyrkevfoFvXxnmp835Vjfuf5/x3oO25Q4g==
Received: from BN9PR03CA0197.namprd03.prod.outlook.com (2603:10b6:408:f9::22)
 by SA1PR12MB8743.namprd12.prod.outlook.com (2603:10b6:806:37c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Tue, 23 May
 2023 01:54:32 +0000
Received: from BN8NAM11FT114.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f9:cafe::58) by BN9PR03CA0197.outlook.office365.com
 (2603:10b6:408:f9::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28 via Frontend
 Transport; Tue, 23 May 2023 01:54:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT114.mail.protection.outlook.com (10.13.177.46) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6411.29 via Frontend Transport; Tue, 23 May 2023 01:54:32 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 22 May 2023
 18:54:29 -0700
Received: from [10.110.48.28] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Mon, 22 May
 2023 18:54:29 -0700
Message-ID: <1ced7f32-553e-2a5b-eec9-f794d7983d56@nvidia.com>
Date:   Mon, 22 May 2023 18:54:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: FOLL_LONGTERM vs FOLL_EPHEMERAL Re: [PATCH] tee: add
 FOLL_LONGTERM for CMA case when alloc shm
Content-Language: en-US
To:     David Hildenbrand <david@redhat.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        Christoph Hellwig <hch@infradead.org>
CC:     Xiaoming Ding <xiaoming.ding@mediatek.com>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        <op-tee@lists.trustedfirmware.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <fei.xu@mediatek.com>,
        <srv_heupstream@mediatek.com>, <linux-mm@kvack.org>
References: <20230517031856.19660-1-xiaoming.ding@mediatek.com>
 <ZGSDoVKKVqCkbaCB@infradead.org>
 <CAFA6WYO+AvnbuAdWyBAQ8HkLaOno7PXdsPb9SubxrGNvAm4UnQ@mail.gmail.com>
 <ZGSLiiK/JzD5KMd7@infradead.org>
 <CAFA6WYPOMwmrA3J84AHzoD2eAtNkpMxr754qHpc-j6XRkgFFvQ@mail.gmail.com>
 <ZGSgCZrg+RjAbGO1@infradead.org>
 <CAFA6WYO+EpiECFxdVgmd-Ey9jq1Ybt78WupK_bW5+oDcW-soVQ@mail.gmail.com>
 <d4773626-6cf0-c929-c775-a84ac41fd719@redhat.com>
 <ZGWnq/dAYELyKpTy@infradead.org>
 <CAFA6WYPgvifYcj_MT7BBcC0BtQDWXV0u+HY8qv0M9nNyiCgkow@mail.gmail.com>
 <8b898768-a3c0-198d-a70c-9aa96b7f4a29@redhat.com>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <8b898768-a3c0-198d-a70c-9aa96b7f4a29@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT114:EE_|SA1PR12MB8743:EE_
X-MS-Office365-Filtering-Correlation-Id: 66fdedb2-be1d-476b-0baf-08db5b30a70d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hUakEgwgV7AX0oF9bm6np3zY5ezv5hq6RUrm6wNHPD5R4EoXotYxHvfivzM/SOsPPEy+6WVXAT8QAvDJQWWrHKcjzbe2F1K2Rn9vOGUboL8q6DoqvaqW0M3dgJ2F+KeMHza0UUb3upiQFmCbWYDz8un/beJoxnyIWeRM1GIvnvPeaIignTPZvLnibjc40bzG24D06WjX7ygxBOCpiR0+YxO3IDGrev1xl479rKCKJS8QbUjzy3tp0qD709TXrH5+UYbbAEUEr6nplO/MbtpMWhu/lbXc0uPn3aqQkaI7xZegHEnpYCux1BjYgfvtp39XHOoSbyXNxTR1XJjqHjGwr1Sxtu6Vq3mUM5m53nZUg9/p4BnxoccnTYN4w6WOoI3lnZwKZHE3AVsaBsF/vo9kpR6uZ8dmLT2Ms7JoEyjbPrRgs155+BL0GfaxaeFLeknd0mxfUIbQXyMsx/cXn9uywNVvy2dFzu4NTeba4GzUdSBohIppCatYXiOEb2dFu+Nlg8P1RRQ2hFgqMmmoeXxdjVTWr4cBjvCY0sA6OVzS7tWmeNNUKXLw1KOI5YH7hGTERqV4NdJpUV+Vo1itYDAJnmZBMtUedC9dRZtBGe4ZEOakSPFi9BKqomGIixtlug4B8We75R4bCE2SkWXui88kxxlSBf7Im0MdtopUhC6Ukhd2rhSdhjLkrw7XIAZ44CkpwE8nhes039WNG+bJGr3bqYEBlApqQXSQVBS2YSsE2XNfmkzgrjd71aRSpA8fdho4HA86Sxml03mRoWfJ+CcgsQ==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(376002)(136003)(346002)(451199021)(46966006)(36840700001)(40470700004)(8936002)(8676002)(5660300002)(47076005)(7416002)(36860700001)(82310400005)(83380400001)(186003)(16526019)(53546011)(31696002)(86362001)(2616005)(26005)(356005)(336012)(82740400003)(426003)(7636003)(40460700003)(41300700001)(40480700001)(70206006)(70586007)(316002)(4326008)(36756003)(478600001)(110136005)(54906003)(16576012)(2906002)(31686004)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 01:54:32.0390
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66fdedb2-be1d-476b-0baf-08db5b30a70d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT114.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8743
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/18/23 06:56, David Hildenbrand wrote:
> On 18.05.23 08:08, Sumit Garg wrote:
>> On Thu, 18 May 2023 at 09:51, Christoph Hellwig <hch@infradead.org> wrote:
>>>
>>> On Wed, May 17, 2023 at 08:23:33PM +0200, David Hildenbrand wrote:
>>>> In general: if user space controls it -> possibly forever -> long-term. Even
>>>> if in most cases it's a short delay: there is no trusting on user space.
>>>>
>>>> For example, iouring fixed buffers keep pages pinned until user space
>>>> decides to unregistered the buffers -> long-term.
>>>>
>>>> Short-term is, for example, something like O_DIRECT where we pin -> DMA ->
>>>> unpin in essentially one operation.
>>>
>>> Btw, one thing that's been on my mind is that I think we got the
>>> polarity on FOLL_LONGTERM wrong.  Instead of opting into the long term
>>> behavior it really should be the default, with a FOLL_EPHEMERAL flag
>>> to opt out of it.  And every users of this flag is required to have
>>> a comment explaining the life time rules for the pin..

I see maybe 10 or 20 call sites today. So it is definitely feasible to add
documentation at each, explaining the why it wants a long term pin.

>>
>> It does look like a better approach to me given the very nature of
>> user space pages.
> 
> Yeah, there is a lot of historical baggage. For example, FOLL_GET should be inaccessible to kernel modules completely at one point, to be only used by selected core-mm pieces.

Yes. When I first mass-converted call sites from gup to pup, I just
preserved FOLL_GET behavior in order to keep from changing too much at
once. But I agree that that it would be nice to make FOLL_GET an
mm internal-only flag like FOLL_PIN.

> 
> Maybe we should even disallow passing in FOLL_LONGTERM as a flag and only provide functions like pin_user_pages() vs. pin_user_pages_longterm(). Then, discussions about conditional flag-setting are no more :)
> 
> ... or even use pin_user_pages_shortterm() vs. pin_user_pages() ... to make the default be longterm.
> 

Yes, it is true that having most gup flags be internal to mm does tend
to avoid some bugs. But it's also a lot of churn. I'm still on the fence
as to whether it's really a good move to do this for FOLL_LONGTERM or
not. But it's really easy to push me off of fences. :)

thanks,
-- 
John Hubbard
NVIDIA

