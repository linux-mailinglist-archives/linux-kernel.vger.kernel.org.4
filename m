Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 565DA6C8C24
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 08:15:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232168AbjCYHPN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 03:15:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232137AbjCYHPF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 03:15:05 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19EAFCA2C;
        Sat, 25 Mar 2023 00:15:00 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id b20so16191969edd.1;
        Sat, 25 Mar 2023 00:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679728499;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kijlfd+PM0iLIZMF5+sg/CV/MasVvO3Ll6lZ/t4bxdI=;
        b=FZ77NWTfSvwT9v8ocqKeOx4jjsZG5oQfioG+yB5uQMy343Q3nOmxEvvsbJkARFtPCH
         PwDPkywFMhLaH8YuxGXhcqrtS7PdWpVXx+6W6Ro4UVAYHdmIbBT1JclOId1f4x5ceYXP
         PbqbjfdR1rBm87M/EJ0MJGXzmSvs5O4PYwsbuPFjrC9kfmaSxKG9jAvImLdLLsfIkcB+
         3RV2h09TnxpZo0CjAeJSfq/8vcI2Fj051E8yih2107elwNcbyGKBOQBn0AUu7+JNYaY6
         rSOUt15DbINLqRQxGtkDhuolo6xMi8HwEnqSfFn0SWCCA2YPunw7GDmC4P8NPacGwyek
         c2Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679728499;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kijlfd+PM0iLIZMF5+sg/CV/MasVvO3Ll6lZ/t4bxdI=;
        b=FWENjpNfR+tF7urRJ0dXB0k7Ldf6FYYea0l+6P6QL1CrAl5KqPlQvfxG2Cbzr5XgTV
         Qkv1YPBXPoAMcS84P/cTPxY2nJf0O38f8JfWtc3Syde1Yi0ODbhYT6hpFTMLT2FP82f0
         yHC2NjGPNI+ldBZ3lhswQPsekWkHD8zco9C2mP/wUhn5gVD7jeYCjdWcP25Qk+Q1T2+N
         GNpEVkazWgIspAocu52shkRd7pu/Kyuj9e7xK1wQ8dr7eOH4E67xa+SELb/jGzMjwntk
         okyaoWiVwBesf29FohqBFYXB/UlUzzTVu5jcgQcOkQv+sKyGMYSk68zW84l6Lyy8fwX7
         z1dw==
X-Gm-Message-State: AAQBX9cQ1m0XDeVGDzjr2EhQhd+93iwvFR8HCwb43VdOXgsjUqJmYk2R
        4t45iHBbsO2G9Yhc5Qbff7M+vgMrZrA=
X-Google-Smtp-Source: AKy350bVXqlcE3R0ij4TuNgV6ae2ij2U7WNVD9/hsIPrrzW64ZPAegx3gEMchmCP/NzT8DnQVmXMEg==
X-Received: by 2002:aa7:dad3:0:b0:4fb:999:e04c with SMTP id x19-20020aa7dad3000000b004fb0999e04cmr5766278eds.38.1679728499360;
        Sat, 25 Mar 2023 00:14:59 -0700 (PDT)
Received: from kista.localnet (82-149-1-233.dynamic.telemach.net. [82.149.1.233])
        by smtp.gmail.com with ESMTPSA id i23-20020a508717000000b004af6c5f1805sm11822239edb.52.2023.03.25.00.14.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Mar 2023 00:14:59 -0700 (PDT)
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
Subject: Re: [PATCH 9/9] media: sun6i-isp: capture: Implement enum_framesizes
Date:   Sat, 25 Mar 2023 08:14:57 +0100
Message-ID: <7500135.EvYhyI6sBW@kista>
In-Reply-To: <20230324151228.2778112-10-paul.kocialkowski@bootlin.com>
References: <20230324151228.2778112-1-paul.kocialkowski@bootlin.com>
 <20230324151228.2778112-10-paul.kocialkowski@bootlin.com>
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

Dne petek, 24. marec 2023 ob 16:12:28 CET je Paul Kocialkowski napisal(a):
> Report available frame sizes as a continuous range between the
> hardware min/max limits.
> 
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> Co-authored-by: Adam Pigg <adam@piggz.co.uk>
> Signed-off-by: Adam Pigg <adam@piggz.co.uk>

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej


