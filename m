Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 852BE6ECCA0
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 15:08:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231818AbjDXNIQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 09:08:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231801AbjDXNIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 09:08:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0872149D0;
        Mon, 24 Apr 2023 06:08:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 26C09612CA;
        Mon, 24 Apr 2023 13:08:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DBAAC4339B;
        Mon, 24 Apr 2023 13:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1682341685;
        bh=MRtXNN7K2xxelZ/JoLLZMsrymk0qjan7oK/Hjqz/K7s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z7pBD1sH0r7g7xaRHXQ5z9Qq4Z1sZrN0xWvyH5RtHjsxRQ9dB/Axx8d016FPZVfL2
         UFm1+ckTwKYK6mkivsDLi5QuIZ6tZ5rB7ebh+mtkkK4quMRX+Hfa/qrpUrU9Jd8RrR
         DkUT5ttpIUMkl+s6UhRv68vxbx3VgMeqSKF6F8us=
Date:   Mon, 24 Apr 2023 15:08:03 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Peter Enderborg <peter.enderborg@sony.com>,
        Yingsha Xu <ysxu@hust.edu.cn>,
        Serge Semin <fancer.lancer@gmail.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: remove return value check of debugfs_create_dir()
Message-ID: <2023042423-ice-rice-e3d3@gregkh>
References: <20230423061155.2540-1-ysxu@hust.edu.cn>
 <eb3c6aa6-6820-4e94-8eb0-5abd3b627fcc@sirena.org.uk>
 <368e31ae-31b5-839f-72e3-20a27239cb0b@sony.com>
 <a4706089-399b-4663-9ac8-216f12ebe7ca@sirena.org.uk>
 <2023042421-landowner-magnitude-a38c@gregkh>
 <55ab40bb-8b3e-496d-bf45-6c4ebd01e43f@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55ab40bb-8b3e-496d-bf45-6c4ebd01e43f@sirena.org.uk>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 24, 2023 at 02:00:14PM +0100, Mark Brown wrote:
> On Mon, Apr 24, 2023 at 02:53:12PM +0200, Greg Kroah-Hartman wrote:
> > On Mon, Apr 24, 2023 at 01:32:14PM +0100, Mark Brown wrote:
> 
> > > There's issues with partially created debugfs structures getting in the
> > > way of people trying to debug things, just completely ignoring all
> > > errors can create confusion as the diagnostic information people believe
> > > is being shown to them ends up being partial or mistructured without any
> > > indication that this has happened.
> 
> > How do you end up with partially created debugfs structures?
> 
> The ones I've seen have been name collisions caused by for example the
> debugfs structure created being flatter than the device model structure,
> though obviously something unanticipated could come up.

Sure name collisions will happen, when people aren't precise about how
they create their debugfs files (I just had to insist on this type of
fixups for a USB patch last week.)  But, debugfs failures should never
stop a driver from working properly, only the debugging functionalities.
So there's no need to error out from debugfs errors as the only one
affected is the kernel developer involved, not users.

thanks,

greg k-h

