Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA0E16891B6
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 09:11:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232583AbjBCILc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 03:11:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232614AbjBCIKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 03:10:55 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27A651B33B
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 00:09:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675411756;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=I4jp0pd7nTd2IokMgM4q5yjP1Mu7SicarJFLgTsenx8=;
        b=cyR9ZTZMX5b5nV3kfVbn975xvzyDBfW7FILuHvzRN8vSOdYtQA/S+vFZRg7ye12dPP6Xq5
        W1HRLZ6Io/MmBHGIhnOgOpmLok1rcNaquJBXJ9h3p9wYTGhi9S7qFJ0tyn+bgCdnbfikpm
        5gOsgiwJx+rBteEdbk5FVzGVQxSmYgo=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-60-uYMiU6X7Oumt7hipgrYmTw-1; Fri, 03 Feb 2023 03:09:14 -0500
X-MC-Unique: uYMiU6X7Oumt7hipgrYmTw-1
Received: by mail-ed1-f69.google.com with SMTP id n17-20020a056402061100b004a3f32cc366so3083063edv.20
        for <linux-kernel@vger.kernel.org>; Fri, 03 Feb 2023 00:09:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I4jp0pd7nTd2IokMgM4q5yjP1Mu7SicarJFLgTsenx8=;
        b=VBlm3FHBvi1AnjJveVFXZOay2hgA03pe30Qt2F2mj7fhB6/bjkNP1s6gsfy3YLkQvO
         c7bLAMBNgiCybNiX2YVyziY2IOD8XZ+5eE3PRf4ft46o7AoFLCMUnnW+xzFvL8U9Hnv6
         ujleiznvuv+x0K2R+PpWxYZjEh0L+p9N5l95VdmwJ66Cw3Xz3s5JcG07S/yYh9cISOfF
         4yJEymSwFJ1tXLCbW2CB2AtWMUSYkRxSt5soUWOaT8V1eET0mQwYjsMyNMsSt4DXZcvv
         3IdRlQBzsB7cRAh9wJX1N1liyMRw7fSXaI0W3cCag2e8xjVy8SnJKKHzxFOsyLf8QmfR
         D1cg==
X-Gm-Message-State: AO0yUKXAUdqsgbHRxFJXt/xsnyIWCuBB3f0h5g1FdRS9Jh9HNNc9sg/i
        UMwyzb8pmXJb9E4ZQVkls8Tu+usRcbUB9vsSjoS1EUjC5M9U6s361tCCwFz/jg0c+rKtGc53EZX
        /YKA67TgH6ojQBFMu6yo+kaB8
X-Received: by 2002:aa7:d84d:0:b0:49c:96f9:417e with SMTP id f13-20020aa7d84d000000b0049c96f9417emr9623170eds.2.1675411753298;
        Fri, 03 Feb 2023 00:09:13 -0800 (PST)
X-Google-Smtp-Source: AK7set+Fq1e3LQCYUMQ4JqNsvVTMReZl/rmJ4045vTiSRljk5PQQqakOY3FlB8VmZndAcRaI3SwG4Q==
X-Received: by 2002:aa7:d84d:0:b0:49c:96f9:417e with SMTP id f13-20020aa7d84d000000b0049c96f9417emr9623159eds.2.1675411753050;
        Fri, 03 Feb 2023 00:09:13 -0800 (PST)
Received: from redhat.com ([2.52.156.122])
        by smtp.gmail.com with ESMTPSA id cn13-20020a0564020cad00b0049eea46c909sm744733edb.37.2023.02.03.00.09.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 00:09:12 -0800 (PST)
Date:   Fri, 3 Feb 2023 03:09:08 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Si-Wei Liu <si-wei.liu@oracle.com>
Cc:     jasowang@redhat.com, parav@nvidia.com, elic@nvidia.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/7] vdpa: validate device feature provisioning
 against supported class
Message-ID: <20230203025523-mutt-send-email-mst@kernel.org>
References: <1675207345-22328-1-git-send-email-si-wei.liu@oracle.com>
 <1675207345-22328-6-git-send-email-si-wei.liu@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1675207345-22328-6-git-send-email-si-wei.liu@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 31, 2023 at 03:22:23PM -0800, Si-Wei Liu wrote:
