Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03E2F6D69BA
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 19:02:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235509AbjDDRCK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 13:02:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbjDDRCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 13:02:06 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06763D1
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 10:02:02 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id p203so39471525ybb.13
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 10:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1680627721;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EZxuHLFtNW6DOyg0Up2V+fzvewo/xPE26/VxJVS43KM=;
        b=pgXOVRk9JdN65LKkNabkbTgzcBobSkNY05vjQSWL2ErDYSW2u6yUUWyhVR4+r2GJYt
         Rf4AXFDHOXCQSthx35gkOeGIBo1tbYTlBSlk4MAF6EFssBpLhT+65wJ3UG2dgAv8tT2l
         Uc6L3Z3flUUKu6E2pXFBh/K2Xsr7UnuH1oXJc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680627721;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EZxuHLFtNW6DOyg0Up2V+fzvewo/xPE26/VxJVS43KM=;
        b=aqJqJqG9VlNmB3tgS0bQJK8+rBa8GmSfBNyrYpzXqRRkg5i7htv7imivsIjmPQ4bWR
         9lpczf/8DOtuDGT8XRzs2x4ZBug7ITzubX4JNT3gHoech/t7uTZLt1mdZ4AWMEat0upE
         mGS8j7XXfXmwtEurqbfrPM7yXgZ4mVPUxxQiIB0S/Vi4A9Vu5ZBJiByJBjMdA9J1lF0x
         Gz3N7cKmoHiyg4RNb0xF57Ft0fbsjU3ulZHoqL2e1mawyk3k+uZ+W+LEdhe8rwCGn8cs
         23fWUUdUkZBDWSPuFG3MYZvAk6GdETlAHg7KJ35R3eFeB4k6zQmnB0LvRuYyEPd7XqDg
         GlpA==
X-Gm-Message-State: AAQBX9dRVxQPM3A5/0O3WnzXjp58MPUR/O6ZtlAGdBNiE3U2ygSo9CTn
        Wze6ca7VkQ7LQqdCaifyTHI4EnCdx2rziJQnFaVw8w==
X-Google-Smtp-Source: AKy350Z7TmeWoGKs4uFwycO48nTq5+V4hfheLwSgeAH2M5abZ8O02ny5Sy+MxzKC+4uu8XORDbRs7SbiinLtq9cYgD0=
X-Received: by 2002:a25:d984:0:b0:b69:fab9:de39 with SMTP id
 q126-20020a25d984000000b00b69fab9de39mr2006909ybg.2.1680627721079; Tue, 04
 Apr 2023 10:02:01 -0700 (PDT)
MIME-Version: 1.0
References: <f1b6cd5f-f0b7-4748-abd5-0dcfef0ce126@paulmck-laptop>
 <20230404135741.GB471948@google.com> <f2ae6531-1443-47e0-8897-0a47ca61ffec@paulmck-laptop>
In-Reply-To: <f2ae6531-1443-47e0-8897-0a47ca61ffec@paulmck-laptop>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Tue, 4 Apr 2023 13:01:50 -0400
Message-ID: <CAEXW_YSSSFrRpb8bM0=ebBkJHQdFGuEWRAUqGesdonk9bNohTg@mail.gmail.com>
Subject: Re: [PATCH rcu 0/20] Further shrink srcu_struct to promote cache locality
To:     paulmck@kernel.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, rostedt@goodmis.org, hch@lst.de
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[..]
> > The "improperly set" thingies are perhaps Kconfig on ARM64 setting some KVM
> > options slightly differently. I have seen that before as well on this board.
>
> Agreed, and one of the things on the long list is to allow arch-specific
> settings for those options.
>
> The CONFIG_SMP warnings are interesting, though.  Does arm64 disallow
> !SMP builds?  ;-)

Yes, it looks like it. As per arch/arm64/Kconfig, CONFIG_SMP is always
'y' and cannot be set.

config SMP
        def_bool y

Thanks.
