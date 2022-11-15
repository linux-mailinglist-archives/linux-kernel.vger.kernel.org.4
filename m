Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4241D62A42D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 22:31:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238872AbiKOVbd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 16:31:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238793AbiKOVbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 16:31:16 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0160717E11;
        Tue, 15 Nov 2022 13:31:14 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id f18so6409572ejz.5;
        Tue, 15 Nov 2022 13:31:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NuwEA1//rEiZ9SIXSxB8K40zOCZHlQgw0PCBzNeNQ5I=;
        b=Ru5f3SLgubKJgLZYHgjKReHhixWrPdDLR8c8evvgt4Z1sbvPov+bBOAPjYv6wOmEGC
         wuh24SD/zUTThaqS11cikEg2hiMhtnB4UjWZYBHuKLQGXVaXWY5/MwN+ogAErLxjDLY7
         F2ZOvz3jMuMjBJw+Rh78sGgZMSLrHnFrsBS5nDdhsay1PzDXpH6kB2Vvpd75uVoqg0mV
         n2IgvaM/WXp+UDgByrC98g5133XF8OymuuKNNhBMcnngJqt0zBF7Xs475NIY4PUA2jPm
         X+mzskMa/eXmWbsZ50gTBAJvaxhBpOt3gv65x3+255U0NdSccgybH3yXK88HHUuwHnYT
         4M9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NuwEA1//rEiZ9SIXSxB8K40zOCZHlQgw0PCBzNeNQ5I=;
        b=O2Rs2R2JDq4Mqtr+4dXjiD5RoLK0LwE19Ep5S+4wVouUHX5JXeTIUdN9fU+DEOrOq/
         JiLuTvXFfkMq8krqc8BoRTJ9Vekmk89qrm97nOxx+Nr5Siul5yUlgR6te/PpDE415YX4
         K7rpvZeUK+3EQuONEd93iDMOIZSGFzOMMRv9VvU6d4XtfbiaIr5vpiSU0NjpOKk44+sQ
         x972ny5KfFq51mmhjVQLiRPwqniC6XkZXb+Vn3u2Fd2fQBlXWSMqmztBhwXNHoM8F+oe
         qJIsF82MRkyeZxJ8EeSiPHalDXlfxExkFIXAg6KoBn1hGUVBLUM2ZzYNVSpcsiov8Meh
         ps3Q==
X-Gm-Message-State: ANoB5pkyPly8bP89/97A1AY8KNgY/uib0tBio4nKjqulNNPkM/orKY6Y
        KENLwLXlLzNrQI2KoETU4Tk=
X-Google-Smtp-Source: AA0mqf5Zm31QFNT3PlLIzS3hN87Qrr0tlkvKMCRdGyCCwKnm2IkLh3/dCPdFhvSBQco74JxUmX8diQ==
X-Received: by 2002:a17:906:2ecf:b0:778:f9b6:6fc with SMTP id s15-20020a1709062ecf00b00778f9b606fcmr15866641eji.580.1668547872425;
        Tue, 15 Nov 2022 13:31:12 -0800 (PST)
Received: from jernej-laptop.localnet (82-149-19-102.dynamic.telemach.net. [82.149.19.102])
        by smtp.gmail.com with ESMTPSA id w14-20020a50fa8e000000b00461bb7e7ef1sm6692823edr.30.2022.11.15.13.31.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 13:31:12 -0800 (PST)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Samuel Holland <samuel@sholland.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Chen-Yu Tsai <wenst@chromium.org>
Cc:     Chen-Yu Tsai <wenst@chromium.org>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] arm64: dts: allwinner: h6: Add IOMMU reference to Hantro G2
Date:   Tue, 15 Nov 2022 22:31:10 +0100
Message-ID: <2853225.e9J7NaK4W3@jernej-laptop>
In-Reply-To: <20221115090644.3602573-3-wenst@chromium.org>
References: <20221115090644.3602573-1-wenst@chromium.org> <20221115090644.3602573-3-wenst@chromium.org>
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

Dne torek, 15. november 2022 ob 10:06:44 CET je Chen-Yu Tsai napisal(a):
> The Hantro G2 video decoder block sits behind the IOMMU. Without a
> reference for the system to properly configure the IOMMU, it will fault
> and cause the video decoder to fail.
> 
> Add a proper reference to the IOMMU port. The master ID is taken from
> the IOMMU fault error message on Linux, and the number seems to match
> the order in the user manual's IOMMU diagram.
> 
> Fixes: 0baddea60e8d ("arm64: dts: allwinner: h6: Add Hantro G2 node")
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej


