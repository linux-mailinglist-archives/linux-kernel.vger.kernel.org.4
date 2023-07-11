Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 618FE74F46A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 18:07:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231750AbjGKQHb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 12:07:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjGKQH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 12:07:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B418218D
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 09:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689091598;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IHgmi2wwFrPjMP5Rxs8KSVDqK1J+qf75UCdExpa0HJo=;
        b=ENDaHJ/Vv8mI7uMgKK3FkLa7QEI3A5wQWLon3XqttdV42wVrb9YeO4sR8fMctVSW7c0a+o
        EqnawonnmLC4jJMKMohvtw9kw8v9BBCivORrOJlQ1nuVPNQ48PByZwdKG6k7CPxKAu99GK
        GBgTgMokpS/khyRLq6nF70NNf/YffWs=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-308-IciLerx8OkWjHuRDRssX-A-1; Tue, 11 Jul 2023 12:06:37 -0400
X-MC-Unique: IciLerx8OkWjHuRDRssX-A-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-98843cc8980so395445666b.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 09:06:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689091596; x=1691683596;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:cc:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IHgmi2wwFrPjMP5Rxs8KSVDqK1J+qf75UCdExpa0HJo=;
        b=CWV3fgsOH+kzwX8KKtfXgdNIgL27dMA6NjaRyU3GeBddbldUHa0qI79HZTnTmrRx6X
         y/kqthQ6fy7T2Udo2CNsmlekDgzi488dBbM42hM9NnJGy4OhIstBPGHMsEsaXNof1vkT
         zAhE8gAYfYUzL2QdoRxyIPwPz/M6gO/AV4gB/TYzV02ODDFg90Jf7/yETdyn6PYYK9Tn
         +Rlgpup3NibOJjyyOZhkhXv8ibCi4lOaNxpVvYi+peMda5XKMvGgVV4CLuyy160Ljs4s
         R85RRgn6GgJ0XKmMdLwBnprJ9gXB7+fCobTrZTwC3cKj3O77wvEQwL6LC3BnOWLKJKzb
         ADvQ==
X-Gm-Message-State: ABy/qLYNyIgTlYxS9KFQIk1TBhYUR6ovd1wwzHI4AgcF04FFJEfm875W
        hvUOOGtFNSfORkVLMPDgUoTMJgBe1OmWdzH3mMN9ePo9Idrp/iuT6DGn1hyhDS8rWdO1IJbwrNL
        BPI262WsrCwYDOJI1nTtCut4x
X-Received: by 2002:a17:906:73d5:b0:994:577:f9df with SMTP id n21-20020a17090673d500b009940577f9dfmr7195370ejl.4.1689091596090;
        Tue, 11 Jul 2023 09:06:36 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFVb+VnLW+A+oRRKhUDHDJ2ge75t79bT8wF0gNCeIcmMzqWP9QSikucwVt4UtqYjBbKUKQ5GA==
X-Received: by 2002:a17:906:73d5:b0:994:577:f9df with SMTP id n21-20020a17090673d500b009940577f9dfmr7195342ejl.4.1689091595649;
        Tue, 11 Jul 2023 09:06:35 -0700 (PDT)
Received: from [192.168.42.100] (194-45-78-10.static.kviknet.net. [194.45.78.10])
        by smtp.gmail.com with ESMTPSA id z19-20020a1709060ad300b009934b1eb577sm1340404ejf.77.2023.07.11.09.06.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jul 2023 09:06:35 -0700 (PDT)
From:   Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <da7ac0a1-5f62-bc0e-8954-d3d1e846fb52@redhat.com>
Date:   Tue, 11 Jul 2023 18:06:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Cc:     brouer@redhat.com, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Xu Kuohai <xukuohai@huawei.com>, Pu Lehui <pulehui@huawei.com>
Subject: Re: [PATCH bpf] bpf: cpumap: Fix memory leak in cpu_map_update_elem
Content-Language: en-US
To:     Pu Lehui <pulehui@huaweicloud.com>, bpf@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230711115848.2701559-1-pulehui@huaweicloud.com>
In-Reply-To: <20230711115848.2701559-1-pulehui@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/07/2023 13.58, Pu Lehui wrote:
> From: Pu Lehui <pulehui@huawei.com>
> 
> Syzkaller reported a memory leak as follows:
> 
[...]>
> In the cpu_map_update_elem flow, when kthread_stop is called before
> calling the threadfn of rcpu->kthread, since the KTHREAD_SHOULD_STOP bit
> of kthread has been set by kthread_stop, the threadfn of rcpu->kthread
> will never be executed, and rcpu->refcnt will never be 0, which will
> lead to the allocated rcpu, rcpu->queue and rcpu->queue->queue cannot be
> released.
> 
> Calling kthread_stop before executing kthread's threadfn will return
> -EINTR. We can complete the release of memory resources in this state.
> 
> Fixes: 6710e1126934 ("bpf: introduce new bpf cpu map type BPF_MAP_TYPE_CPUMAP")
> Signed-off-by: Pu Lehui <pulehui@huawei.com>

LGTM, thanks for fixing this.

Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>

