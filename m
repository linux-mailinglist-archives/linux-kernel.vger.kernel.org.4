Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F03E9622F8B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 17:00:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbiKIQAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 11:00:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiKIQAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 11:00:53 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14773101C9;
        Wed,  9 Nov 2022 08:00:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B2E7EB81F29;
        Wed,  9 Nov 2022 16:00:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FDC4C433C1;
        Wed,  9 Nov 2022 16:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1668009650;
        bh=zrKocyoA9vOJPLuwCmUr/r5EilxVL2Mb3dwLxuOroZw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mGuDVJ3Tf054mVcwp8j38WsBwxdbHFORJu++gSPfcy0bd0ck8y1WHS9XsdlOSlYkM
         A4DUZ4F1h9blsWxKgD3OZIW6zO5SvN37+G2JDbVO3YeSVfybLbi4booX10/656JESH
         zK3MSwwLoMxS9PDgnnVoiwiG1R0n5WW5GhNZU+4c=
Date:   Wed, 9 Nov 2022 17:00:47 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Deepak R Varma <drv@mailo.com>
Cc:     Julia Lawall <julia.lawall@inria.fr>, outreachy@lists.linux.dev,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: fbtft: Use ARRAY_SIZE() to get argument count
Message-ID: <Y2vOrxwi1diR0JEY@kroah.com>
References: <Y1vZXUi0Bjiub8HZ@ubunlion>
 <Y1zXIjCe3LGwApWD@kroah.com>
 <Y11b0oCmle2pbRel@ubunlion>
 <alpine.DEB.2.22.394.2210291931590.2917@hadrien>
 <Y191LI7zKVRA5LEb@ubunlion>
 <Y1+YC5OuycA5hLFx@ubunlion>
 <7dc9b4d2-413-3f65-1381-b164d810c3ee@inria.fr>
 <Y2T/FA0Ws9ExS+uz@qemulion>
 <Y2UkwwUn+IaCq3wf@qemulion>
 <Y2vApJF0eNSkOQqP@qemulion>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2vApJF0eNSkOQqP@qemulion>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 09, 2022 at 08:30:52PM +0530, Deepak R Varma wrote:
> On Fri, Nov 04, 2022 at 08:12:11PM +0530, Deepak R Varma wrote:
> > On Fri, Nov 04, 2022 at 05:31:24PM +0530, Deepak R Varma wrote:
> > > On Mon, Oct 31, 2022 at 01:05:32PM +0100, Julia Lawall wrote:
> > > >
> > > >
> > > > I took a look, but it's pretty complex.  You could take the code and
> > > > reorganize it so that it is more readable, and then take the definition of
> > > > the ARRAY_SIZE macro, to better see what is going on.
> > > >
> > > > julia
> > > >
> > >
> > > Hello Greg, Julia,
> > > I was able to successfully build the fbtft object file for arm architecture as
> > > well. I used gcc 6.5.0 and 9.5.0 tool chains. It was successful using both. I
> > > have attached the build log from my machine for your reference.
> > >
> > > I am also looking at the .i file and rearrange the expanded macro to understand
> > > it. However, since it is built successfully, I am not sure if that is truly the
> > > problem area.
> > >
> > > Should I resend the patch and check if it still errors the kernel build bot?
> > > Anything else I can try?
> >
> > Looks like the change I proposed is causing nesting inside the write_reg
> > function due to additional set of { & } brackets for the __VA_ARGS__ symbol.
> >
> > Am I understanding it right?
> 
> Hello Julia, Greg,
> I am unable to reproduce this build failure on my local machine. I tried the X86
> and arm based build. I am unable to troubleshoot this further. Do you have any
> other suggestions? If not, I will drop this patch from my watch list.

Please just drop it, it is not a correct change to make.

thanks,

greg k-h
