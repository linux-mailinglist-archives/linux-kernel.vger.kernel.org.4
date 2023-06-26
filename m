Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B5F473D753
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 07:52:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbjFZFwM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 01:52:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjFZFwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 01:52:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C980FE43;
        Sun, 25 Jun 2023 22:52:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3CA3060C83;
        Mon, 26 Jun 2023 05:52:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39EA9C433C0;
        Mon, 26 Jun 2023 05:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687758725;
        bh=Q/Jx4hUMTo4PbW0+37Rx0hnjf5b3/J11HUc9EDQu0M8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EDnRus/73cUBJt1KENvBFHrmmhm+JYVyU2VV816M7TP16lKsYV+74Dmn3a78QfEBT
         1NhFxG8a2NJTiP76ziq0ougRA33fMSL3T2zGU8j3OlOzxrkOXMdeoI2mVa5GPj60Bx
         zcmX2JnnEnKzhswXn0t/0MVsGHKsCDtWZUJGByko=
Date:   Mon, 26 Jun 2023 07:52:02 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jan Beulich <jbeulich@suse.com>,
        Zhang Shurong <zhang_shurong@foxmail.com>
Cc:     xen-devel@lists.xenproject.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, jgross@suse.com
Subject: Re: [PATCH] xen: fix potential shift out-of-bounds in
 xenhcd_hub_control()
Message-ID: <2023062628-shame-ebook-56f2@gregkh>
References: <tencent_15DD79B42AD8A0D64A7CDC24D4FE6C85800A@qq.com>
 <1c8ff405-2bfe-37ff-42ba-aa4f81853475@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1c8ff405-2bfe-37ff-42ba-aa4f81853475@suse.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 26, 2023 at 07:48:05AM +0200, Jan Beulich wrote:
> On 25.06.2023 18:42, Zhang Shurong wrote:
> > --- a/drivers/usb/host/xen-hcd.c
> > +++ b/drivers/usb/host/xen-hcd.c
> > @@ -456,6 +456,8 @@ static int xenhcd_hub_control(struct usb_hcd *hcd, __u16 typeReq, __u16 wValue,
> >  			info->ports[wIndex - 1].c_connection = false;
> >  			fallthrough;
> >  		default:
> > +			if (wValue >= 32)
> > +				goto error;
> >  			info->ports[wIndex - 1].status &= ~(1 << wValue);
> 
> Even 31 is out of bounds (as in: UB) as long as it's 1 here rather
> than 1u.

Why isn't the caller fixed so this type of value could never be passed
to the hub_control callback?

thanks,

greg k-h
