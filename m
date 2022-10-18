Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2174760333D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 21:18:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbiJRTSl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 15:18:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiJRTSj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 15:18:39 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 859C15AC6B
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 12:18:38 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id v11so1435511wmd.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 12:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RjbO23Kmf5BvgFjN1z1uqLCDsbhW7avPARU1Jkeq+U8=;
        b=UXY+7vEzyyIUoZX8qENreyalPp7Pp825/HqaRmLaEqpWo5oNCBaiF0clpYwqRJbSZI
         k/TLs9qHgGX4qNPPusnZLHw4DJ/Dbw/+328xIOxXuHtiB/hgoK2x2V3XyVKfZA3euQEn
         wHYqk5agUu/WYCqKgThBUNTcg6+wZ++PbaX3QU+rn/FW7ht8pheHqE5phRJ/dDkXXwnv
         v3jbSRU/B6Crab0IZYlwwQoTFO+ZSt8jdtbhK6c9caBo9ilnoNEPawfaJBfE/SQinFjz
         0hl3K+M/EAqr/oOJQjgMoWHPHCgmARNzjE48bvIogdHB9p0/CRg0rOXIQAcycMOVilEz
         oC3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RjbO23Kmf5BvgFjN1z1uqLCDsbhW7avPARU1Jkeq+U8=;
        b=UXeVaJADF2CzqiY7X/yCmPPw6kO8ZJF16EtVhflR1eyr9XcjxrRzSoXufm78OJoSDL
         nwormkyBcWbdg5F97syag/Gi3Myv68JFvUsJ/rxUmpDzLyip4p77UW5qOs3lnoSgw+08
         Mcs+rh52Ck352EW0z31KNNRQptA4gKPiUdYZmLkPv/mlPGfw6eoJHV3JuCFTQrbF+KTV
         Y3mvWJEXNKqghyhQY7JBWR8CxPZ9GjwYVQz3sP5qkmebCIS4q3YBpktIZsz9+KMWyUIv
         473NaegiGRMOykcJeCnLiw0MBNLv7FpeNZ0CSXMu8ja1xSeVhlpLW+IvXc9/blJZ+6uq
         mNfg==
X-Gm-Message-State: ACrzQf3tCfXtZk2ywQK20D8+1ch8/5I8Oc+NbMqLbSPbEb7DfamOqtUH
        DskUO3WdA3GxQ2xQjGy2yzc=
X-Google-Smtp-Source: AMsMyM6LhEUEwAFsNy/Sd6G0ILdt2v+yd4rHRoFcgt61bvHIHmyHdNCg5dxP5r8XFEEEQ+zER6NUNw==
X-Received: by 2002:a05:600c:1d17:b0:3c5:d7ca:190c with SMTP id l23-20020a05600c1d1700b003c5d7ca190cmr3095244wms.137.1666120716649;
        Tue, 18 Oct 2022 12:18:36 -0700 (PDT)
Received: from mypc.localnet (host-82-59-43-249.retail.telecomitalia.it. [82.59.43.249])
        by smtp.gmail.com with ESMTPSA id m7-20020a5d6247000000b0022c906ffedasm11937506wrv.70.2022.10.18.12.18.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 12:18:35 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Gao Xiang <hsiangkao@linux.alibaba.com>
Cc:     linux-erofs@lists.ozlabs.org, Chao Yu <chao@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, ira.weiny@intel.com
Subject: Re: [PATCH v2] erofs: use kmap_local_page() only for erofs_bread()
Date:   Tue, 18 Oct 2022 21:18:49 +0200
Message-ID: <9108233.CDJkKcVGEf@mypc>
In-Reply-To: <20221018105313.4940-1-hsiangkao@linux.alibaba.com>
References: <20221018105313.4940-1-hsiangkao@linux.alibaba.com>
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

On Tuesday, October 18, 2022 12:53:13 PM CEST Gao Xiang wrote:
> Convert all mapped erofs_bread() users to use kmap_local_page()
> instead of kmap() or kmap_atomic().
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
>  fs/erofs/data.c     | 8 ++------
>  fs/erofs/internal.h | 3 +--
>  fs/erofs/xattr.c    | 8 ++++----
>  fs/erofs/zmap.c     | 4 ++--
>  4 files changed, 9 insertions(+), 14 deletions(-)
> 

I just realized that you know the code of fs/erofs very well. I saw a Gao 
Xiang in MAINTAINERS, although having a different email address.

Therefore, I'm sure that everybody can trust that you checked everything is 
needed to assure the safety of the conversions.

However, an extended commit message would have prevented me to send you the 
previous email with all those questions / objections.

Thanks,

Fabio


