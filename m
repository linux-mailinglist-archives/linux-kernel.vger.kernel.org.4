Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0106615607
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 00:21:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231355AbiKAXVM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 19:21:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231313AbiKAXVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 19:21:08 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 710C217E0D
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 16:21:05 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id o4so22207807wrq.6
        for <linux-kernel@vger.kernel.org>; Tue, 01 Nov 2022 16:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rpsnLesYz9W6MJNwj7E4OuCodm3h8Pnmeibwsh0+nzU=;
        b=kZ0L9cN3pQKQ+jSPu4z2TGRum9J/wx6IT+LLtRq7w31lj7Tq+cX3bU7ugAbqAPfBm/
         iJF4vVdtf6yN+ZQThL6oiaRoODqcI7P63Iz3pAo/ci1IGj2+eAxMXXcLlOJDU2wx6mSM
         9e8FTyMqCp/MF8sG63wc3BDEQmA8P63OThvi27J2Vp3myCZoio5I3YvzcEfkMhI0MWkQ
         WrI/YaeqajiOTf41VJ+dl/okUe0MEYqVsipaRwi3rnzIMHgD2tWBb6fu47n5SlTRVDH7
         Z5i5bLtFkoYq0hYobEv+RWEfaFtIEksUVIOg4LNT1X4tlgXpdkG+FtHLY1KukdHKYSbe
         +cTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rpsnLesYz9W6MJNwj7E4OuCodm3h8Pnmeibwsh0+nzU=;
        b=jBxO+g4IIXYXV2hThp4JZFeNsmD6Tnnc46DtBwc5rAi0Dq6l0/U6HM+IixLNh8q9Lv
         i1K5/FpRSiDxjdwfjAD2mDWnRDR8T/yJaxYJIdbD0bt65BBLGcr+nMJKUZiI5Xak7WFC
         ZxPOGNPlS6U1JGt2NIXGpZT+W+dSQYB4Ao3D3IWavYSCIY9rgup9mTbCuGtM217lN6JS
         Gzlx95zspW0vZYwkB0T/EfYv/0ESkptRMvr9U+f0t3wMYCA4jdh568YFNG6UA22iSvpA
         ba+RGhI5gmZrdXK2J1ZqDyGpyBhfOWRIjRXctVjaZdUY7yaUhRgRaIV+SpB3kwCGMvk9
         B9mA==
X-Gm-Message-State: ACrzQf1HqiY0ZYyy3EhAGwHFp2U5YS5luC01cXvgyFjQdNRmQ1YUfwmI
        HPDjxdnz2otd+xAA8iLaCVMA+fjXfgnMzA==
X-Google-Smtp-Source: AMsMyM6aKA+IT7eK0W1X1IuFXeolPnKxpQcsOI2M5s9JpU54zo4lkGBiygnxcQSflsVjnosjY5hp9A==
X-Received: by 2002:adf:fb84:0:b0:21a:10f2:1661 with SMTP id a4-20020adffb84000000b0021a10f21661mr12959853wrr.2.1667344864028;
        Tue, 01 Nov 2022 16:21:04 -0700 (PDT)
Received: from suse.localnet (host-79-43-11-206.retail.telecomitalia.it. [79.43.11.206])
        by smtp.gmail.com with ESMTPSA id b10-20020a05600c4e0a00b003cf4c1e211fsm108896wmq.38.2022.11.01.16.21.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 16:21:02 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Tao Zhou <tao.zhou1@amd.com>, Jack Xiao <Jack.Xiao@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>
Subject: Re: [RESEND PATCH] drm/amd/amdgpu: Replace kmap() with kmap_local_page()
Date:   Wed, 02 Nov 2022 00:09:42 +0100
Message-ID: <1753145.VLH7GnMWUR@suse>
In-Reply-To: <CADnq5_MDp6WUYTUO+Lo=XMSLdaYcwu5i2MWid9u1U2hKiyqoYg@mail.gmail.com>
References: <20221016174158.16638-1-fmdefrancesco@gmail.com> <CADnq5_MDp6WUYTUO+Lo=XMSLdaYcwu5i2MWid9u1U2hKiyqoYg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLY,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On luned=EC 17 ottobre 2022 18:53:24 CET Alex Deucher wrote:
> Applied.  Thanks!
>=20

The same report about which I just wrote in my previous email to you is als=
o=20
referring to this patch which later changed status to "Not Applicable".

It points to https://patchwork.linuxtv.org/project/linux-media/patch/
20220812175753.22926-1-fmdefrancesco@gmail.com/

Can you please let me understand why?

Thanks,

=46abio



