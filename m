Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CEF16CD125
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 06:17:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbjC2ERu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 00:17:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjC2ERs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 00:17:48 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11C95193;
        Tue, 28 Mar 2023 21:17:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 30CFACE1E9E;
        Wed, 29 Mar 2023 04:17:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EBF6C4339C;
        Wed, 29 Mar 2023 04:17:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680063464;
        bh=eV+z6VEaC2dINI98VszrbaiHTFz32QNR/TbnF151vTQ=;
        h=In-Reply-To:References:Subject:From:To:Date:From;
        b=n7hHoT9cl4BahD9JFvPKB/aQB761g/fnk9KOSQ4o/z3XCcbxVkzNXykCpetV4JMcb
         lKbnfFksoTf1RSJUMCOfr73CEq3qqeAiYcfo+/nxbj1z1H99Kn6MJB013kAVtoMaBj
         q6hkpyychUIseBiT9ydWEHjqWN30KUhmPOcUGU9u1tLQThnCFsu1tqpWJ/6c7AtJLc
         rSsNaKKxTzgFVIJ+4mFqu4ZmcrtFT/tPtmpU+nLtI20acClSmzkvUYLh31TBOS+V5i
         9wiq+TfU8CzOWNnOCGS9p47Niz4LN/UokOEmy2Ffp+sqFnmgypTEgIuBbYAbmZ1Dov
         G8AoiXz4invKQ==
Message-ID: <7e58e5c86bd602932b762f9364209e31.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230310222857.315629-2-krzysztof.kozlowski@linaro.org>
References: <20230310222857.315629-1-krzysztof.kozlowski@linaro.org> <20230310222857.315629-2-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH 02/16] spi: mtk-pmif: Drop of_match_ptr for ID table
From:   Stephen Boyd <sboyd@kernel.org>
To:     Alim Akhtar <alim.akhtar@samsung.com>,
        Andi Shyti <andi@etezian.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kamal Dasu <kdasu.kdev@gmail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-spi@vger.kernel.org
Date:   Tue, 28 Mar 2023 21:17:41 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Krzysztof Kozlowski (2023-03-10 14:28:43)
> The driver can match only via the DT table so the table should be always
> used and the of_match_ptr does not have any sense (this also allows ACPI
> matching via PRP0001, even though it is not relevant here).
>=20
>   drivers/spmi/spmi-mtk-pmif.c:517:34: error: =E2=80=98mtk_spmi_match_tab=
le=E2=80=99 defined but not used [-Werror=3Dunused-const-variable=3D]
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

I'll fix the subject.

Applied to spmi-next
