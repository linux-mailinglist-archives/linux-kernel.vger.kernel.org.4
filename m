Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4180160D023
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 17:18:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233030AbiJYPRx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 11:17:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232694AbiJYPRu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 11:17:50 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2A62303D3;
        Tue, 25 Oct 2022 08:17:49 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id h9so10560370wrt.0;
        Tue, 25 Oct 2022 08:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZNYnzxUYxZx4XD4Lwaw+hJ+8re+ot06tXHAq9yK6z6I=;
        b=lLz0o4cAIskTwp7ABd3e6vyx5q9XxRcKxkusLDtvncdPEUydTQN6ylznML/3yB/0B6
         Y9gCW+xnxc00wI62CK2Id71kIm2nTL5yZ6A9kA4FnEBAnSCc+YMg/zWSLzBdSSwxqcbO
         Q2tBKIH/Q5WtjxR1VQVZ0eHNyECpX6rskKU9JCTZT3eWsAvwGobcfo8EFNJt5Uih/aue
         lWPYXHA6lKVRqJyFit/eNyzZqiib9/lf19QFCa61PAguWbmSrV6SWapCKMCjARNSzg89
         2E82SAv44NB+Irys2ei9Y6ka7JobgmEq+Vym3LLPyxclsI3iiYFhh9QZhsqc/ZSXWigz
         iLMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZNYnzxUYxZx4XD4Lwaw+hJ+8re+ot06tXHAq9yK6z6I=;
        b=z/vBgpzgtVISuEBdSYqYJgN0Y1hieZ4Tppqc6SQJFhNrUUPaFQMgyzgJ09cpNV6Na+
         oRVMcrkZYPKjSI5lFmSVVuEukRMI+YVl/dr0B9eULJYNDdUWMBswKpJQl1iCnQLnBNK3
         gO86RK6flLq5XX578lXD94HO5P7cUD7++URC6u/OJX4s1W/emCopBpOpqKTBXIEBGfzY
         StBYh49oSrYyX/bAnDBHBp/ssY0/M/LOi1kMDf9uotsU3Lkp0EYH3iW5/H8gkBq2VlxE
         A5W7ZWeEiBg11//nANNd+UxAXr/dEktqrApMQ47kedH7GGDgmjF/7k+9iroZ0RQQZYPh
         6Z9g==
X-Gm-Message-State: ACrzQf3GG5owX9Qjz9KtC4o3d7BVX3wnXso3ws0n8v5QFmWZXWljdPZJ
        LbU2vF0r22i0pufxYOnjLc4=
X-Google-Smtp-Source: AMsMyM4k+sL9ejhrgxIrUG2j+VYySP/clvgyL/EnFgkDZ96m1kQCxllzpWiqTW4fA086/Ds6KHJt9w==
X-Received: by 2002:adf:ba8f:0:b0:22c:def3:1179 with SMTP id p15-20020adfba8f000000b0022cdef31179mr26168784wrg.571.1666711068568;
        Tue, 25 Oct 2022 08:17:48 -0700 (PDT)
Received: from jernej-laptop.localnet (82-149-19-102.dynamic.telemach.net. [82.149.19.102])
        by smtp.gmail.com with ESMTPSA id f9-20020a5d5689000000b0022e3538d305sm3358017wrv.117.2022.10.25.08.17.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 08:17:48 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     mripard@kernel.org, paul.kocialkowski@bootlin.com,
        mchehab@kernel.org, gregkh@linuxfoundation.org, wens@csie.org,
        samuel@sholland.org, hverkuil-cisco@xs4all.nl,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/11] media: cedrus: Add helper for checking capabilities
Date:   Tue, 25 Oct 2022 17:17:47 +0200
Message-ID: <13124586.uLZWGnKmhe@jernej-laptop>
In-Reply-To: <Y1eChJS/0aEchtpH@kadam>
References: <20221024201515.34129-1-jernej.skrabec@gmail.com> <20221024201515.34129-5-jernej.skrabec@gmail.com> <Y1eChJS/0aEchtpH@kadam>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne torek, 25. oktober 2022 ob 08:30:28 CEST je Dan Carpenter napisal(a):
> On Mon, Oct 24, 2022 at 10:15:08PM +0200, Jernej Skrabec wrote:
> > There is several different Cedrus cores with varying capabilities, so
> > some operations like listing formats depends on checks if feature is
> > supported or not.
> > 
> > Currently check for capabilities is only in format enumeration helper,
> > but it will be used also elsewhere later. Let's convert this check to
> > helper and while at it, also simplify it. There is no need to check if
> > capability mask is zero, condition will still work properly.
> 
> Sure.  That's true.  Out of curiousity, can cedrus_formats[i].capabilities
> be zero?  Because it feels like that's what should be checked.

Yes, it can be. It's the case for V4L2_PIX_FMT_NV12_32L32. All variants 
supports it, so there is no special capability needed in order to be listed. 
What would you check in such case? Condition still works for this case.

Best regards,
Jernej




