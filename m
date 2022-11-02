Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80168616A49
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 18:14:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231219AbiKBRN6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 13:13:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231158AbiKBRNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 13:13:51 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A36A01D0C3;
        Wed,  2 Nov 2022 10:13:50 -0700 (PDT)
Received: from notapiano (unknown [IPv6:2600:4041:5b1a:cd00:524d:e95d:1a9c:492a])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 7AD0066028C5;
        Wed,  2 Nov 2022 17:13:47 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1667409228;
        bh=ji3U3ak5nD4n2XqIAQUOdY5r4XOdv7SBDqXsn1vBOFw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Zf4qXkpxiJryyHIFvuayAUpf1EuMA5gcze3C5zcESUQ6vpKd3JyYDTPb1XEX30Wk4
         KZ602yOuRgovIHUP0WKhlBIm2sNL5RjCrstCvglykMSu5sPoq1XIj81n2In596xdKs
         XFuq7m28o22PWxMzQpyVWJunDOBC65ReJDfTHUsG6XC5d5beOmE/tjoOl57X/H0Eqp
         nl2NuVcqzShS9+SUDsAVcLS9j9zuNBFItKupOW17AIqlo7AZvJTIejqjN9BasEludZ
         IebB2Ycy3pq1AEQYAojmIkKLxxadejxmZIc2S3Qldti/p0V17zaAkhmgKGeo5swe2/
         TRyF4vZIc8FSA==
Date:   Wed, 2 Nov 2022 13:13:43 -0400
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     Rob Herring <robh@kernel.org>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, kernel@collabora.com,
        Masahiro Yamada <masahiroy@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] kbuild: Add DTB_FILES variable for dtbs_check
Message-ID: <20221102171343.3ajwlkxhp7s7r36k@notapiano>
References: <20221101220304.65715-1-nfraprado@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221101220304.65715-1-nfraprado@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 01, 2022 at 06:03:03PM -0400, Nícolas F. R. A. Prado wrote:
> Currently running dtbs_check compiles and runs the DT checker on all
> enabled devicetrees against all dt-bindings. This can take a long time,
> and is an unnecessary burden when just validating a new devicetree or
> changes in an existing one, with the dt-bindings unchanged.
> 
> Similarly to DT_SCHEMA_FILES for dt_binding_check, add a DTB_FILES
> variable that can be passed to the dtbs_check make command to restrict
> which devicetrees are validated.
> 
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> 
> ---
> Usage example:
> make dtbs_check DTB_FILES='arch/arm64/boot/dts/mediatek/mt8192-asurada-spherion-r0.dtb arch/arm64/boot/dts/mediatek/mt8192-asurada-hayato-r1.dtb'

Hi,

I have just learned that it is already possible to achieve the same thing by
passing the dtbs explicitly to make and enabling the DTBS_CHECK flag like so:

make CHECK_DTBS=y mediatek/mt8192-asurada-spherion-r0.dtb

This flag isn't documented anywhere outside the Makefile however. So I'll send a
patch documenting it shortly, and this commit can be ignored.

Thanks,
Nícolas
