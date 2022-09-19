Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74E185BC5A5
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 11:45:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbiISJpG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 05:45:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbiISJpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 05:45:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37667CE29
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 02:45:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C7F3D60FEE
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 09:45:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92121C433D6;
        Mon, 19 Sep 2022 09:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1663580700;
        bh=fRcmRGYuCxElmbVoEv4GLbgpAqtCZKtYkTbraNaqeMI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=l9xS8XubRv64qvvOST0HVGC9k6t3EzQu6oHrFk8KRyEaYZZ/VBoyPBXJbwr7AHoe+
         Li67RmtXa5eJegkzdXa3XT+DNWKNiCO1BqYgZqiq0Nk5j1nY2mw1YcEBr2TcgDO6iT
         I9jD+S6f/tNrujsB04aEykCo+/xNRH9MYHuAjDmw=
Date:   Mon, 19 Sep 2022 11:45:27 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Hyunwoo Kim <imv4bel@gmail.com>
Cc:     lkundrak@v3.sk, linux-kernel@vger.kernel.org, arnd@arndb.de,
        linux@dominikbrodowski.net
Subject: Re: [PATCH v4] char: pcmcia: scr24x_cs: Fix use-after-free in
 scr24x_fops
Message-ID: <Yyg6N+yS9YyAepFk@kroah.com>
References: <20220919093801.GA307492@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220919093801.GA307492@ubuntu>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 19, 2022 at 02:38:01AM -0700, Hyunwoo Kim wrote:
> A race condition may occur if the user physically removes the
> pcmcia device while calling open() for this char device node.
> 
> This is a race condition between the scr24x_open() function and
> the scr24x_remove() function, which may eventually result in UAF.
> 
> So, add a mutex to the scr24x_open() and scr24x_remove() functions
> to avoid race contidion of krefs.
> 
> Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
> Reported-by: kernel test robot <lkp@intel.com>

The robot did not report this original problem :(

> ---
>  drivers/char/pcmcia/scr24x_cs.c | 73 +++++++++++++++++++++++----------
>  1 file changed, 52 insertions(+), 21 deletions(-)

You failed to put below the --- line what changed from previous versions
as the documentation asks for.

thanks,

greg k-h
