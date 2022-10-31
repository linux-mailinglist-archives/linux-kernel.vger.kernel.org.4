Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFCDB613261
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 10:18:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbiJaJSW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 05:18:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiJaJSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 05:18:20 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 886B1D2CD;
        Mon, 31 Oct 2022 02:18:19 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id x2so16534883edd.2;
        Mon, 31 Oct 2022 02:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ecCahP3NbGV/UrWYeJFBrd6bWsq75pHnaHwN/pqPc2U=;
        b=kKG6/ZIXiMapVlg3cGF3ZZBd8ugJEee+EQqOsiTFaCYHiCfxXJ53zmY5lieEH8sI75
         UPpFYhJk6gW1gUTL7EdPujVDA8hN3BlQSr/qYK8u41jJXsoTOdgwXCUTEMHallx35sX0
         Cmko9AmEYE6Np3DBfULf6QwXAUXoF4B+hCWwINHnp/1pWeo6JqwpPkncVJnXxgXD8HmN
         p5v9jLyNTjEjjLn8EEl4R/ckRl/9FpVUDAtHaJwaez2saO2727gJkXN1tgBmaL8Oh3Eb
         wA5c2Pu0+fK7AAjSmPi6iHwftOswU044EryL81nETC8U8remaxDV69Fjk8AJiclbZo3D
         t2yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ecCahP3NbGV/UrWYeJFBrd6bWsq75pHnaHwN/pqPc2U=;
        b=y9ID1nCq9n20TIcS4eoawdopEuiTTbaHtJNhr47Y4Ccsa4AGEu5snZGIH9eCSl4NOc
         oZit4mQ03Fg7SM/PClHuquioPkr+odBqUS+zuGHpDynVihiUPOaJNAhZtqt2pY7yRXGy
         qBeuw8SSxTwoAa/iXyjNHd3Nop4E9X504vaydVEfs2nXYptDXU0kaIdmyj5QXrxru6mn
         p/7hb9RPmJHaWB17TApMP9XNgKed19GkRBfW+gCUL2505hJMZf+tvaPL6kee+9u6GWX+
         lbFuEkM9//e22nOFLm+Keb5WoSl1COfofS5W+DQnleOgvhBKEqsAmwW2zvRhOme1eXc0
         9UhQ==
X-Gm-Message-State: ACrzQf0XzNO2QwwcteFCUHwckcumvG78ondg6zOMgk0okYLcuaP24w4M
        OPgEhIkBerdVpkT0T0nb5fZdyxw1f8g=
X-Google-Smtp-Source: AMsMyM63sIee6jJUO+QTZM8eD94QlMVcR1aUAVyeVWqhd61IiQpO3wxZvuGEssEFhsz6dRiZfPUcdw==
X-Received: by 2002:aa7:d458:0:b0:45b:ddbf:39fa with SMTP id q24-20020aa7d458000000b0045bddbf39famr12714032edr.335.1667207898047;
        Mon, 31 Oct 2022 02:18:18 -0700 (PDT)
Received: from kista.localnet (82-149-19-102.dynamic.telemach.net. [82.149.19.102])
        by smtp.gmail.com with ESMTPSA id a15-20020aa7cf0f000000b004616b006871sm2968662edy.82.2022.10.31.02.18.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 02:18:17 -0700 (PDT)
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
Subject: Re: [PATCH v6 36/43] media: sun6i-csi: Move hardware control to the bridge
Date:   Mon, 31 Oct 2022 10:18:16 +0100
Message-ID: <2257327.ElGaqSPkdT@kista>
In-Reply-To: <20220826183240.604834-37-paul.kocialkowski@bootlin.com>
References: <20220826183240.604834-1-paul.kocialkowski@bootlin.com> <20220826183240.604834-37-paul.kocialkowski@bootlin.com>
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

Dne petek, 26. avgust 2022 ob 20:32:33 CET je Paul Kocialkowski napisal(a):
> In order to support the isp workflow, we need to be able to configure
> the hardware from the bridge when the capture device is not used.
> 
> As a result, move all hardware configuration calls from capture to
> the bridge. Only the window configuration part (which is specific
> to using capture) remains there.
> 
> This effectively opens the way for hooking the bridge to the
> isp in the future.
> 
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej


