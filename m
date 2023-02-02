Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8850568889A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 21:54:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233085AbjBBUyq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 15:54:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232500AbjBBUyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 15:54:44 -0500
Received: from mail-vk1-xa2d.google.com (mail-vk1-xa2d.google.com [IPv6:2607:f8b0:4864:20::a2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8025E820D9
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 12:54:41 -0800 (PST)
Received: by mail-vk1-xa2d.google.com with SMTP id i38so1565738vkd.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 12:54:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=v5EQvloJ9CpdHZjfadgqWrDLzLydTeMlPjVvp1vgvMA=;
        b=QJoOIXxEb/sQrUTYQ6QfhIamMl4W35y/1RrelnQLl7cXtxwFglFcxnxS6n7d2JTE+q
         nZPbcT4vAdYOL19XHSDzrOyzRnsYoFRhI5JvKe31jBHExFzkHXmH/N2DcyltPvLuCbnB
         vnvRdaXk3n+xfSG8wkrmeMrVvTE/zTQMS5XC0u46sSGGGPTQdlBFH9/uHmvEDStKZwZf
         m1f4Zfh7pflNf+vsbh9RICPCUifVq4n+/cDro984zH/2vyxqPW1esllqXWbcTYngll93
         9ThPSxwcjxa3ezgePioMl7XbOKYq8m7v4xDOwqYkCQpzrnhWBd7D8c6r3LCejxQbrh3t
         B5/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v5EQvloJ9CpdHZjfadgqWrDLzLydTeMlPjVvp1vgvMA=;
        b=iMQUepIfs4YV8JtQTnL4YA1rtn+S3Tm8SIwajaKLWbqe7apVX6CvwvbHolY0TFn0ml
         lzX/c/ImQ0hGrB5ijWxfy8YN0oQUtXAq1FDjpezxRut6MuZxhtJDvNm3w98fGc5J6Mth
         c+JlUPAybqp0LAC3dEmE+JFd+rfEtz0bvKyYBsKym29c6JeHVK42JZV5gZx8FijNd2bi
         kFEPjI5ryh6lBjbwTg0AVZU3BG0xnf290rVJqK9acb8I7+O1Ow2C1dN4OUOd3XETDQ30
         bIMIiPz8pYJ9ShcEIYv8M5ESZA2Jf6ck4+ME+FiuXOEVSmXv3w0w4uJN8UFX4qwLuhkp
         0OXg==
X-Gm-Message-State: AO0yUKWxetBqf2nAjyHFmDpejqsvgmj6S7hOLvuYuA0HPwBF1BQWelwh
        8Jz/wJR33elsdHYWaXcDBXKRn8XXcjq5CeFDu9xi
X-Google-Smtp-Source: AK7set8Vo0d8OHsOn0nyqDdpPp7uFKPSYXZLIFKMmBYS9Vbdh+E8ONBZWaZO9FQKeWyegfll2tOqabWyBTxxvWx/esc=
X-Received: by 2002:a05:6122:792:b0:3ea:704:c196 with SMTP id
 k18-20020a056122079200b003ea0704c196mr1167056vkr.11.1675371280470; Thu, 02
 Feb 2023 12:54:40 -0800 (PST)
MIME-Version: 1.0
References: <417c4e3a-6fa8-5210-dd27-669a5d9e255c@arm.com> <20230127231001.1920947-1-yabinc@google.com>
 <CAJ9a7VjZs_sHz=p-HQfE0gvqWx65776W8Y-gR3ATx-_k+vr7LQ@mail.gmail.com> <aacdd394-3008-a7fa-66a8-1db2a8fc1065@arm.com>
In-Reply-To: <aacdd394-3008-a7fa-66a8-1db2a8fc1065@arm.com>
From:   Yabin Cui <yabinc@google.com>
Date:   Thu, 2 Feb 2023 12:54:29 -0800
Message-ID: <CALJ9ZPNrF-HhUNskr=_MJ1CrnO+0xzSN8pMpER3FMqf5Pd0idg@mail.gmail.com>
Subject: Re: [PATCH v2] coresight: tmc: Don't enable TMC when it's not ready.
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     Mike Leach <mike.leach@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        James Clark <james.clark@arm.com>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
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

Hi,

> > There is a similar unprepare function in ETR - this should have similar updates.

Thanks for reminding me! I will update the patch to fix it.

> > The tmc_flush_and_stop() function also calls tmc_wait_for_tmcready().
>
> I think this already an error message there, when it fails to complete
> the flush.I thought of adding a WARN_ON, but thought it is not worth much.

I can see error messages when tmc flush timeouts or tmcready timeouts.
I don't know how the callers (read_buffer and disable) can handle this error.
I think the perf event call chain doesn't accept failures when
disabling coresight
devices. So I feel reporting the error is the best effort we can do.

Thanks,
Yabin
