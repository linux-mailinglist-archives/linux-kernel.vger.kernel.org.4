Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3DFE674BA1
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 06:03:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230448AbjATFDb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 00:03:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjATFDI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 00:03:08 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADEA6D88C9;
        Thu, 19 Jan 2023 20:50:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 779D5B82147;
        Thu, 19 Jan 2023 09:34:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A385FC433D2;
        Thu, 19 Jan 2023 09:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1674120859;
        bh=cTYhWhuoAArfN8ATkC/1fHyyuIoz5/V7W6EqeQ81PU4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NXyrMIIwdo9UdtGF5a0iaSMpO6tagJ8WWBUxVwSHRBIjLSGvE+Oavb4ePMGPwdqxB
         5nYP7pEBMNjs2Qar0Vj1npXLCKlZN+J8YCwSVyaEs5rCKIjSE1fvQq3KQoQiqku4vV
         zPJT33Koo7thoNF72zmUER2bBTs/gT/U09Zq0DYw=
Date:   Thu, 19 Jan 2023 10:34:16 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Umang Jain <umang.jain@ideasonboard.com>
Cc:     linux-staging@lists.linux.dev,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Adrien Thierry <athierry@redhat.com>,
        Dan Carpenter <error27@gmail.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [RFC PATCH 0/4] Drop custom logging
Message-ID: <Y8kOmFWG/korDc5Y@kroah.com>
References: <20230118115810.21979-1-umang.jain@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230118115810.21979-1-umang.jain@ideasonboard.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2023 at 05:28:06PM +0530, Umang Jain wrote:
> Drop custom logging from the vchiq interface.
> Mostly of them are replaced with dev_dbg and friends
> and/or pr_info and friends. 

Everything should be dev_*() calls, there should never be a pr_* call in
a driver.

> The debugfs log levels (in 4/4) are mapped to kernel
> logs levels (coming from include/linux/kern_levels.h)
> Would like some thoughts on it as I am not sure (hence
> marking this is RFC)

Do not have any "custom" debugging controls in a driver, they are not
special and should follow the whole rest of the kernel.  Just remove
them all and rely on the existing dev_*() calls instead please.

thanks,

greg k-h
