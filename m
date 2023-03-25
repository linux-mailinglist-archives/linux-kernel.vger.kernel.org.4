Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 739E06C8C19
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 08:09:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232097AbjCYHJl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 03:09:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232064AbjCYHJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 03:09:39 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A96B1910D;
        Sat, 25 Mar 2023 00:09:38 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id eh3so15985957edb.11;
        Sat, 25 Mar 2023 00:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679728176;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w/ujjclnWN6KTk5hPb9bPEGuHnH9sHPNMeXaNyMo1OA=;
        b=k0z1HkfqgM6MV7LVa6pQFGBeC3p+S49jZ3AiOa5iqNJeoO9nydVGJll6iVMav6iIN3
         YzGNORS7NT+LWtGATl37V2TJC9aY0pXlkicNJkMmGTRpIh1XJ4XrIrGuKtQIPBuYjMNQ
         9uIrvsfIoTjNq7jbMXTHEVn/eXtqOoUo81MCtbpZ0uAAcNpGEpgxki/J8om4wiU8n36/
         kczUdX2CeyNjZPDAy+t122rwgGwUqo3P0Ai7+hHZ0Jt+q6VgitrgISOVDT7mJUAj9/oT
         iRiBUDnRmDHBHw2jhVD3n4Rl6kU8s/mVXiL35Dn4P3VhVOdB3fG2GXs/Xy8N4SxEBfSO
         Z8rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679728176;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w/ujjclnWN6KTk5hPb9bPEGuHnH9sHPNMeXaNyMo1OA=;
        b=gRB16RyEVHYjVVzBoA9o90KXP5xiyrapmUhJaiRQb7lBDA2qlljvnO92tWA1Uy1oKS
         DUwIn6FfRtUZgtm329h5qs1uRZFVAJSW2DSe1q0j/4vnPnZ9bcrTNi60QiOr8cBMJBgp
         tQWCYBvadKZmqzPrGliAt2Eeo2ZylSKjIkimTWFRL6TZz4FWSC53RtkULdqMGv+2N0V1
         KIybDV7DeIDZQJFtAQp/9ZGFJi8h8tbth5H9zk1y4h7guJHFti11OhTM7wc7gaNP0Ko1
         7KPJueShCAry99B3S0SBoxu1FLaSziyO+P2XmtyoCaVsqI8H1ZCVmSl1vVu3FGhyENQ5
         XAPA==
X-Gm-Message-State: AAQBX9frqullZnTAWuefOK+sWW5aQALExOgyerAZewaY/yhaWJV9JTEI
        flY640WruOWnici6xEAcz1UuxYTGRhs=
X-Google-Smtp-Source: AKy350Yrm8NxzzWwq4tTErI98MNS8Ww+7IHh20SBFhf2jmwE3850/8lWC0puzBAICPFykXML2kpL6Q==
X-Received: by 2002:a17:906:da07:b0:931:6b2b:a671 with SMTP id fi7-20020a170906da0700b009316b2ba671mr5421623ejb.65.1679728176520;
        Sat, 25 Mar 2023 00:09:36 -0700 (PDT)
Received: from kista.localnet (82-149-1-233.dynamic.telemach.net. [82.149.1.233])
        by smtp.gmail.com with ESMTPSA id i22-20020a17090671d600b0093348be32cfsm9448552ejk.90.2023.03.25.00.09.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Mar 2023 00:09:36 -0700 (PDT)
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
Subject: Re: [PATCH 5/9] media: sun6i-csi: capture: Rework and separate format
 validation
Date:   Sat, 25 Mar 2023 08:09:34 +0100
Message-ID: <2872678.e9J7NaK4W3@kista>
In-Reply-To: <20230324151228.2778112-6-paul.kocialkowski@bootlin.com>
References: <20230324151228.2778112-1-paul.kocialkowski@bootlin.com>
 <20230324151228.2778112-6-paul.kocialkowski@bootlin.com>
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

Dne petek, 24. marec 2023 ob 16:12:24 CET je Paul Kocialkowski napisal(a):
> Introduce a new sun6i_csi_capture_format_check helper to indicate
> whether a set of pixel format and mbus code are compatible.
> Most of the logic is taken from sun6i_csi_capture_link_validate,
> with extra checks added along the way.
> 
> Note that v4l2_format_info is now used for all pixel formats
> since they should all be listed in the helper at this point.
> 
> The motivation behind this change is to pave the way for supporting
> the mc-style enum_fmt.
> 
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej


