Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3955362EA93
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 01:52:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240718AbiKRAwz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 19:52:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239518AbiKRAwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 19:52:50 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56E6D7ECB9
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 16:52:47 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id h24so2269208qta.9
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 16:52:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aPUhBRM7af6SDX8uROXNjiuNd6PSOuaNj6oZthCIpWo=;
        b=rAzaUE6911mVWba1MSs4jf/a90oQHQpKXWsyHBhgih2dmaNH/csD6ruFRUzTrtlAiJ
         JIBXqvyjZZO9dm+bUSaZD0bPUO8c7WIUkfkoImPro/iqt1XeL7jBFQWEMDMB/iX8LLeW
         I07Esy+LwiPQm/MmqnIzNDtaAhWLhQ9NwO9NE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aPUhBRM7af6SDX8uROXNjiuNd6PSOuaNj6oZthCIpWo=;
        b=c2mbJyytbn7CKU4MPbW7g7kqmAeT/6kHLsPPszPqo3Z5qNiS5hTpjEn48hXVToKjm/
         cFpGImUzkq43TRnVQgtVYwcQEyur3fjrEdyg/b9gdDXiQ+bNWzFEbg1fDvYISV1N7Gnb
         OKf4toepFHxSDNVTSXseH0voH3nDa8GUmy2VGjcxxW923kzerkUTrJNRmbHKUm+4yJ1/
         ewWyjrINHS6ytpfe2LO6bSJj9flF4LNbXLHSMJP5UmCaMYMNFYyB7C67SdcGQgQdWXCZ
         q0D6zVqPzoBRj+lASunzShjm3Mq4fzT5pP7+cz8Ywmqd47ZYVBdjSIe44/dqHYwrKQz8
         j5Ww==
X-Gm-Message-State: ANoB5pntrykBtiZiwYjE7uQoFkjCU0SqOFIn5/TsGaHJ+6kYX5KueED4
        k2+Xk1Lh2pnTI3trJ7W5FJ1f7w==
X-Google-Smtp-Source: AA0mqf6mP6IG1t0XSCLizUCJqtt8ZD65azPy0uNH0KslgRkBnZzAEZ4QQ5DX84fA8JQhPvMDNIbCeg==
X-Received: by 2002:ac8:7457:0:b0:3a5:2e28:b57b with SMTP id h23-20020ac87457000000b003a52e28b57bmr4765744qtr.106.1668732766330;
        Thu, 17 Nov 2022 16:52:46 -0800 (PST)
Received: from localhost (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id k21-20020ac86055000000b003a50c9993e1sm1198082qtm.16.2022.11.17.16.52.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 16:52:45 -0800 (PST)
Date:   Fri, 18 Nov 2022 00:52:45 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Eric Dumazet <edumazet@google.com>
Cc:     linux-kernel@vger.kernel.org, Cong Wang <xiyou.wangcong@gmail.com>,
        David Ahern <dsahern@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org,
        Paolo Abeni <pabeni@redhat.com>, rcu@vger.kernel.org,
        rostedt@goodmis.org, paulmck@kernel.org, fweisbec@gmail.com
Subject: Re: [PATCH rcu/dev 2/3] net: Use call_rcu_flush() for in_dev_rcu_put
Message-ID: <Y3bXXYOeZQPkhQmP@google.com>
References: <20221117031551.1142289-1-joel@joelfernandes.org>
 <20221117031551.1142289-2-joel@joelfernandes.org>
 <CANn89iK345JjXoCAPYK6hZF99zBBWRM1z7xCWbstQJLb4aBGQg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANn89iK345JjXoCAPYK6hZF99zBBWRM1z7xCWbstQJLb4aBGQg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,

On Thu, Nov 17, 2022 at 01:58:18PM -0800, Eric Dumazet wrote:
> On Wed, Nov 16, 2022 at 7:16 PM Joel Fernandes (Google)
> <joel@joelfernandes.org> wrote:
> >
> > In a networking test on ChromeOS, we find that using the new CONFIG_RCU_LAZY
> > causes a networking test to fail in the teardown phase.
> >
> > The failure happens during: ip netns del <name>
> >
> > Using ftrace, I found the callbacks it was queuing which this series fixes. Use
> > call_rcu_flush() to revert to the old behavior. With that, the test passes.
> >
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > ---
> >  net/ipv4/devinet.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
> > index e8b9a9202fec..98b20f333e00 100644
> > --- a/net/ipv4/devinet.c
> > +++ b/net/ipv4/devinet.c
> > @@ -328,7 +328,7 @@ static void inetdev_destroy(struct in_device *in_dev)
> >         neigh_parms_release(&arp_tbl, in_dev->arp_parms);
> >         arp_ifdown(dev);
> >
> > -       call_rcu(&in_dev->rcu_head, in_dev_rcu_put);
> > +       call_rcu_flush(&in_dev->rcu_head, in_dev_rcu_put);
> >  }
> 
> For this one, I suspect the issue is about device refcount lingering ?
> 
> I think we should release refcounts earlier (and only delegate the
> freeing part after RCU grace period, which can be 'lazy' just fine)
> 
> Something like:

