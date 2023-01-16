Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FD6666B5A7
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 03:42:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231658AbjAPCmP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 21:42:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231779AbjAPCmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 21:42:08 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20A7F728A
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 18:42:08 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id y1so28936682plb.2
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 18:42:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HzasTk/Ro7CO00la7hcoLrNg4yRWZdF8WTiKUq6bM2k=;
        b=gsgZmqMmSWpWo4TZWVpQ7aNVLgCxuLy/SkYvwEYhUIvKED2TfSsQh+9uJCE6BOVSZy
         zpd4A4GAXOBgZ1X5IdCugq6WxRy+o/STLIvHvZSYGfy8sUaB8fkYekWRiBHK1D44np3/
         J5wlCPXHv0iaTl0t2q5Ugojxm9f/4s7ckBGyxGW7jQ1v0dyj/FEpIfTayxOl5h3JofeY
         zrjJPkjJANMikWmeuzHy905F15uYA++3phaWo5IAcOssKwfyslkxficFC3DCZQTVX6hN
         2gAlgUt+ZIobE9Q7U1rjTH7E0Jon3zulUVdU90gR0MZgecfocWZatA3kmfOl3IlpXISD
         SMdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HzasTk/Ro7CO00la7hcoLrNg4yRWZdF8WTiKUq6bM2k=;
        b=6ppM8N32FN7/zjq6Ak8tKdSzd2TysehwaXf8PBEy/45Rm8DhyQFUw60bqZ/Mz6Y/Zc
         ZocEX3sWanmWsYAcws1gFxrGVnrm/atZrDOZz3Cvz4ZPWZ+CCal7AzbAPP+0aW3oqhHH
         Gm1jvdC6WdzXVCiTVLE0rvcz+udtw9zwu1KvZdqnEsvK5dhT/cTNBwQv/hu/m/aVQNy1
         2LNCpdalAxtyw+yblT8Xad0v2HE6N0WAQmUUzkrnOB6x5Pw1UDCGMU0+mzPQSJRKBXSW
         2kj0H2Rhs+9U6hwj0nxmxYWNQ3tkUVrf0AB/TJhDp8ZobjxxmyhV3c9un3mZEV7U3ob9
         RloA==
X-Gm-Message-State: AFqh2krvnqpKUA45lVoh6U094Yw+e7HuLdtjhE9qNspS99l1eVVatu8k
        24siv0iM4tmynIy8THNGsyo=
X-Google-Smtp-Source: AMrXdXuKjanSCUOEr1Oui8au3I3YJcM2uFAcKpKAJErY3jfUtwiZYKOQLotkiJnAgNR30bW5ip3bhg==
X-Received: by 2002:a17:902:9b97:b0:193:b58:2b0c with SMTP id y23-20020a1709029b9700b001930b582b0cmr29244471plp.23.1673836927675;
        Sun, 15 Jan 2023 18:42:07 -0800 (PST)
Received: from localhost ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id cp5-20020a170902e78500b00177e5d83d3esm18051232plb.88.2023.01.15.18.42.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 15 Jan 2023 18:42:07 -0800 (PST)
Date:   Mon, 16 Jan 2023 10:47:22 +0800
From:   Yue Hu <zbestahu@gmail.com>
To:     Gao Xiang <xiang@kernel.org>
Cc:     linux-erofs@lists.ozlabs.org, Chao Yu <chao@kernel.org>,
        Jingbo Xu <jefflexu@linux.alibaba.com>,
        Gao Xiang <hsiangkao@linux.alibaba.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] erofs: get rid of debug_one_dentry()
Message-ID: <20230116104722.0000405d.zbestahu@gmail.com>
In-Reply-To: <20230114125746.399253-1-xiang@kernel.org>
References: <20230114125746.399253-1-xiang@kernel.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 14 Jan 2023 20:57:45 +0800
Gao Xiang <xiang@kernel.org> wrote:

> From: Gao Xiang <hsiangkao@linux.alibaba.com>
> 
> Since erofsdump is available, no need to keep this debugging
> functionality at all.
> 
> Also drop a useless comment since it's the VFS behavior.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Yue Hu <huyue2@coolpad.com>

