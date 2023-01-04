Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B38C665DAFE
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 18:10:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239917AbjADRKU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 12:10:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239446AbjADRJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 12:09:46 -0500
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2E1E11807
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 09:09:44 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id j16-20020a056830271000b0067202045ee9so21103504otu.7
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jan 2023 09:09:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=v3SV/pRZ8kBLvbm32yVCANFhuKrE0mqli+M9WEjG9/g=;
        b=NtTfzMp8Uv94LYMmBNgNaWa9k9Ic79F8HfGVm5DUTWxbedBe8PI3OYGixCm9Ha5j6s
         Obuyi5r92oltw8vsC0VKaJqx5GNYRDAFjoBZMFRCpobo/w3PahmqlKl8nHq9E0OKc4Vr
         1JAXBIVNmONvfMwfCcdE1enfS2hHVXKX4SqCDfRvNzPXEvE4iMyOK9q5Kf4hIjjWGRUN
         pa8frZ89+Des6b/G9LuVpyQF2HBSmVijA+o7ZKb+rqdaKO5KZ5CBMFTE9VE7dYPzEPLB
         ++07iMgR2x+P273wPRftk51Z1zs37AuQdsLhL0GWBnlTcH6xCMEMcMyXSt1nSpOK3W6a
         Tvgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v3SV/pRZ8kBLvbm32yVCANFhuKrE0mqli+M9WEjG9/g=;
        b=0Ye6Hdoga6GrRbhNF6FH5yGfukU4bf5U0F+9EvJi3LBFoPp7XOF7YOo7KE9pVIaFpo
         O6ei08HBTEWaAyFeTT/W7/L0/EHGAh3/pZNCdsu7cdgVG37OjBTpVRm3Y23w7TrgXjWe
         EM2nx79Som5x2PWVMtVrfgH8bWrPZi0fRVAPunOp7cen8vrmiRMu9/CpROy3TLy8/zIW
         YqBioT1zidSe548WdwnCEAL4xryVrqwRJHFfv8Y9nfGVW03OJ+f6rDVCVFcR4EX7GMbb
         V+z03lyjToJZ471hxIIWE9F/QoXKe/aEgHXNu7ggmXXz197DugPrF6dTHoUXMnB95Or5
         qEyw==
X-Gm-Message-State: AFqh2koyAn0xbLxrx11lWt03jZLBAjM1uuXIcS2D7+EscW2sF359WPYB
        wpJezwcR9KK4HJ5Z543M4kbiOFX6LYN6KOf1ZPI=
X-Google-Smtp-Source: AMrXdXsO5U+hyynlhinfooNiyQdtVxoQct8y+ZUzoE8fk296xHwLprRJoY/m4CkymQXu9HHO3iCbJULL7895QurkJZM=
X-Received: by 2002:a9d:62d1:0:b0:675:cde9:90b9 with SMTP id
 z17-20020a9d62d1000000b00675cde990b9mr3163048otk.123.1672852184006; Wed, 04
 Jan 2023 09:09:44 -0800 (PST)
MIME-Version: 1.0
References: <20230104164042.30271-1-mario.limonciello@amd.com> <20230104164042.30271-6-mario.limonciello@amd.com>
In-Reply-To: <20230104164042.30271-6-mario.limonciello@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 4 Jan 2023 12:09:32 -0500
Message-ID: <CADnq5_M-JFEYtEOJyBAP1Z9zBkA-=ck8ZZMUC5eJ42zp-_9KjQ@mail.gmail.com>
Subject: Re: [PATCH v5 05/45] drm/amd: Add a new helper for loading/validating microcode
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        linux-kernel@vger.kernel.org, "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        Lazar Lijo <Lijo.Lazar@amd.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        Daniel Vetter <daniel@ffwll.ch>,
        Carlos Soriano Sanchez <csoriano@redhat.com>,
        David Airlie <airlied@gmail.com>, christian.koenig@amd.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 4, 2023 at 11:42 AM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> All microcode runs a basic validation after it's been loaded. Each
> IP block as part of init will run both.
>
> Introduce a wrapper for request_firmware and amdgpu_ucode_validate.
> This wrapper will also remap any error codes from request_firmware
> to -ENODEV.  This is so that early_init will fail if firmware couldn't
> be loaded instead of the IP block being disabled.
>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v4->v5:
>  * Rename symbols for amdgpu_ucode_request/amdgpu_ucode_release
>  * Make argument const
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c | 36 +++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h |  3 ++
>  2 files changed, 39 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
> index eafcddce58d3..dc6af1fffdd9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
> @@ -1312,3 +1312,39 @@ void amdgpu_ucode_ip_version_decode(struct amdgpu_device *adev, int block_type,
>
>         snprintf(ucode_prefix, len, "%s_%d_%d_%d", ip_name, maj, min, rev);
>  }
> +
> +/*
> + * amdgpu_ucode_request - Fetch and validate amdgpu microcode
> + *
> + * @adev: amdgpu device
> + * @fw: pointer to load firmware to
> + * @fw_name: firmware to load
> + *
> + * This is a helper that will use request_firmware and amdgpu_ucode_validate
> + * to load and run basic validation on firmware. If the load fails, remap
> + * the error code to -ENODEV, so that early_init functions will fail to load.
> + */
> +int amdgpu_ucode_request(struct amdgpu_device *adev, const struct firmware **fw,
> +                        const char *fw_name)
> +{
> +       int err = request_firmware(fw, fw_name, adev->dev);
> +
> +       if (err)
> +               return -ENODEV;
> +       err = amdgpu_ucode_validate(*fw);
> +       if (err)
> +               dev_dbg(adev->dev, "\"%s\" failed to validate\n", fw_name);
> +
> +       return err;
> +}
> +
> +/*
> + * amdgpu_ucode_release - Release firmware microcode
> + *
> + * @fw: pointer to firmware to release
> + */
> +void amdgpu_ucode_release(const struct firmware *fw)

This should be **fw if we want to set it to NULL.

Alex

> +{
> +       release_firmware(fw);
> +       fw = NULL;
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
> index 552e06929229..7fd2f04f7f98 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
> @@ -544,6 +544,9 @@ void amdgpu_ucode_print_sdma_hdr(const struct common_firmware_header *hdr);
>  void amdgpu_ucode_print_psp_hdr(const struct common_firmware_header *hdr);
>  void amdgpu_ucode_print_gpu_info_hdr(const struct common_firmware_header *hdr);
>  int amdgpu_ucode_validate(const struct firmware *fw);
> +int amdgpu_ucode_request(struct amdgpu_device *adev, const struct firmware **fw,
> +                        const char *fw_name);
> +void amdgpu_ucode_release(const struct firmware *fw);
>  bool amdgpu_ucode_hdr_version(union amdgpu_firmware_header *hdr,
>                                 uint16_t hdr_major, uint16_t hdr_minor);
>
> --
> 2.34.1
>
