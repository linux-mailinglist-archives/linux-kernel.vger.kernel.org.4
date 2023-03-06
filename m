Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72C8F6AC21B
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 15:03:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbjCFODG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 09:03:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjCFODE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 09:03:04 -0500
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8BCD10A94;
        Mon,  6 Mar 2023 06:03:03 -0800 (PST)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id 411A961;
        Mon,  6 Mar 2023 15:03:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1678111381;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zfypnypvacWffqwSaL9BcGlfaMYQWouJSD3qCS/ye+g=;
        b=my6+005DUHCqAdk6C4m8LwLNWsjb8iEXaqCun1z6ponQo0x+FchETD9mxTtcTm3h5fpo3v
        3NidJ4+rRAjEaIJ6MH2CQIA8oH8Smu4knmtXe/560HPJSXcjbERg8sln2TkxZem1abCAcl
        LWUADN7unxdeWshB2w/hywIzGiPYOVf2iewNx7Wtsqh8Bykghle2/RkJ93Po7lPgJ5x6+6
        yjXAmyFs65sOVSiPS+NK2a2UCRHT6Bifd/Dusp1lUvCjCUCClCmPx5Km6eIQMnEq3ftjKx
        IUq7j2XCaLqJmGVAzSDC0BLXjEzqu0wJxs8uXCUbQNGnesiPpTGXTn+R2hGdKg==
MIME-Version: 1.0
Date:   Mon, 06 Mar 2023 15:03:01 +0100
From:   Michael Walle <michael@walle.cc>
To:     =?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Robert Marko <robert.marko@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 0/8] nvmem: Let layout drivers be modules
In-Reply-To: <73a04afaf658292c05ef27117c60b21d@milecki.pl>
References: <20230301152239.531194-1-miquel.raynal@bootlin.com>
 <ee7923a8b5fa8358e6805d20df7d8049@walle.cc> <20230306143528.7407fda5@xps-13>
 <73a04afaf658292c05ef27117c60b21d@milecki.pl>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <d46241e139b7a1e96705402a42f9bf31@walle.cc>
X-Sender: michael@walle.cc
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2023-03-06 14:57, schrieb Rafał Miłecki:
> On 2023-03-06 14:35, Miquel Raynal wrote:
>> Hi Michael,
>> 
>> michael@walle.cc wrote on Mon, 06 Mar 2023 14:01:34 +0100:
>> 
>>> > Miquel Raynal (8):
>>> >   of: Fix modalias string generation
>>> >   of: Change of_device_get_modalias() main argument
>>> >   of: Create an of_device_request_module() receiving an OF node
>>> >   nvmem: core: Fix error path ordering
>>> >   nvmem: core: Handle the absence of expected layouts
>>> >   nvmem: core: Request layout modules loading
>>> >   nvmem: layouts: sl28vpd: Convert layout driver into a module
>>> >   nvmem: layouts: onie-tlv: Convert layout driver into a module
>>> 
>>> With the fixes series [1] applied:
>> 
>> Thanks for the series! Looks good to me. I believe both series can 
>> live
>> in separate tress, any reason why we would like to avoid this? I am 
>> keen
>> to apply [1] into the mtd tree rather soon.
> 
> Given past events with nvmem patches I'm against that.
> 
> Let's wait for Srinivas to collect pending patches, let them spend a
> moment in linux-next maybe, ask Srinivas to send them to Greg early if
> he can. That way maybe you can merge Greg's branch (assuming he doesn't
> rebase).

Mh? None of these fixes have anything to do with nvmem (except maybe 
patch
4/4). The bugs were just discovered while I was testing this series. But
OTOH they are kind of a prerequisite for this series. So what are you
suggesting here?

-michael

