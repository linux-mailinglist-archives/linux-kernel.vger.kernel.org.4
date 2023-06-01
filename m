Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4C7471A38D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 18:00:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234388AbjFAP7p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 11:59:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234474AbjFAP7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 11:59:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF38AF2
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 08:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685635134;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ol2VrA3MBxjSHCAQgCh55CsBJm+rZHfsDaePIVKvX14=;
        b=NrureafwFph1REpvtnxBnYaIgbFXcgh3QsbXLrkls/o52j4+mms1wLyQJRFMVINxJ7hW3v
        9EbnhF8xXAfVMbbQ0LX3/uSKnYp9DiISExCJ1TkTVieQWvuSAj8hdSpE4v58kqLhZzpMZD
        B4gM9FZnlm6R4tnCmJTDnylXW+q+p8M=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-325-JINIGgWkMoKvV_Fhqb1qdQ-1; Thu, 01 Jun 2023 11:58:53 -0400
X-MC-Unique: JINIGgWkMoKvV_Fhqb1qdQ-1
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-38bedafc58dso807913b6e.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 08:58:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685635133; x=1688227133;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ol2VrA3MBxjSHCAQgCh55CsBJm+rZHfsDaePIVKvX14=;
        b=J46YOvjnQR+05mGXuEuvL9/vBw9FdBBUO2C4ZNIQK7iXh4WevHKztzQ0u46F4Hu4A4
         868SZrNh4Eo86pC+x71YWnXTc3mnfMFqgHorT9IlmyLIJyx0B8JCH2wa0v7h1wdDanW/
         xtKzHZSDEHp/rVJ4Cg0kN0C6apD4x9pknq0qTToQUjNwlm8lVzNvKjaPgiXWOT5gy/p3
         /EruWF6s1KbyVx8eZ8NMtCufpnpEEjOFrox4XPHppv3mDPWAn7i71PWu79UjBCvULVwE
         6qlcLM9xaZ9JUA/q9Z1IWL5s0xPphfoeDvfa+ZmxCQk9MkXjdHePEPkeq2eXiOgrfYly
         mBXQ==
X-Gm-Message-State: AC+VfDznXE7Q0jxMeyYZVxv8vKD0mXCe4mSyAVzlfTcUgTDNp8lF3pik
        cKdzKRRNwVme9lDbG4SuveYZQxaxAT4DMGsLzRgBEtsUMWCwp9wmF3rjcokIqyTpt0j4Rcj8Ard
        8RzZdyrSypL00Cf4kJ2q056sGMiVM2do=
X-Received: by 2002:a05:6808:1526:b0:394:41e7:5719 with SMTP id u38-20020a056808152600b0039441e75719mr9088570oiw.40.1685635132989;
        Thu, 01 Jun 2023 08:58:52 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4o53SioLIxrQWbrVVF62wXGz1rBcPOl9Niil0Fjck0toG1YH6XCucHTghz0cHYxCDg9CGKLg==
X-Received: by 2002:a05:6808:1526:b0:394:41e7:5719 with SMTP id u38-20020a056808152600b0039441e75719mr9088558oiw.40.1685635132757;
        Thu, 01 Jun 2023 08:58:52 -0700 (PDT)
Received: from [192.168.9.16] (net-2-34-28-169.cust.vodafonedsl.it. [2.34.28.169])
        by smtp.gmail.com with ESMTPSA id v10-20020a0cf90a000000b0062627f71b07sm4446227qvn.125.2023.06.01.08.58.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jun 2023 08:58:52 -0700 (PDT)
Message-ID: <3475be3b-11d5-96fe-6bc4-26d0e3a270df@redhat.com>
Date:   Thu, 1 Jun 2023 17:58:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] accel/ivpu: Use struct_size()
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
        Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>,
        Oded Gabbay <ogabbay@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        dri-devel@lists.freedesktop.org
References: <0ae53be873c27c9a8740c4fe6d8e7cd1b1224994.1685366864.git.christophe.jaillet@wanadoo.fr>
Content-Language: en-US
From:   Marco Pagani <marpagan@redhat.com>
In-Reply-To: <0ae53be873c27c9a8740c4fe6d8e7cd1b1224994.1685366864.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023-05-29 15:28, Christophe JAILLET wrote:
> Use struct_size() instead of hand-writing it. It is less verbose, more
> robust and more informative.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Reviewed-by: Marco Pagani <marpagan@redhat.com>

> ---
>  drivers/accel/ivpu/ivpu_job.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/accel/ivpu/ivpu_job.c b/drivers/accel/ivpu/ivpu_job.c
> index 3c6f1e16cf2f..0a09bba8da24 100644
> --- a/drivers/accel/ivpu/ivpu_job.c
> +++ b/drivers/accel/ivpu/ivpu_job.c
> @@ -289,15 +289,13 @@ ivpu_create_job(struct ivpu_file_priv *file_priv, u32 engine_idx, u32 bo_count)
>  {
>  	struct ivpu_device *vdev = file_priv->vdev;
>  	struct ivpu_job *job;
> -	size_t buf_size;
>  	int ret;
>  
>  	ret = ivpu_rpm_get(vdev);
>  	if (ret < 0)
>  		return NULL;
>  
> -	buf_size = sizeof(*job) + bo_count * sizeof(struct ivpu_bo *);
> -	job = kzalloc(buf_size, GFP_KERNEL);
> +	job = kzalloc(struct_size(job, bos, bo_count), GFP_KERNEL);
>  	if (!job)
>  		goto err_rpm_put;
>  

