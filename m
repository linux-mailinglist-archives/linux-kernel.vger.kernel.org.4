Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 017A56C31AD
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 13:27:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbjCUM1C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 08:27:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbjCUM1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 08:27:00 -0400
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33FA248E3E
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 05:26:20 -0700 (PDT)
Received: by mail-ed1-f46.google.com with SMTP id ek18so58933861edb.6
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 05:26:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679401575; x=1681993575;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=26c/PJlmYgWkbBmERwUyqF2dpBsoOH9Y3u2+yXmk3wc=;
        b=NWi/rbNWlOWRm0KvJqKWK3AqEXqoEzpEAKHKS2mZqG+lP7vyUk6sS63hv7z131gFsd
         OzBowG7iyefaEmekLam2JlQ7BmQJiqOiTE8hBZWw70Sijf0O/yFrFh7FSB6nZWtswnej
         aTqezqVdQhaJO3gR477irgxyXMtqCW/a8/0zgDtSDZEZkhuMaxW5dxUEH7hvxjTuBmoi
         6SSocg0KqDR+pVTRjtoQFQ4+QMrBjDOY+t1L07u9UrdqKXjafTrVsjcWs4USl+QlMdZP
         doks5U3bSOad7Qe0PmlIUmmEXylVUP0WENI4zAVxBkevtPYbybeETTubdBxg/61VuwY5
         lEGg==
X-Gm-Message-State: AO0yUKVO8Tcv7joTYUYCWd/7Z/Q24HHhecB4kqoYi7KWVRSDq/HkT7ZN
        K/MMriCcml9Wo4T+IewiVF8=
X-Google-Smtp-Source: AK7set9BR+aUaX9jSI1+8SuxIhEkOn8iOy7MhwLuv4P3XYOXwQIiS4APbSbxzBudsHD9WeybjYQJMw==
X-Received: by 2002:a17:906:10d0:b0:931:4285:ea16 with SMTP id v16-20020a17090610d000b009314285ea16mr2362836ejv.7.1679401574832;
        Tue, 21 Mar 2023 05:26:14 -0700 (PDT)
Received: from [10.100.102.14] (85.65.253.165.dynamic.barak-online.net. [85.65.253.165])
        by smtp.gmail.com with ESMTPSA id bv1-20020a170906b1c100b00939e76a0cabsm795854ejb.111.2023.03.21.05.26.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Mar 2023 05:26:14 -0700 (PDT)
Message-ID: <56620baf-6195-b987-6067-ae81d23e39c5@grimberg.me>
Date:   Tue, 21 Mar 2023 14:26:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [External] Re: [PATCH] nvme: fix heap-use-after-free and oops in
 bio_endio for nvme multipath
Content-Language: en-US
To:     Lei Lei2 Yin <yinlei2@lenovo.com>,
        "kbusch@kernel.org" <kbusch@kernel.org>,
        "axboe@fb.com" <axboe@fb.com>, "hch@lst.de" <hch@lst.de>
Cc:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "cybeyond@foxmail.com" <cybeyond@foxmail.com>
References: <PS1PR03MB493948DD1ECFAF150EE7B2F688819@PS1PR03MB4939.apcprd03.prod.outlook.com>
 <042385ef-285e-5179-941b-ab37f490c1d8@grimberg.me>
 <PS1PR03MB49395AC5BC73DDDA6A79E87488819@PS1PR03MB4939.apcprd03.prod.outlook.com>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <PS1PR03MB49395AC5BC73DDDA6A79E87488819@PS1PR03MB4939.apcprd03.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> 	Thank you for your reply
> 
> 	This problem occurs in nvme over rdma and nvme over tcp with nvme generate multipath. Delete the ns gendisk is caused by nvmf target subsystem is faulty, then host detect all path keep alive overtime and io timeout. After ctrl-loss-tmo seconds, host will remove fail ctrl and ns gendisk.

That is fine, but it is a problem if it does not correctly drain
inflight I/O, weather it was split or not. And this looks like the wrong
place to address this.

> 	We have reappear this proble in Linux-5.10.136, Linux-5.10.167 and the latest commit in linux-5.10.y, and this patch is only applicable to Linux-5.10.y

So my understanding that this does not reproduce upstream?

> 
> 	Yes , this is absolutely the wrong place to do this . Can i move this modification after nvme_trace_bio_complete?
> 
> 	Do I need to resubmit a patch, if modifications are needed?

Yes, but a backport fix needs to be sent to stable mailing list
(stable@vger.kernel.org) and cc'd to linux-nvme mailing list.

But I don't think that this fix is the correct one. What is needed is
to identify where this was fixed upstream and backport that fix instead.
If that is too involving because of code dependencies, it may be
possible to send an alternative surgical fix, but it needs to be
justified.
