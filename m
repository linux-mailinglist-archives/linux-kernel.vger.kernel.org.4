Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8D865F74C7
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 09:40:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbiJGHkR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 03:40:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbiJGHkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 03:40:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 188253FA16;
        Fri,  7 Oct 2022 00:40:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A079461C0A;
        Fri,  7 Oct 2022 07:40:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BCCEC433D6;
        Fri,  7 Oct 2022 07:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1665128411;
        bh=GKlx4XpC4V4eNmFalCE62eQxE/iy5Kh4EpFqqS1kpA4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GZ9K3KULO5a/jrGADpCK92s3OF1ZGtLpoouHlBzykdZSDl0a2f+PvoVCMOjyp6M1m
         gRhvzgyze5T4gAMbmuIN2Rbf55/EcfXwHIOLLEBo7YdDr2wCeDU692KjAriyVZTObK
         bg1lFSw6AE8+Y1jZPiql6aBLW7DexwIQyoABzIrc=
Date:   Fri, 7 Oct 2022 09:40:52 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Elliot Berman <quic_eberman@quicinc.com>
Cc:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, devicetree@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 14/14] tty: gunyah: Add tty console driver for RM
 Console Services
Message-ID: <Yz/YBDqqwBUlswgX@kroah.com>
References: <20220928195633.2348848-1-quic_eberman@quicinc.com>
 <20220928195633.2348848-15-quic_eberman@quicinc.com>
 <YzbePxTF8hRbWNRU@kroah.com>
 <14d0ff9f-60f3-71cc-ea42-ceee389298ac@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14d0ff9f-60f3-71cc-ea42-ceee389298ac@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 06, 2022 at 10:59:51PM -0700, Elliot Berman wrote:
> > > + */
> > > +#define RSC_MGR_TTY_ADAPTERS		16
> > 
> > We can have dynamic tty devices, so I don't understand this comment.
> > What really is the problem here?
> > 
> 
> Yes, I see the confusion. Dynamic device addition of tty devices is
> supported. As I understand, you need to know the maximum number of lines
> that could be added, and that is limitation I was referring to.

What do you mean by "lines"?  That's not a tty kernel term.

> Is this comment better?
> 
> The Linux TTY code requires us to know ahead of time how many lines we
> might need. Each line here corresponds to a VM. 16 seems like a
> reasonable number of lines for systems that are running Gunyah and using
> the provided console interface.

Again, line?  Do you mean port?

> > > +	cons_data->tty_driver->driver_name = "gh";

KBUILD_MODNAME?

> > > +	cons_data->tty_driver->name = "ttyGH";
> > 
> > Where did you pick this name from?
> > 
> > Where is it documented?
> > 
> 
> "GH" is the shorthand we've been using for "Gunyah". I didn't find
> documentation for dynamically assigned char devices, but if it exists, I can
> add entry for ttyGH.

Why use a new name at all?  Why not stick with the existing tty names
and device numbers?

thanks,

greg k-h
