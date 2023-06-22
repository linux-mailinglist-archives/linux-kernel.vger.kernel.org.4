Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 686BC73A5F8
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 18:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230125AbjFVQVb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 12:21:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjFVQV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 12:21:29 -0400
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8039D1BF2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 09:20:43 -0700 (PDT)
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-3fde82c8ca7so58122121cf.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 09:20:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687450842; x=1690042842;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RU40QciyzSWhXtIKZMMI511TX+2RgRNyBLY22nx/h8U=;
        b=PtaiPK+R1j/uNvSJVCYqGHP9KLH/lDzoTyXbSktf5fIpLj+riAejObi1kVLz2XZ2VD
         RWXxP5wLjXsa8ytlX0K2ZHrojeB6XvTDIb7dHRb5FwzhAZxZFP3seGQewp21ydejTTJM
         3sKb+TcGNcjceXYfXT6fyYdYEUgtB/nt4kueK9I4vIsuE63Xc3wRSWt3iyEnXz6vGQsp
         OMi7vctFVqqVSCq+ST2bwncG4CK/mk0lwSG61WjoLrbn6HOcbuEtyldwMnyoQaAYWva+
         CxUSJNjg1fVPceUmuHcM8+rJymGv30Qv1rxYMBsT21TGZ3JsDJi8wEmfMjs7LytV9x4p
         t7Cw==
X-Gm-Message-State: AC+VfDzpB6DJDd0dOzfuOy+VNsmxgisZyYcN2iY7QeuYbsNX+k8GR2s7
        wknDaAH2YQBVf9qNtWa88/16WDbGI0Svm08dLA==
X-Google-Smtp-Source: ACHHUZ5ba9c/IqHgawcehKYSiGCA8K/yuVg3Qdf3Vi4r9PxUvm1bIlutOvIe+Bf2i7ztBErrtMPs3A==
X-Received: by 2002:a05:6214:501b:b0:62f:ec06:6c93 with SMTP id jo27-20020a056214501b00b0062fec066c93mr12465499qvb.51.1687450842632;
        Thu, 22 Jun 2023 09:20:42 -0700 (PDT)
Received: from localhost (pool-68-160-166-30.bstnma.fios.verizon.net. [68.160.166.30])
        by smtp.gmail.com with ESMTPSA id a14-20020a0cb34e000000b0062627f71b07sm3944698qvf.125.2023.06.22.09.20.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 09:20:41 -0700 (PDT)
Date:   Thu, 22 Jun 2023 12:20:40 -0400
From:   Mike Snitzer <snitzer@kernel.org>
To:     Demi Marie Obenour <demi@invisiblethingslab.com>
Cc:     Alasdair Kergon <agk@redhat.com>, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/6] device-mapper: Avoid double-fetch of version
Message-ID: <ZJR02A79ljoUjbFl@redhat.com>
References: <20230601212456.1533-1-demi@invisiblethingslab.com>
 <20230603145244.1538-1-demi@invisiblethingslab.com>
 <20230603145244.1538-5-demi@invisiblethingslab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230603145244.1538-5-demi@invisiblethingslab.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 03 2023 at 10:52P -0400,
Demi Marie Obenour <demi@invisiblethingslab.com> wrote:

