Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 960D374DF73
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 22:43:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232032AbjGJUn2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 16:43:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232096AbjGJUn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 16:43:26 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36C11E40
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 13:43:22 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-2632a72f289so2335606a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 13:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689021801; x=1691613801;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3/Kkq1v8telRaHQgV7zepQoTU75jRONxaU9eHXBvmDo=;
        b=WvjAwqQtJtaHexfOvhDpNwojVMD0FhJ7NN7QEpiDGCae1doh1Uea7+vY15bW2qnVcY
         2RB0RGTRLLQfc/zRwcQXcrwenuzrNED7/3drO5jsu2+mupbu+oQGapatwjZAVUePArzF
         4b5ZqWIS/61Bu4pwSpy1ex9kt2k0OmQMf4vaM7eEqX+2vavLf8T7eShszSiHDaYilSc9
         +JDevVG5yLsbmW/0YlrM8YfDj+y/cXjkdSQzmXnbbkf0qzZ4Fh3OGukXkbERsrCc/5KI
         +1huTClsojnW6oOiHrnI0hzdgYWgVGRmNCg3twFpjvpDdvqoDCavRaJUVyUwSHAY6NLw
         UJjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689021801; x=1691613801;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3/Kkq1v8telRaHQgV7zepQoTU75jRONxaU9eHXBvmDo=;
        b=F2pI8BBBeUWiYke+PvHqHyEApB0VU7OmcEzs0itKSLdK41UsYKwgPndmNnvK5TUBoB
         /64FHb/IBmLrZwdgZy5DEKSIwY8wIrEb5IZ027x7Rsl14IRfjdHoh7VKqwyCWa/wi1Hd
         z2tCZ0fDHcS0Zem7rFTuTGB9bPoTKmfiQ7GjxUdnyf1O8cmmanvJn7fcWlbgr8vUlL4b
         jkusC3cA8GO02efteFjjliHxeWFB1imFTttQkjDtRznkuG/ZaJCSEUuhPlJ531VpS6V5
         BXKvlxGRRkh21BEbtWOeM6HUV2p/Y7zsXjFYovU4M8GloQ7k9pcM+tTeSRXEQEBPOY1e
         z9kQ==
X-Gm-Message-State: ABy/qLacL12XkdaCPOipYEC0QtKjFpc/aVWnqGcMBUC57NvPcoM5HxA2
        /EdO06BtN5LSuZE7VWB2475HHYR3mt4ZSg==
X-Google-Smtp-Source: APBJJlHz7WUwBYrB720STPKVZk3YkBoazcrIVF9ccZd0GnTc+tu9XRBsQoMqwjVkXzdiuvxQODBmkg==
X-Received: by 2002:a17:90a:88b:b0:262:ff1c:bc37 with SMTP id v11-20020a17090a088b00b00262ff1cbc37mr10913252pjc.2.1689021800908;
        Mon, 10 Jul 2023 13:43:20 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:e2fe])
        by smtp.gmail.com with ESMTPSA id f12-20020a17090ac28c00b00262ff206931sm6678756pjt.42.2023.07.10.13.43.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 13:43:20 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 10 Jul 2023 10:43:19 -1000
From:   Tejun Heo <tj@kernel.org>
To:     rdunlap@infradead.org, frederic@kernel.org, jiangshanlai@gmail.com,
        linux-kernel@vger.kernel.org, zyhtheonly@gmail.com,
        zyhtheonly@yeah.net, zwp10758@gmail.com, fuyuanli@gmail.com
Subject: Re: [PATCH v5] workqueue: add cmdline parameter
 `workqueue.unbound_cpus` to further constrain wq_unbound_cpumask at boot
 time
Message-ID: <ZKxtZxH7c3L3f6c9@slm.duckdns.org>
References: <fd34114d-d2e4-0d10-475c-61585753a639@infradead.org>
 <20230629035050.GA17223@didi-ThinkCentre-M930t-N000>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230629035050.GA17223@didi-ThinkCentre-M930t-N000>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 29, 2023 at 11:50:50AM +0800, tiozhang wrote:
> Motivation of doing this is to better improve boot times for devices when
> we want to prevent our workqueue works from running on some specific CPUs,
> e,g, some CPUs are busy with interrupts.
> 
> Signed-off-by: tiozhang <tiozhang@didiglobal.com>

Applied to wq/for-6.6.

Thanks.

-- 
tejun
