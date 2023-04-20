Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 512596E9239
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 13:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234261AbjDTLQB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 07:16:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235620AbjDTLPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 07:15:19 -0400
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2883816DF8
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 04:10:26 -0700 (PDT)
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-63b4bf2d74aso755409b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 04:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1681988912; x=1684580912;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j9YMorYZCe7b34lf9uVJ+ykw7vorvXBBMkd1pEzu71I=;
        b=XQewu1XWuAZKv0wPt156pIH2QIKEk3qFSesrRHuajbc8IeZurlVYIJbEa4/mTCgrB6
         cGWgnu39+41vQnC6cf2ETiIA2oiUkFNe7pOFLA2gh4FcD+0lV3rVIhevgsB01W5qvZoF
         xD2pmhoOPNJ0Pv7cSrggFIalEsOkEPv22sxkXzOXldJSBj44Cq6AXSl1eM1xyBTxJ4dA
         wSqU+YKe9LowILdMRQUrFztmRKnT2ag5fuXasNfRkk3AAmjFiR2mvsFtgF7cB1bTktkr
         YLDWMDKBZ8EZfvGx2AQCdUK113RJo4VUAigEaCcjTwjhAtnjyDk1hEKZrjcDMA3txVWw
         G0hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681988912; x=1684580912;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=j9YMorYZCe7b34lf9uVJ+ykw7vorvXBBMkd1pEzu71I=;
        b=bdhtkXwmsMoqwUzinPsjXMJQGq66pquetiFUKT9aPE70dbc+Xl8feh+NaJm8HZcch1
         WJgaU9sRStxuY+dd+/hfCSwTaeWM2CTEO1sVohxq1TCvir0UHlOUYqzZUlgcm93CMMYO
         ph4xFg9WsmzGKnSuhdnETh0V2wGf0Z2YDGC89EpfIXn2lqT7et3LbEt7w56bw3QJhX1f
         DTDur8fuARTeX7Cc2zlBPzJyJJEwR4qjdmFE74QD1k9SorTQI8KIrhaMvcClg2Gj4qyh
         Y1gXlBt7DZVl+5kr0f+OV8E0/Jb9CqhAqjZHZrsGtpXvIUg5S6GMnN2fbxLMJxRPrlEf
         p0yQ==
X-Gm-Message-State: AAQBX9f13aSpOtblU9QLHrcge1y04QIcbqMmDNce7vSRY80SeC2gXm7A
        Y1lMgiRqvQd89YUTtShH2QlvTw==
X-Google-Smtp-Source: AKy350YLF0N8SDkeEgp9uSCISx93bvsVjkVuAmd33nv4E9x6/tIlcAVna4osWq+f44tXvIwb3zjbTQ==
X-Received: by 2002:a05:6a00:1ad1:b0:63b:89a2:d624 with SMTP id f17-20020a056a001ad100b0063b89a2d624mr1079030pfv.12.1681988911678;
        Thu, 20 Apr 2023 04:08:31 -0700 (PDT)
Received: from [10.85.115.102] ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id g9-20020a056a0023c900b00594235980e4sm1009027pfc.181.2023.04.20.04.08.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Apr 2023 04:08:31 -0700 (PDT)
Message-ID: <658fe430-320f-5f4f-2011-9e1bd11d772c@bytedance.com>
Date:   Thu, 20 Apr 2023 19:08:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH 0/2] Fix two warnings about rq clock
To:     mingo@redhat.com, peterz@infradead.org, mingo@kernel.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        mgorman@techsingularity.net
Cc:     linux-kernel@vger.kernel.org
References: <20230410081206.23441-1-jiahao.os@bytedance.com>
From:   Hao Jia <jiahao.os@bytedance.com>
In-Reply-To: <20230410081206.23441-1-jiahao.os@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kindly ping...


On 2023/4/10 Hao Jia wrote:
> These two patches fix two warnings about rq clock
> 
> Patch1 fixes the warning of using the old rq clock caused by
> missing update rq clock.
> 
> Patch2 fixes the warning that the rq clock was updated multiple
> times while holding the rq lock.
> 
> Hao Jia (2):
>    sched/core: Fixed missing rq clock update before calling
>      set_rq_offline()
>    sched/core: Avoid double calling update_rq_clock()
> 
>   kernel/sched/core.c     | 11 +++++++----
>   kernel/sched/fair.c     |  9 ++++++---
>   kernel/sched/topology.c | 10 ++++++----
>   3 files changed, 19 insertions(+), 11 deletions(-)
> 
