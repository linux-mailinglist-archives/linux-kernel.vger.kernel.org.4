Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50DA06FE429
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 20:44:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbjEJSoL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 14:44:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjEJSoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 14:44:08 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C368D8F;
        Wed, 10 May 2023 11:44:07 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-965ddb2093bso1056368966b.2;
        Wed, 10 May 2023 11:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683744246; x=1686336246;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wPS2VOYPj9tvhVnf11tmZgqUIiOL0oJR1EZsgcJxV5Y=;
        b=BrXkYLveWgEDMLIx+hk2YsTKuck1qBJH2+cVNfTxpVbGMw3PO3P9v2ilSoAs2esdyU
         R+C/jPQPrldO9hwRMTtrYIVggF+Jqn3303ZhYxN+zGIo8OuNGoY7+s8Cf4XHdPcMU+RA
         FaycWzcf+Y4cls7Z43lP3FRp2gN0yadZlXTq7uGzsDVCMX1ffGmSq83ewYF6TfZHMTTh
         yJ1GxVV//IT97eW5fvylBXOgnQDycwvpQG5jCUXW4wnB0Tyx5wVe1nWhj+qa56qUHJT+
         sE/0qaicg19IXMYEEqMvy0o1a5Z4x1dXCIxi6OkBqgYyRollUbHzJ/3JBTrQrNQUbqc/
         8H/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683744246; x=1686336246;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wPS2VOYPj9tvhVnf11tmZgqUIiOL0oJR1EZsgcJxV5Y=;
        b=DKkVJcPpYMYQ19+w90UtzniMYlc8Q5qZX+1iK+nxw5ILKROUTf3d/YVtoeMQZXwUjW
         aGzenv943VbQ2uTJeT9e/eeAXa/HMKLdRlQLbs2yutj6HYkCgCg0Dn4CLppn0oZQ+oSX
         GZhrI+xAHDGEbzv51CUlzQzX1AhL+fyWiQ4zFVVvdj2ThHG4HKkjhaC/EHm5fOasMpjP
         /RjN3Mgd/AvvKHOw8fCWc7XFAUY7CuewrPGc8sgy0+JP/p2GnOKWORLIT5ZmJ4q58Qbv
         DwlD5eYt8gDqykhp7rOWyG12O4RDaO7nwvjLuhkUkKBi9Fyuej/IXiEKbF6k9TKh86yU
         j/AA==
X-Gm-Message-State: AC+VfDyAFrls+NTR16DduJtB6XS0W8ORinxhcTIqRQ6UqEAn/fFqamqk
        aEim0m4FkTlNbDBqRHOMlBc=
X-Google-Smtp-Source: ACHHUZ4hCWeeIeHV2i78urTzM1T1DLqwN/c7QodoCeW4ajn/Fdkro9dtvrwr4zJg5A9dC5Mm+S7kRA==
X-Received: by 2002:a17:907:25c3:b0:961:b0:3dff with SMTP id ae3-20020a17090725c300b0096100b03dffmr15898231ejc.14.1683744246050;
        Wed, 10 May 2023 11:44:06 -0700 (PDT)
Received: from jernej-laptop.localnet (82-149-1-233.dynamic.telemach.net. [82.149.1.233])
        by smtp.gmail.com with ESMTPSA id h21-20020aa7c615000000b0050bcaedc299sm2151054edq.33.2023.05.10.11.44.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 11:44:05 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Roman Beranek <me@crly.cz>
Cc:     Frank Oltmanns <frank@oltmanns.dev>,
        Icenowy Zheng <icenowy@aosc.io>, Ondrej Jirman <megi@xff.cz>,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/4] ARM: dts: sunxi: rename tcon's clock output
Date:   Wed, 10 May 2023 20:44:03 +0200
Message-ID: <4830298.31r3eYUQgx@jernej-laptop>
In-Reply-To: <20230505052110.67514-3-me@crly.cz>
References: <20230505052110.67514-1-me@crly.cz> <20230505052110.67514-3-me@crly.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne petek, 05. maj 2023 ob 07:21:08 CEST je Roman Beranek napisal(a):
> While the rate of TCON0's DCLK matches dotclock for parallel and LVDS
> outputs, this doesn't hold for DSI. According manuals from Allwinner,
> DCLK is an abbreviation of Data Clock, not dotclock, so go with that
> instead.
> 
> Signed-off-by: Roman Beranek <me@crly.cz>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej


