Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B5DA710A21
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 12:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238860AbjEYKbl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 06:31:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240892AbjEYKbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 06:31:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E477519A
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 03:31:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 712EE644A6
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 10:31:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC022C433D2;
        Thu, 25 May 2023 10:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685010688;
        bh=OD8rD59I+wawmCfnEFxirBa5h36zblMiNcRYE5vjeQg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YRvIcAkU7Uueiqs1B7ZV6VDl03Z9J4dX8YREtKZd4CBOK60HjllzeiniqXy2FyvTJ
         68yqBxLksU3q4rqR4CFoJp2vWpFGv46OZXwfqIih/v477xOrIncorGDLUuB68i6P9j
         7Jj8IyhZh7L+xGFnbR4DuXmtL2zC2Htrc47CfcDsFUsR0za95Y1DFbbQD4BXPqJsQW
         MCcr/8WLcHQgaRqjbvI87NxLC9lI44w6MobFOUQPX/VM8rk+iV0b5IA5h7GZWS3bth
         ZWNahiTWZy5lrqOeFuAPb+xNjrj9S//QCR15IkxXQykELydN57STMv9UPz/kEZGnom
         pafy++vNoH4Fw==
Date:   Thu, 25 May 2023 11:31:24 +0100
From:   Lee Jones <lee@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: intel-lpss: hide suspend/resume functions in #ifdef
Message-ID: <20230525103124.GC9691@google.com>
References: <20230516202746.561111-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230516202746.561111-1-arnd@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 May 2023, Arnd Bergmann wrote:

> From: Arnd Bergmann <arnd@arndb.de>
> 
> When CONFIG_PM is disabled, the prototypes for these two functions
> are not visible:
> 
> drivers/mfd/intel-lpss.c:482:5: error: no previous prototype for 'intel_lpss_suspend' [-Werror=missing-prototypes]
>   482 | int intel_lpss_suspend(struct device *dev)
>       |     ^~~~~~~~~~~~~~~~~~
> drivers/mfd/intel-lpss.c:503:5: error: no previous prototype for 'intel_lpss_resume' [-Werror=missing-prototypes]
>   503 | int intel_lpss_resume(struct device *dev)
> 
> Add the same #ifdef around the definition of the unused functions,
> which avoids the warning and slightly reduces the code size.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/mfd/intel-lpss.c | 2 ++
>  1 file changed, 2 insertions(+)

Applied, thanks

-- 
Lee Jones [李琼斯]
