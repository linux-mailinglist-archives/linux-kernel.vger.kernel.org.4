Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10DA162DCB6
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 14:27:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240059AbiKQN0x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 08:26:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234146AbiKQN0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 08:26:48 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 007D559FF0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 05:26:46 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id c15so1008174qtw.8
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 05:26:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KZKDGywksPC2VKoAr50lKKIAMxnyrxtKe798RUQ67C8=;
        b=nW22d0AkvFDqi0/36i4jyFmsCYj+HPbm4fDGwpKz9UhyCY33HEmokqBTgN+fehY1ou
         +zi3rxyzFMSOlFyNHHnT7/wFf0mGNvjAUwSOzLEdqu0FhUwsg93a+fvASIpddmOybBT6
         DPQXtRhVjcRaefRIp86JeA2bvEW+zSxVoGDCjZqKATjKKQQ3DxwAla1kZ6sLAkUwWu+5
         GgJ9tWVFNm8hNfjQ5qh5WNbV7CAvTXzK4193PWX3ia++2gQXEgIaAqGYVc8mXaFz1Caz
         Y3RjPADGlZli6DhCkkBJo+p3B2dm4dSQ5wCipPsS65SZFRqTvdF9vaTzmKg4x6x8aVR0
         vdsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KZKDGywksPC2VKoAr50lKKIAMxnyrxtKe798RUQ67C8=;
        b=n9zoVDPaOORKjh/67N0Vn3h44TCfobjhJf/vk88c6qLimGD6Ly93Qwp5P+vJ5zRoB/
         4IOY83X7JOgjoqbX5AJcWTIGhLaG0Aoqyh+5muANCLPkn1ziuc8ib6eIhpFtSu+jOmWG
         Snr5uSGNvpjeU6+YW2e5wQ35zwJzupKD9NQoqxuAARGTyxxVp9DkYsYIdTubdqP7hxjl
         E1drGbbQ8yavzY+zCv0/+LYs3J3h3G/nlo/9zXjjXeI93Xd0ITr49Qb2RYmjZN/Mpjsf
         vMlN4Wg0/ZBUK3wvv3SqrKooYIYwlEZNKRnhCrnW+6ms3FpoSBS6yHWzv43bzTmH6OGq
         Dz/g==
X-Gm-Message-State: ANoB5pl6kWyQ709ceiU1xFqP+QGjhwrmAIEWdJfICJWgFomOsPNhlddW
        MUHKDsv3aolpAU0kI7NHAK2pQg==
X-Google-Smtp-Source: AA0mqf6IJ9TfEi4fdZUSbZrZidog6WqIgbZlNXByL6goS1x+RR8fuxBhuZpaBoyABKyEvDf3soyJWA==
X-Received: by 2002:a05:622a:410a:b0:3a5:5987:42c6 with SMTP id cc10-20020a05622a410a00b003a5598742c6mr2154192qtb.147.1668691606159;
        Thu, 17 Nov 2022 05:26:46 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:bc4])
        by smtp.gmail.com with ESMTPSA id n1-20020a05620a294100b006fa617ac616sm447437qkp.49.2022.11.17.05.26.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 05:26:45 -0800 (PST)
Date:   Thu, 17 Nov 2022 08:27:09 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sean Christopherson <seanjc@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] proc/meminfo: fix spacing in SecPageTables
Message-ID: <Y3Y2rUaTPN6e2/EI@cmpxchg.org>
References: <20221117043247.133294-1-yosryahmed@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221117043247.133294-1-yosryahmed@google.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2022 at 04:32:47AM +0000, Yosry Ahmed wrote:
> SecPageTables has a tab after it instead of a space, this can break
> fragile parsers that depend on spaces after the stat names.
> 
> Fixes: ebc97a ("mm: add NR_SECONDARY_PAGETABLE to count secondary page table uses.")
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
