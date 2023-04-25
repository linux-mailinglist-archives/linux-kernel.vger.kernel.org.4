Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C94016EDB32
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 07:31:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232854AbjDYFbU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 01:31:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjDYFbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 01:31:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B678F5FF3;
        Mon, 24 Apr 2023 22:31:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 51E2862B63;
        Tue, 25 Apr 2023 05:31:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D4F6C433EF;
        Tue, 25 Apr 2023 05:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1682400676;
        bh=kIRAPdXYCFJzfTvzQkwUjDYU35AND/M28n31JpTFWek=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JK6WNJWhAh5harM4ffD+b3FewvAo2EQqDTv4VQeeDlSSnwk4eBNZDYB744RH3+lBM
         CHVKSVUC7JnrLMgMB9dvSmfehoU9w48j8Opio9nl33Jq6ukhU5lIFDnRpCl9U8Or92
         gV/36/JhkzpByzdZpkinvboYc2XFcmgKAydC9EwA=
Date:   Tue, 25 Apr 2023 07:31:13 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Peter Enderborg <Peter.Enderborg@sony.com>
Cc:     Mark Brown <broonie@kernel.org>, Yingsha Xu <ysxu@hust.edu.cn>,
        Serge Semin <fancer.lancer@gmail.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: remove return value check of debugfs_create_dir()
Message-ID: <ZEdlofQJ6cfSOLmD@kroah.com>
References: <20230423061155.2540-1-ysxu@hust.edu.cn>
 <eb3c6aa6-6820-4e94-8eb0-5abd3b627fcc@sirena.org.uk>
 <368e31ae-31b5-839f-72e3-20a27239cb0b@sony.com>
 <a4706089-399b-4663-9ac8-216f12ebe7ca@sirena.org.uk>
 <2023042421-landowner-magnitude-a38c@gregkh>
 <3164e897-a423-3948-d50a-f2bdd4ad05e9@sony.com>
 <2023042431-crook-stable-5749@gregkh>
 <f58c04d3-df1d-1dad-03fa-50457f39d9dc@sony.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f58c04d3-df1d-1dad-03fa-50457f39d9dc@sony.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 24, 2023 at 03:54:13PM +0200, Peter Enderborg wrote:
> On 4/24/23 15:22, Greg Kroah-Hartman wrote:
> > On Mon, Apr 24, 2023 at 03:17:09PM +0200, Peter Enderborg wrote:
> >> On 4/24/23 14:53, Greg Kroah-Hartman wrote:
> >>>>> We can do things with the debug information without filesystem enabled.
> >>> What exactly do you mean by this?
> >>>
> >>>
> >> We can read out data from kernel with a ramdumper and analyse with crash.
> >>
> >> See https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/7/html/kernel_administration_guide/kernel_crash_dump_guide 
> >>
> >> If it is useful or not I can not say, but the dws->regset. is lost and can not be read with a post mortem debugger.
> > What is "dws"?  What is "regset"?
> 
> That is from the patch. It is used as an example.
> 
> 
> > What is the root problem here?
> 
> That it is a mater of taste.  It should not be a mater of taste.
> 
>       if (!dws->debugfs)
>                 return -ENOMEM;

Right here, you abort the normal operation of the driver if something
went wrong with debugfs, which is not a good idea.  That's the goal
here, nothing else.

thanks,

greg k-h
