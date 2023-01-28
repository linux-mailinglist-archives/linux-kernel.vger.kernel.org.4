Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38F2867F6CE
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 10:45:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233672AbjA1Jp2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 04:45:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjA1JpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 04:45:25 -0500
X-Greylist: delayed 160 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 28 Jan 2023 01:45:24 PST
Received: from sender3-op-o18.zoho.com (sender3-op-o18.zoho.com [136.143.184.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CCCE196AA;
        Sat, 28 Jan 2023 01:45:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1674899111; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=Gs+k5/tw7f8uV+5W0s6cMoHUzx+wWf5YMOixzc7BmW7slefysudnccVtPwPLZrZ3Esq2n1/p/F93jPneglWwkSIgjK25xsTLyyIPphWXQXgJfNOEJyxVGdCu4rxeoi+igkTS1mXO7Kc4cJYREH7KpvCqr9W3Jt4yraWI0JgqFVk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1674899111; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=vei6BXjShZ5KCJ0rDNOmDnzdu6/DrX9IT0+aX3tLZYs=; 
        b=geOwJzSpwiUZHH3e47oX/LfdahpySEBN3kqxO899VnsDdZ3uvtcnN9NH3njKz/6mGa220WhruSk5HTAfrNkHmGJx4yVgCuQTJ6Hkcs5I9aF3K+vNGfV8PvrMFINHY9VzUTGs69bnMyrBHpCbOiALru4EJWv3D3tNu55EXunvTh4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=linux.beauty;
        spf=pass  smtp.mailfrom=me@linux.beauty;
        dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1674899111;
        s=zmail; d=linux.beauty; i=me@linux.beauty;
        h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=vei6BXjShZ5KCJ0rDNOmDnzdu6/DrX9IT0+aX3tLZYs=;
        b=jCqbR++nWA/hCSX+tj9ucIRv6e2kvDqHVCrV6K37SJ8PL+MGexBlsxocXf7r6Vse
        A4Z3C8uQAQgcRd4FlTDzDjRejM59Ixp8iQjzoUYHf4jiT9NdgAnsGL3D45rL7qEGOLf
        jaCDIMHSLGoPi+bUrvEVCdL4NGmrspULeaY423PU=
Received: from mail.zoho.com by mx.zohomail.com
        with SMTP id 1674899109228560.0594748370073; Sat, 28 Jan 2023 01:45:09 -0800 (PST)
Date:   Sat, 28 Jan 2023 17:45:09 +0800
From:   Li Chen <me@linux.beauty>
To:     "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>
Cc:     "li chen" <lchen@ambarella.com>,
        "michael turquette" <mturquette@baylibre.com>,
        "stephen boyd" <sboyd@kernel.org>,
        "rob herring" <robh+dt@kernel.org>,
        "krzysztof kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        "moderated list:arm/ambarella soc support" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:common clk framework" <linux-clk@vger.kernel.org>,
        "open list:open firmware and flattened device tree bindings" 
        <devicetree@vger.kernel.org>,
        "open list" <linux-kernel@vger.kernel.org>,
        "arnd bergmann" <arnd@arndb.de>
Message-ID: <185f7c4354e.afe15657487769.5617846622807925893@linux.beauty>
In-Reply-To: <1eff0411-430d-25d2-f1c6-41b22ff3938f@linaro.org>
References: <20230123073305.149940-1-lchen@ambarella.com>
 <20230123073305.149940-8-lchen@ambarella.com>
 <0c19efb4-3bca-f500-ca24-14b9d24369ef@linaro.org>
 <87y1prgdyu.wl-me@linux.beauty>
 <b26a52ff-6b8a-8a64-7189-346cd2b0d705@linaro.org>
 <87tu0ehl88.wl-me@linux.beauty>
 <ec9fc589-2612-3315-3550-83b68bead926@linaro.org>
 <87sffyhgvw.wl-me@linux.beauty>
 <f70def8e-b148-616f-a93e-c2a8fb85be03@linaro.org>
 <185f3b3a330.11c135c37327076.6300919877819761183@linux.beauty> <1eff0411-430d-25d2-f1c6-41b22ff3938f@linaro.org>
Subject: Re: [PATCH 07/15] dt-bindings: clock: Add Ambarella clock bindings
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLACK autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

 ---- On Fri, 27 Jan 2023 23:11:26 +0800  Krzysztof Kozlowski  wrote --- 
 > On 27/01/2023 15:48, Li Chen wrote:
 > >  > This is independent topic. SoC-specific compatibles are a requirement
 > >  > but it does not affect your device hierarchy.
 > >  
 > > Thanks, "requirement" makes things much more clear. So I will always use SoC-specific compatibles even
 > > if different Amarella SoCs may share the same reg offset and setting.
 > 
 > Just please read before sending any new versions:
 > https://elixir.bootlin.com/linux/v6.1-rc1/source/Documentation/devicetree/bindings/writing-bindings.rst

Gotcha.

Regards,
Li
