Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F97A73EC38
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 22:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230357AbjFZUyt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 16:54:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbjFZUys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 16:54:48 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0B579E
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 13:54:47 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-666eb03457cso1825792b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 13:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687812887; x=1690404887;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CYCMueTG15Qd1hUiZSyBUCrvl3HLbRhK1eO0hU0rYmo=;
        b=eN4qrz+mMTFYIEfFEyq1QI2MWjiI+eEvtZhA88aK8RuBZimsVRiixPZ7go+NmPC+S+
         OitaiLPChpCnBz7nFnfrLbxLiV2aQ0qbnVn4Yz1QfGhLZEyV+w9xru5+alYYx/OOsbzV
         i2klmHgdT2HHG947IVXKDyis1VWjM5PtFH/OMaf2YbYutHuUakl2O8SfXm7tF2diW1RS
         INPrzAwtUjgA50heG2jeTYAKST8UUGXQxmB1QB5YN7jeSwnmvPDoark3AgXaNF2E+7e6
         ib3GY7cJKytz4uRqiC/Yv0DQGxueK5QfoNc+1vg8BoUQ9fT7C0BiQUUk8QF+QrP1qVME
         ExIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687812887; x=1690404887;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CYCMueTG15Qd1hUiZSyBUCrvl3HLbRhK1eO0hU0rYmo=;
        b=GOfnni+JGpe8Qs5x6El0LcGKTQSPtyGGWPOfYFpLDRFQvUmj1caccm0+UlFv+v58U7
         uTiPmTWHNZ+1olK/4ocBTBczjBxXW/1rpH+8F8v4dBfEWcE6hpTirfEBcQXsr+tgju2C
         +czwtSNJX7ize7s3Q6p+O8GuIn3TPdfbb7PlnMWt4YluqMIWid/QF+02q696mMnYeQAX
         DGtGfhOb5KFn0aDnixUcWc1qf2UfJa3EMv2pJEaGP73CH9vGk9f8KxTlMCN4B2MZsFtR
         jBOtHJJllW7K9ZsY+vfOiieBOFBB8DzMz0oyNaYiFGxi72f0DiBJTjcF7oW4JXbWSGmn
         JcyA==
X-Gm-Message-State: AC+VfDxbIRZqSHsLVD++YFDwMVKWp/3jXTK3y4JWijs0l3jBwT53OMeg
        6AMcaejegy/10D+19tJyXHE=
X-Google-Smtp-Source: ACHHUZ4UJpj0J5WHUC3A67nRWAG5f+vx1KatSNGWN/rxZdlJRnReWXk9i2msPbsvaNUXKbhz0ZEz6g==
X-Received: by 2002:a05:6a20:4e06:b0:125:56d8:6724 with SMTP id gk6-20020a056a204e0600b0012556d86724mr7964586pzb.58.1687812886805;
        Mon, 26 Jun 2023 13:54:46 -0700 (PDT)
Received: from localhost (dhcp-72-235-13-41.hawaiiantel.net. [72.235.13.41])
        by smtp.gmail.com with ESMTPSA id j6-20020aa78006000000b00643355ff6a6sm4354053pfi.99.2023.06.26.13.54.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 13:54:46 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 26 Jun 2023 10:54:46 -1000
From:   Tejun Heo <tj@kernel.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        fuyuanli@didiglobal.com, zwp10758@gmail.com, zyhtheonly@gmail.com,
        zyhtheonly@yeah.net
Subject: Re: [PATCH v3] sched/isolation: add a workqueue parameter onto
 isolcpus to constrain unbound CPUs
Message-ID: <ZJn7Fm4OI1ySPHZg@slm.duckdns.org>
References: <ZJNizvI-7A2hFDoM@slm.duckdns.org>
 <20230622032133.GA29012@didi-ThinkCentre-M930t-N000>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230622032133.GA29012@didi-ThinkCentre-M930t-N000>
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

On Thu, Jun 22, 2023 at 11:22:17AM +0800, tiozhang wrote:
> Motivation of doing this is to better improve boot times for devices when
> we want to prevent our workqueue works from running on some specific CPUs,
> i,e, some CPUs are busy with interrupts.
> 
> Also remove HK_FLAG_WQ from nohz_full to prevent nohz_full overriding
> workqueue's cpu config.
> 
> Suggested-by: Tejun Heo <tj@kernel.org>
> Signed-off-by: tiozhang <tiozhang@didiglobal.com>

Let's just do the workqueue specific parameter. I'll apply the other one to
the workqueue branch after the merge window.

Thanks.

-- 
tejun
