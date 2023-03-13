Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04F3A6B77EB
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 13:46:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbjCMMqV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 08:46:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbjCMMqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 08:46:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CF256EBB;
        Mon, 13 Mar 2023 05:46:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D4C0F61277;
        Mon, 13 Mar 2023 12:45:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABDBDC433D2;
        Mon, 13 Mar 2023 12:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678711559;
        bh=qVkmwXonH8hmMSSCuPxE/fYZDjtdar66MDKlKu02CYg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YviOT9U7ELoxrS3EwLG3X7qlriMbweVhj5Kek/YLMV+E/QrriI1BSExdG/pcc46GW
         At6bYmXyqHEyOkXbVoMlRLvmSIW65zg13KX53Pi1ISApLImH7x0GnXvHeMaJsF1W1Y
         g4x6tflym2Dd7Dy4wBUC5yVKPUoMvaKMmvCx4K/d/eey/y+OBgLFkaoIqK2hfpN5Q4
         Xnut8+nuUTm0IluESvj37VI29Cn/JjQ5dAb2EvHzvui4XbN2hJmhKqEDUOph/rscT5
         zWRKTs3ogfflZDFof8WeDwgLcTuY9Dim9u7/wP8tRkeBlrFivCA5L6wK194SuSmRy0
         XJ299IuuVz45Q==
Date:   Mon, 13 Mar 2023 05:49:23 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Eric Chanudet <echanude@redhat.com>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sa8775p: add symbols to dtb
Message-ID: <20230313124923.iwaknvrnitqal3wa@ripper>
References: <20230309233945.1199358-1-echanude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230309233945.1199358-1-echanude@redhat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 09, 2023 at 06:39:48PM -0500, Eric Chanudet wrote:
> ABL uses the __symbols__ section to process the DTB before passing it
> forward. Without it, the bootstrap is interrupted.
> 
> Signed-off-by: Eric Chanudet <echanude@redhat.com>

@Rob, @Krzysztof, it seems useful to be able to use the upstream
generated DTBs with overlays.

Do you suggest that we enable this on a per-board basis when it's being
requested, across all devices, or tell the users that they have to
re-generate the dtbs themselves?

Thanks,
Bjorn

> ---
> Depends on initial sa8775p-ride.dts:
> https://lore.kernel.org/all/20230214092713.211054-3-brgl@bgdev.pl/
> 
>  arch/arm64/boot/dts/qcom/Makefile | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index b63cd1861e68..72e85ab31d74 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -1,4 +1,8 @@
>  # SPDX-License-Identifier: GPL-2.0
> +
> +# Enable support for device-tree overlays required on sa8775p-ride.
> +DTC_FLAGS_sa8775p-ride := -@
> +
>  dtb-$(CONFIG_ARCH_QCOM)	+= apq8016-sbc.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= apq8094-sony-xperia-kitakami-karin_windy.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= apq8096-db820c.dtb
> -- 
> 2.39.1
> 
