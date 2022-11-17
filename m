Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE57D62D056
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 02:00:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238754AbiKQBAW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 20:00:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238982AbiKQBAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 20:00:07 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46F5D6A742
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 16:59:59 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id gv23so1394813ejb.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 16:59:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=S3aBmIu2GAscMgHpQ7LhFXU7lgU27PZREOd7olyT2fU=;
        b=cQo2wWyM06EVhdkBIbXN7wK/eL8GGmlXPWa671OgKIkSJAo5mfPZxWgsvUbSuS5Y9O
         64VIx5AItYZhftFYyU3QvyBdu+R87tzyVAN9WJ0ezn0BtGZtzVEyJYvRRGcm39bf0aPT
         x/LlPLBLDswwczVy2LPICOflUw2V4MQFz1BYI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S3aBmIu2GAscMgHpQ7LhFXU7lgU27PZREOd7olyT2fU=;
        b=ipe5169dYsCADhWAAe4TABjW1L64vtH2FzW4aEyuhWd1OVDO4Fnow2ByizfPVKGvT3
         vtDl6kfE7IjDv+PP2rZ/+xDFjLYIXD9X1qp2QMgNXRjtB+WmlPQ+JI1ZhaMMKRNZIVW4
         42tF9ieT9qz9ia9TriH/dkuCNH9cj8V/KUtqnJcS0UjubwiobwapsdVMtJr5bT75mjBG
         RoTJtHc308DrCP22Gmn1l836nj6dbYC7wr8+zfB2U1FQOMxd0yRmfGVPwB8YcfVnzj0c
         9+6JwXc9tdWgILb7N9FnTQdABgkYXZilR1ByyYIUxAmOM7vlMzRKpY+HnZuTxw/iBcS1
         dzTQ==
X-Gm-Message-State: ANoB5pmGvnNxCJIN2JT1fms4az3NNRL+prDSM2ZcVxNvKssGsaH4sT5B
        XvOo0Nd4K4wisYonECDIOpN/4MjIdmEsBYw3
X-Google-Smtp-Source: AA0mqf59q5vzyTUGa62lR3LNQjTdSdWHrsU06O1u3+RPXLlwLjq5VpjAtJGeZ1Pror4H2kvyGHqDcQ==
X-Received: by 2002:a17:906:a257:b0:7ae:3f79:4d0a with SMTP id bi23-20020a170906a25700b007ae3f794d0amr316603ejb.120.1668646796454;
        Wed, 16 Nov 2022 16:59:56 -0800 (PST)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com. [209.85.128.47])
        by smtp.gmail.com with ESMTPSA id fi11-20020a056402550b00b00461c1804cdasm8201325edb.3.2022.11.16.16.59.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Nov 2022 16:59:55 -0800 (PST)
Received: by mail-wm1-f47.google.com with SMTP id c3-20020a1c3503000000b003bd21e3dd7aso3265720wma.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 16:59:54 -0800 (PST)
X-Received: by 2002:a7b:c4d8:0:b0:3cf:b0ed:de9d with SMTP id
 g24-20020a7bc4d8000000b003cfb0edde9dmr3518370wmk.188.1668646794601; Wed, 16
 Nov 2022 16:59:54 -0800 (PST)
MIME-Version: 1.0
References: <20221116162152.193147-1-john.ogness@linutronix.de> <20221116162152.193147-15-john.ogness@linutronix.de>
In-Reply-To: <20221116162152.193147-15-john.ogness@linutronix.de>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 16 Nov 2022 16:59:42 -0800
X-Gmail-Original-Message-ID: <CAD=FV=U_sTtbuKeyoE6m4OznnQyPGaMKC6+NMOjH9h8zSD092g@mail.gmail.com>
Message-ID: <CAD=FV=U_sTtbuKeyoE6m4OznnQyPGaMKC6+NMOjH9h8zSD092g@mail.gmail.com>
Subject: Re: [PATCH printk v5 14/40] kdb: use srcu console list iterator
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Aaron Tomlin <atomlin@redhat.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        kgdb-bugreport@lists.sourceforge.net,
        Aaron Tomlin <atomlin@atomlin.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Nov 16, 2022 at 8:22 AM John Ogness <john.ogness@linutronix.de> wrote:
>
> Guarantee safe iteration of the console list by using SRCU.
>
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> Reviewed-by: Petr Mladek <pmladek@suse.com>
> Reviewed-by: Aaron Tomlin <atomlin@atomlin.com>
> ---
>  kernel/debug/kdb/kdb_io.c | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)

Without becoming an expert on this whole series, this seems reasonable to me.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
