Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55D11673B64
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 15:12:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231621AbjASOMZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 09:12:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231462AbjASOLw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 09:11:52 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7D1D84556;
        Thu, 19 Jan 2023 06:10:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 555D061957;
        Thu, 19 Jan 2023 14:10:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33BF7C433D2;
        Thu, 19 Jan 2023 14:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1674137416;
        bh=5C216vTrkyYZuw9mA2HXMbg2MCiU0VRVvsY9D+/BvSo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mr3UcwsVawDuRc2Eii94Y7LgvepiVyXCMA6UDbP47wrHFkyeoyTDX9gwizJKUWNHD
         ctoRQkOXB0q7tXf0iIk9A0C6Jiyuq4fdvwSJPKI7hu/q6hfDAgPSqSwcGKXjuS2LIa
         aNLaNTjtE5kwyvuGgh30CP+pwwkwOpbbFmvBVmRM=
Date:   Thu, 19 Jan 2023 15:10:14 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, Alex Elder <elder@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-serial@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [RESEND PATCH 0/2] tty: serial: add and use a managed variant of
 uart_add_one_port()
Message-ID: <Y8lPRiEbUfkjS/P/@kroah.com>
References: <20221229161948.594102-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221229161948.594102-1-brgl@bgdev.pl>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 29, 2022 at 05:19:46PM +0100, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Resending rebased on top of v6.2-rc1
> 
> --
> 
> This series adds a managed variant of uart_add_one_port() and uses it in the
> qcom-geni-serial driver.
> 
> I've been asked by Greg to send it separately and he didn't seem to be
> impressed by the proposition of adding devres interfaces to the tty layer
> in general. I can only assume it has something to do with the ongoing
> discussion about the supposed danger of using devres interfaces in conjunction
> with exporting character devices to user-space.

That is correct.

> The bug in question can be triggered by opening a device file, unbinding the
> driver that exported it and then calling any of the system calls on the
> associated file descriptor.
> 
> After some testing I noticed that many subsystems are indeed either crashing
> or deadlocking in the above situation. I've sent patches that attempt to fix
> the GPIO and I2C subsystems[1][2]. Neither of these issues have anything to
> do with devres and all to do with the fact that certain resources are freed
> on driver unbind and others need to live for as long as the character device
> exists. More details on that in the cover letters and commit messages in the
> links.
> 
> I'd like to point out that the serial code is immune to this issue as before
> every operation, the serial core takes the port lock and checks the uart
> state. If the device no longer exists (when the uart port is removed, the
> pointer to uart_port inside uart_state is to NULL), it gracefully returns
> -ENODEV to user-space.
> 
> Please consider applying the patches in the series as devres is the easiest
> way to lessen the burden on driver developers when dealing with complex error
> paths and resource leaks. The general rule for devres is: if it can be freed
> in .remove() then it can be managed by devres, which is the case for this new
> helper.

Overall you are adding more code to the kernel than removing, so how is
this a win?  Perhaps if other drivers were converted over to this new
function then I would be more inclined to be able to accept it.

But as-is, with only one user, it's a non-starter, sorry.

thanks,

greg k-h
