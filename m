Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CC726AA59A
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 00:28:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbjCCX2k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 18:28:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbjCCX2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 18:28:38 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C16F0F970
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 15:28:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7E764B81928
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 23:28:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1082C433D2;
        Fri,  3 Mar 2023 23:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1677886114;
        bh=ZTKHiA7szHOvOhjA3ud+/tRtXeXi1U4d2tB3FjcWrLE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=xz+hEPzI6vAGTikNV2NSPsJ4d5THUdQvR2muRqIwfTD9Uwrj+tgBf//RwUieK4SAm
         /kQMDv8eB1/RrOq8dSLpN9vpHETS1lzDu0vt8jIXQBXtjdFO05sDg8TsShTIwOJI+w
         lf9n2gLk3sMoL1bZcm5Wf0xAqfSYq+H8WG/htIH0=
Date:   Fri, 3 Mar 2023 15:28:33 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Minchan Kim <minchan@kernel.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCHv3 2/4] zsmalloc: fine-grained inuse ratio based fullness
 grouping
Message-Id: <20230303152833.24d7a42102bd712e09f95cd5@linux-foundation.org>
In-Reply-To: <CAJD7tkbhy=JUFsFbGuG7OKgEcLSdCaBBtL-bZn92sP6Wk_sN4A@mail.gmail.com>
References: <20230303073130.1950714-1-senozhatsky@chromium.org>
        <20230303073130.1950714-3-senozhatsky@chromium.org>
        <CAJD7tka5VnRBUnpzoAX6eNuRocSbdGFBfmEx1pxQaDHT9UyMtg@mail.gmail.com>
        <CAJD7tkbhy=JUFsFbGuG7OKgEcLSdCaBBtL-bZn92sP6Wk_sN4A@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Mar 2023 08:58:55 -0800 Yosry Ahmed <yosryahmed@google.com> wrote:

> > > +               for (fg = ZS_INUSE_RATIO_70; fg <= ZS_INUSE_RATIO_99; fg++)
> > > +                       class_almost_full = zs_stat_get(class, fg);
> > > +               for (fg = ZS_INUSE_RATIO_10; fg < ZS_INUSE_RATIO_70; fg++)
> > > +                       class_almost_empty = zs_stat_get(class, fg);
> >
> > Aren't these supposed to be += ?
> 
> Looks like they are removed by a following patch anyway.

I'll fix that up anyway, to avoid a bisection hole.  And in case [patch 4/4]
gets dropped from the series or is later reverted or whatever.

