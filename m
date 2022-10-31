Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3EA0613231
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 10:06:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbiJaJGO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 05:06:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiJaJGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 05:06:12 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7676020C;
        Mon, 31 Oct 2022 02:06:11 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id d26so27667741eje.10;
        Mon, 31 Oct 2022 02:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g0snT4n//h/2k97Qobb3JRu1DhhY5eqFOKQUrnEmwJA=;
        b=EadVQDvXTd2a2c0lt8q3h3DJE69Qed2JO2ph+XpyOEsWL16C732jST4btYtzdn2prT
         GBR/zf4c/Sc5wlSPe0lnAgDD/DhuKBTm3jE6FNHx3x/4/TxkJyrre16xDYCd056nLkKv
         hSQy0iOkqLK8uMaWYFemSgXMeue6NXfSazQhL6EsF9gKVotozpakMkM03mKocbrL/FuZ
         YU1OwhUCtHQMtfq96N58S9fFhSjoN7Ow6DsfPx5wYPKstLxFC1Lt0hiM9EIfY/kpdCiO
         AtbWuIAE+a4VfUzcnTGoxGfh0/ZRsuSu3pzC4Bl3gzg89zDO0EisQG/+MbWB/HYnaWsc
         a8JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g0snT4n//h/2k97Qobb3JRu1DhhY5eqFOKQUrnEmwJA=;
        b=0OZ3iidl3NFSD5D/EbQImErlzHuPp1XO6y5WTeEBv2d114CsCfZDThsKUnmOiwweog
         KCI6uh2gv4UFqhOSBFw7/S3fSkb3hiKjLwaLQk7wP0YGCu8lUtRz77Nau98BunS5y3er
         jggyVqnxWWgb8cJ0OQdVfZfRUyVXqvRV2eWz4XdNRuDKT2TeHbX5X5PK/TxEyE826xRH
         XPHrfGhVGl3jSd3X00SMtdmdo5rnRVXtT3KXlqKvW90zWAi4VSbJXOL2GsIdqWYOjOMz
         9l+mJ0+YQ9MgUmolcXDlwWC2P4Ci8vqNptHFjVINcJJZ3t/4/iy4BqsnbLyeZSjAkG8d
         nQpQ==
X-Gm-Message-State: ACrzQf16TqTzGYwKZuFah5TW2eHEauXXc8gcJU6/MxhEPpy8YfKwqG3x
        TAInKFPWx4hLdifnmzjKHnrEIj6V/jo=
X-Google-Smtp-Source: AMsMyM5L86KUeUMD4iAbsJdWgAWfeyjlYpqLNh5oE8wsCNG6E5CxxPG16p/8/6NFW/9K27pE18u3OA==
X-Received: by 2002:a17:907:b07:b0:7a8:beb3:aa2a with SMTP id h7-20020a1709070b0700b007a8beb3aa2amr11742021ejl.459.1667207169941;
        Mon, 31 Oct 2022 02:06:09 -0700 (PDT)
Received: from kista.localnet (82-149-19-102.dynamic.telemach.net. [82.149.19.102])
        by smtp.gmail.com with ESMTPSA id jx24-20020a170907761800b00730bfe6adc4sm2752122ejc.37.2022.10.31.02.06.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 02:06:09 -0700 (PDT)
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
Subject: Re: [PATCH v6 12/43] media: sun6i-csi: Remove controls handler from the driver
Date:   Mon, 31 Oct 2022 10:06:07 +0100
Message-ID: <2651862.mvXUDI8C0e@kista>
In-Reply-To: <20220826183240.604834-13-paul.kocialkowski@bootlin.com>
References: <20220826183240.604834-1-paul.kocialkowski@bootlin.com> <20220826183240.604834-13-paul.kocialkowski@bootlin.com>
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

Dne petek, 26. avgust 2022 ob 20:32:09 CET je Paul Kocialkowski napisal(a):
> The driver does not expose controls directly and thus does not need
> a controls handler for its own use.
> 
> Controls attached to subdevs used to be exposed that way, however this
> can easily lead to issue when multiple subdevs attached to the same
> v4l2 device expose the same controls. Subdev controls should be set
> through each individual subdev node instead.
> 
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej


