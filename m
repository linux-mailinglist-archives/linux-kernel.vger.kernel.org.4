Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 714DC61E133
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 10:13:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbiKFJMs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 04:12:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbiKFJMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 04:12:45 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B6E06270;
        Sun,  6 Nov 2022 01:12:44 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id ud5so23163365ejc.4;
        Sun, 06 Nov 2022 01:12:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DSBiqNlNBgNvlKGWuMBUaPKxalzmOwOwUz1x9SgGcjQ=;
        b=LUALh1kWYQyMVLx7cxytjtQLUkOhZzWe9Om9WRCBI557dTiX96PYgYozsR6wCPIx2l
         QWUaibDrLttjOFpsMe/NuHm1b1kYfXdkZqKnF7l/b3LNbrunE1hU3JEhkTyLRE8XW0l3
         SVGum080bylTATTcuqridl2mPyIY25jEXPfv10Wh3Y2vkZsCJTuSpL76i+AmlcUdMb6l
         Fx0a1HIjQn+gXAuaTWKKmisHhkM6nBZis5qYuDhSRWeUE/4SLgyhbvGMutO+6NrnrZQE
         vIKYs3aUP8VRkr2URzhyeo8JiiyvmHD4d+wbI4vujr6udryw74B4MakmNHI7l4kuWr+c
         AhrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DSBiqNlNBgNvlKGWuMBUaPKxalzmOwOwUz1x9SgGcjQ=;
        b=tsAOW+8evBghujlocBwjro5h0OpuPtKKTW5fiTWVJMozgFAaPhKnl0ijtx+LmOBgLn
         K7tOifycL5MOuoT31diJxy66r1WQk/QkxmDyW4MCEhZjL/zxv48ckeRXU9fUv1Q+kDNx
         zmVw7y4UBTo15mBsExLtHnCmTYiw668bMxzKYS/NiOTtBxQw7z0yY4dQroK5a0s6IuXV
         9cF47st4v167XtnrUU2XCNPS2lW81W1zABqYK+bglrYlbMPecCu9/SHbKP0EBZj+vTTn
         NJE/DpmBlj4z3BaozPh59eBvNfwPtru5g25jHQSuNr/bZFsuwQBYf/Vdl2ICYlWxVv18
         AmZw==
X-Gm-Message-State: ACrzQf2uYQI0VjQVYxcI8F4nFvW6gadRg+CM4aMHaMhcSxWud4VsVtHX
        H8qWAVegBXKz2GSM1kKf/AfrK4AFQjGk9g==
X-Google-Smtp-Source: AMsMyM7ohNOYzEIyWaeEnQ+5i9q5aQoQJ1XqPUaLHl3klPnbQbCFqMfooVfOoaj24IRCDX1yb3VlnQ==
X-Received: by 2002:a17:907:88ca:b0:7ad:b635:2f1c with SMTP id rq10-20020a17090788ca00b007adb6352f1cmr40788233ejc.6.1667725963116;
        Sun, 06 Nov 2022 01:12:43 -0800 (PST)
Received: from jernej-laptop.localnet (89-212-118-115.static.t-2.net. [89.212.118.115])
        by smtp.gmail.com with ESMTPSA id r2-20020a1709061ba200b0078a543e9301sm1849285ejg.200.2022.11.06.01.12.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Nov 2022 01:12:42 -0800 (PST)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v8 5/6] media: sun6i-csi: Detect the availability of the ISP
Date:   Sun, 06 Nov 2022 10:12:41 +0100
Message-ID: <5312214.Sb9uPGUboI@jernej-laptop>
In-Reply-To: <20221103163717.246217-6-paul.kocialkowski@bootlin.com>
References: <20221103163717.246217-1-paul.kocialkowski@bootlin.com> <20221103163717.246217-6-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne =C4=8Detrtek, 03. november 2022 ob 17:37:16 CET je Paul Kocialkowski=20
napisal(a):
> Add a helper to detect whether the ISP is available and connected
> and store the indication in the driver-specific device structure.
>=20
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej


