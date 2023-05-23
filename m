Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F3C170D60C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 09:53:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235797AbjEWHxo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 03:53:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235795AbjEWHxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 03:53:37 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F75ECD
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 00:52:55 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-253e0edc278so2551311a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 00:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1684828353; x=1687420353;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=biZznb0Xm/1DWPiuZzuhHeJPwNpmTYnggMdIxod5k6A=;
        b=CjmJJ502dj5MxpnI+/+7GZ1YGXKQlrMLkGIlJx04OsOP+BZxvhn1bIM1xLN2msTeJG
         SOxDMSKfqu0K3V0dj+2gF7GrDSlHSOyQkGHctpYFHaz3X/PQ+7dNS89I00JUyr7GMHs+
         u7JGYamJ2WthHKg82/toPPtFvJeDgmGJnJBGpgZ79I1bPwwsJTqHoM9uzcZbCScD3i4R
         ZVsskzS9VANaBunSn4zZXzdmXT8gIWE8D4TzIrIYE7mBI52qNVRGLIIKNRfI+qfEPveW
         qNdtlNg6gcdq66xsP6ta3kS+kQPXKpvUDVlPGMNUZ4hYZ1Z2dKoo60S7B9++a5IG+AsN
         CTnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684828353; x=1687420353;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=biZznb0Xm/1DWPiuZzuhHeJPwNpmTYnggMdIxod5k6A=;
        b=Ga2HUVTnufo27MSB23vWWB63qm/ZokvqhI2As6GgcKWd5y6LMAaLj8ZTa+3K+zWXXT
         keeDTuZm+st9hIwVEuLcfFeuChr/X7bmANMpOjaR4rrRJeDXpqsoHzzhT7e/26cceNOD
         nzIRzSabJa3rOuNR8QcgodwHQo8gWM5NdgVAstxvNxeQk3p0r07HnakhuExSXWy/t33I
         igbysgwKpvhF+XmSykzzVy2InQ9qVUilKNur1EoUy28rSoMgU5UdLuCePRcCffHXPCDn
         WqThuEgrecC2ueTWHsSmlTTKROXKQQRVxFRnl8jLBIp7JOtQ6jEEFKpYhy7B4vr9gf7K
         1CUw==
X-Gm-Message-State: AC+VfDxVeeHqxwCxBQKd2Pd+PoBLee0YburaABHYRgWmfV5qPLVCcazf
        De0ok0JJFAZgXtqjBWlsSRpACQ==
X-Google-Smtp-Source: ACHHUZ6GWkFoVFClX9gWH+TJaVR7Jyz0WLL/88XuhJopenRTtkC/LpdAuZ29qrHjstFWpYBoTSd4Uw==
X-Received: by 2002:a17:902:d34a:b0:1a9:f425:5409 with SMTP id l10-20020a170902d34a00b001a9f4255409mr10452296plk.49.1684828352822;
        Tue, 23 May 2023 00:52:32 -0700 (PDT)
Received: from [10.85.115.102] ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id x4-20020a170902ea8400b001a1adbe215asm6088809plb.142.2023.05.23.00.52.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 May 2023 00:52:32 -0700 (PDT)
Message-ID: <a67af05b-8386-f4ec-c5da-623ce30032a5@bytedance.com>
Date:   Tue, 23 May 2023 15:52:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH v3 0/4] Fix some warnings about rq clock
To:     mingo@redhat.com, peterz@infradead.org, mingo@kernel.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        mgorman@techsingularity.net
Cc:     linux-kernel@vger.kernel.org
References: <20230515063848.77947-1-jiahao.os@bytedance.com>
From:   Hao Jia <jiahao.os@bytedance.com>
In-Reply-To: <20230515063848.77947-1-jiahao.os@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kindly ping...


On 2023/5/15 Hao Jia wrote:
> These four patches fix some warnings about rq clock.
> 
> Patch1 fixes the warning of using the old rq clock caused by
> missing update rq clock.
> 
> Patch2-4 fixes the warning that the rq clock was updated multiple
> times while holding the rq lock.
> 
> v2->v3:
>      - Modify the commit information of patch1 to make the description clearer.
>      - Split v2 patch2 into 3 separate patches.
> 
> v1->v2:
>      - Vincent Guittot suggested using rq_clock_start_loop_update()
>        to prevent multiple calls to update_rq_clock() in unthrottle_cfs_rq()
>        instead of removing update_rq_clock() from unthrottle_cfs_rq()
>        and updating the rq clock before unthrottle_cfs_rq() for patch2.
> 
> [v2] https://lore.kernel.org/all/20230510083450.62334-1-jiahao.os@bytedance.com
> [v1] https://lore.kernel.org/all/20230410081206.23441-1-jiahao.os@bytedance.com
> 
> 
> Hao Jia (4):
>    sched/core: Fixed missing rq clock update before calling
>      set_rq_offline()
>    sched/core: Avoid double calling update_rq_clock() in
>      __balance_push_cpu_stop()
>    sched/core: Avoid multiple calling update_rq_clock() in
>      __cfsb_csd_unthrottle()
>    sched/core: Avoid multiple calling update_rq_clock() in
>      unthrottle_offline_cfs_rqs()
> 
>   kernel/sched/core.c     |  7 ++++---
>   kernel/sched/fair.c     | 18 ++++++++++++++++++
>   kernel/sched/sched.h    | 21 +++++++++++++++++++++
>   kernel/sched/topology.c | 10 ++++++----
>   4 files changed, 49 insertions(+), 7 deletions(-)
> 
