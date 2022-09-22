Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF4465E5E49
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 11:17:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbiIVJRY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 05:17:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230186AbiIVJRO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 05:17:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B573ACC8F4
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 02:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663838232;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kQfJsNBklEQnlLpVZNYjFz1njaLl7T8B+cRrquogK3o=;
        b=MQuMr1Msbygvu9jvS13AdWjOLEv46trP1DZ+JQfLRfFH705N3f9huXwv15tiLfoip1Ca5J
        ZLp1IB6F9l5Klc+/rIwbJe6eZwLrIYmSyRFZqek5dJRMHFv1ZYDkOH52Z0u5Qm1RF2Ukpq
        e+8EToPxPMYngYUMa1bG0ENFL2Nd1SE=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-631-qRCg57c0Nu6OFEjhvF5SXw-1; Thu, 22 Sep 2022 05:17:09 -0400
X-MC-Unique: qRCg57c0Nu6OFEjhvF5SXw-1
Received: by mail-ed1-f71.google.com with SMTP id b17-20020a056402351100b00453b19d9bd0so6181362edd.4
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 02:17:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=kQfJsNBklEQnlLpVZNYjFz1njaLl7T8B+cRrquogK3o=;
        b=Rsgsg4ntV+0dwZJe9D2+Z74YWzZv3MmE+gHi8DFJvyj3zdDSv+bQknwcetTfU/RHNr
         aanfe0zaRGS17+l+IWQynvHlbEG5eVU/w/c7MP3+OV6bT7YMipzU5CVuMIlRzDiZrQr1
         ZsYA8GW6PTzGt6ZeTA8boV2dm/4+IiMJW+VzDGcGfIAheU8pzouwI5E/uOt6oEL8AIhD
         DmST5iIKtnAZFa3EYmSluJXmJG6z6D6cuMuhDKEHCFrtJYPDiALBladgxGAeqikEne4r
         FalvFymSojL6N7cjjdwJ745h9qYYcKSbVkrxMEgutHCVHXy+sEMfWizFRA0kS6TTtBCf
         Ovaw==
X-Gm-Message-State: ACrzQf1UXQc2yYXSPIVxz7lGOpTllGUEIR5fpffTfcuQyXySFnudfLhq
        kzCtuBVTNUtQWPXr/ZWfHoqGnY5EIR2qAjntIjhmmOCCj/M22TmN0DW2NWeSOGIS8XUJlKVIj5C
        x5A/nxknBBN1uFHQTlIj1Xd8z
X-Received: by 2002:a17:907:d07:b0:72e:ec79:ad0f with SMTP id gn7-20020a1709070d0700b0072eec79ad0fmr2019347ejc.296.1663838228506;
        Thu, 22 Sep 2022 02:17:08 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6aWYk2gLkly55RZes2gWKaV2mpYmlQSmVpIR2XSzCn6t3IkeaTpYNPXd0NwzuX13AYtWwYqg==
X-Received: by 2002:a17:907:d07:b0:72e:ec79:ad0f with SMTP id gn7-20020a1709070d0700b0072eec79ad0fmr2019336ejc.296.1663838228336;
        Thu, 22 Sep 2022 02:17:08 -0700 (PDT)
Received: from redhat.com ([2.55.16.18])
        by smtp.gmail.com with ESMTPSA id d14-20020a170906304e00b0073bf84be798sm2374187ejd.142.2022.09.22.02.17.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 02:17:07 -0700 (PDT)
Date:   Thu, 22 Sep 2022 05:17:03 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Paolo Abeni <pabeni@redhat.com>
Cc:     Junbo <junbo4242@gmail.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
        John Fastabend <john.fastabend@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        virtualization@lists.linux-foundation.org,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, bpf@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Do not name control queue for virtio-net
Message-ID: <20220922051613-mutt-send-email-mst@kernel.org>
References: <20220917092857.3752357-1-junbo4242@gmail.com>
 <20220918025033-mutt-send-email-mst@kernel.org>
 <CACvn-oGUj0mDxBO2yV1mwvz4PzhN3rDnVpUh12NA5jLKTqRT3A@mail.gmail.com>
 <20220918081713-mutt-send-email-mst@kernel.org>
 <f3ad0de40b424413ede30abd3517c8fad0c3caca.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f3ad0de40b424413ede30abd3517c8fad0c3caca.camel@redhat.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 22, 2022 at 11:10:37AM +0200, Paolo Abeni wrote:
> On Sun, 2022-09-18 at 08:17 -0400, Michael S. Tsirkin wrote:
> > On Sun, Sep 18, 2022 at 05:00:20PM +0800, Junbo wrote:
> > > hi Michael
> > > 
> > > in virtio-net.c
> > >     /* Parameters for control virtqueue, if any */
> > >     if (vi->has_cvq) {
> > >         callbacks[total_vqs - 1] = NULL;
> > >         names[total_vqs - 1] = "control";
> > >     }
> > > 
> > > I think the Author who write the code
> > 
> > wait, that was not you?
> 
> I believe 'the Author' refers to the author of the current code, not to
> the author of the patch.

Oh I see. Responded.

> @Junbo: the control queue is created only if the VIRTIO_NET_F_CTRL_VQ
> feature is set, please check that in your setup.
> 
> Thanks
> 
> Paolo


-- 
MST

