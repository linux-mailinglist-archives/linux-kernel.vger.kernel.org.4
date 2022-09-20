Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC6845BEE86
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 22:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbiITU0t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 16:26:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbiITU0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 16:26:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC2626FA08
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 13:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663705604;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kTuYdzoZrrSVtqbKAPsta2mJ6sY3BJrx+736wsbe0TI=;
        b=KqyzTmh2p+Fl4jAsI0AWT/yGcpPUF7RAgyzCI4x570HItzzMTp/aCdZjdDJoWkgjmtPkRd
        snqtvnCfqK6+rx6jiIt2SGD7POlbIHbdB0/4iZoYlz/XotGGXXWA29dFREgyu5z/ztTXa8
        o/gbCKHDgtPeGDc8w7yxLHKMQt5Nf3Y=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-538-OMw3qYPsNdu4xojdkzA0Ow-1; Tue, 20 Sep 2022 16:26:43 -0400
X-MC-Unique: OMw3qYPsNdu4xojdkzA0Ow-1
Received: by mail-io1-f70.google.com with SMTP id x22-20020a6bda16000000b006a123cb02beso2039660iob.18
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 13:26:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date;
        bh=kTuYdzoZrrSVtqbKAPsta2mJ6sY3BJrx+736wsbe0TI=;
        b=7LmpZVXlZT5gZd2uY8ypM5tbTCGlq5pURtXxzL/kHxlnrPpWlrBDmgRREivn12YWb9
         qVFxu7YXp73mRVg/nO9rWTplnP6KNn0bE+L8E8Im4t+h4IkkTv7vxUi6j+Ebn2OEvWyx
         3pAt4TcfEkxtFZ4ZWAC3tSMzysUJnKeAzHDkB0ruwBhuUFIx2gpyEAX4Z1BOY0+uNAyn
         Ygd4tRyRD4P7B55EXUThG0cjOXhTJdZUulbWnaQYs72YXVFYPR/b0zPLS4U+DwSX8fXw
         JLl9LJ7bVxDr9KyLxBCOyI1JjNgTjwQHFvLPkpqhi3DwVnFj/+Sf6JEvG9WPCeAurSZt
         zTDg==
X-Gm-Message-State: ACrzQf2nKIN78u1ZX+yzimYnFifzDZ67gX1Sqo3d94sf1C7Abr9BEHxV
        C0GT09SflXA6Yxjbkr5H9HjQflFo/YyFrqZzt6mltoUmYS8Gzo9AePIWawnXUHbkgfIRhLWBGcS
        A1UnbhjkpCZj//KSfgMaSKjfA
X-Received: by 2002:a05:6638:379e:b0:35a:6503:453c with SMTP id w30-20020a056638379e00b0035a6503453cmr11604727jal.118.1663705602744;
        Tue, 20 Sep 2022 13:26:42 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7Wn3n/ipGU1Lsd59DpS6zB424nUgnSwe6A3PA6dfJBFxnu4Ya4+9pvipnOK8j87C89TfNNcQ==
X-Received: by 2002:a05:6638:379e:b0:35a:6503:453c with SMTP id w30-20020a056638379e00b0035a6503453cmr11604691jal.118.1663705602488;
        Tue, 20 Sep 2022 13:26:42 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id z18-20020a05663822b200b00359fbe10489sm269899jas.103.2022.09.20.13.26.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 13:26:42 -0700 (PDT)
Date:   Tue, 20 Sep 2022 14:26:39 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Kevin Tian <kevin.tian@intel.com>
Cc:     Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Eric Farman <farman@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Tony Krowiak <akrowiak@linux.ibm.com>,
        Jason Herne <jjherne@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Diana Craciun <diana.craciun@oss.nxp.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Longfang Liu <liulongfang@huawei.com>,
        Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Yishai Hadas <yishaih@nvidia.com>,
        Eric Auger <eric.auger@redhat.com>,
        Kirti Wankhede <kwankhede@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        Abhishek Sahu <abhsahu@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v3 15/15] vfio: Add struct device to vfio_device
Message-ID: <20220920142639.29b1bdc2.alex.williamson@redhat.com>
In-Reply-To: <20220909102247.67324-16-kevin.tian@intel.com>
References: <20220909102247.67324-1-kevin.tian@intel.com>
        <20220909102247.67324-16-kevin.tian@intel.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  9 Sep 2022 18:22:47 +0800
Kevin Tian <kevin.tian@intel.com> wrote:

> From: Yi Liu <yi.l.liu@intel.com>
> 
> and replace kref. With it a 'vfio-dev/vfioX' node is created under the
> sysfs path of the parent, indicating the device is bound to a vfio
> driver, e.g.:
> 
> /sys/devices/pci0000\:6f/0000\:6f\:01.0/vfio-dev/vfio0
> 
> It is also a preparatory step toward adding cdev for supporting future
> device-oriented uAPI.
> 
> Add Documentation/ABI/testing/sysfs-devices-vfio-dev.
> 
> Also take this chance to rename chardev 'vfio' to 'vfio-group' in
> /proc/devices.

What's the risk/reward here, is this just more aesthetically pleasing
symmetry vs 'vfio-dev'?  The char major number to name association in
/proc/devices seems pretty obscure, but what due diligence have we done
to make sure this doesn't break anyone?  Thanks,

Alex

