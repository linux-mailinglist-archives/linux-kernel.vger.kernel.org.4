Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 132275FABFD
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 07:46:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbiJKFqB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 01:46:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiJKFp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 01:45:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE58F4D15C
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 22:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665467156;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mDLip3zeejmnkhQb+7KaEyxp3L0KOSICdhVmdqjYG3k=;
        b=MGlF0dqT33/Rr3VrOm1Rkux/ifisCHdo2aAZJRCxZyGOU8l9HktYnKIdngMrejBxB1krQM
        x2VY+quty/jHSLBjvsgoef/923diMf6cWr3KxGG+r5Xup9jkrp4nj2WxZHEXhAL/uSLOSO
        K2ui3KgLfvcPDDFvs3EfM9W+mXukBsQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-163-OgahoQadP1OS0h1KxdBUYg-1; Tue, 11 Oct 2022 01:45:52 -0400
X-MC-Unique: OgahoQadP1OS0h1KxdBUYg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1CB6F185A794;
        Tue, 11 Oct 2022 05:45:52 +0000 (UTC)
Received: from niphredil.zaitcev.lan (unknown [10.2.17.221])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 85A2DA37D0;
        Tue, 11 Oct 2022 05:45:51 +0000 (UTC)
Date:   Tue, 11 Oct 2022 00:45:50 -0500
From:   Pete Zaitcev <zaitcev@redhat.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Juergen Stuber <starblue@users.sourceforge.net>,
        Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH] USB: make devnode() callback in usb_class_driver take a
 const *
Message-ID: <20221011004550.46e068f5@niphredil.zaitcev.lan>
In-Reply-To: <20221001165128.2688526-1-gregkh@linuxfoundation.org>
References: <20221001165128.2688526-1-gregkh@linuxfoundation.org>
Organization: Red Hat, Inc.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat,  1 Oct 2022 18:51:28 +0200
Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> +++ b/drivers/usb/class/usblp.c
> @@ -1090,7 +1090,7 @@ static const struct file_operations usblp_fops = {
> -static char *usblp_devnode(struct device *dev, umode_t *mode)
> +static char *usblp_devnode(const struct device *dev, umode_t *mode)
>  {
>  	return kasprintf(GFP_KERNEL, "usb/%s", dev_name(dev));
>  }

Seems obvious.

Acked-by: Pete Zaitcev <zaitcev@redhat.com>

-- P

