Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD53361F4A6
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 14:54:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231697AbiKGNyg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 08:54:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231253AbiKGNye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 08:54:34 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42E5F655C
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 05:53:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667829216;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WZNc+tr+S4WltVfB/kdnQZ3LcaOHN70GuE/UfxpNBH8=;
        b=MNecPS1Q2CSXXC8CLkQDBIev0oqnZQm1+ZtI6m0SNNRL6vbMif2u1625CLSPB8K2FFTzrd
        +L/N9B9H21IFz45oOJoyI53pVKa0RTP3E0yemh6ni6i1dHNvFSZ6kN4bkCOGHP9GgN41+c
        KlJfvi2ZHar6b/g/DGdxt4Ws+IhE/gA=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-454-QYJf0jdSMtCmzsnshxXcCg-1; Mon, 07 Nov 2022 08:53:35 -0500
X-MC-Unique: QYJf0jdSMtCmzsnshxXcCg-1
Received: by mail-qk1-f199.google.com with SMTP id n13-20020a05620a294d00b006cf933c40feso10246412qkp.20
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 05:53:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WZNc+tr+S4WltVfB/kdnQZ3LcaOHN70GuE/UfxpNBH8=;
        b=sDivqnR4/jLuJPa6hGAqoez0gqqIZirvzsYO+7Mgf9PGCQ8ekobFpQIWuPfptzQRBE
         QNFAUfxXD8ANxuHwMc6XXZEqlrnoiFskkD2ln6t7o/SARYeRCGuz73aXoOsNRLpf29kA
         wLNDrWspHMRz1wxkuEy3pRHzUTvgMIJj9IRoAJaC28ljyIKrruCLgDhugao1q4duCQMm
         Vt27Pw28z7dLzGYNJYvhp5tFMLU//reliD+WKoFF/O2dVVpRf6sBq9kOFBEBp3KYj68I
         olb1Li73WIqlr7OL1FgWwdAPh1yOd77aNAIl6O66r0A/0r9Q1+sCSFUVBgaOkR2y+2xY
         qWCQ==
X-Gm-Message-State: ACrzQf2Cv07qIgawbuj3WwYTf2RTrFZfB2WA4Y6t9J7/TsUY0pTTOGc4
        HWeBXLliwecVfGWeSsnLqncG/TqzKIef3bXikMa5EfPjT+Ivj3CF47LBfV3qrw4hB92RQGjJ3FR
        HEA7UBOncw7L9SM76r4CuPqco
X-Received: by 2002:a05:6214:1cc8:b0:4af:649f:dd57 with SMTP id g8-20020a0562141cc800b004af649fdd57mr44979893qvd.81.1667829214989;
        Mon, 07 Nov 2022 05:53:34 -0800 (PST)
X-Google-Smtp-Source: AMsMyM7fwKhFvTzfCmWtOrLqIbBb5uJr/E5Ez/tctluYNT+hrC/s+ClMa3HLULqX7VxpE9UhnsGjmA==
X-Received: by 2002:a05:6214:1cc8:b0:4af:649f:dd57 with SMTP id g8-20020a0562141cc800b004af649fdd57mr44979873qvd.81.1667829214841;
        Mon, 07 Nov 2022 05:53:34 -0800 (PST)
Received: from fionn (bras-base-rdwyon0600w-grc-08-184-147-142-10.dsl.bell.ca. [184.147.142.10])
        by smtp.gmail.com with ESMTPSA id r4-20020ae9d604000000b006fa2b1c3c1esm6805488qkk.58.2022.11.07.05.53.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 05:53:34 -0800 (PST)
Date:   Mon, 7 Nov 2022 08:53:20 -0500 (EST)
From:   John Kacur <jkacur@redhat.com>
To:     Daniel Bristot de Oliveira <bristot@kernel.org>
cc:     Steven Rostedt <rostedt@goodmis.org>,
        linux-trace-devel@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>,
        Clark Williams <williams@redhat.com>,
        Chang Yin <cyin@redhat.com>
Subject: Re: [PATCH] rtla: Fix exit status when returning from calls to
 usage()
In-Reply-To: <b4639b19-94e3-2128-643e-6a3a44a1d944@kernel.org>
Message-ID: <ca3dce1a-98d0-109a-f4d-d35b6ee2399a@redhat.com>
References: <20221103135742.9523-1-jkacur@redhat.com> <b4639b19-94e3-2128-643e-6a3a44a1d944@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 4 Nov 2022, Daniel Bristot de Oliveira wrote:

> On 11/3/22 14:57, John Kacur wrote:
> > rtla_usage(), osnoise_usage() and timerlat_usage() all exit with an
> > error status
> 
> missing .
?

> 
> > However when these are called from help, they should exit with a
> > non-error status.
> > 
> > Fix this by passing the exit status to the functions
> 
> missing .
?

> 
> > Note, although we remove the subsequent call to exit after calling
> > usage, we leave it in at the end of a function to supress the compiler
> 
> suppress?
Of course, thanks for the spelling check!

> 
> > warning "control reaches end of a non-void function"
> 
> missing .
?

> 
> Yep, that is a problem, and agree with the solution (I am already doing it
> in the rv cmd line).
cool

> 
> -- Daniel
> 

