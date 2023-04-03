Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 322A86D529C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 22:37:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233398AbjDCUhp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 16:37:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233419AbjDCUhm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 16:37:42 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA95CE78
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 13:37:30 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id jl13so22054564qvb.10
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 13:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680554250; x=1683146250;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PT2nbduFIoItxBLmb62kwW+aXvG7yZHy5CU0nT4j1ME=;
        b=KiBR5aW9ZOnqsbUbKLtDpbWeeJbq3Tbnq5AZAMJTtiYPIA/5jcE3rDwPZtJxyTxlSJ
         8GGPhvLkRgMJ5lW0QxixeJ+SWs0yduj9AlvPcUH5CfGOmHtviZpduGyBFPhP6jDfyYkI
         VIRp19Ua5SIX7rrEIunWW67v6y2oaA+mrVdlnoZJmPNtIfuetIZeY1R0NyIrDVI5xxtU
         lfkod/+X+EPZt8SggNwQTfYwqSQRsNosUmelV4vYUz29qlwRT8BbKD3LSsJcghAEo/i/
         B+v9nAPElFEHUfYk+jLmRsdZoFW4wkMt2JjhJFTYkYNkIHUxTOWOUWZHUj1RCFSYoa6V
         /qSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680554250; x=1683146250;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PT2nbduFIoItxBLmb62kwW+aXvG7yZHy5CU0nT4j1ME=;
        b=UiSVTp0GQltSfvGn6FhCgNi88Gs3wFLwrmikKHpIl/+y32r4G0y82D4DhJ1EK1L70o
         Icl+c4qCe5tw323+aa/Sm61LcD2OekEw0G5TL+w1QZrqQGGQA/MdM6TyrpnsFt+QbiJN
         gW7TWVOVG6+Rxrrf0mlhUTeK06pzs/nNAr3Dip+ad2ZiQNL08LZRFtN3PH2X89J8qWUy
         gcmpcEHE7mkxNRrbOtKJSV8vuNX945PSNWJ6+3F6i5akAE/eB8eOVjeEXKme2jdJu3+W
         RUh2dulIqdopqB66cMyhbCFbRVF10g+SvXw+kXUWserDZ0GHuENPMAluqxbF1XHCR31C
         4weA==
X-Gm-Message-State: AAQBX9e37N3ftdj11lLC8ageijprxi/oilb0+EHrlhNBo7LUfGY8+DXX
        3Bw6Yxxv28cI0owHjOowe+E=
X-Google-Smtp-Source: AKy350bvpFMXKH/owC71BRqSVUGhPeL12LadcTUpCATNvQT1ox6EaHn7ULVaDcY3819mt9u/DL1NZg==
X-Received: by 2002:ad4:5d4d:0:b0:5e3:d150:3160 with SMTP id jk13-20020ad45d4d000000b005e3d1503160mr63993qvb.16.1680554249786;
        Mon, 03 Apr 2023 13:37:29 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id nw6-20020a0562143a0600b005dd8b9345basm2885012qvb.82.2023.04.03.13.37.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 13:37:29 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com,
        Zhaoyang Li <lizhaoyang04@hust.edu.cn>
Cc:     hust-os-kernel-patches@googlegroups.com,
        Dan Carpenter <error27@gmail.com>,
        Dongliang Mu <dzm91@hust.edu.cn>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] soc: bcm: brcmstb: biuctrl: fix of_iomap leak
Date:   Mon,  3 Apr 2023 13:37:25 -0700
Message-Id: <20230403203725.906166-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230327115422.1536615-1-lizhaoyang04@hust.edu.cn>
References: <20230327115422.1536615-1-lizhaoyang04@hust.edu.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Mar 2023 19:54:22 +0800, Zhaoyang Li <lizhaoyang04@hust.edu.cn> wrote:
> Smatch reports:
> 
> drivers/soc/bcm/brcmstb/biuctrl.c:291 setup_hifcpubiuctrl_regs() warn:
> 'cpubiuctrl_base' from of_iomap() not released on lines: 291.
> 
> This is because in setup_hifcpubiuctrl_regs(),
> cpubiuctrl_base is not released when handle error, which may cause a leak.
> To fix this, iounmap is added when handle error.
> 
> Fixes: 22f7a9116eba ("soc: brcmstb: Correct CPU_CREDIT_REG offset for Brahma-B53 CPUs")
> Signed-off-by: Zhaoyang Li <lizhaoyang04@hust.edu.cn>
> Reviewed-by: Dan Carpenter <error27@gmail.com>
> Reviewed-by: Dongliang Mu <dzm91@hust.edu.cn>
> ---

Applied to https://github.com/Broadcom/stblinux/commits/drivers/next, thanks!
--
Florian
