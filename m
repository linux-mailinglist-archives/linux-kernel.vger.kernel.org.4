Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D161F62FF62
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 22:32:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230074AbiKRVb7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 16:31:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiKRVb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 16:31:58 -0500
X-Greylist: delayed 9630 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 18 Nov 2022 13:31:57 PST
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 508D877222;
        Fri, 18 Nov 2022 13:31:57 -0800 (PST)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id AB6681382;
        Fri, 18 Nov 2022 22:31:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1668807115;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jhsoQZGuusQB+cmhOr0OjTamtUUcvXLkhCvJFGQv/dM=;
        b=dyqmJDrhlD49WDtt67kx3e41wuqADtomYJdL3P9JWqaY9HodYZSEwm66ELysqQdEuRFCGm
        d4gR1HQJnixVwcD8QqsnKVeQz4wJ1usztknklJQEZiFpqBbBOLrtVlhoB/SOhHIdu4KQex
        /dhB5zAMYT2ch4k5OQWd261mx0G15jDeUkm0hWn6hZ0DFgZNwNS19KS9VuztfAw6hIrHf+
        NocsD8ySWtxr72mPW+uWo5Y4KHVihNz66+5MD+z+3lwI40i5guJCIoKng3ni67NSQeXdG5
        ppwKu3g5rV8hu9RKpiINMWfGsseo3Hy+TO6oCRTGHcWlxMQ8yvOwOoij2W1OIg==
MIME-Version: 1.0
Date:   Fri, 18 Nov 2022 22:31:55 +0100
From:   Michael Walle <michael@walle.cc>
To:     Jonathan Corbet <corbet@lwn.net>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 02/18] of: base: add
 of_parse_phandle_with_optional_args()
In-Reply-To: <20221118185118.1190044-3-michael@walle.cc>
References: <20221118185118.1190044-1-michael@walle.cc>
 <20221118185118.1190044-3-michael@walle.cc>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <8b976cf546bad3aa159a6f05cd3c15d1@walle.cc>
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

Am 2022-11-18 19:51, schrieb Michael Walle:
> Add a new variant of the of_parse_phandle_with_args() which treats the
> cells name as optional. If it's missing, it is assumed that the phandle
> has no arguments.
> 
> Up until now, a nvmem node didn't have any arguments, so all the device
> trees haven't any '#*-cells' property. But there is a need for an
> additional argument for the phandle, for which we need a '#*-cells'
> property. Therefore, we need to support nvmem nodes with and without
> this property.

I've just noticed that this isn't enough. We also need to fix the 
parsing
in drivers/of/property.c, otherwise spurious device links will be 
created
because the phandle argument is treated as a phandle itself.

-michael

