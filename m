Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B364D728658
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 19:28:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231962AbjFHR2C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 13:28:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231192AbjFHR17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 13:27:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BC5B2733;
        Thu,  8 Jun 2023 10:27:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0A2EF63F6C;
        Thu,  8 Jun 2023 17:27:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA9A6C433EF;
        Thu,  8 Jun 2023 17:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686245274;
        bh=D3n7QlNTzEG2bZLh2whGRjLa6uCHuMKRqgWF/RqPTXU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=amNzwcR42XFVdnXXAwksBTI5cDivfWubhW01QhpuW8sBSyX7fzsXfVOjUh4LYD7rx
         AARkvE7qq/aiVPnf6nOjri+4bB9JTh+rf9GY21AEBpZ95CpvAKYFFEqaLMsxCHJ+xq
         KuC4wjbljWqPix6c9OltAWYYV5nl82D6cJYLvVFockTXTxgFBswW9yTw9SYWXWowSK
         eAgnXpKTsFx6j/S0J4eJh08QV5lIqp0XLrGRa9fkVZTJJ/1lFwWMZnBi4W1mX3tLMV
         81cR9l07NJ0lMIycgIWVqeLtM8xc12yP6385u3qb4+5im76KxrJeNWOJbPJyr6/wKR
         zzck5p7p/SjmQ==
Date:   Thu, 8 Jun 2023 18:27:49 +0100
From:   Lee Jones <lee@kernel.org>
To:     Henning Schild <henning.schild@siemens.com>
Cc:     Pavel Machek <pavel@ucw.cz>, Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v4 3/4] leds: simatic-ipc-leds-gpio: split up into
 multiple drivers
Message-ID: <20230608172749.GJ3572061@google.com>
References: <20230524124628.32295-1-henning.schild@siemens.com>
 <20230524124628.32295-4-henning.schild@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230524124628.32295-4-henning.schild@siemens.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 May 2023, Henning Schild wrote:

> In order to clearly describe the dependencies between the GPIO
> controller drivers and the users the driver is split up into a core,
> two drivers and a common header.
> 
> Signed-off-by: Henning Schild <henning.schild@siemens.com>
> ---
>  drivers/leds/simple/Makefile                  |   4 +-
>  .../simple/simatic-ipc-leds-gpio-apollolake.c |  66 +++++++
>  .../leds/simple/simatic-ipc-leds-gpio-core.c  | 104 +++++++++++
>  .../simple/simatic-ipc-leds-gpio-f7188x.c     |  66 +++++++
>  drivers/leds/simple/simatic-ipc-leds-gpio.c   | 163 ------------------
>  drivers/leds/simple/simatic-ipc-leds-gpio.h   |  22 +++
>  drivers/leds/simple/simatic-ipc-leds.c        |   1 -
>  drivers/platform/x86/simatic-ipc.c            |   7 +-
>  8 files changed, 265 insertions(+), 168 deletions(-)
>  create mode 100644 drivers/leds/simple/simatic-ipc-leds-gpio-apollolake.c
>  create mode 100644 drivers/leds/simple/simatic-ipc-leds-gpio-core.c
>  create mode 100644 drivers/leds/simple/simatic-ipc-leds-gpio-f7188x.c
>  delete mode 100644 drivers/leds/simple/simatic-ipc-leds-gpio.c
>  create mode 100644 drivers/leds/simple/simatic-ipc-leds-gpio.h

Applied, thanks

-- 
Lee Jones [李琼斯]
