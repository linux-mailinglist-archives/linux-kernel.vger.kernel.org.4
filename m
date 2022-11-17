Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDACF62E340
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 18:38:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235045AbiKQRi2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 12:38:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235001AbiKQRiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 12:38:16 -0500
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 061DD7CBAF
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 09:38:13 -0800 (PST)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-13b6c1c89bdso2933713fac.13
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 09:38:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2eg0n52INXltTgVNrVIH+ZsLFa9v6dN3TdcbmSriltQ=;
        b=iZKsFAwvKYkGxl0uttjUp0tImCLGi1yyh+tLFcFJsEcuA04vWHTGhzDrT6If5+djl8
         7UXSm0I9BBnz8b8dFhVD18ZqCUEYmRoJgyZXa4QifamDAx+Tr/IjwRPYza1Pe0Zie5Zs
         sbyw6N9iwrZaJgAyxfPTdg6Dv8nMCJdfXJnQk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2eg0n52INXltTgVNrVIH+ZsLFa9v6dN3TdcbmSriltQ=;
        b=xVz776iIjK3oeP7K8NKRXky04t8wCe6wIFvgbte+d67dmr3nq3d+kQWwUjWwSlRBa1
         iZipbYMW0dEjc+7tqBkQNc7A7ceP3i9netulBj19mhiJ4qXp/08iqr0tCAVJ8i2py08H
         ULxXbyhoGRnJNZEEn/Mf0eX0aUcV1x9WMvdbZ4HEwCxgMPsRLyHhJS2Dgg/VzBwh346X
         qKOn19uYl7UAq6+S6rS0aSA6iPCejiZXtsGE0xV4NQbRuvWHNKACyymrO1NjLyH332E0
         4vBwYw7Sb8DVYXXLADg3rlVBYYrrEJ7uLCabP4yuI3g2gAb/M0hCQbr7P5wqRXJ77EQr
         KM4A==
X-Gm-Message-State: ANoB5pnQh0VK8gJx+TjOowJO+4NsrWN0IMNnJiVV4OiHmZ6C7W0RvPUv
        q28q9AZpqOSezYSEo5MWITf+Avdj4T/kss42GWd/aA==
X-Google-Smtp-Source: AA0mqf47dvqzSrNCPJwwIIiXLsFsDAH4CGJfR2/p7Mji5chyt/6TGdyvjGQFXKuzQibAikDVe0YmTO/Iff7R2KbKYzc=
X-Received: by 2002:a05:6870:591:b0:13b:bbbb:1623 with SMTP id
 m17-20020a056870059100b0013bbbbb1623mr1875946oap.115.1668706692218; Thu, 17
 Nov 2022 09:38:12 -0800 (PST)
MIME-Version: 1.0
References: <20221117031551.1142289-1-joel@joelfernandes.org>
 <20221117031551.1142289-3-joel@joelfernandes.org> <CANn89i+gKVdveEtR9DX15Xr7E9Nn2my6SEEbXTMmxbqtezm2vg@mail.gmail.com>
 <Y3ZaH4C4omQs1OR4@google.com> <CANn89iJRhr8+osviYKVYhcHHk5TnQQD53x87-WG3iTo4YNa0qA@mail.gmail.com>
In-Reply-To: <CANn89iJRhr8+osviYKVYhcHHk5TnQQD53x87-WG3iTo4YNa0qA@mail.gmail.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Thu, 17 Nov 2022 17:38:01 +0000
Message-ID: <CAEXW_YRULY2KzMtkv+KjA_hSr1tSKhQLuCt-RrOkMLjjwAbwKg@mail.gmail.com>
Subject: Re: [PATCH rcu/dev 3/3] net: Use call_rcu_flush() for dst_destroy_rcu
To:     Eric Dumazet <edumazet@google.com>
Cc:     linux-kernel@vger.kernel.org, Cong Wang <xiyou.wangcong@gmail.com>,
        David Ahern <dsahern@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org,
        Paolo Abeni <pabeni@redhat.com>, rcu@vger.kernel.org,
        rostedt@goodmis.org, paulmck@kernel.org, fweisbec@gmail.com,
        jiejiang@google.com, Thomas Glexiner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2022 at 5:17 PM Eric Dumazet <edumazet@google.com> wrote:
