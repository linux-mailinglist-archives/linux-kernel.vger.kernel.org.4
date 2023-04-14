Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 391496E1CF7
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 09:09:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbjDNHJv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 03:09:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjDNHJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 03:09:47 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2075.outbound.protection.outlook.com [40.107.92.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 609763AA7;
        Fri, 14 Apr 2023 00:09:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LYRjGuQf5Cz9tNKLuCZ1Klm5anTrRl4TyYQfgY2nJWAXElBNW7YRSb3ExAZJI0SCDTbfK0JdPv+ooJyA99xViqNSzZFrV67fk1C/5cZsRjl2YWn8O2kCJ4EN9yqCoC/kWYK0LF9jXq2USrOaGkI8ZPowMLGkefN1Pa9tzLSq1zFnhOEFptxELugHO6/hQqiyJ2T6qLGU62+ZaDikA26zLvaM3l3uDMn/mARLV0gXVWnBybK81kEw6pi5ns/weEd6pm7H8x6byU+lRGqgNr4SpVoz0GGKKkbiOZKRE+wsMbedYjidd9oOLkAQOP2mm03s80fLupPpQ9ITOF8b/nym8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IMQ3PhHJI25H6Em/DH9zKDqT1YGSuN67l0wCj3wEWM4=;
 b=b3c3oRnevDeShvM9Kixik1TlmzdT3WHCfuHv32lebRdRKmyd0ilVRCN+ff5chFY8dGrggRtE5JmsMaEMIRz6iB3nUrAn5KTH7o/ck0PN67BYXUyCBWC7QwAv8B2cVNA/8lwJ+0QGPL8thk+qZIznhvZ8SR8aWov+gTvB8DOMRzOHgh5ui6Tic5HXRjUcIeVlZ3HsDXfRBvMq4nVhfIxpmun24LWNOzZBK7qhy+LtnDIp+sp4hKQwC/b3MO+pxAHp3+U5gaCTMm7PVDWK6WnHSgu50eF6uroqz99xv6x+qSsz/TxeNhmtqzRk2Vu5Omyzzq96OsMO8fNDJ2ADSFYSVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IMQ3PhHJI25H6Em/DH9zKDqT1YGSuN67l0wCj3wEWM4=;
 b=DE1l75RwcOO58NWMB17rpXKPu8cR77UvUE2nZGIR9wJF4H95QYnl+caof5VEDXvA/O/3nLCeZm+pW9b164nsH7CT/BX5aBImYMv6LWbg66kCcfH1N0vPk1TFEOOgU+8qIVhS7dWIItovlW9eVCGKOSJkphPmCU1wTA3Yen/xlU6+aLK7B5bdVJ4cprd9y8kMNZdts6Apud0Cf76nqqOnDfjrY1BZ/uFTQ4YWINjlhc891MiTjdTAGg+W8s0btJKPn7/byBOU/lIE6ZEveUBebt5z86vNcrsXU1BUdizwEQ/qtav924HGwBZlCEwBd39Xhz6Cf/1XYU6hCUpKHH1e/Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by DM4PR12MB7599.namprd12.prod.outlook.com (2603:10b6:8:109::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Fri, 14 Apr
 2023 07:09:44 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::f6e3:c3af:67f9:91e9]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::f6e3:c3af:67f9:91e9%7]) with mapi id 15.20.6298.030; Fri, 14 Apr 2023
 07:09:44 +0000
From:   Rahul Rameshbabu <rrameshbabu@nvidia.com>
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] HID: shield: Initial driver implementation with
 Thunderstrike support
