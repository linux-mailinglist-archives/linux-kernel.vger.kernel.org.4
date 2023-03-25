Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C4966C8C10
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 08:06:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231995AbjCYHGi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 03:06:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231928AbjCYHGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 03:06:36 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE3AD13DF0;
        Sat, 25 Mar 2023 00:06:34 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id h8so16027340ede.8;
        Sat, 25 Mar 2023 00:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679727993;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GI9BdI1RMucEwg1yGgAeBp0D0QPkZDZvGWjMZQrZ5bE=;
        b=Kk5Kzw2q4va2tIe3+E7MWgytldyRunLz4mGaEAZVXEJPwGi24i6YsFf5v5Ixlfz0DT
         KL1stOfXNnX74QI+1Us9df6XufKJe0E0uUHDJPMDbSOeXIUt7LXmkCT9ZDPe9DMLRk9C
         55w7oaEpGMKpZAkFIq9QoY5rieHQ0tv8snNKdUOTL0XSSeY8VQm6HGLQXh5lXMKyuxR9
         d3aZIW2egWshzcyr5f91vcexeoStua64eswyNWg1gQlHqEN+EaH/Dxcb3zaj1bUMY1Ra
         dJ3V1SvbxWZKQbw96eaSCFWfcJ5/ajgcg81zzisHy0wVecSr9bGxocu1bvmnrR/ZJ1XK
         JCQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679727993;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GI9BdI1RMucEwg1yGgAeBp0D0QPkZDZvGWjMZQrZ5bE=;
        b=04Cunw8MagdsG/DImNFkoI+pTIhm+TgNcPUacyAec4gdXYLDqHZd5uJjxU3Fy6rFPC
         N6iblo4gqn3qYtxuG8k1z/VVkTSQW5ZEut58m/2aXM2fgF/xGswdSVyx2xuPIcRZWylK
         3VyNhalX6hAadUG1qhDTe20MLlodxbZoKRWoG9QMPR5i+XoQz767vsLtmK3quUkWZANN
         30ULq5QQwHjpanRHOcSWmgx+bggiPGrkDVSd4Q4Bt2Yasd3zIT3d8dACkpYti5TX68n1
         nachYRBwfFH/OS7IWj1a994TMV56tcQgwSclbHSKF8x5Vv+j4nW/XDt9Qc/kpz594w0s
         rINw==
X-Gm-Message-State: AAQBX9cGLnnDdPCE8MAwo+c/nKZ9LPWEhW3RilUnfvG6D3U44I5Vofu/
        sjxBvjKjd8eVdqo9lVvFEXREqpTDD+E=
X-Google-Smtp-Source: AKy350aWHeIkzysz3ySUNTjMdqcaw2bucYZprHzCtZSo3Gv7NktWRc+ZoORqrlQwqnfA/JZ3mOOWNg==
X-Received: by 2002:a17:906:8601:b0:7c4:fa17:7203 with SMTP id o1-20020a170906860100b007c4fa177203mr5225344ejx.63.1679727993390;
        Sat, 25 Mar 2023 00:06:33 -0700 (PDT)
Received: from kista.localnet (82-149-1-233.dynamic.telemach.net. [82.149.1.233])
        by smtp.gmail.com with ESMTPSA id kg2-20020a17090776e200b009334219656dsm9634636ejc.56.2023.03.25.00.06.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Mar 2023 00:06:33 -0700 (PDT)
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
Subject: Re: [PATCH 2/9] media: v4l2: Add NV12_16L16 pixel format to v4l2 format info
Date:   Sat, 25 Mar 2023 08:06:31 +0100
Message-ID: <4468709.LvFx2qVVIh@kista>
In-Reply-To: <20230324151228.2778112-3-paul.kocialkowski@bootlin.com>
References: <20230324151228.2778112-1-paul.kocialkowski@bootlin.com>
 <20230324151228.2778112-3-paul.kocialkowski@bootlin.com>
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

Dne petek, 24. marec 2023 ob 16:12:21 CET je Paul Kocialkowski napisal(a):
> Represent the NV12_16L16 pixel format in the v4l2 format info table.
> This is a 16x16 tiled version of NV12.
> 
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej


