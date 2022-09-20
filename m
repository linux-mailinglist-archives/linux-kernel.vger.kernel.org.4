Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EB485BEB24
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 18:34:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230461AbiITQew (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 12:34:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbiITQet (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 12:34:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 367942A277
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 09:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663691687;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UK0OJHH8BuaTkCT0IEgj47LH/eYbv+0rHs1llpCQhRA=;
        b=G1o6qJ/b3BxIcv+0kxgXEr+tckF/kZfHLEZzfQXyxIFCe76B7O4wSvjBRxndsomgZyP2Uh
        6PyBAPzVh60ku6gshEyM/lLbLD5WAv4EEzRs76sdYMOp6by1pq9UPanAZMipHU4a5aI//I
        aD0DvarBs6GmkEbAZv5ugy76D++0HPw=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-307-QfRruHn5NFufVDR44vrKpQ-1; Tue, 20 Sep 2022 12:34:45 -0400
X-MC-Unique: QfRruHn5NFufVDR44vrKpQ-1
Received: by mail-il1-f197.google.com with SMTP id x14-20020a056e021cae00b002f1d5aca8c6so1901537ill.5
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 09:34:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date;
        bh=UK0OJHH8BuaTkCT0IEgj47LH/eYbv+0rHs1llpCQhRA=;
        b=GH3kgyeicp+4QYfD0UHUTGpW6dutk8M7S2TJ2/jIsTXfyVAxsLxr4TLiONycynYyG0
         TLWKefys8fIb+ytHKol5AEptE2Hr7nD11Cao8K2XYt7TRcS1D0BG5au+/rSoOylFIvau
         /4Str6mT34org02bflUc4piRhzggNbCuK0SQOieXgjPkxirzayykQIz0DKKWODaal2TI
         pxNhXA67ng3ZemhNmhcz/QfpgXpkdyqzwywA8uq4Nx8bwbX4dtm0awgnFHkZzIucV4vq
         AP40H31T8Coafx1ecnWrJid1nJlZ9EHq0TCRYx5zdfR5Gj9G739ugcYvpOrF1xZluKNw
         FapA==
X-Gm-Message-State: ACrzQf09Ln+C8W/jAeW0i1LuK0DNXguvGYRk3mHHxtrbun0rtPzbT3q9
        82zSocA7jP3w5VT9ISV3gcS41WB5QfEh9/pXDft1rSUvxm1/42GvhVd3jUMlG/75Yn1NBnSpofO
        mEmzuY/cM2RrR7KbCODwTPA9z
X-Received: by 2002:a05:6e02:1889:b0:2f5:19a6:2e6d with SMTP id o9-20020a056e02188900b002f519a62e6dmr8199224ilu.120.1663691685268;
        Tue, 20 Sep 2022 09:34:45 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6kV6YD7yBz1u3NW86FLjYFopeZecADum+9a/8SIU06IFoAiND0ZQ+ghe0Dzkgsl9NWbpy3uw==
X-Received: by 2002:a05:6e02:1889:b0:2f5:19a6:2e6d with SMTP id o9-20020a056e02188900b002f519a62e6dmr8199211ilu.120.1663691684991;
        Tue, 20 Sep 2022 09:34:44 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id k13-20020a02334d000000b0035672327fe5sm62256jak.149.2022.09.20.09.34.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 09:34:44 -0700 (PDT)
Date:   Tue, 20 Sep 2022 10:34:43 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Longfang Liu <liulongfang@huawei.com>
Cc:     <jgg@nvidia.com>, <shameerali.kolothum.thodi@huawei.com>,
        <cohuck@redhat.com>, <linux-kernel@vger.kernel.org>,
        <linuxarm@openeuler.org>
Subject: Re: [PATCH 1/5] hisi_acc_vfio_pci: Fixes a memory leak bug
Message-ID: <20220920103443.72654dd7.alex.williamson@redhat.com>
In-Reply-To: <20220915013157.60771-2-liulongfang@huawei.com>
References: <20220915013157.60771-1-liulongfang@huawei.com>
        <20220915013157.60771-2-liulongfang@huawei.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Sep 2022 09:31:53 +0800
Longfang Liu <liulongfang@huawei.com> wrote:

> During the stop copy phase of live migration, the driver allocates
> a memory for the migrated data to save the data.
> 
> When an exception occurs when the driver reads device data, the driver
> will report an error to qemu and exit the current migration state.
> But this memory is not released, which will lead to a memory
> leak problem.
> 
> So we need to add a memory release operation.
> 
> Reviewed-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> Signed-off-by: Longfang Liu <liulongfang@huawei.com>
> ---
>  drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
> index ea762e28c1cc..8fd68af2ed5f 100644
> --- a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
> +++ b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
> @@ -828,15 +828,15 @@ hisi_acc_vf_stop_copy(struct hisi_acc_vf_core_device *hisi_acc_vdev)
>  		return ERR_PTR(err);
>  	}
>  
> -	stream_open(migf->filp->f_inode, migf->filp);
> -	mutex_init(&migf->lock);
> -
>  	ret = vf_qm_state_save(hisi_acc_vdev, migf);
>  	if (ret) {
> -		fput(migf->filp);

Sorry, why did this fput() get removed?  Thanks,

Alex

> +		kfree(migf);
>  		return ERR_PTR(ret);
>  	}
>  
> +	stream_open(migf->filp->f_inode, migf->filp);
> +	mutex_init(&migf->lock);
> +
>  	return migf;
>  }
>  

