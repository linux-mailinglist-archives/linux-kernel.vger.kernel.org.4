Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A16976AE7FC
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 18:11:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230521AbjCGRL3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 12:11:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbjCGRLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 12:11:05 -0500
Received: from mail.3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFA0B9CFF5;
        Tue,  7 Mar 2023 09:05:49 -0800 (PST)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id EB091124;
        Tue,  7 Mar 2023 18:04:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1678208678;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MnPC/dx2pZinfk0Ola2wbvkMss8Crat96y40veuYQjU=;
        b=lEq+23SJ1QPwyEFqQkXp1Prs1SVNz2226k8aboOabP0a4S59Ky5JMD44yE7pHdaL7DfsHy
        b4P28jnpujI6a/Ix+sT/zQ8CqOClQyzGwAoucxKFhIvgk9PzC03FaSCKiBK6w7eOhgPRDD
        P3em48gt3vhbqlX0U24/RuOKTxkBp2f8UikmJhrdZp/MTCh3Rdj/e7V6zRM0kfpqkycxDF
        ohm+n33XaGaLG9FPha0HZboLLazgNZLOdldf2/5ZfhSssrVlWA7Jx1SQxqDbZ+IKurSK00
        ftd4sNGMPns4kyYZB0q9jHLe8DwofBv0fgEHi6/JCyQISxY/yJHwNyzLIyDSvw==
MIME-Version: 1.0
Date:   Tue, 07 Mar 2023 18:04:37 +0100
From:   Michael Walle <michael@walle.cc>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>,
        Robert Marko <robert.marko@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org,
        Alexander Stein <alexander.stein@ew.tq-group.com>
Subject: Re: [PATCH v2 09/21] nvmem: core: return -ENOENT if nvmem cell is not
 found
In-Reply-To: <20230307165359.225361-10-miquel.raynal@bootlin.com>
References: <20230307165359.225361-1-miquel.raynal@bootlin.com>
 <20230307165359.225361-10-miquel.raynal@bootlin.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <b1457acdc76dbf4f945fcf8e8285d463@walle.cc>
X-Sender: michael@walle.cc
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2023-03-07 17:53, schrieb Miquel Raynal:
> From: Michael Walle <michael@walle.cc>
> 
> Prior to commit 3cb05fdbaed6 ("nvmem: core: add an index parameter to
> the cell") of_nvmem_cell_get() would return -ENOENT if the cell wasn't
> found. Particularly, if of_property_match_string() returned -EINVAL,
> that return code was passed as the index to of_parse_phandle(), which
> then detected it as invalid and returned NULL. That led to an return
> code of -ENOENT.
> 
> With the new code, the negative index will lead to an -EINVAL of
> of_parse_phandle_with_optional_args() which pass straight to the
> caller and break those who expect an -ENOENT.
> 
> Fix it by always returning -ENOENT.
> 
> Fixes: efff2655ab0f ("nvmem: core: add an index parameter to the cell")
> Reported-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> Signed-off-by: Michael Walle <michael@walle.cc>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

Misses the Tested-by: Alexander Stein <alexander.stein@ew.tq-group.com>
tag. But.. this is already applied anyways:
https://lore.kernel.org/r/515d5fed-2083-c1fd-eea5-148d9e1c45bd@linaro.org/

-michael
