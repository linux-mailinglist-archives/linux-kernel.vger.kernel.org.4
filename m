Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62189632B29
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 18:37:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbiKURht (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 12:37:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230353AbiKURhg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 12:37:36 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DA7355BE;
        Mon, 21 Nov 2022 09:37:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C00F261368;
        Mon, 21 Nov 2022 17:37:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26EFDC433D7;
        Mon, 21 Nov 2022 17:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669052247;
        bh=9enBFwgR2NIy3a2Lit41uD3LnCDTMa1hHFgRnJhNdcw=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=XqqIxTHBhUkdUGveugaIUMfes/xX2QQ/6kaqWGUXjIMQwJUzRqpK7BV3nOBKsOYWq
         DvzsoIlklnkqs5y5g/EvlqUMmWapX+qPyEKj7uMHylCkYkKTrsjpOrR6SBlTSpPKHl
         yiG/CKk5NQ87SZe2n/WqlPm6ijJm5zSZggOlI2G2raBsqhZbiHv2jWG4NOnGbCC6AP
         UMYXXO6tewDWKC5blQSsy1/ejJ1fp7clKtN/r6MIOCjIzGP4usQQGrb0X+IN1Bc6kj
         Wb+lw5e7TEhVBSpBIgv+xMB4TtXhEKUMlXvOqGss3AYBXYuarV/VCXSd3q+ceF311e
         OKoluADM8qiBA==
Date:   Mon, 21 Nov 2022 18:37:25 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH for-6.2/hid-bpf] HID: force HID depending on INPUT
In-Reply-To: <20221118105448.1888750-1-benjamin.tissoires@redhat.com>
Message-ID: <nycvar.YFH.7.76.2211211837100.6045@cbobk.fhfr.pm>
References: <20221118105448.1888750-1-benjamin.tissoires@redhat.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Nov 2022, Benjamin Tissoires wrote:

> In most configurations, INPUT is actually a boolean: either y or disabled,
> but when it's disabled, you can't do much on your average laptop.
> 
> But it turns out that there is a possibility to have INPUT as a module:
> you have to disable VT and TTY (of course), but also enable EXPERT.
> I'll leave how to disable VT and TTY as an exercise for the bravest.
> 
> Anyway, if INPUT is m, we can still configure HID as y, which is not
> correct because hid-input.c depends on the input API, meaning that
> vmlinuz can not link.
> 
> So: add depends on INPUT too at the HID level, to ensure that if INPUT=m,
> HID can only be m or disabled.
> 
> Fixes: 25621bcc8976 ("HID: Kconfig: split HID support and hid-core compilation")
> Reported-by: kernel test robot <lkp@intel.com>
> Link: https://lore.kernel.org/r/202211181742.QYJY6Gug-lkp@intel.com
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Applied as well to for-6.2/hid-bpf. Thanks,

-- 
Jiri Kosina
SUSE Labs

