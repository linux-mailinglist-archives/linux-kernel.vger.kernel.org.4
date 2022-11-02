Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6D2F61700B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 22:47:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231300AbiKBVrG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 17:47:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbiKBVrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 17:47:04 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82B86EE18;
        Wed,  2 Nov 2022 14:47:01 -0700 (PDT)
Received: from notapiano (unknown [IPv6:2600:4041:5b1a:cd00:524d:e95d:1a9c:492a])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 8690B66017D3;
        Wed,  2 Nov 2022 21:46:58 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1667425620;
        bh=wr7XvMBx78CPPZbFbCo5cFsqN667CuKHD66q8hrxbsU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Chs0dNoDzTTzVfBcJOaxY9re2NI0KcgqFwFCYcBI2SiP7ViF9AwVnzmuBZJ+PTFha
         733pUwWjrPpCGTfB33H0bLV6UmKAAedHz2UKfEkrUXUZvV35TCDhfOGT03jAoN/rKB
         1A8TEcUoKwUSzyfbQi0Mf4w43y95HOoBTc2VwtNpyRASXdGxYy35IXY9xRoRcn2v6I
         vBEhVhPlUg08iQexwCyokTyU7YfPgPI7zF1t/VxHgK+D2dEl9ma8aVxB6y06A6oBW4
         TqkApFf5nIlPOXJa9ejtMrYuKcRHWeK8QQw8mxGpp936vMi8VxHiKrczXPb2rzjsSN
         dYX9bWcsjcdPg==
Date:   Wed, 2 Nov 2022 17:46:54 -0400
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
Message-ID: <20221102214654.axyptitp5kpq3wcq@notapiano>
References: <20221101220304.65715-1-nfraprado@collabora.com>
 <20221102171343.3ajwlkxhp7s7r36k@notapiano>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221102171343.3ajwlkxhp7s7r36k@notapiano>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 02, 2022 at 01:13:48PM -0400, Nícolas F. R. A. Prado wrote:
> On Tue, Nov 01, 2022 at 06:03:03PM -0400, Nícolas F. R. A. Prado wrote:
> > Currently running dtbs_check compiles and runs the DT checker on all
> > enabled devicetrees against all dt-bindings. This can take a long time,
> > and is an unnecessary burden when just validating a new devicetree or
> > changes in an existing one, with the dt-bindings unchanged.
> > 
> > Similarly to DT_SCHEMA_FILES for dt_binding_check, add a DTB_FILES
> > variable that can be passed to the dtbs_check make command to restrict
> > which devicetrees are validated.
> > 
> > Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> > 
> > ---
> > Usage example:
> > make dtbs_check DTB_FILES='arch/arm64/boot/dts/mediatek/mt8192-asurada-spherion-r0.dtb arch/arm64/boot/dts/mediatek/mt8192-asurada-hayato-r1.dtb'
> 
> Hi,
> 
> I have just learned that it is already possible to achieve the same thing by
> passing the dtbs explicitly to make and enabling the DTBS_CHECK flag like so:
> 
> make CHECK_DTBS=y mediatek/mt8192-asurada-spherion-r0.dtb
> 
> This flag isn't documented anywhere outside the Makefile however. So I'll send a
> patch documenting it shortly, and this commit can be ignored.

Patch: https://lore.kernel.org/all/20221102214300.309347-1-nfraprado@collabora.com

Thanks,
Nícolas
