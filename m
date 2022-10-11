Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26E4B5FACAE
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 08:23:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbiJKGW5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 02:22:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbiJKGWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 02:22:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45DD688DF2;
        Mon, 10 Oct 2022 23:22:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3931E61089;
        Tue, 11 Oct 2022 06:21:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26C7BC433B5;
        Tue, 11 Oct 2022 06:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1665469311;
        bh=ZEn+9l/tLbnAqejF5hooJf26ogqUNObWamKwtHfGaAw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MV1nZhLog3CLEEINQ29wAaICGOCBYEFGmmAJOAB93L55BORkUhc7Lk9V15gZTxjy8
         Rp3DLoj4Nmfs9DrAAWoW5s4SCVLgLOhBIhBtP20B6lceAP3TCv6JHCFn6SaU4Co7sf
         UCciOXhBv7NtuNQe8WsQX3ROlNK3XDd0NLGFBZxw=
Date:   Tue, 11 Oct 2022 08:22:34 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Elliot Berman <quic_eberman@quicinc.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
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
Message-ID: <Y0ULqlIMKTc6gdeV@kroah.com>
References: <20220928195633.2348848-1-quic_eberman@quicinc.com>
 <20220928195633.2348848-15-quic_eberman@quicinc.com>
 <YzbePxTF8hRbWNRU@kroah.com>
 <14d0ff9f-60f3-71cc-ea42-ceee389298ac@quicinc.com>
 <Yz/YBDqqwBUlswgX@kroah.com>
 <615493a8-449d-b105-709e-0642dfb5359b@quicinc.com>
 <Y0R/QbysXa6ebNd8@kroah.com>
 <ca42d89e-9e19-0536-0951-2c123d898892@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca42d89e-9e19-0536-0951-2c123d898892@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 10, 2022 at 01:58:00PM -0700, Elliot Berman wrote:
> 
> 
> On 10/10/2022 1:23 PM, Greg Kroah-Hartman wrote:
> > On Sun, Oct 09, 2022 at 01:59:21PM -0700, Elliot Berman wrote:
> > > 
> > > > > > On 10/7/2022 12:40 AM, Greg Kroah-Hartman wrote:
> > > > On Thu, Oct 06, 2022 at 10:59:51PM -0700, Elliot Berman wrote:
> > > > > 
> > > > > "GH" is the shorthand we've been using for "Gunyah". I didn't find
> > > > > documentation for dynamically assigned char devices, but if it exists, I can
> > > > > add entry for ttyGH.
> > > > 
> > > > Why use a new name at all?  Why not stick with the existing tty names
> > > > and device numbers?
> > > > 
> > > 
> > > I can use hvc framework, although driver-level buffering is needed on
> > > both the get_chars/put_chars paths because:
> > 
> > I'm not asking about the framework (although that is a good question,
> > you need to document why this has to be new.)  I'm asking why pick a new
> > name?  You will not have a name conflict in your system with this device
> > with any other tty name right?
> > 
> 
> That's correct, I didn't see any other instances of "ttyGH" in kernel.

Do you see any instances of ttyS?  Any other existing name?  Why pick a
new name at all?

And if you do pick a new name, you need to document it really really
well, not bury it downn within the tty driver code.

thanks,

greg k-h
