Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 150DE5F41D8
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 13:18:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbiJDLSg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 07:18:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiJDLSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 07:18:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9598B27B17
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 04:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664882311;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gnepkY0TgZKqop1C+S4YBSp9YXD3uP2dxXvg2KODGSM=;
        b=EGwsTaVyTagGMsaoZEeli9lMdU1nwI0XEND8uBLdr4FnmC9KX+Uf4HaIewdF3lALXMaBoR
        McVMzeHNPMGet/0oweAvYb2HQIbkwRkYk+pfMxXdYARFNrGJm2zxx099evlhUSDAidHEBk
        jJRztIkdJHPUH8YNJhJP+xj1WWcEc9s=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-571-6c_IAEeTOmmx5xtOxlnNyA-1; Tue, 04 Oct 2022 07:18:30 -0400
X-MC-Unique: 6c_IAEeTOmmx5xtOxlnNyA-1
Received: by mail-ed1-f71.google.com with SMTP id dz21-20020a0564021d5500b0045217702048so10741821edb.5
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 04:18:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:cc:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date;
        bh=gnepkY0TgZKqop1C+S4YBSp9YXD3uP2dxXvg2KODGSM=;
        b=epPFDFbtiDBA6k7IUCc+eL66EsEf6qCe0gsoILKNmTdRTy+NQ4CplwMn78o+1QNXjL
         r0cXjY6uR8ccx7cdd5QREfoYvumSWIfRiNvaQ1saOzsyftqSTaLQS259DomEymnIhmSX
         HD74JstO/Lr/+jg4rLgGQYzNbXUGDJmiUNex8H8yFyZgbcU91sf4fdsnJfDxrxTHWBmn
         wofMVTYFuhzABQ/qm9EQ4vGQyjOfJVvS1gURPrO7Q199a2Vq6ttLhDjxss1apIjnAReN
         DfLEZEudtOkKpkyCvtbOdpG46Fk9vOIr+ibMD4VlVBtAJ+iLTDWwZVNRZ3rApYMougtA
         o3Hw==
X-Gm-Message-State: ACrzQf21yeI9Q/AE5uFbnUsNQQNGFo8lWMVbRI8l9jT/rutWIYeMPgLq
        cKsxJKs3R+AhWlmuNvZPTZeOiurUDHnVUAZbsiqQyYoCZsre4PfJKklOJbpIbjR3eNu3ikUZp5X
        tO+Qk2K4lhrMObBThMZ+H+Yh7
X-Received: by 2002:a05:6402:90a:b0:458:ca4d:a2f8 with SMTP id g10-20020a056402090a00b00458ca4da2f8mr12409296edz.230.1664882309712;
        Tue, 04 Oct 2022 04:18:29 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5wxjDzIjFVczqqYoXyO3JSiwl1e1NNSpIMVWjPSFP032LsEqgpeVHfPd879v/3Em5EYMMGTQ==
X-Received: by 2002:a05:6402:90a:b0:458:ca4d:a2f8 with SMTP id g10-20020a056402090a00b00458ca4da2f8mr12409263edz.230.1664882309499;
        Tue, 04 Oct 2022 04:18:29 -0700 (PDT)
Received: from [192.168.41.81] (83-90-141-187-cable.dk.customer.tdc.net. [83.90.141.187])
        by smtp.gmail.com with ESMTPSA id g2-20020a17090604c200b0073d7bef38e3sm6839369eja.45.2022.10.04.04.18.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Oct 2022 04:18:28 -0700 (PDT)
From:   Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <850048b2-ec8b-26db-6ea7-92ed30aab207@redhat.com>
Date:   Tue, 4 Oct 2022 13:18:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Cc:     brouer@redhat.com, "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Wei Fang <wei.fang@nxp.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, imx@lists.linux.dev,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH v2 1/1] net: fec: using page pool to manage RX buffers
Content-Language: en-US
To:     Jakub Kicinski <kuba@kernel.org>,
        Shenwei Wang <shenwei.wang@nxp.com>
References: <20220930204427.1299077-1-shenwei.wang@nxp.com>
 <20221003165157.2bbdae26@kernel.org>
In-Reply-To: <20221003165157.2bbdae26@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 04/10/2022 01.51, Jakub Kicinski wrote:
> On Fri, 30 Sep 2022 15:44:27 -0500 Shenwei Wang wrote:
>> This patch optimizes the RX buffer management by using the page
>> pool. The purpose for this change is to prepare for the following
>> XDP support. The current driver uses one frame per page for easy
>> management.
> 
> I believe this has been applied as:
> 
> commit 95698ff6177b ("net: fec: using page pool to manage RX buffers")
> 
> to net-next. Thanks!
> 

Sorry, that I was not quick enough to review and ACK this patch.
I just went over it quickly and the page_pool adding LGTM, so:

Acked-by: Jesper Dangaard Brouer <brouer@redhat.com>

