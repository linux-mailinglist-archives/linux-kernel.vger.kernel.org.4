Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA95265CE5F
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 09:32:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234037AbjADIc3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 03:32:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234002AbjADIcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 03:32:25 -0500
Received: from mail.3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A69A186CF;
        Wed,  4 Jan 2023 00:32:16 -0800 (PST)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id 9A467125C;
        Wed,  4 Jan 2023 09:32:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1672821133;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+CX2NGoUNf89QdEBh+WKylLZ5iHDV6P+xXO7uYU7z6A=;
        b=XaAGmCM3jt1/wQgfq4Z0ImuBrzqfwTYgEaukK/7+47wBQu6PuzODUHLNIK7JsRAwXVUEun
        aNyEl8a9Z7E5HQxPlNeo2yMu2xBUD34iuqnD6+r38HXxuLeG/bMCjp466sKTlMpxDQ1js3
        HMMM+BK4J5k6PJ+CZCsCppx61vsFpfyfr7j5dGSkDVhww0C3y8Uome4iW2W4Oss0TZMZpo
        qOVkhCwLJrPjB5vNRbVGBy5FgrBiax+eHWmOmUa/82KYd3NeJon9PeQgqMewjO+Z7qxP/u
        8Kq0HX8JZBiDjihmn12NUdppIv+9fVr2glSqWZW8HpLzayLI152BrhmkNUujLw==
From:   Michael Walle <michael@walle.cc>
To:     jszhang@kernel.org
Cc:     aou@eecs.berkeley.edu, conor@kernel.org,
        devicetree@vger.kernel.org, gregkh@linuxfoundation.org,
        ilpo.jarvinen@linux.intel.com, jirislaby@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-serial@vger.kernel.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com, robh+dt@kernel.org,
        Michael Walle <michael@walle.cc>
Subject: Re: [PATCH v2 6/9] riscv: dts: bouffalolab: add the bl808 SoC base device tree
Date:   Wed,  4 Jan 2023 09:32:04 +0100
Message-Id: <20230104083204.1865526-1-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221127132448.4034-7-jszhang@kernel.org>
References: <20221127132448.4034-7-jszhang@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam: Yes
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> +		uart0: serial@30002000 {

According to the reference manual of the bl808, this is uart3. Can we also
use that name here?

> +			compatible = "bouffalolab,bl808-uart";
> +			reg = <0x30002000 0x1000>;
> +			interrupts = <20 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&xtal>;

This is a shortcut and is likely to change in the future. The xtal
isn't really connected to the uart block, but instead there is a
clock mux and clock gate in between.

> +			status = "disabled";
> +		};

Thanks,
-michael
