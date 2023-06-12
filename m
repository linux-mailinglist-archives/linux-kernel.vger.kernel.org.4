Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3D1E72CA6E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 17:40:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238583AbjFLPkN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 11:40:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239889AbjFLPkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 11:40:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78E2510CB
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 08:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686584366;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Vx3QrjDiS3q1uRFp57xdfeuJGw++/PjrXkp4nmKcYFE=;
        b=IofFZVNMY2Y/Fk+AxHF9JSUe8x/+f8P1DAhxFnUnhv1FZf2ah1rR5KToaq1Q/p1y6NnWrU
        YpShH/kLD8z4PFDYs58E9qDLD3tdLtzcAIqusBTTltmWjjUyKR3Yd5eYlPHqTaTecD2MOh
        i5CTy627hQAW2J9eQeNZKjJIAOJgfGU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-yZcOzuQtOFedDvqGyj-jkg-1; Mon, 12 Jun 2023 11:39:25 -0400
X-MC-Unique: yZcOzuQtOFedDvqGyj-jkg-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-30fbb0ac191so667279f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 08:39:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686584364; x=1689176364;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vx3QrjDiS3q1uRFp57xdfeuJGw++/PjrXkp4nmKcYFE=;
        b=hZdLD4dgNbwrYKsoRJGaozABgeoJlTQ0Q4btO0Zdp4KFaDk/KnMXwmuB0wInmjm27q
         l9zc1EpijzCIv4vthpTyQ6nPDdzC+PtDw4nnlkExj77h1Z1hsQniqhCV8bYJNGOHYe11
         fO7rX6YctDpuKRnISlr0dJuh2H/z4Xq/4kjifxqbWOoz9E0UR6eaUr+rCT4wFFaY1zaY
         ZYpuF0JLVfQQjjKuD7o4heZ/rQrimT7ln4o3tiESfQMnaIPaQiQjgNunJeuNNu28yI5B
         mGz9bw+mg2nmH70rK9oIgZrzawMR2vHZvM4kNYFHUBiJFAKbeiS8B36SchPZMiY1hrXF
         PHBA==
X-Gm-Message-State: AC+VfDyHRpgrLvjZy8sGUWpxEP0bA8eZXbvJ6lAdvU/GuJaJOJd2UV6Z
        N4cxQw/v7jSaL1o18D0z5KS/Nxr88FdF7aG2YJMJ8WUB2C+w/xuSKAxTXL+uDMmTR2+qIYlf/lP
        r9nXB+ByT3HujqhjtYMZoKQJ6
X-Received: by 2002:a05:600c:3508:b0:3f8:651:4b37 with SMTP id h8-20020a05600c350800b003f806514b37mr7869190wmq.2.1686584364252;
        Mon, 12 Jun 2023 08:39:24 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ53Wrs84u/2VPso1N0vhhWAkng5z+KqvyI34AFM56hd1Jp6q84aAeWnUPMfjcrt5J/ZmjH/QQ==
X-Received: by 2002:a05:600c:3508:b0:3f8:651:4b37 with SMTP id h8-20020a05600c350800b003f806514b37mr7869174wmq.2.1686584363957;
        Mon, 12 Jun 2023 08:39:23 -0700 (PDT)
Received: from vschneid.remote.csb ([154.57.232.159])
        by smtp.gmail.com with ESMTPSA id 17-20020a05600c22d100b003f8044b3436sm11373951wmg.23.2023.06.12.08.39.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 08:39:23 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Miaohe Lin <linmiaohe@huawei.com>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org
Cc:     dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, linux-kernel@vger.kernel.org,
        linmiaohe@huawei.com
Subject: Re: [PATCH] sched/topology: mark set_sched_topology() __init
In-Reply-To: <20230603073645.1173332-1-linmiaohe@huawei.com>
References: <20230603073645.1173332-1-linmiaohe@huawei.com>
Date:   Mon, 12 Jun 2023 16:39:22 +0100
Message-ID: <xhsmhlegoy9jp.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/06/23 15:36, Miaohe Lin wrote:
> All callers of set_sched_topology() are within __init section. Mark
> it __init too.
>
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Reviewed-by: Valentin Schneider <vschneid@redhat.com>

