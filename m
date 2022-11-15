Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D5BB62AE00
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 23:14:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbiKOWOP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 17:14:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbiKOWOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 17:14:10 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70A9926AD8
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 14:14:09 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id 136so14839539pga.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 14:14:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XLOWo6R209h3wOJ/I/8aP6VzXrFyz+g8nPZ/Vk5wXJ8=;
        b=d59wIrlvBIGbXoebNK9+YGcYi8ddVquq+elPdqZbh3hzj6uGTxTLaNUMLDWY0eQwnz
         +yYuKNEuCjuy/g2PYZ13Q1Eih10CAvvdg+FHUKtcNWcCLBmOKcjQ+fcrpIW1Co5BErJ2
         og/ef+pU1/RjTtG2Tm8pvqg+z1XvopgYflNBEBUGTOFwG0AmFNpNiFCXTBfHuWffIQrn
         2g+KMo4BjfRDwjucWKKOGQQouPczEIV4C2Eyo/SB5TH4T8kKqujveApIAM5otzcS4cJM
         fomLYx+VpMo0fiq6Rxz0t8qnkMiYNAoVZ0Jv30NegL1EZ6vbOdvjW9oK6FzDf/2dPk9g
         2McQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XLOWo6R209h3wOJ/I/8aP6VzXrFyz+g8nPZ/Vk5wXJ8=;
        b=B7SLfJuwk0TI5vUr9u355qJENM6iDBqVlz78k8L5kSEZ+4TbKDn3/L+W24YUMdxZOp
         yrcDx/782hc/kMoU/VEpdiu5CtsPp2U+WI1MbP3+3vbbGB6LPZb26GRVvcD28VGHU0zk
         lQOegjMYwnBu0NZ1q6HxgB38G8Jv9qb7Nn63Rkmhh27rFt2iRv3vViS/EyKF/ZxuY5a8
         lWiUmUK7l69cy+K79/1AW0uz8FoURCmxPxtkZHnhHfqYvYabeQnJTwqkuYktHl9mE9eV
         yvN/oKtftBc9s4XLFN6JG/FnF+GFN5nyA4D/e167SOlUAtZJvtpE6P9kHIml7ropm2Yh
         HvYw==
X-Gm-Message-State: ANoB5pntnrBw9UbsKRoAPU5fVLZezO4ngrgWdvCLwT2OP0Iv+WzA0/NM
        C3jnRfJSu6DLE9b8guwwHsM=
X-Google-Smtp-Source: AA0mqf5pJIsxkbMQ58/I2IbRh0ZbDs3VNIak0zWu99K3953Itdiaa8u89gjZlwlZ0de3bMu6aJ7cfw==
X-Received: by 2002:a05:6a00:1c86:b0:56b:d027:214 with SMTP id y6-20020a056a001c8600b0056bd0270214mr20268914pfw.79.1668550448500;
        Tue, 15 Nov 2022 14:14:08 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id t18-20020aa79472000000b0056bd737fdf3sm9273178pfq.123.2022.11.15.14.14.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 14:14:08 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 15 Nov 2022 12:14:06 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Matthieu Castet <castet.matthieu@free.fr>,
        Stanislaw Gruszka <stf_xl@wp.pl>, ming.lei@redhat.com,
        Hillf Danton <hdanton@sina.com>,
        syzbot <syzbot+6bc35f3913193fe7f0d3@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] KASAN: use-after-free Read in
 kernfs_next_descendant_post (2)
Message-ID: <Y3QPLje5yYEZdPc6@slm.duckdns.org>
References: <000000000000c183f505eb721745@google.com>
 <20221021225228.1750-1-hdanton@sina.com>
 <Y2BRzPxroVylPLan@slm.duckdns.org>
 <Y3J8GKR905SZ84EE@bombadil.infradead.org>
 <Y3KDxpuoY4PB22vt@google.com>
 <Y3Pp7geXZRX3ltNg@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3Pp7geXZRX3ltNg@bombadil.infradead.org>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 15, 2022 at 11:35:10AM -0800, Luis Chamberlain wrote:
> request_firmware_nowait() is documented as requiring the caller to
> ensure to maintain the the reference count of @device during the
> lifetime of the call to request_firmware_nowait() and the callback.

My reading was that just holding the ref isn't enough. The code expects the
device to be not destroyed independent of the refcnt. I don't see how this
would be fixed by diddling with refcnt.

Thanks.

-- 
tejun