>
> On Thu, Nov 17, 2022 at 7:58 AM Joel Fernandes <joel@joelfernandes.org> wrote:
> >
> > Hello Eric,
> >
> > On Wed, Nov 16, 2022 at 07:44:41PM -0800, Eric Dumazet wrote:
> > > On Wed, Nov 16, 2022 at 7:16 PM Joel Fernandes (Google)
> > > <joel@joelfernandes.org> wrote:
> > > >
> > > > In a networking test on ChromeOS, we find that using the new CONFIG_RCU_LAZY
> > > > causes a networking test to fail in the teardown phase.
> > > >
> > > > The failure happens during: ip netns del <name>
> > >
> > > And ? What happens then next ?
> >
> > The test is doing the 'ip netns del <name>' and then polling for the
> > disappearance of a network interface name for upto 5 seconds. I believe it is
> > using netlink to get a table of interfaces. That polling is timing out.
> >
> > Here is some more details from the test's owner (copy pasting from another
> > bug report):
> > In the cleanup, we remove the netns, and thus will cause the veth pair being
> > removed automatically, so we use a poll to check that if the veth in the root
> > netns still exists to know whether the cleanup is done.
> >
> > Here is a public link to the code that is failing (its in golang):
> > https://source.chromium.org/chromiumos/chromiumos/codesearch/+/main:src/platform/tast-tests/src/chromiumos/tast/local/network/virtualnet/env/env.go;drc=6c2841d6cc3eadd23e07912ec331943ee33d7de8;l=161
> >
> > Here is a public link to the line of code in the actual test leading up to the above
> > path (this is the test that is run:
> > network.RoutingFallthrough.ipv4_only_primary) :
> > https://source.chromium.org/chromiumos/chromiumos/codesearch/+/main:src/platform/tast-tests/src/chromiumos/tast/local/bundles/cros/network/routing_fallthrough.go;drc=8fbf2c53960bc8917a6a01fda5405cad7c17201e;l=52
> >
> > > > Using ftrace, I found the callbacks it was queuing which this series fixes. Use
> > > > call_rcu_flush() to revert to the old behavior. With that, the test passes.
> > >
> > > What is this test about ? What barrier was used to make it not flaky ?
> >
> > I provided the links above, let me know if you have any questions.
> >
> > > Was it depending on some undocumented RCU behavior ?
> >
> > This is a new RCU feature posted here for significant power-savings on
> > battery-powered devices:
> > https://lore.kernel.org/rcu/20221017140726.GG5600@paulmck-ThinkPad-P17-Gen-1/T/#m7a54809b8903b41538850194d67eb34f203c752a
> >
> > There is also an LPC presentation about the same, I can dig the link if you
> > are interested.
> >
> > > Maybe adding a sysctl to force the flush would be better for functional tests ?
> > >
> > > I would rather change the test(s), than adding call_rcu_flush(),
> > > adding merge conflicts to future backports.
> >
> > I am not too sure about that, I think a user might expect the network
> > interface to disappear from the networking tables quickly enough without
> > dealing with barriers or kernel iternals. However, I added the authors of the
> > test to this email in the hopes he can provide is point of views as well.
> >
> > The general approach we are taking with this sort of thing is to use
> > call_rcu_flush() which is basically the same as call_rcu() for systems with
> > CALL_RCU_LAZY=n. You can see some examples of that in the patch series link
> > above. Just to note, CALL_RCU_LAZY depends on CONFIG_RCU_NOCB_CPU so its only
> > Android and ChromeOS that are using it. I am adding Jie to share any input,
> > he is from the networking team and knows this test well.
> >
> >
>
> I do not know what is this RCU_LAZY thing, but IMO this should be opt-in

You should read the links I sent you. We did already try opt-in,
Thomas Gleixner made a point at LPC that we should not add new APIs
for this purpose and confuse kernel developers.

> For instance, only kfree_rcu() should use it.

No. Most of the call_rcu() usages are for freeing memory, so the
consensus is we should apply this as opt out and fix issues along the
way. We already did a lot of research/diligence on seeing which users
need conversion.

> We can not review hundreds of call_rcu() call sites and decide if
> adding arbitrary delays cou hurt .

That work has already been done as much as possible, please read the
links I sent.

Thanks.