The below diff where you reduce refcount before RCU grace period, also makes the
test pass.

If you are Ok with it, I can roll it into a patch with your Author tag and my
Tested-by. Let me know what you prefer?

Also, looking through the patch, I don't see any issue. One thing is
netdev_put() now happens before a grace period, instead of after. But I don't
think that's an issue.

thanks!

 - Joel


> 
> diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
> index e8b9a9202fecd913137f169f161dfdccc16f7edf..e0258aef4211ec6a72d062963470a32776e6d010
> 100644
> --- a/net/ipv4/devinet.c
> +++ b/net/ipv4/devinet.c
> @@ -234,13 +234,21 @@ static void inet_free_ifa(struct in_ifaddr *ifa)
>         call_rcu(&ifa->rcu_head, inet_rcu_free_ifa);
>  }
> 
> +static void in_dev_free_rcu(struct rcu_head *head)
> +{
> +       struct in_device *idev = container_of(head, struct in_device, rcu_head);
> +
> +       kfree(rcu_dereference_protected(idev->mc_hash, 1));
> +       kfree(idev);
> +}
> +
>  void in_dev_finish_destroy(struct in_device *idev)
>  {
>         struct net_device *dev = idev->dev;
> 
>         WARN_ON(idev->ifa_list);
>         WARN_ON(idev->mc_list);
> -       kfree(rcu_dereference_protected(idev->mc_hash, 1));
> +
>  #ifdef NET_REFCNT_DEBUG
>         pr_debug("%s: %p=%s\n", __func__, idev, dev ? dev->name : "NIL");
>  #endif
> @@ -248,7 +256,7 @@ void in_dev_finish_destroy(struct in_device *idev)
>         if (!idev->dead)
>                 pr_err("Freeing alive in_device %p\n", idev);
>         else
> -               kfree(idev);
> +               call_rcu(&idev->rcu_head, in_dev_free_rcu);
>  }
>  EXPORT_SYMBOL(in_dev_finish_destroy);
> 
> @@ -298,12 +306,6 @@ static struct in_device *inetdev_init(struct
> net_device *dev)
>         goto out;
>  }
> 
> -static void in_dev_rcu_put(struct rcu_head *head)
> -{
> -       struct in_device *idev = container_of(head, struct in_device, rcu_head);
> -       in_dev_put(idev);
> -}
> -
>  static void inetdev_destroy(struct in_device *in_dev)
>  {
>         struct net_device *dev;
> @@ -328,7 +330,7 @@ static void inetdev_destroy(struct in_device *in_dev)
>         neigh_parms_release(&arp_tbl, in_dev->arp_parms);
>         arp_ifdown(dev);
> 
> -       call_rcu(&in_dev->rcu_head, in_dev_rcu_put);
> +       in_dev_put(in_dev);
>  }
> 
>  int inet_addr_onlink(struct in_device *in_dev, __be32 a, __be32 b)
