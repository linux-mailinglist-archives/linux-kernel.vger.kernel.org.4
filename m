Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFCD56CF26A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 20:44:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbjC2SoI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 14:44:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjC2SoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 14:44:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0837F59F3;
        Wed, 29 Mar 2023 11:44:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9176BB823F8;
        Wed, 29 Mar 2023 18:44:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 241FAC433D2;
        Wed, 29 Mar 2023 18:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680115441;
        bh=AdTMFlaA1yVpN8yNukEmcL6Sup36/1XqYQqUHYbspDs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gchDkbybXrNa2nr5NVf2u/a3UBLqWO4oDXNai1+pd0Y+WcT05699mtknFCZ6mC04k
         f4eBJXcNS8WKaxncS4UezFbxNraVBIXjwNwnyi/iwFeeJEpv2y/ABSUFjbR6za1oor
         o0Us/G/C9mS0f03HI4KvA3BqUjFo6lr1PPoJ7xursEwwI0qWuS8n9T+z0M84A3xgUq
         LKE5LnD6r9J61sco6GQMTOrFgd8FzA0Qq1v48meX9Yl8bBOcTpKB0ULf52FOWctPvw
         aK7S1K+9YpwkpBSnHNwYMzV8W1LtbgB5JgiR7JtXhRaTZyLlkdHXiKthNJITvanvJh
         k6iXLWOW74/bg==
Date:   Wed, 29 Mar 2023 18:43:59 +0000
From:   Eric Biggers <ebiggers@kernel.org>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     palmer@dabbelt.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, herbert@gondor.apana.org.au,
        davem@davemloft.net, conor.dooley@microchip.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, christoph.muellner@vrull.eu,
        Heiko Stuebner <heiko.stuebner@vrull.eu>
Subject: Re: [PATCH v4 0/4] Implement GCM ghash using Zbc and Zbkb extensions
Message-ID: <ZCSG71bRuTzVutdm@gmail.com>
References: <20230329140642.2186644-1-heiko.stuebner@vrull.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230329140642.2186644-1-heiko.stuebner@vrull.eu>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heiko,

On Wed, Mar 29, 2023 at 04:06:38PM +0200, Heiko Stuebner wrote:
>
> [PATCH v4 0/4] Implement GCM ghash using Zbc and Zbkb extensions

Has there been consideration of implementing AES-GCM instead of GHASH by itself?
This is what arm64 does, for example.  There is not currently any use case for
GHASH outside of AES-GCM, and it's more efficient to implement the full AES-GCM.

- Eric
