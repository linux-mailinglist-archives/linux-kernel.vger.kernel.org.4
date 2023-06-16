Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B890F732F88
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 13:11:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344830AbjFPLLo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 07:11:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344641AbjFPLLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 07:11:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 959D8123
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 04:11:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 218D661901
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 11:11:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DCA0C433C9;
        Fri, 16 Jun 2023 11:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686913893;
        bh=E3LSyICTfe08vvM/D5ylLdhNYeKjU8LGVjDE3PyCk+g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B22vBA/ZCwxWs9Y5gC7wCpYZ5DCL9Mih0/HcCZiti1e2yBTN6RTCMOhfM6tkP1mZp
         w+LENWICxwdQ/EgrWN9zkBCc2gNhxEfNfzEKMPl9T6k2W5s16L1i8h/WomjzYByoGm
         s1fsfOvnHh0HEdtr9Awjql+3aAmX+kLWBcbCzdek=
Date:   Fri, 16 Jun 2023 13:11:30 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Alison Wang <alison.wang@nxp.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Leo Li <leoyang.li@nxp.com>, Forrest Shi <xuelin.shi@nxp.com>,
        "X.F. Ren" <xiaofeng.ren@nxp.com>, Feng Guo <feng.guo@nxp.com>
Subject: Re: [EXT] Re: [PATCH 0/8] ethosu: Add Arm Ethos-U driver
Message-ID: <2023061638-rounding-swinger-5658@gregkh>
References: <20230616055913.2360-1-alison.wang@nxp.com>
 <2023061647-upward-petty-7695@gregkh>
 <AM9PR04MB89076472B9A29DDFFB2F958CF458A@AM9PR04MB8907.eurprd04.prod.outlook.com>
 <2023061646-coil-broadly-9efc@gregkh>
 <AM9PR04MB8907BE77F4F57A89883B1CBDF458A@AM9PR04MB8907.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM9PR04MB8907BE77F4F57A89883B1CBDF458A@AM9PR04MB8907.eurprd04.prod.outlook.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 16, 2023 at 10:47:56AM +0000, Alison Wang wrote:
> On Fri, Jun 16, 2023 at 08:26:28AM +0000, Alison Wang wrote:
> >
> > On Fri, Jun 16, 2023 at 01:59:05PM +0800, Alison Wang wrote:
> > > This series contains Arm's NPU Ethos-U driver for NXP i.MX93 platform.
> > >
> > > Ethos-U Linux driver is to provide an example of how a rich
> > > operating system like Linux can dispatch inferences to an Arm
> > > Cortex-M subsystem, consisting of an Arm Cortex-M and an Arm Ethos-U NPU.
> >
> > What is an "inference"?
> > [Alison Wang] The inference here means machine learning inference. It
> > is the process of running data points into a machine learning model to
> > calculate an output such as a single numerical score. For example, we
> > use this driver, user space application and Cortex-M firmware to complete an inference about image classification.
> 
> Nice, so why isn't this under drivers/accel/ then?  Does it not need that framework?
> [Alison Wang] This driver doesn't need that framework.

Odd quoting style...

Anyway, why not use that famework?  That's what that subsystem is for,
so you are going to have to document why this does not fit into that
model at all and you need your own interface instead.

thanks,

greg k-h
