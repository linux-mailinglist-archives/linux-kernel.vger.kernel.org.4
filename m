Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6283F743DB3
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 16:41:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbjF3OlA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 10:41:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232701AbjF3Okt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 10:40:49 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F1CB3C06
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 07:40:42 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4f973035d60so3229284e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 07:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20221208.gappssmtp.com; s=20221208; t=1688136040; x=1690728040;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=F4P+Rj0oUJhKXVUru8smVHTl7Xg4pceMd76M85J93j4=;
        b=beH7I+3T7UvFuU1PqzWQYYEVZijNNbAuGfoJjqoIk2P+/04qfVXCMQdURQS3ztF2zJ
         gUd5N0JN4XxXCr6J0hzaYBoz1krJL8RDz4oAgGfUt1OH4/CuT5BUFt9AO11gIe6vPj5r
         V4GCZ4PZxm1G2uWHIRV93h4Z8SeBFifK1myV9FMLnsR+14Zoi0kAaZFri+aqGIwbdvBq
         gyzjFQpSQbFHupKYx1C5+rfIb5Hf8IQnu/grB4ef976HYbbEW/kaJ+5r0W9N/xoB+Gjw
         A6tBdDlkDkftlLcY0ut+qxrt+B30KEFk9eat8LM4IAw6sP8/q6IFCLeVP7Gx9OmPUGDh
         kCtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688136040; x=1690728040;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F4P+Rj0oUJhKXVUru8smVHTl7Xg4pceMd76M85J93j4=;
        b=j42eA/8HmofLZrA/AJ5+9f0Kft81VzGxbo1J1b7VUGswcWEdyBfceplnR5QzJoEh8N
         Av8QzdY+TNIGhE2gP+BYDUfyx0AwQH565ALOSEUhT/UPjUiB9so189QWK6GiQd4qB716
         Hm7CC/HlXa10+zso3AMwRo6oXav0PD+qitvSzryCL79qiN8gTdDaC6U3H1KNdNcKBUVd
         j0ckjODC7Os1XBibKOW/VnO7m0x4vsdAYJYfKW6G770m4Ww1/O4CAQg2QhHPFmhIhieS
         Yci9hMotEYTF+l4Es+Wm+FQ2ICidzNkXGu/XW9BFwnD1RW3WNiuwbkT3yXlriynKiFIo
         b5AA==
X-Gm-Message-State: ABy/qLY5TlEyR4fl0Q1Pk5LcbyZIoLq12howeKHlUEPhrUwN0DODWFYT
        +LC5JwSq34gRxiAd0jw5khJGxw==
X-Google-Smtp-Source: APBJJlGfiJ7vQiQkIlcZOiCOr9PTECo0JS3xzwWMnWt65YxoDvwFIHxTLjMzkzwgLxHnJJB4skMdgQ==
X-Received: by 2002:a05:6512:3b8b:b0:4fb:774f:9a84 with SMTP id g11-20020a0565123b8b00b004fb774f9a84mr3062410lfv.13.1688136040182;
        Fri, 30 Jun 2023 07:40:40 -0700 (PDT)
Received: from airbuntu (host86-163-217-97.range86-163.btcentralplus.com. [86.163.217.97])
        by smtp.gmail.com with ESMTPSA id s24-20020a7bc398000000b003fb9ebb6b88sm10815685wmj.39.2023.06.30.07.40.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 07:40:39 -0700 (PDT)
Date:   Fri, 30 Jun 2023 15:40:38 +0100
From:   Qais Yousef <qyousef@layalina.io>
To:     Xuewen Yan <xuewen.yan94@gmail.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Xuewen Yan <xuewen.yan@unisoc.com>, mingo@redhat.com,
        juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, ke.wang@unisoc.com,
        zhaoyang.huang@unisoc.com
Subject: Re: [RFC PATCH] sched/fair: update the vruntime to be max vruntime
 when yield
Message-ID: <20230630144038.v2rv7qtrxi4ujhdg@airbuntu>
References: <20230227220735.3kaytmtt53uoegq7@airbuntu>
 <CAB8ipk--trBk-Acsjz7YDb5szPLc93ejPXVXQBJdomZO4OrpGQ@mail.gmail.com>
 <CAKfTPtBdMO6_APib1OBxW+fdAORX8vXdT-W3fWTRffa5-8bGxQ@mail.gmail.com>
 <CAB8ipk96OXJcmp_H5EcagrMUigSFdW_gd4wwGjfjBpyP6hqaTg@mail.gmail.com>
 <CAKfTPtAvuz0SEDX3izcOhZkC+pFddqrSwY+iYO2p7U6N3Z2hRA@mail.gmail.com>
 <20230228133111.6i5tlhvthnfljvmf@airbuntu>
 <CAKfTPtAsxz7s6W2peoVj+EcNVQp6bpO6qhPPTXgfJxVtXHbaKQ@mail.gmail.com>
 <CAB8ipk83Ofywn0T19dHxjJNXfKcd9DD_EopQupeepjSk-XceRQ@mail.gmail.com>
 <CAKfTPtDfSHnd7=ZG2S-x46kxw0Cc0RSXq+_B8Oe46fa3Fa75BA@mail.gmail.com>
 <CAB8ipk9uPMxwEUHkLWbKXQEO1UkwBPWbZb=NF7AE5JHnG8V6Dw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAB8ipk9uPMxwEUHkLWbKXQEO1UkwBPWbZb=NF7AE5JHnG8V6Dw@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NO_DNS_FOR_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Xuewen

On 03/01/23 16:20, Xuewen Yan wrote:
> On Wed, Mar 1, 2023 at 4:09 PM Vincent Guittot
> <vincent.guittot@linaro.org> wrote:
> >
> > On Wed, 1 Mar 2023 at 08:30, Xuewen Yan <xuewen.yan94@gmail.com> wrote:
> > >
> > > Hi Vincent
> > >
> > > I noticed the following patch:
> > > https://lore.kernel.org/lkml/20230209193107.1432770-1-rkagan@amazon.de/
> > > And I notice the V2 had merged to mainline:
> > > https://lore.kernel.org/all/20230130122216.3555094-1-rkagan@amazon.de/T/#u
> > >
> > > The patch fixed the inversing of the vruntime comparison, and I see
> > > that in my case, there also are some vruntime is inverted.
> > > Do you think which patch will work for our scenario? I would be very
> > > grateful if you could give us some advice.
> > > I would try this patch in our tree.
> >
> > By default use the one that is merged; The difference is mainly a
> > matter of time range. Also be aware that the case of newly migrated
> > task is not fully covered by both patches.
> 
> Okay, Thank you very much!
> 
> >
> > This patch fixes a problem with long sleeping entity in the presence
> > of low weight and always running entities. This doesn't seem to be
> > aligned with the description of your use case
> 
> Thanks for the clarification! We would try it first to see whether it
> could resolve our problem.

Did you get a chance to see if that patch help? It'd be good to backport it to
LTS if it does.


Thanks

--
Qais Yousef
