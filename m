Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 792716A1C67
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 13:46:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbjBXMqu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 07:46:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjBXMqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 07:46:49 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47A6B2ED68
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 04:46:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E3981B81C5F
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 12:46:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 369ACC433D2;
        Fri, 24 Feb 2023 12:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1677242804;
        bh=dcKY5OyrTMwYNZaWgFt1rQYsBSe5lQFIiFZvXJHxDOA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IBlZLA+3Iar8BPKRJPCTk1hn71YKydchkmWRjj3j7ayh9xbMAomr7NGj8rAYvO99P
         8s/2bjeXq7yYZEbX3SlewGvzBxOcrwj756IOEVR7jmV1QUJF84jb7tMWJA39ch/AYr
         2Tv+o8WC0YvFtxodmmNtR4daoemybL+1v0CeTBUI=
Date:   Fri, 24 Feb 2023 13:46:42 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Amadeusz =?utf-8?B?U8WCYXdpxYRza2k=?= 
        <amadeuszx.slawinski@linux.intel.com>
Cc:     Russ Weight <russell.h.weight@intel.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-kernel@vger.kernel.org,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH] firmware_loader: Add debug message with checksum for FW
 file
Message-ID: <Y/ixsjgkh8M10yKX@kroah.com>
References: <20230224201918.411492-1-amadeuszx.slawinski@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230224201918.411492-1-amadeuszx.slawinski@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 24, 2023 at 09:19:18PM +0100, Amadeusz Sławiński wrote:
> Enable dynamic-debug logging of firmware filenames and SHA256 checksums
> to clearly identify the firmware files that are loaded by the system.
> 
> Example output:
> [   34.944619] firmware_class:_request_firmware: i915 0000:00:02.0: Loaded FW: i915/kbl_dmc_ver1_04.bin, sha256: 2cde41c3e5ad181423bcc3e98ff9c49f743c88f18646af4d0b3c3a9664b831a1
> [   48.155884] firmware_class:_request_firmware: snd_soc_avs 0000:00:1f.3: Loaded FW: intel/avs/cnl/dsp_basefw.bin, sha256: 43f6ac1b066e9bd0423d914960fbbdccb391af27d2b1da1085eee3ea8df0f357
> [   49.579540] firmware_class:_request_firmware: snd_soc_avs 0000:00:1f.3: Loaded FW: intel/avs/rt274-tplg.bin, sha256: 4b3580da96dc3d2c443ba20c6728d8b665fceb3ed57223c3a57582bbad8e2413
> [   49.798196] firmware_class:_request_firmware: snd_soc_avs 0000:00:1f.3: Loaded FW: intel/avs/hda-8086280c-tplg.bin, sha256: 5653172579b2be1b51fd69f5cf46e2bac8d63f2a1327924311c13b2f1fe6e601
> [   49.859627] firmware_class:_request_firmware: snd_soc_avs 0000:00:1f.3: Loaded FW: intel/avs/dmic-tplg.bin, sha256: 00fb7fbdb74683333400d7e46925dae60db448b88638efcca0b30215db9df63f
> 
> Reviewed-by: Russ Weight <russell.h.weight@intel.com>
> Reviewed-by: Cezary Rojewski <cezary.rojewski@intel.com>
> Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
> ---
>  drivers/base/firmware_loader/main.c | 45 ++++++++++++++++++++++++++++-
>  1 file changed, 44 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware_loader/main.c
> index 017c4cdb219e..a6e1fb10763d 100644
> --- a/drivers/base/firmware_loader/main.c
> +++ b/drivers/base/firmware_loader/main.c
> @@ -791,6 +791,47 @@ static void fw_abort_batch_reqs(struct firmware *fw)
>  	mutex_unlock(&fw_lock);
>  }
>  
> +#if defined(DEBUG) || defined(CONFIG_DYNAMIC_DEBUG)
> +#include <crypto/hash.h>
> +#include <crypto/sha2.h>
> +#define SHA256_STRING_SIZE (SHA256_DIGEST_SIZE * 2)
> +static void fw_log_firmware_info(const struct firmware *fw, const char *name, struct device *device)
> +{
> +	char outbuf[SHA256_STRING_SIZE + 1];
> +	u8 sha256buf[SHA256_DIGEST_SIZE];

Nit, these are big, are you _SURE_ you can put them on the stack ok?
Why not dynamically allocate them?

> +	struct shash_desc *shash;
> +	struct crypto_shash *alg;
> +
> +	alg = crypto_alloc_shash("sha256", 0, 0);

Do we need to select this in the .config as well?

> +	if (!alg)
> +		return;
> +
> +	shash = kmalloc(sizeof(*shash) + crypto_shash_descsize(alg), GFP_KERNEL);

kmalloc_array()?

> +	if (!shash)
> +		goto out_alg;
> +
> +	shash->tfm = alg;
> +
> +	if (crypto_shash_digest(shash, fw->data, fw->size, sha256buf) < 0)
> +		goto out_shash;
> +
> +	for (int i = 0; i < SHA256_DIGEST_SIZE; i++)
> +		sprintf(&outbuf[i * 2], "%02x", sha256buf[i]);
> +	outbuf[SHA256_STRING_SIZE] = 0;
> +	dev_dbg(device, "Loaded FW: %s, sha256: %s\n", name, outbuf);
> +
> +out_shash:
> +	kfree(shash);
> +out_alg:
> +	crypto_free_shash(alg);

Otherwise, just tiny comments, overall this looks nice, thanks for doing
this.

greg k-h
