Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09C536E5415
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 23:46:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbjDQVqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 17:46:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjDQVqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 17:46:05 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40072C3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 14:46:03 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id q2so32428673pll.7
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 14:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20221208.gappssmtp.com; s=20221208; t=1681767963; x=1684359963;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7FA8JojH6mUYVmoVOmw8jBgrQtRr/3uFKTWP6+VyILM=;
        b=hZSUsGdGy65n3HVucZAbz6xYzWNp4+kUsfz57WFm3em79Zt/mO/Mb7UuU/H9zXtkdg
         393tDSq165zIK/nePbEzWNcia4z5O74aNrMgKBXsF4XIQmlG8HT+ij+AZpQiRhYQRyoc
         EvbNaaK32/vwyu0xZSGXbdIvv4V2SHzdh1AV5Gmh6zru2h77VKQxuc9vRomjaO3kxNh/
         MCflsfHYxGaqBpQPQeD6c5n7CzKbBEt396qjaHKrAPdlzr0g8FgJ0L6deHiR7u5cqz1E
         wIe6f6iYdTQvpQvf5cIOjULWFvTzFIFD/ip+ImU70a04O0ru+vn6SjRMO5rvbLQdhCtf
         UQYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681767963; x=1684359963;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7FA8JojH6mUYVmoVOmw8jBgrQtRr/3uFKTWP6+VyILM=;
        b=e+YBVD+4kodZtJa+48idH7UirCR27g5C7h3+ESa97RGyAULLf+0SpfpfoHBNckevJ1
         acKugBGS4hHw5O8T6pvv73m5AocMQkoMc7iZ7nn3+ovMl5+FEOLivoWY49ud6Gqk0DTR
         JbRzeX2xpY5iSMyhpRjYqp0uUV7K4PbBPe6fQgsClvetgdLof+tgCTxoXk748Hn5OSIk
         RrxiGWO+SOxE2gQsNFap841N6H759e6MDFb99zV9zTTAKdB/0XZc+lqerYyo++weU++Y
         AT/Zs3QYQTAJ8rRt+297IW0mfzhLRGruEmXmk7rihtvH8DKYGlMVQnBk3FvgNXhTODOq
         hJJw==
X-Gm-Message-State: AAQBX9f4GOfROOf3KyvARJHFFktS7o6G549hnU8K6CVCNcnTmm+7/D5m
        g9AWk8WmgkMcMFawqeaDco1RCw==
X-Google-Smtp-Source: AKy350bLuhoWP60ZEZoStXgudRuZfiaJctd4+H3u7EotT3DD61bgp/3jKrLlSHjEIRvWJ9awv5dCbA==
X-Received: by 2002:a17:903:42cc:b0:1a6:9363:1632 with SMTP id jy12-20020a17090342cc00b001a693631632mr308413plb.25.1681767962764;
        Mon, 17 Apr 2023 14:46:02 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-41-174.pa.nsw.optusnet.com.au. [49.180.41.174])
        by smtp.gmail.com with ESMTPSA id v10-20020a1709028d8a00b001a6ce2bcb3esm3096282plo.161.2023.04.17.14.46.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 14:46:02 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1poWff-004cZl-Ld; Tue, 18 Apr 2023 07:45:59 +1000
Date:   Tue, 18 Apr 2023 07:45:59 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     ye.xingchen@zte.com.cn
Cc:     djwong@kernel.org, dchinner@redhat.com, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] xfs: scrub: remove duplicate include headers
Message-ID: <20230417214559.GR3223426@dread.disaster.area>
References: <202304171613075788124@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202304171613075788124@zte.com.cn>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 17, 2023 at 04:13:07PM +0800, ye.xingchen@zte.com.cn wrote:
> From: Ye Xingchen <ye.xingchen@zte.com.cn>
> 
> xfs_trans_resv.h and xfs_mount.h are included more than once.
> 
> Signed-off-by: Ye Xingchen <ye.xingchen@zte.com.cn>

Yes they are, but it's already been fixed:

https://lore.kernel.org/linux-xfs/20230415224532.604844-1-david@fromorbit.com/

-Dave.
-- 
Dave Chinner
david@fromorbit.com
