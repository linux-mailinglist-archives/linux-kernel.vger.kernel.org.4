Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A02777349B0
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 03:21:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbjFSBVA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jun 2023 21:21:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjFSBU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jun 2023 21:20:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DBAE1B4;
        Sun, 18 Jun 2023 18:20:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ADF7660FED;
        Mon, 19 Jun 2023 01:20:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CDF6C433C0;
        Mon, 19 Jun 2023 01:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687137656;
        bh=P/nw2UCR5A0P8VasNf42geCF7CnuqQIE1bIh3grG8k4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=pH1B5X4UTh8/rYYHdnfBA3PtdvmuOVkWvyVorFSzTAy7OpXATBQ6fv+XxSCK7wTze
         r8Yii+AjgZOg5RAjyXOdPtxuWKtRoxjlQv0Msul8KBHUfzES0ZWqOfSgvDp/rVk6fh
         KieB271Ixq/qUr0rGUdf66c0uY0pt7RXo6CZJTzgpgQcc6tFEzUYqVMbomFQy5BmC4
         CM/csqKxxO2v6IQfvJb2W5FcYmejdowu0n6pucrz4JQSVjw0TSf0tT6DeWy4wRus3o
         AZ67t0OOimBc7nhwV5s3XdxLKWLdRcuBc8gDOuDKbOldABKiI59g5uoZ0RS4+zdlUn
         e3urB8auR9xCQ==
Message-ID: <da21ac06-666f-01f1-fa8d-f660a83a9182@kernel.org>
Date:   Mon, 19 Jun 2023 10:20:53 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v4] block: add capacity validation in bdev_add_partition()
To:     Min Li <min15.li@samsung.com>, axboe@kernel.dk,
        willy@infradead.org, hch@lst.de, gregkh@linuxfoundation.org,
        wsa@kernel.org, vkoul@kernel.org
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <CGME20230619011354epcas5p32c094e0c9bcd1ec2184c66a5f8be3268@epcas5p3.samsung.com>
 <20230619091214.31615-1-min15.li@samsung.com>
Content-Language: en-US
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230619091214.31615-1-min15.li@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/19/23 18:12, Min Li wrote:
> In the function bdev_add_partition(),there is no check that the start
> and end sectors exceed the size of the disk before calling add_partition.
> When we call the block's ioctl interface directly to add a partition,
> and the capacity of the disk is set to 0 by driver,the command will
> continue to execute.
> 
> Signed-off-by: Min Li <min15.li@samsung.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>


-- 
Damien Le Moal
Western Digital Research

