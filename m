Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52325687C39
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 12:30:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231894AbjBBLaE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 06:30:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbjBBLaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 06:30:02 -0500
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99E5C193FF;
        Thu,  2 Feb 2023 03:30:01 -0800 (PST)
Received: by mail-ej1-f43.google.com with SMTP id k4so5114829eje.1;
        Thu, 02 Feb 2023 03:30:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8Q1CslKImMRQ92nlftjX0699vIqJ+EJ3jBDjS0IXDgU=;
        b=tFAZKJ2IiMPiMqbokmrZPd9HPUMbhgavQJzH8XDCtPyk1q9McCxUNHxWdBaTjYu8e+
         MTc+NteETTvdp/3Ag67KLzCa4uqITGRKkPgeszi6mxY7Zac4CNswvq0jLChBf7BLQZJP
         PNv9fWEl52h+8IqVoyOadO3Rg6DKri1Av1v0vmibz7ztx7rriPBVqJvcwjPrSYjPtT4K
         nZkGD8Anje4avy8JwyswlzN0ojSahDO1gnCIGX+iU86INOm2Oy1Mi4bXQ2vEXjNuOtTW
         wh1YWjBQ0EeTNYuDLu6cbYkstJi7boYbFzB9SnuQL6mVhw2w2suMhNMs1z0eJvCcw+uG
         qadw==
X-Gm-Message-State: AO0yUKVKpojVlMhouGHatsRftzZbF1kFKKgZl4SJ6ALGSwZzSo/bdpUx
        pjdVDo6Wl1MyAyromjGSRO3+KWpDBzmNSULOG7M=
X-Google-Smtp-Source: AK7set8UGoryRqWrV0zpD9cHRj7sjCaDb5ut21umzkW+3Qn/ptLUVvocsekTw/Td7f5RkIZ3ges6cSq6EKEBXifF7+4=
X-Received: by 2002:a17:906:85c7:b0:878:581b:63ee with SMTP id
 i7-20020a17090685c700b00878581b63eemr1564646ejy.244.1675337400119; Thu, 02
 Feb 2023 03:30:00 -0800 (PST)
MIME-Version: 1.0
References: <20230201143628.270912-1-vincent.guittot@linaro.org>
In-Reply-To: <20230201143628.270912-1-vincent.guittot@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 2 Feb 2023 12:29:48 +0100
Message-ID: <CAJZ5v0h58E3EfdxUi58YGftoeFWXFa2Kzf__B-WmMdDEPLf9NA@mail.gmail.com>
Subject: Re: [PATCH 0/2 v5] unlink misfit task from cpu overutilized
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     mingo@kernel.org, peterz@infradead.org, dietmar.eggemann@arm.com,
        qyousef@layalina.io, rafael@kernel.org, viresh.kumar@linaro.org,
        vschneid@redhat.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, kajetan.puchalski@arm.com,
        lukasz.luba@arm.com, wvw@google.com, xuewen.yan94@gmail.com,
        han.lin@mediatek.com, Jonathan.JMChen@mediatek.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 1, 2023 at 3:36 PM Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> unlink misfit task detection from cpu overutilized and use the new -1 value
> returned by util_fits_cpu() to extend the search for the best CPU.
> Remove capacity inversion detection that is covered by these changes.
>
> Changes since v4:
> - Added patch 2 to remove capacity inversion detection
>
> Vincent Guittot (2):
>   sched/fair: unlink misfit task from cpu overutilized
>   sched/fair: Remove capacity inversion detection
>
>  kernel/sched/fair.c  | 189 ++++++++++++++++++++-----------------------
>  kernel/sched/sched.h |  19 -----
>  2 files changed, 87 insertions(+), 121 deletions(-)
>
> --

Acked-by: Rafael J. Wysocki <rafael@kernel.org>

for the series.
