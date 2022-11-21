Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CAD3632222
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 13:32:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231318AbiKUMcX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 07:32:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbiKUMcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 07:32:03 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41212B4804;
        Mon, 21 Nov 2022 04:30:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A00FEB80F02;
        Mon, 21 Nov 2022 12:30:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85B8FC433D6;
        Mon, 21 Nov 2022 12:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669033850;
        bh=jckmrG5WyHMue6fgjekmw1q+D7Nj07UdM99iFtf76Zk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GBBYM662aPITuBqPbRrmAeHsvtTMEuJ24Ek3b6zSpUFIrtWaxv8OBPnCip5wftHf1
         SzhQJkhq7JHFgfRayMPQ+DTn4XF9qNydHqa87Pu3cYO8qdhCZ8/vOIv6Dt/nS18xPA
         RAYDUfXeZX8BVYS5U99LlGPqbfk0FUKwpdWhGp2XIOiTw+g9OupcWcg7vC4FtNlcdm
         bLXqJRg3nbSLr0XyRWrqYS8IFb8Gn4+G+PdnGVjHKljens/kgBYHfYYzKYKy+BglB1
         mYkbbyfxuVuibOZQ4KzziC4HixhGFMCM/3bZntETFhi40BYgnLuvq3JfvcBQYp4Hzc
         MlgI4OD0YtMgQ==
Date:   Mon, 21 Nov 2022 12:30:45 +0000
From:   Lee Jones <lee@kernel.org>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     John Keeping <john@metanate.com>,
        Greg KH <gregkh@linuxfoundation.org>, balbi@kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH 1/1] usb: gadget: f_hid: Conduct proper refcounting on
 shared f_hidg pointer
Message-ID: <Y3tvdYKifmMKDhk8@google.com>
References: <20221117120813.1257583-1-lee@kernel.org>
 <Y3YuL8rSE9pNfIZN@kroah.com>
 <Y3Y7MlwV0UFcA3w8@google.com>
 <Y3ZlvyZoL+PzpbQX@rowland.harvard.edu>
 <Y3dIXUmjTfJLpPe7@google.com>
 <Y3er7nenAhbmBdBy@rowland.harvard.edu>
 <Y3e0zAa7+HiNVrKN@donbot>
 <Y3f0DJTOQ/8TVX0h@rowland.harvard.edu>
 <Y3piS43drwSoipD9@donbot>
 <Y3qSImZkZwCG1kA1@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y3qSImZkZwCG1kA1@rowland.harvard.edu>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 20 Nov 2022, Alan Stern wrote:

> On Sun, Nov 20, 2022 at 05:22:19PM +0000, John Keeping wrote:
> > On Fri, Nov 18, 2022 at 04:07:24PM -0500, Alan Stern wrote:
> > > On Fri, Nov 18, 2022 at 04:37:32PM +0000, John Keeping wrote:
> > > > I don't think it's at all simple to fix this - I posted a series
> > > > addressing the lifetime issues here a few years ago but didn't chase it
> > > > up and there was no feedback:
> > > > 
> > > > 	https://lore.kernel.org/linux-usb/20191028114228.3679219-1-john@metanate.com/
> > > > 
> > > > That includes a patch to remove the embedded struct cdev and manage its
> > > > lifetime separately, which I think is needed as there are two different
> > > > struct device objects here and we cannot tie their lifetimes together.
> > > 
> > > I still don't have a clear picture of what the real problem is.  Lee's 
> > > original patch description just said "external references are presently 
> > > not tracked", with no details about what those external references are. 
> > > Why not add just proper cdev_get() and cdev_put() calls to whatever code 
> > > handles those external references, so that they _are_ tracked?
> > > 
> > > What are the two different struct device objects?  Why do their 
> > > lifetimes need to be tied together?  If you do need to tie their 
> > > lifetimes somehow, why not simply make one of them (the one which is 
> > > logically allowed to be shorter-lived) hold a reference to the other?
> > 
> > The problem is that we have a struct cdev embedded in f_hidg but the
> > lifetime of f_hidg is not tied to any kobject so we can't solve this in
> > the right way by setting the parent kobject of the cdev.
> > 
> > While refcounting struct f_hidg is necessary, it's not sufficient
> > because the only way to keep it alive long enough for the final
> > kobject_put() on the embedded cdev is to tie the lifetime to a kobject
> > of its own and there is no suitable object as this is not the model
> > followed by gadget function instances.
> 
> I see.  The solution is simple: Embed a struct device in struct f_hidg, 
> and call cdev_device_add() to add the device and the cdev.  This will 
> automatically make the device the parent of the cdev, so the device's 
> refcount won't go to 0 until the cdev's refcount does.  Then you can tie 
> the f_hidg's lifetime to the device's, so the device's release routine 
> can safely deallocate the entire f_hidg structure.
> 
> The parent of the new struct device should be set to &gadget->dev.  If 
> you can't think of a better name for the device, you could simply append 
> ":I" to the parent's name, where I is the interface number, or even 
> append ":C.I" where C is the config number (like we do on the host 
> side).

Thanks for the suggestions Alan.

Not long finished speaking with Greg about this.  He seems okay with
the approach.  I'll knock something together and get a "v1" (*wink*)
out shortly.

-- 
Lee Jones [李琼斯]
