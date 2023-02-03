Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE4E768A2CA
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 20:18:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233628AbjBCTSi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 14:18:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233580AbjBCTSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 14:18:36 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7F0CEF9C
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 11:17:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675451871;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BO4vMWECv4J9NpNXP3V95/hRYYcq72yT05Jkf7LUiYo=;
        b=Y1CQQg0bk4pwCqqYGXQ6viE7UkasYHL7fWVC1yQCIDiKTCqzIwVncKc/wiS3n51H4wgkdn
        rg2/pbKgCIbXdN1FsGkZJ2EbdMC9RPGEzzln+x6Qz9Rp9rbHlDSV5tUZa3jRL1iNljmVHJ
        OkkbOOtgDDaCTN6RNDBNQfCxh8tU+OY=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-594-k03byDDGNLyvg3ITCuwGlw-1; Fri, 03 Feb 2023 14:17:50 -0500
X-MC-Unique: k03byDDGNLyvg3ITCuwGlw-1
Received: by mail-pf1-f198.google.com with SMTP id s8-20020a056a00178800b00593e2189278so3148801pfg.19
        for <linux-kernel@vger.kernel.org>; Fri, 03 Feb 2023 11:17:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BO4vMWECv4J9NpNXP3V95/hRYYcq72yT05Jkf7LUiYo=;
        b=xYOLfw8d2keeiWYsPYE1kcJpTswbcxshpuiZhTrwJAPPrPwFsmljdD9mJ2BpNm3wh+
         9y2dUkKq40HHiAkVTWIktSlrUoeuUnOq/UhEdE+zQ5jibK6sjlptvFJxfXvi5uxT+IGb
         AyPehY7zqF3AfiwINjF4ZjOWK41Onu2VzYkA1npfXeS189INXxH8SsPG8baROVOkPSO8
         bllTuICkqf+yaJ0dpMAabhNSanwZFilGoCF3J0+iqbeNXK+N6Q5EAJUGbxn2fi+MOgI1
         G0Uw8UmVVH2nEyyBTv5B/EjkCtaVBm11w57DYFOnAlgmo43WC8+TqKhcg7wcZ6FHyxwr
         SynQ==
X-Gm-Message-State: AO0yUKUX/2e4gTdQCuyHl2jRIn8dYB/7TcHx6hkObGH5y2+8UVyNekpj
        77NYzJuxhlmI6Kp8OZeYDPxESWaFhds9EDirUjGsCZr2TNmy3jebHdnB5uREfu2M1orO2l1hqk2
        F323pizIMOiElOVE/exHA5Cls
X-Received: by 2002:a05:6a21:170c:b0:be:e6d3:797b with SMTP id nv12-20020a056a21170c00b000bee6d3797bmr11174151pzb.55.1675451869733;
        Fri, 03 Feb 2023 11:17:49 -0800 (PST)
X-Google-Smtp-Source: AK7set+ShFz+W7toatFwTMDcuy98ED66+3PKJrTPzHQS4gMTrCidlVzxlyif4z+Bpqn+zUPRjDPQ0Q==
X-Received: by 2002:a05:6a21:170c:b0:be:e6d3:797b with SMTP id nv12-20020a056a21170c00b000bee6d3797bmr11174140pzb.55.1675451869483;
        Fri, 03 Feb 2023 11:17:49 -0800 (PST)
Received: from ?IPV6:2601:1c0:4680:5870:f0d8:e758:fcd:4c72? ([2601:1c0:4680:5870:f0d8:e758:fcd:4c72])
        by smtp.gmail.com with ESMTPSA id i5-20020a63b305000000b004efe1f24522sm1806578pgf.23.2023.02.03.11.17.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Feb 2023 11:17:48 -0800 (PST)
Message-ID: <9d144ca0-5cf2-a575-a30b-22f5ff4e8e2b@redhat.com>
Date:   Fri, 3 Feb 2023 11:17:47 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [RFC 2/5] rust: sync: Arc: Introduces ArcInner::count()
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>,
        Boqun Feng <boqun.feng@gmail.com>
Cc:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        Peter Zijlstra <peterz@infradead.org>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        =?UTF-8?Q?Bj=c3=b6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Vincenzo Palazzo <vincenzopalazzodev@gmail.com>
References: <20230201232244.212908-3-boqun.feng@gmail.com>
 <Y9t+3u+2UcAFQc+r@hirez.programming.kicks-ass.net>
 <20230202142153.352ba479.gary@garyguo.net> <Y9vZu08L2WaLNJIc@kroah.com>
 <Y9vga90K0aVfGUwW@boqun-archlinux> <Y9viM2POUsSnbKUh@kroah.com>
 <Y9vqJ1h2nkaFRpOY@boqun-archlinux>
 <CANiq72kMZ9XQvte41Mzu4oXX=ujGRCrGDZDiYUBVD3=JTGG57g@mail.gmail.com>
 <Y9yaBybest8JBu8A@kroah.com> <Y9y21JyuPF1nCCzr@Boquns-Mac-mini.local>
 <Y9y58cy1GKZLdyjb@kroah.com>
From:   Josh Stone <jistone@redhat.com>
In-Reply-To: <Y9y58cy1GKZLdyjb@kroah.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/2/23 11:38 PM, Greg KH wrote:
> How?  Because you have an implicit reference on it already?  If so, then
> why does reading from it matter at all, as if you have a reference, you
> know it isn't 0, and that's all that you can really care about.  You
> don't care about any number other than 0 for a reference count, as by
> definition, that's what a reference count does :)

There is an additional ability for 1, mentioned up thread -- if you have
&mut Arc<T>, and the inner count is 1, then you *know* there aren't any
other Arc<T> handles anywhere else. Then it is safe to return an
exclusive &mut T, like the upstream Arc::get_mut and Arc::make_mut. This
can also be used for owned Arc<T> like the upstream Arc::try_unwrap.

