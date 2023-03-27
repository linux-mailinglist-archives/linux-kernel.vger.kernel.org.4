Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E96DE6CAC20
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 19:48:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231873AbjC0Rr6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 13:47:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjC0Rr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 13:47:56 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CF9D19B1;
        Mon, 27 Mar 2023 10:47:53 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id g17so12522770lfv.4;
        Mon, 27 Mar 2023 10:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679939271;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XSGu4vIj//WIk4Ld+SYTvg7ZUwFYk4EeE9Oa1KnGRbM=;
        b=i8wYPGsy6M4lEj6OzMDEXA3LsCESJ777PJc8SVvBiJ6Gebc15NX5RTDtdr58v946Dh
         BlPdGP71yO0xmmoZe4cmfBVWcWLorojRKpp/Eb0tEeA5k4Oz+/bUKKZ37Kt30/t3CX6r
         GPeqDw54bXcrNLi2JkfhFjuDKgOzwEciPV0v6qQSD2YsoHCZ/JfMH+kwlYZoGKIgrn7F
         EvRDUBSKrHTRnMFFR8W1GEwjuvD24n3aWrTtszW150rkLlqqm8FEnQ403wqlKoo0ZrJ3
         CtY4wPY6UUF6e1MfuyTkR9vYEUfMhu084W7d1cRyNOQaZ0XcE0u4Rzhf3J8b+a9xVcQb
         Scgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679939271;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XSGu4vIj//WIk4Ld+SYTvg7ZUwFYk4EeE9Oa1KnGRbM=;
        b=B1Gzao/x+eQ0fK+/KBRapOTw0r7A58A14oobGBz4NVPjL76v4nGaDT2NLyyAVjTktE
         EReJaqiMRolMwA360AsU7pMx7wI5+5CFxfwIrCzGfxR/gwFzDeuC/2XV+xmcvxNBMn+o
         Un9reVtgdgI3kh6P8MejFqf37IYfaAIKCGY/IyaHUWlQ7dJJQbn5GntohGX86KCRO7z1
         CiY91vKRqj02kZKe9TPbiTFWbW1SCeLv6CDTm7HuN+bnKrdkhq3ukdOLfl0nvQY2heJP
         /MtMVdrJAlNA3ul7z90s6dnR9h9o9UghF2QIMHMj0feVZ0eQfDDpCLF1u3EdTVmdmBjv
         /Dwg==
X-Gm-Message-State: AAQBX9fA5kyCwgdx3L+tE4UXtFBjM8PpZawx2XHazL0tUtnmzFkDuh5z
        P8LYpc2Xu++Cb6XB07wpH9c=
X-Google-Smtp-Source: AKy350aSovntrLLGTfxwd5Lhc3e0i0bW8AGOoRdbU92UHOyzWB6ejX7tDAHDJSDGc9T17VR4WGxbVQ==
X-Received: by 2002:ac2:5a46:0:b0:4b5:26f3:2247 with SMTP id r6-20020ac25a46000000b004b526f32247mr3527745lfn.69.1679939271498;
        Mon, 27 Mar 2023 10:47:51 -0700 (PDT)
Received: from pc636 (host-90-233-209-50.mobileonline.telia.com. [90.233.209.50])
        by smtp.gmail.com with ESMTPSA id q5-20020ac25145000000b004d3d43c7569sm4724580lfd.3.2023.03.27.10.47.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 10:47:51 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Mon, 27 Mar 2023 19:47:48 +0200
To:     "Zhang, Qiang1" <qiang1.zhang@intel.com>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        RCU <rcu@vger.kernel.org>,
        "quic_neeraju@quicinc.com" <quic_neeraju@quicinc.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH 1/1] Reduce synchronize_rcu() waiting time
Message-ID: <ZCHWxD7D9N7v115O@pc636>
References: <20230321102748.127923-1-urezki@gmail.com>
 <IA1PR11MB617169A10E6DDE3C1168605D89819@IA1PR11MB6171.namprd11.prod.outlook.com>
 <ZBnKKZsSpI8aAk9W@pc636>
 <PH0PR11MB58805561777B77DC69E87711DA8B9@PH0PR11MB5880.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <PH0PR11MB58805561777B77DC69E87711DA8B9@PH0PR11MB5880.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 27, 2023 at 11:21:23AM +0000, Zhang, Qiang1 wrote:
> > > From: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > > Sent: Tuesday, March 21, 2023 6:28 PM
> > > [...]
> > > Subject: [PATCH 1/1] Reduce synchronize_rcu() waiting time
> > > 
> > > A call to a synchronize_rcu() can be expensive from time point of view.
> > > Different workloads can be affected by this especially the ones which use this
> > > API in its time critical sections.
> > > 
> > 
> > This is interesting and meaningful research. ;-)
> > 
> > > For example in case of NOCB scenario the wakeme_after_rcu() callback
> > > invocation depends on where in a nocb-list it is located. Below is an example
> > > when it was the last out of ~3600 callbacks:
> >
> 
> 
> 
> Can it be implemented separately as follows?  it seems that the code is simpler
> (only personal opinion)  😊.
> 
> But I didn't test whether this reduce synchronize_rcu() waiting time
> 
> +static void rcu_poll_wait_gp(struct rcu_tasks *rtp)
> +{
> +       unsigned long gp_snap;
> +
> +       gp_snap = start_poll_synchronize_rcu();
> +       while (!poll_state_synchronize_rcu(gp_snap))
> +               schedule_timeout_idle(1);
> +}
> +
> +void call_rcu_poll(struct rcu_head *rhp, rcu_callback_t func);
> +DEFINE_RCU_TASKS(rcu_poll, rcu_poll_wait_gp, call_rcu_poll,
> +                 "RCU Poll");
> +void call_rcu_poll(struct rcu_head *rhp, rcu_callback_t func)
> +{
> +       call_rcu_tasks_generic(rhp, func, &rcu_poll);
> +}
> +EXPORT_SYMBOL_GPL(call_rcu_poll);
> +
> +void synchronize_rcu_poll(void)
> +{
> +       synchronize_rcu_tasks_generic(&rcu_poll);
> +}
> +EXPORT_SYMBOL_GPL(synchronize_rcu_poll);
> +
> +static int __init rcu_spawn_poll_kthread(void)
> +{
> +       cblist_init_generic(&rcu_poll);
> +       rcu_poll.gp_sleep = HZ / 10;
> +       rcu_spawn_tasks_kthread_generic(&rcu_poll);
> +       return 0;
> +}
> 
Uh.. I am working on v2 of original patch where i need to add a Kconfig
parameter. You are inventing a new API :)

--
Uladzislau Rezki