In-Reply-To: <nycvar.YFH.7.76.2304131705350.29760@cbobk.fhfr.pm> (Jiri
        Kosina's message of "Thu, 13 Apr 2023 17:07:00 +0200 (CEST)")
References: <20230410170840.16119-1-rrameshbabu@nvidia.com>
        <20230410170840.16119-2-rrameshbabu@nvidia.com>
        <nycvar.YFH.7.76.2304131705350.29760@cbobk.fhfr.pm>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date:   Fri, 14 Apr 2023 00:09:32 -0700
Message-ID: <87a5zbhrdf.fsf@nvidia.com>
Content-Type: text/plain
X-ClientProxiedBy: BYAPR11CA0087.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::28) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|DM4PR12MB7599:EE_
X-MS-Office365-Filtering-Correlation-Id: a32cfe84-6791-41c1-0c3c-08db3cb73924
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 10kZwocLwPN7hccbvtzUUVt9EkEhCGMdT/45Z1nzTDzjD3s8B80Pv7856XiyA1u0KEJ8qZYLChjatu/gtsd4SZfCiziiKe3DkUpIwBdKTq4AKYVD3GsWS7b+aeDpHn1bDrqNSSYTSRa+3NhfGydR0RpZcC4xWXkZJ4tVsdx+pc6D6xdko5ALojMJdi6+yIW+Weort6yf8QPnoJ8Gt5CkoLra/fpPp9XxzifnqQ73mHk/2efQXZIqkqVJuFPMb2govK3BHbRsvEXGsD3qW0OqDd83vNZrheHBzl13kjIfX3Enz5xI43vCSHEVmBuS9zMmxqOcrawKwdbgAsWRs8oFZzX0vPi5Jqykcan5j6kaYDAYBIYTC34rqhi/zep7nBuZZxEPGvWxtUvSDJi93Ne1+I1zWF6rzFz+gRsuIt1MHyBH0S968nbX7ZwB0ZKHHqEpXnP58/2BEtUGsTkJoSxCt6HU58q71hbLPGQZVbr8C2hNK0k7UysfDeOal+Cu7Z0+E5aHW8E5x8F0DeYAC8NiQG2gers75xsjZwi/Gg/qBs0M929VlbjQZhLqTAZ6zkXN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(136003)(346002)(366004)(396003)(451199021)(6512007)(26005)(186003)(6506007)(478600001)(2906002)(8676002)(8936002)(83380400001)(41300700001)(5660300002)(2616005)(38100700002)(6916009)(316002)(4326008)(66946007)(66556008)(66476007)(86362001)(6486002)(6666004)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?b/76MLpCpPu3MpPaPqUICCB1Mg+NhGL5QDyeQ8zzXQmo/RYnO2MvmrHzUoPT?=
 =?us-ascii?Q?T3jRevv/J7/LCbmbWXtUDVC6sihOZZO0pzwSv1xIEcXmHCBCfrjOtgvdMLBA?=
 =?us-ascii?Q?/zChVce1B0B5O1iuxV43ooBZezblWzyzksQBmfPMaq2Gb47mZTRrx5kn1ebB?=
 =?us-ascii?Q?ZwfCAT181Oh07+yRPM5hC0UAUnQNa6Z0avH1b4WXKiG0Ka9QGcmFcS2QxpuA?=
 =?us-ascii?Q?QdWjS0Bf2PMIFpmaegDl9EqIckUYLO+mm8bN+Zm1tiTY4TrDE2wjy+EPlk9K?=
 =?us-ascii?Q?ozARL8b60c8j2MTdJ5nQ5MyBqUsihBKqTiyuQuI4SX8XrxqtutP3Z51Za8cZ?=
 =?us-ascii?Q?65bH9zqsORqXFieTpHJz4a2kh8Brs2O0V+kwEFc7+mRomEyco6z0dnN8nTqh?=
 =?us-ascii?Q?ZPObq9STCSYp9wWZXMAQWTu5WRecTdKGx16FczKczAddlXAWrF4Ah5GwLQ2Y?=
 =?us-ascii?Q?4Pnn0IRt4AljO+QA7fzQCyjo4NeQcNGzn+waazA63UGnu7h27Z320qz1A+Id?=
 =?us-ascii?Q?vlK1dbBJlbNkblICsmDG0GAixpizx77Rx3vOZ3Uc0nwy+OnCKXCZOhWyreTF?=
 =?us-ascii?Q?KEtXLZ3JEIw1eMCeenOEfkrva5kZ/oqjZorKjCXP8vaR/qAOhZ+Q9RtTBFP6?=
 =?us-ascii?Q?6GXTjBE7aVRrGDLy+Hazy8q2RNLX7BdjngrSzA82/MaIDo2nHGcUVUbO6C5Z?=
 =?us-ascii?Q?hDn/UaLE9ieHFkdT13mwJ/kddq7M3Yr0SgjbLgcur4T7jJa7vPv5Iu9lllGu?=
 =?us-ascii?Q?XHNSPkg/82zEV5VpHlvnudCcqCrIugho70TsBSLy7brSa3qS84HIJQOa9kkL?=
 =?us-ascii?Q?hAHZWIJ86Zwh4m1K0iCwG22u+roE4e6oaFb2tWr4tijP4fHUQjbK/S8NK+g4?=
 =?us-ascii?Q?twzKk52pI0Rv/dN7Lp5xFsaIQbmIypb8+ci0PL6sYDdI6y41q01svkqSDR39?=
 =?us-ascii?Q?SNvvP2MYRz6jGWJ3VAOggJ5wxIxFNB/zIwn9bDpxabPhyrau+qHWRjhm4hyM?=
 =?us-ascii?Q?h/z02QOtTrhqHvSLgLaFnM4h3p24fbD9XMMg4VSoZjYlv0uOaROXbKe4SiIi?=
 =?us-ascii?Q?cBspkGx9BmkKpzLSf5bZVL/eN9qL8fbQmvQPAQuUVcTLFF0KMxulJYbCUP8g?=
 =?us-ascii?Q?KFzUF4uOFIC8EBXdmJMfsGXXSucDzr+JUH4CAIc55bfwCTfiHCkHvR3df0m6?=
 =?us-ascii?Q?84ZWlhKEjmn74WUtD0lW1YGQavs2195IBY894GrXqJffMIg0eK4UR2gMIeFW?=
 =?us-ascii?Q?S+XiEwkmi0UdyMuDE/gYfSMkuzOpnyHyYzw0Xt52NJ/sXwuxjhgvxFdZGiAo?=
 =?us-ascii?Q?9YTyDSIE8gR72fzuXdUT/7FBg/7yJgBv7BVCxAbxBKYM7Dlns66VtZXFx+YY?=
 =?us-ascii?Q?7Oh3J3oRlirHI8o/bCQYxUNIy4aH/JgcsIVRrCD9EnbKoLR+Vd6IXHBJIjgm?=
 =?us-ascii?Q?wsFUBuXLATmfUT6EgW1Fy5FBMGL8FTnhi3FK8njfLa/Uerfb8zRFzwL+4yem?=
 =?us-ascii?Q?lNbR8F6/q8Fn2JHwZNF2+387I8deWdqvxP0lZbytDArqFL+obfa3JYmbLoPh?=
 =?us-ascii?Q?GC48nxbjmrhdBpsxUyqC2EtZlKfQ+9YHWwEE0M7ieL0oW7Nd7DmYpEGCpZKY?=
 =?us-ascii?Q?fA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a32cfe84-6791-41c1-0c3c-08db3cb73924
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2023 07:09:44.0586
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cBSYvFYWWs5hJ0BNcJiDoSjuJbxC/PPmLOY5ecPVjOO95T61lCa0hTs3+sUMJSADq+XfgJdCuYzUSukFMfzDUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7599
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

