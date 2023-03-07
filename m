Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E40A66AD7A5
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 07:51:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230362AbjCGGvZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 01:51:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjCGGvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 01:51:23 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B375F468F;
        Mon,  6 Mar 2023 22:51:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2DBF961208;
        Tue,  7 Mar 2023 06:51:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1052AC433D2;
        Tue,  7 Mar 2023 06:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1678171881;
        bh=h/CaBckKm3z5ztXd6B0Mn6OQ+5wb+S8Te9e8g3UVM1k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=olhoTyBJB3hEYivYW+BJ7y0DpdIgqkj3tlGcvVhMqkqY2d/GXx6flaIVrukO/DzdY
         5iQ6SgnfjQaaetFly+0O71P0QzG5BeHFN6g1bYrhcSG37D1eSd6tBIS8JOY/8ZqgqH
         GHuK26LbgtVIGCYukgEhtKxdy64fsRjU/Fd0Un4g=
Date:   Tue, 7 Mar 2023 07:51:18 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Rob Herring <robh@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>, kernel-team@android.com,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] serdev: Set fwnode for serdev devices
Message-ID: <ZAbe5hDZc7wJ0Lok@kroah.com>
References: <20230302023509.319903-1-saravanak@google.com>
 <2cc752fb-a25d-0789-0fad-54b99f08ced7@i2se.com>
 <CAGETcx_nCdm2WYLC7h1s8i9tnHc_LcHk2oZUQ0sUDr-PBsUWDg@mail.gmail.com>
 <faad8810-7aa4-e122-f497-73553feb8bcd@gmail.com>
 <CAGETcx_crW9BJmUoVJv1iU-KTr+9WPp_bpfrKoxzQiJGpqDgAA@mail.gmail.com>
 <CAGETcx8e4eUqXPrKTxjJWENs2iwP-d3L_EK4Qp-pit0hrm9FaA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGETcx8e4eUqXPrKTxjJWENs2iwP-d3L_EK4Qp-pit0hrm9FaA@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 06, 2023 at 08:47:48PM -0800, Saravana Kannan wrote:
> On Thu, Mar 2, 2023 at 10:07 AM Saravana Kannan <saravanak@google.com> wrote:
> >
> > On Thu, Mar 2, 2023 at 9:51 AM Florian Fainelli <f.fainelli@gmail.com> wrote:
> > >
> > >
> > >
> > > On 3/2/2023 9:20 AM, Saravana Kannan wrote:
> > > > On Thu, Mar 2, 2023 at 9:01 AM Stefan Wahren <stefan.wahren@i2se.com> wrote:
> > > >>
> > > >> Hi Saravana,
> > > >>
> > > >> Am 02.03.23 um 03:35 schrieb Saravana Kannan:
> > > >>> This allow fw_devlink to do dependency tracking for serdev devices.
> > > >>>
> > > >>> Reported-by: Florian Fainelli <f.fainelli@gmail.com>
> > > >>> Link: https://lore.kernel.org/lkml/03b70a8a-0591-f28b-a567-9d2f736f17e5@gmail.com/
> > > >>> Cc: Stefan Wahren <stefan.wahren@i2se.com>
> > > >>> Signed-off-by: Saravana Kannan <saravanak@google.com>
> > > >>
> > > >> since this fixes an issue on Raspberry Pi 4, shouldn't this be mentioned
> > > >> in the commit message and providing a Fixes tag?
> > > >
> > > > So RPi 4 was never creating a device links between serdev devices and
> > > > their consumers. The error message was just a new one I added and we
> > > > are noticing and catching the fact that serdev wasn't setting fwnode
> > > > for a device.
> > > >
> > > > I'm also not sure if I can say this commit "Fixes" an issue in serdev
> > > > core because when serdev core was written, fw_devlink wasn't a thing.
> > > > Once I add Fixes, people will start pulling this into stable
> > > > branches/other trees where I don't think this should be pulled into
> > > > older stable branches.
> > >
> > > That is kind of the point of Fixes: tag, is not it? It is appropriate to
> > > list a commit that is not specific to serdev, but maybe a particular
> > > point into the fw_devlink history.
> >
> > I don't want to pick an arbitrary point in fw_devlink as I don't want
> > people picking this up with some old version of fw_devlink and having
> > to support it there.
> >
> > > Given this did not appear to have a
> > > functional impact, we could go without one.
> >
> > This is my take too.
> >
> > Greg/Rob,
> >
> > If you really want a Fixes here, can you please just add it instead of
> > a v2 patch just for that? You can use this commit:
> > 3fb16866b51d driver core: fw_devlink: Make cycle detection more robust
> 
> Rob/Greg,
> 
> Can you pick this up for 6.3-rc2 please?

Will do, my queue is huge at the moment, it might be -rc3...
