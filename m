Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A99B6A1D80
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 15:33:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbjBXOdP convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 24 Feb 2023 09:33:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbjBXOdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 09:33:13 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27548131
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 06:32:49 -0800 (PST)
Received: from hamburger.collabora.co.uk (hamburger.collabora.co.uk [IPv6:2a01:4f8:1c1c:f269::1])
        by madras.collabora.co.uk (Postfix) with ESMTP id 06CB26602FBB;
        Fri, 24 Feb 2023 14:32:47 +0000 (GMT)
From:   "Helen Mae Koike Fornazier" <koike@collabora.com>
In-Reply-To: <20230224140421.29774-1-david@ixit.cz>
Content-Type: text/plain; charset="utf-8"
X-Forward: 127.0.0.1
Date:   Fri, 24 Feb 2023 14:32:47 +0000
Cc:     dri-devel@lists.freedesktop.org,
        "Stefan Hajnoczi" <stefanha@redhat.com>,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        wsa+renesas@sang-engineering.com
To:     "David Heidelberg" <david@ixit.cz>
MIME-Version: 1.0
Message-ID: <2466-63f8ca80-15-200c5ec0@118513565>
Subject: =?utf-8?q?Re=3A?= [RESEND PATCH] =?utf-8?q?init/do=5Fmounts=2Ec=3A?= add 
 virtiofs root fs support
User-Agent: SOGoMail 5.8.0
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(from get_maintainers.pl script) +cc Wolfram Sang, Andrew Morton

On Friday, February 24, 2023 11:04 -03, David Heidelberg <david@ixit.cz> wrote:

> From: Stefan Hajnoczi <stefanha@redhat.com>
> 
> Make it possible to boot directly from a virtiofs file system with tag
> 'myfs' using the following kernel parameters:
> 
>   rootfstype=virtiofs root=myfs rw
> 
> Booting directly from virtiofs makes it possible to use a directory on
> the host as the root file system.  This is convenient for testing and
> situations where manipulating disk image files is cumbersome.
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: David Heidelberg <david@ixit.cz>

Reviewed-by: Helen Koike <helen.koike@collabora.com>

> ---

> We have used this option in Mesa3D CI for testing crosvm for
> more than one years and it's proven to work reliably.
> 
> We are working on effort to removing custom patches to be able to do 
> automated apply and test of patches from any tree.

Thanks David for this work, it would be awesome to have more automated tests, and if we can do
more towards this goal, making the whole process more fluid, I would go for it.
                              
> 
> https://gitlab.freedesktop.org/mesa/mesa/-/blob/main/.gitlab-ci/crosvm-runner.sh#L85
> 
>  init/do_mounts.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/init/do_mounts.c b/init/do_mounts.c
> index 811e94daf0a8..11c11abe23d7 100644
> --- a/init/do_mounts.c
> +++ b/init/do_mounts.c
> @@ -578,6 +578,16 @@ void __init mount_root(void)
>  			printk(KERN_ERR "VFS: Unable to mount root fs via SMB.\n");
>  		return;
>  	}
> +#endif
> +#ifdef CONFIG_VIRTIO_FS
> +	if (root_fs_names && !strcmp(root_fs_names, "virtiofs")) {
> +		if (!do_mount_root(root_device_name, "virtiofs",
> +				   root_mountflags, root_mount_data))
> +			return;
> +
> +		panic("VFS: Unable to mount root fs \"%s\" from virtiofs",
> +		      root_device_name);
> +	}
>  #endif
>  	if (ROOT_DEV == 0 && root_device_name && root_fs_names) {
>  		if (mount_nodev_root() == 0)
> -- 
> 2.39.1
> 

Regards,
Helen

