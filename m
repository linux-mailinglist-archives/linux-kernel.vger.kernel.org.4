Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B27A6A5160
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 03:43:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbjB1Cnn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 21:43:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjB1Cnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 21:43:42 -0500
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4D705262;
        Mon, 27 Feb 2023 18:43:39 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id B2BA541A42;
        Tue, 28 Feb 2023 02:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
        t=1677552217; bh=NuKc2S3qmn19MvrLhz9ClzFdWxxviwYmA9lJ0wCcJD4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=CJYespKF0HwDDt3xb5H7cX1sUtHgGCnnJ69XiKoI+lgTJGY82EUyo25qPJOgD/2je
         7iHaRB6G6Vl2DL+syENSJPMHbJIWazIy5q0fzLLuMaW9gKnmA6IchflMsP6nMjBkjl
         5l1W7xOJT9H5+s9vTdDFPcycjcAo5M8nB1IoGRIST/MUzT0K79wo0S4YhmpQWhXD85
         cPjP0qy21cx+pYYKV41Oa4DzK6nqscUFRTLGAvNQ6JA0pfNAxo/qN1/OczlruLUAOe
         TzSOnn1fZ270pSzwymQ+h/FXy3YDAoyavWZfQoKrzrgrya8A7c6FklAG+jQZrEVYBm
         WI0TVF1m1YnLw==
Message-ID: <01ce15ee-ad64-6d0d-3b72-9d11eac8d40e@marcan.st>
Date:   Tue, 28 Feb 2023 11:43:31 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH RFC 0/4] Driver for Apple Z2 touchscreens.
Content-Language: en-US
To:     fnkl.kernel@gmail.com, Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        - <asahi@lists.linux.dev>, Henrik Rydberg <rydberg@bitmath.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230223-z2-for-ml-v1-0-028f2b85dc15@gmail.com>
From:   Hector Martin <marcan@marcan.st>
In-Reply-To: <20230223-z2-for-ml-v1-0-028f2b85dc15@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/02/2023 19.20, Sasha Finkelstein via B4 Relay wrote:
> Hi.
> 
> This series adds support for Apple touchscreens using the Z2 protocol.
> Those are used as the primary touchscreen on mobile Apple devices, and for the
> touchbar on laptops using the M-series chips. (T1/T2 laptops have a coprocessor
> in charge of speaking Z2 to the touchbar).
> 
> Sending this as a RFC for now, since this series requires the SPI controller
> support which is not upstream yet:
> https://lore.kernel.org/all/20211212034726.26306-1-marcan@marcan.st/
> 
> Signed-off-by: Sasha Finkelstein <fnkl.kernel@gmail.com>

Just FWIW, I'm happy to see this get RFCed early (early review is always
good), but I don't think we should submit it until it actually gets some
testing in real-world scenarios. That is naturally blocked on having a
MIPI display driver, since a touchscreen above a dead screen isn't
terribly useful. Otherwise, we might realize that we have some
binding/API issues we missed that are harder to fix after the fact.

So let's hold off on submission proper until we have the screen working
and some basic userspace tooling to go with all this shipping downstream
and it gets some real-world testing. Hopefully by then I'll have sent
out the SPI controller driver too :)

- Hector