> Today when device features are explicitly provisioned, the features
> user supplied may contain device class specific features that are
> not supported by the parent managment device. On the other hand,
> when parent managment device supports more than one class, the
> device features to provision may be ambiguous if none of the class
> specific attributes is provided at the same time. Validate these
> cases and prompt appropriate user errors accordingly.
> 
> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
> ---
>  drivers/vdpa/vdpa.c | 51 ++++++++++++++++++++++++++++++++++++++++++---------
>  1 file changed, 42 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> index 1eba978..35a72d6 100644
> --- a/drivers/vdpa/vdpa.c
> +++ b/drivers/vdpa/vdpa.c
> @@ -460,12 +460,30 @@ static int vdpa_nl_mgmtdev_handle_fill(struct sk_buff *msg, const struct vdpa_mg
>  	return 0;
>  }
>  
> +static u64 vdpa_mgmtdev_get_classes(const struct vdpa_mgmt_dev *mdev,
> +				    unsigned int *nclasses)

given max value is apparently 64 how important is it that it's unsigned?
Just make it an int.

Also I'd return u64 through a pointer too for consistency.

> +{
> +	u64 supported_classes = 0;
> +	unsigned int n = 0;
> +	int i = 0;
> +
> +	while (mdev->id_table[i].device) {
> +		if (mdev->id_table[i].device <= 63) {
> +			supported_classes |= BIT_ULL(mdev->id_table[i].device);
> +			n++;
> +		}
> +		i++;
> +	}


Better as a for loop. I know you are just moving code if you
want to make it very clear it's a refactoring split
as a separate patch, but ok anyway.

> +	if (nclasses)
> +		*nclasses = n;
> +
> +	return supported_classes;
> +}
> +
>  static int vdpa_mgmtdev_fill(const struct vdpa_mgmt_dev *mdev, struct sk_buff *msg,
>  			     u32 portid, u32 seq, int flags)
>  {
> -	u64 supported_classes = 0;
>  	void *hdr;
> -	int i = 0;
>  	int err;
>  
>  	hdr = genlmsg_put(msg, portid, seq, &vdpa_nl_family, flags, VDPA_CMD_MGMTDEV_NEW);
> @@ -475,14 +493,9 @@ static int vdpa_mgmtdev_fill(const struct vdpa_mgmt_dev *mdev, struct sk_buff *m
>  	if (err)
>  		goto msg_err;
>  
> -	while (mdev->id_table[i].device) {
> -		if (mdev->id_table[i].device <= 63)
> -			supported_classes |= BIT_ULL(mdev->id_table[i].device);
> -		i++;
> -	}
> -
>  	if (nla_put_u64_64bit(msg, VDPA_ATTR_MGMTDEV_SUPPORTED_CLASSES,
> -			      supported_classes, VDPA_ATTR_UNSPEC)) {
> +			      vdpa_mgmtdev_get_classes(mdev, NULL),
> +			      VDPA_ATTR_UNSPEC)) {
>  		err = -EMSGSIZE;
>  		goto msg_err;
>  	}
> @@ -571,8 +584,10 @@ static int vdpa_nl_cmd_dev_add_set_doit(struct sk_buff *skb, struct genl_info *i
>  	struct vdpa_dev_set_config config = {};
>  	struct nlattr **nl_attrs = info->attrs;
>  	struct vdpa_mgmt_dev *mdev;
> +	unsigned int ncls = 0;
>  	const u8 *macaddr;
>  	const char *name;
> +	u64 classes;
>  	int err = 0;
>  
>  	if (!info->attrs[VDPA_ATTR_DEV_NAME])
> @@ -649,6 +664,24 @@ static int vdpa_nl_cmd_dev_add_set_doit(struct sk_buff *skb, struct genl_info *i
>  		goto err;
>  	}
>  
> +	classes = vdpa_mgmtdev_get_classes(mdev, &ncls);
> +	if (config.mask & VDPA_DEV_NET_ATTRS_MASK &&
> +	    !(classes & BIT_ULL(VIRTIO_ID_NET))) {
> +		NL_SET_ERR_MSG_MOD(info->extack,
> +				   "Network class attributes provided on unsupported management device");
> +		err = -EINVAL;
> +		goto err;
> +	}
> +	if (!(config.mask & VDPA_DEV_NET_ATTRS_MASK) &&
> +	    config.mask & BIT_ULL(VDPA_ATTR_DEV_FEATURES) &&
> +	    classes & BIT_ULL(VIRTIO_ID_NET) && ncls > 1 &&
> +	    config.device_features & VIRTIO_DEVICE_F_MASK) {
> +		NL_SET_ERR_MSG_MOD(info->extack,
> +				   "Management device supports multi-class while device features specified are ambiguous");
> +		err = -EINVAL;
> +		goto err;
> +	}
> +
>  	err = mdev->ops->dev_add(mdev, name, &config);
>  err:
>  	up_write(&vdpa_dev_lock);
> -- 
> 1.8.3.1

