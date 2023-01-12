Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59849667ECA
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 20:12:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240439AbjALTMG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 14:12:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231891AbjALTLc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 14:11:32 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C1EF12AA6;
        Thu, 12 Jan 2023 10:57:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D9587B82011;
        Thu, 12 Jan 2023 18:57:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C303C433D2;
        Thu, 12 Jan 2023 18:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673549852;
        bh=aCwt87g5DP33eSulv5cE/E4TmVyVlpRjdU5dgxynFYk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=POGB8sK84IJJYFvOZv9ugRGQtOG+NM55cRn2+Q4evFsSYf8Bkt3EYv7abr6nizYpr
         5Web+iK9kcRs85cQDhf1ryetvDC7iMAtR6G/XtTZeQy6neZ3vhPACC3IyCCjfqAedz
         jCedBqvylv4pGS6OxCAN7csIp2/XSeDrolcQUO+p4oKTYjsjXk0jvrrhGHUxOKKYVN
         nR26j7ot/ZjvM2+kZqS4bcFschagOiIy64dsoFuC9EyN16Terc6tDSTo4bhG3C/Yu4
         wSqUtZR7nyHV3BeIPA5TR1/PmIRuCx+AUFEO8eUbmPwbOM0bhuwoxYmAG0f2lxeNDA
         Nd4y6/cqLgUrg==
Date:   Thu, 12 Jan 2023 10:57:31 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, pabeni@redhat.com,
        slipper.alive@gmail.com, stable-commits@vger.kernel.org
Subject: Re: Patch "net/ulp: prevent ULP without clone op from entering the
 LISTEN status" has been added to the 5.4-stable tree
Message-ID: <20230112105731.0da81d58@kernel.org>
In-Reply-To: <Y8AP6Lqo9sfX9Bb8@kroah.com>
References: <16735310493146@kroah.com>
        <Y8AP6Lqo9sfX9Bb8@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Jan 2023 14:49:28 +0100 Greg KH wrote:
> On Thu, Jan 12, 2023 at 02:44:09PM +0100, gregkh@linuxfoundation.org wrote:
> > 
> > This is a note to let you know that I've just added the patch titled
> > 
> >     net/ulp: prevent ULP without clone op from entering the LISTEN status
> > 
> > to the 5.4-stable tree which can be found at:
> >     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary  
> 
> Oops, nope, this broke the build for 5.4 and older kernels, now
> dropping.

There's no clone op, right? If you're willing to futz with it I think
you just need to remove the "and the ops don't have ->clone" part of
the conditions. Any presence of ops on older kernels should make us
bail.
