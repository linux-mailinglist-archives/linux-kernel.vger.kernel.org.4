Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 326226CD119
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 06:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbjC2EPP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 00:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbjC2EPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 00:15:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ACBD35B5;
        Tue, 28 Mar 2023 21:15:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3D4F5B81EA9;
        Wed, 29 Mar 2023 04:15:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8988C433EF;
        Wed, 29 Mar 2023 04:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680063302;
        bh=OeZwGhdh1OhMyiKBDhpSCIDowglcrCZD9EdOvHs4euc=;
        h=In-Reply-To:References:Subject:From:To:Date:From;
        b=uSzeR7sCDnhf4k0KFCoVmxreYmsgU7LkeN3MdANZ3Z++Yrl4lZBXqmcOq0/1qGoYH
         dnNJw5YysLkr92ae2gs7oc+qqCVBI7dZ03PvQfLpXFyPsZwuYs1JLL3SiOZ6GOeJhX
         ZoO9kowVg5lYCoZTWxf/Y5eLVNILED0DxVSjJlDaWC7maen+Hzg9hvnqEZWg50Mx3H
         6LNpwwB8CLkazqcf8BWE4jr+qMJvW/9GWd0ts91LOffixfAdwcx6V08sZbYShdgcr1
         R4qxJh6W2zkAWr5qcMxYqWFHHNmzoJWO1NriwSQOA5If3XIuJZ75AWYdljD6Qu3Evd
         NN9XT5jI8U1JQ==
Message-ID: <7cf9452c60f2b1c764b01a15a4d5c2f0.sboyd@kernel.org>
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
Date:   Tue, 28 Mar 2023 21:15:00 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The subject says 'spi' but it's actually 'spmi'.

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

Acked-by: Stephen Boyd <sboyd@kernel.org>
