Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C061F740CEA
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 11:31:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233771AbjF1J3v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 05:29:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231665AbjF1H4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 03:56:13 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39BED30F6
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 00:55:32 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id 46e09a7af769-6b73b839025so3177948a34.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 00:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687938931; x=1690530931;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kl6zRFJwJX4TVX+FX/9X3H88Ay6pIJMzZMs21mv/0NU=;
        b=iMGOC55B5TuwgnR0v4ok2zHDywa5XSYRfkgwD+tOItlxgD+o7Ujk3a2/I51UH0CApf
         W9l75bcMGlz1BFFwVxW1+/jDWwtGDWo35h1LRP32v/EOYwdQTlL+2ddr6YsTlNCK2/9/
         QjmWskclSCjQxPg70zFWRwkj7G4CfNCmFoDCFc20KEVKgVNGUHrkCBZOVwBhEXiVx8zk
         31SaNpbyRhgUr20eldNGDrBuUuxUI7P2s6jOqcfADKB+xgyc0ZSZHMQXtcoVBSxcx2Zi
         WQTWaKfTpuCfW/+0URiQPMJCcx+XqPXENNgZzXSuOlKxA+E1ogPWNSMvIKTvqtlYFYW/
         f6eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687938931; x=1690530931;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kl6zRFJwJX4TVX+FX/9X3H88Ay6pIJMzZMs21mv/0NU=;
        b=MtBSwpHopSwmOQy4sxpQAbK8fi1oq9opTqnPjYjbvUYb1kcwSJ70YHi1Gb482q06Z3
         FhDjXpNrc17sRj44RVxBuNn3/Wb9/3xWS6cYfc/ATys7rKfSFo8hssyHmpP5hUt3fqUR
         A6zoQKDBxCT3KD+DKrbHah6nedXP5j9G/UdeJZwoeWox0aSx6XtC53FQA7GPUAMlJrpo
         EA6c+qL+dgsWmETtp1yfclqurTRzSWWA8Y9U1PfGPWw6EbUwP+BukrTdWZg/1DuTAzY1
         oAxzORUOEjzVgh0qK3TA5cwE1U3bZ1987lyh+DbvAugJsDN6gDdSlpSry4J4PTS+QulN
         1Xcw==
X-Gm-Message-State: AC+VfDxn23MkwWgFKLQM1W6FakDZ+v9CzGtoj/8E7MOnV5kq/mytSaEo
        4cj0PLu39w3HauKsvPE60NAteFiG4N0=
X-Google-Smtp-Source: ACHHUZ6JRGIUhgEO5FJSQSbiiil8v67RVs0NzWdjFNveJ+SE3EwyVqvk0R0XDfh2xtMRMHlWi+ekJA==
X-Received: by 2002:a05:6a20:7da1:b0:123:9582:e9fb with SMTP id v33-20020a056a207da100b001239582e9fbmr18239344pzj.50.1687938538548;
        Wed, 28 Jun 2023 00:48:58 -0700 (PDT)
Received: from localhost ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id w5-20020a170902d3c500b001b1a2bf5277sm914932plb.39.2023.06.28.00.48.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Jun 2023 00:48:58 -0700 (PDT)
Date:   Wed, 28 Jun 2023 15:57:42 +0800
From:   Yue Hu <zbestahu@gmail.com>
To:     Gao Xiang <hsiangkao@linux.alibaba.com>
Cc:     linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
        huyue2@coolpad.com
Subject: Re: [PATCH 1/2] erofs: get rid of the remaining kmap_atomic()
Message-ID: <20230628155742.0000038e.zbestahu@gmail.com>
In-Reply-To: <20230627161240.331-1-hsiangkao@linux.alibaba.com>
References: <20230627161240.331-1-hsiangkao@linux.alibaba.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Jun 2023 00:12:39 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> It's unnecessary to use kmap_atomic() compared with kmap_local_page().
> In addition, kmap_atomic() is deprecated now.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Yue Hu <huyue2@coolpad.com>
