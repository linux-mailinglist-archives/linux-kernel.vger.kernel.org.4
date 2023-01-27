Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F371267E7DC
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 15:13:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232848AbjA0ONK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 09:13:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234018AbjA0OND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 09:13:03 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D6B47376A;
        Fri, 27 Jan 2023 06:13:02 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id z11so4865907ede.1;
        Fri, 27 Jan 2023 06:13:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RpJCF71ARWA/yf7MzaIgSXT0iJjBQSiN6LodGI6rwAA=;
        b=bWa2YUKQNMGXcuVXkuL3Jnc1Z9G/nb/kqFBg8e4HC+T6HBjLglQ0GuTDCy+Gjc+Q0u
         dcxgFZT9clLO7NQPxvvsFN/6+XQf38kVIkAXZb0kkMB0m1mBqV0/KUR2wwovN3ClOQer
         Nk7C/SVY2OwgixcDi+zazyzgYodzboeuJ/E2oYbBooRq0eGfKwDU/5aYjU25Aysei08A
         Z/V8GOIxeEdCgwmz23+TQ/vAz9WLOfA5HUYXtE3yNixzdTw38aKuuH5KCLfC4dV1TZLw
         Bc+B46m9kdoxpijKJYFDXPn6x+hItJsglS3ek4TkRn6JOqITZC8oIkE9x3LxXMt8CLKz
         Am+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RpJCF71ARWA/yf7MzaIgSXT0iJjBQSiN6LodGI6rwAA=;
        b=uoD1JiD5XkWtwA5eq6xSsO9mMQRM96LcEuHWEel8VBnXlAksGYSbSFZWif7w4EzBVg
         esv0eq6wUypWYeRvmOelWD5DPauFPdzyxXgEzjtVkk0wpm4rM+1jpBtshCe58o7spt7L
         oufYSosKve/TcIENFVSRO7tInpMUeh4Xy1jntc0yZ6G7SBnWJxVNVN77FueE+/BM4UP5
         FZI8OqacgrINBLsqCFPWmXU2b6Nv7eqxTNtQxIwtLTI/ymCfWTEGByQM8wJv27CMkhyk
         sIdvMEdTZjDIvpd2LhJDXVP7cyYJL64Kjdy2DcfYJ+FoDNJkyIRPFGu37e05ffgMSRJh
         qrdA==
X-Gm-Message-State: AO0yUKVHr8oj0AlfzHABaPUB8Yn7Vobc8fJ5mc8/9xMOclBtmjvmhGKm
        fFW4xybSlTGfqc15XisSmGXuOBuDiXTtgrw3P9o=
X-Google-Smtp-Source: AK7set8W52mQo3SejTyD7HLfhbgO9s38gopDG87i63d5LRiPYavANgiN55NvvJUs89Rl10+/kTsijANBiyfdE0k8Chk=
X-Received: by 2002:a05:6402:175c:b0:4a0:8f64:cddc with SMTP id
 v28-20020a056402175c00b004a08f64cddcmr2903568edx.58.1674828780914; Fri, 27
 Jan 2023 06:13:00 -0800 (PST)
MIME-Version: 1.0
References: <20230125110100.14647-1-iuliana.prodan@oss.nxp.com> <20230126224905.GA4020499@p14s>
In-Reply-To: <20230126224905.GA4020499@p14s>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Fri, 27 Jan 2023 16:12:48 +0200
Message-ID: <CAEnQRZDOvcnr0NtJJp40DvTsUggmmPd3UsVramWxwj35OYfR6g@mail.gmail.com>
Subject: Re: [PATCH] remoteproc: imx_dsp_rproc: add custom memory copy
 implementation for i.MX DSP Cores
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     "Iuliana Prodan (OSS)" <iuliana.prodan@oss.nxp.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "S.J. Wang" <shengjiu.wang@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Paul Olaru <paul.olaru@nxp.com>,
        Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>,
        Iuliana Prodan <iuliana.prodan@nxp.com>,
        linux-imx <linux-imx@nxp.com>, linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

<snip>

>
> This patchset from last year[1] goes to great length to avoid using a driver
> specific function and now you are trying to bring that back...  So how was it
> working before and why are things broken now?  Moreover, function
> rproc_elf_load_segments() deals with situations where the memory slot is bigger
> than the file size[2], which is omitted here.

As I mentioned in [1] the problem was and it is still there if an elf
section has a size which
is not a multiple of 4.

And we do notice this when compiling Sound Open Firmware and loading
it via rproc interface.

This is a hardware limitation! And we need to address it. The
limitation happens for IRAM address range
of HIFI4 DSP integration with I.MX.

Some call it a limitation, others call it an optimization. Either way
we need to avoid crashing the kernel.

We have two options:

1) Fully address it in rproc driver (like the present patch).
2) Partially address it in rproc driver (by returning an error for
section with wrong sizes) and then
making all linker scripts to force elf sections to be a multiple of 4.

I would go for option 1) even if we go back to use our custom `load` function.
