Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61ABA6BD8A7
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 20:10:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbjCPTJ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 15:09:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbjCPTJ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 15:09:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 315AB1A95D;
        Thu, 16 Mar 2023 12:09:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BA13D620ED;
        Thu, 16 Mar 2023 19:09:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5B83C433EF;
        Thu, 16 Mar 2023 19:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1678993794;
        bh=8KIkizWvlt2DPvDyEONJ3fFdM3lCyHdam/VFNf/SBQo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HIdDWkf2BaGbG44tmdrdbzxf/o4IekXDsbNkKR/XNTGD50+CJpTHJlZIyN47Wa/o5
         4CnjtZkwxosA/o/PT6TuoEaUQ6mBjBeIouoz0oODGHSAhAmBn8lfNHW7RfAIb8HIqz
         +AO6lsSMVbHOfzv74S5FCo8APTsg/v6KNoS966FA=
Date:   Thu, 16 Mar 2023 20:09:51 +0100
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     Zheng Hacker <hackerzheng666@gmail.com>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        Zheng Wang <zyytlz.wz@163.com>,
        "valentina.manea.m@gmail.com" <valentina.manea.m@gmail.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "1395428693sheep@gmail.com" <1395428693sheep@gmail.com>,
        "alex000young@gmail.com" <alex000young@gmail.com>
Subject: Re: [PATCH v2] usbip: vudc: Fix use after free bug in vudc_remove
 due to race condition
Message-ID: <ZBNpf5X+y26+eKYf@kroah.com>
References: <20230316180940.1601515-1-zyytlz.wz@163.com>
 <a83b2f5f-732c-6d71-3e0c-1dce76076817@linuxfoundation.org>
 <CAJedcCyb_XP=X=2XzjKJ-ay=mzPdEJEdRsAcU2KbeaQPjLaW3g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJedcCyb_XP=X=2XzjKJ-ay=mzPdEJEdRsAcU2KbeaQPjLaW3g@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 17, 2023 at 02:27:05AM +0800, Zheng Hacker wrote:
> 在 2023年3月17日星期五，Shuah Khan <skhan@linuxfoundation.org> 写道：
> 
> > On 3/16/23 12:09, Zheng Wang wrote:
> >
> >> In vudc_probe, it calls init_vudc_hw, which bound &udc->timer with
> >> v_timer.
> >>
> >> When it calls usbip_sockfd_store, it will call v_start_timer to start the
> >> timer work.
> >>
> >> When we call vudc_remove to remove the driver, theremay be a sequence as
> >> follows:
> >>
> >> Fix it by shutdown the timer work before cleanup in vudc_remove.
> >>
> >> Note that removing a driver is a root-only operation, and should never
> >> happen.
> >>
> >> CPU0                  CPU1
> >>
> >>                       |v_timer
> >> vudc_remove          |
> >> kfree(udc);          |
> >> //free shost         |
> >>                       |udc->gadget
> >>                       |//use
> >>
> >> This bug was found by static analysis.
> >>
> >
> > Tell me which static analysis tool did you use to find this and
> > the output from the tool.
> 
> 
>      This is found by codeql，the rule is complicated. It     finally found
> there is no timer stop behavior in remove function.

When using tools like this, you are required to follow the rules in
Documentation/process/researcher-guidelines.rst

Please do so here.

thanks,

greg k-h
