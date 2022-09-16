Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66B805BA828
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 10:25:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbiIPIZB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 04:25:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230157AbiIPIY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 04:24:56 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 235061CFFF;
        Fri, 16 Sep 2022 01:24:51 -0700 (PDT)
Received: from [192.168.1.111] (91-158-154-79.elisa-laajakaista.fi [91.158.154.79])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 5C73B47C;
        Fri, 16 Sep 2022 10:24:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1663316689;
        bh=TBheFs7a/heafyLccN5CvrNZP43Myi2No4cFtTqVNI8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Si5SbfrlJNDT1P8RiJxCpd7Lh7BG8A+FP3vh3HsoXwKagaldcQv8B+1z5brzcdkuM
         Ukwwsk9GJ3LHE6Fo2HDDPd36cx8jZNfu/2PAHpWQAZVIxiY6kIbAjQ0EYAnbwDix/Y
         iHDITC5h2KkCAo0GP3WtTyp2mAdKTn6EgIYyQcBI=
Message-ID: <6c0d4973-7f7e-1893-58b2-9bbe19160045@ideasonboard.com>
Date:   Fri, 16 Sep 2022 11:24:46 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: drivers/gpu/drm/omapdrm/dss/dsi.c:1126:1: warning: the frame size
 of 1060 bytes is larger than 1024 bytes
Content-Language: en-US
To:     Arnd Bergmann <arnd@arndb.de>, kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-omap@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>,
        dri-devel@lists.freedesktop.org
References: <202209160259.7f3Z5krO-lkp@intel.com>
 <9b4152e9-34cb-4ed6-b5e3-ef045b40dff2@www.fastmail.com>
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
In-Reply-To: <9b4152e9-34cb-4ed6-b5e3-ef045b40dff2@www.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/09/2022 21:49, Arnd Bergmann wrote:
> On Thu, Sep 15, 2022, at 8:17 PM, kernel test robot wrote:
>> Hi Arnd,
>> tree:
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>> master
>> head:   3245cb65fd91cd514801bf91f5a3066d562f0ac4
>> commit: 3d427228f7370894680580fcd0381c0349624fa1 ARM: ixp4xx: enable
>> multiplatform support
> 
> This did not cause the problem, the bisection just landed on a
> commit that enabled additional configuraitons.
> 
>>     drivers/gpu/drm/omapdrm/dss/dsi.c: In function 'dsi_dump_dsi_irqs':
>>>> drivers/gpu/drm/omapdrm/dss/dsi.c:1126:1: warning: the frame size of 1060 bytes is larger than 1024 bytes [-Wframe-larger-than=]
>>      1126 | }
> 
> I think hte problem is that struct dsi_irq_stats is just too
> large, at 776 bytes. The interrupts are disabled during a copy
> from 'dsi->irq_stats' into 'stats'. A trivial workaround would
> avoid the local copy and keep interrupts disabled through
> the entire function so it can operate directly on the source
> data, but that would introduce a longer time with irqs disabled,
> which might be bad as well.
> 
> Since this is only called from a debugfs file, and reading that
> file is probably not performance critical itself, maybe
> using kmalloc on the large structure would be best.

I think that makes sense. I have sent a patch using kmalloc.

Oddly enough, I was not able to reproduce the warning with my normal 
toolchain, gcc-arm-11.2-2022.02-x86_64-arm-none-linux-gnueabihf. I even 
reduced the frame size limit to 700, and saw warnings from other places, 
but not from omapdrm.

  Tomi
