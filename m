Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7666E64CEC8
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 18:17:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237963AbiLNRRc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 12:17:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237720AbiLNRR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 12:17:26 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2083.outbound.protection.outlook.com [40.107.244.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9DF55F90;
        Wed, 14 Dec 2022 09:17:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hZSTG55jX+lHm7W6civtz8CBAcGffLbttFdGPAlDIEdK3Pmx7futKK4jXAyDILpoPxbR9p+PZGcoyTLewSlnydEVG17nX/FxXzY0JVONNXFN4VMyiCXFBsyeI4MT6qDfexdisNJsePBSbSXE8F3yf/jwMb0TAtra7kPC91bb+56fntm4C8nmPEJdhf9XrHzMMEWK9C3lrsKYkeHJsXz1zayLrXLCQV4CXeozEIY8M7rUzduqshkZecftmwmyfMR8mXMoodoOnHL1oqO3OV7k7CC6AiBavj1/MMdTs3w9I1zCAcpDf7e3nbRuIjyaR6kKJ0ydnhYXowUTNrLF3tfqCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o7XQw9DoLQ2NcK3wDVLQZo/rR59aRWV6xlpHzmX5hKg=;
 b=jl3folp6QdR1xnP2t87Lvudk2wHECkAMRz0XX5eN3YG0wN4dP9JYvu4OSykT3WZA1NWSHH5jWOrVxFkW9Vj+9xH3M1kdi3zWXorAGbUMo3GG6rfbIsrO4K/vl/c6WH4exPVL9/n+6Xrd0kLi2ckjy+zhaL5o6DSeGVA59SzWzOxvM1Bxdaf+oPjQiVWWNJCvwRqVN5tHTK64PMwBtKvzF2anE7bp1+ncpdZcbBPuNpMaeajva62XMT1Dq/eVoq6d5Jpk/8asaqDfCp4g8LNstbYEYVq4GD3YZyrAfQskyxnlANt3UT58OR2MD28fOgFF5Zk7G8uEv6bT+7hBXkZEkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o7XQw9DoLQ2NcK3wDVLQZo/rR59aRWV6xlpHzmX5hKg=;
 b=nkdlv4Mf6OWndyNkJlRFZwsYwx+HZUc+CdkIGcSaIqJGkHZGa9GGwCRQyiTPwYytfIKs2QOjwsMKujxjDSu3izFYHnyUTR2tqwAt4+yvpmFky6tklluC9wvkkJJHswPyH5XULDLUXtZmeLn5w8DOsfFA7eu9ZT0ONqqqBVSWZDU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA3PR12MB8021.namprd12.prod.outlook.com (2603:10b6:806:305::16)
 by CH3PR12MB7764.namprd12.prod.outlook.com (2603:10b6:610:14e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.11; Wed, 14 Dec
 2022 17:17:20 +0000
Received: from SA3PR12MB8021.namprd12.prod.outlook.com
 ([fe80::1948:f95c:ea95:8696]) by SA3PR12MB8021.namprd12.prod.outlook.com
 ([fe80::1948:f95c:ea95:8696%9]) with mapi id 15.20.5924.011; Wed, 14 Dec 2022
 17:17:19 +0000
Message-ID: <f996e5a4-13c3-a195-ccc8-73e09c485112@amd.com>
Date:   Wed, 14 Dec 2022 09:17:17 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.1
Subject: Re: [RFC PATCH 1/1] remoteproc: Introduce rproc_get_by_id API
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     "arnaud.pouliquen@foss.st.com" <arnaud.pouliquen@foss.st.com>,
        "bill.mills@linaro.com" <bill.mills@linaro.com>,
        "Shah, Tanmay" <tanmay.shah@amd.com>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20221115153753.2065803-1-ben.levinsky@xilinx.com>
 <20221115153753.2065803-2-ben.levinsky@xilinx.com>
 <20221125180509.GA622847@p14s> <C981698C-5B9B-49B6-9EC2-CC7A0737B155@amd.com>
 <20221202170042.GA165812@p14s> <ba21b0e5-80e2-d976-1bf3-98a91825086b@amd.com>
 <20221208190523.GA636328@p14s> <b49ad56a-f008-55e3-22a7-c47afe5bdd3e@amd.com>
 <20221213215318.GA893317@p14s> <20221213222123.GA1128798@p14s>
 <D93BFC0C-F90C-413E-899F-9CF5C6FB794A@amd.com>
Content-Language: en-US
From:   Ben Levinsky <ben.levinsky@amd.com>
In-Reply-To: <D93BFC0C-F90C-413E-899F-9CF5C6FB794A@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0154.namprd03.prod.outlook.com
 (2603:10b6:a03:338::9) To SA3PR12MB8021.namprd12.prod.outlook.com
 (2603:10b6:806:305::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB8021:EE_|CH3PR12MB7764:EE_
X-MS-Office365-Filtering-Correlation-Id: f109b157-ffea-470f-b1bd-08daddf70e63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wRHHul4zoGlEfRC7ycHcDJwDXbka98XN8iOGPfnVfMpXArwZzQLN8PHEhZFWOWsuSlZhzYBNocR6EIztq9qC0jKm+E5G97xVNCnmt0DOLYBL1WrqwaeGgDaoietnrW6itsKjTV1XLYPpMw+GtEajKmI9IvlL12Ky/VgrkX/SGOAvGs0lOs1VrYomvdO4XV6I3bCGUVa2B675RmQMtLOsXlfH/kI4w/gcEqiS5ISKlO05fltUD+DdsAeW6+PEflB6dpg3zYKbN4DflHryQpCAie1GCd8eTPMgJAGlKyYHYj6yrcbZJ1ULfQTRApnWl4Uwkl6+l7lsF0GsGe4mdaxB+ZuiHe43vNVPgYGNXeBAKmDG03llFoDeBDqCv3K9fufQkq4k3cxIsQtuXl/ctfaQLrMLmFBiMgosKre87ZZW4Tt1sdtQBd4keEhJaPB8snGzEFD1xnjBnSY/+kqf8ebDG6PBmLJNW8JdmEurtbL/QkK2hBx7oDboifKXbHtL/UlXaYjX7kHQaSYPp8xvVgE72ATX2I+qdo+mnLpXUat4O/CJjVy+e4j/WTF+mP/mFzd/WTF+pLobxm+ktRVWPAsMg4pGyg4OUMOMdGH9obkGyD8nZVciz+QuyS14Rp2rfX1yOn5wDKaGUJITFXsHiDE8oXhrghXq1EUGsWYS1TiAoVPwGugj98fcnPMOIsWTw6KZCImon0MKDyZbl7aT0g0Hq7dpsvJ1tAsGUnaZjHJwAahmynHIr1ujGAeA4XSznM9dT4gKLy1/9wMKcQtAbWqxzfYxlFFG4kbeJcVhuicK6S8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB8021.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(366004)(39860400002)(346002)(396003)(451199015)(44832011)(30864003)(2906002)(31696002)(478600001)(6486002)(86362001)(2616005)(6506007)(53546011)(6512007)(186003)(966005)(4326008)(66556008)(66476007)(66946007)(8676002)(83380400001)(41300700001)(316002)(5660300002)(8936002)(38100700002)(54906003)(6916009)(31686004)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y3FjVi9Gc0ZRTGlpYlEvRlppOFdjT2dhSDVKdit6anBHRVpsMEQzYUUyNEl1?=
 =?utf-8?B?SDA0S2xIazhGaHZ3REtKbGk4b0tBWDNQbGdROUhEQTJiUlhrdzlwZFBaUkxt?=
 =?utf-8?B?enZjcmMzSzRtdk1pMDgwNEd2R3FpVGxGRW1ReDNUcFJheWQ4bnNwUWpiclVR?=
 =?utf-8?B?c2tNWHNDMUY4RjBtdjhWR2RzbEtWNU9OQmtjZlRMaWFSQ1o2dWdBeVZDeVlx?=
 =?utf-8?B?WHJXajNXNGswdEpZL1hGcHR4L1VwMDlSSUtuWkVWbXlHYm5hZFZnOVAwNy9v?=
 =?utf-8?B?ZEZTTHNCZUdwUGJyaEQ0NkhiR09pYW1pbVo4UGpzSFM5Y29TZUErbnlmY1ha?=
 =?utf-8?B?QlpFNEJnc1owUzFhTFhTMVVJcSttcUZlblZ5bzJISTFhZkhXMTBxLzJxY3RQ?=
 =?utf-8?B?STNUYUlVZEpTeUZJTm9ORkNIT0FkYlNrRVFUYkFWbmFmdTF3NEhOVVZjb2Mr?=
 =?utf-8?B?RS80WFBlVVUvTmJGY1BJQVo1UW1xZ0orbjRYMW1WN0NoWjVEZ2dKMFprYzdG?=
 =?utf-8?B?NGE2OWVDZDMyQ3VHZERmSjN5N0RtaThJNHVkdTcvRUZOeEVLbG0vMXRFQnB1?=
 =?utf-8?B?VXZPMCtvOTMrbDZKQUxabEcyTFVqejYxd3dIL2lhYWNpRWIzbW9tQmV2OTAz?=
 =?utf-8?B?aXlDdGJraTU3VVNINlVzOElHaDhDS2FaZGh0K3AyVTN6TVU0SlRPa0Z4Mi9W?=
 =?utf-8?B?RlFmMTd0eWRGY0orMDNOb0VhSHVrSGd1QXFDS2VDczlTUTZPLzZKYktJS2NB?=
 =?utf-8?B?YXVTdlNFdXkwNGovWUhCVXRaNk1OK042U0xyd3RDMkFXbWUzS2djb3BPMURV?=
 =?utf-8?B?NWkwbzFUY0k3SStvZC9BOHZ3b3FSSDkzYkd6UTdVM0htQ25iRmRaRHBqLzRt?=
 =?utf-8?B?WE5iWDdpTHlWUGNueDExTXFDcVNvUmNoTGZaWnIzS0VJYVFXdHJtQlQ0NzZn?=
 =?utf-8?B?NkZOakVqSUNRTUNkVk8zWWZTK1U4aThkVlppd3RYNnBTUy94dXFFanhFVmRr?=
 =?utf-8?B?MXlIZEpPc0Ewb05hVHVDUklZSXZZZDZzSVNmYVRkQlVzTUlyemt4VXNGUTc4?=
 =?utf-8?B?NVlPTXUzQ1dtS2FLMlRGTldPbk03UndpNm1yRkZVZVZPUGppeW5jQU0xcndr?=
 =?utf-8?B?NWRtZS80YWVGci9HdFBFcm9Td2lkOWpBWG80Y3ZSTEp6YmliWWdhYTdUSHpM?=
 =?utf-8?B?UjIrNHpCaUVuS1o4dzFKWnlBcGtqWVoxSkhFLy9pQ29EajlkQUUrcWZYS2Ro?=
 =?utf-8?B?YUlMT25Ob2pnWDRwYUlPZ2xZTDZsaU1RU0ozZzVIalRkTFh0UWMza0Nza3Zo?=
 =?utf-8?B?T3RZb0c1MlJRa0JWb2szMDlPMU4wcXJjbkNDTWl2dmQvV3dsT3pDcExUcE1j?=
 =?utf-8?B?VHEzRE9Ia2p4QXhNSkw2eXkwK3RISkhpWmFpZ0hENWJOTjlaRkZ1ajNKKzk5?=
 =?utf-8?B?UE42a05tWVlTSUFsejM0OEZjTFBBbFZoM1NvVGZhYzVETkhxa0w4OWRWVlFK?=
 =?utf-8?B?bTlmV2pYK1Z5UFlUaENkTVc4TTBEZm5ZWXo5alpHQTJDNytOcmJ4ZnpGcjZ3?=
 =?utf-8?B?OWRpNDVwcGFON0paTXc3ZlZIczh1RGZXWjErZXR1eXZ0ZS93WGJIYkNYTkxI?=
 =?utf-8?B?eTh1bk83dUlUL25oaG1uakRyY2hYd2s5TzB2Tk1jQW8ybnh2SUhTSWlyeFds?=
 =?utf-8?B?OVo2akJiVGNHM1IzL3hwYzBZZWtTUm1PbVkvMzk0WlR6aE82NFpGWlNOYUxj?=
 =?utf-8?B?VEdaanJPcmZRMnNpbCtFZDJrcGlRRG1CbDlpYnN0OTVYK2s0WVBaZ1ZCWXBj?=
 =?utf-8?B?bTZ2UGc5S2lzOURsRUlCWmVOK1Z6NDVDRk9VTGphN1dlbXUrZFU0bjluZmNk?=
 =?utf-8?B?YmZxS2tUYS83bmpva2NvYVo3UmFXYTE5bVkxMklUZ1FKbjJYWGFxbzdmQ0Z6?=
 =?utf-8?B?VUpOWW5UclNFb241WkdWUGpMZWdFdHM4TTFxUmNsaWZucXQxS1FLWS9OQWRE?=
 =?utf-8?B?b0dCVmxqVk91VlJyMVVxVWVjRVpkdm41d0c1d1laMi9XY1orcS9nVHFlM24y?=
 =?utf-8?B?M3hUTlJ0VkduQjBBMDAzdUJHWmF3Sytzamw1YkN5OWl3Sks5Q2svNldRcFlW?=
 =?utf-8?B?bGYycEJobDdRU3lVb2VCQ0dJVEtOcWk3TG9pTXJIbW1vcmQzeTRzM1JyVWxF?=
 =?utf-8?Q?sXaZr3wZ7xtULYumthBpmBdbqfKWFWfnERwPFdt57eFi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f109b157-ffea-470f-b1bd-08daddf70e63
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB8021.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2022 17:17:19.5839
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SEMTwQJUw+nWw+57xAzryuQ4yoe8KoHwD2Tj/bZxldG1HSV3pT7X7dx3U1OlFleg8ZLEdzWAk0Q8ryPwgrjyRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7764
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Can confirm this works for my use case! Thank you!

On 12/14/22 9:16 AM, Levinsky, Ben wrote:
> 
> 
> ﻿On 12/13/22, 2:21 PM, "Mathieu Poirier" <mathieu.poirier@linaro.org> wrote:
> 
>      On Tue, Dec 13, 2022 at 02:53:18PM -0700, Mathieu Poirier wrote:
>      > On Fri, Dec 09, 2022 at 11:01:47AM -0800, Ben Levinsky wrote:
>      > > Hi Mathieu,
>      > >
>      > > On 12/8/22 11:05 AM, Mathieu Poirier wrote:
>      > > > On Tue, Dec 06, 2022 at 08:23:13AM -0800, Ben Levinsky wrote:
>      > > > > Good Morning Mathieu,
>      > > > >
>      > > > >
>      > > > > I did some testing and replied inline.
>      > > > >
>      > > > >
>      > > > > On 12/2/22 9:00 AM, Mathieu Poirier wrote:
>      > > > > > On Wed, Nov 30, 2022 at 09:39:33PM +0000, Levinsky, Ben wrote:
>      > > > > > > Hi Mathieu,
>      > > > > > >
>      > > > > > > Thank you for your review. Please see my reply inline.
>      > > > > > >
>      > > > > > > Thanks
>      > > > > > > Ben
>      > > > > > >
>      > > > > > > On 11/25/22, 10:05 AM, "Mathieu Poirier"<mathieu.poirier@linaro.org>  wrote:
>      > > > > > >
>      > > > > > >       CAUTION: This message has originated from an External Source. Please use proper judgment and caution when opening attachments, clicking links, or responding to this email.
>      > > > > > >
>      > > > > > >
>      > > > > > >       Hi Ben,
>      > > > > > >
>      > > > > > >       On Tue, Nov 15, 2022 at 07:37:53AM -0800, Ben Levinsky wrote:
>      > > > > > >       > Allow users of remoteproc the ability to get a handle to an rproc by
>      > > > > > >       > passing in node that has parent rproc device and an ID that matches
>      > > > > > >       > an expected rproc struct's index field.
>      > > > > > >       >
>      > > > > > >       > This enables to get rproc structure for remoteproc drivers that manage
>      > > > > > >       > more than 1 remote processor (e.g. TI and Xilinx R5 drivers).
>      > > > > > >       >
>      > > > > > >       > Signed-off-by: Ben Levinsky<ben.levinsky@xilinx.com>
>      > > > > > >       > ---
>      > > > > > >       >  drivers/remoteproc/remoteproc_core.c | 64 +++++++++++++++++++++++++++-
>      > > > > > >       >  include/linux/remoteproc.h           |  1 +
>      > > > > > >       >  2 files changed, 64 insertions(+), 1 deletion(-)
>      > > > > > >       >
>      > > > > > >       > diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
>      > > > > > >       > index 775df165eb45..6f7058bcc80c 100644
>      > > > > > >       > --- a/drivers/remoteproc/remoteproc_core.c
>      > > > > > >       > +++ b/drivers/remoteproc/remoteproc_core.c
>      > > > > > >       > @@ -40,6 +40,7 @@
>      > > > > > >       >  #include <linux/virtio_ring.h>
>      > > > > > >       >  #include <asm/byteorder.h>
>      > > > > > >       >  #include <linux/platform_device.h>
>      > > > > > >       > +#include <linux/of_platform.h>
>      > > > > > >       >
>      > > > > > >       >  #include "remoteproc_internal.h"
>      > > > > > >       >
>      > > > > > >       > @@ -2203,13 +2204,74 @@ struct rproc *rproc_get_by_phandle(phandle phandle)
>      > > > > > >       >
>      > > > > > >       >       return rproc;
>      > > > > > >       >  }
>      > > > > > >       > +
>      > > > > > >       > +/**
>      > > > > > >       > + * rproc_get_by_id() - find a remote processor by ID
>      > > > > > >       > + * @phandle: phandle to the rproc
>      > > > > > >       > + * @id: Index into rproc list that uniquely identifies the rproc struct
>      > > > > > >       > + *
>      > > > > > >       > + * Finds an rproc handle using the remote processor's index, and then
>      > > > > > >       > + * return a handle to the rproc. Before returning, ensure that the
>      > > > > > >       > + * parent node's driver is still loaded.
>      > > > > > >       > + *
>      > > > > > >       > + * This function increments the remote processor's refcount, so always
>      > > > > > >       > + * use rproc_put() to decrement it back once rproc isn't needed anymore.
>      > > > > > >       > + *
>      > > > > > >       > + * Return: rproc handle on success, and NULL on failure
>      > > > > > >       > + */
>      > > > > > >       > +
>      > > > > > >       > +struct rproc *rproc_get_by_id(phandle phandle, unsigned int id)
>      > > > > > >       > +{
>      > > > > > >       > +     struct rproc *rproc = NULL, *r;
>      > > > > > >       > +     struct platform_device *parent_pdev;
>      > > > > > >       > +     struct device_node *np;
>      > > > > > >       > +
>      > > > > > >       > +     np = of_find_node_by_phandle(phandle);
>      > > > > > >       > +     if (!np)
>      > > > > > >       > +             return NULL;
>      > > > > > >       > +
>      > > > > > >       > +     parent_pdev = of_find_device_by_node(np->parent);
>      > > > > > >       > +     if (!parent_pdev) {
>      > > > > > >       > +             dev_err(&parent_pdev->dev,
>      > > > > > >       > +                     "no platform device for node %pOF\n", np);
>      > > > > > >       > +             of_node_put(np);
>      > > > > > >       > +             return NULL;
>      > > > > > >       > +     }
>      > > > > > >       > +
>      > > > > > >       > +     /* prevent underlying implementation from being removed */
>      > > > > > >       > +     if (!try_module_get(parent_pdev->dev.driver->owner)) {
>      > > > > > >       > +             dev_err(&parent_pdev->dev, "can't get owner\n");
>      > > > > > >       > +             of_node_put(np);
>      > > > > > >       > +             return NULL;
>      > > > > > >       > +     }
>      > > > > > >       > +
>      > > > > > >       > +     rcu_read_lock();
>      > > > > > >       > +     list_for_each_entry_rcu(r, &rproc_list, node) {
>      > > > > > >       > +             if (r->index == id) {
>      > > > > > >       > +                     rproc = r;
>      > > > > > >       > +                     get_device(&rproc->dev);
>      > > > > > >       > +                     break;
>      > > > > > >       > +             }
>      > > > > > >       > +     }
>      > > > > > >
>      > > > > > >       This won't work because several remote processors can be on the list.  If
>      > > > > > >       another remote processor was discovered before the one @phandle is associated
>      > > > > > >       with, the remote processor pertaining to that previous one will returned.
>      > > > > > >
>      > > > > > > I didn't understand. From my point of view passing in the phandle of the child-platform device here will work because each child-platform will have its own entry in the remoteproc list.
>      > > > > > You are correct, each child platform device will have its own entry in
>      > > > > > @rproc_list.  The problem is that r->index may not match @id that is passed as a
>      > > > > > parameter.
>      > > > > >
>      > > > > > > Also " If    another remote processor was discovered before the one" Here this prevented from what I can see because the remoteproc_list is protected by a mutex_lock. Seehttps://github.com/torvalds/linux/blob/master/drivers/remoteproc/remoteproc_core.c#L2288  for the mutex_lock.
>      > > > > > >
>      > > > > > > Additionally the calls to zynqmp_r5_add_rproc_core() are called sequentially so this also prevents the race condition.
>      > > > > > >
>      > > > > > > I think I am missing something in your paragraph above. Can you expand on this issue?
>      > > > > > As explained above, the issue is not about race conditions but the value of
>      > > > > > r->index and @id.
>      > > > > >
>      > > > > > >    Do you mean to say that if we use the cluster platform device you think using one of the existing APIs will work? For example rproc_get_by_child() or rproc_get_by_phandle()
>      > > > > > >
>      > > > > > > Athttps://git.kernel.org/pub/scm/linux/kernel/git/remoteproc/linux.git/tree/drivers/remoteproc/xlnx_r5_remoteproc.c?h=rproc-next#n923  " zynqmp_r5_add_rproc_core(&child_pdev->dev);" Here if we use cluster->dev this will work? To dig deeper into this for both the Xilinx and TI R5 remoteproc drivers, I think this proposed solution will create an issue in that for Split modes, the existing getter APIs will not be able to return one of the corresponding rproc instances because both cores will refer to the same platform-device structure.
>      > > > > > >
>      > > > > > > I can bring up the above in the community call.
>      > > > > > >
>      > > > > > >       There is also an issue with rproc_put().
>      > > > > > >
>      > > > > > > If passing the cluster platform device works for the above then rproc_put() should work correct? We can test this on our side as well. That being said I can bring this up in the community call
>      > > > > > Yes, using the cluster platform device will work with rproc_put().
>      > > > > >
>      > > > > > >
>      > > > > > >       I think your description of the problem is mostly correct.  The intermediate
>      > > > > > >       devices created by the cascading entries for individual remote processors in the
>      > > > > > >       device tree are causing an issue.  The "compatible" string for each remote
>      > > > > > >       processor can't be handled by any platform drivers (as it should be), which
>      > > > > > >       makes try_module_get() fail because r->dev.parent->driver is not bound to
>      > > > > > >       anything.
>      > > > > > >
>      > > > > > >       Looking at the code for Xilinx's R5F support that I just queued[1], the simplest
>      > > > > > >       solution may be to pass @dev, which is in fact @cluster->dev, to
>      > > > > > >       zynqmp_r5_add_rproc_core() rather than the device associated with the
>      > > > > > >       intermediate platform device.
>      > > > > > >
>      > > > > > >       That _should_ work.  It is hard for me to know for sure since I don't have a
>      > > > > > >       platform that has dual core remote processor to test with.
>      > > > > > >
>      > > > > > >       Get back to me with how that turned out and we'll go from there.
>      > > > > > >
>      > > > > > >       Thanks,
>      > > > > > >       Mathieu
>      > > > > > >
>      > > > > > >
>      > > > > > >
>      > > > > > >
>      > > > > > >       [1].https://git.kernel.org/pub/scm/linux/kernel/git/remoteproc/linux.git/tree/drivers/remoteproc/xlnx_r5_remoteproc.c?h=rproc-next#n923
>      > > > >
>      > > > > I have an update on this.
>      > > > >
>      > > > >
>      > > > >
>      > > > > I tested the following using the RPU-cluster platform device:
>      > > > >
>      > > > > test 1: RPU split with 2 core
>      > > > >
>      > > > > test 2: RPU split with 1 core
>      > > > >
>      > > > > test 3: lockstep RPU
>      > > > >
>      > > > >
>      > > > > I tested with the zynqmp-r5-remoteproc platform probe using the (RPU)
>      > > > > cluster platform device instead of the core/child platform device. When I
>      > > > > used this I was unable to properly use the API rproc_get_by_phandle() and
>      > > > > there was _only_ an issue for test 1. This was because each core will have
>      > > > > its own call to rproc_alloc(), rproc_add() and each core's remoteproc
>      > > > > structure has the same parent device.
>      > > >
>      > > > You haven't specified if my proposal worked with test 2 and 3.  I'm guessing
>      > > > that it does.
>      > > >
>      > > Sorry, yes tests 2 and 3 work with your proposal.
>      > > > >
>      > > > > This results in the later call to rproc_get_by_phandle() not behaving
>      > > > > properly because the function will return whichever core had its entries
>      > > > > added to the list first.
>      > > > >
>      > > >
>      > > > That is a valid observation, but at least we are getting closer.  The next step
>      > > > is to find the right remote processor and I think we should look at np->name and
>      > > > rproc->name.  They should be quite close because rproc_alloc() is called with
>      > > > dev_name(cdev).
>      > > >
>      > > > I will look into this further tomorrow morning if I have time, but I encourage
>      > > > you to do the same on your side.
>      > > >
>      > >
>      > > For the case where the cluster is in split mode and there are 2 child nodes
>      > > here is my update:
>      > >
>      > > 1. The rproc_list has 2 entries as follows:
>      > > 	
>      > >   as expected each entry has the same r->dev.parent (E.g. the cluster node)
>      > >
>      > >   The entries have the  with device name rproc->dev name 'remoteproc0' and
>      > > 'remoteproc1'
>      > >
>      > >
>      > > 	
>      > > 2. For my use case I am trying to pass in the phandle of the core node
>      > > (child of the cluster). If I pass in the core node then
>      > > rproc_get_by_phandle() returns NULL because the r->dev.parent->of_node does
>      > > not match. This is expected because at rproc_alloc() we passed in the
>      > > cluster and not the core.
>      > >
>      >
>      >
>      > I had a serious look into this and trying to do something with the rproc->name and
>      > device_node->name won't work.  As such, I suggest the following (uncompiled and
>      > untested):
>      >
>      > struct rproc *rproc_get_by_phandle(phandle phandle)
>      > {
>      >         struct platform_device *cluster_pdev;
>      > 	struct rproc *rproc = NULL, *r;
>      >         struct device_driver *driver;
>      > 	struct device_node *np;
>      >
>      > 	np = of_find_node_by_phandle(phandle);
>      > 	if (!np)
>      > 		return NULL;
>      >
>      > 	rcu_read_lock();
>      > 	list_for_each_entry_rcu(r, &rproc_list, node) {
>      > 		if (r->dev.parent && r->dev.parent->of_node == np) {
>      > 			/* prevent underlying implementation from being removed */
>      >
>      >                         /*
>      >                          * If the remoteproc's parent has a driver, the
>      >                          * remoteproc is not part of a cluster and we can use
>      >                          * that driver.
>      >                          */
>      >                         driver = r->dev.parent->driver;
>      >
>      >                         /*
>      >                          * If the remoteproc's parent does not have a driver,
>      >                          * look for the driver associated with the cluster.
>      >                          */
>      >                         if (!driver) {
>      >                                 cluster_pdev = of_find_device_by_node(np->parent);
>      >                                 if (!cluster_pdev) {
>      >                                         dev_err(&r->dev, "can't get driver\n");
>      >                                         break;
>      >                                 }
>      >
>      >                                 driver = cluster_pdev->dev.parent->driver;
> 
>      This should be:
> 
>                                        driver = cluster_pdev->dev.driver;
> 
>      >                                 put_device(&cluster_pdev->dev);
>      >                         }
>      >
>      > 			if (!try_module_get(driver->owner)) {
>      > 				dev_err(&r->dev, "can't get owner\n");
>      > 				break;
>      > 			}
>      >
>      > 			rproc = r;
>      > 			get_device(&rproc->dev);
>      > 			break;
>      > 		}
>      > 	}
>      > 	rcu_read_unlock();
>      >
>      > 	of_node_put(np);
>      >
>      > 	return rproc;
>      > }
>      >
>      > Let me know if that works for you.
>      >
>      > Thanks,
>      > Mathieu
>      >
>      >
>      >
>      > > np->name in the loop is then name of the cluster node in my sample device
>      > > tree that I booted with that is 'r5f_0' where the cluster is 'rf5ss'.
>      > >
>      > > If I am trying to get the rproc entry with name 'remoteproc0' and I pass in
>      > > to rproc_get_by_phandle() the cluster node's phandle (that is of rf5ss) then
>      > > the API _does_ work for getting the first entry from the rproc list.
>      > >
>      > > But If I am trying to the second rproc entry (dev name 'remoteproc1') and I
>      > > pass into rproc_get_by_phandle()  I will still get the 'remoteproc0' entry
>      > > because the phandle of the first entry also matches in the loop.
>      > >
>      > > Thanks
>      > > Ben
>      > >
>      > > > >
>      > > > > For reference I placed the logic for API rproc_get_by_phandle() that loops
>      > > > > through device and the rproc_alloc() line where the dev parent is set:
>      > > > >
>      > > > >
>      > > > > Here is the getter API where the loop checking the remoteproc dev parent is:
>      > > > >
>      > > > > https://github.com/torvalds/linux/blob/master/drivers/remoteproc/remoteproc_core.c#L2109
>      > > > >
>      > > > >
>      > > > > if(r->dev.parent&& r->dev.parent->of_node== np) {
>      > > > >
>      > > > >
>      > > > > Here is the rproc_alloc() call where they set remoteproc dev parent:
>      > > > >
>      > > > > https://github.com/torvalds/linux/blob/master/drivers/remoteproc/remoteproc_core.c#L2448
>      > > > >
>      > > > >
>      > > > > rproc->dev.parent= dev;
>      > > > >
>      > > > > Thanks,
>      > > > >
>      > > > > Ben
>      > > > >
>      > > >
> 
> ep
> is to find the right remote processor and I think we should look at np->name and
> rproc->name.  They should be quite close because rproc_alloc() is called with
> dev_name(cdev).
> 
> I will look into this further tomorrow morning if I have time, but I encourage
> you to do the same on your side.
> 
>>
>> For reference I placed the logic for API rproc_get_by_phandle() that loops
>> through device and the rproc_alloc() line where the dev parent is set:
>>
>>
>> Here is the getter API where the loop checking the remoteproc dev parent is:
>>
>> https://github.com/torvalds/linux/blob/master/drivers/remoteproc/remoteproc_core.c#L2109
>>
>>
>> if(r->dev.parent&& r->dev.parent->of_node=np) {
>>
>>
>> Here is the rproc_alloc() call where they set remoteproc dev parent:
>>
>> https://github.com/torvalds/linux/blob/master/drivers/remoteproc/remoteproc_core.c#L2448
>>
>>
>> rproc->dev.parent=ev;
>>
>> Thanks,
>>
>> Ben
>>
> 
