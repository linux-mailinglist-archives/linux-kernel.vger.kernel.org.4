Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4047F649AF2
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 10:19:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231484AbiLLJTY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 04:19:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231784AbiLLJSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 04:18:24 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1385FFAFE
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 01:17:39 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id h8-20020a1c2108000000b003d1efd60b65so4584380wmh.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 01:17:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DvqLjkQWzDmTIRIYzZtvS21E0eB9F/PhqJejB/D5W8A=;
        b=HhRQEW0Pz2DQPpZllLf6WVe7Zat4DnmpdrUJpyDzLSHUkYQw4vCkBuNsUZrTfPTaSq
         5Kv6Bt8iLAbQ6QWjBfbkr7jXP4qvJ9BhZm4Zo9WpO65I2EeyNc+H/P3/iRENmAFZdqGC
         +gK6bX7DOOgYyBvL9BeeGqNYNZ8KNPR+SntLh4ipAlphw4BiN7rTyz/vg4ZmCq0Dfz2H
         /IL0gjq8bqWdg0Men94Imn5hGGsKDDBqzPEroLOMChn/cfgNdmpyrrBf58nyPt9y2xyG
         mlUx5JajafX3WgcCWw4WVII1c3HfVhVcjVuWQZwxfkQiIYJJkjf0d/r+Zjd0T1RZIJAY
         RupQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DvqLjkQWzDmTIRIYzZtvS21E0eB9F/PhqJejB/D5W8A=;
        b=JiOlJE4nUStyHRRkj3e5+eC0qMtNKr4f8QvoeNurLzUDOjdOwtFxasag8CtluasBwv
         FK+FuWXeWyk7Nj3pnHdXZ4w4p4nOKt4Ab14Pdn1TnAf47ZiWxFiFShDNf3Ius61b4AGP
         ETiJmnyXgIV6b2RgqMshFyNbVN14hRQtXDANAsPZ7jYf9JxfU16wWWZ7uiwItBlLSrlf
         3cqHQHmhAgwi2GjvRcELfPkm1rQ0Q1KnSLUW77QirVF0p7XyxWIJhkrMzfWeOL24NqGO
         sBsscy1dVSIamZtARqglUsWaNWHtmBjoByazM6JlfHiT58HOshahcXscmeIl+jK/NFHW
         TbAw==
X-Gm-Message-State: ANoB5pkxs0rb1mItbN24MjOhgp1HwrSHy+N1RoX9boq49Hmbnq7SwDOb
        LIMhQn0acz9dfGHLV08KJzI40JEjCztWmaZNNpk=
X-Google-Smtp-Source: AA0mqf45QeQzpjckU/lzIapgnDwl0dVaPlXUoLcBccjsSY62MhPwJu5ml+jGzezbNuNXgNoTWN9zlsFZEk+s2KIB5Lk=
X-Received: by 2002:a05:600c:500f:b0:3c7:135a:2e4f with SMTP id
 n15-20020a05600c500f00b003c7135a2e4fmr74313281wmr.30.1670836658218; Mon, 12
 Dec 2022 01:17:38 -0800 (PST)
MIME-Version: 1.0
References: <20221212061836.3620-1-richard.xnu.clark@gmail.com> <Y5bI9ZbjpzNFpk/8@slm.duckdns.org>
In-Reply-To: <Y5bI9ZbjpzNFpk/8@slm.duckdns.org>
From:   richard clark <richard.xnu.clark@gmail.com>
Date:   Mon, 12 Dec 2022 17:17:26 +0800
Message-ID: <CAJNi4rNzSOyRt01G6=EYH-ojVHPaOLDJVnLbfeehXbcTxBEa=g@mail.gmail.com>
Subject: Re: [PATCH] workqueue: Prevent a new work item from queueing into a
 destruction wq
To:     Tejun Heo <tj@kernel.org>
Cc:     jiangshanlai@gmail.com, linux-kernel@vger.kernel.org
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

On Mon, Dec 12, 2022 at 2:23 PM Tejun Heo <tj@kernel.org> wrote:
>
> On Mon, Dec 12, 2022 at 02:18:36PM +0800, Richard Clark wrote:
> > Currently the __WQ_DRAINING is used to prevent a new work item from queueing
> > to a draining workqueue, but this flag will be cleared before the end of a
> > RCU grace period. Because the workqueue instance is actually freed after
> > the RCU grace period, this fact results in an opening window in which a new
> > work item can be queued into a destorying workqueue and be scheduled
> > consequently, for instance, the below code snippet demos this accident:
>
> I mean, this is just use-after-free. The same scenario can happen with

IMO, it's not exactly the use-after-free since no free action before
the end of RCU grace period, if it really is then the code will
trigger a kernel BUG:

    BUG: kernel NULL pointer dereference, address: 0000000000000000
    #PF: supervisor read access in kernel mode
    #PF: error_code(0x0000) - not-present page
    ...

Which can be easily observed for both non-RCU frees and RCU frees.

Thanks

> non-RCU frees or if there happens to be an RCU grace period inbetween. I'm
> not sure what's being protected here.
>
> Thanks.
>
> --
> tejun
