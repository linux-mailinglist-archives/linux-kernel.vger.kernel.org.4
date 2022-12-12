Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72D1F6497D8
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 03:06:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231216AbiLLCGc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Dec 2022 21:06:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231138AbiLLCG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Dec 2022 21:06:29 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEC3562C7
        for <linux-kernel@vger.kernel.org>; Sun, 11 Dec 2022 18:05:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670810734;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KcoXdId9+WwBuH+gRgk9EJjde2pyS057yq6y4/z/asQ=;
        b=HV7sX9H9t0xf5vm/DabBzVSqKFg9RzxRUP3yR2dL41QEhgkli3gzn8HEWUSV2wR9n6n3TK
        tmZl0g+JqkrEjsSNUwHPTnnzg7EEjfgw+LSzqfpC87lYNPGiwKhul/vRyvYAdQym99DVWz
        23WCyI/4xk5Tmq7OZ2fYaVc1CwPwiU4=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-53-5Gq4lyCmN4SQWp1IKVUB0A-1; Sun, 11 Dec 2022 21:05:33 -0500
X-MC-Unique: 5Gq4lyCmN4SQWp1IKVUB0A-1
Received: by mail-pf1-f197.google.com with SMTP id a18-20020a62bd12000000b0056e7b61ec78so7230313pff.17
        for <linux-kernel@vger.kernel.org>; Sun, 11 Dec 2022 18:05:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KcoXdId9+WwBuH+gRgk9EJjde2pyS057yq6y4/z/asQ=;
        b=mEsU3UjH/DpIMx3aq/63XUGztmQEfAwpJ2YXA4HdJZMttpAPnXdPisL42pxFzS9qWs
         GwD2ogfhZFJ3Bux2TiBUHlpzOD8zCpfoDK6EInF/sDM674pWD1XWb0UdVvgAiCWuBpE+
         XwIfHz1FTrTKoK5SGKkvNk6mkUdprJT7Fe2EHtbUaYOhaiL7SJNArnTukTmp0XRs7o5U
         5pqZ8CA8Ssr9ltqTTFnwYq/E5388wnxlCkzsX9pMGYn42sRGu1AuWjSIZ12sqq01xQsc
         TvHG0VGc9FjkvKHNLCzLKI4jW9J8Vw8ZoW+OxwnG+Vn14Nic7K4cyTkdFdKIliVlPldt
         FAfQ==
X-Gm-Message-State: ANoB5pmPtlki6u4cpjKMdrM97X4xEqkQqcGMHIeRcEmmHWCRzKENvhch
        Jg/8jsNR0EwocqAJLXIzT3B+0xodVFTpyxO61AdeCPu0t0waQPymjPnHE4xHNveHlGWlHA9O25v
        +oGSOxnM4CEVQARlR0yiQ8suZ
X-Received: by 2002:a05:6a20:8c10:b0:a4:f2e7:3ddb with SMTP id j16-20020a056a208c1000b000a4f2e73ddbmr17958905pzh.36.1670810732448;
        Sun, 11 Dec 2022 18:05:32 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7aCLSEyoJ7BBMHiT3mCrX87K6sPK5IjIUx454Tyd3aJ4b2HlJT4e0NaY+fcVHMckzeWZrVJA==
X-Received: by 2002:a05:6a20:8c10:b0:a4:f2e7:3ddb with SMTP id j16-20020a056a208c1000b000a4f2e73ddbmr17958891pzh.36.1670810732163;
        Sun, 11 Dec 2022 18:05:32 -0800 (PST)
Received: from ?IPV6:2403:580e:4b40:0:7968:2232:4db8:a45e? (2403-580e-4b40--7968-2232-4db8-a45e.ip6.aussiebb.net. [2403:580e:4b40:0:7968:2232:4db8:a45e])
        by smtp.gmail.com with ESMTPSA id o24-20020aa79798000000b005745eb7eccasm4537805pfp.112.2022.12.11.18.05.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Dec 2022 18:05:31 -0800 (PST)
Message-ID: <2d8ac4c9-abeb-6a36-6c96-b14a5a0a2a31@redhat.com>
Date:   Mon, 12 Dec 2022 10:05:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v3 0/5] proc: improve root readdir latency with many
 threads
Content-Language: en-US
To:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, willy@infradead.org
Cc:     onestero@redhat.com, ebiederm@redhat.com,
        Brian Foster <bfoster@redhat.com>
References: <20221202171620.509140-1-bfoster@redhat.com>
From:   Ian Kent <ikent@redhat.com>
In-Reply-To: <20221202171620.509140-1-bfoster@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/12/22 01:16, Brian Foster wrote:
> Hi all,
>
> Here's v3 of the /proc readdir optimization patches. See v1 for the full
> introductary cover letter.
>
> Most of the feedback received to this point has been around switching
> the pid code over to use the xarray api instead of the idr. Matt Wilcox
> posted most of the code to do that. I cleaned it up a bit and posted a
> standalone series for that here [1], but didn't receive any feedback.
> Patches 1-3 of this series are essentially a repost of [1].
>
> Patches 4-5 are otherwise mostly the same as v2 outside of switching
> over to use the xarray bits instead of the idr/radix-tree.
>
> Thoughts, reviews, flames appreciated.


It looks like there's not much happens with this change so far.


Mathew, could we at least include this in linux-next, to see if

there is anything obvious to worry about since we are fiddling

with the pid numbering ... is there anything we need to do

differently for these to be included in next?


Ian

>
> Brian
>
> [1] https://lore.kernel.org/linux-mm/20220715113349.831370-1-bfoster@redhat.com/
>
> v3:
> - Drop radix-tree fixups.
> - Convert pid idr usage to xarray.
> - Replace tgid radix-tree tag set/lookup to use xarray mark.
> v2: https://lore.kernel.org/linux-fsdevel/20220711135237.173667-1-bfoster@redhat.com/
> - Clean up idr helpers to be more generic.
> - Use ->idr_base properly.
> - Lift tgid iteration helper into pid.c to abstract tag logic from
>    users.
> v1: https://lore.kernel.org/linux-fsdevel/20220614180949.102914-1-bfoster@redhat.com/
>
> Brian Foster (5):
>    pid: replace pidmap_lock with xarray lock
>    pid: split cyclic id allocation cursor from idr
>    pid: switch pid_namespace from idr to xarray
>    pid: mark pids associated with group leader tasks
>    procfs: use efficient tgid pid search on root readdir
>
>   arch/powerpc/platforms/cell/spufs/sched.c |   2 +-
>   fs/proc/base.c                            |  17 +--
>   fs/proc/loadavg.c                         |   2 +-
>   include/linux/pid.h                       |   3 +-
>   include/linux/pid_namespace.h             |   9 +-
>   include/linux/threads.h                   |   2 +-
>   init/main.c                               |   3 +-
>   kernel/fork.c                             |   2 +-
>   kernel/pid.c                              | 177 +++++++++++++---------
>   kernel/pid_namespace.c                    |  23 ++-
>   10 files changed, 132 insertions(+), 108 deletions(-)
>

