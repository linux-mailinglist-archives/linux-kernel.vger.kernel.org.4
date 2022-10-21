Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AF5260726B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 10:34:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbiJUIep (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 04:34:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230316AbiJUIeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 04:34:18 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B0615B11C
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 01:34:04 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id a18so1630360qko.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 01:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=auS4tVUwcUseQVTVEiGRM+ro1zrL8AC/r1RNa7sIwkY=;
        b=hkYNZqktU4aAHFnn8vZ6QXTJRErSH0MRNGpOfna068WCQa5EHyDJYazCz4JmRfrquz
         GdIisRXXX7obNueHKmj1/JNlDZ4EhIMJfWgbiZxzE/jK8OQCUcQRRU4ASjPd31m/xidh
         kx3lOjx1L59ry2UO8kaXbgS5eKW7xAvxr4NS/8xWwm4gQ+NV2Y9v67ZM0Cx1PXua3K2Y
         Zgph9N6RMqO/esa812+MJOsxoavdSX8n4HQPPH76MWRs/xrxYegmHlWNvXNwD8T7t2rh
         ABUs0kgfoTnQriKHftPFlUSUWExu+Bw9/CDxpyBWdftpjOJ96Q3ZTAutBsGs3IrCgPca
         B5Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=auS4tVUwcUseQVTVEiGRM+ro1zrL8AC/r1RNa7sIwkY=;
        b=vpo3rNM5IS8JY1hl1thLH2bm23EvhT/gkVcoxL3TlkDnZLWwuTEg3IHQ/oQYPoKHPh
         YisDwdmujbFgXXCrpqkohSogbxUOQYhOtiOjVTghmAV7I+gNYpVJJlCS8lZTpF/f+71R
         6AAvIcZY+ALLDnQguJKCCb2+7TDCpsT9vMmtqp8I+wqIWUuLPuVz2W9OXxrtfTzaGm+8
         q2ipuN/c6ap2urxPVDPwJ8jCOeL2j9rbnKyNIvZW72pSKWijHQgrcee2R9QyiGRJRZ94
         2yX0fRDURG+CA1AevigkQ6CMUHhcAm18Ah6Es+KRPIs8gpYwl3yHMLkAtsxWb96Oo1QR
         IAsQ==
X-Gm-Message-State: ACrzQf0QXsIwnT5xYNW6lEWOiaBUNabYbFF9f7/bcvsbTvABMTjEe0Ah
        a0wQKF+HCdHLfeYK9g5gvULZeTSMlvtlj3BRPb8=
X-Google-Smtp-Source: AMsMyM7Uzw7wHP0j9EY0rDtZFj3HwrBBdUDk+AoqIm5ZhiX0BU7J8S6i2OXG0OrBIafK5nqO+eXsOqX3eqvGNo2taB8=
X-Received: by 2002:a05:620a:2552:b0:6ca:bf8f:4d27 with SMTP id
 s18-20020a05620a255200b006cabf8f4d27mr12651177qko.383.1666341242520; Fri, 21
 Oct 2022 01:34:02 -0700 (PDT)
MIME-Version: 1.0
References: <1666318661-11777-1-git-send-email-u0084500@gmail.com>
In-Reply-To: <1666318661-11777-1-git-send-email-u0084500@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 21 Oct 2022 11:33:26 +0300
Message-ID: <CAHp75VeMvWycVsNPHb1cvMbtVSCiX3m9wUsZk7HkPU+e=VTb3A@mail.gmail.com>
Subject: Re: [PATCH v2] mfd: mt6370: Add the out-of-bound check to prevent the
 null pointer
To:     cy_huang <u0084500@gmail.com>
Cc:     lee@kernel.org, matthias.bgg@gmail.com, chiaen_wu@richtek.com,
        cy_huang@richtek.com, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
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

On Fri, Oct 21, 2022 at 5:17 AM cy_huang <u0084500@gmail.com> wrote:
>
> From: ChiYuan Huang <cy_huang@richtek.com>
>
> This potential risk could happen at regmap_raw_read() or
> regmap_raw_write() when accessing the over-bound register address.
>
> For testing, I try to reproduce it with a testing attribute file.
> Below's the issue trace log.

It looks like you randomly cut the trace.
It's not what I meant and documentation suggests.

> [41.314358] pc : i2c_smbus_xfer+0x58/0x120
> [41.314371] lr : i2c_smbus_read_i2c_block_data+0x74/0xc0
> [41.399677] Call trace:
> [41.402153]  i2c_smbus_xfer+0x58/0x120
> [41.405956]  i2c_smbus_read_i2c_block_data+0x74/0xc0
> [41.410991]  mt6370_regmap_read+0x40/0x60 [mt6370]
> [41.415855]  _regmap_raw_read+0xe4/0x278
> [41.419834]  regmap_raw_read+0xec/0x240
> [41.423721]  rg_bound_show+0xb0/0x120 [mt6370]
> [41.428226]  dev_attr_show+0x3c/0x80
> [41.431851]  sysfs_kf_seq_show+0xc4/0x150
> [41.435916]  kernfs_seq_show+0x48/0x60
> [41.439718]  seq_read_iter+0x11c/0x450
> [41.443519]  kernfs_fop_read_iter+0x124/0x1c0
> [41.447937]  vfs_read+0x1a8/0x288
> [41.451296]  ksys_read+0x74/0x100
> [41.454654]  __arm64_sys_read+0x24/0x30
> [41.458541]  invoke_syscall+0x54/0x118
> [41.462344]  el0_svc_common.constprop.4+0x94/0x128
> [41.467202]  do_el0_svc+0x3c/0xd0
> [41.470562]  el0_svc+0x20/0x60
> [41.473658]  el0t_64_sync_handler+0x94/0xb8
> [41.477899]  el0t_64_sync+0x15c/0x160
> [41.481614] Code: 54000388 f9401262 aa1303e0 52800041 (f9400042)
> [41.487793] ---[ end trace 0000000000000000 ]---

...

> If there's still something improper, please kindly correct me.

https://www.kernel.org/doc/html/latest/process/submitting-patches.html#backtraces-in-commit-messages

-- 
With Best Regards,
Andy Shevchenko
