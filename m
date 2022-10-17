Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8502660173C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 21:20:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230367AbiJQTUD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 15:20:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230339AbiJQTTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 15:19:50 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED8DB1EAF3;
        Mon, 17 Oct 2022 12:19:47 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id pq16so11866170pjb.2;
        Mon, 17 Oct 2022 12:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GuVE9fVTM4eodOC6sJzSFmeJV1Sl1qeoc+ZDwqd1NBE=;
        b=BCGp6HTFj0dBO16cFsAUMbAwB2kXgReySlKd4UqcPoEtEkQ+5o6yMLwSSFX5WtOhyi
         Xtc+Av44Tqb1YzvKSoUzktfSJg9VIeW1eyqVkC7+UrvOiNsWN6dpYgh7py6iuerj0wqa
         pbAih0x388OQVu3PthnVkvKnK+4+GxnecWIZTS2QdWvLe48MrIk/dTmZn29tZf6s8rig
         zoy+hWeCUXeH4+MC8skFIDdrJ02hZf0DfnB4tHdXCC7wmVRIY9lIRycagcni+4s1mBlR
         04dgT4vKkejZu/Bb0N/W8nWEIxFvu2RawXWqhN0dXVlKKWsYHYSQIxLRP+LI3tok0eYT
         27AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GuVE9fVTM4eodOC6sJzSFmeJV1Sl1qeoc+ZDwqd1NBE=;
        b=cFbVOaMKaVD5ye44aHLPqF0o4TchdneB8t1UoAgi7TLawxj1KORvWLSM6IwnQl5YI8
         9uWcrDfBiyVOWbN7B4xGccJTZ7CiIg15cPzQJPQQiml9LR3CVZes4snsleKXlfdALpif
         pZS1UvYzri3PE1relv6vcz322aoJ3+jGge1Kai2wh972D0NbX5PsoVQo9eKr2c9ODxFm
         exqWayY8SqxJBbl95PaCN4rYciNAG93D6EwNJLt5VbJ9QNREVouFzQEMpYd8y+jZx+gr
         QlVE8ccs0b/70mmQ58WF5Xlu2CCEL7/d7XfrfZ4iMbg4KkQPypnlJB4Oik778qayGUk4
         WJhA==
X-Gm-Message-State: ACrzQf37oCAGoHWu5dQ17gMDvuaOR40J+LArwGzwf3fJNDf2YjiH6pm5
        Cvv8eFf1mFhxq5wV3DW1x9Jv3juJF4FVPw==
X-Google-Smtp-Source: AMsMyM7073GR1pbP1Mtfl3zE7AM9vl9nzjP4ozn+3Jbt9DBHDexqdbpwPazCugEpdYW9o3rrMXDTXg==
X-Received: by 2002:a17:902:9308:b0:182:b2ba:755 with SMTP id bc8-20020a170902930800b00182b2ba0755mr13479172plb.107.1666034387177;
        Mon, 17 Oct 2022 12:19:47 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id t2-20020a170902e1c200b001807922f43bsm6927713pla.158.2022.10.17.12.19.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 12:19:46 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 17 Oct 2022 09:19:45 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Kemeng Shi <shikemeng@huawei.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 8/8] blk-iocost: Get ioc_now inside weight_updated
Message-ID: <Y02q0Us+WZmQU3zO@slm.duckdns.org>
References: <20221017020011.25016-1-shikemeng@huawei.com>
 <20221017020011.25016-9-shikemeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221017020011.25016-9-shikemeng@huawei.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 17, 2022 at 10:00:11AM +0800, Kemeng Shi wrote:
> The ioc_now parameter of weight_updated is only needed if we need call
> propagate_weights. Move ioc_now inside weight_updated to remove
> unnecessary get of ioc_now from outside of weight_updated.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huawei.com>

Ditto. I don't think this improves anything meaningful.

Thanks.

-- 
tejun
