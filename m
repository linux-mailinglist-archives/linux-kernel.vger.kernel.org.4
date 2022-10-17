Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4413600916
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 10:50:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbiJQIuA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 04:50:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbiJQIt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 04:49:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C2B1186CF
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 01:49:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8B32C60F33
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 08:49:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B99FC433C1;
        Mon, 17 Oct 2022 08:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1665996591;
        bh=pLF8lQGEgwutXLGl789CCAfUrFbxcq32mcAvhAYC9zQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AAQIWVNoB7mDalTZgehHPPBrR4d9A14wkkW7pnyF6dx9WSBqAIp8PHxA1Eo1CckSZ
         dkcA+KKOI5q9PjxHXD1MU0Dv/JV3/5pDurimMHo6vltr8nKvHUCQOfJG4NfdtQb2fJ
         ir0yD1KII0FxNrnphbPQ7bgLZK6xJq/ivZXkUsoA=
Date:   Mon, 17 Oct 2022 10:49:47 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-kernel@vger.kernel.org, rafael@kernel.org
Subject: Re: [PATCH] kobject: fix possible memory leak in
 kset_create_and_add()
Message-ID: <Y00XKw+Vs5Bo8jkZ@kroah.com>
References: <20221017023327.1793893-1-yangyingliang@huawei.com>
 <Y0zfPKAgQSrYZg5o@kroah.com>
 <9c2e91e1-dd07-8a4b-999c-9a2d26ee5f07@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c2e91e1-dd07-8a4b-999c-9a2d26ee5f07@huawei.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 17, 2022 at 04:13:03PM +0800, Yang Yingliang wrote:
> Hi,
> 
> On 2022/10/17 12:51, Greg KH wrote:
> > On Mon, Oct 17, 2022 at 10:33:27AM +0800, Yang Yingliang wrote:
> > > If kset_register() fails in kset_create_and_add(), the name allocated
> > > in kset_create() will be leaked.
> > How is kset_create_and_add() failing?  Is this in a real kernel, or
> > created with a fake fault injection?
> Inject fault while probing module qemu_fw_cfg, kset_create_and_add() may
> fail.

Ah good, it's never being hit in a real situation.  The next time you
submit patches that are found like this, please include this type of
information.

thanks,

greg k-h
