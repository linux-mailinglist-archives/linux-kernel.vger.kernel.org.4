Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EC2E64C88C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 13:00:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238395AbiLNMAF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 07:00:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238360AbiLNL7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 06:59:42 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC04625285
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 03:58:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671019115;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Puk59mM8eVDxnAzNFx5aGXWzYXrsqC20wq+ZEPuJ168=;
        b=Yh97XS+YfYNfGPpyo0uPY+U0JXVYwp6yiA/2mD+nwczb++s2OvNjRrq1ldhQwGfPjKDGQw
        k+cHYIGd5e1FFPp6wezHHukyAOXXuG3a9uSegIzN0GM2kGacfGSsR7jkLH0H+nLXhrBHAJ
        SvFn1tW4fGlR5VKcAcG101VsmxMAX6k=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-121-HHx8-fCyMAy-cMMgND83cw-1; Wed, 14 Dec 2022 06:58:34 -0500
X-MC-Unique: HHx8-fCyMAy-cMMgND83cw-1
Received: by mail-wr1-f70.google.com with SMTP id e7-20020adf9bc7000000b00242121eebe2so3439631wrc.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 03:58:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Puk59mM8eVDxnAzNFx5aGXWzYXrsqC20wq+ZEPuJ168=;
        b=rX1YGgO/cBjdfU/e7jiZ6TwQXHBtUTc2gRR4JApretnUMNwnumNsVc/UV7pQpGcuPA
         G2bMzMonIETkvB7uwrmHIORYdNwp1LhkwtTynJGOPQTYKV0ACUmewf7F6IL6vsJC5jsw
         t0KM9SQZvT0h2e/PtdVKUDH4GLzrf/08kJ+zpXaCGdrXswR4pembw3QUAxEygOTIch6W
         zEGGP6I5FEIiPuWt0AFqgYlP205COMEBi/2oLXcwuhyqgglzX1iOmxsdpxyp/JVeK99w
         VZAMpo26Rv1pLl4kKk1PfNTdblbrpeUtPZWsSj32RoFhKGjw2sSP4RJyGjzv1Yg2SOKk
         VTRg==
X-Gm-Message-State: ANoB5pmVpTXOYKJWo2QpLCqI5vkQWGdiuM2v88vy1ljU+TmtuA3il9Ib
        dc1YrJMjmO2LiRDoSPeCwlrrPFeBQ0DIMpo2LMKaKAF2Z0xicMJyr+ANqH2c+B2y0467BMf2/7t
        KjjrNsrcZCs8NNnAwmC1JKaIv
X-Received: by 2002:a5d:526a:0:b0:242:877d:ca63 with SMTP id l10-20020a5d526a000000b00242877dca63mr16179199wrc.44.1671019113291;
        Wed, 14 Dec 2022 03:58:33 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4HSxAPf40LKD9a4HZ7iVGC/QK8BhMe6SSXxWXIEd+STJY7Pm38ou+bHRi/WjDGVGhtNtqGUg==
X-Received: by 2002:a5d:526a:0:b0:242:877d:ca63 with SMTP id l10-20020a5d526a000000b00242877dca63mr16179181wrc.44.1671019113009;
        Wed, 14 Dec 2022 03:58:33 -0800 (PST)
Received: from redhat.com (bzq-82-81-161-50.red.bezeqint.net. [82.81.161.50])
        by smtp.gmail.com with ESMTPSA id u2-20020adff882000000b00241d21d4652sm2635751wrp.21.2022.12.14.03.58.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Dec 2022 03:58:32 -0800 (PST)
Date:   Wed, 14 Dec 2022 06:58:29 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Wolfram Sang <wsa@kernel.org>, asowang@redhat.com,
        Conghui <conghui.chen@intel.com>, linux-i2c@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        Jian Jun Chen <jian.jun.chen@intel.com>
Subject: Re: [PATCH] MAINTAINERS: Update maintainer list for virtio i2c
Message-ID: <20221214065417-mutt-send-email-mst@kernel.org>
References: <20221214053631.3225164-1-conghui.chen@intel.com>
 <20221214063107.fazrfq3n26hw4ndl@vireshk-i7>
 <Y5mjcuCRP45ynJis@shikoro>
 <20221214105642.3xagckvbbgu5mubl@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221214105642.3xagckvbbgu5mubl@vireshk-i7>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 14, 2022 at 04:26:42PM +0530, Viresh Kumar wrote:
> On 14-12-22, 11:20, Wolfram Sang wrote:
> > Dunno if this is really a rule, but if a maintainer steps out and makes
> > sure there is someone to pick up the work, this is more than welcome.
> > Way better than a stale entry in the MAINTAINERS file.
> 
> Sure, a stale entry is always bad.
> 
> > I mean, it does not limit the chance to have further maintainers, for
> > example. I believe in meritocracy here. Those who do and collaborate,
> > shall get responsibility. If not, then not. We can fix this, too, if
> > needed.
> > 
> > What is the reason for your question?
> 
> It was a general question that I asked myself and didn't know an
> answer to. I wasn't sure if adding someone to be a maintainer here to
> a driver, which they haven't contributed to until now (at least based
> on open source commits), is right or not, since this isn't a stale
> entry in MAINTAINERS anyway.
> 
> An entry as R: would be okay normally IMO, as this makes sure
> interested party is kept aware of the development in the area. An M:
> entry somehow gives a higher level of authority to the person and
> without any prior contributions, it feels tricky at least.
> 
> Anyway, I don't have any objection to the patch at least as it was
> primarily developed by Intel engineers.
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

If a maintainer acks a patch I generally expect that the patch is good.
If we have a maintainer who's not familiar with the codebase, this
assumption does not hold.
R: would be ok with me.

> -- 
> viresh

