Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 744E16D7DB7
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 15:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238108AbjDEN3K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 09:29:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237448AbjDEN3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 09:29:07 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31A1530F3;
        Wed,  5 Apr 2023 06:29:06 -0700 (PDT)
Received: from localhost (unknown [213.194.153.37])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: rcn)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 59A356603187;
        Wed,  5 Apr 2023 14:29:04 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1680701344;
        bh=Wy5cD6MOK2ImneHYyj/DhkXP/o9TxK5UnpSHLobAN2I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dtqngf0E46w7Qa/GIKf5pYthfkaFg64RH+zZimJ7KFIlqUCO1DRnEsksXA2OhvLw/
         ZbnWEPugdWSHmOsRYvSMCre4qOUh8m0KtNIziEQ/LUDKcqB8FU+FjfnHAg5kNiEPYF
         BbpTkDxvQy2HH4ZyXQURcFQnTZwakmsHLFdKcQykWSwb7/GP61/7Aux6Ecr/66O9ij
         1MCWYzSO+sGdkUwBfDrH1qI8jAid9d3xR8xbat//sNRtegn3KCBWI4UOC+pJuNSWaf
         lMOSgwJjLul9J2lDyD/0TWbj3bVD7hcdfdkvRHxwgzirmBjrG6/oxxs47wri2dzfl7
         vxhofdzmUCy5g==
Date:   Wed, 5 Apr 2023 15:29:00 +0200
From:   Ricardo =?utf-8?Q?Ca=C3=B1uelo?= <ricardo.canuelo@collabora.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 1/3] ARM: dts: meson: Fix the UART compatible strings
Message-ID: <20230405132900.ci35xji3xbb3igar@rcn-XPS-13-9305>
Mail-Followup-To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20211227180026.4068352-1-martin.blumenstingl@googlemail.com>
 <20211227180026.4068352-2-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211227180026.4068352-2-martin.blumenstingl@googlemail.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

On lun 27-12-2021 19:00:24, Martin Blumenstingl wrote:
> The dt-bindings for the UART controller only allow the following values
> for Meson6 SoCs:
> - "amlogic,meson6-uart", "amlogic,meson-ao-uart"
> - "amlogic,meson6-uart"
> 
> Use the correct fallback compatible string "amlogic,meson-ao-uart" for
> AO UART. Drop the "amlogic,meson-uart" compatible string from the EE
> domain UART controllers.

KernelCI detected that this patch introduced a regression in
stable-rc/linux-4.14.y on a meson8b-odroidc1.
After this patch was applied the tests running on this platform don't
show any serial output.

This doesn't happen in other stable branches nor in mainline, but 4.14
hasn't still reached EOL and it'd be good to find a fix.

Here's the bisection report:
https://groups.io/g/kernelci-results/message/40147

KernelCI info:
https://linux.kernelci.org/test/case/id/64234f7761021a30b262f776/

Test log:
https://storage.kernelci.org/stable-rc/linux-4.14.y/v4.14.311-43-g88e481d604e9/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-meson8b-odroidc1.html

Thanks,
Ricardo

#regzbot introduced: 5225e1b87432dcf0d0fc3440824b91d04c1d6cc1
#regzbot title: no serial output in KernelCI tests on meson8b-odroidc1
for stable-4.14
