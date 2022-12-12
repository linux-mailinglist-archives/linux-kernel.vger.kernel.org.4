Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AD9464A051
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 14:23:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232562AbiLLNXg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 08:23:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232602AbiLLNXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 08:23:16 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E90BFEE
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 05:22:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670851343;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lHbD0bc62wnvFcvyZgL/qUAul189e+x07WK3pUf5sj4=;
        b=ibjgvxTXoiBV4f5vhmpQwqKT545cZVovJpS8d7uzhIPm0OXDd+TcSBLVH47oGZcBSDE+ib
        nvNcxmE+gcqmR7GwyCbKIM66VT7wu5WrIpvlw2TieKWC/ZTinKCw314D8PKmvgL2+wOkR/
        o1rez4/FJFq6sksNSCdn33FYQso9m8M=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-581-zyDuQbhfNQWjz-MR1cTcPA-1; Mon, 12 Dec 2022 08:22:22 -0500
X-MC-Unique: zyDuQbhfNQWjz-MR1cTcPA-1
Received: by mail-qv1-f69.google.com with SMTP id y11-20020ad457cb000000b004c6fafdde42so11569830qvx.5
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 05:22:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lHbD0bc62wnvFcvyZgL/qUAul189e+x07WK3pUf5sj4=;
        b=KoAqHR4UriHXB2YqifWa6j0Xl9q2CCamFBFn+sh7OkeojPpUBP733/Oe41pfvou9FS
         BiM68Y6zTCMQfjc3KPA2DLHdOde2qMjCDhT8Qr52J42SI5DMW0Vob9geRn0gK10Zd8iS
         4zFZV4FfvYM+9tXhs8buu+nEfr9SbcvGH/nRO0dILZOQqKVLeaJFerBxOayfxAGtgMPJ
         H9yZfTzvhlOjUoPufJrWvHmeGVIeQmavqzbxZLaEyLcQDkmIcR3dVCpCzotPg2sE9lEw
         3sdQNIE/d0X+IpVe6c3R2cBFys3J/bc/UTd9iA/8aNPotVpenuGR4mtVhgdzoKEQqMLF
         RG7g==
X-Gm-Message-State: ANoB5pl7PdeEhXnYtHItmtAvWmzbRHW1QucPQiwtNitJ728o520VqugW
        zudaWXcwwW3aS1zW2mf3GZIQ+cqx1rqz8as2eeJWZZSD6L1chVdHpXoohH2+krzVTt1uXyHNhIR
        oYQ1vH38+zVOgIiuq4wXXdx6x
X-Received: by 2002:a05:622a:18a1:b0:3a7:f669:4599 with SMTP id v33-20020a05622a18a100b003a7f6694599mr33800684qtc.62.1670851341721;
        Mon, 12 Dec 2022 05:22:21 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7Dsnp4gnwGIrvBBlo7rjiD+yh/h1xU3xuWVWjf9K0mQgn/zO86Bt1+cxSVx+kIzoAr5tnnMQ==
X-Received: by 2002:a05:622a:18a1:b0:3a7:f669:4599 with SMTP id v33-20020a05622a18a100b003a7f6694599mr33800646qtc.62.1670851341442;
        Mon, 12 Dec 2022 05:22:21 -0800 (PST)
Received: from bfoster (c-24-61-119-116.hsd1.ma.comcast.net. [24.61.119.116])
        by smtp.gmail.com with ESMTPSA id h18-20020ac846d2000000b003a55fe9f352sm5713126qto.64.2022.12.12.05.22.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 05:22:20 -0800 (PST)
Date:   Mon, 12 Dec 2022 08:22:26 -0500
From:   Brian Foster <bfoster@redhat.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Nhat Pham <nphamcs@gmail.com>, akpm@linux-foundation.org,
        hannes@cmpxchg.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, willy@infradead.org,
        kernel-team@meta.com
Subject: Re: [PATCH v2 3/4] cachestat: implement cachestat syscall
Message-ID: <Y5crEpr5QWptjK17@bfoster>
References: <20221205175140.1543229-1-nphamcs@gmail.com>
 <20221205175140.1543229-4-nphamcs@gmail.com>
 <Y5UbhBTB2nSMN4UD@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5UbhBTB2nSMN4UD@ZenIV>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 10, 2022 at 11:51:32PM +0000, Al Viro wrote:
> On Mon, Dec 05, 2022 at 09:51:39AM -0800, Nhat Pham wrote:
> 
> > +	if (!access_ok(cstat, sizeof(struct cachestat)))
> > +		return -EFAULT;
> 
> What for?  You are using copy_to_user() later, right?
> 
> > +	f = fdget(fd);
> > +	if (f.file) {
> 
> It would be easier to read if you inverted the condition here.
> 

Seconded.. I mentioned the same the last time I looked at this. On
looking again, perhaps it might even make sense to create a
filemap_cachestat() to split up the syscall bits from the associated map
walking bits..? That subsequently raises the question of whether a new
.c file is really necessary..

Brian

