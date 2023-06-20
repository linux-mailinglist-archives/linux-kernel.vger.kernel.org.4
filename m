Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A360373739A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 20:15:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbjFTSPB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 14:15:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbjFTSO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 14:14:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C87A1199;
        Tue, 20 Jun 2023 11:14:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5D59B61358;
        Tue, 20 Jun 2023 18:14:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 581AFC433C8;
        Tue, 20 Jun 2023 18:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687284897;
        bh=oS71jJIpPfGeBkc1SVNu2IOd3HxB2C9NjFUUQpei/oc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=a+4EnNcNi2GkkACyIYoskSPxqvQ2cvhsc7xaCLyVJi+xL7n/tuFFbNKW/Jk9kDmTu
         xCM0qZVnNSy18xpuQm1jdJeVR9KCRM82+vb26KALKa4vjUZ1SHmgLC+fdSnSO2sVRJ
         LvZ+iA/zDTJvyUWzWKyDPHlIBuVCZ7VDFgINZBr4TE3XQ6H0oyLXnvj386tPFaFMn6
         kgoD8caZDe/2dfmH7Fd/gndraKJPzgzqKnJOIw3TjcotYIgJgxUrSIjj2749zIrl9w
         CtP/d46lK0fwyGnp5lsrk2s48cnmzPe77PIUUN99zsm4vMb4ar4Rr2/glyMCGqhDI6
         0hIzxCMIWEa1w==
Date:   Tue, 20 Jun 2023 11:14:56 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        Rocky Liao <rjliao@codeaurora.org>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] dt-bindings: net: bluetooth: qualcomm:
 document VDD_CH1
Message-ID: <20230620111456.48aae53c@kernel.org>
In-Reply-To: <20230617165716.279857-1-krzysztof.kozlowski@linaro.org>
References: <20230617165716.279857-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 17 Jun 2023 18:57:16 +0200 Krzysztof Kozlowski wrote:
> WCN3990 comes with two chains - CH0 and CH1 - where each takes VDD
> regulator.  It seems VDD_CH1 is optional (Linux driver does not care
> about it), so document it to fix dtbs_check warnings like:
> 
>   sdm850-lenovo-yoga-c630.dtb: bluetooth: 'vddch1-supply' does not match any of the regexes: 'pinctrl-[0-9]+'
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Hi Luiz, I don't see you CCed here, should we take it directly 
to net-next?

> diff --git a/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml b/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
> index e3a51d66527c..2735c6a4f336 100644
> --- a/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
> +++ b/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
> @@ -52,6 +52,9 @@ properties:
>    vddch0-supply:
>      description: VDD_CH0 supply regulator handle
>  
> +  vddch1-supply:
> +    description: VDD_CH1 supply regulator handle
> +
>    vddaon-supply:
>      description: VDD_AON supply regulator handle
>  

