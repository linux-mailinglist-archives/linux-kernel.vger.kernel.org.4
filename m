Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CFDC63DC40
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 18:43:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbiK3RnS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 12:43:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbiK3RnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 12:43:15 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90E7E4E427
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 09:43:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 34EB1B81C5A
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 17:43:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5249EC433C1;
        Wed, 30 Nov 2022 17:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1669830191;
        bh=h1BzRWi3z5+fEMDy7NI8l+Tfel2ZkrLHsxCE4NCtSuE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iSKjjwnsMwZm5Qeny4IYIVYei6hX9O3ilAovTVoGFDfBS64HOugsUSjcRCQYwrk4N
         zN3Nww9Ww7oON7fMd11RTj/T2yPwRV1jQxRpYTDuz8/IRBC6XOV+zt6wx+Io7M5Zm6
         RiyHTHb9cxgzT0XsBzb9m0HYvfmH/HzIYNsyhP+M=
Date:   Wed, 30 Nov 2022 18:43:09 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        David Airlie <airlied@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>,
        Vitaly Lubart <vitaly.lubart@intel.com>,
        intel-gfx@lists.freedesktop.org
Subject: Re: [Intel-gfx] [PATCH v3 0/2] mei: add timeout to send
Message-ID: <Y4eWLWhCy2NLbENs@kroah.com>
References: <20221116124735.2493847-1-alexander.usyskin@intel.com>
 <Y4dmrP9RzXi7wrwJ@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y4dmrP9RzXi7wrwJ@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 30, 2022 at 09:20:28AM -0500, Rodrigo Vivi wrote:
> On Wed, Nov 16, 2022 at 02:47:33PM +0200, Alexander Usyskin wrote:
> > When driver wakes up the firmware from the low power state,
> > it is sending a memory ready message.
> > The send is done via synchronous/blocking function to ensure
> > that firmware is in ready state. However, in case of firmware
> > undergoing reset send might be block forever.
> > To address this issue a timeout is added to blocking
> > write command on the internal bus.
> > 
> > Introduce the __mei_cl_send_timeout function to use instead of
> > __mei_cl_send in cases where timeout is required.
> > The mei_cl_write has only two callers and there is no need to split
> > it into two functions.
> > 
> > V2: address review comments:
> >  - split __mei_cl_send and __mei_cl_send_timeout
> >  - add units to timeout KDoc
> >  - use MAX_SCHEDULE_TIMEOUT to squash wait to one macro
> > 
> > V3: - split the state fix into separate patch
> >     - document define unit
> >     - expand timeout KDoc
> 
> These 2 patches looks good to me now.
> 
> Greg, whenever you review it, please let me know if it is
> okay to me to push these through the drm-fixes, or if you
> prefer these to the mei branches.

These have been in my tree for over a week now, sorry.  No one told me
not to take them...

{sigh}

greg k-h
