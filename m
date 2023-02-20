Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0752B69CED0
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 15:05:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232821AbjBTOFj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 09:05:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232699AbjBTOFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 09:05:38 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C774683F1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 06:05:36 -0800 (PST)
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 0F20F3F71F
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 14:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1676901934;
        bh=dzSoi4QFKSwQF6afiZkQC9N3RdyPdUsM3TO6tUG2yLg=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=B+1Ww+XNQZ3jA8r7iSayICdqqJlzhR4YnaS2mbFtmG/xa3glZbSCBUVjjduq3knx6
         0ud//1CeSpYyQ3SjwSxp+0iPJNKqRMK3ASoS+SzAArogEclnfgIb6/9oQTP6Qn3HDE
         GCBR1VNvmsDn+roaBXQRInA1Oe1xSrqf3fA8eBSlbTwApXlCALIgf8wpV1P1y7x5JC
         dz6dHNJyenvTopk0e2UaWjSERt5lp2TfiF4I3h9kD5sxGBO0dxBjM5CScAgKRIQfpn
         brWXRPt25ev6fp1GSQPIuk88hJ0OF7nJaYsKpgvGOLjhWO6LUij2RMi/LvU+vublxW
         HWdViOLQUqmQQ==
Received: by mail-qk1-f197.google.com with SMTP id f11-20020a05620a280b00b006e08208eb31so105251qkp.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 06:05:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dzSoi4QFKSwQF6afiZkQC9N3RdyPdUsM3TO6tUG2yLg=;
        b=7QTnL7zJ4n36pOGDBjZxmLlT1dn7GW87kVT5a7CasokMvAIF+jlEKhh0Ija8WPPZms
         yFvUYc8EqdacqgMzJC7VJ2+zoFDMxgiXypEq0ucJovOF1Bhn5GmeqDm0T555MHHd6cab
         1ajy/iqXehRioesmT+qCv8PSKUqBpoe+7KTRAJ9FGvOzzkbPCSDvubgGyroGiHYSO+Ea
         M23+5V+SZT9X+pBS3Va9DGFVPJUC5XGJsZLG1x+HcFm2QcqjXvyd749b9rBJ08FzA2fH
         iI627h/HN/hWRbeVieUpzudtjFrWJdeXGHpSnva5PhbubGPXCPlRWWkwgjWFij9JLPek
         JkEA==
X-Gm-Message-State: AO0yUKVwMfJcXOKRFPfqCTZomYycxZ0XuAWsUhPUma2/NRP61o9/IPTs
        bB1xxHxwDPQHIO2J0fIYjZSG9IJRo2u8cd/cp+uqS5hoa/Llv/cnZxtYJ5sx5R/A0pltB50J7iK
        QFCl3Zzro0bpm5S+6rvgjQ7Huq4Em0eITXG2P2fF9BHAVZ/+CIOitxtw1KQ==
X-Received: by 2002:a0c:d990:0:b0:570:fc87:4f2c with SMTP id y16-20020a0cd990000000b00570fc874f2cmr292631qvj.83.1676901932971;
        Mon, 20 Feb 2023 06:05:32 -0800 (PST)
X-Google-Smtp-Source: AK7set9+5IcIjvQKZqoR1+axj5VeZiHUAcZlLKVa9weRBzGDTEUyWaKv9QTowi0nMLky06a8W3KysbXpK45taPqjNlI=
X-Received: by 2002:a0c:d990:0:b0:570:fc87:4f2c with SMTP id
 y16-20020a0cd990000000b00570fc874f2cmr292626qvj.83.1676901932733; Mon, 20 Feb
 2023 06:05:32 -0800 (PST)
MIME-Version: 1.0
References: <20230118061701.30047-1-yanhong.wang@starfivetech.com> <20230118061701.30047-8-yanhong.wang@starfivetech.com>
In-Reply-To: <20230118061701.30047-8-yanhong.wang@starfivetech.com>
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
Date:   Mon, 20 Feb 2023 15:05:17 +0100
Message-ID: <CAJM55Z_a4SN9jYFZqnM9nrL2a-nDzLSGLbXdsTYuf0OrD-c0Fg@mail.gmail.com>
Subject: Re: [PATCH v4 7/7] riscv: dts: starfive: visionfive-v2: Enable gmac
 device tree node
To:     Yanhong Wang <yanhong.wang@starfivetech.com>
Cc:     linux-riscv@lists.infradead.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Richard Cochran <richardcochran@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Peter Geis <pgwipeout@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Jan 2023 at 07:19, Yanhong Wang
<yanhong.wang@starfivetech.com> wrote:
>
> Update gmac device tree node status to okay.
>
> Signed-off-by: Yanhong Wang <yanhong.wang@starfivetech.com>
> ---
>  .../dts/starfive/jh7110-starfive-visionfive-v2.dts     | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-v2.dts b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-v2.dts
> index c8946cf3a268..b22363d5f9dc 100644
> --- a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-v2.dts
> +++ b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-v2.dts
> @@ -15,6 +15,8 @@
>
>         aliases {
>                 serial0 = &uart0;
> +               ethernet0 = &gmac0;
> +               ethernet1 = &gmac1;

Hi Yanhong,

Please keep these sorted alphabetically so it's obvious where the next
additions go.

/Emil
>         };
>
>         chosen {
> @@ -114,3 +116,11 @@
>         pinctrl-0 = <&uart0_pins>;
>         status = "okay";
>  };
> +
> +&gmac0 {
> +       status = "okay";
> +};
> +
> +&gmac1 {
> +       status = "okay";
> +};
> --
> 2.17.1
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
