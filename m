Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 547B26E1785
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 00:35:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbjDMWfj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 18:35:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjDMWfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 18:35:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 790A68A72
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 15:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681425220;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kj3FArPvDua1fzACXV/qcxXxJ2Rz3bhS2RrVgGGgTfY=;
        b=NDElARQ7Ebn0pznZOGyYIeTp2aJ/K3f7dM4uK2x9lk0Fh1lvtH/0bz5fYmyPJGor74GKzd
        5ttyQlFOSOj8FeZFHXEvm4JiETVBeNlOLdkRXlrcVSthALjDsd+6H6GDn9MHTpiKvQox9d
        P0Elj5RNwkJJr9vz5Jf5nODsA2JIsOs=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-125-hJlu3rELNw2v8bQENKXbvQ-1; Thu, 13 Apr 2023 18:33:39 -0400
X-MC-Unique: hJlu3rELNw2v8bQENKXbvQ-1
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-32a03cacb86so3421235ab.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 15:33:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681425218; x=1684017218;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kj3FArPvDua1fzACXV/qcxXxJ2Rz3bhS2RrVgGGgTfY=;
        b=QWM55r39Q5QCMuhzBpTUxWmTigGDZOADFhJ0aR7Xc+JoHmf4SZveODrdpUOz7rAsgJ
         3VCc/fxW5aheLc7E6g5HfjcUKZY+frxZaZEH6ar/7hE7hLRK27mBCCxP0PcgzFsk++eK
         npsSyfJQpuhsFh9M6qgMV2cH++E2wQRDX8d5tRazn3/kyvvDzmB5oM7cgQ90zYD8DYxV
         FjEELCec8ucfmJ6yO4wyHq0qFzO8EH0Il+Gkexd/IMRCwmks0Y7wol/0K5TFha4ltE+s
         p8SLcR9z5Xnps5TMJlJ3eUqncd6xkWCmOLbaDUBLDbWk5YHBsQmM4DzC3q9DQu1AUY0g
         9bkQ==
X-Gm-Message-State: AAQBX9elbzc0FbJiSKvzIUrReLEhDEscU3m/KMhAjCN0jwWkzaENyaC9
        08wriwro6JhRLvEiQlk25Ib/YCVKQSNCMMmq2e5Pk6VP3ds2Q1dfoKOJClNJWww8+tqwrtK9X+g
        hOR6HEmnHm08CvJoibZDYZMfd
X-Received: by 2002:a05:6e02:110:b0:316:dcfd:1b6e with SMTP id t16-20020a056e02011000b00316dcfd1b6emr2356914ilm.30.1681425218498;
        Thu, 13 Apr 2023 15:33:38 -0700 (PDT)
X-Google-Smtp-Source: AKy350aW54nFomY+2phshGuCm1AzmqhZrTVLEIz9kKnWdncxODMmpUU/yCYW3ZAvdT4Kl7Fv16a+IQ==
X-Received: by 2002:a05:6e02:110:b0:316:dcfd:1b6e with SMTP id t16-20020a056e02011000b00316dcfd1b6emr2356903ilm.30.1681425218185;
        Thu, 13 Apr 2023 15:33:38 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id c20-20020a023f54000000b0040bcac59412sm775980jaf.150.2023.04.13.15.33.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 15:33:37 -0700 (PDT)
Date:   Thu, 13 Apr 2023 16:33:36 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Yi Liu <yi.l.liu@intel.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the vfio tree
Message-ID: <20230413163336.7ce6ecec.alex.williamson@redhat.com>
In-Reply-To: <20230412143229.0c379a7f@canb.auug.org.au>
References: <20230412143229.0c379a7f@canb.auug.org.au>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Apr 2023 14:32:29 +1000
Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> Hi all,
> 
> After merging the vfio tree, today's linux-next build (htmldocs) produced
> this warning:
> 
> Documentation/virt/kvm/devices/vfio.rst:45: WARNING: Literal block expected; none found.
> 
> Introduced by commit
> 
>   25e1b301a946 ("docs: kvm: vfio: Suggest KVM_DEV_VFIO_GROUP_ADD vs VFIO_GROUP_GET_DEVICE_FD ordering")
> 

Thanks, Stephen!

Hi Yi,

Clearly this comes from:

diff --git a/Documentation/virt/kvm/devices/vfio.rst b/Documentation/virt/kvm/devices/vfio.rst
index 2d20dc561069..79b6811bb4f3 100644
--- a/Documentation/virt/kvm/devices/vfio.rst
+++ b/Documentation/virt/kvm/devices/vfio.rst
@@ -39,3 +39,10 @@ KVM_DEV_VFIO_GROUP attributes:
        - @groupfd is a file descriptor for a VFIO group;
        - @tablefd is a file descriptor for a TCE table allocated via
          KVM_CREATE_SPAPR_TCE.
+
+::
+
+The GROUP_ADD operation above should be invoked prior to accessing the
+device file descriptor via VFIO_GROUP_GET_DEVICE_FD in order to support
+drivers which require a kvm pointer to be set in their .open_device()
+callback.

Were you looking for this paragraph to be formatted like an
implementation note in a similar way to a block quote, for example:

https://docs.kernel.org/process/2.Process.html#getting-started-with-kernel-development

We need tabs preceding each line to get that effect.

If there's no objection, I'll just fix the original commit with that
change given how little is currently in my next branch.  Thanks,

Alex

