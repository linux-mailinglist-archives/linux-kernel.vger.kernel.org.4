Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C48B6717BC
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 10:29:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbjARJ2k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 04:28:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbjARJXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 04:23:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0288378AB2;
        Wed, 18 Jan 2023 00:47:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 927006170C;
        Wed, 18 Jan 2023 08:47:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7861C433D2;
        Wed, 18 Jan 2023 08:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674031647;
        bh=eGelRK0QxB4MHLWy0yYg1Wv7neg8Dl520nKPLbMU4aA=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=sS7XrDHS/o9lxqEMfAYhwR5Fqlu9awESG6q4VEp79BN3Old4eI8JzG4Yjhgs9Zdsf
         fMoudhuaeYeTRj17o2Pw5X6/l7IX/S7ybP7RtnK46P9owfsSeowL1Xe5ff7eda/fcs
         NeGgxGZ3EYdY1KZKfoR6nCbeucRBdcYoKjrVuGNUnvvKYawo0I7jc0a4ZLlAyILF4B
         upj1v1Ntf7YbLlkvi3qVx2VhYQHKm7WADhxiq1ZsmOyteE3DH+kSREvaez7ddG9PrW
         BaIgS6qUnz2wm395RBkzKx50UNDXYSkpy2qaEFIL042Vji8Sk5e7OPXYj9u4x2iMKg
         A9XUE0FkV94nA==
Date:   Wed, 18 Jan 2023 09:47:27 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     =?ISO-8859-15?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
cc:     benjamin.tissoires@redhat.com, mcanal@igalia.com,
        mairacanal@riseup.net, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: uclogic: Use KUNIT_EXPECT_MEMEQ
In-Reply-To: <20221226125736.18053-1-jose.exposito89@gmail.com>
Message-ID: <nycvar.YFH.7.76.2301180947220.1734@cbobk.fhfr.pm>
References: <20221226125736.18053-1-jose.exposito89@gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Dec 2022, José Expósito wrote:

> Commit b8a926bea8b1 ("kunit: Introduce KUNIT_EXPECT_MEMEQ and
> KUNIT_EXPECT_MEMNEQ macros") introduced a new macro to compare blocks of
> memory and, if the test fails, print the result in a human friendly
> format. For example, this is the output of a test failure:
> 
>  Expected res == params->expected, but
>      res ==
>       01  02  aa  00  00  00  03  bb  00 <00> 00  04  05
>      params->expected ==
>       01  02  aa  00  00  00  03  bb  00 <01> 00  04  05
> 
> Use this new macro to replace KUNIT_EXPECT_EQ + memcmp.
> 
> Signed-off-by: José Expósito <jose.exposito89@gmail.com>
> ---
>  drivers/hid/hid-uclogic-rdesc-test.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/hid/hid-uclogic-rdesc-test.c b/drivers/hid/hid-uclogic-rdesc-test.c
> index b429c541bf2f..90bf4e586e01 100644
> --- a/drivers/hid/hid-uclogic-rdesc-test.c
> +++ b/drivers/hid/hid-uclogic-rdesc-test.c
> @@ -197,8 +197,7 @@ static void hid_test_uclogic_template(struct kunit *test)
>  					   params->param_list,
>  					   params->param_num);
>  	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, res);
> -	KUNIT_EXPECT_EQ(test, 0,
> -			memcmp(res, params->expected, params->template_size));
> +	KUNIT_EXPECT_MEMEQ(test, res, params->expected, params->template_size);
>  	kfree(res);

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

