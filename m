Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC69D61392A
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 15:43:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231668AbiJaOnG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 10:43:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231658AbiJaOnD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 10:43:03 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C4ECD64
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 07:43:02 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-367cd2807f2so109902817b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 07:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=m3rS7ZOPDHRvZr3V/vvpo/qbENUpvRcqo7cok3v2x3M=;
        b=r8LV6uPMuGeqnZjOBbU15rihGbvXAwsvKBQMb/ILfmao522fVg4IoF8LZUv4NZyDe2
         DhsN5OAGOch/lo40i5h940Z3gVaD3a7KbTlMZjYcs8G8R/nulskq60DE0GljodLCnanR
         JtmLOg8rgSNzh04aCRJproQwwZxCnHkkmLOPV7BGDK2p/OCfFburo2y04z0ucphvOyjJ
         P5jcSq3L1lFdAHpPYT7oo1SaSFDp2DDK43jdt5KEXUgnZSCUGabIii5NduLyTMPHNHMa
         Lwun+VK4xq+vsU7k6j/g9wLi81RIB412ACwOnzvEoOmT4kvq8J7bp8e0FSogizDwqlUU
         SBng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m3rS7ZOPDHRvZr3V/vvpo/qbENUpvRcqo7cok3v2x3M=;
        b=1M+bHIndkJXCSpxKpQP7TXZ3la15iMJtJX039+Tdu6VOh25tgmiUKHyCUkq4d0KL6y
         6NKtK9CiVvOK6c/kxQ0iaVo/IBfRU8YJ4N/0vroVxQwXgdPdTQX8TiqeHoMGECfQZEDT
         J89s+xry9d+bf/6HnUljQT1RSJJLaRw/Fp0ozCRjaVJ0Du+uvp6ETN4mqdSZDnHt30K4
         vXTlqV6qnj26CvWTLTSBxPmx0188NforNheaUeEcNU9Shd6TlgtUfdgwrwNZ9EnOVGoF
         QyBuFrAhkMID4s06zmsKcrj0jdC37zN91TeHAjjBWfZ/BRd8x/jIV+semH2AzPFnEHYZ
         KiDw==
X-Gm-Message-State: ACrzQf38BGzTvcogJcYoThVhJZGbM4J1uAFP3fo+yQHOIVGfSieTXrGU
        9elRZxDDbrNB3ZG5M4sNjAf1WptKk0v4qrEhN9WCiA==
X-Google-Smtp-Source: AMsMyM5DQyGKg6pSY2b1b0gOZ/v0deWBiDrpju8x3oHyaZpGOQFE0HG31j7h+8ueNRcBbS8Km9yUVqyXlPRg2CW/5vU=
X-Received: by 2002:a0d:eec4:0:b0:361:3052:476f with SMTP id
 x187-20020a0deec4000000b003613052476fmr12831988ywe.185.1667227381609; Mon, 31
 Oct 2022 07:43:01 -0700 (PDT)
MIME-Version: 1.0
References: <20221021131204.5581-1-james.morse@arm.com> <20221021131204.5581-2-james.morse@arm.com>
In-Reply-To: <20221021131204.5581-2-james.morse@arm.com>
From:   Peter Newman <peternewman@google.com>
Date:   Mon, 31 Oct 2022 15:42:50 +0100
Message-ID: <CALPaoCgxPgJ2MjTu_FDXSouD=nV_5zej1sjebK0i7M7V5SY_=g@mail.gmail.com>
Subject: Re: [PATCH 01/18] x86/resctrl: Track the closid with the rmid
To:     James Morse <james.morse@arm.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        shameerali.kolothum.thodi@huawei.com,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        carl@os.amperecomputing.com, lcherian@marvell.com,
        bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
        Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>, xingxin.hx@openanolis.org,
        baolin.wang@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On Fri, Oct 21, 2022 at 3:12 PM James Morse <james.morse@arm.com> wrote:
>
> x86's RMID are independent of the CLOSID. An RMID can be allocated,
> used and freed without considering the CLOSID.
>
> MPAM's equivalent feature is PMG, which is not an independent number,
> it extends the CLOSID/PARTID space. For MPAM, only PMG-bits worth of
> 'RMID' can be allocated for a single CLOSID.
> i.e. if there is 1 bit of PMG space, then each CLOSID can have two
> monitor groups.
>
> To allow rescrl to disambiguate RMID values for different CLOSID,
> everything in resctrl that keeps an RMID value needs to know the CLOSID
> too. This will always be ignored on x86.

I recall that the allocation of RMIDs on MPAM was an open topic of
discussion on the other thread. Can we finish that discussion first?

https://lore.kernel.org/lkml/14df28f0-90b1-9c43-add5-08947165596d@intel.com/

Thanks!
-Peter
