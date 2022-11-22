Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21373633DD3
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 14:37:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233578AbiKVNhv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 08:37:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232997AbiKVNhn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 08:37:43 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3216265E46
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 05:36:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669124192;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W8Ipj1lUpRMmyp202cPcvMaIYrm2ApjcaybUn1X7ca8=;
        b=XXtZ+nDV1xk5XrY5q5WLhnYHJ4XpA/qzYjoK6hfn7jZzSZ6dejs6YqsBxnyzm9NkYBBXxn
        kuP5fM0+eWevs4LGCJCJTbAghRq+ruZdjiX24UJP4T8rIV/3uklGLP9/h3j993m1QGqXBD
        NQDHCB9O/Q+6BbFoMI0Xzc2z9tJgiHE=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-457-fWufHEj3MK-PIC61LUFdig-1; Tue, 22 Nov 2022 08:36:30 -0500
X-MC-Unique: fWufHEj3MK-PIC61LUFdig-1
Received: by mail-qv1-f70.google.com with SMTP id nn2-20020a056214358200b004bb7bc3dfdcso14137365qvb.23
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 05:36:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W8Ipj1lUpRMmyp202cPcvMaIYrm2ApjcaybUn1X7ca8=;
        b=JGY+A6x85QHYC+p6pXeReld5acNsitFlYNj/jJ4GDWz2nJkMBVXRT0DE4PlGnWsUt/
         vy4gm+AkdKGQOnNv182+fH4dgkDHH4XgIX70bzDlC53rnsLhG4nhWPwO87cOydj9k2AV
         ZRau+7jwGbix7UC8Hmu+Nq13a2BBgd+7ius1qguZGm2IXCcEBl6zpImF9rwVmTgjH98A
         MsmfgX9ELIMxY4ycW5EI5vWKvMoY5wxkbRyFzWEtbbk1DLY+3TEraLyzmCOE2Fp8NI9K
         PFpO5LcQ25vrx5cwVnQXo3UVFuY1wf6/LV1v+GUwjljmhEhYwXrCs67mfemRL1r0axNl
         Inog==
X-Gm-Message-State: ANoB5pnezDKDQX7E0wMK2D+TmLxWX+dgPM4jiHXE1YAvy5vAr1hiBS9i
        ilS9PWlsmo5Tk9+grZfQP+gUzNNlk/x+DlmZFT6pz2h2MRZYH2HlSI9m8rfVqBzjqK9pTk+ruGc
        Lv+HSIg9MGa14GCxmo87eB6Vl
X-Received: by 2002:a05:620a:10a2:b0:6e7:1224:7940 with SMTP id h2-20020a05620a10a200b006e712247940mr20474038qkk.35.1669124189167;
        Tue, 22 Nov 2022 05:36:29 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6L+x8XMrEVNDrZE1jKcDe5/UIKjSKnOcumCLAzAXJ2tQbn9iIDTNNaA7dbfgh+bh+oYldBdg==
X-Received: by 2002:a05:620a:10a2:b0:6e7:1224:7940 with SMTP id h2-20020a05620a10a200b006e712247940mr20474019qkk.35.1669124188930;
        Tue, 22 Nov 2022 05:36:28 -0800 (PST)
Received: from [192.168.33.110] (c-73-19-232-221.hsd1.tn.comcast.net. [73.19.232.221])
        by smtp.gmail.com with ESMTPSA id bs42-20020a05620a472a00b006b61b2cb1d2sm10080554qkb.46.2022.11.22.05.36.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Nov 2022 05:36:28 -0800 (PST)
Message-ID: <1fe036eb-5207-eccd-0cb3-aa22f5d130ce@redhat.com>
Date:   Tue, 22 Nov 2022 08:36:26 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH net-next 2/2] bonding: fix link recovery in mode 2 when
 updelay is nonzero
To:     Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        Jay Vosburgh <j.vosburgh@gmail.com>
Cc:     Veaceslav Falico <vfalico@gmail.com>,
        Andy Gospodarek <andy@greyhouse.net>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org
References: <cover.1668800711.git.jtoppins@redhat.com>
 <cb89b92af89973ee049a696c362b4a2abfdd9b82.1668800711.git.jtoppins@redhat.com>
 <38fbc36783d583f805f30fb3a55a8a87f67b59ac.camel@redhat.com>
Content-Language: en-US
From:   Jonathan Toppins <jtoppins@redhat.com>
In-Reply-To: <38fbc36783d583f805f30fb3a55a8a87f67b59ac.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/22/22 05:59, Paolo Abeni wrote:
> Hello,
> 
> On Fri, 2022-11-18 at 15:30 -0500, Jonathan Toppins wrote:
>> Before this change when a bond in mode 2 lost link, all of its slaves
>> lost link, the bonding device would never recover even after the
>> expiration of updelay. This change removes the updelay when the bond
>> currently has no usable links. Conforming to bonding.txt section 13.1
>> paragraph 4.
>>
>> Signed-off-by: Jonathan Toppins <jtoppins@redhat.com>
> 
> Why are you targeting net-next? This looks like something suitable to
> the -net tree to me. If, so could you please include a Fixes tag?
> 
> Note that we can add new self-tests even via the -net tree.
> 

I could not find a reasonable fixes tag for this, hence why I targeted 
the net-next tree.

-Jon

