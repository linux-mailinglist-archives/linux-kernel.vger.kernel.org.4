Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FF5D69BDF4
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Feb 2023 00:32:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbjBRXcP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Feb 2023 18:32:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjBRXcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Feb 2023 18:32:14 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BF351206F
        for <linux-kernel@vger.kernel.org>; Sat, 18 Feb 2023 15:32:13 -0800 (PST)
Received: from [192.168.2.109] (unknown [109.252.117.89])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id DC4D26602097;
        Sat, 18 Feb 2023 23:32:09 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1676763131;
        bh=yVDkAb8rgaOCrNdaY3hB3QoJUrg+SNQndQVrEq0Uk3E=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=kCwa7btluaTiY/1x+TuHbmwWI/J65a1y2Ztuw27XhUnjfwchk6kxLYRMHJpZeSpB9
         lxDW930sKapT9uWf3mmJJnWQ6PH7gv4UP6cKW6gOKM/dhyj30m2kshehA6CXXQQlOc
         6bECZ0NQdvYHPsH9m5V7e8CN2e4nMWIBCb+Votb7feXDVwWzLhuDFfNOnCJkCZ/26Q
         lFwerPXhqcTV08CmylyFe5nnp4qqHmOHoEXytIn33LP5umz6PnRO4MQZRPyAYnOZhs
         lkbU4LsmLvYt1HGxo/m4l6tRFdozfjXhiGM0HmitZ/XBqKz7RXwDMoTmtS0TDRPp8f
         8oYnO8wvERaVA==
Message-ID: <0a8358cd-4c2e-ed70-2cc5-1cff27b7594d@collabora.com>
Date:   Sun, 19 Feb 2023 02:32:06 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 1/3] kernel/reboot: Use the static sys-off handler for any
 priority
Content-Language: en-US
To:     Samuel Holland <samuel@sholland.org>,
        Palmer Dabbelt <palmer@dabbelt.com>, rafael.j.wysocki@intel.com
Cc:     aou@eecs.berkeley.edu, apatel@ventanamicro.com,
        Atish Patra <atishp@rivosinc.com>, geert@linux-m68k.org,
        heiko@sntech.de, kai.heng.feng@canonical.com, mcgrof@kernel.org,
        paulmck@kernel.org, Paul Walmsley <paul.walmsley@sifive.com>,
        pmladek@suse.com, yuehaibing@huawei.com,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        tangmeng@uniontech.com
References: <mhng-fbf5d10c-239d-4e47-bf52-3e1255cbe5e0@palmer-ri-x1c9>
 <8bba0d3c-bf10-97df-80a5-ad98d5a417c8@sholland.org>
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <8bba0d3c-bf10-97df-80a5-ad98d5a417c8@sholland.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/19/23 02:20, Samuel Holland wrote:
> On 2/14/23 18:17, Palmer Dabbelt wrote:
...
>> Sorry for being slow here, I'd been assuming someone would Ack this but
>> it looks like maybe there's nobody in the maintainers file for
>> kernel/reboot.c?  I'm fine taking this via the RISC-V tree if that's OK
>> with people, but the cover letter suggests the patch is necessary for
>> multiple patch sets.
> 
> See also Dmitry's reply[0] to the PSCI thread. (Maybe I should have sent
> both conversions as one series?)
> 
> I am happy with the patches going through any tree. The kernel/reboot.c
> patch is exactly the same between the two series, so it should not hurt
> if it gets merged twice. Though if you take this series through the
> RISC-V tree, maybe you want to create a tag for it?
> 
> I am not sure exactly what needs to be done here; I am happy to do
> anything that would assist getting both series merged for v6.3, to avoid
> a regression with axp20x[1].
> 
> Regards,
> Samuel
> 
> [0]:
> https://lore.kernel.org/lkml/0a180849-ba1b-2a82-ab06-ed1b8155d5ca@collabora.com/
> [1]:
> https://lore.kernel.org/lkml/e38d29f5-cd3c-4a2b-b355-2bcfad00a24b@sholland.org/

The reboot.c changes should be acked/applied by Rafael.
I noticed that you haven't CC'd the linux-pm ML, maybe that's why it
hasn't got the attention.

-- 
Best regards,
Dmitry

