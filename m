Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16E5F71528A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 02:17:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbjE3ARj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 20:17:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjE3ARh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 20:17:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EF04DB
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 17:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685405809;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cBl3q2i812Jlu/HY8zePZKnZZJeg4miQ7XeIUUOuIUs=;
        b=EC8IjAlaEJeGBXv9msEe2PdkvOHjVXRikyqJlItGhZoe36YjqmxzdlK8Xusjb+bAPiqU1d
        Pd9R5CwwQwv14isZMokhEHJtOQjvrhAPxvS1sHuCbIeSEv2NQf3GNmqS4NICocYOWj0MWH
        gtau7H3FlWceDAlkbuGcACATVJVvFhI=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-546-4xVz2Th7OXeyAj1QXPmjTQ-1; Mon, 29 May 2023 20:16:47 -0400
X-MC-Unique: 4xVz2Th7OXeyAj1QXPmjTQ-1
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-33832662ba5so48162815ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 17:16:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685405807; x=1687997807;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cBl3q2i812Jlu/HY8zePZKnZZJeg4miQ7XeIUUOuIUs=;
        b=K/Vzl+ReeVakiz6m+AkbAujmwGMRy0ZIZOIuNNaP0JTZunSnt96+d6xuiO+yfrPy7V
         fGw1F5+0/K0ex6+Ug74FvTiM97m6GDZYhFyVIfLlsLKZrNC+ggiXRsCaGISjsKRAg9hX
         CVR61v0UpEKwbEqtx51PblqqtjZrEdntNQ5Gm2jEKxc7rnXahArKIpEyfRLCdfjKwecV
         /eOK3JF3n8X2Wt/tX9o7csZhl08+sMXSYb0wx1GEThuTFDarO5Nset2rFphBuYByZPWl
         wGHg521kShBbF9j24kIU/gfMKo06wEjtJYkv9xU9P+GQ9WKXaPgxZ8ABT9+iRoGUa6F9
         MxPA==
X-Gm-Message-State: AC+VfDz+AHvxaYP4Jg/82pwaJplJ1wkIswVS8Infi5HcErPNQAF93uAB
        n0/Cx0rYFVPMjFyNFCburgtdsWODxHEI6Y67GNMSEGOzLakdzTuanl1OLYZTOlPkg7dambDbitL
        HJ+EOLvR39vLTnAb1zLv0qGns
X-Received: by 2002:a92:dcc1:0:b0:328:8770:b9c2 with SMTP id b1-20020a92dcc1000000b003288770b9c2mr507361ilr.14.1685405807097;
        Mon, 29 May 2023 17:16:47 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ73yMhHh+AVUWd+tWnEm39ZtbwzqfO2AHakkj3n4fptb2pthTIWuj5Tj1tTy9hAry5+QAej4w==
X-Received: by 2002:a92:dcc1:0:b0:328:8770:b9c2 with SMTP id b1-20020a92dcc1000000b003288770b9c2mr507347ilr.14.1685405806881;
        Mon, 29 May 2023 17:16:46 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id d6-20020a926806000000b003248469e5easm590655ilc.43.2023.05.29.17.16.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 May 2023 17:16:46 -0700 (PDT)
Date:   Mon, 29 May 2023 18:16:44 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     "Tian, Kevin" <kevin.tian@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
        "cohuck@redhat.com" <cohuck@redhat.com>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
        "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "mjrosato@linux.ibm.com" <mjrosato@linux.ibm.com>,
        "chao.p.peng@linux.intel.com" <chao.p.peng@linux.intel.com>,
        "yi.y.sun@linux.intel.com" <yi.y.sun@linux.intel.com>,
        "peterx@redhat.com" <peterx@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "shameerali.kolothum.thodi@huawei.com" 
        <shameerali.kolothum.thodi@huawei.com>,
        "lulu@redhat.com" <lulu@redhat.com>,
        "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
Subject: Re: [PATCH v3 00/10] Add Intel VT-d nested translation
Message-ID: <20230529181644.3a6a5c7b.alex.williamson@redhat.com>
In-Reply-To: <ZHTyNgnjj/bOkIgi@nvidia.com>
References: <20230511145110.27707-1-yi.l.liu@intel.com>
        <BN9PR11MB52765FA8255FB8F8A1A6F11B8C419@BN9PR11MB5276.namprd11.prod.outlook.com>
        <ZHTyNgnjj/bOkIgi@nvidia.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 May 2023 15:43:02 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Wed, May 24, 2023 at 08:59:43AM +0000, Tian, Kevin wrote:
> 
> > At least this looks a reasonable tradeoff to some proprietary VMMs
> > which never adds RO mappings in stage-2 today.  
> 
> What is the reason for the RO anyhow?
> 
> Would it be so bad if it was DMA mapped as RW due to the errata?

What if it's the zero page?  Thanks,

Alex

