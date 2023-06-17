Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C25CD73418C
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 16:00:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346197AbjFQOAT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 10:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346329AbjFQOAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 10:00:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31101172C
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 07:00:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BAB5260C36
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 14:00:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BECADC433C0;
        Sat, 17 Jun 2023 14:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687010405;
        bh=16Q1fD+TC/tzkSSYLPM02Yk89NzHUHa9D6kkl8csDrI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=No5rAoGBJIngpvTCaZ3eLJ0HW9pu6h8shBaF9MU8rgT4lQJs1dlr/HRVBU/32RpL5
         Jx1Yhj3eF7VAFUWfjP71KZ7LpSlroem6xUyGyZBKwKiuc8kIfbcofxPd88FNJ0QT5B
         K0u11APfWf3P2sMG14HB7qU1KDM8mie+lMGsfpRQ=
Date:   Sat, 17 Jun 2023 16:00:02 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Prathu Baronia <prathubaronia2011@gmail.com>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Khadija Kamran <kamrankhadijadj@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, dan.carpenter@linaro.org,
        error27@gmail.com, lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        oe-kbuild@lists.linux.dev
Subject: Re: [PATCH v5 1/2] axis-fifo: use devm_kasprintf() for allocating
 formatted strings
Message-ID: <2023061750-blog-curse-c1a3@gregkh>
References: <ZIiTL5bzMUgs3L5K@redkillpc>
 <20230616152602.33232-1-prathubaronia2011@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230616152602.33232-1-prathubaronia2011@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 16, 2023 at 08:55:59PM +0530, Prathu Baronia wrote:
> In various places, string buffers of a fixed size are allocated, and
> filled using snprintf() with the same fixed size, which is error-prone.
> 
> Replace this by calling devm_kasprintf() instead, which always uses the
> appropriate size. Allocate the device name with a unique identifier
> instead of a kernel address.

You are doing two different things here, one is changing the allocation
way, and the other is the name.  If one of those things turns out to
break something, we have to revert this whole thing.

So please make this two different changes, one to change to use
devm_kasprintf() and the second to change the naming scheme, ESPECIALLY
as you do not mention the name change in the subject line.  And that's
going to be a user-visible change, so you need to make that VERY
obvious.

thanks,

greg k-h
