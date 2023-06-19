Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34DEB73561A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 13:47:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbjFSLrG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 07:47:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjFSLq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 07:46:57 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBA05137;
        Mon, 19 Jun 2023 04:46:55 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id af79cd13be357-76243a787a7so243266285a.2;
        Mon, 19 Jun 2023 04:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687175215; x=1689767215;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+DL0OF7uuuNOYsqXOPSGvFJ/HjEnbDBZl0VpUNHErKM=;
        b=nlMY23NVUs2/TV+4X1loiY46xV6KKlwv5w9g1oziAw3FFBWCs1oaRqWXorL4zeWrKM
         yNs/OVxOvtjDlfeamQV8dQP0N1MOXMARRiFBuiXEug37L5tCEVGAoMGS5XAUdUrfqGDH
         zfrPnB25ELPugT/FJzVlpx+Mj9Yg1ThZUj496XCTfiL6d11YRAa2kq0B3qDeUPZXCobI
         t7zP9Qhg0FT+SBkNok5LXxaby6qjtqhW4UGZV5xSusfM/Mox16LA4vlC/QsEaCb3+dw9
         2q6W+6bV7UANVGEnlVFFe/vlIU1OsmmXfS/DBwlIEGhvq786JOecG07G75f3yk1RV1gE
         xuFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687175215; x=1689767215;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+DL0OF7uuuNOYsqXOPSGvFJ/HjEnbDBZl0VpUNHErKM=;
        b=YM306dYf3UcLS2yGMLwOD/4xZjvY8VfLI1aZZqtZZ15C7wEW9xfmaZBYd3R4i7cJ1/
         gJgdp3vNFfmHeXKEx6vlZ2o/+qvA/F0jR7DraSv8Lmfuod9lgwa6AfW5tW0CCgRpfNID
         PeuLXyh/khke5GsaqsgJChRpvLXEB8k4HUMAN00emv/yzH0bGgMgItSu5je60poouXc9
         t4y+ZZUyZJ6Q5jQ//8cobukHE2tuT0M/y7x4geXgRZHLAnzvW9cP0CnamJKZOKs6qzVU
         2rh3JjfBrgv3GIGR+uSkO678yl0RHlpeR46buFekRYZiCTUXvhmkoglnCCL7clJUJdAn
         BubA==
X-Gm-Message-State: AC+VfDy5yakY6jtxlrPWJFuwnd7x9TMMeRafiqgBbptTI6dk3P+RETLe
        Z3qZAZDFM3pwH0UJFB5wHRM=
X-Google-Smtp-Source: ACHHUZ7WJGHmzDBSaJdMmZtj2q9g+F+HBvoIaWkaobPS5K/bb1dOY9PCsUd743jpPaFGn1z+i9saIw==
X-Received: by 2002:a05:6214:401d:b0:626:376b:c95d with SMTP id kd29-20020a056214401d00b00626376bc95dmr12389587qvb.47.1687175214665;
        Mon, 19 Jun 2023 04:46:54 -0700 (PDT)
Received: from localhost (172.174.245.35.bc.googleusercontent.com. [35.245.174.172])
        by smtp.gmail.com with ESMTPSA id a20-20020a0ca994000000b0062de1ed9d15sm8529497qvb.102.2023.06.19.04.46.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 04:46:53 -0700 (PDT)
Date:   Mon, 19 Jun 2023 07:46:53 -0400
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To:     David Howells <dhowells@redhat.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc:     dhowells@redhat.com, netdev@vger.kernel.org,
        Alexander Duyck <alexander.duyck@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        David Ahern <dsahern@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        linux-nvme@lists.infradead.org
Message-ID: <6490402d8401a_37b5c7294c6@willemb.c.googlers.com.notmuch>
In-Reply-To: <755077.1687109321@warthog.procyon.org.uk>
References: <648f353c55ce8_33cfbc29413@willemb.c.googlers.com.notmuch>
 <20230617121146.716077-1-dhowells@redhat.com>
 <20230617121146.716077-11-dhowells@redhat.com>
 <755077.1687109321@warthog.procyon.org.uk>
Subject: Re: [PATCH net-next v2 10/17] nvme: Use sendmsg(MSG_SPLICE_PAGES)
 rather then sendpage
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells wrote:
> Willem de Bruijn <willemdebruijn.kernel@gmail.com> wrote:
> 
> >     struct bio_vec bvec;
> >     struct msghdr msg = { .msg_flags = MSG_SPLICE_PAGES | ... };
> > 
> >     ..
> > 
> >     bvec_set_virt
> >     iov_iter_bvec
> >     sock_sendmsg
> > 
> > is a frequent pattern. Does it make sense to define a wrapper? Same for bvec_set_page.
> 
> I dunno.  I'm trying to move towards aggregating multiple pages in a bvec
> before calling sendmsg if possible rather than doing it one page at a time,
> but it's easier and more obvious in some places than others.

Ok. I just wanted to have your opinion. Fine to leave as is.

Acked-by: Willem de Bruijn <willemb@google.com>

