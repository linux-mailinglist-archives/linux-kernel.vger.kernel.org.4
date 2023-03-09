Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D1DD6B1E9A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 09:50:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbjCIIuP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 03:50:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbjCIIuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 03:50:11 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 057C07585F
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 00:49:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678351770;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6XxVpP4I6etF/R+Wh1vjQAaCt3ds5sZTWni+6rnd9Rk=;
        b=Vu87T3/03oazpXX7sgSKbXPsDGczcg7/cuIhGdyt/v0WCruAni8Jf99BJeOOE3tHESe61d
        D/NkUtugKGUnVFm0Vf8x2DgYdjm4XHcNhi8qTD7bDlKCACPRIykMU+Hyg8Z924GzmDy5Vm
        WWhDyF8Gc0rr+PsfzG/gVLLvhikaFPc=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-266-UADC2uOQOUejat3iSZck2g-1; Thu, 09 Mar 2023 03:49:29 -0500
X-MC-Unique: UADC2uOQOUejat3iSZck2g-1
Received: by mail-qv1-f69.google.com with SMTP id pm17-20020ad446d1000000b0057256b237b9so852345qvb.16
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 00:49:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678351768;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6XxVpP4I6etF/R+Wh1vjQAaCt3ds5sZTWni+6rnd9Rk=;
        b=hFXn9CScxzAqZuURwZvl7aTmdjXOieA/iowKnfZ8txltRD4liqYA4ltl9ulPPtD97p
         EKwUAWIUOTayp3hZlbf5oZe5cNC3SICHhfHHI+llN1Jlt9pxStud5bx7m2gafvdG7c4r
         WKZumU0rmONMUFc70dVzVftMc+D5r5CtMzpZkbDQSTPH2zXK08BiOhUFL3YyRTPL+nV4
         OWyoLqNfbG5Fiv2UJDnRkbT1qsnpLghD3ZdxP0Mc8hjEl7WdyUun3GQ+lnPEigKOzA9v
         hGefBLc83HZvvea/OMgKCyhUBdbIddQXc+tcpvSed1c1J1sAJ9jp1tePqu9k9mwCmiUJ
         ThWA==
X-Gm-Message-State: AO0yUKWyc7H+870ugHOjY3r2ExPpgFSPJJpkd5WAqtLXnGuMEpYooC/t
        xGjhVSKLQw9q875yf3jOCoSwyUN9GYY4W0QHe3tlNZQG/HnozlqWCMDsh/LUXLuO41V391KgCfq
        JhQrZ0r7K9/7mOrJzKu2dzqD4
X-Received: by 2002:a05:6214:2681:b0:56e:a9c6:d2c6 with SMTP id gm1-20020a056214268100b0056ea9c6d2c6mr36835531qvb.6.1678351768659;
        Thu, 09 Mar 2023 00:49:28 -0800 (PST)
X-Google-Smtp-Source: AK7set/thTK4EUAQWBzgsfLcQMoo2cMp3slVR0A8J9Dzj1kqFjwA7/OGlmJSuV6MuuTmFXXxDQbdYw==
X-Received: by 2002:a05:6214:2681:b0:56e:a9c6:d2c6 with SMTP id gm1-20020a056214268100b0056ea9c6d2c6mr36835518qvb.6.1678351768410;
        Thu, 09 Mar 2023 00:49:28 -0800 (PST)
Received: from sgarzare-redhat (host-82-57-51-170.retail.telecomitalia.it. [82.57.51.170])
        by smtp.gmail.com with ESMTPSA id 29-20020a05620a041d00b0073b8745fd39sm4523932qkp.110.2023.03.09.00.49.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 00:49:27 -0800 (PST)
Date:   Thu, 9 Mar 2023 09:49:20 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Rong Tao <rtoax@foxmail.com>
Cc:     Rong Tao <rongtao@cestc.cn>, "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "open list:VIRTIO CORE AND NET DRIVERS" 
        <virtualization@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] tools/virtio: virtio_test -h,--help should return
 directly
Message-ID: <20230309084920.oj66qnighnnyet3f@sgarzare-redhat>
References: <tencent_822CEBEB925205EA1573541CD1C2604F4805@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <tencent_822CEBEB925205EA1573541CD1C2604F4805@qq.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 09, 2023 at 04:42:50PM +0800, Rong Tao wrote:
>From: Rong Tao <rongtao@cestc.cn>
>
>When we get help information, we should return directly, and we should not
>execute test cases. Move the exit() directly into the help() function and
>remove it from case '?'.
>
>Signed-off-by: Rong Tao <rongtao@cestc.cn>
>---
>v2: help(): exit with a value different from 0 (e.g. 2).
>v1: https://lore.kernel.org/lkml/tencent_4B5122C4158323A1D1ACA04B3295F1579207@qq.com/
>---
> tools/virtio/virtio_test.c | 10 +++++-----
> 1 file changed, 5 insertions(+), 5 deletions(-)
>
>diff --git a/tools/virtio/virtio_test.c b/tools/virtio/virtio_test.c
>index 120062f94590..33e17307441f 100644
>--- a/tools/virtio/virtio_test.c
>+++ b/tools/virtio/virtio_test.c
>@@ -327,7 +327,7 @@ const struct option longopts[] = {
> 	}
> };
>
>-static void help(void)
>+static void help(int status)
> {
> 	fprintf(stderr, "Usage: virtio_test [--help]"
> 		" [--no-indirect]"
>@@ -337,6 +337,8 @@ static void help(void)
> 		" [--batch=random/N]"
> 		" [--reset=N]"
> 		"\n");
>+
>+	exit(status);

Sorry, I meant you can put exit(2) here, and remove the `int status` 
parameter of help().

> }
>
> int main(int argc, char **argv)
>@@ -354,14 +356,12 @@ int main(int argc, char **argv)
> 		case -1:
> 			goto done;
> 		case '?':
>-			help();
>-			exit(2);
>+			help(2);

Here you can use help()

> 		case 'e':
> 			features &= ~(1ULL << VIRTIO_RING_F_EVENT_IDX);
> 			break;
> 		case 'h':
>-			help();
>-			goto done;
>+			help(0);

And also here you can use help()

I'm sure you're learning the process, so as a suggestion for the future,
if some thing is not clear, better to ask before sending another
version.

Thanks,
Stefano

> 		case 'i':
> 			features &= ~(1ULL << 
> 			VIRTIO_RING_F_INDIRECT_DESC);
> 			break;
>-- 
>2.39.1
>

