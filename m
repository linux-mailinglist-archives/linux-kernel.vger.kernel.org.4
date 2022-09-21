Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11DBB5C0425
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 18:29:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232482AbiIUQ3W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 12:29:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbiIUQ3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 12:29:03 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9275BB56C0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 09:10:59 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id y2so4445855qtv.5
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 09:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=AMTftBiMWZk2QAmHkrehOI1g5/daemu3hoROzAqo87c=;
        b=f/UulgVbJR9/vOmsWbt5U91/tnOJo2PNL7TKCK8SY11JbGK+VrMoYbcJhcnMEmf5jQ
         EovlYjMoktLgNatoK+CVy/Rs7kyV2UA6+8pOZJO7l4anbiUth706rX7MVcJm2FurqfvZ
         qefHdqd0c/ho17jos0I/MwJ0GFfLtiSQFIshBUoETfF+JIBKx/dTEV8P4MJcgAKTCfgw
         iOPIc2rXvMSMMVwnmZz1ld8coHSm6IkjdCY6psHq+gvZXV66Pty8+C6P9UseXBXGvQ70
         r4tkHYuAgGQJeczB7XpAp+Yau+TWBCZJuVUu2BM/CB1qYJNCkA9RyP2l842CVcM2rxWG
         DOzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=AMTftBiMWZk2QAmHkrehOI1g5/daemu3hoROzAqo87c=;
        b=vQKW9FCnhbM6ob6yeVrbcQDD03wB1hOkvuKtrw5grzHMZpB994v41Rrgdn9XluSWpU
         NiaoQl+ZvUR2jBA2kDRFvaiQpZ+hpG6DbpIjEseuK+pKrd01jPbbyYgU9SRGMnzDlNlg
         OedJ6up0w+Kvscv7n86B7brdGHgi6MBNMtGw3BwTx/Jqh41t+w365Dq+KYS5UCvvndk6
         Q2LjsMcOg8Zw9i9HQ+1WK60PidfrSHdgl8It5k7rATnfsZDnYM6chiBA/EOLj91B3ysu
         Vj5iKxpc/r9FhnY/qcwR7zrKIZhI8d0t8N09fQLZAYXlrV88aAqvWT1CK6w+NoVSJSSQ
         lVPQ==
X-Gm-Message-State: ACrzQf0C8ZsgNn6DoCMc/8xgYuuzp5LD/dYl05utgp/bbIDUcmO+KWdu
        TUFbK3g8lOH52UphJAC67enlgA==
X-Google-Smtp-Source: AMsMyM6D2XVUjaEeXTE0RkRp6giqAEccP/ds63pJ2ySWLbtpckoAq+4dbYsu8/rqDg2Hj9+Vy46RKw==
X-Received: by 2002:ac8:7d10:0:b0:35c:d519:545 with SMTP id g16-20020ac87d10000000b0035cd5190545mr20896336qtb.537.1663776631727;
        Wed, 21 Sep 2022 09:10:31 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id l3-20020a05620a28c300b006b872b606b1sm2199206qkp.128.2022.09.21.09.10.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 09:10:30 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1ob2Iv-000qCI-Hh;
        Wed, 21 Sep 2022 13:10:29 -0300
Date:   Wed, 21 Sep 2022 13:10:29 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     Alex Williamson <alex.williamson@redhat.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        "Wang, Zhi A" <zhi.a.wang@intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        "Vivi, Rodrigo" <rodrigo.vivi@intel.com>,
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
        Yishai Hadas <yishaih@nvidia.com>,
        Eric Auger <eric.auger@redhat.com>,
        Kirti Wankhede <kwankhede@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        Abhishek Sahu <abhsahu@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        "intel-gvt-dev@lists.freedesktop.org" 
        <intel-gvt-dev@lists.freedesktop.org>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "Liu, Yi L" <yi.l.liu@intel.com>
Subject: Re: [PATCH v3 15/15] vfio: Add struct device to vfio_device
Message-ID: <Yys3dZS5ZUByiXin@ziepe.ca>
References: <20220909102247.67324-1-kevin.tian@intel.com>
 <20220909102247.67324-16-kevin.tian@intel.com>
 <20220920142639.29b1bdc2.alex.williamson@redhat.com>
 <BN9PR11MB5276484952784F5E336814BD8C4C9@BN9PR11MB5276.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276484952784F5E336814BD8C4C9@BN9PR11MB5276.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 20, 2022 at 10:55:40PM +0000, Tian, Kevin wrote:
> > From: Alex Williamson <alex.williamson@redhat.com>
> > Sent: Wednesday, September 21, 2022 4:27 AM
> > 
> > On Fri,  9 Sep 2022 18:22:47 +0800
> > Kevin Tian <kevin.tian@intel.com> wrote:
> > 
> > > From: Yi Liu <yi.l.liu@intel.com>
> > >
> > > and replace kref. With it a 'vfio-dev/vfioX' node is created under the
> > > sysfs path of the parent, indicating the device is bound to a vfio
> > > driver, e.g.:
> > >
> > > /sys/devices/pci0000\:6f/0000\:6f\:01.0/vfio-dev/vfio0
> > >
> > > It is also a preparatory step toward adding cdev for supporting future
> > > device-oriented uAPI.
> > >
> > > Add Documentation/ABI/testing/sysfs-devices-vfio-dev.
> > >
> > > Also take this chance to rename chardev 'vfio' to 'vfio-group' in
> > > /proc/devices.
> > 
> > What's the risk/reward here, is this just more aesthetically pleasing
> > symmetry vs 'vfio-dev'?  The char major number to name association in
> > /proc/devices seems pretty obscure, but what due diligence have we done
> > to make sure this doesn't break anyone?  Thanks,
> 
> I'm not sure whether the content of /proc/devices is considered as ABI.
> 
> @Jason?

Ah, I've forgotten why we got here - didn't we have a naming conflict
with the new stuff that is being introduced?

ABI wise it is not a problem unless there is a real user, I'm not
aware of anything scanning /proc, that has been obsoleted by sysfs a
long time ago.

Jason
