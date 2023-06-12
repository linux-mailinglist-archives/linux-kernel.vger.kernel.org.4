Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E3C272BF5A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 12:42:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232256AbjFLKl5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 06:41:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231204AbjFLKld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 06:41:33 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 350AF319D6
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 03:25:53 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-51b4ef5378bso2806229a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 03:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686565543; x=1689157543;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iMnNoTCuZfel8amFbSTUxxwKPaBvxjJNJh4C0Qnn6hk=;
        b=i7mL1d80g/JXGdpILDUxbA10HUt2ReMbJ3U4ba9yLqvDwn3nDTK8KiLT5tphL3OJbU
         TL4RQ0eM45axl6bwoBS2zhORCysIxFNKHUJkEhtHjxVWDaVz4YysA21f+rX5jIZH/dsP
         4feZLgEPzJJWw64eTxM3vA3d2tSblhpmD1Moi58/M5v6yOrrTWLUBcMMDoOAaBqd8BMz
         q6HTpIIVW08tF3bwWihfns82Mi0MZmwStgRpbvuOrQXZWMSpoGpJF7tT+Qu/S/xaiabQ
         ywj7U2Kl+qNIZsSx/wlfXLWhYL7Ik0PJgNwmd+ZVJtPk8q2RvMNntqstm9LvwEVPWyGW
         0YXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686565543; x=1689157543;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iMnNoTCuZfel8amFbSTUxxwKPaBvxjJNJh4C0Qnn6hk=;
        b=V48rN0ZDHoB/f2eG65dzALWR/2EEXBeNMtywGOxbaveQIn0KMRT40YzA9b6AGb3y2V
         AkOkFWNSW4XRm3rFXua3Ql669ho42V2FRKmQUpTatFZoYttEd7XULi2aNgTPu/EWCgn7
         ZF6S6fZOP+alN0O/G3RALOaYhyk3sYuFyvIKnEE3SYKGq6BXnkISFGOFb/iONZZ4e0wS
         veD4I/5ZgaezF+9yO2uF0DjFN1cZrPlQ1mIjepGGLOwLr68PwnLLeU5eFRwzCGu0oRIi
         YLCBmrsYvdQwajg9FWpt1JS7w7o5EtlchyX86vViHNRxXHEk0NO4Je+UQh5byUXGFRzo
         ac5Q==
X-Gm-Message-State: AC+VfDzq3Sv8tlBQMXLoadt6/IPsa7Q8RDDeDR/a1peg8YK2rprhT40J
        9h4wYh9NFYrPScOFalzimta9bQ==
X-Google-Smtp-Source: ACHHUZ7vr2Sb/VrxeuRSU/zkdi+fwgLM95jBKLP8RyrWo+b0yzuj4avNzR7Mbo3sLB8yejlIkXIvkg==
X-Received: by 2002:a17:90a:4c:b0:25b:cb3c:b5ac with SMTP id 12-20020a17090a004c00b0025bcb3cb5acmr3995793pjb.6.1686565543531;
        Mon, 12 Jun 2023 03:25:43 -0700 (PDT)
Received: from leoy-huanghe.lan (211-75-219-201.hinet-ip.hinet.net. [211.75.219.201])
        by smtp.gmail.com with ESMTPSA id pt1-20020a17090b3d0100b002500df72713sm9077644pjb.7.2023.06.12.03.25.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 03:25:43 -0700 (PDT)
Date:   Mon, 12 Jun 2023 18:25:37 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Shuai Xue <xueshuai@linux.alibaba.com>
Cc:     alexander.shishkin@linux.intel.com, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        jolsa@kernel.org, namhyung@kernel.org, irogers@google.com,
        adrian.hunter@intel.com, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        Baolin Wang <baolin.wang@linux.alibaba.com>
Subject: Re: [PATCH 1/2] perf/core: Bail out early if the request AUX area is
 out of bound
Message-ID: <20230612102537.GF217089@leoy-huanghe.lan>
References: <20230612052452.53425-1-xueshuai@linux.alibaba.com>
 <20230612052452.53425-2-xueshuai@linux.alibaba.com>
 <20230612073821.GB217089@leoy-huanghe.lan>
 <5fe7c14e-4dd4-3e7f-ece4-75da36c3b6c3@linux.alibaba.com>
 <20230612100502.GE217089@leoy-huanghe.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230612100502.GE217089@leoy-huanghe.lan>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 12, 2023 at 06:05:02PM +0800, Leo Yan wrote:
> On Mon, Jun 12, 2023 at 04:35:07PM +0800, Shuai Xue wrote:
> 
> [...]
> 
> > > Furthermore, I believe the AUX trace pages are only mapped for VMA
> > > (continuous virtual address), the kernel will defer to map to physical
> > > pages (which means it's not necessarily continuous physical pages)
> > > when handling data abort caused by accessing the pages.
> > 
> > I don't know why the rb->aux_pages is limit to allocated with continuous physical pages.
> > so I just add a check to avoid oops and report a proper error code -EINVAL to
> > user.
> > 
> > I would like to use vmalloc() family to replace kmalloc() so that we could support
> > allocate a more large AUX area if it is not necessarily continuous physical pages.
> > Should we remove the restriction?
> 
> As you said, we are now able to support a maximum AUX trace buffer
> size of up to 2GiB, and AUX trace buffer is per CPU wise.

Ouch, I reviewed my notes and correct myself:

For per thread mode, perf tool only allocates one generic ring buffer
and one AUX ring buffer for the whole session; for the system wide mode,
perf allocates the generic ring buffer and the AUX ring buffer per CPU
wise.

> Seems to me, 2GiB AUX buffer per CPU is big enough for most tracing
> scenarios, right?  Except you can provide profiling scenario which
> must use bigger buffer size.

But I think this question is still valid.

> Another factor is the allocation of buffers from kmalloc() offers better
> performance compared to allocation from vmalloc(), this is also
> important for perf core layer.
> 
> Thanks,
> Leo
