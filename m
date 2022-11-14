Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D892B6281E8
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 15:04:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236314AbiKNOEE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 09:04:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236719AbiKNODT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 09:03:19 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE0BC2AC75;
        Mon, 14 Nov 2022 06:03:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 82B46B80F91;
        Mon, 14 Nov 2022 14:03:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33777C433C1;
        Mon, 14 Nov 2022 14:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668434596;
        bh=MUvSTgHOHNFDpAL2hFpOgTLtI7jmWOp30r5+jRyuvvg=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=cli7xA2q8GmnA1bTRkzFFKoYOEy8ffVbJ4oO3j5hmsuNRKUVmlAUxXtaQrgq+yZOG
         3hKXdBS36zkhDnDLmRkA1WTcfD6XA2qil5PkNTiQSrd/rQk8v46YKh4UnhdqR36f1V
         lWIEPWheqkOhkrqsqJbssb7eVvWadWzi8shpkENyox15O4Fz2LdCY3hpMIlCngKu10
         hZ5j5hS5Q73bmCBc+mMz/vssRhtXJHB2VZJu6LlJCm0A0wnM7kyAtbhx9YTohM50XZ
         eseTZjrhb1E+ofCT9Q7ql/9bk4hidD5vtH23GJP2jQWAXqBpw25QX2Qw35iFcntwdn
         11rRbiA9imf2Q==
Date:   Mon, 14 Nov 2022 15:03:14 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     =?ISO-8859-15?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
cc:     benjamin.tissoires@redhat.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: uclogic: Fix frame templates for big endian
 architectures
In-Reply-To: <20221110174918.398567-1-jose.exposito89@gmail.com>
Message-ID: <nycvar.YFH.7.76.2211141503020.6045@cbobk.fhfr.pm>
References: <20221110174918.398567-1-jose.exposito89@gmail.com>
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

On Thu, 10 Nov 2022, José Expósito wrote:

> When parsing a frame template with a placeholder indicating the number
> of buttons present on the frame its value was incorrectly set on big
> endian architectures due to double little endian conversion.
> 
> In order to reproduce the issue and verify the fix, run the HID KUnit
> tests on the PowerPC architecture:
> 
>   $ ./tools/testing/kunit/kunit.py run --kunitconfig=drivers/hid \
>     --arch=powerpc --cross_compile=powerpc64-linux-gnu-
> 
> Fixes: 867c89254425 ("HID: uclogic: Allow to generate frame templates")
> Signed-off-by: José Expósito <jose.exposito89@gmail.com>
> ---
>  drivers/hid/hid-uclogic-rdesc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hid/hid-uclogic-rdesc.c b/drivers/hid/hid-uclogic-rdesc.c
> index 4bd54c4fb5b0..6b73eb0df6bd 100644
> --- a/drivers/hid/hid-uclogic-rdesc.c
> +++ b/drivers/hid/hid-uclogic-rdesc.c
> @@ -1193,7 +1193,7 @@ __u8 *uclogic_rdesc_template_apply(const __u8 *template_ptr,
>  			   p[sizeof(btn_head)] < param_num) {
>  			v = param_list[p[sizeof(btn_head)]];
>  			put_unaligned((__u8)0x2A, p); /* Usage Maximum */
> -			put_unaligned_le16((__force u16)cpu_to_le16(v), p + 1);
> +			put_unaligned((__force u16)cpu_to_le16(v), (s16 *)(p + 1));
>  			p += sizeof(btn_head) + 1;
>  		} else {

Applied to hid.git#for-6.1/upstream-fixes, thanks José.

-- 
Jiri Kosina
SUSE Labs

