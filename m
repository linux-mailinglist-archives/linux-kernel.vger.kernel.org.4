Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F3926CD790
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 12:22:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231529AbjC2KWk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 06:22:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjC2KWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 06:22:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 326DB211F
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 03:22:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C4AD3B82229
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 10:22:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09E27C433EF;
        Wed, 29 Mar 2023 10:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1680085355;
        bh=4sX9XMtD+21BEY/67X7zCOxUYjEltxNobcQGjkEiXrA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vE0HJVu3ScGlr172U+cNj2zPRte8lGkhi2zjsq0loRUCnaG78WocF2HjRRQwz5YEj
         RYCmDF0LLuDm3zkgCe1AEeF6UWZD9NwLgCgC9jk8B6DYsy9MhtR60mPCv6xbCtD9ff
         m/JAkC+ppdL8r7bIXYVufm96DRWDMeTQb8c5TgPs=
Date:   Wed, 29 Mar 2023 12:22:33 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Amadeusz =?utf-8?B?U8WCYXdpxYRza2k=?= 
        <amadeuszx.slawinski@linux.intel.com>
Cc:     Russ Weight <russell.h.weight@intel.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-kernel@vger.kernel.org,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH v5] firmware_loader: Add debug message with checksum for
 FW file
Message-ID: <ZCQRad48nMs0TEAk@kroah.com>
References: <20230317224729.1025879-1-amadeuszx.slawinski@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230317224729.1025879-1-amadeuszx.slawinski@linux.intel.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 17, 2023 at 11:47:29PM +0100, Amadeusz Sławiński wrote:
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
> Reviewed-by: Cezary Rojewski <cezary.rojewski@intel.com>
> Reviewed-by: Russ Weight <russell.h.weight@intel.com>
> Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
> ---
> 
> Changes in v5:
>  * remove unnecessary select in Kconfig (Greg)
> 
> Changes in v4:
>  * update menuconfig prompt and help message (Russ)
> 
> Changes in v3:
>  * add DYNAMIC_DEBUG and FW_LOADER as dependencies before option can be
> enabled (kernel test robot)
> 
> Changes in v2:
>  * allocate buffers (Greg)
>  * introduce CONFIG_ option to allow for CONFIG_CRYPTO and CONFIG_CRYPTO_SHA256
> dependencies without introducing circular dependency (Greg)
>  * add new line between includes and function name (Cezary)
> 
> ---
>  drivers/base/firmware_loader/Kconfig | 12 +++++++
>  drivers/base/firmware_loader/main.c  | 48 +++++++++++++++++++++++++++-
>  2 files changed, 59 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/base/firmware_loader/Kconfig b/drivers/base/firmware_loader/Kconfig
> index 5166b323a0f8..0cabc783d67a 100644
> --- a/drivers/base/firmware_loader/Kconfig
> +++ b/drivers/base/firmware_loader/Kconfig
> @@ -24,6 +24,18 @@ config FW_LOADER
>  	  You also want to be sure to enable this built-in if you are going to
>  	  enable built-in firmware (CONFIG_EXTRA_FIRMWARE).
>  
> +config FW_LOADER_DEBUG
> +	bool "Log filenames and checksums for loaded firmware"
> +	depends on DYNAMIC_DEBUG
> +	depends on FW_LOADER
> +	depends on CRYPTO
> +	depends on CRYPTO_SHA256
> +	default FW_LOADER
> +	help
> +	  Select this option to use dynamic debug to log firmware filenames and
> +	  SHA256 checksums to the kernel log for each firmware file that is
> +	  loaded.
> +
>  if FW_LOADER
>  
>  config FW_LOADER_PAGED_BUF
> diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware_loader/main.c
> index 017c4cdb219e..b2c292ca95e8 100644
> --- a/drivers/base/firmware_loader/main.c
> +++ b/drivers/base/firmware_loader/main.c
> @@ -791,6 +791,50 @@ static void fw_abort_batch_reqs(struct firmware *fw)
>  	mutex_unlock(&fw_lock);
>  }
>  
> +#if defined(CONFIG_FW_LOADER_DEBUG)
> +#include <crypto/hash.h>
> +#include <crypto/sha2.h>
> +
> +static void fw_log_firmware_info(const struct firmware *fw, const char *name, struct device *device)
> +{
> +	struct shash_desc *shash;
> +	struct crypto_shash *alg;
> +	u8 *sha256buf;
> +	char *outbuf;
> +
> +	alg = crypto_alloc_shash("sha256", 0, 0);
> +	if (!alg)
> +		return;
> +
> +	sha256buf = kmalloc(SHA256_DIGEST_SIZE, GFP_KERNEL);
> +	outbuf = kmalloc(SHA256_BLOCK_SIZE + 1, GFP_KERNEL);
> +	shash = kmalloc(sizeof(*shash) + crypto_shash_descsize(alg), GFP_KERNEL);
> +	if (!sha256buf || !outbuf || !shash)
> +		goto out_free;
> +
> +	shash->tfm = alg;
> +
> +	if (crypto_shash_digest(shash, fw->data, fw->size, sha256buf) < 0)
> +		goto out_shash;
> +
> +	for (int i = 0; i < SHA256_DIGEST_SIZE; i++)
> +		sprintf(&outbuf[i * 2], "%02x", sha256buf[i]);
> +	outbuf[SHA256_BLOCK_SIZE] = 0;
> +	dev_dbg(device, "Loaded FW: %s, sha256: %s\n", name, outbuf);
> +
> +out_shash:
> +	crypto_free_shash(alg);
> +out_free:
> +	kfree(shash);
> +	kfree(outbuf);
> +	kfree(sha256buf);
> +}
> +#else
> +static void fw_log_firmware_info(const struct firmware *fw, const char *name,
> +				 struct device *device)
> +{}
> +#endif
> +
>  /* called from request_firmware() and request_firmware_work_func() */
>  static int
>  _request_firmware(const struct firmware **firmware_p, const char *name,
> @@ -861,11 +905,13 @@ _request_firmware(const struct firmware **firmware_p, const char *name,
>  	revert_creds(old_cred);
>  	put_cred(kern_cred);
>  
> - out:
> +out:

Nit, this change shouldn't have been needed.  But it cleans up the file,
so I'll take it :)

thanks,

greg k-h
