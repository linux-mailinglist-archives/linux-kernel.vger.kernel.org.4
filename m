Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4968D60FCC0
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 18:14:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236488AbiJ0QOG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 12:14:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234241AbiJ0QOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 12:14:04 -0400
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C50518DD55;
        Thu, 27 Oct 2022 09:14:04 -0700 (PDT)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id 4D8531D6F;
        Thu, 27 Oct 2022 18:14:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1666887242;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UiHt6AVew/1wtXAOhAxrgy0TgFZJ92deBlw2WsMD19E=;
        b=xJrjL61WojU9fcAAFKas37v5lkt7C1TUbJcsOhEsPI9S381zT7/70UL3ocV92Sq4N1Cidz
        JdWBCf94Uet4QijeuZM6lOmGssx5FK8sdPom+5kht1V58kg75aKjIwcgzwV4yIyaZ2w1qT
        5JVhCDvYF3zBR+mBXwakYeDJesP4SasbhBLTab9SKID9LQyVAIiaIbGEHtJLNWlOWN+nDv
        yXcr4cDvOoygl0F97oaNVp7D00B+2h3zrLAh607OR0MNgcWThj0cW2pAgQ2kPZ8TPlCYc0
        vUz/3P3rrsm10/qyK/2QCtV0hu7hNTKesC3UR3G2H6X4sr2zEaqEyVrlvCEXKA==
MIME-Version: 1.0
Date:   Thu, 27 Oct 2022 18:14:02 +0200
From:   Michael Walle <michael@walle.cc>
To:     Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Vladimir Oltean <vladimir.oltean@nxp.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Heiko Thiery <heiko.thiery@gmail.com>
Subject: Re: [PATCH] Revert "arm64: dts: ls1028a: sl28: use ocelot-8021q
 tagging by default"
In-Reply-To: <20221027113248.420216-1-michael@walle.cc>
References: <20221027113248.420216-1-michael@walle.cc>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <3938a228c0c136f568b7b0a7d92ff15c@walle.cc>
X-Sender: michael@walle.cc
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2022-10-27 13:32, schrieb Michael Walle:
> This reverts commit be0b178c50c37a666d54f435da71cf9f008362a0.
> 
> This commit will break networking on the sl28 boards if the tagger is
> not compiled into the kernel. If a non-default tagger is used, the
> kernel doesn't do a request_module(). Fixing that is also not that
> trivial because the tagger modules are loaded by ids, not by name.
> Thus for now, just revert to the default tagger until that is fixed.
> 
> Fixes: be0b178c50c3 ("arm64: dts: ls1028a: sl28: use ocelot-8021q
> tagging by default")
> Reported-by: Heiko Thiery <heiko.thiery@gmail.com>
> Signed-off-by: Michael Walle <michael@walle.cc>

Please disregard this patch. The proper fix is here:
https://lore.kernel.org/netdev/20221027145439.3086017-1-vladimir.oltean@nxp.com/

-michael
