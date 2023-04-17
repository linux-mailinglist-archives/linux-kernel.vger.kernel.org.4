Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E814C6E474B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 14:13:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230311AbjDQMNM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 08:13:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbjDQMNK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 08:13:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB9669023;
        Mon, 17 Apr 2023 05:12:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 74EFB62328;
        Mon, 17 Apr 2023 12:12:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB5E2C433EF;
        Mon, 17 Apr 2023 12:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681733553;
        bh=eNV1zUDagB32PHHEZMYchgD0JkU4lTO2tcK5xBVvozg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kXEY4kbPp7jM8iD80BIvQUEzp1K3o9bxJ/sjeCCR8O+WbTZHKyKfDx7YrsmJBqCL/
         e9IcxsnDn/2RCF7NLY+/W0EsgtEcxitc3hbiIn6fWwsz4NlYDdspsPfj+fqF/tXupX
         YCGt7FN5YecLdvEtSTg8YB1K/CnWcaSzE1ZKCWcb0sNMry3W4axgh8WIT97vC2xk6c
         m0nH3pjwCvRHR/61jXMnEPmjUm5Z+h6ja/oYIrWsbw12SWRLL5VnoncQDl5Mz8Cb68
         fAjciGRQ1RkY2qWaGXCNINiOKPVt2XOvl07iR0GDjeffA34iskLTsAzMusK2tkW6zX
         Tce9NkxxNN5vA==
Date:   Mon, 17 Apr 2023 13:12:25 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_msavaliy@quicinc.com,
        mka@chromium.org, swboyd@chromium.org, quic_vtanuku@quicinc.com
Subject: Re: [PATCH v3 3/3] spi: spi-qcom-qspi: Add DMA mode support
Message-ID: <30a752c9-3ea0-43d3-959a-da2e8b526cb4@sirena.org.uk>
References: <1681481153-24036-1-git-send-email-quic_vnivarth@quicinc.com>
 <1681481153-24036-4-git-send-email-quic_vnivarth@quicinc.com>
 <CAD=FV=VKY-0vX271G+EQQ5kC3gTqpPPyTGE0xHWPBncVUhZufQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="QerR8LcbkWiaBCb1"
Content-Disposition: inline
In-Reply-To: <CAD=FV=VKY-0vX271G+EQQ5kC3gTqpPPyTGE0xHWPBncVUhZufQ@mail.gmail.com>
X-Cookie: Two heads are more numerous than one.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--QerR8LcbkWiaBCb1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 14, 2023 at 03:05:58PM -0700, Doug Anderson wrote:

> Having alignment requirements like this doesn't seem like it should be
> that unusual, though, and that's why it feels like the logic belongs
> in the SPI core. In fact, it seems like this is _supposed_ to be
> handled in the SPI core, but it isn't? In "spi.h" I see
> "dma_alignment" that claims to be exactly what you need. As far as I
> can tell, though, the core doesn't use this? ...so I'm kinda confused.
> As far as I can tell this doesn't do anything and thus anyone setting
> it today is broken?

SPI consumers should only be providing dmaable buffers.

--QerR8LcbkWiaBCb1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQ9N6gACgkQJNaLcl1U
h9A0RAf/Q/Bi/4JeWGxUTZ0r2ETK1oo6ycZJpBYut1iRufKN7g8gHo0D+I7u4ShX
PbOSybrq4CnyaGqfmtBnuBBBS/4VX9Ryu8mj5XTkLKyUbamhzjUZj48SauEkufN8
bUkhQ5VZtCrIOd+aWVUIBX5L+VyAmjXddaHINuWUHXIYy5w5/Z/23ES7iUqsjUe+
LIDO3zSxDkssalpPAsbCjcoYDBs+oRmIUUNvbwS5FlaTsl3yIq9r75YXHd/lUHXf
EuW/RGag45g7zSGN02g15P0wvajWATasTYWuEnWxNMV76YOiRbmtZ8vedV1bsGPP
O4J9kUULTNCnTdo6M5NRqqWfIXdCvQ==
=/PHR
-----END PGP SIGNATURE-----

--QerR8LcbkWiaBCb1--
