Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5FA25F984C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 08:23:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231626AbiJJGXi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 02:23:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231450AbiJJGXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 02:23:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C7EA54CA3
        for <linux-kernel@vger.kernel.org>; Sun,  9 Oct 2022 23:23:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ACF1B60DD5
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 06:23:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB1C8C433C1;
        Mon, 10 Oct 2022 06:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1665383013;
        bh=v+/fx3CHymza6Mrw9mp7QVZMVSEPEAO3TCCmsNiSOQQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nfnZKNfDMgCPXqCIjpMS7Cx0CT97sHXMS2KLZmBJoM4GICoPp/cvNz/VsJuKQVyUz
         V51nrHHN2jpjRDR8UhssP07zr2R45/deMOUgQFgH2JinrXq/1sgm05vpIiRu1LcBpy
         yAxsFQ7Mm33HT+BrAK67dfRz1eb30jfes5F1tDq0=
Date:   Mon, 10 Oct 2022 08:24:16 +0200
From:   'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>
To:     Soha Jin <soha@lohu.info>
Cc:     "'Rafael J. Wysocki'" <rafael@kernel.org>,
        'Andy Shevchenko' <andriy.shevchenko@linux.intel.com>,
        'Daniel Scally' <djrscally@gmail.com>,
        'Heikki Krogerus' <heikki.krogerus@linux.intel.com>,
        'Sakari Ailus' <sakari.ailus@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] string: add match_string_nocase() for
 case-insensitive match
Message-ID: <Y0O6kDQ9Bxi9jMfo@kroah.com>
References: <20221009162155.1318-1-soha@lohu.info>
 <20221009162155.1318-2-soha@lohu.info>
 <Y0MR+uSDEm2bPgcD@kroah.com>
 <EE2940315EA6EAA4+1b3101d8dc54$c2f83680$48e8a380$@lohu.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <EE2940315EA6EAA4+1b3101d8dc54$c2f83680$48e8a380$@lohu.info>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 10, 2022 at 11:02:39AM +0800, Soha Jin wrote:
> Hi Greg,
> > On Mon, Oct 10, 2022 at 12:21:53AM +0800, Soha Jin wrote:
> > > Sometimes we want to make a case-insensitive comparison with strings,
> > > like checking compatible devices in fwnode properties, so this commit
> > > abstracts match_string to __match_string with a compare function. The
> > > original match_string will call __match_string with strcmp, and the
> > > new match_string_nocase will call it with strcasecmp.
> > 
> > Wait, no, fwnode properties are case sensitive, why are you allowing that to
> > be changed?  That sounds like broken firmware to me, right?
> > 
> 
> I am writing regarding the compatibility. In `of_device_is_compatible`, it
> uses `of_compat_cmp` which calls `strcasecmp` to match compatible property.
> 
> As the `fwnode_is_compatible` should be the replacement of the OF way, I
> think we should make the fwnode way and the OF way the same, i.e. either
> both case-insensitive or case-sensitive, to keep the consistency. I am
> afraid that make `of_compat_cmp` case-sensitive may break a great many of
> devices, that is why I am doing this.

Ok, but if you change this with the series, what will break?  What needs
this new case-insensitive comparison that does not work today?

thanks,

greg k-h
