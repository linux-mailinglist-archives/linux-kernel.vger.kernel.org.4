Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99CDD74E36B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 03:23:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbjGKBXf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 21:23:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230363AbjGKBXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 21:23:32 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 142C510C2;
        Mon, 10 Jul 2023 18:23:02 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-666e6ecb52dso2823004b3a.2;
        Mon, 10 Jul 2023 18:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689038532; x=1691630532;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OVuNwbfMW1iG37Ru6hotAgBrvCT0w/byW9moxs6+ZvY=;
        b=ZzgjiS/4Uu7mSWQFarbFQStCYoJTiqoJk4qzWPwi59coAxl7nKaxdOBdyIwFTva2MK
         5L+Z1q9Uf4XJ0OwYZPu/WCkW1a2f+PW/THPVg5QwuI+K/s/AKEK/LQkwRMkK5b4SaTzy
         JzMq1OQccwYj8gHbStU+gvFeg7R4mSJ61/Ppy+dJaO0vNfx8B92iRzJJnsGHk/h6fFrQ
         Ef1nXoaBXxKy/3JP/BY7sOT5SyvF10FSZGuOY8FmSgudxNGlmPQPeWT7DPixcIO35O0K
         TZUB7v/zqqhWV4dYysAnGQna5Cxj71WRvk1TG3kMlbOdVW72IZvxrOGSJuPhgA9tEA6y
         naMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689038532; x=1691630532;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OVuNwbfMW1iG37Ru6hotAgBrvCT0w/byW9moxs6+ZvY=;
        b=JKd/k9VPq4wdQkSPDr+Z2hTIqMoQGUbjigCegq5Cdzyaskpck2v6lFxQ5wXNaSZ7lu
         2GAxiY3PzPrC8/3E8d7NODI07sN7ZBDW/hQuc9VTivhBWZybLpPy88kUaXNdthyYaBBa
         wx6WbclOHH3YxpLmsjS+DcqdM6G4tbIMZKO2pikjMtDudWwbiGQgKthQB01AgnCQpVEt
         H1mmwF5r/bH62cwLG7fCsDVwPwFB4fVD8SwlNroy3kDFb3MN89+DPsS1kxrTQ5/t7A9K
         j5KmXlb/kpCGQvP8xbaHOBN/9ZhyOAfyFOJiI+5YG3V6QMDAmZF5RjTlKrmx18H0lJ7a
         hHmQ==
X-Gm-Message-State: ABy/qLbKBYVJq2Bm6/6MjmRui6c4cwovvSuvAlLtIIymDXw6ItIFm2nP
        iQV3LKDiKP30JH4r8hIXGAk=
X-Google-Smtp-Source: APBJJlF9v6rG7b6+m5yt+Dy6aR4JFSm1uGlbD9cqpVC3G7xVAefgPRJvPR5XCd1jK2rk2gg8o7mecg==
X-Received: by 2002:a05:6a20:7489:b0:126:78b0:993a with SMTP id p9-20020a056a20748900b0012678b0993amr13453586pzd.29.1689038531792;
        Mon, 10 Jul 2023 18:22:11 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:e2fe])
        by smtp.gmail.com with ESMTPSA id p8-20020a1709026b8800b001b8649e52f8sm495107plk.254.2023.07.10.18.22.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 18:22:11 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 10 Jul 2023 15:22:10 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Miaohe Lin <linmiaohe@huawei.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the cgroup tree
Message-ID: <ZKyuwkDWB85Zs9R0@slm.duckdns.org>
References: <20230711111509.1045f32e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230711111509.1045f32e@canb.auug.org.au>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2023 at 11:15:09AM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the cgroup tree, today's linux-next build (arm
> multi_v7_defconfig) produced this warning:
> 
> kernel/cgroup/cgroup.c:503:36: warning: 'cgroup_tryget_css' defined but not used [-Wunused-function]
>   503 | static struct cgroup_subsys_state *cgroup_tryget_css(struct cgroup *cgrp,
>       |                                    ^~~~~~~~~~~~~~~~~
> 
> Introduced by commit
> 
>   1299eb2b0ad5 ("cgroup: minor cleanup for cgroup_extra_stat_show()")

Miaohe, can you send a patch to either add __maybe_unused to
cgroup_tryget_css() or also put it inside CONFIG_CGROUP_SCHED?

Thanks.

-- 
tejun
