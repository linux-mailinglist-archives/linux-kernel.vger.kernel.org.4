Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8806B7112CC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 19:49:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233523AbjEYRto (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 13:49:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjEYRtm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 13:49:42 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12C02B6
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 10:49:39 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id af79cd13be357-75affe9d7feso148006185a.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 10:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20221208.gappssmtp.com; s=20221208; t=1685036978; x=1687628978;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y53fCd8Q+55p0znlINKSHlCkfln7E+iB7ORmKuvgOhc=;
        b=SeedwvHMZBcM/2aUs7FnSTIMs2gE/mOLWJzXxQ812wgTeOvcP825IesFLkFvR0Kx8F
         Ku6kposCaXrB/6oYY7MrlNNUKTJkP1jC9+b03/FKRDCoWBUsbw/TbmQRlRqPWD3C4Rwb
         UlJAvi4NJqDbCPadTOKvx0j3yVKBCJmgzaJ/9KqDrOnnIjyh+FRWkgySN8lXqgWvx9V0
         YOXmq18Sml6YisR+PqYd2T9ZkQE0OvrnLxRui4yO++x4X9rqHLRGwKZPbIgsBLo86ddL
         3qpNmbudMTZHe2zuEPtZaiQ5JKR2gDlHti7FcZ3U1kjxIv5EY/82dIA255eLUvBpIQGS
         aboA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685036978; x=1687628978;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y53fCd8Q+55p0znlINKSHlCkfln7E+iB7ORmKuvgOhc=;
        b=Wn7HKzv7hDgZ9NUXvie4iWSbGEv25niXpHOgZPQfWkHIbCORhfU/HAjOQTQ3AcRBpl
         NNA4HFxdUIdovq9ncCRcC/6MVs48HsDDVVQCrBoMD512klhZT1UunhBRSvTyzTvgxjaH
         YuTdlb0OaXbfOQP+ddAso1CTf/DhgB+ChHzzPQ4EYiRTIIGeGkb6T5gGQ4m7sdnb/a3F
         HoOLOsOehE7HcYK2UI2IhjbE+xli0qTYCs4R7+V7HJLC8OY70Bp5zm2tMAmm2qpIJxnf
         ziYNnGu+PYMADT2D2Ohh7Wl6dlMHLBFEwUNu9DXHgLPNJY4ZPQT+4LMFl6s61+E/j9Ew
         fTBA==
X-Gm-Message-State: AC+VfDwG8kin3CNjcIaOdb8gDGMnQIsE01jsDKyaBFZ49ypYCGJxNrIn
        ndTIps6vq4d13dmVY16+5OOs4g==
X-Google-Smtp-Source: ACHHUZ7c0N0miOKWVgMwO2DSVHVI5CelXnbuwk63+24Zflw8PSFuwqk4nECIBKR93grSjr5PHrtWow==
X-Received: by 2002:a05:620a:4249:b0:75b:23a0:deb4 with SMTP id w9-20020a05620a424900b0075b23a0deb4mr12674435qko.50.1685036978283;
        Thu, 25 May 2023 10:49:38 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:8bb6])
        by smtp.gmail.com with ESMTPSA id j27-20020a05620a001b00b0074d3233487dsm539288qki.114.2023.05.25.10.49.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 May 2023 10:49:37 -0700 (PDT)
Date:   Thu, 25 May 2023 13:49:37 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     surenb@google.com, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: Re: [PATCH] sched/psi: make psi_cgroups_enabled static
Message-ID: <20230525174937.GA34467@cmpxchg.org>
References: <20230525103428.49712-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230525103428.49712-1-linmiaohe@huawei.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 25, 2023 at 06:34:28PM +0800, Miaohe Lin wrote:
> The static key psi_cgroups_enabled is only used inside file psi.c.
> Make it static.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

This was previously submitted by Tom:
https://lore.kernel.org/lkml/20230405163602.1939400-1-trix@redhat.com/

Peter, could you please pick this up?

Thanks!
