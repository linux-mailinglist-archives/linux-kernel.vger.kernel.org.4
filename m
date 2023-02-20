Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD37169D300
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 19:45:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232597AbjBTSpn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 13:45:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231740AbjBTSph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 13:45:37 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30EA41E1F4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 10:44:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676918687;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5o6eRTQNfDmApvYWeJ5Fj/h2ml291ODKP5nMoklmwOg=;
        b=axs1HljxYlNniipImmcz8h5/Yz5PZo6cgsEObn5l4n6FEjOnh3G3gCj1HF9Lt7bQot6yq9
        NO0xVxGUd5hMwTzkmW8vz7LQMlH2mzUwmWAVX2gdsCEqGvzHV2JO0NTTL+VhEQDEG8Kn/D
        tvIH/vTHjge6sic/KgT+fdXtOoQ4Qro=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-7-WeOMW5AAPeWPc1_tS-mSQA-1; Mon, 20 Feb 2023 13:44:46 -0500
X-MC-Unique: WeOMW5AAPeWPc1_tS-mSQA-1
Received: by mail-ed1-f70.google.com with SMTP id da15-20020a056402176f00b004ace822b750so2811603edb.20
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 10:44:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5o6eRTQNfDmApvYWeJ5Fj/h2ml291ODKP5nMoklmwOg=;
        b=SoE4vdn3eEB0J8tbXgSGfcz9L+KdPbHt/BHM2mc1xj/htIkC6vU9BMbNLpBVgQrQV5
         7d1gdgFGVkN/0G/Fpnw+RV9U4dGzXUObLmb6lOUQny2EcV1EKxiLfuz4lSqUdjAyBOiF
         qfjWQaLZvziOnlA6U6u0LW26GvX21jA9rAA4GXxOctvDBpcwXm/UdsYtsXzXhXWRvO81
         sK9uY878BwLdJIgBq2dxV++X22gzHFKhs6ipHsVG4JT3iwZAHIc2aUu0OhAdhRHkzJFP
         drkrfxxxmsqiSX5KEpKVse3DbGl7Rf+xvx6enPANpz6T6W7YT4MaPqV0GN4ief2Pw3Xy
         i0gg==
X-Gm-Message-State: AO0yUKUCPCBr7R+GsQrNGPM1FvQiT/RH6ZrwQuuWPhjFi3QtVR8cvW9f
        Ml5FULVZ0vPtmpZU1nmOEVUwWVSMas8l+QFqsl2rR+340xYpPw36wQxaFn5IUeLhAeSnMIlBwVc
        JTJRBWu2MKCX5OD0+C0NjVLzG
X-Received: by 2002:a17:907:7288:b0:8bc:9bce:7eb6 with SMTP id dt8-20020a170907728800b008bc9bce7eb6mr11093417ejc.7.1676918684880;
        Mon, 20 Feb 2023 10:44:44 -0800 (PST)
X-Google-Smtp-Source: AK7set9ocE67SLza6haA31oEbJHJRcyYUHybtxqKgcJJvEaEBloE29nx4Mt4k9LeCQov7jkXoVJscw==
X-Received: by 2002:a17:907:7288:b0:8bc:9bce:7eb6 with SMTP id dt8-20020a170907728800b008bc9bce7eb6mr11093401ejc.7.1676918684569;
        Mon, 20 Feb 2023 10:44:44 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:4783:a68:c1ee:15c5? ([2001:b07:6468:f312:4783:a68:c1ee:15c5])
        by smtp.googlemail.com with ESMTPSA id u20-20020a1709064ad400b008d21431e705sm1751526ejt.84.2023.02.20.10.44.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Feb 2023 10:44:44 -0800 (PST)
Message-ID: <489768bf-34e1-305b-9264-cdb1cebf3be2@redhat.com>
Date:   Mon, 20 Feb 2023 19:44:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 07/29] LoongArch: KVM: Implement vcpu run interface
Content-Language: en-US
To:     Tianrui Zhao <zhaotianrui@loongson.cn>
Cc:     Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Mark Brown <broonie@kernel.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Oliver Upton <oliver.upton@linux.dev>, maobibo@loongson.cn
References: <20230220065735.1282809-1-zhaotianrui@loongson.cn>
 <20230220065735.1282809-8-zhaotianrui@loongson.cn>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20230220065735.1282809-8-zhaotianrui@loongson.cn>
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

On 2/20/23 07:57, Tianrui Zhao wrote:
> +	lose_fpu(1);

Is this enough to clear CSR_EUEN_FPEN?

Paolo

