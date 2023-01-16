Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A896E66BDD1
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 13:29:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbjAPM33 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 07:29:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjAPM30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 07:29:26 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 968C81CF73
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 04:29:25 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id i65so17359300pfc.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 04:29:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tu5OJOBIgMLHuUpsp6UpRFubmqLqzfGdVmO7CU8EkKs=;
        b=I4tjtw/UCFox/srRbt1s5pAj87hrugXKw43CBMeH86AXlSaAAwipyCqo2EdfOZLTnh
         n9ijnEfgcThnWNV7FYPAOgzV5oHG+5F+e4kY6x/llVkrrr53Ehym4fkIrfPbKvqLR6Ds
         1NY+lxiUt9ma9a4/JGkI/hsgSN9hEjqQAnNPjkYlLLrl+m6gjBMxa9WjLxC0Uj1o/ePo
         yr/XLGNv77kMWeNfiWCg3Dr8El1QQiQrboFfpJxXasmr2YKjYI/5QtzN9e2cjfsR3k98
         W3fFOChDz+/s7wqaL0cb+cyJFM9jKT/qmMAfdRF9Um0TZEbj0bIknjS4AxX+Ai507ixT
         b9UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tu5OJOBIgMLHuUpsp6UpRFubmqLqzfGdVmO7CU8EkKs=;
        b=sj52+xhZ4H3oq0uhQt/VJ20yeeGOi6DJudZH9Wx0+oCSEKvDRM4T7rzv6UOaLd37Cd
         LJrrtoBRR1vw5qH34ZkjK/a1Bmgq8TwLZbv02jUkPTvtvTVRF1EuJn3NXHj1IaZOOCYj
         ysxu0oGVBqz8AIutlM/RD4UDgXE2AM+Zb1lDsRKwzd3WPE64I4nVnz+c7JHCYTHbSpzZ
         uHRlXmDKv5cj+l1178W5WhVa7QIWgOS/gvf8lYfuHMWvs9PPT7SpjEsixqrY0uXTwJbn
         cBAk/X52RWsP+cTWL7rsBClzk3pH9d7kkP4bsKpxMmV9yhdnJ3cFJKdyKjEEEibE9zQQ
         WVcA==
X-Gm-Message-State: AFqh2kpiILCB+D6725gADwsuu3DpHEaqtnEN0IZoMfrvJGD/RVehBmTe
        zhPucRD+eCr5JPHMV3yUaJCrLRUAxcKH2qTE4fuV4Q==
X-Google-Smtp-Source: AMrXdXsJB+z7pfvhzwjU2HZpxaf8SN+y75dBho1GmgangP2wLMdwcOsOceVbkZ5kiDwx8zY0OtozBqQkkO5bnXVMD4w=
X-Received: by 2002:aa7:88c5:0:b0:58d:aeb6:2d66 with SMTP id
 k5-20020aa788c5000000b0058daeb62d66mr200816pff.66.1673872165004; Mon, 16 Jan
 2023 04:29:25 -0800 (PST)
MIME-Version: 1.0
References: <20221219234638.3661-1-mike.leach@linaro.org> <20221219234638.3661-5-mike.leach@linaro.org>
 <Y6sm74wfjenzA0v9@infradead.org>
In-Reply-To: <Y6sm74wfjenzA0v9@infradead.org>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Mon, 16 Jan 2023 12:29:13 +0000
Message-ID: <CAJ9a7VgMFXTh19eQa5_yX2Ss8Eur8zRxBSyZJbr68ybJSW_hYg@mail.gmail.com>
Subject: Re: [PATCH v5 4/6] coresight: configfs: Modify config files to allow
 userspace use
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        linux-kernel@vger.kernel.org, mathieu.poirier@linaro.org,
        suzuki.poulose@arm.com, acme@kernel.org, james.clark@arm.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'll rework this in the next set.

Thanks for the review

Mike


On Tue, 27 Dec 2022 at 17:10, Christoph Hellwig <hch@infradead.org> wrote:
>
> On Mon, Dec 19, 2022 at 11:46:36PM +0000, Mike Leach wrote:
> > Update coresight-config.h and the coresight-config-file.c & .h
> > to allow use in userspace programs.
> >
> > Use __KERNEL__ defines to filter out driver only structures and
> > elements so that user space programs can use the descriptor structures.
> >
> > Abstract memory allocation in coresight-config-file.c to allow read
> > file functions to be run in userspace and kernel drivers.
>
> That's now how kernel code is written.



--
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