> The version is fetched once in check_version(), which then does some
> validation and then overwrites the version in userspace with the API
> version supported by the kernel.  copy_params() then fetches the version
> from userspace *again*, and this time no validation is done.  The result
> is that the kernel's version number is completely controllable by
> userspace, provided that userspace can win a race condition.
> 
> Fix this flaw by not copying the version back to the kernel the second
> time.  This is not exploitable as the version is not further used in the
> kernel.  However, it could become a problem if future patches start
> relying on the version field.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Demi Marie Obenour <demi@invisiblethingslab.com>
> ---
>  drivers/md/dm-ioctl.c | 30 ++++++++++++++++++------------
>  1 file changed, 18 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/md/dm-ioctl.c b/drivers/md/dm-ioctl.c
> index da6ca26b51d0953df380582bb3a51c2ec22c27cb..7510afe237d979a5ee71afe87a20d49f631de1aa 100644
> --- a/drivers/md/dm-ioctl.c
> +++ b/drivers/md/dm-ioctl.c
> @@ -1873,30 +1873,33 @@ static ioctl_fn lookup_ioctl(unsigned int cmd, int *ioctl_flags)
>   * As well as checking the version compatibility this always
>   * copies the kernel interface version out.
>   */
> -static int check_version(unsigned int cmd, struct dm_ioctl __user *user)
> +static int check_version(unsigned int cmd, struct dm_ioctl __user *user,
> +			 struct dm_ioctl *kernel_params)
>  {
> -	uint32_t version[3];
>  	int r = 0;
>  
> -	if (copy_from_user(version, user->version, sizeof(version)))
> +	if (copy_from_user(kernel_params->version, user->version, sizeof(kernel_params->version)))
>  		return -EFAULT;
>  
> -	if ((version[0] != DM_VERSION_MAJOR) ||
> -	    (version[1] > DM_VERSION_MINOR)) {
> +	if ((kernel_params->version[0] != DM_VERSION_MAJOR) ||
> +	    (kernel_params->version[1] > DM_VERSION_MINOR)) {
>  		DMERR("ioctl interface mismatch: kernel(%u.%u.%u), user(%u.%u.%u), cmd(%d)",
>  		      DM_VERSION_MAJOR, DM_VERSION_MINOR,
>  		      DM_VERSION_PATCHLEVEL,
> -		      version[0], version[1], version[2], cmd);
> +		      kernel_params->version[0],
> +		      kernel_params->version[1],
> +		      kernel_params->version[2],
> +		      cmd);
>  		r = -EINVAL;
>  	}
>  
>  	/*
>  	 * Fill in the kernel version.
>  	 */
> -	version[0] = DM_VERSION_MAJOR;
> -	version[1] = DM_VERSION_MINOR;
> -	version[2] = DM_VERSION_PATCHLEVEL;
> -	if (copy_to_user(user->version, version, sizeof(version)))
> +	kernel_params->version[0] = DM_VERSION_MAJOR;
> +	kernel_params->version[1] = DM_VERSION_MINOR;
> +	kernel_params->version[2] = DM_VERSION_PATCHLEVEL;
> +	if (copy_to_user(user->version, kernel_params->version, sizeof(kernel_params->version)))
>  		return -EFAULT;
>  
>  	return r;
> @@ -1922,7 +1925,10 @@ static int copy_params(struct dm_ioctl __user *user, struct dm_ioctl *param_kern
>  	const size_t minimum_data_size = offsetof(struct dm_ioctl, data);
>  	unsigned int noio_flag;
>  
> -	if (copy_from_user(param_kernel, user, minimum_data_size))
> +	/* Version has been copied from userspace already, avoid TOCTOU */
> +	if (copy_from_user((char *)param_kernel + sizeof(param_kernel->version),
> +			   (char __user *)user + sizeof(param_kernel->version),
> +			   minimum_data_size - sizeof(param_kernel->version)))
>  		return -EFAULT;
>  
>  	if (param_kernel->data_size < minimum_data_size) {
> @@ -2034,7 +2040,7 @@ static int ctl_ioctl(struct file *file, uint command, struct dm_ioctl __user *us
>  	 * Check the interface version passed in.  This also
>  	 * writes out the kernel's interface version.
>  	 */
> -	r = check_version(cmd, user);
> +	r = check_version(cmd, user, &param_kernel);
>  	if (r)
>  		return r;
>  

I picked this patch up for 6.5, please see:
https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git/commit/?h=dm-6.5&id=c71878e9982075eab2e9f6dc5a09ba7b60ac1e24

But FYI, I folded these changes in:

diff --git a/drivers/md/dm-ioctl.c b/drivers/md/dm-ioctl.c
index 526464904fc1..b58a15e212a3 100644
--- a/drivers/md/dm-ioctl.c
+++ b/drivers/md/dm-ioctl.c
@@ -1838,6 +1838,9 @@ static int check_version(unsigned int cmd, struct dm_ioctl __user *user,
 {
 	int r = 0;
 
+	/* Make certain version is first member of dm_ioctl struct */
+	BUILD_BUG_ON(offsetof(struct dm_ioctl, version) != 0);
+
 	if (copy_from_user(kernel_params->version, user->version, sizeof(kernel_params->version)))
 		return -EFAULT;
 
@@ -1885,7 +1888,7 @@ static int copy_params(struct dm_ioctl __user *user, struct dm_ioctl *param_kern
 	const size_t minimum_data_size = offsetof(struct dm_ioctl, data);
 	unsigned int noio_flag;
 
-	/* Version has been copied from userspace already, avoid TOCTOU */
+	/* check_version() already copied version from userspace, avoid TOCTOU */
 	if (copy_from_user((char *)param_kernel + sizeof(param_kernel->version),
 			   (char __user *)user + sizeof(param_kernel->version),
 			   minimum_data_size - sizeof(param_kernel->version)))
