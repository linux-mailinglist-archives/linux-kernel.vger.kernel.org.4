Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 776E366CE27
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 18:59:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233891AbjAPR7C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 12:59:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232936AbjAPR6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 12:58:06 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CD1C49017
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 09:37:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673890675;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AM3cLoP8TWPmrgmRZcDwyPuhd6tlFOUEOcdOzvKctl4=;
        b=Xh1YQb7OsmRKfzgQTDrGERbDM/FqdLFdpNcDrApOYk6B4EnnlLNyb1lMTCV8yiJ1F+OGR0
        EsRqbvwScrTs18weG+uvkqSvZUFmdX1syezR1nt+b7NENp8k1LoI5/nAiRVNRHzar9l4sw
        CwOgIGgft3oNaZiWWda0FJspVML+Hm8=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-578-PnExP8F-MoC57AgBoR5tlw-1; Mon, 16 Jan 2023 12:37:54 -0500
X-MC-Unique: PnExP8F-MoC57AgBoR5tlw-1
Received: by mail-ej1-f72.google.com with SMTP id hs18-20020a1709073e9200b007c0f9ac75f9so19906709ejc.9
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 09:37:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AM3cLoP8TWPmrgmRZcDwyPuhd6tlFOUEOcdOzvKctl4=;
        b=3OEHo+A1FEoI9Ltw+s5/7MYMbxYVGCRReBGjDKfGcd0srNDP2aOvr/s7yes9f+cnmm
         hhg5khfKjPjuE1S0rchsQLgKWf9uStzxSP+v60HHJqMZIKup9Uku2a5PN4cVd73geBfH
         nbLmxVgtyWkrBDO+Zvq0UdfGYTv7WhvavquzI+RqI/UOCh2BLGmjtIP4Lf6x5eMrRSpu
         a2A+1hMiuL5fO747IbfajhdP8WcP33IPooCzI9XHptF3dAvrPmJWNMPCMkIqpkxkJAwU
         TGWK1nzV3eCy685q98WMrvunWAcmZOwdFIwaIwQLHcp9/+d3EkzqByNf0u4rdqgplerx
         GEFA==
X-Gm-Message-State: AFqh2kqIQNsPU3576HjvBSyVbAnWv0NPHB7HbwU6YqXAxR1gfgj1vYZ0
        BoCc1TfgroxLdZpuZssMm6GGwp+XMR7KRC5c9ao1sBKXJrRnvzswTUOYj3a2iba/6piAPWh1+on
        rZg2twGk9F2PeBO6hdEhPmm2P
X-Received: by 2002:a17:907:c11:b0:844:79b1:ab36 with SMTP id ga17-20020a1709070c1100b0084479b1ab36mr18134631ejc.25.1673890673111;
        Mon, 16 Jan 2023 09:37:53 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvxAktoVxqLbdOoIJzCFzA1FFlFx58XcCCbvaWacxz4nXnLR6H0c+d24xfdoV/jYoPocchgDQ==
X-Received: by 2002:a17:907:c11:b0:844:79b1:ab36 with SMTP id ga17-20020a1709070c1100b0084479b1ab36mr18134606ejc.25.1673890672894;
        Mon, 16 Jan 2023 09:37:52 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e? ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
        by smtp.googlemail.com with ESMTPSA id g17-20020a17090670d100b007bb86679a32sm12121592ejk.217.2023.01.16.09.37.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Jan 2023 09:37:52 -0800 (PST)
Message-ID: <c08f1e98-03fe-1996-bc2c-43d90ec78613@redhat.com>
Date:   Mon, 16 Jan 2023 18:37:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH] Documentation: kvm: fix SRCU locking order docs
Content-Language: en-US
To:     David Woodhouse <dwmw2@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        seanjc@google.com, Joel Fernandes <joel@joelfernandes.org>,
        Matthew Wilcox <willy@infradead.org>,
        Josh Triplett <josh@joshtriplett.org>, rcu@vger.kernel.org,
        Michal Luczaj <mhal@rbox.co>,
        Peter Zijlstra <peterz@infradead.org>
References: <20230111183031.2449668-1-pbonzini@redhat.com>
 <a14a13a690277d4cc95a4b26aa2d9a4d9b392a74.camel@infradead.org>
 <20230112152048.GJ4028633@paulmck-ThinkPad-P17-Gen-1>
 <Y8EF24o932lcshKs@boqun-archlinux>
 <d1d44f07-558c-e0ed-403e-61a854c868cb@redhat.com>
 <023e131b3de80c4bc2b6711804a4769466b90c6f.camel@infradead.org>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <023e131b3de80c4bc2b6711804a4769466b90c6f.camel@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/13/23 11:33, David Woodhouse wrote:
>> It's missing an important testcase; if it passes (does not warn), then
>> it should work:
>
> I think it does.

What I'm worried about is a false positive, not a false negative, so I'm 
afraid your test may not cover this.  I replied in the thread with 
Boqun's patches.

Paolo

