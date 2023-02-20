Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C686269D45C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 20:56:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232083AbjBTT4O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 14:56:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231340AbjBTT4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 14:56:12 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88BA61DB9F;
        Mon, 20 Feb 2023 11:56:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=C8wxn5zU9hrSXYKgcJgtYOni4ihYgf3wye9qtJ+vVco=; b=dTDX2o8o0EWBaAUGfT1/WY9n4r
        xmJ0bBnheU6Imcy4h54K6XdCqll3yOJEbuOfZsVPYPcD/u0eD+NiRwbJUy0/DAfdvXIVnRmQ5AcTF
        HQ+Eg0c7TBYivVrcndaLLOATBj5tGFzuxRRcIxobkpFwpjs6NyUCC0UqAFWqHJnVlzokYhfu6gnTE
        rznLXbtw9ni4PqM2OLs2TrTTTqmcjrJ+P7I2FqnhUaw+kn3z+/+VQIyYpUCfu6ewvfSFp3CT+K1Q2
        tbtnYRK0cdwk3DRjUpBt6+sgBkPSlls4IGBImxgTH2jLlBYxNeLLTbCoXeRwJ6HMNTwrxb6zbqlca
        u2XVmnvg==;
Received: from [2601:1c2:980:9ec0::df2f]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pUCGY-005QkH-MB; Mon, 20 Feb 2023 19:56:02 +0000
Message-ID: <2f9aa86e-40e1-91f6-06b2-c79d62f7a136@infradead.org>
Date:   Mon, 20 Feb 2023 11:55:58 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH V3 2/2] nvmem: add generic driver for devices with MMIO
 access
Content-Language: en-US
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
References: <20230220174930.7440-1-zajec5@gmail.com>
 <20230220174930.7440-3-zajec5@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230220174930.7440-3-zajec5@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2/20/23 09:49, Rafał Miłecki wrote:
> +static int mmio_nvmem_write(void *context, unsigned int offset, void *val, size_t bytes)
> +{
> +	struct mmio_nvmem *priv = context;
> +
> +	switch (priv->io_width) {
> +	case 1:
> +	case 2:
> +	case 4:
> +		return -EOPNOTSUPP;

I'm just curious: (since read supports those cases)

what size writes are typically used here?
And what value for priv->io_width?



Thanks.

> +	default:
> +		memcpy_toio(priv->base + offset, val, bytes);
> +	}
> +
> +	return 0;
> +}

-- 
~Randy
