Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5237A6BC3C9
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 03:29:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbjCPC3H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 22:29:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbjCPC3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 22:29:05 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A5F99EF9
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 19:28:55 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id i24so358328qtm.6
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 19:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1678933734;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KG1r9kbQqAfNoWzYNzz6bJ+MT9bAShSCfI7fsXqrf/o=;
        b=m3vKxWOfLEopey4P8LpX6utUyayrLDNztqtTK5qlZlMpGozb0jK0xeFY3JBjaJ6r6y
         7+eegABYmlMqBn4DVR3d1oZUZbGLZ2VCQYRu4ZsQY185dgQ9qsabOHxqy6tBopw6gX62
         YMh9Jcc33JpjbMDUseu0hYTNp8xFMosxHw09c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678933734;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KG1r9kbQqAfNoWzYNzz6bJ+MT9bAShSCfI7fsXqrf/o=;
        b=wgDB5qTOLG2acbM8SElpACUagg4qk2yc6AIud15YiGv9woumEx/aT0g9og07JcdhOr
         /ck5wfUwTI3YNZm5tom4U39g9DSg7l2y8kFW40xSoNbPRdogQ0Wf8h+Al9DKmE+fJT+R
         ZudjRlhr+MKFwSuTAgnLu88Lx0SlbHlzU66gkXsN6+EUbvuTgOvzMWvn73gYcSUs7s8K
         SwBFa69HgZjl97ty0hHN5oEq1JMbFhXE7f5eSNW08JArrAXM30+dw8/qEa3mP2fVQc+P
         FoUNwunaasijFryrQ+MPxxwKuXkEVwlv7cAkrIZHLjfh2Th/MvBqv8H/DWiVZZWW4sFV
         wtBQ==
X-Gm-Message-State: AO0yUKX2EVG/jkWakhqve/GwTY69f2RhGvAlHufC8Rb/nGZLw7HflTqf
        LemyRdJbyy3xo337ueIPYZrnOkpia8R4Zl2zuko=
X-Google-Smtp-Source: AK7set9j25ceInnfVhwEylSlTyaH9XxqIg+YiHpbF3rcR/mqN8/4KnIzNfpAVswqTmOuOyySZ5d9Mg==
X-Received: by 2002:ac8:4e88:0:b0:3ba:26a0:d0ee with SMTP id 8-20020ac84e88000000b003ba26a0d0eemr3562630qtp.52.1678933734410;
        Wed, 15 Mar 2023 19:28:54 -0700 (PDT)
Received: from localhost (129.239.188.35.bc.googleusercontent.com. [35.188.239.129])
        by smtp.gmail.com with ESMTPSA id z9-20020ac84309000000b003d2d815825fsm3924906qtm.40.2023.03.15.19.28.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 19:28:53 -0700 (PDT)
Date:   Thu, 16 Mar 2023 02:28:53 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Zqiang <qiang1.zhang@intel.com>, rcu@vger.kernel.org
Subject: Re: [PATCH 4/9] rcu: Register rcu-lazy shrinker only for
 CONFIG_RCU_LAZY=y kernels
Message-ID: <20230316022853.GA110573@google.com>
References: <20230315194349.10798-1-joel@joelfernandes.org>
 <20230315194349.10798-4-joel@joelfernandes.org>
 <ZBJSd9tJ8RU7er1o@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZBJSd9tJ8RU7er1o@localhost.localdomain>
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLACK autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 16, 2023 at 12:19:19AM +0100, Frederic Weisbecker wrote:
> Le Wed, Mar 15, 2023 at 07:43:44PM +0000, Joel Fernandes (Google) a écrit :
> > From: Zqiang <qiang1.zhang@intel.com>
> > 
> > The lazy_rcu_shrink_count() shrinker function is registered even in
> > kernels built with CONFIG_RCU_LAZY=n, in which case this function
> > uselessly consumes cycles learning that no CPU has any lazy callbacks
> > queued.
> > 
> > This commit therefore registers this shrinker function only in the kernels
> > built with CONFIG_RCU_LAZY=y, where it might actually do something useful.
> > 
> > Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> > Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> 
> Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

Thanks!

 - Joel

