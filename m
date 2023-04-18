Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E224B6E5D64
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 11:30:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230423AbjDRJaA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 05:30:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231316AbjDRJ3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 05:29:48 -0400
Received: from mail.3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4D135595
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 02:29:46 -0700 (PDT)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id 5B5DF9E3;
        Tue, 18 Apr 2023 11:29:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1681810185;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NayrR68KcLRy+l3mJSHMh2mevUq9FSM3tf3pOAeKAqY=;
        b=p0n/c2lUevHY4Rw1cblUVNGasItTK6jdIGDkq2NlqWhIutLX+HulTKtcpgog3eWfey6mIS
        FwsIWy6AD3eXbkFIdmZ1EDvddqX9Hp5LG4E1Aru6pRh96tM7vLIa+7Bo18ytk3h+sjbykd
        VYX1a/nhmZwsJUN4p3fsJcQnQw96RvxHAyZdqauoOLYUKNhSVfGwqlWU8paWOQcTnaMeJX
        G2zC9+MU0HOa8uvNYmh7aZe1or1Wl+XdCm7q+TPRY7aI+ro8GzeL+MSqiDjRBDzzLVGSqZ
        SNLoyq3sLeEnFRyJoWzL4zbQig+pEm9agck7ZNtnXFu/6eKGX5fuBDxTzzAF9w==
MIME-Version: 1.0
Date:   Tue, 18 Apr 2023 11:29:45 +0200
From:   Michael Walle <michael@walle.cc>
To:     Tudor Ambarus <tudor.ambarus@linaro.org>
Cc:     tkuw584924@gmail.com, Takahiro.Kuwano@infineon.com,
        pratyush@kernel.org, bacem.daassi@infineon.com,
        miquel.raynal@bootlin.com, richard@nod.at,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: spi-nor: spansion: Rename method to
 cypress_nor_get_page_size
In-Reply-To: <20230405060456.48986-1-tudor.ambarus@linaro.org>
References: <20230405060456.48986-1-tudor.ambarus@linaro.org>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <736b881c4dd3d0fb0522ab0d385798f5@walle.cc>
X-Sender: michael@walle.cc
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2023-04-05 08:04, schrieb Tudor Ambarus:
> The method queries SPINOR_REG_CYPRESS_CFR3V to determine the page size.
> Rename the method accordingly, s/set/get.

I'm not sure about this one. There is also a
cypress_nor_set_addr_mode_nbytes() which queries the flash and
set the params->addr_nbytes and params->addr_mode_nbytes.

cypress_nor_set_page_size() also queries the flash and set
params->page_size.

Secondly, if this function is called get_page_size() I'd assume it
doesn't modify anything. But thats not true.

-michael
