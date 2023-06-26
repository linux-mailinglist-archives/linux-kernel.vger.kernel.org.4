Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04CC173E028
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 15:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbjFZNFr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 09:05:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230268AbjFZNFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 09:05:41 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B35AE7A;
        Mon, 26 Jun 2023 06:05:38 -0700 (PDT)
Received: from [192.168.2.254] (109-252-154-132.dynamic.spd-mgts.ru [109.252.154.132])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id BCCD36606EF9;
        Mon, 26 Jun 2023 14:05:35 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1687784737;
        bh=UduXksLELXstu/IT+fN/u2qfAoyq+jaxriMeJJQvIMM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=NrgukjA1DHJj1g7zNjrN/5FsxxcF05ysjW5CddwQDyvmub9yTZmZfcfCi1zocvuQs
         tKnhwifaeyEv0gyFrsBp6pXUKEIJ/jD1c/vVStDTe71ma2gejUp/lAZSQNd2YRsOtK
         ZGqTay3e0HR9Y/knPtp+nSSlzp9ZoJ9w9E5wdGHJ5Yu0cCVFiNTAUJojSddZ/qoT5M
         osqOer+obrMLx/wHp7XfRlUOn7AmJmt+eNmgm6D5uDi81CFyspZ0ecmB+tRUDOvqNs
         b7ZDWOIvFbSmlfJL+d6Xs9g08fKOHWnL3rIJ65Re1zJ41jLzy/SMKKBFvqjwnhXW0Y
         2kOyALaDANEeQ==
Message-ID: <4f652b3b-8691-84f4-037a-64950a30d496@collabora.com>
Date:   Mon, 26 Jun 2023 16:05:33 +0300
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
> I think here is the major problem I have with this patch: you've made
> drm_gem_shmem_{get_pages,pin}() private, which forces me to call
> drm_gem_shmem_pin() in a path where I already acquired the resv lock
> (using the drm_exec infra proposed by Christian). That would
> probably work if you were letting ret == -EALREADY go through, but I'm
> wondering if it wouldn't be preferable to expose
> drm_gem_shmem_pin_locked().

You should be free to expose the necessary functions. They are private
because nobody need them so far and we don't want to export unused
functions.

-- 
Best regards,
Dmitry

