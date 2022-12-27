Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE5F36567CF
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 08:23:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbiL0HXC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 02:23:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbiL0HWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 02:22:55 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D48802A3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 23:22:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672125729;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zfKUWZq7lCvM5zpq0a3YtNlAumoZQidpl8RqW6Hsass=;
        b=P3yDw/rn+n14V98j8so80HF1PDwCspcRxEx2Mplbm1lPG18IvXe3ozzf8FOCq9sIzQsbBG
        pPPSn4pp0/NELvPkGLmg1gwo6duq7WIklWpA5e8NZJlMnnC5yyyWsl8uYJ3f9Fa9QtVi9t
        QNqzlAvtM7CFXArKu+6PGpHWvQm4yNs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-81-9PzXu--cP7W7qT0DthEvsA-1; Tue, 27 Dec 2022 02:22:04 -0500
X-MC-Unique: 9PzXu--cP7W7qT0DthEvsA-1
Received: by mail-wm1-f72.google.com with SMTP id q21-20020a7bce95000000b003d236c91639so3001127wmj.8
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 23:22:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zfKUWZq7lCvM5zpq0a3YtNlAumoZQidpl8RqW6Hsass=;
        b=M4RZE+wgq2va6S+RwGcbbCSPV4LPpNjtDf25+NXLctmoY4VFuUvDo0/cdNxy+q3wSG
         6F/rnQxiN5nSjXxZGdcOtXUVkZy7lJbqguf5SL2lKkCntDbfjgrtlusDX0756OFLE75b
         hoC9/L6b3qfgh+G1b9CzrhKHWy7CLDYR6yL4zUIpag8fB21aDbhgiZ+tNbKCDOid4IeX
         e76OECDfmTjH8Bc/aQdrOlGbj9RF+EIJ7VU34foWkwU2Rv4cEXWTNIxOskozGPohTwaQ
         PL4829kyofyFRI3TmhAuZvt6MFuE0KtkvgASTTUGqIGNbIyltCAofWRbmE945bGc9yuV
         4i6w==
X-Gm-Message-State: AFqh2kpsmyeA2cnDR1FowWG31gvei5vyvbnLWjZScgM9TLNkQKI7jCI7
        JJX/Z54y0jEbeKVHJ+3EzspuEp6mBuzF9QlkoDngEn6dBOyl7Q7imiItCMZQaR0Dj2f0qWeDdA3
        t6L7rm+lo+rbSWAO3lnQEAi4v
X-Received: by 2002:a05:600c:1e11:b0:3d2:26e1:bd45 with SMTP id ay17-20020a05600c1e1100b003d226e1bd45mr18912020wmb.29.1672125723570;
        Mon, 26 Dec 2022 23:22:03 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtwhWF3hOB+CfPMNbqAWtPqmXhnEhLYXElqDaRnAVfaIXYN2fR1+P4H6eVMgRzb2KIsN1XyWg==
X-Received: by 2002:a05:600c:1e11:b0:3d2:26e1:bd45 with SMTP id ay17-20020a05600c1e1100b003d226e1bd45mr18912007wmb.29.1672125723386;
        Mon, 26 Dec 2022 23:22:03 -0800 (PST)
Received: from redhat.com ([2.52.151.85])
        by smtp.gmail.com with ESMTPSA id y24-20020a05600c365800b003cf894dbc4fsm16018925wmq.25.2022.12.26.23.22.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Dec 2022 23:22:03 -0800 (PST)
Date:   Tue, 27 Dec 2022 02:21:59 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     "Chen, Jian Jun" <jian.jun.chen@intel.com>
Cc:     Wolfram Sang <wsa@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>, asowang@redhat.com,
        Conghui <conghui.chen@intel.com>, linux-i2c@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Update maintainer list for virtio i2c
Message-ID: <20221227022149-mutt-send-email-mst@kernel.org>
References: <20221214053631.3225164-1-conghui.chen@intel.com>
 <20221214063107.fazrfq3n26hw4ndl@vireshk-i7>
 <Y5mjcuCRP45ynJis@shikoro>
 <20221214065856-mutt-send-email-mst@kernel.org>
 <fd9bc91a-8afe-9dac-7d1f-2e57e658d2d7@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fd9bc91a-8afe-9dac-7d1f-2e57e658d2d7@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 27, 2022 at 12:05:09PM +0800, Chen, Jian Jun wrote:
> 
> On 12/14/2022 20:00, Michael S. Tsirkin wrote:
> > On Wed, Dec 14, 2022 at 11:20:34AM +0100, Wolfram Sang wrote:
> > > Hi Viresh,
> > > 
> > > > I understand that it is okay to pass the maintainership, within the
> > > > company, for platform specific parts from one person to another, since
> > > > they have the best knowledge of the code and are the only one
> > > > interested in maintaining it too.
> > > > 
> > > > But what is the rule for generic drivers like this one ?
> > > Dunno if this is really a rule, but if a maintainer steps out and makes
> > > sure there is someone to pick up the work, this is more than welcome.
> > > Way better than a stale entry in the MAINTAINERS file.
> > > 
> > > I mean, it does not limit the chance to have further maintainers, for
> > > example. I believe in meritocracy here. Those who do and collaborate,
> > > shall get responsibility.
> > Exactly. I'd like to see Jian Jun Chen do and collaborate first.
> 
> Hi Michael,
> 
> Sure, I will start to collaborate first.

Great!

> > > If not, then not. We can fix this, too, if
> > > needed.
> > > 
> > > What is the reason for your question?
> > > 
> > > All the best,
> > > 
> > >     Wolfram
> > > 
> > 

