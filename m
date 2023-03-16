Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE9C46BD564
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 17:20:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbjCPQUX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 12:20:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbjCPQUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 12:20:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A34AEE2510;
        Thu, 16 Mar 2023 09:19:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3EF9EB8227B;
        Thu, 16 Mar 2023 16:19:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94AE7C433EF;
        Thu, 16 Mar 2023 16:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1678983577;
        bh=dTsd/PL4Q3omoMF56pqe4IplV8a9A+s1oiMDQ7fMXyk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NHvg7MlOckeE95ZfYl5bedYflaBZ11UWbjxvIZmr5m4Mf9hklF//49FS6Flaww2QI
         Y18gmcFB3RWC6thgGeOcBoDngVM8INOjmMAKFtqTtAvxMf6RzJhnT1O/Z2ejVyi3Zb
         wNkDN7D3jLSYDaRMYXc4fsCMQPytXKQT0Zh2wQL8=
Date:   Thu, 16 Mar 2023 17:19:35 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Valery Zabrovsky <valthebrewer@yandex.ru>
Cc:     Guo Zhengkui <guozhengkui@vivo.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Alan Stern <stern@rowland.harvard.edu>,
        Mian Yousaf Kaukab <yousaf.kaukab@intel.com>,
        Felipe Balbi <balbi@ti.com>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org
Subject: Re: [PATCH] usb: gadget: net2280: fix NULL pointer dereference
Message-ID: <ZBNBlwc9lt+pLFkd@kroah.com>
References: <20230316155356.13391-1-valthebrewer@yandex.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230316155356.13391-1-valthebrewer@yandex.ru>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 16, 2023 at 06:53:55PM +0300, Valery Zabrovsky wrote:
> In net2280_free_request():
> If _ep is NULL, then ep is NULL and is dereferenced
> while trying to produce an error message.

How can that ever happen?  How did you test and hit this?

> The patch replaces dev_err() with pr_err() which works fine.

That's not a good idea for driver code to use, sorry.

> Found by Linux Verification Center (linuxtesting.org) with SVACE.

As I have said before, your testing framework needs a lot more work.

good luck!

greg k-h
