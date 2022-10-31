Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E4A561324D
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 10:11:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbiJaJLB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 05:11:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbiJaJKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 05:10:49 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40E63DED5;
        Mon, 31 Oct 2022 02:10:44 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id u24so7250703edd.13;
        Mon, 31 Oct 2022 02:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o48W/QGPdWIlzJ0mxNkgDcBycjNxJi2Vko9v4xoh1fM=;
        b=SRBSzrqxXwelI816T9OPBTFhYZwzByI38DmZmROHZ5gQYy7ow69i1Nuiniy32wVZ2M
         TGVSSNJBjCPtE0wgELBM6J+1La29BEW6lW87cfwqdCGiUzSGYRqqIBUfMIbpY9jtYVgq
         er8OSMUJxwNGK+hOpLZnVNnhQvK8rpTOweyq4zKmnZiEh5Ko3GCAqdWVWyVIQEILNzMi
         8ofjMA3mA0CQUa7hhiQnpGiGn8p3OkEIceZgJFDsknSX1Diws3SzeuYFQqjtdw8+sfah
         7ImNLCa42Wk5rUzv9IPm2u/CxayaB4tLZQqunp1MOC8NCLMkIZ1Hst5464rPI/IJ5qC/
         Gm+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o48W/QGPdWIlzJ0mxNkgDcBycjNxJi2Vko9v4xoh1fM=;
        b=5n7cleyw+ZZLrfhJjyzBIQ52SK1qNZ3jYhF7unSV4wPfsWcenNike9gv7rivqf/xkT
         igNfS/Y1ImKcZ/ekT7ojqoSTBpO1f0FQQldvzVHRzbHylESsKq/YrlDbOzk5jiI3apR6
         cJCV1EvxU2MqlhkQCa1QTDOG8BM2xdv9iNWyoJhkxE35TomzfXRgMLblkxV0ewxK/aXy
         PmDJKlSjZRg9ITjqnEge1+oE8CNGH/ed7ilgkim6SGNsDZxl27yjTBAauEbXGplm0LiN
         N3JkhvW31CTIIKfPkXu848Q43rrX/7SEG0VbxdfC+8sXLIHi1jrmZ/aixGjQCJt4cBCC
         9m1g==
X-Gm-Message-State: ACrzQf1ymd0oZzSuiSiuyDatUf1UzEvSDbtxCK9TvYRKZCwQeChxGj5x
        42Ygo8lqg0Sg0sQL2Cn9LC5JZtfh8/0=
X-Google-Smtp-Source: AMsMyM7W1MiAWrqsxt403h66Nae6oWchB8b5Le1iuYzwKU9F019jrzSr4RrlDt/Gk7cud1b/vOv8WA==
X-Received: by 2002:aa7:cf0b:0:b0:461:2271:8559 with SMTP id a11-20020aa7cf0b000000b0046122718559mr12708767edy.92.1667207442723;
        Mon, 31 Oct 2022 02:10:42 -0700 (PDT)
Received: from kista.localnet (82-149-19-102.dynamic.telemach.net. [82.149.19.102])
        by smtp.gmail.com with ESMTPSA id y26-20020a1709063a9a00b0078246b1360fsm2725893ejd.131.2022.10.31.02.10.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 02:10:42 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     Yong Deng <yong.deng@magewell.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v6 16/43] media: sun6i-csi: Add bridge v4l2 subdev with port management
Date:   Mon, 31 Oct 2022 10:10:41 +0100
Message-ID: <5614788.DvuYhMxLoT@kista>
In-Reply-To: <20220826183240.604834-17-paul.kocialkowski@bootlin.com>
References: <20220826183240.604834-1-paul.kocialkowski@bootlin.com> <20220826183240.604834-17-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne petek, 26. avgust 2022 ob 20:32:13 CET je Paul Kocialkowski napisal(a):
> Introduce a bridge v4l2 subdev to prepare for separation between the
> processing part (bridge) and the dma engine, which is required to
> properly support ths isp workflow later on.
> 
> Currently the bridge just manages fwnode mapping to media pads,
> using an async notifier (which was previously in the main code).
> The s_stream video op just forwards to the connected v4l2 subdev
> (sensor or MIPI CSI-2 bridge).
> 
> The video capture device is now registered after the bridge and
> attaches to it with a media link.
> 
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej


