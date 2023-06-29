Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8917742362
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 11:43:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231546AbjF2JnS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 05:43:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbjF2JnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 05:43:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9A77ED;
        Thu, 29 Jun 2023 02:43:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5E98A6150C;
        Thu, 29 Jun 2023 09:43:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D8F7C433C0;
        Thu, 29 Jun 2023 09:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688031792;
        bh=wzR8YZnxm3FG7gwYs5SdxjfCUJ2NXEhOFnOR0leXfts=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=TxlqtQPOajshWpjFna9G6VbJOeh8zHECorIIqQlvPPPQyHYCRbGuSIuZlYyeilevd
         5Lia1h5+HRqmaM1fej92tx1ZC7o7S2CgedzSniTSwOKxGTJB96ZbUhtFy0+JQQP7az
         MMMcBFjv06KbCdIpK/mCrznNAppuXgT+dkUp614c3cg8HKv19CY4/pXBgnRqSzBbNW
         7wXcWilQnGauItgDfq3a+xZLhBatp5mYGIxeUruqr/THmVHNzVDel6RZ68aBrfFPZj
         ACGyPmy3EPmNaWjpeDLBAH/umcemXf2S3dpgclpXvx8Xb/8RrEoi8zLTHDGjkNP4WY
         WKEdpiIQhIyWQ==
Message-ID: <cefae2c3-c8b5-f5ff-13dc-e8527ca2346f@kernel.org>
Date:   Thu, 29 Jun 2023 18:43:10 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v4 4/4] ublk: add zone append
Content-Language: en-US
To:     "Andreas Hindborg (Samsung)" <nmi@metaspace.dk>,
        Ming Lei <ming.lei@redhat.com>
Cc:     Hans Holmberg <Hans.Holmberg@wdc.com>,
        Aravind Ramesh <Aravind.Ramesh@wdc.com>,
        Jens Axboe <axboe@kernel.dk>,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        open list <linux-kernel@vger.kernel.org>, gost.dev@samsung.com,
        Minwoo Im <minwoo.im.dev@gmail.com>
References: <20230628190649.11233-1-nmi@metaspace.dk>
 <20230628190649.11233-5-nmi@metaspace.dk>
 <ZJzwcG2gIxXh8HbE@ovpn-8-18.pek2.redhat.com> <87edluy5l3.fsf@metaspace.dk>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <87edluy5l3.fsf@metaspace.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/29/23 18:17, Andreas Hindborg (Samsung) wrote:
> 
> Ming Lei <ming.lei@redhat.com> writes:
> 
>> On Wed, Jun 28, 2023 at 09:06:49PM +0200, Andreas Hindborg wrote:
>>> From: Andreas Hindborg <a.hindborg@samsung.com>
>>>
>>> Add zone append feature to ublk. This feature uses the `addr` field of `struct
>>> ublksrv_io_cmd`. Therefore ublk must be used with the user copy
>>> feature (UBLK_F_USER_COPY) for zone append to be available. Without this
>>> feature, ublk will fail zone append requests.
>>
>> Given zone append is a must, please fail to add device in case of zoned
>> and !user_copy, then we can make fast IO code path clean.
> 
> I will squash the patches and reject zone support if not user copy is
> enabled 👍

Or if !CONFIG_BLK_DEV_ZONED or if the user specifies a bad parameter (invalid
limits etc).

-- 
Damien Le Moal
Western Digital Research

