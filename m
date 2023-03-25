Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA2576C8C16
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 08:08:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232051AbjCYHIY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 03:08:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232022AbjCYHIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 03:08:22 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA13F9EF9;
        Sat, 25 Mar 2023 00:08:20 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id ek18so16075232edb.6;
        Sat, 25 Mar 2023 00:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679728099;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BhCjNke4o6htNuSSLMhV34Z5L+JJwT2dpRjptiRlbNA=;
        b=FSP+zdm04PUFXrHWmmUhgTQEBDdojePDUHJMnf+5Ee4YjEPld2dNeK+TcNP0WFcZzV
         KmC0aWpSkLlNJt1KfpszcQ+UtUxVTapfshN+YIR/qVc3c7GfDR96HoDrKwjWBcER3bPn
         TnD+NQyYV7y6BnGV0qpOxsCX4hi+bWzT3UwMlcS63XzjjTXMS7cNZ+td6nfp3YfmQJva
         0lL4kV1n58k1XmymwRwDLL9GQ3cLzAMIJUzqfMlvUAgXz5js9VGcTup8oFoBAc2cy/Fo
         EvQ061n8s2I0D0V7aJjojx9nAOroEV7ET4T5dccAZWOT+lZEx6Tg5bSN+TPN3qmuWEl9
         eiWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679728099;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BhCjNke4o6htNuSSLMhV34Z5L+JJwT2dpRjptiRlbNA=;
        b=gcH2PK0ui0JxebqrKA23Fgue6h70LGTzLB2f7sMBTDZnLvxm28MQLM6aXqCD2mcbuu
         lZZvrcGUfhm4aEshLbA5+/a4o2BY/51sGWvFHeFurzENw0216vjtmyiqw+TIfmGqeU31
         F4rMSf+1opIO6huGhkFyYlB9aUYFSu1yKE5QcD3+HdKNY5f3AW2FLF25/IDWhv1VirmB
         iNbSH3h1wTtzKJ5I2J4O4OjtlW+veORNlXEsXZQUqXSDjK+ZwgnXjRCxXYiT/z68/VMI
         yeNUT3c9NAul3xDQe98V93QquY9PE3KtquLxdL3Yqk6vDp/amnkoe4OKVfSROKzgiV5V
         GKvA==
X-Gm-Message-State: AAQBX9cJKle6L4wtlYEs6KMQzYdWFS7ymIj/dSnkaGCuXtwtVlXMZ/UU
        LhVOCwq15wOdfKi8naByekaFIGIOFeA=
X-Google-Smtp-Source: AKy350b5jXK3iNNla2GOfg9iEvFexE+B43iDNSO9KQERX/FasFstxWwyw7TYoALYHn35CrkWN91GTw==
X-Received: by 2002:a17:906:fc2:b0:923:c199:dab1 with SMTP id c2-20020a1709060fc200b00923c199dab1mr5891132ejk.55.1679728099311;
        Sat, 25 Mar 2023 00:08:19 -0700 (PDT)
Received: from kista.localnet (82-149-1-233.dynamic.telemach.net. [82.149.1.233])
        by smtp.gmail.com with ESMTPSA id sd13-20020a170906ce2d00b008e09deb6610sm11299252ejb.200.2023.03.25.00.08.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Mar 2023 00:08:18 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Adam Pigg <adam@piggz.co.uk>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 4/9] media: v4l2: Add JPEG pixel format to v4l2 format info
Date:   Sat, 25 Mar 2023 08:08:17 +0100
Message-ID: <2135691.irdbgypaU6@kista>
In-Reply-To: <20230324151228.2778112-5-paul.kocialkowski@bootlin.com>
References: <20230324151228.2778112-1-paul.kocialkowski@bootlin.com>
 <20230324151228.2778112-5-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne petek, 24. marec 2023 ob 16:12:23 CET je Paul Kocialkowski napisal(a):
> Represent the JPEG pixel format in the v4l2 format info table.
> 
> Note that the bpp is set to 1 which is not a proper way to estimate
> the needed buffer size for a given JPEG image. However the compression
> ratios of JPEG typically allow fitting the image in a smaller size,
> even though extra metadata could increase the total size by an
> arbitrary amount. Thus it is not a perfectly safe way to calculate the
> size of a JPEG buffer for given dimensions but it still provides a
> reasonable approach.
> 
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej


