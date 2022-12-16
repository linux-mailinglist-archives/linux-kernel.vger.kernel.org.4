Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08EB864E756
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 07:42:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbiLPGmS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 01:42:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbiLPGmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 01:42:15 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A4DF2648C
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 22:42:14 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id b4-20020a253404000000b006fad1bb09f4so1639698yba.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 22:42:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XbFQZVTv5eoAtvU5UO3qEMDwUg37kVn93aA4beZeXOE=;
        b=B32cHry/4db6r8sIjGaaLfuU0IK0V3s+UWwxhGQIzjn8H6E1sPDMIkVCy5aN9SvEEq
         SI041R1yGhw0bPemMxjdJ4WeIlIjgnc4Iv2n7/L/aqNu8BjScCof2ddh4dUeHGUKf+Fo
         kE8VwjolKR941fjOukS1XC5GirXDUPBb8MEjV6dd4ywVMzxDmRV/Qz2VptcOQcl1mnRx
         EONXcoDKoG/kql8Dsanzyfg6PgV0gfysCi24+eCBKq1Y9oQsIVlfwa+yg2LW4d3cnWI7
         j3U6gpeswWqCwk8G1ngtDTyF056OceX2oW3U94LhrzSMfB0BGyBDYsg5DOWcBsSeG/eZ
         W07g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XbFQZVTv5eoAtvU5UO3qEMDwUg37kVn93aA4beZeXOE=;
        b=DgyBLLTrGyl+5Bo3LP5TKb1FaceVSz9Azudjju5boZ4iwjctS8NN9bi6HRxUqkxEKr
         FeaMgjNGWGsgZuBPDxdXEmUwkFbTriGyhSF3gHaAXZQpcx8sxqV7VJbzPM+iAdZaHa0Q
         IlttQ/iLXYmqt+OKXEw2FgPCGV+fJo+uxZBbmasUR8NSlabO6t8cL0UPupgQzEXgEK8g
         W0U5MGk1qk8Qeqd5S8TRMeYa2CDJc2YOH5U68myLHE8ulNfjufgKPHuH0lqA+nOSvWMG
         cXlvb+m99nMFAS3+mWTF+U1cm+U0ktKkcVvPp0T/f6kbI/hEXY4IV7QnK0jqdrqClWCr
         1a1g==
X-Gm-Message-State: ANoB5pndBXkE97yax0caTLWKsSDrIW2bjcnnaSDZdjkYEgXviKhXUDXX
        DFJdRXYYEF8EAlvJqTXH6l+pM4sGfs127Q==
X-Google-Smtp-Source: AA0mqf6iZOfNJ13UnO5fRuS8zsnd4vEiiBfyWq8+nBNy+R0Sxc903uGk1DXEC+ZSnfjeurRKErAiBsUFND2YLg==
X-Received: from shakeelb.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:262e])
 (user=shakeelb job=sendgmr) by 2002:a05:690c:c98:b0:3ed:d236:5845 with SMTP
 id cm24-20020a05690c0c9800b003edd2365845mr20036200ywb.498.1671172933100; Thu,
 15 Dec 2022 22:42:13 -0800 (PST)
Date:   Fri, 16 Dec 2022 06:42:10 +0000
In-Reply-To: <abec13da-c74a-0fd8-74e0-3cdc547e4e08@shopee.com>
Mime-Version: 1.0
References: <20221215091907.763801-1-haifeng.xu@shopee.com>
 <20221215181803.ome46pkh6g7qu3t4@google.com> <abec13da-c74a-0fd8-74e0-3cdc547e4e08@shopee.com>
Message-ID: <20221216064210.krxtxebuwc7dijzu@google.com>
Subject: Re: [PATCH] mm/memcontrol: Skip root memcg in memcg_memory_event_mm
From:   Shakeel Butt <shakeelb@google.com>
To:     Haifeng Xu <haifeng.xu@shopee.com>
Cc:     akpm@linux-foundation.org, roman.gushchin@linux.dev,
        songmuchun@bytedance.com, hannes@cmpxchg.org, vbabka@suse.cz,
        willy@infradead.org, vasily.averin@linux.dev,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 16, 2022 at 09:43:02AM +0800, Haifeng Xu wrote:
> 
> 
> On 2022/12/16 02:18, Shakeel Butt wrote:
> > On Thu, Dec 15, 2022 at 09:19:07AM +0000, Haifeng Xu wrote:
> >> The memory events aren't supported on root cgroup, so there is no need
> >> to account MEMCG_OOM_KILL on root memcg.
> >>
> > 
> > Can you explain the scenario where this is happening and causing issue
> > for you?
> > 
> If the victim selected by oom killer belongs to root memcg, memcg_memory_event_mm
> still counts the MEMCG_OOM_KILL event. This behavior is meaningless because the
> flag of events/events.local in memory_files is CFTYPE_NOT_ON_ROOT. The root memcg
> does not count any memory event.
> 

What about v1's memory.oom_control?

