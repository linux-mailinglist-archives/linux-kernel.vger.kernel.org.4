Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66FB06DC66B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 13:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbjDJLuh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 07:50:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjDJLug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 07:50:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A099F5260
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 04:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681127385;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IdX9A2cTuLMGC5c/5nYygSYn711EAtAdcecz6KOLn0Q=;
        b=Dt2Iar/eJlJ9QE6fF+feuhkIK/5kk/NEmdhx5HIw84aod9q8Q26sOpz+HYEIrqwZQkioyH
        ND8wCxBSzog2jT0Rwjps6gj4wXJWWlLgXPLPIsAKGA+JX13NBdIC4NKqdXWadNK42+XLYA
        0X9WYMqnGTdd44lLp1rQEY0dH3IIgYE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-xTvGgPKENYO9LbxKvNkqAQ-1; Mon, 10 Apr 2023 07:49:44 -0400
X-MC-Unique: xTvGgPKENYO9LbxKvNkqAQ-1
Received: by mail-wr1-f69.google.com with SMTP id j6-20020adfa546000000b002d58b4b7698so625994wrb.19
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 04:49:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681127383;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IdX9A2cTuLMGC5c/5nYygSYn711EAtAdcecz6KOLn0Q=;
        b=2jK4STiggLJg5cYX7J9seHQsxpv9S3b/x2oPTyOx72abtjY5MwE6sGiVRDe7s2Y4Dm
         EupI3ev9OAx/C0LrQS7kpgqWA1YKlOyepqJyNZ8vVPtuYUjsC2hWhTTDRsWkbEJjcqyN
         CdF3rtqKs69J7JWhi4sLKgBJCrBWZKRsWkPxW9RfQyJz48BsT4KW7dII86pEJk+hul0E
         E2HAssLLeiXXCyCHRMlPYFHvBfWc+PGPV5KHb2LKnPZuIbPjX7BM9D7NOgCcIXKjx+yv
         ANxNEs3X0tQZ3XKrkXeKn5DD/IC7W5HqUdU5Qxch3KevqqCWv8S5YhKbYvq8umIZBM1X
         Dovg==
X-Gm-Message-State: AAQBX9dF/LO3Rj3f46QcMD/xguMpHGjXP57tU+bO/CvVxxW8ZJiWNGk4
        6iSLa+6djDQeHgWA9KZvyUPdJnJAm97ZZJ0YE4px5tWixh2/YHXKcnLd8kxFPP/kg9zqJWvy5Jw
        vzxFmfgzto4arufHeoDYj0VjH
X-Received: by 2002:a7b:c843:0:b0:3f0:7b28:e393 with SMTP id c3-20020a7bc843000000b003f07b28e393mr6286341wml.9.1681127383481;
        Mon, 10 Apr 2023 04:49:43 -0700 (PDT)
X-Google-Smtp-Source: AKy350aAtSETWgLgh29QKPfaPRkt+2l+8Yf8254jf8O+Oz84Y5///MBqKYZ+7beWIEv18R2u1KpZ3Q==
X-Received: by 2002:a7b:c843:0:b0:3f0:7b28:e393 with SMTP id c3-20020a7bc843000000b003f07b28e393mr6286327wml.9.1681127383211;
        Mon, 10 Apr 2023 04:49:43 -0700 (PDT)
Received: from redhat.com ([2.52.31.213])
        by smtp.gmail.com with ESMTPSA id i7-20020a05600c290700b003ee70225ed2sm13374390wmd.15.2023.04.10.04.49.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 04:49:42 -0700 (PDT)
Date:   Mon, 10 Apr 2023 07:49:38 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Shunsuke Mie <mie@igel.co.jp>
Cc:     Jason Wang <jasowang@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Stefano Garzarella <sgarzare@redhat.com>,
        Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v2 1/2] virtio_ring: add a struce device forward
 declaration
Message-ID: <20230410074929-mutt-send-email-mst@kernel.org>
References: <20230410112845.337212-1-mie@igel.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230410112845.337212-1-mie@igel.co.jp>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

s/struce/struct/ ?

On Mon, Apr 10, 2023 at 08:28:44PM +0900, Shunsuke Mie wrote:
> The virtio_ring header file uses the struct device without a forward
> declaration.
> 
> Signed-off-by: Shunsuke Mie <mie@igel.co.jp>
> ---
>  include/linux/virtio_ring.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/linux/virtio_ring.h b/include/linux/virtio_ring.h
> index 8b95b69ef694..77a9c2f52919 100644
> --- a/include/linux/virtio_ring.h
> +++ b/include/linux/virtio_ring.h
> @@ -58,6 +58,7 @@ do { \
>  
>  struct virtio_device;
>  struct virtqueue;
> +struct device;
>  
>  /*
>   * Creates a virtqueue and allocates the descriptor ring.  If
> -- 
> 2.25.1

