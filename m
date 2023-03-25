Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61A6E6C8C0E
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 08:06:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231960AbjCYHGJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 03:06:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231928AbjCYHGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 03:06:08 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E0FB15CBB;
        Sat, 25 Mar 2023 00:06:05 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id r11so16083178edd.5;
        Sat, 25 Mar 2023 00:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679727964;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CWzZjuKdZZ8Q41Kypgjwm630o9Xz66N9zx57beMyRnE=;
        b=Dz+KHMweeCAV0UaTu2DCL6ZJ4rBQy5Khd0fEvgajww3FNewXVlalFD+0kYl6hxadSQ
         YwkGwSIOl/wWnpBi9vdnyQtPuC4wQlf4eML7eZdraGB468yA8y7lbpZ/O5SAuGXmhpAh
         0HwCpymSkpjVEPNBmtmxlJXAJlvDKnJdz9Nke3n9/64qDB7Rt4JL35YZcWBM3lyvZp51
         BsJhihkf5LgWO3kwb4KwLYYYqLZI5hvQfx32vjd4zoBNLsqajtpkdto8GGdqBNMyjf08
         vLYjzBfxyJNuPFlYNDjZoHyLvW+/WRGQQGLwqEV0DCI/r+l+fdL3a+Euu50JgPvC9nW5
         NboQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679727964;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CWzZjuKdZZ8Q41Kypgjwm630o9Xz66N9zx57beMyRnE=;
        b=2PyURImdaKcNiJFrMc9DZsqHTksbaEaGWevNoHgQ5dxxQh9ueOCVyf301reTADJf8K
         Z9C9ElioBpARLGcec/KQGOTBcuA/nkgmAu5OCDNDjMriuoNyXLe+p4KnVi8gVlWyNubi
         6r+nJXewPMgD3vrxzSGluc5aAJ/Gj9e9sMiznBtBNGZxWwIUuiTpnVu69kjF9hZGJA6Q
         Kib+q9DY0w1z+p3LdkNJLUF1KTxA5gIuGQd3Hdjw+R6YuYiMvF+OW+42iTOt/N5wmboC
         wsKYHf7bfpdWpGtv7RQ1oAV7Bue9+oaV9dhc/LAWFOndEu+YfQtqfCIFIPBqGMGqdySt
         gUcQ==
X-Gm-Message-State: AAQBX9dZOX/0zMdWuaxQ7B7ayX+87B4SmM/3YbSuX4o7xGjv/VgLcWIP
        CRdFfjzKjvtu1nY9y68l2jSJjbtLoc0=
X-Google-Smtp-Source: AKy350YhCzO1/A8DzoSDutUqw/zDg4P/WX8y65703/YoBvnXXjHwwsnEgvSFrXD/8d9Xf1dtG3j5gA==
X-Received: by 2002:a17:906:148d:b0:8b1:7e23:5041 with SMTP id x13-20020a170906148d00b008b17e235041mr5035502ejc.39.1679727963696;
        Sat, 25 Mar 2023 00:06:03 -0700 (PDT)
Received: from kista.localnet (82-149-1-233.dynamic.telemach.net. [82.149.1.233])
        by smtp.gmail.com with ESMTPSA id a12-20020a170906274c00b00926b944676esm11392917ejd.131.2023.03.25.00.06.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Mar 2023 00:06:03 -0700 (PDT)
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
Subject: Re: [PATCH 1/9] media: v4l2: Add RGB565X pixel format to v4l2 format info
Date:   Sat, 25 Mar 2023 08:06:02 +0100
Message-ID: <5915883.lOV4Wx5bFT@kista>
In-Reply-To: <20230324151228.2778112-2-paul.kocialkowski@bootlin.com>
References: <20230324151228.2778112-1-paul.kocialkowski@bootlin.com>
 <20230324151228.2778112-2-paul.kocialkowski@bootlin.com>
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

Dne petek, 24. marec 2023 ob 16:12:20 CET je Paul Kocialkowski napisal(a):
> Represent the RGB565X pixel format in the v4l2 format info table.
> This is a big-endian variant of the already present RGB565 format,
> which has the same characteristics.
> 
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej


