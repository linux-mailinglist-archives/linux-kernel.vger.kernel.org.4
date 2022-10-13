Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C4735FE238
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 20:57:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbiJMS50 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 14:57:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbiJMS4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 14:56:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAFCA2DF0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 11:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665687243;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=8pkajZPOZxDkGw1RxC1xTCn1Bly76di5EaF0TtIpiUE=;
        b=ZrIZrt/cok8LxprCcBtg2yGW2vtd8KXrDoVzqe2XxfBZSaQRIAlIn5aHkyrfkm6obTjMKH
        Gl6xoqdoOsR0sRfb+uwVlahRghc4UXcIBobJWansWEL42thTIDO/pWhD8f1H38bw8EdIWA
        9+O5xYZxAhdTmEWqL0Vlu/m5u5GvehQ=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-193-uIv25s3KPhiYRpgz8R5BLA-1; Thu, 13 Oct 2022 14:40:50 -0400
X-MC-Unique: uIv25s3KPhiYRpgz8R5BLA-1
Received: by mail-oo1-f72.google.com with SMTP id n27-20020a4a611b000000b0048067b2a6f7so1269031ooc.6
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 11:40:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8pkajZPOZxDkGw1RxC1xTCn1Bly76di5EaF0TtIpiUE=;
        b=g0DpTnl/tKLICrfWXmth1HZUGSUGB0WazRwwPhr7R9rCD8IL+vNupK5vhqBUcus8M8
         KcEnPSloB5UxYrWolFbvDmPyrEBf8T7rZEkzpbxpnrSYOtlJjS4lVG5EhTDXMY0im5h7
         mAIpD1Ive/Aau1+vPdjCFxOIXuk1LIr4AY1MbQbE1xouuUvjfA6TgoxtXP4iGCYvvIQi
         gQK7uwSgRkHMRHSo4jRpXTrAbEVcLAJsyXot4HYHIsiU4o9xZiFVRV095sBQC2xt1Ie/
         gVthc7ATfFNo/TgisVnbIEgwYoU4KYho4JMTIZDPwCCAWQGd8gxUUFTNWNMK/KG5GlW9
         342A==
X-Gm-Message-State: ACrzQf043gZ95a3CCVYR5w64qzUaOFfy43ikheGsxGPyTybl3/8Y2DJt
        BqQkb9aDPgN3dFAqRHg7uxXszpvfkb7pD1+FVVsZWMSJkBrha4JL1P7vN7r6sBk5SXiiZxswxxs
        Jx5Ls5Z4/Zy1rssBl9yvVgHMi
X-Received: by 2002:a05:6830:2647:b0:659:edd8:3fcd with SMTP id f7-20020a056830264700b00659edd83fcdmr681876otu.344.1665686449485;
        Thu, 13 Oct 2022 11:40:49 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5zsqe12qXgtGqOG3X4aAkxg5HN1AkA2/2fmrv6WsfdypDLxNxz0oYk6/aTlQR85OUwZLjPpA==
X-Received: by 2002:a05:6830:2647:b0:659:edd8:3fcd with SMTP id f7-20020a056830264700b00659edd83fcdmr681866otu.344.1665686449258;
        Thu, 13 Oct 2022 11:40:49 -0700 (PDT)
Received: from localhost.localdomain ([2804:1b3:a801:9473:d360:c737:7c9c:d52b])
        by smtp.gmail.com with ESMTPSA id v13-20020a05683024ad00b006618ad77a63sm244521ots.74.2022.10.13.11.40.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 11:40:48 -0700 (PDT)
From:   Leonardo Bras <leobras@redhat.com>
To:     Steffen Klassert <steffen.klassert@secunet.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Leonardo Bras <leobras@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Phil Auld <pauld@redhat.com>,
        Antoine Tenart <atenart@kernel.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Wang Yufen <wangyufen@huawei.com>, mtosatti@redhat.com
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH v2 0/4] CPU isolation improvements
Date:   Thu, 13 Oct 2022 15:40:25 -0300
Message-Id: <20221013184028.129486-1-leobras@redhat.com>
X-Mailer: git-send-email 2.38.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch 1 removes some noise from isolation.c

Patch 2 adds some information about the housekeeping flags and a short
description on what to expect from the HK functions. I would really like 
some feedback on this one, since I got all that from the flags usage, and 
maybe I am misreading stuff.

In patch 3, I am suggesting making isolcpus have both the _DOMAIN flag and 
the _WQ flag, so the _DOMAIN flag is not responsible for isolating cpus on 
workqueue operations anymore. This will avoid AND'ing both those bitmaps 
every time we need to check for Workqueue isolation, simplifying code and 
avoiding cpumask allocation in most cases. 

Maybe I am missing something in this move, so please provide feedback.

In patch 4 I use the results from patch 3 and I disallow pcrypt to schedule 
work in cpus that are not enabled for workqueue housekeeping, meaning there 
will be less work done in those isolated cpus.

Best regards,
Leo

Leonardo Bras (4):
  sched/isolation: Fix style issues reported by checkpatch
  sched/isolation: Improve documentation
  sched/isolation: Add HK_TYPE_WQ to isolcpus=domain
  crypto/pcrypt: Do not use isolated CPUs for callback

 crypto/pcrypt.c                 |  9 +++++---
 drivers/pci/pci-driver.c        | 13 +----------
 include/linux/sched/isolation.h | 38 ++++++++++++++++++++-------------
 kernel/sched/isolation.c        |  4 ++--
 kernel/workqueue.c              |  1 -
 net/core/net-sysfs.c            |  1 -
 6 files changed, 32 insertions(+), 34 deletions(-)

-- 
2.38.0

