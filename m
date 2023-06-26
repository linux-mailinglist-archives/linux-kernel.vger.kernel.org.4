Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B7AF73E023
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 15:05:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbjFZNFc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 09:05:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbjFZNFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 09:05:25 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 268E4C2;
        Mon, 26 Jun 2023 06:05:22 -0700 (PDT)
Received: from [192.168.2.254] (109-252-154-132.dynamic.spd-mgts.ru [109.252.154.132])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 265C96606EF9;
        Mon, 26 Jun 2023 14:05:18 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1687784720;
        bh=1sBMM2PRRV9h1R/j/rMSloE9aC2lpEqWGuljd40xwbM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=lGBeuXWb01fFSzJ2pFOwmMEqBs2rZQZVQpaA/TuCvDVDtXQgBurZ7wQBDEiRk+D0g
         kFY6B96C8DgjTQOg4y+E15Bi2zbWx2hRzPT+TCeWBvlq/z3x9mLE/zZBSmqvOaVYg4
         BNutK+oH87OC2/6/PhJ6UJyTyOQqs0eLny9I4cuW2DyKxbXTbei0YwBov4cLtLAWr1
         NJrEfrJLFtxEKT4oyQogTfqonglyJRyKBfA5hiByacbQOSwuTg3+ej8OHo2WvybNiJ
         5eb75PHN01929Km2K0XGC2iOSUpP7IGjp0mhGtjQI9Xhu87S4NVhdTC4ov//7BmKtx
         YFN46CpVsU7WQ==
Message-ID: <2b932742-0637-3b7a-acb5-ab643781caa3@collabora.com>
Date:   Mon, 26 Jun 2023 16:05:14 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.1
Subject: Re: [PATCH v4 6/6] drm/shmem-helper: Switch to reservation lock
Content-Language: en-US
To:     Boris Brezillon <boris.brezillon@collabora.com>
Cc:     Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        John Stultz <jstultz@google.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Tomi Valkeinen <tomba@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        kernel@collabora.com, linux-media@vger.kernel.org
References: <20230529223935.2672495-1-dmitry.osipenko@collabora.com>
 <20230529223935.2672495-7-dmitry.osipenko@collabora.com>
 <20230626114014.2c837255@collabora.com>
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20230626114014.2c837255@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/26/23 12:40, Boris Brezillon wrote:
> Same problem with this renaming: it's confusing because this function
> was previously taking care of the locking, and it's no longer the case.
> That's actually true for other public functions your patching, but I
> won't go over all of them.
> 
> I know this patch has been under discussion for quite some time, and has
> been validated by other devs/maintainers, but I'd like to understand the
> reasoning behind these decisions. Not the decision to replace all locks
> by dma_resv, which I kinda understand, but the decision to change the
> behavior of functions without making the name reflect the new behavior
> (_locked prefix), or the fact we now prohibit some functions to
> succeed when the dma_resv lock is taken by the driver beforehand (which,
> unless I'm mistaken, will happen in the VM_BIND logic, and can happen
> in the SUBMIT ioctl too depending on the driver).

Adding explicit _locked/unlocked postfix to all function names indeed
won't hurt to do. There was no decision made about the function names,
the old functions kept the old name where possible to minimize code
changes during transition to the resv lock. Improving the names could be
the next step.

Thanks for the feedback!

-- 
Best regards,
Dmitry

