Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B98C35FC597
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 14:47:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbiJLMrL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 08:47:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbiJLMrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 08:47:04 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52DE5C90E1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 05:47:02 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id i3so6830282pfc.11
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 05:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TCsnt1jn9/nACViL38XJV3sKXpu5bWJAYvOB5PY80uY=;
        b=qVTx2GjiFO/WpomiCKTc7aV0b8O33zcsAD2umlKepSPVpnzSCao2Zp+0/Phm54KmOw
         vDQTL8D4nBVDmZ/5PDT8AU+SXGfsOTPZj+hiOuzGoFYLshsxgxQJiG4EdR2c2j4dVgEr
         QfchIMgDUT6dn9vjTOftIrwKP8UJ+QIPEzossca8bSIXvhKuYhvLE1L6XNhnJ+BDs44e
         rtnVRyHKUKgRNxvihjgn2uvOFslD8UhFzPnHvbva368kvI8hOrTPtnvDhcBLp7ywkhho
         3TEPKr7uZobooo8FJk3lEp8VmX7RkkPW3WDC5By7ortXsWvTYiT/MeDpVXVs1PYbIIUA
         6ZDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TCsnt1jn9/nACViL38XJV3sKXpu5bWJAYvOB5PY80uY=;
        b=mPnBiAfYX726apXzdMSGN0MpQsYiomMO8DK1lS1WFXpyUTIgoC7W7ZZFxmiBY+8pHW
         VVdCgvKfNDbIjQNJXwowzB+9dmSCBNX3kNHtIu+zgKnL35FlO0s8DH6MVWGO4xnDPRDx
         pjLzMuIy5DfYSW/LfMw+LrQ+Ii29UXT0M+Zts9+svs9LizA2BxXoem513PngPH/RvdDS
         cRWpKk8ZIrWByezJawms50+WDCCvBsl7qjb3p3sxVZhaotJGcN8/AH5xq9TI9039uymG
         fetWpD5vqzGLvspSBKTtoRCQPMrUgRdratf+ms9BOe+F9KOh2TZPLlnKc0M80nOt8hc0
         zrVA==
X-Gm-Message-State: ACrzQf35gZadvLT9gvt33WtLPrnhcB3NINlAxMN9670GWHs+iD+zTYVL
        peg/e7YAejwrahZ3NhsnAlG0XBkydlrldRct2PypOysR85ils22u
X-Google-Smtp-Source: AMsMyM5X8KAbJFALIbtCpWlQDg88SoPYZRnk1lZE7Je8zrI6+NFA1rPAK8S0VL3JGkZPk9tBfUzPKanpk4vBd0W2nFk=
X-Received: by 2002:a62:ee0c:0:b0:558:5c4:97dc with SMTP id
 e12-20020a62ee0c000000b0055805c497dcmr30541467pfi.14.1665578821795; Wed, 12
 Oct 2022 05:47:01 -0700 (PDT)
MIME-Version: 1.0
References: <20221012104055.421393330@goodmis.org>
In-Reply-To: <20221012104055.421393330@goodmis.org>
From:   Masami Hiramatsu <masami.hiramatsu@gmail.com>
Date:   Wed, 12 Oct 2022 13:46:50 +0100
Message-ID: <CADyE4xEUE++m7VcKq9a3_va6m_K9zZ5FTFPPT8CZqin8aZ8A2g@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] tracing: Fix synthetic event bug
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tom Zanussi <zanussi@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

2022=E5=B9=B410=E6=9C=8812=E6=97=A5(=E6=B0=B4) 11:45 Steven Rostedt <rosted=
t@goodmis.org>:
>
>
> The follow commands caused a crash:
>
>   # cd /sys/kernel/tracing
>   # echo 's:open char file[]' > dynamic_events
>   # echo 'hist:keys=3Dcommon_pid:file=3Dfilename:onchange($file).trace(op=
en,$file)' > events/syscalls/sys_enter_openat/trigger'
>   # echo 1 > events/synthetic/open/enable
>
> BOOM!
>
> The problem is that the synthetic event field "char file[]" will read
> the value given to it as a string without any memory checks to make sure
> the address is valid. The above example will pass in the user space
> address and the sythetic event code will happily call strlen() on it
> and then strscpy() where either one will cause an oops when accessing
> user space addresses.
>
> Changes since v1: https://lore.kernel.org/all/20221011212501.773319898@go=
odmis.org/

Thanks, this series of patches looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thank you!

>
>  - Handle "(fault)" printing when there's a fault
>
> Steven Rostedt (Google) (3):
>       tracing: Move duplicate code of trace_kprobe/eprobe.c into header
>       tracing: Add "(fault)" name injection to kernel probes
>       tracing: Fix reading strings from synthetic events
>
> ----
>  kernel/trace/trace_eprobe.c       |  60 ++------------------
>  kernel/trace/trace_events_synth.c |  23 ++++++--
>  kernel/trace/trace_kprobe.c       |  60 ++------------------
>  kernel/trace/trace_probe_kernel.h | 115 ++++++++++++++++++++++++++++++++=
++++++
>  4 files changed, 142 insertions(+), 116 deletions(-)
>  create mode 100644 kernel/trace/trace_probe_kernel.h



--=20
Masami Hiramatsu
mailto:masami.hiramatsu@gmail.com
