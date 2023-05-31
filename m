Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF5DF71896D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 20:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbjEaSdb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 14:33:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjEaSd3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 14:33:29 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18C13B2;
        Wed, 31 May 2023 11:33:28 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-5149b63151aso88091a12.3;
        Wed, 31 May 2023 11:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685558006; x=1688150006;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=buUAsYpGe1TJXNZB34CE38fSA+mccfTTNpY51fAljHE=;
        b=agzLnmVvQLyfbvlFIo2Qgm+/9TnQK2BVa/t/pucjNWa/QTUlTb4HFPlSk7pAwVrAiI
         e7p+ksqNewnEUQ2VRF7Nl75pQNFcQME7lZ/Jq1yn9Xhvjpaj8t8LVKJLB9lkj+FfUhhk
         v89zwEga0fmMo+yK98qLPvfpEswqoOcF5Jj3Jwn2YY1vPL+8rFeikuffhWFp5A4+RxVx
         8+O5dzTg38qjz8pKfPazurh+aUat70x6akJFvMlKo71LaZK7LHuX5UWAgs485KbGw7RL
         LvXMcnD+ednbQ6DPnSFP5MqTpGy/7czqOC8Uwezqzc+kenCdy5x3DzKnOa51pjXpVeUa
         UMjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685558006; x=1688150006;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=buUAsYpGe1TJXNZB34CE38fSA+mccfTTNpY51fAljHE=;
        b=Ae5iJjxik25EZ4Z25B2Wp9WaetxIBIjalzGp59lGtXLaZlzokBQXsZRWVtgrxsJ9f7
         ZSC7B0jSKq4JsDK4rVQ9Txd9DDv0e03EQWYDdueyixtmFLsDKzkL1wD1fyZGnTj7q50g
         elYohweqbOGHe8ZUdTNhE+dx9aalTVpmsppjIrj1R257LyET0qa4Lz/O5KHQDtXEEo1W
         heyViREav5CZQpc5yyh6bgicQmyoyv8iMKW3Lbs+VdJszoSHbCcK9lXLikq0eNkJupcO
         ccJTExX3gxAECTXSxowSQBToyHV7MghSkJfEzxIy5xnkYRyN/X8g47aDALK8lVaY7Wue
         XiuQ==
X-Gm-Message-State: AC+VfDzmPFi43vTE+IXUbsHrhkv7nbZAIT5aL27UASjszemhgj2R/OCF
        Xsrv2OWpJEOBDAaLVYSKSyLwr5v2gIH0Wg==
X-Google-Smtp-Source: ACHHUZ6pDDMwtYftfM6OWJhG0jtXy7xWoRm/gCiNWZ5cbXC25pURukXPdx30WqV8DCeUUWqd8RiZ+w==
X-Received: by 2002:a17:907:ea4:b0:94f:2852:1d2b with SMTP id ho36-20020a1709070ea400b0094f28521d2bmr6787313ejc.72.1685558006031;
        Wed, 31 May 2023 11:33:26 -0700 (PDT)
Received: from skbuf ([188.27.184.189])
        by smtp.gmail.com with ESMTPSA id d5-20020a170906640500b0094ef923a6ccsm9366064ejm.219.2023.05.31.11.33.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 11:33:25 -0700 (PDT)
Date:   Wed, 31 May 2023 21:33:23 +0300
From:   Vladimir Oltean <olteanv@gmail.com>
To:     netdev@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>,
        Vinicius Costa Gomes <vinicius.gomes@intel.com>,
        linux-kernel@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
        Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>,
        Peilin Ye <yepeilin.cs@gmail.com>,
        Pedro Tammela <pctammela@mojatatu.com>
Subject: [PATCH net-next 0/5] Improve the taprio qdisc's relationship with
 its children
Message-ID: <20230531183323.eozihhbax4tzho6w@skbuf>
X-Mailer: git-send-email 2.34.1
References: <20230531182758.5u5hv5leobeinxih@skbuf>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230531182758.5u5hv5leobeinxih@skbuf>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Has anyone received this message? I guess at least vger and kuba@kernel.org
rejected it, because I got this bounce email:

kernel.org suspects your message is spam and rejected it.

Error:
550 5.7.350 Remote server returned message detected as spam -> 554 5.7.1
Service unavailable; Helo command [EUR04-DB3-obe.outbound.protection.outlook.com]
blocked using dbl.spamhaus.org; Error: open resolver;
https://www.spamhaus.org/returnc/pub/34.216.226.155

Message rejected by: smtp.kernel.org

Interestingly, if I click the link above, it says "This is not due to an
issue with your email set-up", so I'm not sure what to believe...

----- Forwarded message from Vladimir Oltean <vladimir.oltean@nxp.com> -----

Date: Wed, 31 May 2023 20:39:23 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang
 <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Vinicius Costa
 Gomes <vinicius.gomes@intel.com>, linux-kernel@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, Muhammad Husaini Zulkifli
 <muhammad.husaini.zulkifli@intel.com>, Peilin Ye <yepeilin.cs@gmail.com>,
 Pedro Tammela <pctammela@mojatatu.com>
Subject: [PATCH net-next 0/5] Improve the taprio qdisc's relationship with
 its children
X-Mailer: git-send-email 2.34.1

Prompted by Vinicius' request to consolidate some child Qdisc
dereferences in taprio:
https://lore.kernel.org/netdev/87edmxv7x2.fsf@intel.com/

I remembered that I had left some unfinished work in this Qdisc, namely
commit af7b29b1deaa ("Revert "net/sched: taprio: make qdisc_leaf() see
the per-netdev-queue pfifo child qdiscs"").

This patch set represents another stab at, essentially, what's in the
title. Not only does taprio not properly detect when it's grafted as a
non-root qdisc, but it also returns incorrect per-class stats.
Eventually, Vinicius' request is addressed too, although in a different
form than the one he requested (which was purely cosmetic).

Review from people more experienced with Qdiscs than me would be
appreciated. I tried my best to explain what I consider to be problems.
I am deliberately targeting net-next because the changes are too
invasive for net - they were reverted from stable once already.

Vladimir Oltean (5):
  net/sched: taprio: don't access q->qdiscs[] in unoffloaded mode during
    attach()
  net/sched: taprio: keep child Qdisc refcount elevated at 2 in offload
    mode
  net/sched: taprio: try again to report q->qdiscs[] to qdisc_leaf()
  net/sched: taprio: delete misleading comment about preallocating child
    qdiscs
  net/sched: taprio: dump class stats for the actual q->qdiscs[]

 net/sched/sch_taprio.c | 60 ++++++++++++++++++++++++------------------
 1 file changed, 35 insertions(+), 25 deletions(-)

-- 
2.34.1


----- End forwarded message -----
