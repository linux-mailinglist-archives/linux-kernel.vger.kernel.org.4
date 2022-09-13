Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFC055B6EA2
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 15:53:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231820AbiIMNxm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 09:53:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231804AbiIMNxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 09:53:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 261DB4F387
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 06:53:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DA130B80ECE
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 13:53:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9FA7C433D6;
        Tue, 13 Sep 2022 13:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1663077212;
        bh=aup2nwX3kkZwT2fpjNlwE5UG1xXwi8SrWSRqDOplkjQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tfbWd0RBZMbNshwdkuNQn++nN9X0RLPcaK60s3OCX//2cV+ZO4x8O1r8IngPrFCEz
         ywY+7pZvFCQQR5xXodV7/KoWSnkkbifRNW4BKYyMTp8yTZu9yGMI6f0SOyV6Uy0K1X
         JwvOSOkxeGU/ibG51pKAWbCmCl2sj/cw61zPjs7g=
Date:   Tue, 13 Sep 2022 15:53:56 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Alex Elder <elder@kernel.org>, greybus-dev@lists.linaro.org,
        stable <stable@kernel.org>
Subject: Re: [PATCH] staging: greybus: audio_helper: remove unused and wrong
 debugfs usage
Message-ID: <YyCLdCsGouLie1/E@kroah.com>
References: <20220902143715.320500-1-gregkh@linuxfoundation.org>
 <YyCAaaLuT5s1Jhy2@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YyCAaaLuT5s1Jhy2@hovoldconsulting.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 13, 2022 at 03:06:49PM +0200, Johan Hovold wrote:
> On Fri, Sep 02, 2022 at 04:37:15PM +0200, Greg Kroah-Hartman wrote:
> > In the greybus audio_helper code, the debugfs file for the dapm has the
> > potential to be removed and memory will be leaked.  There is also the
> > very real potential for this code to remove ALL debugfs entries from the
> > system, and it seems like this is what will really happen if this code
> > ever runs.  This all is very wrong as the greybus audio driver did not
> > create this debugfs file, the sound core did and controls the lifespan
> > of it.
> 
> Yeah, this looks very broken indeed.
> 
> > So remove all of the debugfs logic from the audio_helper code as there's
> > no way it could be correct.  If this really is needed, it can come back
> > with a fixup for the incorrect usage of the debugfs_lookup() call which
> > is what caused this to be noticed at all.
> 
> > Cc: Johan Hovold <johan@kernel.org>
> > Cc: Alex Elder <elder@kernel.org>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: greybus-dev@lists.linaro.org
> > Cc: linux-staging@lists.linux.dev
> > Cc: stable <stable@kernel.org>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> I know this has already been applied, but still:
> 
> Acked-by: Johan Hovold <johan@kernel.org>

Thanks for the review, much appreciated.

greg k-h
