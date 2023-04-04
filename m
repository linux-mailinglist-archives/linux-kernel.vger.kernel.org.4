Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D85E6D631F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 15:37:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235174AbjDDNhr convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 4 Apr 2023 09:37:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234971AbjDDNho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 09:37:44 -0400
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B04871AB
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 06:37:43 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id by14so14691681ljb.12
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 06:37:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680615461;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v5oq7n3GlIXktxJklhqgcT1TTB67yDatIC7dGkiiCuI=;
        b=TfhK3BT+wiESZFacv4SnIzcMeWi9Cq2CSpYYklugqq6GXyCr3F9MqPCk3tvLmpNiay
         sOEBOQPuuvCALLXOmavjUgg6SilyUBkamDTnsuRaxGgC0Du7H2n3gsRPcx4E9R0DnOnE
         fg3ktVEmdQNvPOuaxP2BcP5tw8meOPURi4KBXKzgBcNnA1fWR/9/lsBHAohIbx92AsCR
         CklyTqJu9qHJwLgLxDL0ypXf9ScWfjW/HAzfQMd2t4pePjVcwkSzrnFrJgbjkFxg2yj2
         LTQfpToJmZkO725MGPFYwA9sJV6bwt1eChmFwLKa1diAq751kPi4vN4yg4VU/lKzzGDO
         oXPA==
X-Gm-Message-State: AAQBX9euK0D1yR27OV8ULTgHH1WGzbO52JvOy6fnDJi/Z/IYxSQLs7sT
        nJt1j6v3xeIT6O2/SdYIsyJYZRUdei3u1MFE
X-Google-Smtp-Source: AKy350bYfM08VHcRY1B3DkKRrIrLRHzwImfe12kxvrfE9dICu0C6Uz6wtcSQaa0jl8a7Mj3zJnkGBQ==
X-Received: by 2002:a2e:9017:0:b0:29a:29cf:f01d with SMTP id h23-20020a2e9017000000b0029a29cff01dmr829773ljg.3.1680615461320;
        Tue, 04 Apr 2023 06:37:41 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id w22-20020a2e3016000000b002a5faadb938sm2329284ljw.138.2023.04.04.06.37.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Apr 2023 06:37:40 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id g17so42436720lfv.4
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 06:37:40 -0700 (PDT)
X-Received: by 2002:ac2:5a01:0:b0:4db:266c:4337 with SMTP id
 q1-20020ac25a01000000b004db266c4337mr749742lfn.1.1680615459983; Tue, 04 Apr
 2023 06:37:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230403160314.1210533-1-robdclark@gmail.com>
In-Reply-To: <20230403160314.1210533-1-robdclark@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 4 Apr 2023 15:37:22 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUph5ADYcC0EnEEMDjTLC5TQrTzRXmTDOOOZ0SAjxPV0Q@mail.gmail.com>
Message-ID: <CAMuHMdUph5ADYcC0EnEEMDjTLC5TQrTzRXmTDOOOZ0SAjxPV0Q@mail.gmail.com>
Subject: Re: [PATCH v2] drm/vblank: Fix for drivers that do not drm_vblank_init()
To:     Rob Clark <robdclark@gmail.com>
Cc:     dri-devel@lists.freedesktop.org,
        Rob Clark <robdclark@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        open list <linux-kernel@vger.kernel.org>,
        Javier Martinez Canillas <javierm@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 3, 2023 at 6:07 PM Rob Clark <robdclark@gmail.com> wrote:
> From: Rob Clark <robdclark@chromium.org>
>
> This should fix a crash that was reported on ast (and possibly other
> drivers which do not initialize vblank).
>
>    fbcon: Taking over console
>    Unable to handle kernel NULL pointer dereference at virtual address 0000000000000074

Thanks, this fixes a crash seen with the ssd130x DRM driver.
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
