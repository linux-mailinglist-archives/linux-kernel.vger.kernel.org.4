Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B98AC6AC18B
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 14:39:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230411AbjCFNjp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 08:39:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbjCFNjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 08:39:41 -0500
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A7A72F79E;
        Mon,  6 Mar 2023 05:39:38 -0800 (PST)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id 0624661;
        Mon,  6 Mar 2023 14:39:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1678109977;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CuGi+nnvASLj3QCZh43qyWjqOQVQw8vWY8x1yJbFcEE=;
        b=vbQpb6MYYUC2zwMF6UJhU0C+TvXoJGh55Udb8rNp+jtwAmR1BEyIOTjm8XQN4vcq49ZEGZ
        8OnzPocrO+sZvdmV/29UNtJB55XjyPCvaPqLW81dW8BURcOSel9KrWka7tM9/sY2oPXNLK
        uR50I0rKDtgd8weu2B7UBJNMwQ8RAKRokKE2kyMYe1XFRRIdX2eN94Gtzs4GmhdEauKrMl
        g8D2BGztDhSifG4UDuhtettWUUUD+6pXc5oKbq38gF8kYhVu/ZSB57QLxi3yOBcY9sIS4z
        OiKgTXGXtbU/udklN4zwTl5LtgqbZjkI585vmwpqxSUVo30/7Tf7LKL6aZpOGw==
MIME-Version: 1.0
Date:   Mon, 06 Mar 2023 14:39:36 +0100
From:   Michael Walle <michael@walle.cc>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Robert Marko <robert.marko@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        rafal@milecki.pl
Subject: Re: [PATCH 0/8] nvmem: Let layout drivers be modules
In-Reply-To: <20230306143528.7407fda5@xps-13>
References: <20230301152239.531194-1-miquel.raynal@bootlin.com>
 <ee7923a8b5fa8358e6805d20df7d8049@walle.cc> <20230306143528.7407fda5@xps-13>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <301f9723dca9645e1b5c71eac6221f93@walle.cc>
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

Hi Miquel,

Am 2023-03-06 14:35, schrieb Miquel Raynal:
> michael@walle.cc wrote on Mon, 06 Mar 2023 14:01:34 +0100:
> 
>> > Miquel Raynal (8):
>> >   of: Fix modalias string generation
>> >   of: Change of_device_get_modalias() main argument
>> >   of: Create an of_device_request_module() receiving an OF node
>> >   nvmem: core: Fix error path ordering
>> >   nvmem: core: Handle the absence of expected layouts
>> >   nvmem: core: Request layout modules loading
>> >   nvmem: layouts: sl28vpd: Convert layout driver into a module
>> >   nvmem: layouts: onie-tlv: Convert layout driver into a module
>> 
>> With the fixes series [1] applied:
> 
> Thanks for the series! Looks good to me. I believe both series can live
> in separate tress, any reason why we would like to avoid this? I am 
> keen
> to apply [1] into the mtd tree rather soon.

I'm fine with that.

-michael

[1] https://lore.kernel.org/r/20230306125805.678668-1-michael@walle.cc/
