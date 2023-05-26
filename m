Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8B76712ADF
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 18:41:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236777AbjEZQlN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 12:41:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbjEZQlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 12:41:11 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CCF3194;
        Fri, 26 May 2023 09:41:09 -0700 (PDT)
Received: from [10.10.2.69] (unknown [10.10.2.69])
        by mail.ispras.ru (Postfix) with ESMTPSA id C65D844C1026;
        Fri, 26 May 2023 16:41:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru C65D844C1026
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1685119267;
        bh=RAtqNYbh7M5s0Zh77kXZkFyvhVnNh8Ig8hf9ng8Oukk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=G6VyIKAu6nhnyF2F96l1FQtH5ux+1Km4ytWdzol4QcM8Y5R9yqHb7EO02P1vRMi1X
         8+JVda2cJtSw7Qxw946OzJ+T4bvyKVqvlHSLgPxLQGa+Nn40li3+ptBXQNwnwnbazY
         BGCoQr/Sk2khjpQcwnUG3G75te8L0h8HQ5j3AXaA=
Message-ID: <d3fccbd0-c92e-9aff-8c32-48c1171746c3@ispras.ru>
Date:   Fri, 26 May 2023 19:41:07 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] udp6: Fix race condition in udp6_sendmsg & connect
Content-Language: ru
To:     Eric Dumazet <edumazet@google.com>
Cc:     Paolo Abeni <pabeni@redhat.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        David Ahern <dsahern@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
References: <20230526150806.1457828-1-VEfanov@ispras.ru>
 <27614af23cd7ae4433b909194062c553a6ae16ac.camel@redhat.com>
 <027d28a0-b31b-ab42-9eb6-2826c04c9364@ispras.ru>
 <CANn89iLGOVwW-KHBuJ94E+QoVARWw5EBKyfh0mPkOT+5ws31Fw@mail.gmail.com>
From:   Vlad Efanov <vefanov@ispras.ru>
In-Reply-To: <CANn89iLGOVwW-KHBuJ94E+QoVARWw5EBKyfh0mPkOT+5ws31Fw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sk_dst_set() is called by sk_setup_caps().

sk_dst_set() replaces dst in socket using xchg() call and we still have 
two tasks use one socket but expect different dst in sk_dst_cache.


__sk_dst_set() is rcu protected, but it checks for socket lock.


static inline void
__sk_dst_set(struct sock *sk, struct dst_entry *dst)
{
     struct dst_entry *old_dst;

     sk_tx_queue_clear(sk);
     sk->sk_dst_pending_confirm = 0;
     old_dst = rcu_dereference_protected(sk->sk_dst_cache,
                         lockdep_sock_is_held(sk));
     rcu_assign_pointer(sk->sk_dst_cache, dst);
     dst_release(old_dst);
}


Best regards.

Vlad.


On 26.05.2023 19:00, Eric Dumazet wrote:
> On Fri, May 26, 2023 at 5:58 PM Ефанов Владислав Александрович
> <vefanov@ispras.ru> wrote:
>> Paolo,
>>
>>
>> I don't think that we can just move sk_dst_set() call.
>>
>> I think we can destroy dst of sendmsg task in this case.
>>
> dst are RCU protected, it should be easy to make sure we respect all the rules.
