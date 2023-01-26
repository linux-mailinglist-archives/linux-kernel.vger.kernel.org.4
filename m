Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 216B867CB13
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 13:46:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbjAZMqm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 07:46:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbjAZMql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 07:46:41 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AB7C65F00
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 04:46:29 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id kt14so4763976ejc.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 04:46:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+a/Cr2fpsCIFchjkO6sVEwm8g+0ParyfTabMfmyS1Tw=;
        b=mpnuVBCCQHafgxEXum+E8lw/YLZV1TQAU7UQMNVBePwwrspPsd/DJXxrrApIEDVjki
         O37VHoJv7oLtFGySNznAxQ1PdL/Zamzd9flVsfeDBM2bIneJWkwDG0T+pMhsvtnd2ZYo
         yZf6yIpkyFJsb4oYLQWqMi/wwAwnLfBZpv53M3FahDu6xQUkZ5DCgQSc96Lb/HHoX/w5
         HylCELOO17X1pr9uo7fz93Pi1ME7c9FGq2B5r/ogXEn/fRChWjlklhB4OGRcnKZks5LD
         rKwI2Wd9gmmp5hk4ENS4YMKYFjxw+YC9DUS6XXoi5grPL36Vsusj27/0HJoHYc9DbHJe
         mWCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+a/Cr2fpsCIFchjkO6sVEwm8g+0ParyfTabMfmyS1Tw=;
        b=ixc4nNCxbnnnDukopu48mxD0YuN0LLGCe+ev7zrzWq9Kv3kJc5CexKwe/oGnNigC93
         0AGc6lFCgnkRN/SwSBkqFrBosgHpiVOyp2yrbFkX4vJrkqMP8gDoJGhmNYuxnTQao7bf
         6hSNs7glcIiNVAEeQhrIdLrE2osQn9jgaKgdCM/CcsDFOvSgMtf6hwPBZWsWjWHOx7S2
         4MKyeh09pIqewk+hc6Yj+n/uEfGDKnA7zGQ8VDNVN8Flehyt3vH7E1bAB5iFAzeaW9kZ
         19W/4Gw+tEbubYu//Kr8gRgqMj6XgUa/j766K43qKVRZydVd2dQt5Q72bH8E8E8EHPgT
         Q0EQ==
X-Gm-Message-State: AFqh2koz87NSVRzM8O2FPkK2RwA1iQeFptx4jHnd/wgTy11uVmXj6Hix
        Vv81ZB4GM+ZYRgt2/8iH/qfUTigyL9g=
X-Google-Smtp-Source: AMrXdXv4zUM1tkja27ILz+JI/RJ3sUqNAGeUoF9OSG76CeUo/cq2/nk/nIoy9SNHjuQ2k+w3h4mafg==
X-Received: by 2002:a17:906:415:b0:7c1:2e19:ba3f with SMTP id d21-20020a170906041500b007c12e19ba3fmr50220572eja.57.1674737187598;
        Thu, 26 Jan 2023 04:46:27 -0800 (PST)
Received: from gmail.com ([31.46.245.95])
        by smtp.gmail.com with ESMTPSA id e22-20020a50ec96000000b0046c5baa1f58sm662376edr.97.2023.01.26.04.46.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 04:46:26 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Thu, 26 Jan 2023 13:46:22 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        linux-kernel@vger.kernel.org, john.p.donnelly@oracle.com,
        Hillf Danton <hdanton@sina.com>,
        Mukesh Ojha <quic_mojha@quicinc.com>,
        Ting11 Wang =?utf-8?B?546L5am3?= <wangting11@xiaomi.com>
Subject: Re: [PATCH v7 0/4] lockinig/rwsem: Fix rwsem bugs & enable true lock
 handoff
Message-ID: <Y9J2HkiyLDmGPWyn@gmail.com>
References: <20230126003628.365092-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230126003628.365092-1-longman@redhat.com>
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Waiman Long <longman@redhat.com> wrote:

> v7:
>  - Add a comment to down_read_non_owner() in patch 2.
>  - Drop v6 patches 4 & 6 and simplify the direct rwsem lock handoff
>    patch as suggested by PeterZ.
> 
> v6:
>  - Fix an error in patch 2 reported by kernel test robot.
> 
> v5:
>  - Drop patch 2 and replace it with 2 new patches disabling preemption on
>    all reader functions and writer functions respectively. The other
>    patches are adjusted accordingly.
> 
> It turns out the current waiter optimistic spinning code does not work
> that well if we have RT tasks in the mix. This patch series include two
> different fixes to resolve those issues. The last 3 patches modify the
> handoff code to implement true lock handoff similar to that of mutex.
> 
> Waiman Long (4):
>   locking/rwsem: Prevent non-first waiter from spinning in down_write()
>     slowpath
>   locking/rwsem: Disable preemption at all down_read*() and up_read()
>     code paths
>   locking/rwsem: Disable preemption at all down_write*() and up_write()
>     code paths
>   locking/rwsem: Enable direct rwsem lock handoff
> 
>  kernel/locking/rwsem.c | 161 +++++++++++++++++++++++++++++------------
>  1 file changed, 115 insertions(+), 46 deletions(-)

So as a first step I've applied the first 3 patches to the locking tree, 
which are arguably fixes.

Thanks,

	Ingo
