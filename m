Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE700719663
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 11:08:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232562AbjFAJIh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 05:08:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231941AbjFAJIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 05:08:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C059E7
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 02:08:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B924A63E4B
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 09:08:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEAC9C433EF;
        Thu,  1 Jun 2023 09:08:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685610513;
        bh=eQsVWXqridKFIaEbeSF6yMg35CDWIw0NC22i3fuLTWA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bpFWwZ/FRnXOyU0JxCUvQ3IhQSBHlIw20BG7Ay3b+MwO4OXPWc8K72WJRfr4PKURj
         hS/DwV1e8oUbGQ1dNyxneym5TCZOZ0WzHjIsOnC1AW7djpfrx9TyhDjmYZ17MaMXOq
         YmfnFXnj6aYNhHlRCXnngZshMjFjaf7gkLI1vDS4=
Date:   Thu, 1 Jun 2023 10:08:30 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Shreenidhi Shedi <yesshedi@gmail.com>
Cc:     dhowells@redhat.com, dwmw2@infradead.org,
        linux-kernel@vger.kernel.org, sshedi@vmware.com
Subject: Re: [PATCH v6 0/7] refactor file signing program
Message-ID: <2023060155-mustard-mating-32b7@gregkh>
References: <20230321193341.87997-1-sshedi@vmware.com>
 <0ae37bcc-4398-644b-a295-1245d73e5450@gmail.com>
 <2023053135-bubbling-commodore-3a7b@gregkh>
 <cefc1a42-725a-8afa-c222-f4df085ba6a2@gmail.com>
 <2023053148-ahead-overbite-863d@gregkh>
 <730c8712-1553-63e5-ffa1-d75a922f4a42@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <730c8712-1553-63e5-ffa1-d75a922f4a42@gmail.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 01, 2023 at 02:33:23PM +0530, Shreenidhi Shedi wrote:
> On Wed, 31-May-2023 22:20, Greg KH wrote:
> > On Wed, May 31, 2023 at 09:01:24PM +0530, Shreenidhi Shedi wrote:
> > > On Wed, 31-May-2023 20:08, Greg KH wrote:
> > > > On Tue, Apr 25, 2023 at 04:14:49PM +0530, Shreenidhi Shedi wrote:
> > > > > On Wed, 22-Mar-2023 01:03, Shreenidhi Shedi wrote:
> > > > > Can you please review the latest patch series? I think I have addressed your
> > > > > concerns. Thanks.
> > > > 
> > > > The big question is, "who is going to use these new features"?  This
> > > > tool is only used by the in-kernel build scripts, and if they do not
> > > > take advantage of these new options you have added, why are they needed?
> > > > 
> > > > thanks,
> > > > 
> > > > greg k-h
> > > 
> > > Hi Greg,
> > > 
> > > Thanks for the response.
> > > 
> > > We use it in VMware Photon OS. Following is the link for the same.
> > > https://github.com/vmware/photon/blob/master/SPECS/linux/spec_install_post.inc#L4
> > > 
> > > If this change goes in, it will give a slight push to our build performance.
> > 
> > What exactly do you mean by "slight push"?
> 
> Instead of invoking the signing tool binary for each module, we can pass
> modules in bulk and it will reduce the build time by couple of seconds.

Then why not modify the in-kernel build system to also do this, allowing
everyone to save time and money (i.e. energy)?

Why keep the build savings to yourself?

thanks,

greg k-h
