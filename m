Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BB196138E0
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 15:22:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231532AbiJaOWH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 10:22:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231529AbiJaOWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 10:22:04 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEC20EE1C
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 07:22:02 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-3704852322fso38739517b3.8
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 07:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=L4f8O1niA/i6t8Y5AJawjSI5uUXL6Dy1q347jw4xtkU=;
        b=Nq8/gNiuqex7DknbnmUZ2q6SQYb4Y91J9w+j72FF5JE3AUWf43skjiryCjS08A5+jM
         5q0VdRgXEh9WoNF4rc97IE0lwJhJpGGnFAOQ6Mqpnpd+8rt45yX30qXZl1tncCryu/uc
         0A5e1H3iDp5ZBDLkmHFNi0Vc9Igred/fEKfEb+s573GanS06IPYpVGq/H3UxtG9nLYoC
         Q4t5zt/qVJ+svFVztySIv2piD0S8lgGLzkDdWvDpXQjZPAT2QUPOFgmbzikH/QsofShV
         GI4HyfoEWHij89nuwIaTfwuYSyT7XxltvVuASzuWtENbHXeYB+ILG5oEtHavJChICMVM
         BDCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L4f8O1niA/i6t8Y5AJawjSI5uUXL6Dy1q347jw4xtkU=;
        b=dsp8Qr+XiQ9uR9e2QCt7oeQL8Z/d4MuFKFfJG8amsfGi4Il0MXQw4V1TEELqYKYSHT
         l0DA5vftnUCnDFM+ZvuyjU3GPHe7V0YrhNzI83z376UWYPpSJZxGzGhEJxn3ErhLfrKH
         Sd4xy90DLNMJ54jbl7Cwv03fAk3dK31fc0r5hK4Amt6q4Wm9PmKBr0xYYF3I2hVL68rm
         UWXnKxcMEi0/7QkHGuwsxLBEji92MxBRrBuBBD0eGubUfOjA9XdIvZpm4yn2FI/6SD1U
         vy4xclrIs1UJMVJ0Sf8QMgSQhAMPsqxzTgZwOBmIUbCSFpJbAzq1eHbEKF+mCDnQKTXh
         jGpA==
X-Gm-Message-State: ACrzQf35O+NtrRcn+Ib5qzdFb6Gza0unR72nMKWgYAFeSy4maMqHMRlc
        UZhXlDjCb70azhRRSDwz/gfYd0/Cf/9NCRW0/mTgJQ==
X-Google-Smtp-Source: AMsMyM6G7GD0XIK2OaMfnU7tTRBl4ybT4IPEbhAZPmpB6R0TuABNMTPpMRQ+dZLkNy/6fYheaXVFdmWteqeY/i49fGY=
X-Received: by 2002:a81:4ccc:0:b0:360:811f:4b74 with SMTP id
 z195-20020a814ccc000000b00360811f4b74mr13146492ywa.398.1667226122098; Mon, 31
 Oct 2022 07:22:02 -0700 (PDT)
MIME-Version: 1.0
References: <20221021131204.5581-1-james.morse@arm.com> <20221021131204.5581-19-james.morse@arm.com>
In-Reply-To: <20221021131204.5581-19-james.morse@arm.com>
From:   Peter Newman <peternewman@google.com>
Date:   Mon, 31 Oct 2022 15:21:51 +0100
Message-ID: <CALPaoCjTzzdqtEoqSWv-w=Fvq-dLLjvt8VJrP_RzmijLTD5=2w@mail.gmail.com>
Subject: Re: [PATCH 18/18] x86/resctrl: Separate arch and fs resctrl locks
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

On Fri, Oct 21, 2022 at 3:13 PM James Morse <james.morse@arm.com> wrote:
>
> MPAM's monitors have an overflow interrupt, so it needs to be possible
> to walk the domains list in irq context. RCU is ideal for this,
> but some paths need to be able to sleep to allocate memory.

I'm curious about this requirement. There are already counters which can
overflow on Intel, but we've been able to detect overflows soon enough
by checking at a reasonable interval. Are we expecting MSCs to have
counters that overflow so quickly that the overflows need to be handled
directly in IRQ context vs being able to run a threaded handler before
the second overflow?

It seems like MBM would be really intrusive if it could cause the system
to process overflow IRQs at a high rate.

Also is the overflow interrupt handler in one of your MPAM preview
branches? I was only able to find an error IRQ handler in
mpam/snapshot/v6.0:

https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git/tree/drivers/platform/mpam/mpam_devices.c?h=mpam/snapshot/v6.0#n1813

-Peter
