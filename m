Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1132166075A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 20:49:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235493AbjAFTtM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 14:49:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjAFTtJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 14:49:09 -0500
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0B2C10BB
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 11:49:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=vcs0m2YzlpeiTJ1RSZsiUkgKFpcVYkaXJi2AsnlJnbA=; b=cqrzqceqJ+xAIjvgIkwcGb2b4P
        yQV/ALn6PCpPogumeGY4YFJsm4yZOg0mIUE5uyBgLodgdXMdyMAsqe4MAO5RNOQLBgRHt8IUwawIw
        xMgmgZGGkFGg4v9tJ8YFWaqBqaBrPCVE26cUvjlUQwcamBxx5G8UD6SHRM9b/YPNbHcQcSWoW63v3
        MEKSf5krO8jYbGu6CZJF/MtKb1/Nv//sYdyA2fNraX8iq+gd0g/Zp6TfBPox1D7QYIpVvLAgIUidx
        LlDDX3cQNP+a9VgGSgtkiFZDKkjQbT6hIxeSfwq/CVs3SP8pQ2JvPPaxzzXEabLen4qnXS4uEiRtt
        88JG6tUA==;
Received: from [187.36.234.139] (helo=[192.168.1.195])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1pDsi4-0018xr-Hg; Fri, 06 Jan 2023 20:49:00 +0100
Message-ID: <ea2367c5-a850-f62c-6baf-e7529c1c84ae@igalia.com>
Date:   Fri, 6 Jan 2023 16:48:50 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 2/9] drm/gud: use new debugfs device-centered functions
Content-Language: en-US
To:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     Melissa Wen <mwen@igalia.com>,
        =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@igalia.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        etnaviv@lists.freedesktop.org, noralf@tronnes.org,
        Liviu Dudau <liviu.dudau@arm.com>,
        Brian Starkey <brian.starkey@arm.com>,
        Emma Anholt <emma@anholt.net>,
        Alexey Brodkin <abrodkin@synopsys.com>,
        David Airlie <airlied@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>,
        Tomi Valkeinen <tomba@kernel.org>
References: <20221226155029.244355-1-mcanal@igalia.com>
 <20221226155029.244355-3-mcanal@igalia.com>
From:   =?UTF-8?Q?Ma=c3=adra_Canal?= <mcanal@igalia.com>
In-Reply-To: <20221226155029.244355-3-mcanal@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/26/22 12:50, Maíra Canal wrote:
> Replace the use of drm_debugfs_create_files() with the new
> drm_debugfs_add_file() function, which center the debugfs files
> management on the drm_device instead of drm_minor. Moreover, remove the
> debugfs_init hook and add the debugfs files directly on gud_probe(),
> before drm_dev_register().
> 
> Signed-off-by: Maíra Canal <mcanal@igalia.com>

Applied to drm/drm-misc (drm-misc-next).

Best Regards,
- Maíra Canal

> ---
>   drivers/gpu/drm/gud/gud_drv.c | 17 ++++-------------
>   1 file changed, 4 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/gpu/drm/gud/gud_drv.c b/drivers/gpu/drm/gud/gud_drv.c
> index 5aac7cda0505..9d7bf8ee45f1 100644
> --- a/drivers/gpu/drm/gud/gud_drv.c
> +++ b/drivers/gpu/drm/gud/gud_drv.c
> @@ -325,8 +325,8 @@ static struct drm_gem_object *gud_gem_prime_import(struct drm_device *drm, struc
>   
>   static int gud_stats_debugfs(struct seq_file *m, void *data)
>   {
> -	struct drm_info_node *node = m->private;
> -	struct gud_device *gdrm = to_gud_device(node->minor->dev);
> +	struct drm_debugfs_entry *entry = m->private;
> +	struct gud_device *gdrm = to_gud_device(entry->dev);
>   	char buf[10];
>   
>   	string_get_size(gdrm->bulk_len, 1, STRING_UNITS_2, buf, sizeof(buf));
> @@ -352,16 +352,6 @@ static int gud_stats_debugfs(struct seq_file *m, void *data)
>   	return 0;
>   }
>   
> -static const struct drm_info_list gud_debugfs_list[] = {
> -	{ "stats", gud_stats_debugfs, 0, NULL },
> -};
> -
> -static void gud_debugfs_init(struct drm_minor *minor)
> -{
> -	drm_debugfs_create_files(gud_debugfs_list, ARRAY_SIZE(gud_debugfs_list),
> -				 minor->debugfs_root, minor);
> -}
> -
>   static const struct drm_simple_display_pipe_funcs gud_pipe_funcs = {
>   	.check      = gud_pipe_check,
>   	.update	    = gud_pipe_update,
> @@ -386,7 +376,6 @@ static const struct drm_driver gud_drm_driver = {
>   	.fops			= &gud_fops,
>   	DRM_GEM_SHMEM_DRIVER_OPS,
>   	.gem_prime_import	= gud_gem_prime_import,
> -	.debugfs_init		= gud_debugfs_init,
>   
>   	.name			= "gud",
>   	.desc			= "Generic USB Display",
> @@ -623,6 +612,8 @@ static int gud_probe(struct usb_interface *intf, const struct usb_device_id *id)
>   	if (!gdrm->dmadev)
>   		dev_warn(dev, "buffer sharing not supported");
>   
> +	drm_debugfs_add_file(drm, "stats", gud_stats_debugfs, NULL);
> +
>   	ret = drm_dev_register(drm, 0);
>   	if (ret) {
>   		put_device(gdrm->dmadev);
