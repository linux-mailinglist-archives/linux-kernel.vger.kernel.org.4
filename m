Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C5B46793AD
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 10:10:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233284AbjAXJKP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 04:10:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232470AbjAXJKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 04:10:14 -0500
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D971B3A58C
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 01:10:13 -0800 (PST)
Received: by mail-vs1-xe36.google.com with SMTP id q125so15862301vsb.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 01:10:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IE9O1SydCsnhsFCENDn3NxHStqlAINZs2v4blfU4wdA=;
        b=S/yub+Snf2WkDJE2zxJM4oAsRzyflpz7dIfS6mDMSo9a0MaO8asAlJaD+ircCYS1Ny
         8CmLwFU1mJMC119sJOMW95gFkQwENaJydIXya9EiQpvcXNSZRtWiIrqEvFK9C59xvkJy
         LLdzOCO2cKohwYDjtNuLrp8bFmrrKSBeP5KY54xXixJmutI9OE2D0YCc26JMEjexHLRz
         Cn5ZeZ48jXY1+jPIM4Udk5sHm6fqarBubp5Smj2pfh/SIFGmDyKXbD9ndBPPr3CdAD0n
         3Fzploxu2dWxPC8M8cZSCkU/X2b137J5SMzLFDmmRAvmIpD/gm64TCgqLUcl/jd++gY1
         NQZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IE9O1SydCsnhsFCENDn3NxHStqlAINZs2v4blfU4wdA=;
        b=DMVE5Id8S4Lkkyi9xTs3vJVRR45tpKzKfm/hy86cY7qvTlPG2jJmJyQOyLL80Kh68g
         qzvx5CYfmOungW2oOlggd2vAR6mAWJMKrHlDzY9h8MNxWQfqfh/xglylROBxwbWSnssr
         yL5itHlIxkWpaiAcR2sETE0ijXEVI78aQ8sY4eqOzBzIG1TzGUGxfKlob6iCYvHuwr5n
         59k3jZanvwIEZwYqt3kRUdnN7eO9W36AsSLZNuy7KIbloloa3bGGOpauUEH9DqjUHUCk
         Oy+iwf9Bj83HW9wwnjEB5cEhIfM2KR2s+FNmHCbHlQSGSBuUfTE8asSioKgIbVbUEyZ/
         y4xQ==
X-Gm-Message-State: AFqh2kpL7u7/OqHv1Q+oKNHFV8yRNK8vbYcnz15ktvtDpG2n1egsgSlI
        MUSWYQrEYL+S8rJ/BcUz8yEJg+Dx+4QngTnQu3umJQ==
X-Google-Smtp-Source: AMrXdXv9Y6NfEKHCqZsS700dYNQXLKzMEUj12p7DTDMeRgMdMzGdUfXDXH7sPEYestGpkKeRXZfuBXUyvCg9sh9t0lA=
X-Received: by 2002:a05:6102:109b:b0:3c4:876c:b0d6 with SMTP id
 s27-20020a056102109b00b003c4876cb0d6mr3808510vsr.54.1674551412931; Tue, 24
 Jan 2023 01:10:12 -0800 (PST)
MIME-Version: 1.0
References: <20230123182728.825519-1-kan.liang@linux.intel.com>
 <20230123182728.825519-2-kan.liang@linux.intel.com> <87sfg0gvrk.ffs@tglx>
In-Reply-To: <87sfg0gvrk.ffs@tglx>
From:   Stephane Eranian <eranian@google.com>
Date:   Tue, 24 Jan 2023 01:10:01 -0800
Message-ID: <CABPqkBSt2WH=zo0_tXNb_Q7waDazvcquXgexXqqn=70A_f4H8Q@mail.gmail.com>
Subject: Re: [PATCH 1/3] timekeeping: NMI safe converter from a given time to monotonic
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     kan.liang@linux.intel.com, peterz@infradead.org, mingo@redhat.com,
        jstultz@google.com, sboyd@kernel.org, linux-kernel@vger.kernel.org,
        namhyung@kernel.org, ak@linux.intel.com
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

On Tue, Jan 24, 2023 at 12:52 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Mon, Jan 23 2023 at 10:27, kan liang wrote:
> > From: Kan Liang <kan.liang@linux.intel.com>
> >
> > It's useful to provide a NMI safe function to convert a given time to
> > monotonic. For example, the perf_event subsystem wants to convert a TSC
> > of a PEBS record to a monotonic clock in a NMI handler.
>
> Why? That's a postprocessing problem, really.
>
Because you want to correlate samples captured by PEBS with samples
from applications timestamped with a user available clock such as
CLOCK_MONOTONIC, for instance.
When I create a perf_event event and I stipulate that
event_attr.clockid=MONOTONIC, I expect all the samples from
that event to be timestamped using the same clock source, regardless
of PEBS or IBS.



> Thanks,
>
>         tglx
