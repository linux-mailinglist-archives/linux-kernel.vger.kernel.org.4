Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8692D64AA39
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 23:27:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233484AbiLLW12 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 17:27:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233187AbiLLW1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 17:27:24 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83D5B1AF19
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 14:27:22 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id 142so9208041pga.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 14:27:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=400oaOIiyloicCpX8EtufmJp07eU8qBnM6If/zlJJTc=;
        b=e/P7FkSscCxR6APwFC13kxSYc/eEU4TdRpDho/1ff/fefcdVNgnatbXTaOBPlT/H2d
         pWZ617K+ur0lJyX8ZHezAr+couZ8J7mS4GKNVfE2Hl+oBL6LrQ4apf93mQ7pn6GPL2mO
         joF0TxzL1FWUHhHNnRbTAyKjKH5O0V4kZxBWW+RHHIwxbipGV1sfMf/ITDf0OPudA+9N
         pNb81TC92Mf75W+nsMcbbKh2S29O24kYpw2teCEIfgYNNvHUPlaV+1FUf7Pt1NUEfwVY
         xI9VbA8zxCQQBU1GxzQgvFNiPADM9qOwRu0krRhTsiXNXpL8Fuw7GYHAKVKROho7mGDg
         oKtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=400oaOIiyloicCpX8EtufmJp07eU8qBnM6If/zlJJTc=;
        b=2iCqtOAY0ZXzU8fI5CQ4Cl/FwSbBWIO3fKTT9Z1Mgy35lPUY7cn8ngdGizBI86D4/g
         SCN/YiNiRNcf1HbLxRmsL9rcPAs+NfG+bUfX0eazNYVloeR8VWuyWls3WKzPuqpeEmTZ
         vN1m4gxyrpsIKRarQ0iOOV0Aa0ZElmsjWsWSzzX1dTgILjgRpVEU2YvwUDWLgYrMhT+Z
         +wIedj3arbJ51bcE+5RLOGqF30/wPchSTgfvQ+1FeMCcTNedlW7suEwZIhKWHDjtjaKW
         jH4N7MtHTxkW2SzumTBKuxs6K6KBfStiXKbx/ljGI7wAwfB934ohuejBEcAXFUp9YPIu
         pWXw==
X-Gm-Message-State: ANoB5pnqqCT0NYhoWCizbrjVsep6na6D5VmVPZ0BThnp6fsJ3cd3tMIx
        Te8i2T0vUe4AcPeOJtPC5ds=
X-Google-Smtp-Source: AA0mqf6rtwlJR53yHfqPRsdSWi3k/GcYwywOOLy6NDgDSTWFXdjZEOFnSUOzXmLeVy/9Kl8JMjYXbw==
X-Received: by 2002:a62:3103:0:b0:576:14a4:b76a with SMTP id x3-20020a623103000000b0057614a4b76amr15930050pfx.34.1670884041723;
        Mon, 12 Dec 2022 14:27:21 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id z7-20020aa79587000000b005769436a23dsm6257177pfj.218.2022.12.12.14.27.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 14:27:21 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 12 Dec 2022 12:27:20 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     Richard Clark <richard.xnu.clark@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] workqueue: Prevent a new work item from queueing into a
 destruction wq
Message-ID: <Y5eqyErNGDD0tbF9@slm.duckdns.org>
References: <20221212061836.3620-1-richard.xnu.clark@gmail.com>
 <Y5bI9ZbjpzNFpk/8@slm.duckdns.org>
 <CAJhGHyA=qGtktv6BPavo5HRrDkcORqpkD3C7nhnxyFtt8WNJMg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJhGHyA=qGtktv6BPavo5HRrDkcORqpkD3C7nhnxyFtt8WNJMg@mail.gmail.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 12, 2022 at 02:48:25PM +0800, Lai Jiangshan wrote:
> On Mon, Dec 12, 2022 at 2:23 PM Tejun Heo <tj@kernel.org> wrote:
> >
> > On Mon, Dec 12, 2022 at 02:18:36PM +0800, Richard Clark wrote:
> > > Currently the __WQ_DRAINING is used to prevent a new work item from queueing
> > > to a draining workqueue, but this flag will be cleared before the end of a
> > > RCU grace period. Because the workqueue instance is actually freed after
> > > the RCU grace period, this fact results in an opening window in which a new
> > > work item can be queued into a destorying workqueue and be scheduled
> > > consequently, for instance, the below code snippet demos this accident:
> >
> > I mean, this is just use-after-free. The same scenario can happen with
> > non-RCU frees or if there happens to be an RCU grace period inbetween. I'm
> > not sure what's being protected here.
> 
> I think it is a kind of debugging facility with no overhead in the
> fast path.
> 
> It is indeed the caller's responsibility not to do use-after-free.
> 
> For non-RCU free, the freed workqueue's state can be arbitrary soon and
> the caller might get a complaint. And if there are some kinds of debugging
> facilities for freed memory, the system can notice the problem earlier.
> 
> But now is RCU free for the workqueue, and the workqueue has nothing
> different between before and after destroy_workqueue() unless the
> grace period ends and the memory-allocation subsystem takes charge of
> the memory.

idk, maybe? It seems kinda out of scope. Richard, can you update the patch
description and comment so that they clearly state that this is a debug aid
to help spotting user errors?

Thanks.

-- 
tejun
