Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09F846D7FB7
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 16:38:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238514AbjDEOiZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 10:38:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238315AbjDEOiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 10:38:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E82675B90
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 07:38:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 756E962993
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 14:38:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E041C433A4;
        Wed,  5 Apr 2023 14:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1680705480;
        bh=TAtG4B5tFiggBEsy4rhkDWycj6tfQMutZHeZjsUAWWQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HAOcfidP9OBCM8O8X1pqT3yVrK/CjqtrpGu0qFaZzlWtFvqi66komKn+M0l/eYnUa
         gMsv8ORRrzfiV5i5CLKLbOzfUU0ZpB/iXxInWVUgfORRl25wPJsc32KHW/10QwR1Ol
         /arQFNgwUFg27BVZQxr9WLlPT7H83U/0obVTyXqg=
Date:   Wed, 5 Apr 2023 16:37:58 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Philipp Hortmann <philipp.g.hortmann@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [BUG] staging: rtl8192e: oops occurs when finding hardware
 rtl8192se
Message-ID: <2023040521-angelic-emptier-1367@gregkh>
References: <39dc735c-fd6d-e405-856c-788a52704d63@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39dc735c-fd6d-e405-856c-788a52704d63@gmail.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 02, 2023 at 05:00:13PM +0200, Philipp Hortmann wrote:
> Hi,
> 
> when I use the hardware rtl8192se the driver
> drivers/staging/rtl8192e/rtl8192e/r8192e_pci.ko detects that it should not
> run on this hardware and aborts.
> But when the driver is freeing the resources an oops occures. Find oops at
> the end of this Email.
> 
> When I comment out the following lines those errors disappear:
> cancel_delayed_work_sync(&ieee->hw_wakeup_wq);
> cancel_delayed_work_sync(&ieee->hw_sleep_wq);
> cancel_work_sync(&ieee->ips_leave_wq);
> 
> When I do an init before the cancel:
> INIT_DELAYED_WORK(&priv->rtllib->hw_wakeup_wq, (void *)rtl92e_hw_wakeup_wq);
> The oops are gone as well.
> 
> When I use cancel_delayed_work() instead of cancel_delayed_work_sync() it
> also works.
> 
> Can somebody give me a hint what the expected way is to solve this?

Is this a new thing, or has it always been there?

Why is the driver loading if you don't have hardware for it?  Or are you
manually loading it?

thanks,

greg k-h
