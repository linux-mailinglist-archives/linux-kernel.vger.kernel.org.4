Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E25EA6417B8
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 17:20:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbiLCQUf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Dec 2022 11:20:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiLCQUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Dec 2022 11:20:34 -0500
Received: from smtp.domeneshop.no (smtp.domeneshop.no [IPv6:2a01:5b40:0:3005::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7874BB865
        for <linux-kernel@vger.kernel.org>; Sat,  3 Dec 2022 08:20:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tronnes.org
        ; s=ds202112; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:Cc:
        References:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID
        :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
        Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe
        :List-Post:List-Owner:List-Archive;
        bh=enw8VD3zPnXl7/R2ZunjM3J38aIylzUIoo4Sqggqufk=; b=KB938maJsa5aZfqs3S5Mw9MLTU
        m86WTmZFS//+wcmd1cs3nr/a85g9RlJr4trgcx1KDdMaMZ8eorjDNhkMmX6EhuBm0BXKz1geGAKG/
        9SlhQkU6bzMVbrkO6PoEjLajJGkUjkqzDFZxjpWNNsqxcA2iAWYYOBk1MykZOEQqaNRp6HP0mkKHU
        Ui0vzmuBwV8MiFXZXo4fs3YxXac6vDYCvOvERhPYCd74oHgC17llYO7P+rxSIfYZS3MhMsVNf8ncn
        Tm5gIKJmKTDoXw1V07Q8K3LUr6aPBlQF7dBpq327YYa5AwW4mCIwQVY8ybGFRfz4Y9zBOTHEIFtjv
        4tKlF+Tg==;
Received: from [2a01:799:95e:1700:6395:ccbd:d000:d42b] (port=57101)
        by smtp.domeneshop.no with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <noralf@tronnes.org>)
        id 1p1VFf-0003h8-BV; Sat, 03 Dec 2022 17:20:31 +0100
Message-ID: <9d0815fb-141d-91dc-2ca3-a827bed62b3e@tronnes.org>
Date:   Sat, 3 Dec 2022 17:20:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v2 2/3] drm/tiny: panel-mipi-dbi: Read I/O supply from DT
To:     =?UTF-8?Q?Otto_Pfl=c3=bcger?= <otto.pflueger@abscue.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221201160245.2093816-1-otto.pflueger@abscue.de>
 <20221201160245.2093816-3-otto.pflueger@abscue.de>
Cc:     =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
From:   =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
In-Reply-To: <20221201160245.2093816-3-otto.pflueger@abscue.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Den 01.12.2022 17.02, skrev Otto Pflüger:
> To support platforms with a separate I/O voltage supply, set the new
> io_regulator property along with the regulator property of the DBI
> device. Read the I/O supply from a new "io-supply" device tree
> property.
> 
> Signed-off-by: Otto Pflüger <otto.pflueger@abscue.de>
> ---

Reviewed-by: Noralf Trønnes <noralf@tronnes.org>
