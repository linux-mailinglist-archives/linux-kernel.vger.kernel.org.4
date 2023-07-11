Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DACE74E8F4
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 10:23:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbjGKIXs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 04:23:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230258AbjGKIXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 04:23:43 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCB8F9C
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 01:23:42 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-3144098df56so6180797f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 01:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689063821; x=1691655821;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bWfhOL0U8rYGCbU7iO2bFZtG2lY8a2YNkFaUZYv9jzg=;
        b=gCgCeBr6Zy/nc46CehzJ2Eil+FbNOmR/caj3/gi+mpZ+/ezaTdY1MPDx/StX1WE7ya
         PK/l0Fs8K/LUSfeSONJ3KdstQ8TikZNXutIvhuVNoIJ5dsb40eBpFs4+wJCYjsceLWrn
         rvOQEJ+2Ew4igWAZv6WEohlQTeHGvEaot+qzEpGlE0IJgf41d2WLB8awkYdgS454n2/f
         q+TR2p9BwZA1aAtJZP8dG5AGC/tKDZEcW+eMRbtNqoOcfcE3wEnrhCSN6WPQTIQB4ECP
         rLmeg+Q/siSrB9hKYPrKiTeOL9qmX2r8knv1viHZExBqGWCAXyhd4OA9OL760rCCe+N3
         Zqhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689063821; x=1691655821;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bWfhOL0U8rYGCbU7iO2bFZtG2lY8a2YNkFaUZYv9jzg=;
        b=FoP2/QhRZTg85CaEQTRObD1s8fJpMWOkoIDjrms2yQ635PD9IxxTqwtg/IuO/XDw3Y
         vXUv9L+ZrmisF7+UF+2GExlycVVho4OZNStqQuDeqsH/Q0t3EqEOURnBWGmrr6ZAUPED
         ivh0PCNvzU2IBDaQpouLsshqsBqMaEdoNdL0fw2ZQ+swEh4ueXplkvI/8q/NYpcNcMb0
         2xRejiu3X4azS2XZbSpv3aklSZZwHNTzRwLkfdpO79VaWZDPJVkV701XvR6qxjrCY3ck
         9VBQYcQytagfteQKP9gdwCHwrTH3qefuWWUtwf/3cxLkCWYpNeJKADmR0jRs+rr7nTpc
         PwUA==
X-Gm-Message-State: ABy/qLbXrZtGtlNnSuzd05Xzmci5hdibQLgUxK47GmHmfe3DIGOT6AeZ
        JZSU98bTGQuxrh5Tu2Gib3I1NQ==
X-Google-Smtp-Source: APBJJlFW5hJ233s0Ak0LbKmIutem+TONDSgNwOWCndaPsJufSxYq8e30lFidKzGMpIoA3n3urToyNA==
X-Received: by 2002:a5d:4bc6:0:b0:314:71a5:c103 with SMTP id l6-20020a5d4bc6000000b0031471a5c103mr12215472wrt.61.1689063821184;
        Tue, 11 Jul 2023 01:23:41 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id r8-20020a056000014800b0030fa3567541sm1579223wrx.48.2023.07.11.01.23.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 01:23:40 -0700 (PDT)
Date:   Tue, 11 Jul 2023 09:23:39 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Jason Wessel <jason.wessel@windriver.com>,
        Douglas Anderson <dianders@chromium.org>,
        Aaron Tomlin <atomlin@atomlin.com>,
        kgdb-bugreport@lists.sourceforge.net
Subject: Re: [PATCH printk v2 1/5] kdb: do not assume write() callback
 available
Message-ID: <20230711082339.GA26224@aspen.lan>
References: <20230710134524.25232-1-john.ogness@linutronix.de>
 <20230710134524.25232-2-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230710134524.25232-2-john.ogness@linutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 10, 2023 at 03:51:20PM +0206, John Ogness wrote:
> It is allowed for consoles to provide no write() callback. For
> example ttynull does this.
>
> Check if a write() callback is available before using it.
>
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> Reviewed-by: Petr Mladek <pmladek@suse.com>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>

For v1 I shared an ack rather than queuing the patch. Although reading
the thread back it is possible that was based on a misunderstanding
(https://lore.kernel.org/lkml/20230309113020.GA78621@aspen.lan/ ).

Anyhow, it looks like you have designed the new series to be picked
individually?


Daniel.
