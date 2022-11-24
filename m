Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25A40637EF5
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 19:34:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbiKXSec (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 13:34:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiKXSeb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 13:34:31 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E08410FEC0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 10:34:30 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id 1so2643302ybl.7
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 10:34:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fooishbar-org.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zyRhD2tPNIj0nXRz4n59RUuEw/jmNKMtBzavR3aFP6M=;
        b=0mdcxFca7j4Uht3BEQZsAVyxIL/oGWwXqL68PF8S8TY2myiPbTRBVPe3mXvNSKx6av
         KA0SVrScCZM8kb7WL+z+p7kYMu5+ObNL+2oJNIChzua11fp8mgk0JytAYEKvhHTJGih5
         yG7QSlVjc74bVbWPnH1ZFJn+wJViH9pwEF9um1TfMFu/Dg6SxMgKFVqYgJWjo1CW+DEo
         YG316QWq3Nvfn5dO4JO0ITB0sd6Aih4LRNQyVQFypPeEOoiuQMQtUSfS2nA3c9b9s8Ft
         uUKVuMku+HMb7QBkEUSJTqe+gXITuINODm78njcyF8sLq314CNKajBIEaGhHLoLzzC10
         TotQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zyRhD2tPNIj0nXRz4n59RUuEw/jmNKMtBzavR3aFP6M=;
        b=Jgmlu5UL3XRyLJkJJdfmusPSkH8JVnRV1o80a7++B4iCLN4e2O7Vv/t+MVidHY1GVW
         9J2QS1e77+Mqxk8bDCPR7HaxdCiwzAAERZdxorgFouI4/DCw/ZQMLG7jePqS6Kuuzhm+
         e5s4aIB2KOvThGJeQTDY3UwpkewjGOXTqWKY7MsGFZ+GRacqrGFYNd9nosip5Yv7AIfX
         tJABPeYWONJ6ARwyoBh8xTpkQ/L4K2t3exp2uqJYVqqXPl8l/mTI3Miv5lr2DCGOCBYc
         F7uWVNV2Is7VA+kGx+1/6JZCQ6y6Xj0INpdmHHdH/QRh9qeRMgej88U4bmZl8kYPPdq6
         lZCQ==
X-Gm-Message-State: ANoB5pklwYZKcC8Jgk4U0IEcNnsgmV3qf0g84Q/p9JLtXG0RO7/jCcXV
        3TlmgLhfujSEEjOAXU8omH3MkvDqxRYn+7cZqLEYqg==
X-Google-Smtp-Source: AA0mqf6rcnAERmHXaxruYTZAZ0ocrxqnoiTXzYSs2X9Z6f3JMvANi58OnE2gQ2uJU4I1q0FEexhER0auefwS45XVzos=
X-Received: by 2002:a25:6607:0:b0:6df:a8d:d232 with SMTP id
 a7-20020a256607000000b006df0a8dd232mr18901115ybc.142.1669314868648; Thu, 24
 Nov 2022 10:34:28 -0800 (PST)
MIME-Version: 1.0
References: <20221119204435.97113-1-ogabbay@kernel.org>
In-Reply-To: <20221119204435.97113-1-ogabbay@kernel.org>
From:   Daniel Stone <daniel@fooishbar.org>
Date:   Thu, 24 Nov 2022 18:34:17 +0000
Message-ID: <CAPj87rOc1AZJwSEEsLvx_RLpnUK032t8jHLU1rVgsMisNBYQ6g@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] new subsystem for compute accelerator devices
To:     Oded Gabbay <ogabbay@kernel.org>
Cc:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>,
        Jiho Chu <jiho.chu@samsung.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Jeffrey Hugo <quic_jhugo@quicinc.com>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
        Maciej Kwapulinski <maciej.kwapulinski@linux.intel.com>,
        Christopher Friedt <chrisfriedt@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Oded,

On Sat, 19 Nov 2022 at 20:44, Oded Gabbay <ogabbay@kernel.org> wrote:
> This is the fourth (and hopefully last) version of the patch-set to add the
> new subsystem for compute accelerators. I removed the RFC headline as
> I believe it is now ready for merging.
>
> Compare to v3, this patch-set contains one additional patch that adds
> documentation regarding the accel subsystem. I hope it's good enough for
> this stage. In addition, there were few very minor fixes according to
> comments received on v3.
>
> The patches are in the following repo:
> https://git.kernel.org/pub/scm/linux/kernel/git/ogabbay/accel.git/log/?h=accel_v4

Series is:
Acked-by: Daniel Stone <daniels@collabora.com>

Cheers,
Daniel
