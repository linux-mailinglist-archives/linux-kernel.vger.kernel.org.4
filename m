Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7AD15FA385
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 20:44:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbiJJSoF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 14:44:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiJJSoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 14:44:03 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30D662A435
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 11:44:03 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id 3so9942355pfw.4
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 11:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oW0CWE8Mxy7BHzfjbHZaEpFCvHoZ9BdQrgIi0GsS5pg=;
        b=HBQr4dDdpf3mT5RDIWG74wsOzV7ICg/rBuSjZfqByG/lxaM7w9C2bfK/gusuGelyLo
         0DSVzpTaICFc9YAUanhX5Czp9U6LJZD9BMEZr6fB232sb34iFte+ezqoqpVWcM6WZI6O
         K8y8FoAHEdPopwM0i5brACF2/6PfWi8OKRU2qDnSxJDtxaFKuoHvEEsRheoPlLinDwfu
         gEx09XM+P0clmcxK7P1vUdRpQejmr+viXg0zNTuUqYn7wh0N09MlX6879ro5WhPQ1a8z
         CwAlA62q3dW474B1gysvfetHLXf2E0Al8+hAOv529RAHt5AD5q5YBg1tc9QLUxt32wO/
         hbNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oW0CWE8Mxy7BHzfjbHZaEpFCvHoZ9BdQrgIi0GsS5pg=;
        b=QiT5WQ6vj7f1g9KinMfVKVQs+XnUcx5GxGbU5EsTADJ9hOyQoZlMjg6jjJfqVJVPKU
         9s7WbN4+bjHhTRW/IZTaIPXpBXV9ofD2F9cK7vRfmJXx3aQzBaFicd7wW+6FjVhbKKwY
         sDmrpSAFNCd4yS5y/6znj9u46SouLOgjEqBKfbRMBIg7W7ys5sl8fonxapK5yt0ICx2E
         03QwEswmzrpyYqIkuiy5YUdVIkIKml3aMwFlE83N+PwvlcF+0XvuLcm2Q2SROvBfVu1k
         cS4d43HHLcEQ/3JwwF5ECxFhempzDZ6LO/seN2dybRHR6KFdGCu7X5AdHRzt0Sj8d0ko
         O+bA==
X-Gm-Message-State: ACrzQf2HRc/iBi8gfMKoU9nrAdC5x3RY50YUkzU7Z52QAIGP3fSb45HU
        eKdEae7GgavM+cFCxF5rJDd2Nh9ddQqoZw==
X-Google-Smtp-Source: AMsMyM6HmnyK0y2ub1a69fpP+XWXvOpr20Hxek6JGJTZjnR/6YmiymBrgkoxYR68tatbsur22dAmqg==
X-Received: by 2002:a17:902:ea03:b0:180:b53f:6da with SMTP id s3-20020a170902ea0300b00180b53f06damr14648660plg.69.1665427431906;
        Mon, 10 Oct 2022 11:43:51 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id a67-20020a621a46000000b0055f98a2c64bsm7559698pfa.142.2022.10.10.11.43.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 11:43:51 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 10 Oct 2022 08:43:50 -1000
From:   Tejun Heo <tj@kernel.org>
To:     "Christian A. Ehrhardt" <lk@c--e.de>
Cc:     Christian Brauner <brauner@kernel.org>,
        syzbot <syzbot+534ee3d24c37c411f37f@syzkaller.appspotmail.com>,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com,
        Yosry Ahmed <yosryahmed@google.com>
Subject: Re: [PATCH] cgroup: Fix crash with CLONE_INTO_CGROUP and v1 cgroups
Message-ID: <Y0Rn5qzP6MjayoCz@slm.duckdns.org>
References: <000000000000385cbf05ea3f1862@google.com>
 <00000000000028a44005ea40352b@google.com>
 <Y0CbtVwW6+QIYJdQ@slm.duckdns.org>
 <Y0HBlJ4AoZba93Uf@cae.in-ulm.de>
 <20221009084039.cw6meqbvy4362lsa@wittgenstein>
 <Y0LITEA/22Z7YVSa@cae.in-ulm.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y0LITEA/22Z7YVSa@cae.in-ulm.de>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Sun, Oct 09, 2022 at 03:10:36PM +0200, Christian A. Ehrhardt wrote:
> 
> Since commit f3a2aebdd6, Version 1 cgroups no longer cause an
> error when used with CLONE_INTO_CGROUP. However, the permission
> checks performed during clone assume a Version 2 cgroup.
> 
> Restore the error check for V1 cgroups in the clone() path.
> 
> Reported-by: syzbot+534ee3d24c37c411f37f@syzkaller.appspotmail.com
> Link: https://lore.kernel.org/lkml/000000000000385cbf05ea3f1862@google.com/
> Fixes: f3a2aebdd6 ("cgroup: enable cgroup_get_from_file() on cgroup1")
> Signed-off-by: Christian A. Ehrhardt <lk@c--e.de>

This feels too error prone. I'd rather revert the original commit. Yosry,
imma revert f3a2aebdd6. Can you please add a separate function which allows
looking up IDs for cgroup1 hierarchies if absolutely necessary? But,
frankly, given how inherently confusing using IDs for cgroup1 hierarchies is
(fd for cgroup1 identifies both the hierarchy and the cgroup, id is
inherently partial which is super confusing), I'd rather just not do it.

Thanks.

-- 
tejun
