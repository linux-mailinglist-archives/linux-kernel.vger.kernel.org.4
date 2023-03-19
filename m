Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08C2A6C0518
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 22:00:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbjCSVAh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 17:00:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbjCSVAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 17:00:34 -0400
Received: from sender4-op-o10.zoho.com (sender4-op-o10.zoho.com [136.143.188.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E96BE6A72;
        Sun, 19 Mar 2023 14:00:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1679259590; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=naJvgxfc7mo6cG95E8IVzExgl38hmPTl3Dg8QD7cpxvy/GOj++FhCIUTQpJvoK7WF+tv7MhFrDCtJFzfRffDGNK3PjzuGjNjYHPNx7BtPc+c1F/zF4QoGtBP0qVVJ9//7BR5mL1byBcu3M9Lly52bmY2Bc06wL5C3QD8w65UV+k=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1679259590; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=jwAO0z9En6mLxOF3Ju75lHjUXBw+TZ9xk9DabZ0leYY=; 
        b=mN3SK0xIJuOmOEaGxG6TGO/YhSRERPCOXaeAqYuQtPnACHI6CxvJ+2vttCI804IbvYFx2wFlgLGuEbk417ZC7QGEh4/jHEWGW7bqGWyTHZYWEb2e/qbqLAne8fn62OOyzPPn919pAyCcYU3q/YA/oNAYg36LGv6WkfN/vrt5s4I=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=arinc9.com;
        spf=pass  smtp.mailfrom=arinc.unal@arinc9.com;
        dmarc=pass header.from=<arinc.unal@arinc9.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1679259590;
        s=zmail; d=arinc9.com; i=arinc.unal@arinc9.com;
        h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=jwAO0z9En6mLxOF3Ju75lHjUXBw+TZ9xk9DabZ0leYY=;
        b=S1gNH/qjIJ3Rn11Tb0cC4wAdVehaPSBKBzmHCyDXSzUHUXSqRG50yIG4gFcoL43w
        QDMy2Q6jQSpUtVynindMK846Id2HgMVmxybXSmKJiNLpU0rl3IF85VclIE3tsG7de+O
        8Wn9cJa7DAZXqv/FOsuJGjyZrj54OrDMI5pVFj7M=
Received: from [10.10.10.3] (149.91.1.15 [149.91.1.15]) by mx.zohomail.com
        with SMTPS id 1679259589012624.8771487940448; Sun, 19 Mar 2023 13:59:49 -0700 (PDT)
Message-ID: <e9e6ad87-2db5-9767-ff39-64a302b06185@arinc9.com>
Date:   Sun, 19 Mar 2023 23:59:40 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3 00/21] pinctrl: ralink: fix ABI, improve driver, move
 to mediatek, improve dt-bindings
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        William Dean <williamsukatube@gmail.com>,
        Sean Wang <sean.wang@kernel.org>,
        Andy Teng <andy.teng@mediatek.com>,
        Del Regno <angelogioacchino.delregno@collabora.com>,
        Daniel Golle <daniel@makrotopia.org>,
        Hui Liu <hui.liu@mediatek.com>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        =?UTF-8?Q?Bernhard_Rosenkr=c3=a4nzer?= <bero@baylibre.com>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Daniel Santos <daniel.santos@pobox.com>,
        Luiz Angelo Daros de Luca <luizluca@gmail.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        Landen Chao <Landen.Chao@mediatek.com>,
        DENG Qingfang <dqfext@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>, erkin.bozoglu@xeront.com,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org
References: <20230317213011.13656-1-arinc.unal@arinc9.com>
 <CACRpkdbWmtBtpkW2=DUX2v6CR7aJz52R6y5mJ=W+VDena+Fzng@mail.gmail.com>
Content-Language: en-US
From:   =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <CACRpkdbWmtBtpkW2=DUX2v6CR7aJz52R6y5mJ=W+VDena+Fzng@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.03.2023 23:49, Linus Walleij wrote:
> On Fri, Mar 17, 2023 at 10:30 PM <arinc9.unal@gmail.com> wrote:
> 
>> This is an ambitious effort I've been wanting to do for months.
> 
> I don't see any major missing ACKs so I just applied the patches, we
> can fix any remaining issues in-tree.
> 
> Good work!

Music to my ears. It was pretty final so I don't expect more issues.

Thanks for applying them.

Cheers.
Arınç
