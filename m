Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DC0974CC07
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 07:08:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232427AbjGJFIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 01:08:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232465AbjGJFIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 01:08:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0A2A2723;
        Sun,  9 Jul 2023 22:06:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 460F660DED;
        Mon, 10 Jul 2023 05:04:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36C10C433C7;
        Mon, 10 Jul 2023 05:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688965495;
        bh=phIY5znAcGKL80ExVNQ3VL4dsnbeApEXQjzAcBy/Heo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KB49TV6oNCWuupaGeHBI3nsULIkXkIg0rBQZr0iNROmFevzopdFISYMbG0E8ezVt1
         qILV60r+MwChIAqVXgmNDnvDYqe4+Fr8RuVrD1z5fM6TniGQUJy8iMIHrSW9tVeMJi
         tA2CT1iwQROjuB8gJ3YSyAGgNROrfBazpYAGWEjpsJXNlNkyVKnQ0tDG/9QmhBiN28
         2GtGE6TqcGcK6cHgZ4pwMNnDIpdcChmormHBBvGyKBSv4cQJH2D+n86opwuTtfmbx9
         cB5b54j0j+hsFSFkMjhJ/PEXBAiOR7TjPeX2ck7A4U9pntQD6PHOcBnk3Ri2Fjf/GP
         vzA5n5DvMRiFg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Iskren Chernev <me@iskren.info>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Luca Weiss <luca.weiss@fairphone.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Eric Biggers <ebiggers@google.com>
Subject: Re: (subset) [PATCH v5 0/5] Fix some issues in QCOM UFS bindings
Date:   Sun,  9 Jul 2023 22:07:34 -0700
Message-ID: <168896565974.1376307.14861663929943818215.b4-ty@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20221209-dt-binding-ufs-v5-0-c9a58c0a53f5@fairphone.com>
References: <20221209-dt-binding-ufs-v5-0-c9a58c0a53f5@fairphone.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 27 Jun 2023 10:28:00 +0200, Luca Weiss wrote:
> This series aims to solve the dtbs_check errors from the qcom ufs
> bindings. It has changed in scope a bit since v1, so it may be a bit all
> over the place.
> 
> Please note, that I have not tested the sm8450.dtsi patch since I don't
> have any hardware there. Testing would be appreciated.
> 
> [...]

Applied, thanks!

[5/5] arm64: dts: qcom: sm8450: Use standalone ICE node for UFS
      commit: 86b0aef435851dec9e5202d22dfbfff56da4440c

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