Thanks for the feedback.

On Thu, 13 Apr, 2023 17:07:00 +0200 Jiri Kosina <jikos@kernel.org> wrote:
> On Mon, 10 Apr 2023, Rahul Rameshbabu wrote:
>
>> Supports the Thunderstrike (SHIELD 2017) controller. Implements support for
>> the Thunderstrike HOSTCMD firmware interface. Adds sysfs attributes about a
>> SHIELD device and introduces haptics support for controllers.
>> 
>> Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
>
> Thanks a lot for submitting the driver. I have one minor question:
>
> [ ... snip ... ]
>> +thunderstrike_update_haptics(struct thunderstrike *ts,
>> +			     struct thunderstrike_hostcmd_haptics *motors)
>> +{
>> +	unsigned long flags;
>> +
>> +	spin_lock_irqsave(&ts->haptics_update_lock, flags);
>> +	ts->haptics_val = *motors;
>> +	spin_unlock_irqrestore(&ts->haptics_update_lock, flags);
>
> Do we really have to disable interrupts when taking haptics_update_lock? 
> Is it ever being taken from interrupt context?

The reason why I disable interrupts is because I call
thunderstrike_update_haptics from the play_effect callback I pass to
input_ff_create_memless. From there, it is used in ml_effect_timer
drivers/input/ff-memless.c, which is a timer interrupt context so we
should disable interrupts when taking haptics_update_lock.

  static void ml_effect_timer(struct timer_list *t)
  {
    struct ml_device *ml = from_timer(ml, t, timer);
    struct input_dev *dev = ml->dev;
    unsigned long flags;

    pr_debug("timer: updating effects\n");

    spin_lock_irqsave(&dev->event_lock, flags);
    ml_play_effects(ml);
    spin_unlock_irqrestore(&dev->event_lock, flags);
  }

Let me know if this seems off.

>
> Thanks,

-- Rahul Rameshbabu
