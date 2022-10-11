Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 447425FBBCB
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 22:06:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbiJKUGB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 16:06:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbiJKUF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 16:05:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7244340E10;
        Tue, 11 Oct 2022 13:05:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1A52A6118B;
        Tue, 11 Oct 2022 20:05:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06638C433C1;
        Tue, 11 Oct 2022 20:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1665518752;
        bh=BZb9QQ/EFfDQt70QeG7zs/Wcs3AWySfQkWFC7/8GlN8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qU5pednL5iYRFpBcNRyiaJAQ7BQWs2Ta6HZFXgzCwncmZqvvt2qTyX0YJ5Sx3+bxk
         b7An1+fJ09HRZMSeOMA89zFlg9dXGT7fmea6wneuWBlcLXzxeMSMFl6rOKaDeYy/xY
         iaU4bHxr9bAn4isZJP4iEmMvDaPDQKHt9FeAheBQ=
Date:   Tue, 11 Oct 2022 21:53:48 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Michael Grzeschik <mgr@pengutronix.de>
Cc:     Dan Vacura <w36195@motorola.com>, linux-usb@vger.kernel.org,
        Daniel Scally <dan.scally@ideasonboard.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Felipe Balbi <balbi@kernel.org>,
        Paul Elder <paul.elder@ideasonboard.com>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 0/3] uvc gadget performance issues
Message-ID: <Y0XJzGW/zlcCfffi@kroah.com>
References: <20221011183437.298437-1-w36195@motorola.com>
 <20221011194808.GH27626@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221011194808.GH27626@pengutronix.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 11, 2022 at 09:48:08PM +0200, Michael Grzeschik wrote:
> I also have an patch in the queue that will limit the sg support for
> devices with speed > HIGH_SPEED. Because of the overhead of the limited
> transfer payload of 1024*3 Bytes, it is possible that a simple memcpy
> will actually be fast enough. But for that patch I still have to make
> proper measurements. Btw. which USB speed are you transferring with?

For a payload that small, yes a memcpy is almost always faster.  I think
it's only much larger sizes that actually start to help with sg.

Can you submit this change now?  Odds are it will help out a lot of
systems.

thanks,

greg k-h
