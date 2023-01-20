Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEAAF6748FE
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 02:45:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbjATBp3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 20:45:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjATBp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 20:45:27 -0500
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2B709D2A3
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 17:45:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1674179127; x=1705715127;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/JE9hSVjD7t18bE2BYaRoBBydrD5mKkECHvxwn753Ns=;
  b=YyJ2K6DPfn4/mkOKZBGLb/jyA/Nc/031dU9SuCadh4lMKa37IH2V+vPs
   FdnTi5tlwY0QkxOgc4p/iolGEVxByJKPHsimlCxqwS08akYjviTAl1bvq
   /L4lCZg+e98VUDZM+DCCfmsnfFz8JNiRkzfLpqtCdlm+unXwb61zxskbq
   A=;
X-IronPort-AV: E=Sophos;i="5.97,230,1669075200"; 
   d="scan'208";a="288474623"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-iad-1e-m6i4x-529f0975.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2023 01:45:26 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-iad-1e-m6i4x-529f0975.us-east-1.amazon.com (Postfix) with ESMTPS id 70466439BF;
        Fri, 20 Jan 2023 01:45:24 +0000 (UTC)
Received: from EX19D010UWA004.ant.amazon.com (10.13.138.204) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1497.45; Fri, 20 Jan 2023 01:45:23 +0000
Received: from u9aa42af9e4c55a.ant.amazon.com (10.43.160.120) by
 EX19D010UWA004.ant.amazon.com (10.13.138.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.1118.7; Fri, 20 Jan 2023 01:45:23 +0000
From:   Munehisa Kamata <kamatam@amazon.com>
To:     <surenb@google.com>
CC:     <ebiggers@kernel.org>, <hannes@cmpxchg.org>, <hdanton@sina.com>,
        <kamatam@amazon.com>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <mengcc@amazon.com>, <tj@kernel.org>
Subject: Re: another use-after-free in ep_remove_wait_queue()
Date:   Thu, 19 Jan 2023 17:45:07 -0800
Message-ID: <20230120014507.827289-1-kamatam@amazon.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CAJuCfpFZ3B4530TgsSHqp5F_gwfrDujwRYewKReJru==MdEHQg@mail.gmail.com>
References: <CAJuCfpFZ3B4530TgsSHqp5F_gwfrDujwRYewKReJru==MdEHQg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.43.160.120]
X-ClientProxiedBy: EX13D43UWC004.ant.amazon.com (10.43.162.42) To
 EX19D010UWA004.ant.amazon.com (10.13.138.204)
X-Spam-Status: No, score=-11.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-01-19 21:01:42 +0000, Suren Baghdasaryan <surenb@google.com> wrote:
>
> Munehisha, if Tejun confirms this is all valid, could you please post
> a patch replacing wake_up_interruptible() with wake_up_pollfree()? We
> don't need to worry about wake_up_all() because we have a limitation
> of one trigger per file descriptor:
> https://elixir.bootlin.com/linux/latest/source/kernel/sched/psi.c#L1419,
> so there can be only one waiter.

Yes, will do (and will CC stable).


Regards,
Munehisa
