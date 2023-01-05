Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3169F65E512
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 06:26:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbjAEF0T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 00:26:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230220AbjAEF0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 00:26:11 -0500
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8CDE48CCB;
        Wed,  4 Jan 2023 21:26:08 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id D62C9425D6;
        Thu,  5 Jan 2023 05:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
        t=1672895977; bh=DBNkKPLiFmCsOai0eLz6rBhEs0qbT7bO/x7ibCYBYPE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=zHn7iLgCqBMr20WdN/Kx6nNWPZv43tDvT8UFeTKrXHxNbbwuBdPcs8Q0kGi+lYfQX
         6y5W6359/O4ox/TS0pG++cSHZH7aynh6x/apobgwKVVqZU7/fIhOlG4j0iMa0hGD1r
         KB9e2NttfGMjNr0Kh/dWk2LUtXXDyZvdi7ZuqTgFnUC5H3lp5S9m5L1KxyKjvnmDW8
         LOaBMLZen50hgUwTfYgxs+moZKwflHdSYpJbpWOFt93L3JUXAmiRVidBsmJAGSHRuW
         Vbzo0d+IM+TiJju0npZIWZbYYDDR33aHI0q8rUa1q3jiDfHppJwjBwrmXXIdVaJgZk
         mWqi2pWEmY2tg==
Message-ID: <fd66fa48-8810-5b8b-c330-8456bdb9de9e@marcan.st>
Date:   Thu, 5 Jan 2023 14:19:32 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 7/7] iommu: dart: Add t8110 DART support
Content-Language: en-US
To:     Sven Peter <sven@svenpeter.dev>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Janne Grunau <j@jannau.net>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, iommu@lists.linux.dev,
        asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20230104110013.24738-1-marcan@marcan.st>
 <20230104110013.24738-8-marcan@marcan.st>
 <bebc741d-bcbe-4449-9379-be70fd65b0f0@app.fastmail.com>
From:   Hector Martin <marcan@marcan.st>
In-Reply-To: <bebc741d-bcbe-4449-9379-be70fd65b0f0@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/01/04 22:50, Sven Peter wrote:
> Do you have any more details on this registers? For the 8103 DART
> we called it _CONFIG but I assume for the t8110 DART it can
> actually lock different parts of the HW instead of just a global lock?

This is based on R's reverse engineering here:

https://github.com/AsahiLinux/m1n1/blob/main/proxyclient/m1n1/hw/dart8110.py#L87

I don't think they ever fully nailed down exactly what the lock bit
behavior is, though.

- Hector
