Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D3E168A4CB
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 22:37:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233740AbjBCVhU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 16:37:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233571AbjBCVhN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 16:37:13 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 057D4A8A25
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 13:35:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675460155;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5k+UxZR8AqVwDwvK/Db4g0V588SY+VI2pB0owqXny0I=;
        b=Sy6gvVesgHw7JxfnxTUTJECI7a1/7v9QkOzDrmZ5HhXcqHmsPEI72aJiaUX2dciATLWJtD
        nF9cGZi65knzhsQyjRiddsecXmugw6Eu+IIm6/uOZ23foFdRtIkT/34/qRK3P4ZNkPCYQH
        0eeQf9bbrUBY6nqF04Ur91kUikd/Hys=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-172-N8dTAfnVOeG9iuO3yybM1g-1; Fri, 03 Feb 2023 16:35:54 -0500
X-MC-Unique: N8dTAfnVOeG9iuO3yybM1g-1
Received: by mail-io1-f71.google.com with SMTP id u6-20020a6be406000000b00716ceebf132so3728445iog.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Feb 2023 13:35:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5k+UxZR8AqVwDwvK/Db4g0V588SY+VI2pB0owqXny0I=;
        b=kxPlY3BL1/7Wfsi2At1TOpYF9HxzwCKWjFVfQnnshTosUoQF8+6p1Nxa4P/DGIjkpn
         6DnRXGJR+3UIoq4FWexla6V731/RBxV4aC84yvzVs43xRWcpSxGGgKP0C0TZKX2mBKfq
         nbdH2hNagET/Wmq01wghVgerNWqZxY2+XNF3mLAItwkSXG+xAO0VbcxJ/mRvi3PrKBvH
         op8ha/Pw8GPIu+kql11z8v8ikzW5aKBlxKhBtVTpv2GNJ8El8Lo45lR40voa9G91h5S0
         lZRyU+uHa0B2l0ySCxRc5Q8RcJ8+Y4zU3jIRTfVtk5igwe8dry9AP3RwanezLx7HTMZF
         s79Q==
X-Gm-Message-State: AO0yUKX3n6qQZ2FHKbGbfdJhfj8gAa5+xCad9MAkPlWXarpaS7upouga
        dLAG7wjPAGldSiKX9HzhaEazb/8Q9ergzJ06QMUgVZJ5O9CpIiA5eK6oNnQLVqMEb/tWAWYLhzf
        9jQLEvZEwb0szLxfUVcVxCKKU
X-Received: by 2002:a05:6e02:148c:b0:312:7bbf:94f5 with SMTP id n12-20020a056e02148c00b003127bbf94f5mr9262267ilk.3.1675460153335;
        Fri, 03 Feb 2023 13:35:53 -0800 (PST)
X-Google-Smtp-Source: AK7set8GiBZNAUhnppz+3LpmWjBO/5Dhk61WY57QRLNeBIn7RbRA8vBDcQoGmES9jBCpRxioDalZzw==
X-Received: by 2002:a05:6e02:148c:b0:312:7bbf:94f5 with SMTP id n12-20020a056e02148c00b003127bbf94f5mr9262252ilk.3.1675460153111;
        Fri, 03 Feb 2023 13:35:53 -0800 (PST)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id a16-20020a924450000000b0031264571bd8sm1103072ilm.18.2023.02.03.13.35.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 13:35:52 -0800 (PST)
Date:   Fri, 3 Feb 2023 14:35:51 -0700
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Matthew Rosato <mjrosato@linux.ibm.com>
Cc:     "Liu, Yi L" <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "cohuck@redhat.com" <cohuck@redhat.com>,
        "farman@linux.ibm.com" <farman@linux.ibm.com>,
        "pmorel@linux.ibm.com" <pmorel@linux.ibm.com>,
        "borntraeger@linux.ibm.com" <borntraeger@linux.ibm.com>,
        "frankja@linux.ibm.com" <frankja@linux.ibm.com>,
        "imbrenda@linux.ibm.com" <imbrenda@linux.ibm.com>,
        "david@redhat.com" <david@redhat.com>,
        "akrowiak@linux.ibm.com" <akrowiak@linux.ibm.com>,
        "jjherne@linux.ibm.com" <jjherne@linux.ibm.com>,
        "pasic@linux.ibm.com" <pasic@linux.ibm.com>,
        "zhenyuw@linux.intel.com" <zhenyuw@linux.intel.com>,
        "Wang, Zhi A" <zhi.a.wang@intel.com>,
        "Christopherson, , Sean" <seanjc@google.com>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "intel-gvt-dev@lists.freedesktop.org" 
        <intel-gvt-dev@lists.freedesktop.org>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] vfio: fix deadlock between group lock and kvm lock
Message-ID: <20230203143551.2f349702.alex.williamson@redhat.com>
In-Reply-To: <b5e64413-0374-edd8-9bfd-8bb613ab04f9@linux.ibm.com>
References: <20230202162442.78216-1-mjrosato@linux.ibm.com>
        <20230202124210.476adaf8.alex.williamson@redhat.com>
        <BN9PR11MB527618E281BEB8E479ABB0418CD69@BN9PR11MB5276.namprd11.prod.outlook.com>
        <20230202161307.0c6aa23e.alex.williamson@redhat.com>
        <BN9PR11MB5276017F9CEBB4BAE58C40E88CD79@BN9PR11MB5276.namprd11.prod.outlook.com>
        <DS0PR11MB7529050661FCE4A5AC4B17C3C3D79@DS0PR11MB7529.namprd11.prod.outlook.com>
        <20230203064940.435e4d65.alex.williamson@redhat.com>
        <DS0PR11MB75297154376388A3698C5CCAC3D79@DS0PR11MB7529.namprd11.prod.outlook.com>
        <20230203081942.64fbf9f1.alex.williamson@redhat.com>
        <ed030aa5-b3af-638e-6e26-4e3a20b98ef4@linux.ibm.com>
        <20230203133503.4d8fb3e8.alex.williamson@redhat.com>
        <b5e64413-0374-edd8-9bfd-8bb613ab04f9@linux.ibm.com>
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

On Fri, 3 Feb 2023 16:19:10 -0500
Matthew Rosato <mjrosato@linux.ibm.com> wrote:
> > @@ -350,32 +350,25 @@ void vfio_device_get_kvm_safe(struct vfio_device *device)
> >  
> >  	lockdep_assert_held(&device->dev_set->lock);
> >  
> > -	spin_lock(&device->group->kvm_ref_lock);
> > -	if (!device->group->kvm)
> > -		goto unlock;
> > -
> >  	pfn = symbol_get(kvm_put_kvm);
> >  	if (WARN_ON(!pfn))
> > -		goto unlock;
> > +		return;
> >  
> >  	fn = symbol_get(kvm_get_kvm_safe);
> >  	if (WARN_ON(!fn)) {
> >  		symbol_put(kvm_put_kvm);
> > -		goto unlock;
> > +		return;
> >  	}  
> >  >  	ret = fn(device->group->kvm);  
> 
> s/device->group->kvm/kvm/

Oops, yes.

> With that small change, this looks good to me too (and testing looks
> good too).  Do you want me to send a v4 for one last round of review?

Please do.  Thanks,

Alex

