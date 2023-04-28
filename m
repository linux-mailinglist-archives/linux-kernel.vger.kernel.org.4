Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 832236F197F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 15:30:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346107AbjD1Na3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 09:30:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjD1Na1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 09:30:27 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2088.outbound.protection.outlook.com [40.107.100.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3514335B8
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 06:30:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lgrslIRO8/FhGbv9gaZvRC2vzwNQ8HxdJf0PbIfaLU3HweP+KK4zBlMlc8wYoJG9NBP/l3w3jahBAysw8ZC+0cFI3Hhpu5pPrQ8KTXAhVGAEWcb4dBY//8kmY8oSva8jz5pqtFAXKv3e/e9V5fDXIlPC1lF9+PpO+gGrFEiZddj4YongYkZ+iNBf58eGZONxMJRP90HHgOM+0CMHAFjCUp1LIrSnxLnmDNO3BRcmxKhvGSQpnrgyLIICB17Cx+aHi3E8nUOa5ZFQ9f28VADrI9aRQ8VLWtCRW9Fb7fPHotChuxmlKQCtjIaUkbiWx/txAgGkuMIBqhxbCnfeloafhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E4dwnUD2oOXA8EyxFkVyoHOHzMDnxWz+nMqD96ZpiXA=;
 b=MKeU40eMmdN3/dEiunJhnfbGcIG84VsYo36XT8IsVYGTB25AXN58k4/ZbNbqr5NOlxudtBRs5455jgxNgQcYMgZ8Ikom2pQ8mPfMp/oN6VlFSpOM5AQ/E7G2gYMbaSQLnO1RWsoS2w3yhxMTInFKHoSlmfWDUTqDP1F/d1gDL8pTAZq57tZ5dZqr+8GYzVjwtciXrR3AV6KP4+NBerl5RaMbI5VPnHuf7z0DbQTWMWvchuCK9bVvx3myUr4Sn2jWJJeqbY+GBwyS+roFmY1bmkMgRcNsJNUO3w84U6c7Uknqqn6Ar8wKnXWw4omTULt+XkIJYYYK3vV3BYAr18X6Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E4dwnUD2oOXA8EyxFkVyoHOHzMDnxWz+nMqD96ZpiXA=;
 b=Vz8V5KhbLfTpW2CcUlOc+9HpLKiRPI9ANOA9l85+rLkiIHjwS2pdp0qCtjFGgRnf/Ktu4dbJhhBWNTFyjFp+dFoj/KDva87C9PcsYgPNaoyz+z1hM/WK6N+2RwgxfVcUgcFPEbiC10U5F+AA34GIDUC/Sv5WPwUEzc8qodm7syI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2621.namprd12.prod.outlook.com (2603:10b6:805:73::15)
 by MN6PR12MB8592.namprd12.prod.outlook.com (2603:10b6:208:478::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.24; Fri, 28 Apr
 2023 13:30:15 +0000
Received: from SN6PR12MB2621.namprd12.prod.outlook.com
 ([fe80::5b9b:f31f:ac6d:be94]) by SN6PR12MB2621.namprd12.prod.outlook.com
 ([fe80::5b9b:f31f:ac6d:be94%7]) with mapi id 15.20.6340.022; Fri, 28 Apr 2023
 13:30:15 +0000
Message-ID: <a3a0dba5-a231-7cc2-dbad-79df7ad9a136@amd.com>
Date:   Fri, 28 Apr 2023 14:30:09 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH] xen/evtchn: Introduce new IOCTL to bind static evtchn
To:     Rahul Singh <rahul.singh@arm.com>, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Samuel Holland <samuel@sholland.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Marc Zyngier <maz@kernel.org>,
        Jane Malalane <jane.malalane@citrix.com>,
        David Woodhouse <dwmw@amazon.co.uk>
References: <48d30a439e37f6917b9a667289792c2b3f548d6d.1682685294.git.rahul.singh@arm.com>
From:   Ayan Kumar Halder <ayankuma@amd.com>
In-Reply-To: <48d30a439e37f6917b9a667289792c2b3f548d6d.1682685294.git.rahul.singh@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO3P123CA0003.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:ba::8) To SN6PR12MB2621.namprd12.prod.outlook.com
 (2603:10b6:805:73::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR12MB2621:EE_|MN6PR12MB8592:EE_
X-MS-Office365-Filtering-Correlation-Id: dba4d9a2-6f47-4cd7-f9ab-08db47ecb3b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r/mpqrox6I81UYhKkT+xoIKVlK4ZeQU2gsefsjpgHzReLZxKkspVn0J7GRh/zdBCjAVYCYPZiZ99AChtZsJNSIwpJsYi2uQh7tutnYncCc4OdhILEAAfP+W05ijs7xjJpxC0Hjyx2x8EyhVpPxYQ4434cTENWj0zd6UUxgf2CBifujiHXuxxpB0KKgk+xQjNRAwmCflOIazDjaFDuEkBlgIe2514MS6Wr1HWjPvVVrVjfh0mw+OGbXfrdYvzucdy70r8xEL2MwEkiceEFU4GDbYM/y2FeLKYSqcwkblHf8XeHGDmGGC/KCot/qvKLNE0PJ1MB9nWUfsiMOFfwxYJU0cdVgknqO00VNQGI2AtQleVTlQPlV51HjnYoIMx78AF6AUoD4Rt4C1ciKcqFXpm9OLnH6Bh6CDGFM1F5vZfaspHGgyF/HKCnwZQBl/eW0sCWfL4jXlYSFqDvl8vKd9Yn3tX2X+DwwxcVbtnuyznTVSZrKEnhvUFjrAkMLCaoXVghm/PU4wJiK6XH/odHZ0eVK7Hkwaz+fMzhRujDuiDNej1yrJcOTUFx+0q5ipDEp3YAjqYotWaOzH5Ju2QdLlYKe7d0EnnFDeVbG5Kuvcv9HaqPe7er6I+jRDhXtpB1x7x2n6zwrj8kEFKDLR3PB55PQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2621.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(136003)(396003)(346002)(376002)(451199021)(31686004)(31696002)(2906002)(36756003)(6486002)(53546011)(6666004)(2616005)(186003)(83380400001)(6512007)(26005)(6506007)(66476007)(4326008)(66556008)(66946007)(478600001)(316002)(5660300002)(38100700002)(41300700001)(8676002)(54906003)(7416002)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MzIwQWVZc2t0QlAzNUdydnVpRXZHUnVwUUVHMzRxY2EyWVZja1owZzJuMkMv?=
 =?utf-8?B?cC90WnFoTkVndGJBcndYcERROTFZdURZTjdsZ1BCU3pMSkd4WFM4ckNaL05s?=
 =?utf-8?B?WUF6UnFudTNzbHVnd1E1ZDdCQlptcjBmVEVtWXZyOXZuNzFEWjFXcFkycXp1?=
 =?utf-8?B?TWhCRmNIRHFwc24vdmJEK3BFbm1jcXd4NElzS0MyNXlLWG9WWDB4M2NzM1pU?=
 =?utf-8?B?QU11NkdFdDhTcXRSdjdVYVRxUkhNYzBpQU51RC9WZTFldkpXSTk2bGxYRG1S?=
 =?utf-8?B?aW5XZExtcHpIVWtkOUxPVEc5M08xUWFvb1hLcCtNV2hKQTBkczJkRFpwYWdK?=
 =?utf-8?B?dUVPazh2dXpGUzhod01YQkRhQTlKc1J2MHlUMnBrQlo3ODdGbUpFaTBvdWxP?=
 =?utf-8?B?ZWxkQ1hsWUZaSTNWUnJuQnFMNTNZZWpDVWNkN0V2M3dUb25NUldlRExZTTRR?=
 =?utf-8?B?WFBzMlh6M2svNk91Sk9McUtoSVhrNVJNTjRQSmFQNzM4eUwveGVOUmF6Q0Vu?=
 =?utf-8?B?bFRRaXpPaC9MMDJxVDZSM1dEQW15aXhjWHdlWFppNGpNVXBSYUhnS09oZGxh?=
 =?utf-8?B?N3c1cXhaNXo1YXVqbjdBa2FFQW1GZHJkcTZWMkdBRGMzaFVBMjRsS2ZPaDlh?=
 =?utf-8?B?TjNBa3hhNGVhOGYzWWpDbUxrQ3lMc2hDQkY1S0g5aUxSa1Nsc2JUT3pGYzFW?=
 =?utf-8?B?a3JaenhHUWRjalhLaTlKRFFWcG1JakJsM25GbHVMcGJEdFJIQ201c2ZrcjRE?=
 =?utf-8?B?bm5vNjF5SU9GdVZZQjRYZ21wT2VVb2NhZ3lTQXJiQlRkWXcxRnVEVXM2bXI1?=
 =?utf-8?B?SXd6enVoRGo3THBDQm9kb3JtTjB5Ym9qSGFsOG9vYWFDYSs4T1hKN2JtUkVQ?=
 =?utf-8?B?ZUNQYUIvWnZkSSsybUtiZHp2cnhNN0pJRXpCdUZsQTZyMDBwb0d0a3hSc21p?=
 =?utf-8?B?eXgwc1Mzd1JtZnc4S1krSnBxTG9OZUU3a0dSLzE3QUFxMjhTZVk0VXM3TG11?=
 =?utf-8?B?TnNKUmJhckZvWDR6WkUwcXFyNk5RZEZqUUZxUnljaGFlYkZiRGVHcCtGcytI?=
 =?utf-8?B?cjJhNDcwOTZhZG9OQTY1WUlQY1Y4alh2TE9lWFg5RkMyS2U3cENqZktFdUpo?=
 =?utf-8?B?YmVTRmZDdUVBNmxmclFlWUMwaVJDTEU5bTl1VWEyTG5maFVHajRrTlVVSVZk?=
 =?utf-8?B?Uy9xWXZYL2tOblB2amZicDhBV0dscnhyY3piQ010V0pkeWpsbDdFTSsxeW83?=
 =?utf-8?B?VFIrc2FOS1BxQ2NRc0plYWFNWFlocWhlMk1nYTZCMFFETkFWcTlIY2FJVThm?=
 =?utf-8?B?dXloRTRqaGd4VFgvaENNKzJmMlJPZTlvUnRqVXRhZ1N2VGZMbmlLcWE0Q2p4?=
 =?utf-8?B?WkVLN0dLWkJOM3Yyc0ZXT0hNUEpUeHpTdUlxQ0c5WnJZVVQxRzNkcVpyczV2?=
 =?utf-8?B?Y29KWi9nUTZLd2o4aGlSVjNhWENNWlR0c0t6OSt5REFaNENrQXdvWnppTU5m?=
 =?utf-8?B?WUJveUEwcy9oYll1L09mdHpyRlVDZktUOGxOLzg4MkhXNGR0REVmS0VSY04w?=
 =?utf-8?B?aUFrNVZKMnFzci8rRVU4MTNGQXpWcks3TlFoMTBpc1oyNkhuN0c1dmozUkRD?=
 =?utf-8?B?TDkxUkhRWUQzNjRwTGdwLzJ3SExQTXBPdlgvSmhLZm42VFRjWnp0QzdqeGxN?=
 =?utf-8?B?VHU1NFFtVS9KRE5HYnNGeHppQ3NFWTVZaU93TzhLSEVvTjNLd0ducDZhOXNJ?=
 =?utf-8?B?N0FLNlNvU2hGdkFNZGp4czlUR3Y4a3B6UHh2NUhQMjdXdVBCbnN0RkRDMCta?=
 =?utf-8?B?eDdTSXdqdDNRLzBHQjNsRVpqRWZxSjd0aVZFMjhrMjNyUUdsQTZLSUNTcDBq?=
 =?utf-8?B?UHM4QzFtWmQzWWw3Nnc0a1dtbmh2Q0E3MmkrN3N4elNJZUJCOC9nKzkrUUg2?=
 =?utf-8?B?T2YxQ1VkRkwvQ0s4TExXQ0J1RlF0bnprTWkyWjdFbUJKT0xBY1ViWW9vNW1x?=
 =?utf-8?B?WHBiL0JpaDd6VWMrMUwyUm9qek9zWG5sNEJxRDJheDRTdDU3ZlVxeWlEVVZH?=
 =?utf-8?B?L0dOUFNrd2dJVnRyK0N3V0IveStUOEpmQkZKcHd2c0Y4c3N0bjdGZ3BrdVVk?=
 =?utf-8?Q?qSQ61UecgLSn5HRD3n9m8YPFh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dba4d9a2-6f47-4cd7-f9ab-08db47ecb3b2
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2621.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2023 13:30:15.8155
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3T7J/KCBcuDu0YAlEb1ya/+voJAp7mK1XtWY/2DnWVRX4CRZBdQvJdiM7MZJiSgS/BWKaW08YNWtC6jX3uZL4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8592
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rahul,

On 28/04/2023 13:36, Rahul Singh wrote:
> CAUTION: This message has originated from an External Source. Please use proper judgment and caution when opening attachments, clicking links, or responding to this email.
>
>
> Xen 4.17 supports the creation of static evtchns. To allow user space
> application to bind static evtchns introduce new ioctl
> "IOCTL_EVTCHN_BIND_STATIC". Existing IOCTL doing more than binding
> that’s why we need to introduce the new IOCTL to only bind the static
> event channels.
>
> Also, static evtchns to be available for use during the lifetime of the
> guest. When the application exits, __unbind_from_irq() end up
> being called from release() fop because of that static evtchns are
> getting closed. To avoid closing the static event channel, add the new
> bool variable "is_static" in "struct irq_info" to mark the event channel
> static when creating the event channel to avoid closing the static
> evtchn.
>
> Signed-off-by: Rahul Singh <rahul.singh@arm.com>
> ---
>   drivers/xen/events/events_base.c |  7 +++++--
>   drivers/xen/evtchn.c             | 22 +++++++++++++++++-----
>   include/uapi/xen/evtchn.h        |  9 +++++++++
>   include/xen/events.h             |  2 +-
>   4 files changed, 32 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/xen/events/events_base.c b/drivers/xen/events/events_base.c
> index c7715f8bd452..31f2d3634ad5 100644
> --- a/drivers/xen/events/events_base.c
> +++ b/drivers/xen/events/events_base.c
> @@ -112,6 +112,7 @@ struct irq_info {
>          unsigned int irq_epoch; /* If eoi_cpu valid: irq_epoch of event */
>          u64 eoi_time;           /* Time in jiffies when to EOI. */
>          raw_spinlock_t lock;
> +       u8 is_static;           /* Is event channel static */

I think we should avoid u8/u16/u32 and instead use 
uint8_t/uint16_t/uint32_t.

However in this case, you can use bool.

- Ayan

>
>          union {
>                  unsigned short virq;
> @@ -982,7 +983,8 @@ static void __unbind_from_irq(unsigned int irq)
>                  unsigned int cpu = cpu_from_irq(irq);
>                  struct xenbus_device *dev;
>
> -               xen_evtchn_close(evtchn);
> +               if (!info->is_static)
> +                       xen_evtchn_close(evtchn);
>
>                  switch (type_from_irq(irq)) {
>                  case IRQT_VIRQ:
> @@ -1574,7 +1576,7 @@ int xen_set_irq_priority(unsigned irq, unsigned priority)
>   }
>   EXPORT_SYMBOL_GPL(xen_set_irq_priority);
>
> -int evtchn_make_refcounted(evtchn_port_t evtchn)
> +int evtchn_make_refcounted(evtchn_port_t evtchn, bool is_static)
>   {
>          int irq = get_evtchn_to_irq(evtchn);
>          struct irq_info *info;
> @@ -1590,6 +1592,7 @@ int evtchn_make_refcounted(evtchn_port_t evtchn)
>          WARN_ON(info->refcnt != -1);
>
>          info->refcnt = 1;
> +       info->is_static = is_static;
>
>          return 0;
>   }
> diff --git a/drivers/xen/evtchn.c b/drivers/xen/evtchn.c
> index c99415a70051..47681d4c696b 100644
> --- a/drivers/xen/evtchn.c
> +++ b/drivers/xen/evtchn.c
> @@ -366,7 +366,8 @@ static int evtchn_resize_ring(struct per_user_data *u)
>          return 0;
>   }
>
> -static int evtchn_bind_to_user(struct per_user_data *u, evtchn_port_t port)
> +static int evtchn_bind_to_user(struct per_user_data *u, evtchn_port_t port,
> +                       bool is_static)
>   {
>          struct user_evtchn *evtchn;
>          struct evtchn_close close;
> @@ -402,7 +403,7 @@ static int evtchn_bind_to_user(struct per_user_data *u, evtchn_port_t port)
>          if (rc < 0)
>                  goto err;
>
> -       rc = evtchn_make_refcounted(port);
> +       rc = evtchn_make_refcounted(port, is_static);
>          return rc;
>
>   err:
> @@ -456,7 +457,7 @@ static long evtchn_ioctl(struct file *file,
>                  if (rc != 0)
>                          break;
>
> -               rc = evtchn_bind_to_user(u, bind_virq.port);
> +               rc = evtchn_bind_to_user(u, bind_virq.port, false);
>                  if (rc == 0)
>                          rc = bind_virq.port;
>                  break;
> @@ -482,7 +483,7 @@ static long evtchn_ioctl(struct file *file,
>                  if (rc != 0)
>                          break;
>
> -               rc = evtchn_bind_to_user(u, bind_interdomain.local_port);
> +               rc = evtchn_bind_to_user(u, bind_interdomain.local_port, false);
>                  if (rc == 0)
>                          rc = bind_interdomain.local_port;
>                  break;
> @@ -507,7 +508,7 @@ static long evtchn_ioctl(struct file *file,
>                  if (rc != 0)
>                          break;
>
> -               rc = evtchn_bind_to_user(u, alloc_unbound.port);
> +               rc = evtchn_bind_to_user(u, alloc_unbound.port, false);
>                  if (rc == 0)
>                          rc = alloc_unbound.port;
>                  break;
> @@ -536,6 +537,17 @@ static long evtchn_ioctl(struct file *file,
>                  break;
>          }
>
> +       case IOCTL_EVTCHN_BIND_STATIC: {
> +               struct ioctl_evtchn_bind bind;
> +
> +               rc = -EFAULT;
> +               if (copy_from_user(&bind, uarg, sizeof(bind)))
> +                       break;
> +
> +               rc = evtchn_bind_to_user(u, bind.port, true);
> +               break;
> +       }
> +
>          case IOCTL_EVTCHN_NOTIFY: {
>                  struct ioctl_evtchn_notify notify;
>                  struct user_evtchn *evtchn;
> diff --git a/include/uapi/xen/evtchn.h b/include/uapi/xen/evtchn.h
> index 7fbf732f168f..aef2b75f3413 100644
> --- a/include/uapi/xen/evtchn.h
> +++ b/include/uapi/xen/evtchn.h
> @@ -101,4 +101,13 @@ struct ioctl_evtchn_restrict_domid {
>          domid_t domid;
>   };
>
> +/*
> + * Bind statically allocated @port.
> + */
> +#define IOCTL_EVTCHN_BIND_STATIC                       \
> +       _IOC(_IOC_NONE, 'E', 7, sizeof(struct ioctl_evtchn_bind))
> +struct ioctl_evtchn_bind {
> +       unsigned int port;
> +};
> +
>   #endif /* __LINUX_PUBLIC_EVTCHN_H__ */
> diff --git a/include/xen/events.h b/include/xen/events.h
> index 44c2855c76d1..962f0bbc7ce1 100644
> --- a/include/xen/events.h
> +++ b/include/xen/events.h
> @@ -69,7 +69,7 @@ int xen_set_irq_priority(unsigned irq, unsigned priority);
>   /*
>    * Allow extra references to event channels exposed to userspace by evtchn
>    */
> -int evtchn_make_refcounted(evtchn_port_t evtchn);
> +int evtchn_make_refcounted(evtchn_port_t evtchn, bool is_static);
>   int evtchn_get(evtchn_port_t evtchn);
>   void evtchn_put(evtchn_port_t evtchn);
>
> --
> 2.25.1
>
>
