Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EDC9626338
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 21:51:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234320AbiKKUvV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 15:51:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233015AbiKKUvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 15:51:19 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AC6F86D55
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 12:50:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668199806;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2Q2/IZbU+pr/0KvLnVJ4qomM1Uu7FpRO3AOTtlCSc5U=;
        b=HTB+J0iFrnfXrmbhlX+NwbZ8MBg07dHNpl2m3vCD/uydsGFeH7P5NcAAtvzdNBPqLyafGH
        Bw8C8V/sKom8N9TphBHDR4TqII+PC687qvAVcL9iZECct8CI4uoc7xR/IDs1r1BqAme/Wt
        3EbiLpHgwwi+YzyenEv72Mxwpf/d8CM=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-341-maMZoX5qOwCipYVxnf069A-1; Fri, 11 Nov 2022 15:50:05 -0500
X-MC-Unique: maMZoX5qOwCipYVxnf069A-1
Received: by mail-qk1-f197.google.com with SMTP id x2-20020a05620a448200b006fa7dad5c1cso5603011qkp.10
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 12:50:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2Q2/IZbU+pr/0KvLnVJ4qomM1Uu7FpRO3AOTtlCSc5U=;
        b=JYB5AYzl7enBA34EuvzSdBg5u0J5LKwztLPmtjt9EPcAFRxcLvK1e6yOtxfBr9qGSj
         kkMiBXwNWUmVEb4tTZngJMCuRXWaZS5bXyU+bcvC9OFzOMbuLzlLhyGfOyEKVZT7DK0f
         Xqh/OLD4WLH34EYCqxWhrlJ0w+o98Amcl41LsXVKQWy7gzSDAKDNscnKVMD5o5o8mIM+
         h9aSiQlW0e5AYcRkpiNxDl3CcOR33rs0oo/NcJSy75UQ3OCAF6so5KPlOjZeFnbFELkE
         VBTKfejiUg99kvZrh7iHME0X6ZuO41RFUhMGNtNWgd6ngCuiLgMcoKTEe5YCQLDRifW4
         qHhw==
X-Gm-Message-State: ANoB5pmZnmnw31bZj+1gQc+dIrk/fZhOOgHA+Q3GiEDFxDivN1tWIWuJ
        D4wHP9vSOpvGsi9O8NJktVvtr7Nb0TnpEw3c0PJ8CHx6QaX0/v+zjml73W09KV8hwjYktjld4tb
        JXl829y9C49vIERT3Ww3IzNom
X-Received: by 2002:ac8:43ca:0:b0:3a5:2615:5694 with SMTP id w10-20020ac843ca000000b003a526155694mr3010715qtn.429.1668199805055;
        Fri, 11 Nov 2022 12:50:05 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7H6e0UPBlPiN+t9b+AvaK1l1Q6Pa+c4x6XYFVDXe23cNygOYAhnSl+0XxzZydpMOALX8/3/g==
X-Received: by 2002:ac8:43ca:0:b0:3a5:2615:5694 with SMTP id w10-20020ac843ca000000b003a526155694mr3010696qtn.429.1668199804841;
        Fri, 11 Nov 2022 12:50:04 -0800 (PST)
Received: from ?IPv6:2600:4040:5c6c:9200::feb? ([2600:4040:5c6c:9200::feb])
        by smtp.gmail.com with ESMTPSA id h19-20020ac87453000000b003a5612c3f28sm1782363qtr.56.2022.11.11.12.50.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 12:50:03 -0800 (PST)
Message-ID: <006064db584562c38ba75bff30d1b33f8995df62.camel@redhat.com>
Subject: Re: Regression bisected: drm/display/dp_mst: Move all payload info
 into the atomic state
From:   Lyude Paul <lyude@redhat.com>
To:     Dirk Gouders <dirk@gouders.net>
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>,
        Wayne Lin <Wayne.Lin@amd.com>,
        Ville =?ISO-8859-1?Q?Syrj=E4l=E4?= 
        <ville.syrjala@linux.intel.com>, Fangzhi Zuo <Jerry.Zuo@amd.com>,
        Jani Nikula <jani.nikula@intel.com>,
        Imre Deak <imre.deak@intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Sean Paul <sean@poorly.run>
Date:   Fri, 11 Nov 2022 15:50:02 -0500
In-Reply-To: <ghwn827862.fsf@gouders.net>
References: <ghwn827862.fsf@gouders.net>
Organization: Red Hat Inc.
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank for letting us know! Luckily I only have good news, as we've actually
been looking into this issue for a bit now and have made a pretty good amount
of progress. There's pretty much only one issue left for us to fix I'm fairly
sure:

https://gitlab.freedesktop.org/drm/amd/-/issues/2171

If you'd like to help, there's some logs I could use someone getting to help
me figure out the last remaining issue here.

On Thu, 2022-11-10 at 23:32 +0100, Dirk Gouders wrote:
> Hello,
> 
> I noticed a regression with Linus' current tree and bisected it to
> 4d07b0bc403403 (drm/display/dp_mst: Move all payload info into the atomic state):
> 
> I have two monitors connected to my laptop's USB-C port and since this
> patch, one of the monitors remains dark.
> 
> Please let me know if I can provide additional information that could help
> to investigate this problem.
> 
> Dirk
> 

-- 
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat

