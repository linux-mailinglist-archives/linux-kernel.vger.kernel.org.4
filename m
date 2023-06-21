Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8222A738630
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 16:06:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232450AbjFUOGk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 10:06:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232746AbjFUOGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 10:06:20 -0400
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89BA91FF0;
        Wed, 21 Jun 2023 07:05:46 -0700 (PDT)
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-3f3284dff6cso14546345e9.0;
        Wed, 21 Jun 2023 07:05:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687356345; x=1689948345;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CjWf42UQYA0pstvW1dY+TJV0OEUfplMXQFAUiulmBpE=;
        b=fflWFxzSZ3mpNCxCW4OUleSon2OfFBVzBOukFGnfsiqvnZRPnzBv+YFYggxT1ciydY
         rNpiLs+c2OQO+ZVga5KNFnIWsaGWgqHkibDl88cc4CG6xfH1NY5+r2HsXP37ZlptEW8y
         UdnqnZlvxcwIR/twobbhdcZbshnLiYow/nQNfzExJCQ8y+M+aHDBNfbx/18hcD+JoxjS
         PtbfU285HqD9ZR7TbVlBXUbkln2unusQcBwwpv4mY2waqOg+vTRcVC9k+iOAuJbEYP+7
         9edpxx2AKtsLs6QWdThnN2OhmptBcLFk9qYqJGwEGa8GaVSQopxY0B2pKC2RcLB4TmO6
         VaCg==
X-Gm-Message-State: AC+VfDzGbL1bHW8rzjm5ghbGmH0XmA2Jp2SDr9R0TMcH2YSMRVb7YE0a
        iFlMecnEgYLalU/FBroMPf0=
X-Google-Smtp-Source: ACHHUZ5J/At+CMQhWo/1+EsLpTfsPUzSaVSoS/7W21QNNoZrlL3BW+yga2Pv1xjVTP20UsMLpE8hHQ==
X-Received: by 2002:a05:600c:3ba8:b0:3f9:b445:9037 with SMTP id n40-20020a05600c3ba800b003f9b4459037mr5958214wms.2.1687356344797;
        Wed, 21 Jun 2023 07:05:44 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id x23-20020a1c7c17000000b003f72468833esm5114935wmc.26.2023.06.21.07.05.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jun 2023 07:05:44 -0700 (PDT)
Message-ID: <361c3135-51c4-ae81-e4e2-30c54db4eb39@grimberg.me>
Date:   Wed, 21 Jun 2023 17:05:40 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH net-next v3 10/18] nvme/host: Use
 sendmsg(MSG_SPLICE_PAGES) rather then sendpage
Content-Language: en-US
To:     David Howells <dhowells@redhat.com>
Cc:     netdev@vger.kernel.org,
        Alexander Duyck <alexander.duyck@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        David Ahern <dsahern@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Willem de Bruijn <willemb@google.com>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        linux-nvme@lists.infradead.org
References: <87f547b0-7826-b232-cd01-c879b6829951@grimberg.me>
 <20230620145338.1300897-1-dhowells@redhat.com>
 <20230620145338.1300897-11-dhowells@redhat.com>
 <1733833.1687350915@warthog.procyon.org.uk>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <1733833.1687350915@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>> What tree will this be going from btw?
> 
> It's aimed at net-next, as mentioned in the subject line.

ok, thanks.
