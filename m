Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 687AD5F8D20
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Oct 2022 20:24:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbiJISYY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 14:24:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbiJISYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 14:24:20 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A0AC22B16
        for <linux-kernel@vger.kernel.org>; Sun,  9 Oct 2022 11:24:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 8C68BCE0F51
        for <linux-kernel@vger.kernel.org>; Sun,  9 Oct 2022 18:24:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96FDCC433C1;
        Sun,  9 Oct 2022 18:24:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1665339856;
        bh=y17/edWAbKDZQXeYm6vmcgJncyVJkeZZwuIW9jSu/RA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Pb3Y5bA5Rr/43eN82Z4h9fIkiBsUU2GZ+A/h5O8zYtvubAY1thG2HQgjNpXaGLDlb
         WRdlfJ77lrRAZb+3EYU77K6fnyFOlhGoVI00soPfYAXlRHMV6MCB94kuJQx0yLXwbe
         5L6Bke5dLE5s/H0+yPquXpc2bGki6VSqY/Hb5zac=
Date:   Sun, 9 Oct 2022 20:24:58 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Soha Jin <soha@lohu.info>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] string: add match_string_nocase() for
 case-insensitive match
Message-ID: <Y0MR+uSDEm2bPgcD@kroah.com>
References: <20221009162155.1318-1-soha@lohu.info>
 <20221009162155.1318-2-soha@lohu.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221009162155.1318-2-soha@lohu.info>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 10, 2022 at 12:21:53AM +0800, Soha Jin wrote:
> Sometimes we want to make a case-insensitive comparison with strings, like
> checking compatible devices in fwnode properties, so this commit abstracts
> match_string to __match_string with a compare function. The original
> match_string will call __match_string with strcmp, and the new
> match_string_nocase will call it with strcasecmp.

Wait, no, fwnode properties are case sensitive, why are you allowing
that to be changed?  That sounds like broken firmware to me, right?

thanks,

greg k-h
