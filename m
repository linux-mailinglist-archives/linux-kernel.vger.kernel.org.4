Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 190AC6BD87E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 20:01:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbjCPTBv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 15:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbjCPTBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 15:01:46 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FEB3E20F5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 12:01:45 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id j6so1544923ilr.7
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 12:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1678993305; x=1681585305;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dr0JenSZTfgvBDt5ctYqmIxEaiHBoB1L+lvdc14PxbY=;
        b=MszB2l6uewYnYB3bGQR6Var1AkaWqVhjrkkcWL6rM2OFCuLjRck4SX01SS3EEmNTOt
         byhJ7zAtLOOgsRblJIVQbqJNstY7LEp2EiVsVLPtbjv+h6dLd8zurljNUHH+Nz+FvJLB
         kj55yvHNA674x53Ol40bMGPt/Av7Wn4mIqKsCyQ8mWDZTPt5Rtbjs58atYrsfgMICgGP
         5lBkM6J6niVpFe87vYNFmNtHJOpA0gtu+Hvy8eGM6uslMvOYIwp2NgqVRk3D0Icjq/qu
         K53Y9Lcj1fGRjWTrtKmawrhTjIooo5oVOt2+iyXqOmQ9ASbeQKBHP9Urq2Muq5AGMkBM
         hj5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678993305; x=1681585305;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dr0JenSZTfgvBDt5ctYqmIxEaiHBoB1L+lvdc14PxbY=;
        b=PPIaYOj3rUTfvRn7eren4CEWKI0SOn/CsmmMg8M2kADa0h1vyn8VSSYYI7I3w4zpN/
         uIDwU7sY8K1vqoqzbmPtw/3mMjxo9WvvJjXbXa940pmY/oUCC1CKWUSLiQ7gM26LtBRQ
         4IBNqW6vQkPxzjzKTJE6Rtr+f4VTxJsI5+CMsksN5fBZsIrv1wGgC41a2CP5VXFSrXFu
         mjJX3qfrMchb7kyNHnvXD2xwBrQJtz+txpkHxr3T+mMgdl0vOFOx2Ge7Sf+No0UIlKOc
         el6sTSihxCjpK/I7/wHab+fSghQOM3aF+LAg2E7bMpSww7o8DMWvrYS4D/EvO+GMEBZm
         QDNQ==
X-Gm-Message-State: AO0yUKUV95JSNM7FyKovA12sPmDKq3UjAiOsHRlrOKAdLqBNvhfUOqZS
        o8OaQVPqdKzA3k7hQkaZWbX3aQ==
X-Google-Smtp-Source: AK7set+ww9TnAgxPUQjcYjCw4hqV863M7VN4ZqZy09GZ2y4iLJ+p2cy+vYhxEmACwDzyl7QQzw8h8Q==
X-Received: by 2002:a05:6e02:dd3:b0:317:2f8d:528f with SMTP id l19-20020a056e020dd300b003172f8d528fmr2084878ilj.2.1678993304850;
        Thu, 16 Mar 2023 12:01:44 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 71-20020a020a4a000000b004040f9898ebsm6279jaw.148.2023.03.16.12.01.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 12:01:44 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     asml.silence@gmail.com, io-uring@vger.kernel.org,
        Breno Leitao <leitao@debian.org>
Cc:     linux-kernel@vger.kernel.org, gustavold@meta.com, leit@meta.com,
        kasan-dev@googlegroups.com
In-Reply-To: <20230223164353.2839177-1-leitao@debian.org>
References: <20230223164353.2839177-1-leitao@debian.org>
Subject: Re: [PATCH v3 0/2] io_uring: Add KASAN support for alloc caches
Message-Id: <167899330412.128512.9758823252493186358.b4-ty@kernel.dk>
Date:   Thu, 16 Mar 2023 13:01:44 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-2eb1a
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 23 Feb 2023 08:43:51 -0800, Breno Leitao wrote:
> This patchset enables KASAN for alloc cache buffers. These buffers are
> used by apoll and netmsg code path. These buffers will now be poisoned
> when not used, so, if randomly touched, a KASAN warning will pop up.
> 
> This patchset moves the alloc_cache from using double linked list to single
> linked list, so, we do not need to touch the poisoned node when adding
> or deleting a sibling node.
> 
> [...]

Applied, thanks!

[1/2] io_uring: Move from hlist to io_wq_work_node
      commit: 80d5ea4e019d5ac0257c9bf06a7bcf30c9500adc
[2/2] io_uring: Add KASAN support for alloc_caches
      commit: 80d5ea4e019d5ac0257c9bf06a7bcf30c9500adc

Best regards,
-- 
Jens Axboe



