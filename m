Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E97256A1432
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 01:14:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbjBXAOE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 19:14:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjBXAOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 19:14:03 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BF5132E4B
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 16:14:02 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id o12so7384552oik.6
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 16:14:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TdidChoinEBLrLlt/CurGVixllEMtFuJAvHMgu/NZfo=;
        b=rJDsx+/KQ+i03a6ImfABsae+QTdtjd98soThsy2LfP6SUmtri7cI2gi1zIZhLyyaFp
         m56LuccBFx6Cq5iNXT5DNWK9GA+9k3P9LmrhKZ6Er/ezbCpEID7KfXDp4FWtDFHsSXc2
         RzBrV2O4ELyNK2d4RIrQWKjwDFwtK6XgPYmkxdX9JBCGw0dzxMe5crX7lLq0O/zL8YoI
         04RgXLtgpDvE0LgSRsciv9uO9i3r2kqBoXDRMZjdDFG2XoD2xuOs1PafBMO458WxN35Y
         wyBZ6kTQb1eAejmJVZB7CWidP1uOswaZRaskncBHH5BJqV3AFCDXaHOnRme+5wU6TzMF
         TisQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TdidChoinEBLrLlt/CurGVixllEMtFuJAvHMgu/NZfo=;
        b=TL40UPS+irKvbB9dzcfyUNX/vIUyMQGiWqRuTCJ08ie7iJZE9nprW3qkvLxs/hQo+K
         CM1RpUC4+odulz1widByjqg/wunuTu3QpVNgNx79SNcP1AhAQxYvNtGOB18/9o/kt31l
         wBJBoX0d1TP3X/99Y7IklJ1KYlOda61MJLrEWp2+J6775IQ4tJ25QDfrHsrqJIbHuoIK
         kJAHyPkujHMDBImZinXxgApfUmbHAXFGAAb4TXrxOaI8LsUPefdJ7qKNcXe9x6NL2M90
         h5dg18RdGGxgG++7FqBsVSLsubRh3YyPcgyLtFSIs/zy/xtL1MTBOnB9eE4hPveCLVlc
         UgDQ==
X-Gm-Message-State: AO0yUKXo7GztJsQuzBQLJke1x6K2UTAaxwyaT9CR4Wpg/D/0ASFnkKKD
        UvmLCjwoPOpJuCgo2nUaBsP3RJ+LBoURljCmPrfyLsg7IfviMUA1
X-Google-Smtp-Source: AK7set+Pu785rN2AMAsPyHuytxZFqVMOw3qN483f3LOeHCqNR/vsjJGPUIVlB9AeSPnsU8LhcUihzBkG+wVVr1U+WBI=
X-Received: by 2002:a05:6808:8e3:b0:37f:9a01:f661 with SMTP id
 d3-20020a05680808e300b0037f9a01f661mr525076oic.9.1677197641278; Thu, 23 Feb
 2023 16:14:01 -0800 (PST)
MIME-Version: 1.0
References: <20230208093322.75816-1-hsiangkao@linux.alibaba.com>
 <Y/ewpGQkpWvOf7qh@gmail.com> <ca1e604a-92ba-023b-8896-dcad9413081d@linux.alibaba.com>
 <8e067230-ce1b-1c75-0c23-87b926357f96@linux.alibaba.com>
In-Reply-To: <8e067230-ce1b-1c75-0c23-87b926357f96@linux.alibaba.com>
From:   Sandeep Dhavale <dhavale@google.com>
Date:   Thu, 23 Feb 2023 16:13:50 -0800
Message-ID: <CAB=BE-SQZA7gETEvxnHmy0FDQ182fUSRoa0bJBNouN33SFx3hQ@mail.gmail.com>
Subject: Re: [PATCH v5] erofs: add per-cpu threads for decompression as an option
To:     Gao Xiang <hsiangkao@linux.alibaba.com>
Cc:     Eric Biggers <ebiggers@kernel.org>, linux-erofs@lists.ozlabs.org,
        LKML <linux-kernel@vger.kernel.org>,
        Nathan Huckleberry <nhuck@google.com>,
        Yue Hu <huyue2@coolpad.com>, kernel-team@android.com
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

On Thu, Feb 23, 2023 at 11:08 AM Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
>
>
>
> On 2023/2/24 02:52, Gao Xiang wrote:
> > Hi Eric,
> >
> > On 2023/2/24 02:29, Eric Biggers wrote:
> >> Hi,
> >>
> >> On Wed, Feb 08, 2023 at 05:33:22PM +0800, Gao Xiang wrote:
> >>> From: Sandeep Dhavale <dhavale@google.com>
> >>>
> >>> Using per-cpu thread pool we can reduce the scheduling latency compared
> >>> to workqueue implementation. With this patch scheduling latency and
> >>> variation is reduced as per-cpu threads are high priority kthread_workers.
> >>>
> >>> The results were evaluated on arm64 Android devices running 5.10 kernel.
> >>
> >> I see that this patch was upstreamed.  Meanwhile, commit c25da5b7baf1d
> >> ("dm verity: stop using WQ_UNBOUND for verify_wq") was also upstreamed.
> >>
> >> Why is this more complex solution better than simply removing WQ_UNBOUND?
> >
> > I do think it's a specific issue on specific arm64 hardwares (assuming
> > qualcomm, I don't know) since WQ_UNBOUND decompression once worked well
> > on the hardwares I once used (I meant Hisilicon, and most x86_64 CPUs,
> > I tested at that time) compared with per-cpu workqueue.
> >
> > Also RT threads are also matchable with softirq approach.  In addition,
> > many configurations work without dm-verity.
>
> Also for dm-verity use cases, EROFS will reuse the dm-verity context
> directly rather than kick off a new context.  Yet I'm not sure there
> are still users using EROFS without dm-verity as I said above.
>
> Anyway, the original scheduling issue sounds strange for me (with my
> own landing experiences) in the beginning, and I have no way to
> confirm the cases.  Just hopefully it could be resolved from the
> developer inputs and finally benefit to end users.
>
> I've already did my own stress test with this new configuration as
> well without explicit regression.
>
Hi Eric,
From the dm-verity patch description of removing WQ_UNBOUND it seems
Nathan saw the EROFS wait time was reduced by 51% whereas high pri per-cpu
threads showed me sched latency reduced on avg by ~80%.

So from the description at least it does not look like both patches have
equal benefits. I can't argue about the size and complexity of removing
WQ_UNBOUND if it gives the same benefits, that would have been great.

I will do the app launch tests again to compare these and share.

Thanks,
Sandeep.


> >
> > I don't have more time to dig into it for now but it's important to
> > resolve this problem on some arm64 hardwares first.  Also it's an
> > optional stuff, if the root cause of workqueue issue can be resolved,
> > we could consider drop it then.
> >
> > Thsnka,
> > Gao Xiang
> >
> >>
> >> - Eric
