Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE1BC740C28
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 11:02:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236565AbjF1JBf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 05:01:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236030AbjF1In4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 04:43:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4F7B3C21;
        Wed, 28 Jun 2023 01:36:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EDE1C612D8;
        Wed, 28 Jun 2023 06:05:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79D25C433C8;
        Wed, 28 Jun 2023 06:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687932330;
        bh=twiHrOPZB7Cgvszl3+g/k/ScexccFFEb5EWUW2A41Fo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=BioGUNGwScYPlVG94Dmc41pSG0YnmkxnAjq06pLGC6Xor/LlqTzgKYeDb2fjeMbA/
         FLFShvgCLtmU1zzhBbyRYUhfx/q3jpEOnCgFyAMhViU63W0+oL5/TVd+IOoflXyLvW
         o9DwjALrw6VSPv+qbEnhgdIF2jfBkqtPMWPKxDAJPwUeAZZZ5+s5JU8lfIa0PHLg3d
         xX5f/aLJdUko24gqPt2gqdrKEbAZn9ogTBHY3zyPYos5/F3s/NGyXukm33NwESzlix
         HT7TO0Zz5NovQwWwfEVcfwGbGSF2V67tiaY1NF09bn3sf3r3XND3jE7if5Rz8iZf4k
         xqiNEnh40EJrw==
Message-ID: <6232885e-d841-8067-b238-dda6f89f33f2@kernel.org>
Date:   Wed, 28 Jun 2023 15:05:28 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3] block: add check that partition length needs to be
 aligned with block size
Content-Language: en-US
To:     Min Li <min15.li@samsung.com>, axboe@kernel.dk,
        willy@infradead.org, hch@lst.de, gregkh@linuxfoundation.org
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@kernel.org
References: <CGME20230628051122epcas5p45d70f2c36ce91b60863f702de1534321@epcas5p4.samsung.com>
 <20230628130941.10690-1-min15.li@samsung.com>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230628130941.10690-1-min15.li@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/28/23 22:09, Min Li wrote:
> Before calling add partition or resize partition, there is no check
> on whether the length is aligned with the logical block size.
> If the logical block size of the disk is larger than 512 bytes,
> then the partition size maybe not the multiple of the logical block size,
> and when the last sector is read, bio_truncate() will adjust the bio size,
> resulting in an IO error if the size of the read command is smaller than
> the logical block size.If integrity data is supported, this will also
> result in a null pointer dereference when calling bio_integrity_free.
> 
> Signed-off-by: Min Li <min15.li@samsung.com>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>


-- 
Damien Le Moal
Western Digital Research

