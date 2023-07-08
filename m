Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94A3474BDE7
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 16:45:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbjGHOpT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jul 2023 10:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjGHOpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jul 2023 10:45:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4841C123;
        Sat,  8 Jul 2023 07:45:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BA05D60CF7;
        Sat,  8 Jul 2023 14:45:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62D5AC433C7;
        Sat,  8 Jul 2023 14:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688827515;
        bh=XgayjEk//+VzuZX+1PcLJY62DwKbUAeSfMwNwLvMmBI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JqIMA0D4/aNeHllP7aXLVh/cVJaHCAtMlQ+c4KpbsT1HRQLBG4kiVjIir94xKRplV
         OHxp3Gcch0pWZwBZKCP9HG4aJClITqTPTcUqWCAYNyFYal3CnmhnO+/FtZiGKsG843
         mQA296H3arm8joo6oB8RBH/JJNlrr6KqTTYhCokdlp8NSGsQqsiGirAie80QKWTeRV
         LuJoMi9/IbmPyUpz0PWUTkg6cttkl5utH4xIZkxrpHb4Wrxs1DX/bsq12xpTgMgItL
         sFu3jrz+S3LGnDeBoH8Lq0oHNmDRVljEfKeenOb9WmgYvH5uz5T6k31G9DfZctWHfc
         qjNU8mGDxCDwA==
Date:   Sat, 8 Jul 2023 15:45:06 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Cc:     Madhumitha Prabakaran <madhumithabiw@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-staging@lists.linux.dev, skhan@linuxfoundation.org,
        ivan.orlov0322@gmail.com
Subject: Re: [PATCH] Add struct ad9832_platform_data to the
 include/linux/iio
Message-ID: <20230708154506.01785c65@jic23-huawei>
In-Reply-To: <2023070858-brewing-outpour-764c@gregkh>
References: <20230707211553.GA110890@madhu-kernel>
        <2023070858-brewing-outpour-764c@gregkh>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 8 Jul 2023 13:10:29 +0200
Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> On Fri, Jul 07, 2023 at 04:15:53PM -0500, Madhumitha Prabakaran wrote:
> > Add struct ad9832_platform_data to the include/linux/iio
> > for maintaining code organization and clarity.
> > 
> > Signed-off-by: Madhumitha Prabakaran <madhumithabiw@gmail.com>
> > ---
> >  drivers/staging/iio/frequency/ad9832.c |  3 +--
> >  drivers/staging/iio/frequency/ad9832.h | 34 --------------------------
> >  include/linux/iio/frequency/ad9832.h   | 30 +++++++++++++++++++++++  
> 
> No, not yet, sorry.  Staging drivers should be self-contained, why does
> this .c file need a .h file at all anyway?  It should all just be in the
> .c file, can you do that instead?

This is an aged driver so still has definitions that would be included
from board files, hence the header.

So Madhumitha, if you are looking at getting this driver out of staging
(which would be great!) then first job is convert it from platform data
to device tree (or better yet generic firmware bindings using linux/property.h)
A side effect of that is the header would go away as equivalent job would be
done by the dt-bindings yaml file.

Jonathan

> 
> thanks,
> 
> greg k-h

