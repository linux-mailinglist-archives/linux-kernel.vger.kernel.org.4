Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D4B06D465F
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 16:02:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232693AbjDCOCM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 10:02:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230269AbjDCOCK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 10:02:10 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51B547A8B;
        Mon,  3 Apr 2023 07:02:09 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id k17so34837434ybm.11;
        Mon, 03 Apr 2023 07:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680530528;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Lcw7CsrgJYECAzGsrUJFDPn/CnlU4ZU6smKnWO17Ae0=;
        b=mQkUbNiW0esw3jO4JiIlQGq18gSiAY8UYiaxcqykrSwc0GcoaqBnZZu81I2uh9b0A1
         W6RjLKVl30VbyvmM/i2idv4uDHjf5FsqWULm9+rm3Udncrc7RYR9sp4j0tZI9B5C0IeM
         KJ6dIETWJXYUssvxdq7zIlxWYs6U8PNgxsMnWgN1GeHA35xgTsIgpY/M/wt5uVyYIUTO
         1veRDy7QiJ266iCrtchYEjv/qrTEZGxr+Taia7wTuyk8xUV4ZxqlRoIhCQbw5PKoCN8Z
         Q0p/8+oh/fauIXLqwmbEL27+SsDuOGh54qu2EJI8cbIlYbOVNcXPsmzRsEnUX/ScLG1P
         3rbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680530528;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Lcw7CsrgJYECAzGsrUJFDPn/CnlU4ZU6smKnWO17Ae0=;
        b=F7qSnwmRAAsDkUoUfmkjWYprdCFxze+WdgmpwWX0E72EpF0JF4jUrMN10RTTRnoN4m
         FHrkHL3lYZOBha5eyLmXrK/qlNhMilc15FEbDLeSSEYiDbUbDpBsgzghz4ACdLuIaFgs
         eqXTKPopNKFwYnNdgIxjPY74BFs39FaYcLY1CtopmQpv7A5pAPTgLllOEvd+PzFIoZ7/
         gfYlA/d2xxQiVtIS1hASYaiG1Sl9KUIqsQPPeKXTfodUeAXbgXUM+QGXsF0Vgmcaes4o
         p+dHe4BjqzKn7eSvaNZTuY7d90t7Qa7cs3QLV1Fr5ob/F24f5L0ydDIBWcgGBANzHGjQ
         CUaQ==
X-Gm-Message-State: AAQBX9cMTYEYWKQ3WSNOuFYyv51Asn6wPl9dU/5e1yNZy9ubUFU+Ty1o
        cMmhu0A3cLY6oj7O0zBu30ta/296umgUIK7VOAI=
X-Google-Smtp-Source: AKy350YKHmOqiL7IpC/Sx2Cu1gKrbtmOye3W2UwR6MNJrI4YJ78lzeG0UeVfyco2byZJzLJuVgOf3PGgek6XPCmFY1c=
X-Received: by 2002:a05:6902:1247:b0:b78:4b00:7772 with SMTP id
 t7-20020a056902124700b00b784b007772mr22643916ybu.5.1680530528529; Mon, 03 Apr
 2023 07:02:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230402164826.752842-1-dmitry.osipenko@collabora.com> <20230402164826.752842-8-dmitry.osipenko@collabora.com>
In-Reply-To: <20230402164826.752842-8-dmitry.osipenko@collabora.com>
From:   Emil Velikov <emil.l.velikov@gmail.com>
Date:   Mon, 3 Apr 2023 15:01:57 +0100
Message-ID: <CACvgo529Rji9oVdSX81NJhXf9bF6jq1OTLhDff9CjHvfKLS4tA@mail.gmail.com>
Subject: Re: [PATCH v1 7/7] drm/shmem-helper: Switch to reservation lock
To:     Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc:     Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Liam Mark <lmark@codeaurora.org>,
        Brian Starkey <Brian.Starkey@arm.com>,
        John Stultz <jstultz@google.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Tomi Valkeinen <tomba@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Amol Maheshwari <amahesh@qti.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-tegra@vger.kernel.org, kernel@collabora.com,
        linux-media@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

On Sun, 2 Apr 2023 at 17:49, Dmitry Osipenko
<dmitry.osipenko@collabora.com> wrote:

> -void drm_gem_shmem_put_pages(struct drm_gem_shmem_object *shmem)
> +static int drm_gem_shmem_pin_locked(struct drm_gem_shmem_object *shmem)
>  {
> -       mutex_lock(&shmem->pages_lock);
> -       drm_gem_shmem_put_pages_locked(shmem);
> -       mutex_unlock(&shmem->pages_lock);
> +       struct drm_gem_object *obj = &shmem->base;
> +       int ret;
> +
> +       dma_resv_assert_held(shmem->base.resv);
> +
> +       drm_WARN_ON(obj->dev, obj->import_attach);
> +

We don't need this WARN_ON to happen with a reservation lock, do we?
If so, let's leave that in the caller.

> +       ret = drm_gem_shmem_get_pages(shmem);
> +
> +       return ret;
> +}
> +
> +static void drm_gem_shmem_unpin_locked(struct drm_gem_shmem_object *shmem)
> +{
> +       struct drm_gem_object *obj = &shmem->base;
> +
> +       dma_resv_assert_held(shmem->base.resv);
> +
> +       drm_WARN_ON(obj->dev, obj->import_attach);
> +

Ditto.

With that the series is:
Reviewed-by; Emil Velikov <emil.l.velikov@gmail.com>

HTH
-Emil
