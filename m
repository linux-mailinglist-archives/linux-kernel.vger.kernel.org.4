Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43D7C690D9D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 16:52:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231311AbjBIPwn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 10:52:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjBIPwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 10:52:41 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DD81BB9F
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 07:52:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F0EABB821AB
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 15:52:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F39A6C433D2;
        Thu,  9 Feb 2023 15:52:35 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="T7479kc0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1675957953;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ClkILBFhwZ0hiKBY6JMu424+AE+9QOn/sCNADO5raM4=;
        b=T7479kc0O5QmNDeC9Qyyjh2xEhjUPOaZMFArkBoVaJdeKu5s8jYbfZ3xK5J1iDriwR9uXN
        3rZodz28XhNZYDKZ2BNgwrbtP0eDeGzvsjyTpVCHnMY+cbpXIJyED9KhTuTJmG/5qUk7Jv
        78ZT6IAAB0MueXiEXNco+4O6qJhrNR8=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 79d27562 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 9 Feb 2023 15:52:33 +0000 (UTC)
Date:   Thu, 9 Feb 2023 16:52:32 +0100
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     qemu-devel@nongnu.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, Dov Murik <dovmurik@linux.ibm.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Eric Biggers <ebiggers@kernel.org>,
        Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
        Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH RFC 6/7] Revert "x86: return modified setup_data only if
 read as memory, not as file"
Message-ID: <Y+UWwJRY/ejrIqv7@zx2c4.com>
References: <20230208211212.41951-1-mst@redhat.com>
 <20230208211212.41951-7-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230208211212.41951-7-mst@redhat.com>
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MISSING_HEADERS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 08, 2023 at 04:12:51PM -0500, Michael S. Tsirkin wrote:
> This reverts commit e935b735085dfa61d8e6d276b6f9e7687796a3c7.
> 
> Fixes: e935b73508 ("x86: return modified setup_data only if read as memory, not as file")
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  include/hw/nvram/fw_cfg.h | 22 -------------------
>  hw/i386/x86.c             | 46 +++++++++------------------------------
>  hw/nvram/fw_cfg.c         | 12 +++++-----
>  3 files changed, 16 insertions(+), 64 deletions(-)
> 
> diff --git a/include/hw/nvram/fw_cfg.h b/include/hw/nvram/fw_cfg.h
> index 2e503904dc..c1f81a5f13 100644
> --- a/include/hw/nvram/fw_cfg.h
> +++ b/include/hw/nvram/fw_cfg.h
> @@ -117,28 +117,6 @@ struct FWCfgMemState {
>   */
>  void fw_cfg_add_bytes(FWCfgState *s, uint16_t key, void *data, size_t len);
>  
> -/**
> - * fw_cfg_add_bytes_callback:
> - * @s: fw_cfg device being modified
> - * @key: selector key value for new fw_cfg item
> - * @select_cb: callback function when selecting
> - * @write_cb: callback function after a write
> - * @callback_opaque: argument to be passed into callback function
> - * @data: pointer to start of item data
> - * @len: size of item data
> - * @read_only: is file read only
> - *
> - * Add a new fw_cfg item, available by selecting the given key, as a raw
> - * "blob" of the given size. The data referenced by the starting pointer
> - * is only linked, NOT copied, into the data structure of the fw_cfg device.
> - */
> -void fw_cfg_add_bytes_callback(FWCfgState *s, uint16_t key,
> -                               FWCfgCallback select_cb,
> -                               FWCfgWriteCallback write_cb,
> -                               void *callback_opaque,
> -                               void *data, size_t len,
> -                               bool read_only);
> -
>  /**
>   * fw_cfg_add_string:
>   * @s: fw_cfg device being modified
> diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
> index a00881bc64..29a5bef1d5 100644
> --- a/hw/nvram/fw_cfg.c
> +++ b/hw/nvram/fw_cfg.c
> @@ -693,12 +693,12 @@ static const VMStateDescription vmstate_fw_cfg = {
>      }
>  };
>  
> -void fw_cfg_add_bytes_callback(FWCfgState *s, uint16_t key,
> -                               FWCfgCallback select_cb,
> -                               FWCfgWriteCallback write_cb,
> -                               void *callback_opaque,
> -                               void *data, size_t len,
> -                               bool read_only)
> +static void fw_cfg_add_bytes_callback(FWCfgState *s, uint16_t key,
> +                                      FWCfgCallback select_cb,
> +                                      FWCfgWriteCallback write_cb,
> +                                      void *callback_opaque,
> +                                      void *data, size_t len,
> +                                      bool read_only)
>  {
>      int arch = !!(key & FW_CFG_ARCH_LOCAL);

Could you leave these snippets in? This function is useful and will be
needed in the reprise.

Jason
